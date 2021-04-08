#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define SOCK_PATH "Fibonnaci_Socket"

int main(){
    int sock, done, n, i, tmp, t;
    struct sockaddr_un server;
    char str[50];
    // Create socket
    if ((sock = socket(AF_UNIX, SOCK_STREAM, 0)) == -1) {
        perror("socket");
        exit(1);
    }
    // Server filepath
    server.sun_family = AF_UNIX;
    strcpy(server.sun_path, SOCK_PATH);
    // Connect this client to server
    if (connect(sock, (struct sockaddr *)&server, 
    sizeof(struct sockaddr_un)) == -1) {
        perror("connect");
        exit(1);
    }
    // Program start print
    printf("Connected to server.\n");
    printf("As client, you must give N numbers to the server, in\n");
    printf("turn the server will tell you if the numbers you sent\n ");
    printf("are the first N numbers of the Fibonacci sequence.\n");
    
    done=0;
    do{
        // Ask for N and send it to server
        printf("Give N: "); scanf("%d",&n);
        send(sock, &n, sizeof(n), 0);
        // Ask for N numbers and send each to server
        for(i=0;i<n;i++){
            printf("Num %d: ", i+1); 
            scanf("%d",&tmp);
            send(sock, &tmp, sizeof(tmp), 0);
        }
        // Receive and print server answer
        t = recv(sock, str, 50, 0);
        str[t]='\0';
        printf("Server Response: %s\n",str);
        // Ask user if he wants to repeat and send to server
        printf("Repeat?\n0. Yes\tOther. No\nInput: ");
        scanf("%d",&done);
        send(sock, &done, sizeof(done), 0);
    }while(!done);
}