#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#include <stdbool.h>
#include <time.h>
#include <math.h>

#define TIME_MULT 1000

int numThreads;

// Get user input for number of threads, array size and how to set array.
void userInput(int *arrSizeN, int *arrMode, int *exportMode){
    printf("------------------------------\n");
    printf("Parallel Systems Assignment 1\n");
    printf("------------------------------\n");

    printf("Set number of threads: ");
    scanf("%d", &numThreads);
    
    printf("Set array size N: ");
    scanf("%d", arrSizeN);

    printf("Choose set array mode:\n");
    printf("1. Manual Input\n");
    printf("2. Generate random array\n");
    printf("3. Generate strict diagonal dominant array\n");
    printf("Input: ");
    scanf("%d", arrMode);

    printf("Export arrays to txt?\t1.Yes Other.No\n");
    printf("Input: ");
    scanf("%d", exportMode);
    if(*exportMode != 1)
        *exportMode = 0;
}

void allocateArrays(int ***arrA, int ***arrB, int arrSizeN){
    int i;
// Allocate NxN array A
    *arrA = (int **) malloc(arrSizeN * sizeof(int*));
    for( i = 0; i < arrSizeN; i++)
        arrA[0][i] = (int *) malloc(arrSizeN * sizeof(int));

// Allocate NxN array B
    *arrB = (int **) malloc(arrSizeN * sizeof(int*));
    for( i = 0; i < arrSizeN; i++)
        arrB[0][i] = (int *) malloc(arrSizeN * sizeof(int));
}

void manualSetArrays(int **arrA, int arrSizeN){
    int i, j;

// Set array A:
    printf("Set array A variables:\n");
    for( i = 0; i < arrSizeN; i++)
        for( j = 0; j < arrSizeN; j++){
            printf("A[%d][%d] = ", i, j);
            scanf("%d", &arrA[i][j]);
        }
}

void generateArray(int **arrA, int arrSizeN, int arrMode){
    int i, j, lineSum;

    for(i=0;i<arrSizeN;i++){
        lineSum = 0;
        for(j=0;j<arrSizeN;j++){
            arrA[i][j] = rand() % 10;
            lineSum += arrA[i][j]; 
        }
        if(arrMode == 2)
            arrA[i][i] = rand() % ( lineSum * 2);
        else if(arrMode == 3)
            arrA[i][i] = lineSum + 1;
    }
}

// Export array to filename txtName
void exportArray(int **arr, int arrSizeN, char* txtName, int exportMode){
    int i, j;
    FILE *text;

    if(exportMode == 0)
        return;

    text = fopen(txtName, "w");

    for(i=0;i<arrSizeN;i++){
        for(j=0;j<arrSizeN;j++){
            fprintf(text,"%d ", arr[i][j]);
        }
        fprintf(text,"\n");
    }

    fclose(text);

    printf("Exported %s\n", txtName);
}

// Check if given NxN array is strictly diagonally dominant. And get run time.
bool isStrictDiagDominant(int **arrA, int arrSizeN, double *time){
    int i, j, chunk;
    bool isOk = true;

    // Evenly distribute array A lines
    // One thread for one line
    chunk = arrSizeN / numThreads;
    if(chunk == 0) chunk = 1;

    *time = omp_get_wtime();

    #pragma omp parallel shared(arrA, arrSizeN, isOk, chunk) private(i, j)
    {
        // Each line is scheduled to be checked by one thread.
        // This is needed because sum is used exclusively for each line.
        #pragma omp for schedule(dynamic, chunk)
        for (i = 0; i < arrSizeN; i++)
        {
            int sum = 0;

            for (j = 0; j < arrSizeN; j++)
            {
                if(i != j)
                    sum += abs(arrA[i][j]);
            }

            if(sum >= abs(arrA[i][i])) 
                isOk = false;
        }
    }

    *time = (omp_get_wtime() - *time) * TIME_MULT;

    return isOk;
}

// Calculate max value of diagonal A ( maxDiagonal = max(|𝛢𝑖𝑖|), i=0…N-1))
int calcMaxDiagonalA(int **arrA, int arrSizeN, double *time){
    int i, maxA=0, chunk;

// Evenly distribute diagonal A values
    chunk = arrSizeN / numThreads;
    if(chunk == 0) chunk = 1;

    *time = omp_get_wtime();

    #pragma omp parallel shared(arrA, arrSizeN, chunk) private(i)
    {
        // Threads are scheduled to loop through diagonal A and find
        // the maximum value of their assigned indexes.
        // Reduction is used to get the max value from all max values 
        // found by all threads.
        #pragma omp for schedule(dynamic, chunk) reduction(max:maxA)
        for (i = 0; i < arrSizeN; i++){
            if(abs(arrA[i][i]) > maxA)
                maxA = abs(arrA[i][i]);
        }
    }

    *time = (omp_get_wtime() - *time) * TIME_MULT;

    return maxA;
}

// Create array B using max diagonal A (𝐵𝑖𝑗 = m – |𝐴𝑖𝑗| for i<>j και 𝐵𝑖𝑗 = m for i=j)
void createArrayB(int **arrB, int **arrA, int arrSizeN, int maxDiagonal, double *time){
    int i, j, chunk;

    // Evenly distribute all array values
    chunk = arrSizeN * arrSizeN / numThreads;
    if(chunk == 0) chunk = 1;

    *time = omp_get_wtime();

    #pragma omp parallel shared(arrB, arrSizeN, maxDiagonal, chunk) private(i, j)
    {
        // Since the assignment of a point in the array is independent from
        // other points of the array, there is no need to schedule lines
        // to be calculated by one thread. Therefore we use collapse(2)
        // in order to parallelize both for loops.
        #pragma omp for schedule (dynamic, chunk) collapse (2)
        for(i=0;i<arrSizeN;i++){
            for(j=0;j<arrSizeN;j++){
                if(i != j)
                    arrB[i][j] = maxDiagonal - abs(arrA[i][j]);
                else
                    arrB[i][j] = maxDiagonal;
            }
        }
    }

    *time = (omp_get_wtime() - *time) * TIME_MULT;
}

// Calculate minimum value of array B using reduction.
int calcMinB_Reduction(int **arrB, int arrSizeN, double *time){
    int i, j, minB=INT_MAX, chunk;

    // Evenly distribute all array values
    chunk = arrSizeN * arrSizeN / numThreads;
    if(chunk == 0) chunk = 1;

    *time = omp_get_wtime();

    #pragma omp parallel shared(arrB, arrSizeN, chunk) private(i, j)
    {
        // colapse(2) is used in order parallelize both for loops.
        // reduction(min:minB) gets the minimum value of all the
        // minimum values calculated by each thread.
        #pragma omp for schedule(dynamic, chunk) reduction(min:minB) collapse (2)
        for(i=0;i<arrSizeN;i++){
            for(j=0;j<arrSizeN;j++){
                if (abs(arrB[i][j]) < minB) {
                    minB = abs(arrB[i][j]);
                }
            }
        }
    }

    *time = (omp_get_wtime() - *time) * TIME_MULT;

    return minB;
}

// Calculate minimum value of array B using mutual exclusions
int calcMinB_MutualExclusion(int **arrB, int arrSizeN, double *time){
    int i, j, minB=INT_MAX, chunk;

    chunk = arrSizeN * arrSizeN / numThreads;
    if(chunk == 0) chunk = 1;

    *time = omp_get_wtime();

    #pragma omp parallel shared(arrB, arrSizeN, chunk) private(i, j)
    {
        int localMin = INT_MAX;

        // colapse(2) is used in order parallelize both for loops.
        #pragma omp for schedule(dynamic, chunk) collapse (2)
        for(i=0;i<arrSizeN;i++){
            for(j=0;j<arrSizeN;j++){
                if (abs(arrB[i][j]) < localMin) {
                    localMin = abs(arrB[i][j]);
                }
            }
        }

        // Critical is used here in order for the assignment of minB
        // to be done by one thread at a time. If it was done parallelized
        // it would have unexpected results.
        #pragma omp critical
        {
            if (localMin < minB) 
                minB = localMin;
        }
    }
    
    *time = (omp_get_wtime() - *time) * TIME_MULT;

    return minB;
}

// Calculate minimum value of array B using binary tree
int calcMinB_BinaryTree(int **arrB, int arrSizeN, double *time){
    int chunk, tid, xInd, yInd;

    *time = omp_get_wtime();

    // Inspired by EREW PRAM Max algorithm
    #pragma omp parallel shared(arrB, arrSizeN) private(tid, xInd, yInd)
    {
        int tmp0, tmp1;
        int i=1, j=1;
        tid = omp_get_thread_num();
        xInd = tid / arrSizeN; // Starting X index
        yInd = tid % arrSizeN; // Starting Y index

        while (xInd + i-1<arrSizeN){
            while(yInd + j-1<arrSizeN){
                tmp0 = abs(arrB[xInd][yInd]);
                tmp1 = abs(arrB[xInd + i-1][yInd + j-1]);
                
                // Each thread assigns their minimum found value to B[xInd][yInd].
                if(tmp0 < tmp1)
                    arrB[xInd][yInd] = tmp0;
                else
                    arrB[xInd][yInd] = tmp1;

                j = 2*j;
            }
            j = 1;
            i = 2*i;
        }
    }

    *time = (omp_get_wtime() - *time) * TIME_MULT;

    return arrB[0][0];
}

int main(){
    FILE *text;
    int i, j, chunk;
    int arrSizeN, arrMode, exportMode;
    int **arrA, **arrB, maxDiagonal, minB_reduction, minB_mutualExclusion, minB_binaryTree;
    double tTotal=0, tSDD=0, tDiagonal=0, tArrB=0, tMinRed=0, tMinME=0, tMinBinTree=0;

    srand(time(0));

// Intro prints and inputs
    userInput(&arrSizeN, &arrMode, &exportMode);

// Set OpenMP threads
    omp_set_num_threads(numThreads);

// Allocate arrays
    allocateArrays(&arrA, &arrB, arrSizeN);

// Set arrays
    switch (arrMode)
    {
        case 1: // Manual Input
            manualSetArrays(arrA, arrSizeN);
            break;
        case 2: // Generate random array
            generateArray(arrA, arrSizeN, arrMode);
            break;
        case 3: // Generate strict diagonal dominant array
            generateArray(arrA, arrSizeN, arrMode);
            break;
        default:
            printf("Invalid mode.\n");
            break;
    }  

//a) Check if arrA is strictly diagonally dominant (|𝛢𝑖𝑖|>Σ |𝐴𝑖𝑗| όπου j=0…N-1 i<>j)
    if(isStrictDiagDominant(arrA, arrSizeN, &tSDD)){

//b) Calculate max value of diagonal A ( maxDiagonal = max(|𝛢𝑖𝑖|), i=0…N-1))
        maxDiagonal = calcMaxDiagonalA(arrA, arrSizeN, &tDiagonal);

//c) Create array B using maxDiagonal (𝐵𝑖𝑗 = m – |𝐴𝑖𝑗| for i<>j και 𝐵𝑖𝑗 = m for i=j)
        createArrayB(arrB, arrA, arrSizeN, maxDiagonal, &tArrB);

//d1) Calculate minimum value of array B using reduction
        minB_reduction = calcMinB_Reduction(arrB, arrSizeN, &tMinRed);

//d2.1) Calculate minimum value of array B using mutual exclusion
        minB_mutualExclusion = calcMinB_MutualExclusion(arrB, arrSizeN, &tMinME);

//d2.2) Calculate minimum value of array B using binary tree
        exportArray(arrB, arrSizeN, "arrB.txt", exportMode); //Not counted in running time
        minB_binaryTree = calcMinB_BinaryTree(arrB, arrSizeN, &tMinBinTree);

// Total time
        tTotal = tSDD + tDiagonal + tArrB + tMinRed + tMinME + tMinBinTree;

// Final prints
        printf("---------------------------------------------------\n");
        printf("Threads: %d\n", numThreads);
        printf("Array size: %d\n", arrSizeN);
        printf("Array A is SDD           \tTIME(ms): %.1f\n", tSDD);
        printf("MAX of diagonal A: %d    \tTIME(ms): %.1f\n", maxDiagonal, tDiagonal);
        printf("Array B creation         \tTIME(ms): %.1f\n", tArrB);
        printf("MIN of B(reduction): %d  \tTIME(ms): %.1f\n", minB_reduction, tMinRed);
        printf("MIN of B(Mut. Exc.): %d  \tTIME(ms): %.1f\n", minB_mutualExclusion, tMinME);
        printf("MIN of B(bin tree): %d   \tTIME(ms): %.1f\n", minB_binaryTree, tMinBinTree);
        printf("Total run                \tTIME(ms): %.1f\n", tTotal);

// Final exports
        text = fopen("runStats.txt", "a");

        fprintf(text, "Threads: %d\n", numThreads);
        fprintf(text, "Array size: %d\n", arrSizeN);
        fprintf(text, "Array A is SDD           \tTIME(ms): %.1f\n", tSDD);
        fprintf(text, "MAX of diagonal A: %d    \tTIME(ms): %.1f\n", maxDiagonal, tDiagonal);
        fprintf(text, "Array B creation         \tTIME(ms): %.1f\n", tArrB);
        fprintf(text, "MIN of B(reduction): %d  \tTIME(ms): %.1f\n", minB_reduction, tMinRed);
        fprintf(text, "MIN of B(Mut. Exc.): %d  \tTIME(ms): %.1f\n", minB_mutualExclusion, tMinME);
        fprintf(text, "MIN of B(bin tree): %d   \tTIME(ms): %.1f\n", minB_binaryTree, tMinBinTree);
        fprintf(text, "Total run                \tTIME(ms): %.1f\n", tTotal);
        fprintf(text, "---------------------------------------------------\n");
        
        fclose(text);

        exportArray(arrA, arrSizeN, "arrA.txt", exportMode);
    }
    else{
        printf("---------------------------------------------------\n");
        printf("Array A is not SDD - TIME(ms): %.1f\n", tSDD);
        exportArray(arrA, arrSizeN, "arrA.txt", exportMode);
    }

    free(arrA);
    free(arrB);
}