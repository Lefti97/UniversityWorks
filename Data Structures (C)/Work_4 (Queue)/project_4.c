
#include "myQueueList.h"

int edisplay_menu();

int main(){
	PTR front,rear;
	int a;
	char plate[PLATE_LENGTH];
	
	while(a=edisplay_menu()){
		if(a==1){
			printf("Give the car's plate: ");
			scanf("%s",plate);
			enqueue(plate,&front,&rear);
		}
		else if(a==2)
			dequeue(&front,&rear);
		else if(a==3)
			printqueue(front,rear);
	}
	
	return 0;
}

int edisplay_menu(){
	int x;
	
	while(1){
		printf("\nMENU\n\n");
		printf("===========\n\n");
		printf("1.Car arrival\n");
		printf("2.Car departure\n");
		printf("3.Queue state\n");
		printf("0.Exit\n\n");
		printf("Choice? ");
		
		scanf("%d",&x);
		if(0<=x && x<=3)
			return x;
		else
			printf("ERROR. CHOOSE NUMBER FROM MENU.\n\n");
	}
}
