#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <errno.h>
#include <unistd.h>
#include <pthread.h>
#include <semaphore.h>


// Total sum calculated from threads
long int total_sum = 0; 
// *arrA, *arrB are global pointers to arrays A,B initialised in main
int *arrA;
int *arrB;
// first, last, nDIVp are used by the two functions called by threads to
// determine which parts of arrA,arrB each are going to calculate
int first;
int last;
int nDIVp; // n/p

// Mutex locks
pthread_mutex_t mutex0;
pthread_mutex_t mutex1;
// Semaphores
sem_t sem0;
sem_t sem1;

void vectorMultMutex(); // Thread calculation with mutexes
void vectorMultSemaphore(); // Thread calculation with semaphores
void showArrays(int len); // function to show the arrays
char inputChar(char* str1, char* str2); // for nicer code

int main(){
    clock_t t = 0; // for time keeping
    double time_taken; // for time keeping
    char c; // for input
    int i; // loop counter
    int maxRand; // Maximum random number
    int p; // Number of threads
    int n; // Array length

    //Program Intro
    printf("-------------------------------------\n");
    printf("This console program uses multithreading(or not) to calculate\n");
    printf("the internal product of two vectors A and B.\n");
    printf("0 to EXIT.\n");
    printf("-------------------------------------\n");

    // Input for p threads
    printf("Give number of threads: "); 
    scanf("%d",&p); 
    if     (p<0) p=-p; // p never negative
    else if(p==0)exit(0);
    
    pthread_t thr[p];   // Thread/s declaration

    //Input for n array length. n must be integral multiple of p.
    printf("Give length of vectors A and B: ");
    scanf("%d",&n); 
    if(n==0)exit(0);
    while((n%p)!=0){ // LOOP: Asks new value if n is not integral multiple of p
        printf("n must be an integral multiple of p.\n");
        printf("Give n: "); 
        scanf("%d",&n); 
        if(n==0)exit(0);
    } 
    if(n<0)n=-n; // n never negative

    
    int A[n],B[n]; // A and B arrays declaration with n length.
    arrA=A; arrB=B; // Global arrA,arrB now point to A,B


    // Input manual or random values for A and B
    printf("Give value entry method for vectors A,B\n");
    c = inputChar("Manual","Random");
    // Array value methods
    if(c=='1'){    // Manual value entry
        printf("Enter values manually.\n");
        printf("0 will not exit.\n");
        for(i=0;i<n;i++){
            printf("A[%d]= ",i); 
            scanf("%d",&A[i]);
            printf("B[%d]= ",i); 
            scanf("%d",&B[i]);
        }
    }
    else if(c=='2'){    // Random value entry
        srand(time(NULL));
        printf("Choose max random number: "); 
        scanf("%d",&maxRand);
        maxRand++;
        for(i=0;i<n;i++){
            A[i]=(rand()*rand()) % maxRand;
            B[i]=(rand()*rand()) % maxRand;
        }
    }
    


    // Show array data non-multithreaded
    printf("Output non-multithreaded data?.\n");
    c = inputChar("YES","NO (Only multithreaded)");
    if(c=='1') showArrays(n);



    // Input for critical section protection method
    printf("Give critical section protection method.(Multithread calculation)\n");
    c = inputChar("POSIX Mutex","POSIX Semaphore");
 

    printf("-------------------------------------\n");
    printf("VECTOR LENGTH = %d\tTHREADS = %d\n",n,p);
    printf("-------------------------------------\n");


    // Global indexes initialised for first thread
    nDIVp = n/p;
    first=0;
    last = nDIVp - 1;
    
    
    // Threads calculating
    if(c=='1'){
        printf("Multithreaded calculation with POSIX Mutex locks.\n\n");
        // Mutex Initialization
        pthread_mutex_init(&mutex0,NULL);
        pthread_mutex_init(&mutex1,NULL);
        t = clock(); // clock start
        for(i=0;i<p;i++){ // MUTEX METHOD
            if( pthread_create(&thr[i],NULL,(void *) &vectorMultMutex, NULL) != 0 ){
                printf("Error: Thread %d",i);}
        }
    }
    else if(c=='2'){ 
        printf("Multithreaded calculation with POSIX Semaphores.\n\n");
        // Semaphore initialization
        sem_init(&sem0, 0, 1);
        sem_init(&sem1, 0, 1);
        t = clock(); // clock start
        for(i=0;i<p;i++){ // SEMAPHORE METHOD
            if( pthread_create(&thr[i],NULL,(void *) &vectorMultSemaphore, NULL) != 0 ){
                printf("Error: Thread %d",i);}
        }
    }
    // main waiting for threads to finish
    for(i=0;i<p;i++){
        pthread_join(thr[i],NULL);}

    t = clock() - t; // clock finish
    time_taken = ((double)t)/CLOCKS_PER_SEC; // Time taken in seconds

    // Mutex or Semaphore destruction
    if     (c=='1'){
        pthread_mutex_destroy(&mutex0);
        pthread_mutex_destroy(&mutex1);
    }
    else if(c=='2'){
        sem_destroy(&sem0);
        sem_destroy(&sem1);
    }

    printf("\nTotal Sum = %ld\n", total_sum);
    printf("Milliseconds taken = %.3f\n",time_taken*1000);
    printf("-------------------------------------\n");
    printf("Made by: Lefteris Vaggelis\n");
    printf("-------------------------------------\n");

    return(0);
}


void vectorMultMutex(){
    pthread_mutex_lock(&mutex0);// If mutex0 is locked wait. Else continue.
    int firstInd = first; // This thread First index = global first 
    int lastInd = last;   // This thread Last index = global last
    first = last + 1; // global first becomes the next elemnt of global last for next thread
    last += nDIVp;  // nDIVp is added to global last for next thread
    pthread_mutex_unlock(&mutex0); // Unlock mutex0 so another thread can enter.

    long int local_sum = 0; // Local sum to add to global total sum at the end
    int i;
    
    for(i=firstInd; i<lastInd+1; i++){ // Calculate local sum of AB[firstInd...lastInd]
        local_sum += arrA[i]*arrB[i];
        //TESTING printf. Uncomment to output every thread calculation
        //printf("--Thread AB [%d - %d]\tAB[%d]= %d*%d =%d\tlocal_sum = %d\n"
        //   ,firstInd,lastInd,i,arrA[i],arrB[i],arrA[i]*arrB[i],local_sum);
    }
    printf("Thread AB[%d - %d]\tlocal_sum = %ld\n",firstInd,lastInd,local_sum);

    pthread_mutex_lock(&mutex1); // If mutex1 is locked wait. Else continue.
    total_sum += local_sum; // Add local_sum to global total_sum
    pthread_mutex_unlock(&mutex1); // Unlock mutex1 so another thread can enter.
}

void vectorMultSemaphore(){
    sem_wait(&sem0); // If sem0 is 0 wait. Else enter and sem0--
    int firstInd = first; // This thread First index = global first 
    int lastInd = last; // This thread Last index = global last
    first = last + 1; // global first becomes the next elemnt of global last for next thread
    last += nDIVp; // nDIVp is added to global last for next thread
    sem_post(&sem0); // sem++

    int local_sum = 0; // Local sum to add to global total sum at the end
    int i;
    
    for(i=firstInd; i<lastInd+1; i++){ // Calculate local sum of AB[firstInd...lastInd]
        local_sum += arrA[i]*arrB[i];
        //TESTING printf. Uncomment to output every thread calculation
        //printf("--Thread AB [%d - %d]\tAB[%d]= %d*%d =%d\tlocal_sum = %d\n"
        //   ,firstInd,lastInd,i,arrA[i],arrB[i],arrA[i]*arrB[i],local_sum);
    }
    printf("Thread AB[%d - %d]\tlocal_sum = %d\n",firstInd,lastInd,local_sum);

    sem_wait(&sem1); // If sem1 is 0 wait. Else enter and sem1--
    total_sum += local_sum; // Add local_sum to global total_sum
    sem_post(&sem1); // sem1++
}

void showArrays(int len){
    int i;
    int total=0;
    printf("-------------------------------------\n");
    printf("VECTOR DATA (Not multithreaded):\n");
    for(i=0;i<len;i++){
        printf("A[%d] = %d\tB[%d] = %d\tAB[%d]= %d\n",i,arrA[i],i,arrB[i],i,arrA[i]*arrB[i]);
        total += arrA[i]*arrB[i];
    }
    printf("\nTotal Sum = %d (Not multithreaded calculation)\n", total);
    printf("-------------------------------------\n");
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