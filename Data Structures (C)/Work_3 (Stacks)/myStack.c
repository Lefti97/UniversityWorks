
#include "myStack.h"

void push(int stack[], int *t, int obj){
	if((*t)==(N-1)){
		printf("Stack overflow...\n");
		getch();
		abort();
	}
	else stack[++(*t)] = obj;
}

int pop(int stack[], int *t){
	int r;
	if((*t)<0){
		printf("Stack empty...\n");
		printf("Error in expression.\n");
		getch();
		abort();
	}
	else r=stack[(*t)--];
	return (r);
}
