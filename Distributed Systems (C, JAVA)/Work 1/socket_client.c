#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <unistd.h>

#define PORT 9000

// Enum for available choices. Exists to make the code more readable.
enum Choice 
{
    CLOSE = 0, 
    X_MEASURE = 1, 
    XY_INNER_PROD = 2, 
    XY_AVG = 3, 
    XY_R_PROD = 4, 
};

// A function for each available calculation made by the server.
void xMeasure();
void xyInnerProd();
void xyAvg();
void xyRProd();
// Function that requests size and elements of an array.
void vectorInput(int *size, int **arr, char vecName);

int main()
{
    enum Choice ch = -1;
    int tmp;

    // Repeats as long as the user hasnt choosen CLOSE==0.
    while(ch != CLOSE){
        printf("0: CLOSE\n1: VECTOR X MEASURE\t2: XY INNER PRODUCT\t3: XY AVERAGE\t4: XY R PRODUCT\nINPUT: ");
        scanf("%d", &tmp); 
        ch = tmp;

        // The calculation function that the user chose is called here.
        switch (ch)
        {
            case CLOSE:
                printf("Choice: EXIT\n");
                break;
            
            case X_MEASURE:
                printf("Choice: VECTOR X MEASURE\n");
                printf("------------------------\n");
                xMeasure();
                break;

            case XY_INNER_PROD:
                printf("Choice: XY INNER PRODUCT\n");
                printf("------------------------\n");
                xyInnerProd();
                break;

            case XY_AVG:
                printf("Choice: XY AVERAGE\n");
                printf("------------------\n");
                xyAvg();
                break;
            
            case XY_R_PROD:
                printf("Choice: XY R PRODUCT\n");
                printf("--------------------\n");
                xyRProd();
                break;

            default:
                printf("Choice: INCORRECT INPUT\n");
                break;
        }
    }
    printf("Closing client...\n");
}


void xMeasure()
{
    struct sockaddr_in serv_addr;
    struct hostent *server;
    int sock, portno;
    
    enum Choice ch = X_MEASURE;
    int n=0;
    int *X;
    float result = 0;

    vectorInput(&n, &X, 'X');

    if(n>0){
        
        // Socket client setup
        sock = socket(AF_INET, SOCK_STREAM, 0);
        portno = PORT;
        server = gethostbyname("localhost");
        serv_addr.sin_family = AF_INET;
        serv_addr.sin_port = htons(portno);
        bcopy(  (char *)server->h_addr, 
                (char *)&serv_addr.sin_addr.s_addr,
                server->h_length);

        // Connection with socket server
        if (connect(sock, (struct sockaddr *)&serv_addr, sizeof(serv_addr))){
            printf("Failed connection to localhost server.\n");
        }
        else{
            printf("Successful connection to localhost server.\n");
            
            // Sends and receives (different for each calculation function)
            send(sock, &ch, sizeof(ch), 0);
            send(sock, &n, sizeof(n), 0);
            send(sock, X, n*sizeof(int), 0);

            recv(sock, &result, sizeof(float), 0);

            close(sock);

            printf("VECTOR X MEASURE = %.2f\n", result);
            printf("Closed connection to localhost server.\n");
        }
       
       // Deallocate arrays
       free(X);
    }

    printf("------------------------\n");
}


void xyInnerProd()
{
    struct sockaddr_in serv_addr;
    struct hostent *server;
    int sock, portno;

    enum Choice ch = XY_INNER_PROD;
    int n=0;
    int *X, *Y;
    int result=0;

    vectorInput(&n, &X, 'X');
    
    if(n>0){
        vectorInput(&n, &Y, 'Y');

        // Socket client setup
        sock = socket(AF_INET, SOCK_STREAM, 0);
        portno = PORT;
        server = gethostbyname("localhost");
        serv_addr.sin_family = AF_INET;
        serv_addr.sin_port = htons(portno);
        bcopy(  (char *)server->h_addr, 
                (char *)&serv_addr.sin_addr.s_addr,
                server->h_length);

        // Connection with socket server
        if (connect(sock, (struct sockaddr *)&serv_addr, sizeof(serv_addr))){
            printf("Failed connection to localhost server.\n");
        }
        else{
            printf("Successful connection to localhost server.\n");
            
            // Sends and receives (different for each calculation function)
            send(sock, &ch, sizeof(ch), 0);
            send(sock, &n, sizeof(n), 0);
            send(sock, X, n*sizeof(int), 0);
            send(sock, Y, n*sizeof(int), 0);

            recv(sock, &result, sizeof(int), 0);

            close(sock);

            printf("XY INNER PRODUCT = %d\n", result);
            printf("Closed connection to localhost server.\n");
        }

        // Deallocate arrays
        free(X);
        free(Y);
    }
    
    printf("------------------------\n");
}


void xyAvg()
{
    struct sockaddr_in serv_addr;
    struct hostent *server;
    int sock, portno;

    enum Choice ch = XY_AVG;
    int n=0;
    int *X, *Y;
    float result[2] = {0,0}; // result[0] = Ex, result[1] = Ey

    vectorInput(&n, &X, 'X');
    
    if(n>0){
        vectorInput(&n, &Y, 'Y');

        // Socket client setup
        sock = socket(AF_INET, SOCK_STREAM, 0);
        portno = PORT;
        server = gethostbyname("localhost");
        serv_addr.sin_family = AF_INET;
        serv_addr.sin_port = htons(portno);
        bcopy(  (char *)server->h_addr, 
                (char *)&serv_addr.sin_addr.s_addr,
                server->h_length);

        // Connection with socket server
        if (connect(sock, (struct sockaddr *)&serv_addr, sizeof(serv_addr))){
            printf("Failed connection to localhost server.\n");
        }
        else{
            printf("Successful connection to localhost server.\n");
            
            // Sends and receives (different for each calculation function)
            send(sock, &ch, sizeof(ch), 0);
            send(sock, &n, sizeof(n), 0);
            send(sock, X, n*sizeof(int), 0);
            send(sock, Y, n*sizeof(int), 0);

            recv(sock, result, 2*sizeof(float), 0);

            close(sock);

            printf("Ex = %.2f\tEy = %.2f\n", result[0], result[1]);
            printf("Closed connection to localhost server.\n");
        }

        // Deallocate arrays
        free(X);
        free(Y);
    }

    printf("------------------------\n");
}


void xyRProd()
{
    struct sockaddr_in serv_addr;
    struct hostent *server;
    int sock, portno;

    enum Choice ch = XY_R_PROD;
    int n=0;
    int *X, *Y;
    float r;
    float *result;
    
    printf("Give r (FLOAT): "); scanf("%f", &r);
    vectorInput(&n, &X, 'X');
    
    if(n>0){
        vectorInput(&n, &Y, 'Y');
        result = (float*) malloc(n * sizeof(float));

        // Socket client setup
        sock = socket(AF_INET, SOCK_STREAM, 0);
        portno = PORT;
        server = gethostbyname("localhost");
        serv_addr.sin_family = AF_INET;
        serv_addr.sin_port = htons(portno);
        bcopy(  (char *)server->h_addr, 
                (char *)&serv_addr.sin_addr.s_addr,
                server->h_length);

        // Connection with socket server
        if (connect(sock, (struct sockaddr *)&serv_addr, sizeof(serv_addr))){
            printf("Failed connection to localhost server.\n");
        }
        else{
            printf("Successful connection to localhost server.\n");
            
            // Sends and receives (different for each calculation function)
            send(sock, &ch, sizeof(ch), 0);
            send(sock, &n, sizeof(n), 0);
            send(sock, X, n*sizeof(int), 0);
            send(sock, Y, n*sizeof(int), 0);
            send(sock, &r, sizeof(float), 0);

            recv(sock, result, n*sizeof(float), 0);

            close(sock);

            printf("Results array:\n");
            for(int i=0; i<n;i++)
                printf("result[%d] = %.2f\n", i, result[i]);
            printf("Closed connection to localhost server.\n");
        }

        // Deallocate arrays
        free(X);
        free(Y);
        free(result);
    }
    else{
        printf("Results array: EMPTY\n");
        
    }
    printf("--------------------\n");
}


void vectorInput(int *size, int **arr, char vecName){
    if((*size)<=0){
        printf("Give n (INTEGER) size of %c[n]: ", vecName);
        scanf("%d", size);
    }

    if((*size) > 0){
        (*arr) = (int *) malloc ((*size) * sizeof(int));
        printf("Give each element (INTEGER) of vector %c: \n", vecName);
        for(int i=0; i<(*size); i++){
            printf("%c[%d] = ", vecName, i);
            scanf("%d", &((*arr)[i]));
        }
    }
}
