#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>

// Συναρτησεις διεργασιας 0
void userInput(int tasks, int *n, int **arr);
void distrToProcs(int tasks, int n, int *arr, int *procInd);

// Συναρτησεις διεργασιας != 0
void recvArray(int *n, int **arr, MPI_Status *status, int tasks);
int calcArray(int n, int *arr, int tasks, int rank, MPI_Status *status);

// Συναρτησεις διεργασιας 0
int recvFromProcs(int tasks, int n, int *procInd, MPI_Status *status);
void printResult(int res);

// Τελική συνάρτηση 
int endFunc(int tasks, char *repeat);


int main(int argc, char** argv){

    MPI_Status status;
    int tasks, rank ;
    int *procInd; // Κραταει το index 0 καθε διεργασιας πανω στον πινακα Τ.
    int n, *T;
    int result; // -1 ταξινομημενο κατα αυξουσα ... >=-1 πρωτη θεση που χαλαει.
    char repeat = '0'; // 0 Έξοδος, Οτιδήποτε άλλο επανάληψη

    MPI_Init(&argc, &argv);

    MPI_Comm_size(MPI_COMM_WORLD, &tasks);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    do{
        if(tasks < 2){
            printf("----------------------------------------\n");
            printf("There must be at least 2 MPI processors.\n");
            printf("Exiting.\n");
            printf("------------------------------------\n");
            break;
        }

        if(rank == 0){ // Διεργασια 1η
            procInd = (int *) malloc(tasks * sizeof(int));

            // 1. Είσοδος του μεγεθους (Ν), και των στοιχείων του πίνακα Τ.
            userInput(tasks, &n, &T);
            
            // 2. Αποστολή στοιχείων στα άλλα processes.
            distrToProcs(tasks, n, T, procInd);

            // 6. Αποτελεσμα υπολογισμων απο τις αλλες διεργασιες.
            result = recvFromProcs(tasks, n, procInd, &status);

            // 7. Τυπωμα αποτελεσματος
            printResult(result);

            // 8. Τέλος ή επανάληψη
            endFunc(tasks, &repeat);

            // Αποδέσμευση μνήμης.
            free(T);
            free(procInd);
        }
        else if(rank != 0){
            
            // 3. Αποδοχη του πινακα απο την διεργασια 0.
            recvArray(&n, &T, &status, tasks);

            // 4. Αποτελεσμα των υπολογισμων αυτης της διεργασιας.
            result = calcArray(n, T, tasks, rank, &status);

            // 5. Αποστολη αποτελεσματος στην διεργασια 0.
            MPI_Send(&result, 1, MPI_INT, 0, 4, MPI_COMM_WORLD);

            // 9. Αποδοχή τέλους ή επανάληψης.
            MPI_Recv(&repeat, 1, MPI_INT, 0, 5, MPI_COMM_WORLD, &status);
        
            // Αποδέσμευση μνήμης.
            free(T);
        }
    }while(repeat != '0');

    MPI_Finalize();
}



/*  
    1. Για p = 0.
    Ζητάει απο χρήστη μέγεθος Ν του πίνακα Τ,
    κάνει malloc τον Τ και ζητάει κάθε στοιχείο του Τ.
*/
void userInput(int tasks, int *n, int **arr){

    int size;

    tasks--; // Αριθμός διεργασιων που κάνουν υπολογισμους.

    do{
        printf("------------------------\n");
        printf("Give array size >= 0.\n");    
        printf("Number of calculating processes is %d.\n", tasks);
        printf("Input: ");
        scanf("%d", &size);
    }while((size < 0));
    
    *n = size;

    (*arr) = (int *) malloc(size * sizeof(int));
    
    printf("---------------------\n");
    printf("Give array T numbers.\n");
    for(int i=0; i<size; i++){
        printf("T[%d]: ", i);
        scanf("%d", &((*arr)[i]));
    }
    printf("----------\n");
}

/*  
    2. Για p = 0.
    Υπολογίζει το μέγεθος των πινάκων για κάθε p που υπολογίζει,
    κρατάει στο procInd την θέση του πρώτου index κάθε πίνακα των p
    πάνω στον Τ, στέλνει στα p τους υποπίνακες του T που τους αναλογούν.
*/
void distrToProcs(int tasks, int n, int *arr, int *procInd){

    int n2 = ( n / (tasks-1) ); // Ακέραια διαίρεση στοιχείων
    int n2mod = (n % (tasks-1)); // Υπολοιπο διαίρεσης
    int *arr2; // Ο πίνακας που θα στείλουμε σε κάθε p

    int prevSize; // Fix 1: Βοηθητικο στο for loop.

    for(int i=1; i<tasks; i++){
        
        // Όταν το μέγεθος Ν του πίνακα Τ δεν είναι ακέραιο
        // πολλ/σιο των 'p' τότε το υπόλοιπο της διαίρεσης 
        // Ν/p μοιράζεται στα (n MOD p) πρωτους 'p'.
        int indSize = n2;
        if(n2mod > 0){
            indSize++;
            n2mod--;
        }

        arr2 = (int *) malloc(indSize * sizeof(int));

        if(indSize != 0){
            // Index για το κομματι του Τ που θελουμε να στειλουμε
            if(i != 1){
                procInd[i] = procInd[i-1] + indSize; 
                // Fix 1: Όταν το υπόλοιπο (n MOD p) μοιραστεί στα 'p'
                // ο επόμενος p ξεκινάει από το προηγούμενο index του Τ
                // που θα έπρεπε, το διορθώνουμε κάνοντας +1 στο index.
                if(indSize != prevSize) 
                    procInd[i]++;
            }
            else{
                // Ο επεξεργαστης 1 θα έχει πάντα τα πρώτα στοιχεία απο το index 0.
                procInd[i] = 0; 
            }
            int tmp = procInd[i];

            // Γεμίζουμε τον πίνακα που θα στείλουμε από το κομμάτι
            // των στοιχείων του Τ που αναλογεί σε κάθε p.
            for(int j=0; j<indSize; j++){
                arr2[j] = arr[tmp+j];
            }
    
            
            /*// Δοκιμαστική print για εμφάνιση καθε υποπίνακα.
            printf("Proc: %d, Size: %d, Index0InT: %d\n", i, indSize, procInd[i]);
            for(int x=0; x<indSize; x++){
                printf("arr[%d]: %d\n", x, arr2[x]);
            }
            printf("-----------------------------\n");
            */

            // Στελνουμε το μεγεθος του πινακα που θα στειλουμε.
            MPI_Send(&indSize, 1, MPI_INT, i, 1, MPI_COMM_WORLD);
            // Στελνουμε τα στοιχεια του arr που χρειαζονται
            MPI_Send(arr2, indSize, MPI_INT, i, 2, MPI_COMM_WORLD);
        }
        else{
            // Αν το μέγεθος ειναι 0 βάζουμε άχρηστη πληροφορία στο procInd[i].
            procInd[i] = -1;
            MPI_Send(&indSize, 1, MPI_INT, i, 1, MPI_COMM_WORLD);
        }
        // Αποδέσμευση μνήμης και αποθήκευση μεγέθους πίνακα.
        free(arr2);
        prevSize = indSize;
    }
}


/*  
    3. Για p != 0.
    Δέχεται το μέγεθος και τον υποπίνακα του Τ που του αναλογεί.
*/
void recvArray(int *n, int **arr, MPI_Status *status, int tasks){
    
    // Αποδοχη μεγεθους πινακα απο διεργασια 0.
    MPI_Recv(n, 1, MPI_INT, 0, 1, MPI_COMM_WORLD, status);
    
    (*arr) = (int *) malloc((*n) * sizeof(int));

    if(*n != 0){
        // Αποδοχη στοιχειων του πινακα απο διεργασια 0
        MPI_Recv(*arr,(*n), MPI_INT, 0, 2, MPI_COMM_WORLD, status);
    }
}


/*  
    4. Για p != 0.
    Αρχικά ο p στέλνει το τελευταίο στοιχείο του πίνακα του και δέχεται
    το τελευταίο του p-1, αυτο γίνεται για να συγκρίνει ο p το πρωτο του
    στοιχείο με το τελευταίο του p-1.
    Ελέγχει τα στοιχεία του και στελνει -1 αν ειναι ταξινομημενα κατα
    αυξουσα σειρά ή στέλνει τον αριθμό του index που βρίσκεται
    το πρώτο λάθος.
*/
int calcArray(int n, int *arr, int tasks, int rank, MPI_Status *status){

    int result;
    int lastPrev; // Τελευταιο στοιχειο της διεργασιας rank-1
    int zero = 0;

    if(n != 0){
        /*
        Αν ειναι η διεργασια 1, να μην περιμενει τιμη,
        Αν ειναι η τελευταια διεργασια να μην στειλει τιμη.
        */
        if(rank != (tasks-1)){
            MPI_Send(&arr[n-1], 1, MPI_INT, rank+1, 3, MPI_COMM_WORLD);
        }
        if(rank != 1){
            MPI_Recv(&lastPrev, 1, MPI_INT, rank-1, 3, MPI_COMM_WORLD, status);
            // Ελεγχουμε το πρωτο στοιχειο της διεργασιας
            // με το τελευταιο της προηγουμενης διεργασιας.
            if((lastPrev > arr[0]))
                return 0;
        }


        for(int i=1; i<n; i++){
            if(arr[i-1] > arr[i]){
                return i;
            }
        }
    }
    else{ 
        // Αν δεν έχει στοιχεία να υπολογίσει στέλνει άχρηστo αριθμό.
        // Αυτο το κάνουμε για να κυλίσει ομαλά η ροή του MPI όταν
        // το μεγεθος του Τ ΔΕΝ ειναι ακεραιο πολλ/σιο του p.
        if(rank != (tasks-1)){
            MPI_Send(&zero, 1, MPI_INT, rank+1, 3, MPI_COMM_WORLD);
        }
         if(rank != 1){
            MPI_Recv(&zero, 1, MPI_INT, rank-1, 3, MPI_COMM_WORLD, status);
        }
    }
    
    return -1;
}


/*  
    6. Για p = 0.
    Δέχεται τα αποτελέσματα απο τα p ξεκινόντας απο το τελευταίο και
    πηγαίνοντας στο πρώτο. Το αποτέλεσμα είναι είτε το -1 (δλδ ταξινομημενο)
    ή το τελευταίο αποτέλεσμα (διαφορο του -1) που θα σταλθει απο τα p.
*/
int recvFromProcs(int tasks, int n, int *procInd, MPI_Status *status){

    int res = -1;

    for(int i=(tasks-1); i>=1; i--){
        int tmp;
        MPI_Recv(&tmp, 1, MPI_INT, i, 4, MPI_COMM_WORLD, status);
        
        if(tmp != -1){
            res = tmp + procInd[i];
        }
    }

    // Αν ο πίνακας είναι άδειος.
    if(n == 0)
        res = 0;

    return res;
}

/*  
    7. Για p = 0.
    Εκτύπωση αποτελέσματος.
*/
void printResult(int res){
    if(res == -1){
        printf("The matrix is sorted in ascending order.\n");
    }
    else if(res == 0){
        printf("The matrix is empty.\n");
    }
    else{
        printf("The matrix is not sorted in ascending order.\n");
        printf("The problem starts at T[%d]\n", res);
    }
    printf("----------------------------------\n");
}

/*  
    8. Για p = 0.
    Ερωτηση χρήστη αν θέλει να γίνει επανάληψη η όχι. 
    Στέλνει την απαντηση σε ολα τα p.
*/
int endFunc(int tasks, char *repeat){
    printf("Any key to repeat.\n0 to exit.\n");
    printf("Input: ");
    getchar();
    *repeat = getchar();

    //Στέλνουμε σε κάθε p αν θα γίνει επανάληψη.
    for(int i=1; i<tasks; i++){
        MPI_Send(repeat, 1, MPI_INT, i, 5, MPI_COMM_WORLD);
    }

    if((*repeat) == '0'){
        printf("-------------------\n");
        printf("ΑΣΚΗΣΗ 1 ΕΣΠΥ\n");
        printf("ΕΛΕΥΘΕΡΙΟΣ ΒΑΓΓΕΛΗΣ\n");
        printf("ΑΜ: 18390008\n");
        printf("-------------------\n");
    }
}