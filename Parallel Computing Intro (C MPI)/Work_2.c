
#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>

// Για το ερωτημα (δ), struct που κραταει τιμη και index. 
struct float_int{
    float num;
    int ind;
};

void input(int *arrSize, int **X, float **D, int **globPreSums);
void calcLocalSizes(int n, int **counts, int **displs);
void distrX(int root, int *counts, int *displs, int *localN, int *ind0, int **localX, float **localD, int *globX, int *globN);
void avg_min_max(int root, int globN, int locN, int *locX, float *avg, int *min, int *max);

void avg_less_more(int root, int locN, int *locX, float avg, int *less, int *more);
void varElements(int root, int globN, int locN, int *locX, float avg, float *var);
void calcArrD(int root, int max, int min, int locN, int *locX, float *locD, float *D, int *counts, int *displs);
void calcMaxD(int root, int globInd, int locN, float *locD, struct float_int *globMaxD);
void calcPreSums(int root, int *locX, int *globPreSums);

void printResults(int p, int N, int min, int max, float avg, int less_avg, int more_avg, float var, float *D, int *X, struct float_int maxD, int *globPreSums, char *rep);


int main(int argc, char** argv){

    char repeat = '0'; // Για επαναληψη

    int rank, size, root;
    int *counts, *displs; // Counts = localN καθε p, displs = globIndex0 καθε p. Τα εχει μονο ο root.
    int N, *X; // Ο Ν(μεγεθος Χ) δίνεται σε ολα τα p, ο Χ μονο στον root
    int localN, *localX; // Για καθε p, τα υποδιανυσματα του Χ
    int globIndex0; // Για καθε p κραταει την πρωτη θεση στον Χ

    // Η ελαχιστη, μεγιστη και μεση τιμη του Χ,
    // δινονται σε ολα τα p
    int minX, maxX;
    float avgX;

    int less_avg, more_avg; // Για το ερωτημα (α)
    float var; // Για το ερωτημα (β)
    float *D, *localD; // Για το ερωτημα (γ).  Ο D μονο για τον root, ο localD για καθε p.
    struct float_int maxD; // Για το ερωτημα (δ)
    int *globPreSums; // Για το ερωτημα (ε)


    MPI_Init(&argc, &argv);

    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    do{

        root = 0;

        // Ο root παίρνει τα inputs απο τον χρηστη, και 
        // υπολογιζει τα μεγεθη των localX πινακων.
        if(rank == root){
            input(&N, &X, &D, &globPreSums);
            calcLocalSizes(N, &counts, &displs);
        }

        // Διαμοιραζει τα localN μεγεθη και τα στοιχεια του Χ.
        distrX(root, counts, displs, &localN, &globIndex0, &localX, &localD, X, &N);

        // Υπολογιζει τα avg, min, max και τα διαμοιραζει.
        avg_min_max(root, N, localN, localX, &avgX, &minX, &maxX);

        // Ερωτημα (α). 
        avg_less_more(root, localN, localX, avgX, &less_avg, &more_avg);
        
        // Ερωτημα (β).
        varElements(root, N, localN, localX, avgX, &var);

        // Ερωτημα (γ).
        calcArrD(root, maxX, minX, localN, localX, localD, D, counts, displs);

        // Ερωτημα (δ).
        calcMaxD(root, localN, globIndex0, localD, &maxD);

        // Ερωτημα (ε).
        if(N == size)
            calcPreSums(root, localX, globPreSums);

        // Εκτυπωση αποτελεσματων
        if(rank == root)
            printResults(size, N, minX, maxX, avgX, less_avg, more_avg, var, D, X, maxD, globPreSums, &repeat);
        // Στελνουμε σε ολα τα p αν θελουμε επαναληψη
        MPI_Bcast(&repeat, 1, MPI_CHAR, root, MPI_COMM_WORLD);

        // Αποδεσμευση μνημης.
        free(localX);
        free(localD);
        if(rank == root){
            free(counts);
            free(displs);
            free(X);
            free(D);
            free(globPreSums);
        }

    }while(repeat != '0');


    MPI_Finalize();

}





/*
    Ζητάει απο χρήστη μέγεθος Ν του πίνακα X,
    κάνει malloc τον X και τον D και ζητάει κάθε στοιχείο του X.
*/
void input(int *arrSize, int **X, float **D, int **globPreSums){
    
    int p;
    MPI_Comm_size(MPI_COMM_WORLD, &p);
    
    printf("\n-|-|-|-|-|-|-|LOOP START|-|-|-|-|-|-|-\n");
    // Δεχεται μονο N >= των επεξεργαστων
    do{
        printf("\n------------------------------\n");
        printf("Give array size N (>= p) of vector X. (p = %d)\n", p);    
        printf("Input N: ");
        scanf("%d", arrSize);
    }while((*arrSize) < p);

    // Ο root δεσμευει μνημη για τους "global" πινακες X, D και globPreSums.
    (*X) = (int *) malloc((*arrSize) * sizeof(int));
    (*D) = (float *) malloc((*arrSize) * sizeof(float));
    (*globPreSums) = (int *) malloc((*arrSize) * sizeof(int));

    // Ο χρηστης δινει τα στοιχεια του Χ.
    printf("\n----------------------------\n");
    printf("Give N numbers for vector X.\n");
    for(int i=0; i<(*arrSize); i++){
        printf("X[%d]: ", i);
        scanf("%d", &((*X)[i]));
    }

}


/*
    Υπολογιζει και αποθηκευει τα local sizes (N) και τα displs
    για το Scatterv για καθε επεξεργαστη.
*/
void calcLocalSizes(int n, int **counts, int **displs){
    
    int p;
    MPI_Comm_size(MPI_COMM_WORLD, &p);
    

    int nDIVp = n/p;
    int nMODp = n%p;
    
    // Τα localN (counts[0_N-1]) καθε p βγαινουν απο την ακεραια διαιρεση (nDIVp)
    // του μεγεθους του Χ με τον αριθμο των επεξεργαστων. nMODp = το υπολοιπο 
    // της διαιρεσης. Στους nMODp επεξεργαστες τα localN τους είναι nDIVp + 1.
    (*counts) = (int *) malloc( p * sizeof(int));
    for(int i=0; i<p; i++){
        if(i<nMODp)
            (*counts)[i] = nDIVp + 1;
        else
            (*counts)[i] = nDIVp;
    }

    // displs[0_N-1] = globIndex0
    (*displs) = (int *) malloc( p * sizeof(int));
    (*displs)[0] = 0;
    for(int i=0; i<p; i++)
        (*displs)[i] = (*displs)[i-1] + (*counts)[i-1];
}


/*
    Ο root διαμοιραζει το Ν, τα local μεγεθη, τις θεσεις τους 
    στον Χ και τους υποπινακες του Χ στους επεξεργαστες.
*/
void distrX(int root, int *counts, int *displs, int *localN, int *ind0, int **localX, float **localD, int *globX, int *globN){
    
    // Διαμοιραζει το Ν
    MPI_Bcast(globN, 1, MPI_INT, root, MPI_COMM_WORLD);

    // Διαμοιραζει τις θεσεις τους στον Χ
    MPI_Scatter(displs, 1, MPI_INT, 
                ind0, 1, MPI_INT,
                root, MPI_COMM_WORLD);

    // Διαμοιραζει τα local μεγεθη
    MPI_Scatter(counts, 1, MPI_INT, 
                localN, 1, MPI_INT,
                root, MPI_COMM_WORLD);

    // Ολοι οι p δεσμευουν την μνημη για τα localX και
    // localD που θα επεξεργαστουν
    (*localX) = (int *) malloc((*localN) * sizeof(int));
    (*localD) = (float *) malloc((*localN) * sizeof(float));

    // Διαμοιραζει τα στοιχεια του Χ σε ολα τα p
    MPI_Scatterv(globX, counts, displs, MPI_INT,
                *localX, *localN, MPI_INT,
                root, MPI_COMM_WORLD);

}


/*
    Υπολογιζει συλλογικα και διαμοιραζει τις avg, min, max τιμες
    σε ολους τους επεξεργαστες.
*/
void avg_min_max(int root, int globN, int locN, int *locX, float *avg, int *min, int *max){

    int rank, size;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    float loc_sum = locX[0];
    int loc_min = locX[0];
    int loc_max = locX[0];

    // Καθε p βρισκει τα δικα του local min, max και avg
    for(int i=1; i<locN; i++){
        loc_sum += locX[i];
        if(loc_min > locX[i])
            loc_min = locX[i];
        if(loc_max < locX[i])
            loc_max = locX[i];
    }
    loc_sum = loc_sum/globN;

    // Ο root μαζευει τα local min, max και avg, και κανει τις πραξεις μεσω του MPI_Reduce
    MPI_Reduce(&loc_sum, avg, 1, MPI_FLOAT, MPI_SUM, root, MPI_COMM_WORLD);
    MPI_Reduce(&loc_min, min, 1, MPI_INT, MPI_MIN, root, MPI_COMM_WORLD);
    MPI_Reduce(&loc_max, max, 1, MPI_INT, MPI_MAX, root, MPI_COMM_WORLD);

    // Ο root διαμοιραζει τα τελικα avg, min και max σε ολα τα p.
    MPI_Bcast(avg, 1, MPI_FLOAT, root, MPI_COMM_WORLD);
    MPI_Bcast(min, 1, MPI_INT, root, MPI_COMM_WORLD);
    MPI_Bcast(max, 1, MPI_INT, root, MPI_COMM_WORLD);
}


/*
    Ερωτημα (α). Υπολογιζει ποσα στοιχεια του Χ εχουν μικροτερη και
    ποσα μεγαλυτερη τιμη απο τη μεση τιμη αυτου.
*/
void avg_less_more(int root, int locN, int *locX, float avg, int *less, int *more){

    int loc_less = 0;
    int loc_more = 0;
    
    // Καθε p υπολογιζει ποσα στοιχεια εχει μικροτερα και ποσα μεγαλυτερα του avg.
    for(int i=0; i<locN; i++){
        if(locX[i] < avg)
            loc_less++;
        else if(avg < locX[i])
            loc_more++;
    }

    // Ο root μαζευει τα local αποτελεσματα των p και βρισκει τα τελικα.
    MPI_Reduce(&loc_less, less, 1, MPI_INT,
                MPI_SUM, root, MPI_COMM_WORLD);
    MPI_Reduce(&loc_more, more, 1, MPI_INT,
                MPI_SUM, root, MPI_COMM_WORLD);
}


/*
    Ερωτημα (β).Υπολογιζει την διασπορα των στοιχειων του Χ.
*/
void varElements(int root, int globN, int locN, int *locX, float avg, float *var){
    
    float loc_var = 0;

    // Καθε p υπολογιζει το local var του (οπως λεει η εκφωνηση).
    for(int i=0; i<locN; i++){
        loc_var += ((float)locX[i] - avg) * ((float)locX[i] - avg);
    }
    loc_var = loc_var / (float)globN;

    // Ο root μαζευει τα local var των p, τα προσθετει και βρισκει το τελικο var.
    MPI_Reduce(&loc_var, var, 1, MPI_FLOAT,
                MPI_SUM, root, MPI_COMM_WORLD);
}


/*
    Ερωτημα (γ). Υπολογιζει συλλογικα ενα νεο διανυσμα Δ τα οποια
    στοιχεια του ειναι δi = ((xi – xmin) / (xmax – xmin)) * 100.
*/
void calcArrD(int root, int max, int min, int locN, int *locX, float *locD, float *D, int *counts, int *displs){

    // Καθε p υπολογιζει τα local στοιχεια του D(οπως λεει η εκφωνηση).
    for(int i=0; i<locN; i++)
        locD[i] = ((float)(locX[i] - min) / (float)(max - min)) * 100;

    // Ο root μαζευει τα local D στοιχεια ολων το p.
    MPI_Gatherv(locD, locN, MPI_FLOAT,
                D, counts, displs, MPI_FLOAT, 
                root, MPI_COMM_WORLD);
}


/*
    Ερωτημα (δ). Βρισκει συλλογικα το max του D και το index του.
*/
void calcMaxD(int root, int locN, int globInd, float *locD, struct float_int *globMaxD){

    struct float_int locMaxD;
    locMaxD.num = locD[0];
    locMaxD.ind = globInd + 0;

    // Καθε p βρισκει το max του local D του, και το global index του.
    for(int i=1; i<locN; i++){
        if(locMaxD.num < locD[i]){
            locMaxD.num = locD[i];
            locMaxD.ind = globInd + i;
        }
    }

    // Ο root χρησιμοποιει την κληση MPI_Reduce με 
    // datatype MPI_FLOAT_INT το οποιο ειναι struct με float και int
    // και op MPI_MAXLOC για να βρει το max και το index του.
    MPI_Reduce(&locMaxD, globMaxD, 1, MPI_FLOAT_INT,
                MPI_MAXLOC, root, MPI_COMM_WORLD);
}


/*
    Ερωτημα (ε). Υπολογιζει συλλογικα το διανυσμα των προθεματων του Χ
    **ΜΟΝΟ ΓΙΑ N=p**
*/
void calcPreSums(int root, int *locX, int *globPreSums){

    int locPreSum;

    // Με την κληση της MPI_Scan(με MPI_SUM) καθε επεξεργαστης
    // προσθετει το στοιχειο του με ολα τα στοιχεια των προηγουμενων
    // του επεξεργαστων και το βαζει στο locPreSum.
    MPI_Scan(locX, &locPreSum, 1, MPI_INT, MPI_SUM, MPI_COMM_WORLD);
    // Ο root μαζευει ολα τα locPreSum των επεξεργαστων.
    MPI_Gather(&locPreSum, 1, MPI_INT, globPreSums, 1, MPI_INT, root, MPI_COMM_WORLD);

}


/*
    Τυπωνει τις απαντησεις των ερωτηματων και ζηταει απο
    τον χρηστη αν θελει επαναληψη.
*/
void printResults(int p, int N, int min, int max, float avg, int less_avg, int more_avg, float var, float *D, int *X, struct float_int maxD, int *globPreSums, char *rep){
    printf("\n--------------INFO--------------\n");
    printf("Processes (P) = %d\n", p);
    printf("Size of X (N) = %d\n", N);

    printf("\n-------------X STATS------------\n");
    printf("MIN value = %d\n", min);
    printf("MAX value = %d\n", max);
    printf("AVERAGE value = %.1f\n", avg);

    printf("\n----------ANSWER TO A-----------\n");
    printf("Values LESS than AVERAGE : %d\n", less_avg);
    printf("Values MORE than AVERAGE : %d\n", more_avg);
    printf("Values EQUAL  to AVERAGE : %d\n", (N - (less_avg + more_avg)));
    
    printf("\n----------ANSWER TO B-----------\n");
    printf("Element dispersion of X (VAR) = %.1f\n", var);
    
    printf("\n----------ANSWER TO C-----------\n");
    printf("Vector D, where Di == ((Xi - Xmin) / (Xmax - Xmin)) * 100\n");
    for(int i=0; i<N; i++)
        printf("D[%d] = %.1f\n", i, D[i]);
    
    printf("\n----------ANSWER TO D-----------\n");
    printf("Value of Dmax = %.1f\n", maxD.num);
    printf("Dmax index = %d\n", maxD.ind);
    printf("Value of X in Dmax index = %d\n", X[maxD.ind]);

    printf("\n----------ANSWER TO D-----------\n");
    if(p == N){
        printf("Prefix Sums of X\n");
        for(int i=0; i<N; i++)
            printf("PreSum[%d] = %d\n", i, globPreSums[i]);
    } else{
        printf("***Program won't calculate prefix sums for (N != P)***\n");
    }

    printf("\n------------REPEAT ?------------\n");
    printf("Any key to repeat.\n0 to exit.\n");
    printf("Input: ");
    getchar();
    *rep = getchar();


    printf("\n-|-|-|-|-|-|-|LOOP END|-|-|-|-|-|-|-\n");
    
    if((*rep) == '0'){
        printf("\n--------PROGRAM INFO----------\n");
        printf("ΑΣΚΗΣΗ 2 ΕΣΠΥ\n");
        printf("ΕΛΕΥΘΕΡΙΟΣ ΒΑΓΓΕΛΗΣ\n");
        printf("ΑΜ: 18390008\n");
        printf("\n-|-|-|-|-|-|-|PROGRAM END|-|-|-|-|-|-|-\n");
    }
    

}