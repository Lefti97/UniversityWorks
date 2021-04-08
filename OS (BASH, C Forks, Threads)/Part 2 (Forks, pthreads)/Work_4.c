#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
// The requested min number
int min;
// **arrA, **arrB are global pointers to arrays A,B initialised in main
int *arrA;
int *arrB;
// first, last, nDIVp are used by the two functions called by threads to
// determine which parts of arrA,arrB each are going to calculate
int first;
int last;
int nDIVp; // n/p
// Barrier and Mutexes declaration
pthread_barrier_t bar;
pthread_mutex_t mutex1;
pthread_mutex_t mutex2;

void minMatrix(); // Function that finds minimum of A and creates B (uses Barriers)
void showArrays(int len); // function to show the arrays
char inputChar(char* str1, char* str2); // for input

int main(){
    char c; // for input
    int i,j; // loop counters
    int maxRand; // Maximum random number
    int p; // Number of threads
    int n; // Array length

    //Program Intro
    printf("-------------------------------------\n");
    printf("This console program uses multithreading to find\n");
    printf("the minimum number in A[nxn] and create B[nxn]\n");
    printf("where Bij = Aij –  min.\n");
    printf("0 to EXIT.\n");
    printf("-------------------------------------\n");

    // Input for p threads
    printf("Give number of threads: "); 
    scanf("%d",&p); 
    if     (p<0) p=-p; // p never negative
    else if(p==0)exit(0);
    
    pthread_t thr[p];   // Thread/s declaration

    //Input for n array length. n must be integral multiple of p.
    printf("Give n of A[nxn] and B[nxn]: ");
    scanf("%d",&n); 
    if(n==0)exit(0);
    while((n%p)!=0){ // LOOP: Asks new value if n is not integral multiple of p
        printf("n must be an integral multiple of p.\n");
        printf("Give n: "); 
        scanf("%d",&n); 
        if(n==0)exit(0);
    } 
    if(n<0)n=-n; // n never negative

    int A[n][n],B[n][n]; // A and B arrays declaration with n length.
    arrA=*A; arrB=*B; // Global arrA,arrB now point to A,B

    // Input manual or random values for A
    printf("Give value entry method for  A\n");
    c = inputChar("Manual","Random");
    // Array value methods
    if(c=='1'){    // Manual value entry
        printf("Enter values manually.\n");
        printf("0 will not exit.\n");
        for(i=0;i<n;i++){
            for(j=0;j<n;j++){
                printf("A[%d][%d]= ",i,j);
                scanf("%d",&A[i][j]);
            }
        }
    }
    else if(c=='2'){    // Random value entry
        srand(time(NULL));
        printf("Choose max random number: "); 
        scanf("%d",&maxRand);
        maxRand++;
        for(i=0;i<n;i++){
            for(j=0;j<n;j++){
                A[i][j]=(rand()*rand()) % maxRand;
            }
        }
    }

    // Global indexes initialised for first thread
    nDIVp = (n*n)/p;
    first=0;
    last = nDIVp - 1;
    min = A[0][0];
    //Thread creation
    pthread_mutex_init(&mutex1,NULL);
    pthread_mutex_init(&mutex2,NULL);
    pthread_barrier_init(&bar,NULL,p);
    for(i=0;i<p;i++){
        if(pthread_create(&thr[i],NULL,(void *)&minMatrix,NULL) != 0){
            printf("Error: Thread %d",i);
        }
    }
    for(i=0;i<p;i++)// main waiting for threads to finish
        pthread_join(thr[i],NULL);

    showArrays(n);
    printf("-------------------------------------\n");
    printf("GLOBAL MIN= %d\n",min);
    printf("MATRIX DIMENSIONS = %dx%d\tTHREADS = %d\n",n,n,p);
    printf("-------------------------------------\n");
    printf("Made by: Lefteris Vaggelis\n");
    printf("-------------------------------------\n");
    return(0);
}

void minMatrix(){
    pthread_mutex_lock(&mutex1);// If mutex1 is locked wait. Else continue.
    int firstInd = first; // This thread First index = global first 
    int lastInd = last;   // This thread Last index = global last
    first = last + 1; // global first becomes the next elemnt of global last for next thread
    last += nDIVp;  // nDIVp is added to global last for next thread
    pthread_mutex_unlock(&mutex1); // Unlock mutex1 so another thread can enter.
    int i;
    int lclMin = arrA[firstInd];

    for(i=firstInd;i<lastInd+1;i++){ // Calculating local min
        if(arrA[i]<lclMin)
            lclMin=arrA[i];
    }
    if(lclMin<min){// Changing global min if lclMin is smaller
        pthread_mutex_lock(&mutex2);// If mutex2 is locked wait. Else continue.
        min = lclMin;
        pthread_mutex_unlock(&mutex2); // Unlock mutex2 so another thread can enter.
    }
    pthread_barrier_wait(&bar);// Barrier stops threads until min of A is found

    for(i=firstInd;i<lastInd+1;i++)// B is created here
        arrB[i]=arrA[i]-min;
    pthread_barrier_wait(&bar);// Barrier stops threads until B is finished
}


void showArrays(int len){
    int ind=0;
    int i,j;
    printf("-------------------------------------\n");
    printf("MATRIX AB[nxn] DATA:\n\n");
    for(i=0;i<len;i++){
        for(j=0;j<len;j++){
            printf("A[%d][%d]= %d\t",i,j,arrA[ind]);
            printf("B[%d][%d]= %d\n",i,j,arrB[ind++]);
        }
    }
}


char inputChar(char* str1, char* str2){
    char c='5';
    while(c<'0' || '2'<c){
        printf("1.%s\n2.%s\n0.Exit\nChoose: ", str1, str2);
        getchar();
        c=getchar();
    }
    if(c=='0')exit(0);
    return c;
}