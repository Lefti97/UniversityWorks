#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <semaphore.h>

#define SOCK_PATH "Fibonnaci_Socket"

int corrSeq; // Holds number of correct fibonnaci sequences
pthread_mutex_t mut = PTHREAD_MUTEX_INITIALIZER;
sem_t sem;


void* thrFunction(void *arg); // Thread function

int main(){
    int sock, sock2, t, i;
    struct sockaddr_un local, remote;
    pthread_t thread[100];
    
    // Create socket
    if ((sock = socket(AF_UNIX, SOCK_STREAM, 0)) == -1) {
            perror("socket");
            exit(1);
    }
    // local filepath
    local.sun_family = AF_UNIX;
    strcpy(local.sun_path, SOCK_PATH);
    unlink(local.sun_path);
    // bind sock and local
    if (bind(sock, (struct sockaddr *)&local, 
    sizeof(struct sockaddr_un)) == -1) {
        perror("bind");
        exit(1);
    }
    // Prepare for connections on sock
    if (listen(sock, 5) == -1) {
        perror("listen");
        exit(1);
    }
    // Initializations
    i=0;
    corrSeq=0;
    sem_init(&sem,0,0);

    while(i <= 100){
        printf("Waiting for connection...\n");
        t = sizeof(remote);
        // Accept connection on sock. Return new sock to sock2.
        if ((sock2 = accept(sock, (struct sockaddr *)&remote, &t)) == -1) {
            perror("accept");
            exit(1);
        }    
        printf("Connection %d.\n", i);
        // Create thread calling thrFunction(sock2)
        pthread_create(&thread[i++], NULL, (void*)&thrFunction, (void*)&sock2);
        sem_wait(&sem); // Wait for thread to copy sock2
        printf("Correct Sequences until now: %d\n", corrSeq);
    }
    
}

void* thrFunction(void *arg){
    int so = *(int*)arg; 
    sem_post(&sem); // Sock2 copied post sem
    int done, n, i, fib0, fib1, fib2, res, fibCl; 
    char str[50];

    done = 0;
    do {
        recv(so, &n, sizeof(n), 0); // Receive N size from client
        res=0; fib0=0; fib1=1; // Initializations

        for(i=0;i<n;i++){ // Fibonacci sequence algorithm
            fib2 = fib0 + fib1;
            fib0 = fib1; // fib0 is current fibonacci number
            fib1 = fib2;
            // Receive number from client
            recv(so, &fibCl, sizeof(fibCl), 0);
            // Check if client gave correct Fibonnaci number
            if(fibCl != fib0) res = 1;
        }

        if(n<1) // If n given is 0 or negative
            strcpy(str,"Error. N must be greater than 0");
        else if(res==0){ // If sequence was correct
            strcpy(str,"Sequence Correct");
            pthread_mutex_lock(&mut);
            corrSeq++;
            pthread_mutex_unlock(&mut);
        }
        else if(res==1) // If sequence was false
            strcpy(str,"Sequence False");
        else
            strcpy(str,"Error");
        send(so, str, 50, 0);
        // Receive from client if he wants to repeat
        recv(so, &done, sizeof(done), 0);
    } while (!done);

    close(so); // Close socket connection
    pthread_exit(NULL);
}