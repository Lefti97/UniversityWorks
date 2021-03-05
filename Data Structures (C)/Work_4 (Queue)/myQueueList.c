
#include "myQueueList.h"

void enqueue(char obj[], PTR *pf, PTR *pr){
	PTR newnode;
	newnode=(PTR *)malloc(sizeof(PTR)); assert(newnode!=NULL);
	strcpy(newnode->data, obj);
	newnode->next=NULL;
	if((*pf)==NULL){
		*pf=newnode;
		*pr=newnode;
	}
	else{
		(*pr)->next=newnode;
		*pr=newnode;
	}
}

void dequeue(PTR *pf, PTR *pr){
	PTR p;
	if((*pf)==NULL)
		printf("\nQueue empty. No elements to delete.\n");
	else{
		p=*pf;
		*pf=(*pf)->next;
		if((*pf)==NULL) *pr = *pf;
		printf("%s has been deleted...\n",p->data);
		free(p);
	}
	system("pause");
}

void printqueue(PTR p, PTR pr){
	while(p!=NULL){
		printf("\n\t\t%s",p->data);
		p=p->next;
	}
}
