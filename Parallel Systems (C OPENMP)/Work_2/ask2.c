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
    if(*arrSizeN >= INT_MAX){
        printf("Error: Max size of array is %d", INT_MAX);
        exit(1);
    }

    printf("Choose set array mode:\n");
    printf("1. Manual Input\n");
    printf("2. Generate random array\n");
    printf("Input: ");
    scanf("%d", arrMode);

    printf("Export arrays to txt?\t1.Yes Other.No\n");
    printf("Input: ");
    scanf("%d", exportMode);
    if(*exportMode != 1)
        *exportMode = 0;
}

void allocateArrays(int **arrA, int **space, int arrSizeN){
// Allocate array A
    *arrA = (int *) malloc(arrSizeN * sizeof(int));
// Allocate space array
    *space = (int *) malloc(arrSizeN * sizeof(int));
}

void manualSetArrays(int *arrA, int arrSizeN){
    int i;

// Set array A:
    printf("Set array A variables:\n");
    for( i = 0; i < arrSizeN; i++)
        printf("A[%d] = ", i);
        scanf("%d", &arrA[i]);
}

void generateArray(int *arrA, int arrSizeN, int arrMode){
    int i;

    for(i=0;i<arrSizeN;i++){
        arrA[i] = rand() % arrSizeN;
        if(rand() % 2) arrA[i] = -arrA[i];
    }
}

// Export array to filename txtName
void exportArray(int *arr, int arrSizeN, char* txtName, char* openMode, int exportMode){
    int i;
    FILE *text;

    if(exportMode == 0)
        return;

    text = fopen(txtName, openMode);

    for(i=0;i<arrSizeN;i++){
        fprintf(text,"%d ", arr[i]);
    }
    fprintf(text,"\n");

    fclose(text);
}

// Merge arrA and arrB sorted into result array
void merge(int *arrA, const int *arrASize, int *arrB, const int *arrBSize, int *result) {
    int i=0;
    
    // For each result value, assign the smallest value of the current
    // iterations of arrA and arrB. Increment the index of the array 
    // that the value was assigned from. 
    // Repeat until one array reaches its end.
    while (arrA <= arrASize && arrB <= arrBSize) {
        if ( *arrA < *arrB ) {
            result[i++] = *arrA;
            arrA++;
        } else {
            result[i++] = *arrB;
            arrB++;
        }
    }

    //Finish up the lower half
    while (arrA <= arrASize) {
        result[i++] = *arrA;
        arrA++;
    }

    //Finish up the upper half
    while (arrB <= arrBSize) {
        result[i++] = *arrB;
        arrB++;
    }
}

int cmpfunc(const void *a, const void *b) {
   return ( *(int*)a - *(int*)b );
}

// Multisort parallel algorithm
void multisort(int *arr, int *space, int arrSizeN){
    int *startA, *spaceA, *startB, *spaceB, *startC, *spaceC, *startD, *spaceD;
    int quarter;
    int tid;

    // If array size is less than 4 use quicksort
    if(arrSizeN < 4){
        qsort(arr, arrSizeN, sizeof(int), cmpfunc);
        return;
    }

    // New array sizes
    quarter = arrSizeN / 4;

    // Split array to 4 array blocks
    startA = arr;              spaceA = space;
    startB = startA + quarter; spaceB = spaceA + quarter;
    startC = startB + quarter; spaceC = spaceB + quarter;
    startD = startC + quarter; spaceD = spaceC + quarter;

    // Recursive call multisort for each array block
    #pragma omp task
        multisort (startA, spaceA, quarter);
    #pragma omp task
        multisort (startB, spaceB, quarter);
    #pragma omp task
        multisort (startC, spaceC, quarter);
    #pragma omp task
        multisort (startD, spaceD, arrSizeN - 3 * quarter);

    #pragma omp taskwait

    #pragma omp task
        merge(startA, startA+quarter-1, startB, startB+quarter-1, spaceA);
    #pragma omp task
        merge(startC, startC+quarter-1, startD, arr+arrSizeN-1, spaceC);
    
    #pragma omp taskwait
    
    merge(spaceA, spaceC-1, spaceC, spaceA+arrSizeN-1, startA);
}

int main(){
    FILE *text;
    int arrSizeN, arrMode, exportMode;
    int *arrA, *space;
    double runTime;

    srand(time(0));

// Intro prints and inputs
    userInput(&arrSizeN, &arrMode, &exportMode);

// Set OpenMP threads
    omp_set_num_threads(numThreads);

// Allocate arrays
    allocateArrays(&arrA, &space, arrSizeN);

// Set arrays
    switch (arrMode)
    {
        case 1: // Manual Input
            manualSetArrays(arrA, arrSizeN);
            break;
        case 2: // Generate random array
            generateArray(arrA, arrSizeN, arrMode);
            break;
        default:
            printf("Invalid mode.\n");
            break;
    }  

// Export initial array
    exportArray(arrA, arrSizeN, "array.txt", "w", exportMode);

    runTime = omp_get_wtime(); // Start timer

// Call multisort parallel algorithm
    #pragma omp parallel
    {
        #pragma omp single
            multisort(arrA, space, arrSizeN);
    }

    runTime = (omp_get_wtime() - runTime) * TIME_MULT; // Finish timer

// Append sorted array in 2nd line
    exportArray(arrA, arrSizeN, "array.txt", "a", exportMode);

// Print rutime 
    printf("--------------STATS--------------\n");
    printf("Threads: %d\tArray size: %d\n", numThreads, arrSizeN);
    printf("Run Time(ms): %.1f\n", runTime);

// Export run time
    text = fopen("results.txt", "a");
    fprintf(text, "Threads: %d\tArray size: %d\n", numThreads, arrSizeN);
    fprintf(text, "Run Time(ms): %.1f\n", runTime);
    fprintf(text, "---------------------------------------------------\n");
    fclose(text);

// Free space
    free(arrA);
    free(space);
}