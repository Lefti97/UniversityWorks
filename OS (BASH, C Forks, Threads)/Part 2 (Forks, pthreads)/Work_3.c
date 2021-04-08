#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>
#include <pthread.h>
#include <semaphore.h>

void print1();
void print2();
void print3();
sem_t sem1;
sem_t sem2;
sem_t sem3;

int main(){
    pthread_t th1, th2, th3;
    //Semaphore initialization
    sem_init(&sem1,0,1);//Thread calling print1 will be executed first
    sem_init(&sem2,0,0);
    sem_init(&sem3,0,0);
    // Thread creation
    pthread_create(&th1,NULL,(void *) &print1, NULL);
    pthread_create(&th2,NULL,(void *) &print2, NULL);
    pthread_create(&th3,NULL,(void *) &print3, NULL);
    //main waiting threads
    pthread_join(th1,NULL);
    pthread_join(th2,NULL);
    pthread_join(th3,NULL);
}

void print1(){ // First print to be executed
    while(1){ // At beginning sem1 is 1
        sem_wait(&sem1); // Wait until sem1>0, then sem1--
        printf("What A ");
        sem_post(&sem2); // sem2++
    }
}
void print2(){ // Second print
    while(1){ // At beginning sem2 is 0
        sem_wait(&sem2); // Wait until sem2>0, then sem2--
        printf("Wonderful ");
        sem_post(&sem3); // sem3++
    }
}
void print3(){ // Third print
    while(1){ // At beginning sem3 is 0
        sem_wait(&sem3);// Wait until sem3 >0, then sem3--
        printf("World! ");
        sem_post(&sem1); // sem1++
    } //print1 executes next
}
