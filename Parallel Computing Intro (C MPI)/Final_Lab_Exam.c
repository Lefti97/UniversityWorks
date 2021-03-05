
#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>


int main(int argc, char** argv){

    int rank, size;
    MPI_Status status;
    float D[6];
    int counts[4];
    int displs[4];
    float ginomena[4];
    float ginomeno;
    float locGinomeno;
    float *localD;
    int localN;

    MPI_Init(&argc, &argv);

    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);


    // Εδω ο επεξεργαστης 0 ζητα απο τον χρηστη τα 6 στοιχεια
    // και υπολογιζει ποσα στοιχεια θα παρει ο καθε επεξεργαστης(counts),
    // και απο ποιο στοιχειο του πινακα θα ξεκινησουν να παιρνουν(displs).
    if(rank == 0){
        printf("Give 12 numbers:\n");
        for(int i=0; i<6; i++){
            printf("D[%d]: ", i);
            scanf("%f", &D[i]);
        }

        displs[0]=0;
        for(int i=0; i<size; i++){
            if(i<(6%size)){
                counts[i] = (6/size) + 1;
            }else{
                counts[i] = 6/size;
            }
            if(i>0)
                displs[i] = displs[i-1] + counts[i-1];
        }
    }

    // Διαμοιραζουμε τα τοπικα μεγεθοι στους επεξεργαστερ.
    MPI_Scatter(counts, 1, MPI_INT, &localN, 1, MPI_INT, 0, MPI_COMM_WORLD);
    
    // Δεσμευουμε τον χωρο για τα τοπικα στοιχεια και τα διαμοιραζουμε
    localD = (float *) malloc(localN * sizeof(float));
    MPI_Scatterv(D, counts, displs, MPI_FLOAT, localD, localN, MPI_FLOAT, 0, MPI_COMM_WORLD);

    for(int i=0; i<localN; i++){
        printf("RANK %d, localD[%d] = %f\n", rank, i, localD[i]);
    }

    // Υπολογισμος τοπικου γινομενου
    locGinomeno = localD[0];
    for(int i=1; i<localN; i++){
        locGinomeno = locGinomeno * localD[i];
    }
    printf("RANK %d, locGinomeno = %f\n", rank,locGinomeno);

    // Συλλογικη συναρτηση για αθροισμα των τοπικων γινομενων
    // Δεν ημουν σιγουρος αν χρειαζοταν να κανω gather και μετα υπολογισμος στο root.
    MPI_Reduce(&locGinomeno, &ginomeno, 1, MPI_FLOAT, MPI_SUM, 0, MPI_COMM_WORLD);
    
    // Διαμοιρασμος αθροισματος τοπικων γινομενων
    MPI_Bcast(&ginomeno, 1, MPI_FLOAT, 0, MPI_COMM_WORLD);

    printf("RANK = %d\tGINOMENO = %f\n", rank, ginomeno);

    MPI_Finalize();

}
