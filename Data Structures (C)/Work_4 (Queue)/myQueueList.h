
#ifndef _myQueueList_h
#define _myQueueList_h
	
	#include <assert.h>
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	
	#define PLATE_LENGTH 9
	
	#ifndef _node_
	#define _node_
	struct node{
		char data[PLATE_LENGTH];
		struct node *next;
	};
	typedef struct node *PTR;
	#endif
	
	void enqueue(char obj[], PTR *pf, PTR *pr);
	void dequeue(PTR *pf, PTR *pr);
	void printqueue(PTR pf, PTR pr);

#endif
