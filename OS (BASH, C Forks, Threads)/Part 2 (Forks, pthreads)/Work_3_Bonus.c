
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>
#include <pthread.h>
pthread_mutex_t cond_mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond1 = PTHREAD_COND_INITIALIZER;
pthread_cond_t cond2 = PTHREAD_COND_INITIALIZER;
pthread_cond_t cond3 = PTHREAD_COND_INITIALIZER;
void print1();
void print2();
void print3();
int x = 1; // Determines which thread will run

int main(){
    pthread_t th1, th2, th3;
    //Thread creation
    pthread_create(&th1,NULL,(void *) &print1, NULL);
    pthread_create(&th2,NULL,(void *) &print2, NULL);
    pthread_create(&th3,NULL,(void *) &print3, NULL);
    // main waiting threads
    pthread_join(th1,NULL);
    pthread_join(th2,NULL);
    pthread_join(th3,NULL);
}
void print1(){
    while(1){
        // if x!=1 wait pthread_cond_signal(&cond1) in print3
        pthread_mutex_lock(&cond_mutex);
        if(x!=1){
            pthread_cond_wait(&cond1,&cond_mutex);}
        pthread_mutex_unlock(&cond_mutex);

        printf("What A ");
        // signal print2 to continue
        x=2;
        pthread_cond_signal(&cond2);
    }
}
void print2(){
    while(1){
        // if x!=2 wait pthread_cond_signal(&cond2) in print1
        pthread_mutex_lock(&cond_mutex);
        if(x!=2){
            pthread_cond_wait(&cond2,&cond_mutex);}
        pthread_mutex_unlock(&cond_mutex);

        printf("Wonderful ");
        // signal print3 to continue
        x=3;
        pthread_cond_signal(&cond3);
    }
}
void print3(){
    while(1){
        // if x!=3 wait pthread_cond_signal(&cond3) in print2
        pthread_mutex_lock(&cond_mutex);
        if(x!=3){
            pthread_cond_wait(&cond3,&cond_mutex);}
        pthread_mutex_unlock(&cond_mutex);

        printf("World! ");
        //signal print1 to continue
        x=1;
        pthread_cond_signal(&cond1);
    }
}