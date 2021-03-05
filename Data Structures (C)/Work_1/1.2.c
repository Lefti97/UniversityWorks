
#include <stdio.h>
#include <stdlib.h>

float MO(float arr[] , int A , int B);

int main(){
	int i ,min ,max;
	float vathm[50]={};
	
	printf("Type 10 grades of students. (Grades 0 to 10)\n");
	for(i=0;i<50;i++){
		printf("%d. ",i+1);
		scanf("%f",&vathm[i]);
		if(vathm[i]<0||10<vathm[i]){
				printf("Grade must be from 0 to 10\n");
				i--;
		}
	}
	
	printf("Type a minimum and maximum grade to find the average.(Lowest for min 0 , highest for max 10)\n");
	do{
		printf("MINIMUM -> ");
		scanf("%d",&min);
		printf("MAXIMUM -> ");
		scanf("%d",&max);
	}while((min>max || min<0 || 10<min || max<0 || 10<max) && printf("Values must be 0<=MIN<=MAX<=10.\n"));
	
	printf("The average grade in the interval [%d,%d] is : %.1f",min,max,MO(vathm,min,max));
}

float MO(float arr[] , int A , int B){
	int i , cnt=0;
	float sum=0;
	
	for(i=0;i<50;i++){
		if(A<=arr[i] && arr[i]<=B){ //An to arr[i] einai anamesa sto A kai B.
			cnt++;
			sum+=arr[i];
		}
	}
	return sum/cnt;
}
