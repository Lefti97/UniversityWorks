/*
 * This is sample code generated by rpcgen.
 * These are only templates and you can use them
 * as a guideline for developing your own functions.
 */

#include "rpc.h"
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

int conns = 0; // Keeps count of connections made

void
xmeasure_prog_1(char *host, int sock)
{
	CLIENT *clnt;
	float  *result_1;
	nX  xmeasure_1_arg;

#ifndef	DEBUG
	clnt = clnt_create (host, xMeasure_PROG, xMeasure_VERS, "udp");
	if (clnt == NULL) {
		clnt_pcreateerror (host);
		exit (1);
	}
#endif	/* DEBUG */

    // Receive array size from socket client and allocate arrays
    recv(sock, &xmeasure_1_arg.n, sizeof(xmeasure_1_arg.n), 0);
    xmeasure_1_arg.X.X_len = xmeasure_1_arg.n;
    xmeasure_1_arg.X.X_val = (int *) malloc (xmeasure_1_arg.n * sizeof(int));
    
    // Receive array elements from socket client
    recv(sock, xmeasure_1_arg.X.X_val, xmeasure_1_arg.n*sizeof(int), 0);
    
    // RPC_SERVER calculation
	result_1 = xmeasure_1(&xmeasure_1_arg, clnt);
	if (result_1 == (float *) NULL) {
		clnt_perror (clnt, "call failed");
	}

    // Send result to socket client
	send(sock, result_1, sizeof(float), 0);

    // RPC_CLIENT PRINTS
    printf("%d--VECTOR X MEASURE\n", conns);
    printf("%d--Received n = %d\n", conns, xmeasure_1_arg.n);
    printf("%d--Received X:\n", conns);
    for(int i=0; i<xmeasure_1_arg.n; i++)
        printf("%d--X[%d] = %d\n", conns, i, xmeasure_1_arg.X.X_val[i]);
    printf("%d--Sent result = %.2f\n", conns, *result_1);

    free(xmeasure_1_arg.X.X_val);

#ifndef	DEBUG
	clnt_destroy (clnt);
#endif	 /* DEBUG */
}


void
xyinnerprod_prog_1(char *host, int sock)
{
	CLIENT *clnt;
	int  *result_1;
	nXY  xyinnerprod_1_arg;

#ifndef	DEBUG
	clnt = clnt_create (host, xyInnerProd_PROG, xyInnerProd_VERS, "udp");
	if (clnt == NULL) {
		clnt_pcreateerror (host);
		exit (1);
	}
#endif	/* DEBUG */

    // Receive array size from socket client and allocate arrays
    recv(sock, &xyinnerprod_1_arg.n, sizeof(xyinnerprod_1_arg.n), 0);
    xyinnerprod_1_arg.X.X_len = xyinnerprod_1_arg.n;
    xyinnerprod_1_arg.X.X_val = (int *) malloc (xyinnerprod_1_arg.n * sizeof(int));
    xyinnerprod_1_arg.Y.Y_len = xyinnerprod_1_arg.n;
    xyinnerprod_1_arg.Y.Y_val = (int *) malloc (xyinnerprod_1_arg.n * sizeof(int));

    // Receive array elements from socket client
    recv(sock, xyinnerprod_1_arg.X.X_val, xyinnerprod_1_arg.n*sizeof(int), 0);
    recv(sock, xyinnerprod_1_arg.Y.Y_val, xyinnerprod_1_arg.n*sizeof(int), 0);
    
    // RPC_SERVER calculation
	result_1 = xyinnerprod_1(&xyinnerprod_1_arg, clnt);
	if (result_1 == (int *) NULL) {
		clnt_perror (clnt, "call failed");
	}

    // Send result to socket client
	send(sock, result_1, sizeof(int), 0);
    
    // RPC_CLIENT PRINTS
    printf("%d--XY INNER PRODUCT\n", conns);
    printf("%d--Received n = %d\n", conns, xyinnerprod_1_arg.n);
    printf("%d--Received X:\n", conns);
    for(int i=0; i<xyinnerprod_1_arg.n; i++)
        printf("%d--X[%d] = %d\n", conns, i, xyinnerprod_1_arg.X.X_val[i]);
    printf("%d--Received Y:\n", conns);
    for(int i=0; i<xyinnerprod_1_arg.n; i++)
        printf("%d--Y[%d] = %d\n", conns, i, xyinnerprod_1_arg.Y.Y_val[i]);
    printf("%d--Sent result = %d\n", conns, *result_1);

    free(xyinnerprod_1_arg.X.X_val);
    free(xyinnerprod_1_arg.Y.Y_val);
#ifndef	DEBUG
	clnt_destroy (clnt);
#endif	 /* DEBUG */
}


void
xyavg_prog_1(char *host, int sock)
{
	CLIENT *clnt;
	struct float_array  *result_1;
	nXY  xyavg_1_arg;

#ifndef	DEBUG
	clnt = clnt_create (host, xyAvg_PROG, xyAvg_VERS, "udp");
	if (clnt == NULL) {
		clnt_pcreateerror (host);
		exit (1);
	}
#endif	/* DEBUG */

    // Receive array size from socket client and allocate arrays
	recv(sock, &xyavg_1_arg.n, sizeof(xyavg_1_arg.n), 0);
    xyavg_1_arg.X.X_len = xyavg_1_arg.n;
    xyavg_1_arg.X.X_val = (int *) malloc (xyavg_1_arg.n * sizeof(int));
    xyavg_1_arg.Y.Y_len = xyavg_1_arg.n;
    xyavg_1_arg.Y.Y_val = (int *) malloc (xyavg_1_arg.n * sizeof(int));

    // Receive array elements from socket client
    recv(sock, xyavg_1_arg.X.X_val, xyavg_1_arg.n*sizeof(int), 0);
    recv(sock, xyavg_1_arg.Y.Y_val, xyavg_1_arg.n*sizeof(int), 0);
    
    // RPC_SERVER calculation
	result_1 = xyavg_1(&xyavg_1_arg, clnt);
	if (result_1 == (struct float_array *) NULL) {
		clnt_perror (clnt, "call failed");
	}

    // Send result to socket client
	send(sock, result_1->arr.arr_val, 2*sizeof(float), 0);

    // RPC_CLIENT PRINTS
    printf("%d--XY AVERAGE\n", conns);
    printf("%d--Received n = %d\n", conns, xyavg_1_arg.n);
    printf("%d--Received X:\n", conns);
    for(int i=0; i<xyavg_1_arg.n; i++)
        printf("%d--X[%d] = %d\n", conns, i, xyavg_1_arg.X.X_val[i]);
    printf("%d--Received Y:\n", conns);
    for(int i=0; i<xyavg_1_arg.n; i++)
        printf("%d--Y[%d] = %d\n", conns, i, xyavg_1_arg.Y.Y_val[i]);
    printf("%d--Sent result Ex= %.2f\tEy= %.2f\n", conns, result_1->arr.arr_val[0], result_1->arr.arr_val[1]);

    free(xyavg_1_arg.X.X_val);
    free(xyavg_1_arg.Y.Y_val);
	free(result_1->arr.arr_val);
#ifndef	DEBUG
	clnt_destroy (clnt);
#endif	 /* DEBUG */
}


void
xyrprod_prog_1(char *host, int sock)
{
	CLIENT *clnt;
	struct float_array  *result_1;
	nXYr  xyrprod_1_arg;

#ifndef	DEBUG
	clnt = clnt_create (host, xyRProd_PROG, xyRProd_VERS, "udp");
	if (clnt == NULL) {
		clnt_pcreateerror (host);
		exit (1);
	}
#endif	/* DEBUG */

    // Receive array size from socket client and allocate arrays
	recv(sock, &xyrprod_1_arg.n, sizeof(xyrprod_1_arg.n), 0);
    xyrprod_1_arg.X.X_len = xyrprod_1_arg.n;
    xyrprod_1_arg.X.X_val = (int *) malloc (xyrprod_1_arg.n * sizeof(int));
    xyrprod_1_arg.Y.Y_len = xyrprod_1_arg.n;
    xyrprod_1_arg.Y.Y_val = (int *) malloc (xyrprod_1_arg.n * sizeof(int));

    // Receive array elements from socket client
    recv(sock, xyrprod_1_arg.X.X_val, xyrprod_1_arg.n*sizeof(int), 0);
    recv(sock, xyrprod_1_arg.Y.Y_val, xyrprod_1_arg.n*sizeof(int), 0);

    // Receive r from socket client
    recv(sock, &xyrprod_1_arg.r, sizeof(xyrprod_1_arg.r), 0);

    // RPC_SERVER calculation
	result_1 = xyrprod_1(&xyrprod_1_arg, clnt);
	if (result_1 == (struct float_array *) NULL) {
		clnt_perror (clnt, "call failed");
	}

    // Send result to socket client
	send(sock, result_1->arr.arr_val, xyrprod_1_arg.n*sizeof(float), 0);
    
    // RPC_CLIENT PRINTS
    printf("%d--XY R PRODUCT\n", conns);
    printf("%d--Received r = %.2f\n", conns, xyrprod_1_arg.r);
    printf("%d--Received n = %d\n", conns, xyrprod_1_arg.n);
    printf("%d--Received X:\n", conns);
    for(int i=0; i<xyrprod_1_arg.n; i++)
        printf("%d--X[%d] = %d\n", conns, i, xyrprod_1_arg.X.X_val[i]);
    printf("%d--Received Y:\n", conns);
    for(int i=0; i<xyrprod_1_arg.n; i++)
        printf("%d--Y[%d] = %d\n", conns, i, xyrprod_1_arg.Y.Y_val[i]);
    printf("%d--Sent results:\n", conns);
    for(int i=0; i<xyrprod_1_arg.n; i++)
        printf("%d--res[%d] = %.2f\n", conns, i, result_1->arr.arr_val[i]);
    
    free(xyrprod_1_arg.X.X_val);
    free(xyrprod_1_arg.Y.Y_val);
    free(result_1->arr.arr_val);
#ifndef	DEBUG
	clnt_destroy (clnt);
#endif	 /* DEBUG */
}


int
main (int argc, char *argv[])
{
	char host[] = "localhost";

	int sock, new_sock, portno, cli_len;
    struct sockaddr_in serv_addr, cli_addr;

    // Socket server setup
    sock = socket(AF_INET, SOCK_STREAM, 0);
    portno = PORT;
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_port = htons(portno);
    serv_addr.sin_addr.s_addr = INADDR_ANY;

    bind(sock, (struct sockaddr *) &serv_addr, sizeof(serv_addr));
    listen(sock, 5);

    while(1){
        cli_len = sizeof(cli_addr);

        printf("Waiting connection with client...\n");

        // Make connection with socket client
        new_sock = accept(sock, (struct sockaddr *) &cli_addr, &cli_len);

        conns++; // Keeps count of connections made

        // Each connection makes a new fork process
        // in order to achieve server concurrency.
        if(fork() == 0) // Child process
        {
            // Close the connection of this child process with main server socket.
            close(sock);

            enum Choice ch;
            
            printf("%d--Connected with client.\n", conns);

            // Receive the choice of socket client.
            recv(new_sock, &ch, sizeof(ch), 0);
            printf("%d--Received ch = %d\n", conns, ch);

            // Execute rpc program depending on socket client choice.
            switch (ch)
            {
            case X_MEASURE:
				xmeasure_prog_1 (host, new_sock);
                break;

            case XY_INNER_PROD:
				xyinnerprod_prog_1 (host, new_sock);
                break;

            case XY_AVG:
				xyavg_prog_1 (host, new_sock);
                break;

            case XY_R_PROD:
				xyrprod_prog_1 (host, new_sock);
                break;
            
            default:
                printf("%d--ERROR: choice from client\n", conns);
                break;
            }

            // Close child socket and exit.
            printf("%d--Closed connection with client\n\n", conns);
            close(new_sock);
            exit(0);
        }

        // Close parent's connection with child socket.
        // It is no longer needed by the parent.
        close(new_sock);

    }

    exit (0);
}