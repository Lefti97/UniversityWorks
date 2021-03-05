#include <stdio.h>
#include <stdlib.h>
#include <time.h>


int typeCheck(int min , int max)
{
	int x;
	
	while(1){
		scanf("%d",&x);
		if(min<=x && x<=max){
				break;
			}
		printf("TYPE AGAIN. Value must be between %d and %d.\n",min,max);
	}
	return x;
}

int main()
{
	int i , j , count;
	int B[50][100]={} , k , m , n;
		


	printf("Type dimensions of a rectangular space (MAX 50 x 100) : \n");
	printf("Dimension 1 : ");
	m = typeCheck(1,50);
	printf("Dimension 2 : ");
	n = typeCheck(1,100);
	printf("Type number of bombs (MAX %d) : ",n*m);
	k = typeCheck(0,n*m);
	
	
	time_t t;
	srand((unsigned) time(&t));
	
	count=0;
	while(count<k){
		for(i=0;i<=m-1;i++){
			for(j=0;j<=n-1;j++){
				if(count<k && rand() % 1000 == 0 && B[i][j] == 0){
					B[i][j] = -1;
					count++;
				}
			}
		}
	}
	
	count=-1;
	for(i=0;i<=m-1;i++){
		for(j=0;j<=n-1;j++){
			if(B[i][j] == 0){
				if(B[i-1][j-1] == -1)
					++count;
				if(B[i-1][j] == -1)
					++count;
				if(B[i-1][j+1] == -1)
					++count;
				if(B[i][j-1] == -1)
					++count;
				if(B[i][j+1] == -1)
					++count;
				if(B[i+1][j-1] == -1)
					++count;
				if(B[i+1][j] == -1)
					++count;
				if(B[i+1][j+1] == -1)
					++count;
				B[i][j] = count;
				count = 0;
			}
		}
	}
	
	for(i=1;i<=n;i++){
		printf("__");
		if(i==n)
			printf("\n");
	}
	
	for(i=0;i<=m-1;i++){
		for(j=0;j<=n;j++){
			if(j==n)
				printf("\n");
			else if(0<=B[i][j] && B[i][j] <= 8)
				printf("%d|",B[i][j]);
			else if(B[i][j] == -1)
				printf("x|");
		}
	}
}
