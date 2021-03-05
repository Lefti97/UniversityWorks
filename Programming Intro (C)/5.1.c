#include <stdio.h>

int termX (int arr[] , int X1 , int X2)
{
	int i , countX;
	countX = 0;
	
	for(i=0; i<=4; i++)
		if(arr[i] % 2 == 0)
			++countX;
	
	if(X1<=countX && countX<=X2)
		return 1;
	else
		return 0;
}

int termY(int arr[] , int Y1 , int Y2)
{
	int i , sumY;
	sumY = 0;
	
	for(i=0; i<=4; i++)
		sumY += arr[i];
	
	if(Y1<=sumY && sumY<=Y2)
		return 1;
	else
		return 0;
}

int main()
{
	int i , o, p, u, y , temp , te[4];
	int N[45] , maxN , X1 , X2 , Y1 , Y2;
	int sum5 , sumNX , sumNOY , sumTYP;
	float freq[45]={};
	
	sum5 = 0; sumNX = 0; sumNOY = 0; sumTYP = 0;


	printf("Type 5 to 45 integers in the interval [1..45].\n");
	printf("After the 4th integer type 0 if you dont want to type any more numbers\n");
	for(i=0; i<=44; i++){
		printf("%d ->",i+1);
		scanf("%d",&N[i]);
		if(i==44){
			printf("END OF NUMBERS\n");
			maxN = i;
			break;
		}
		else if((i>4 && N[i] == 0) || i==44){
			printf("END OF NUMBERS\n\n");
			maxN = i-1;
			break;
		}
		else if(N[i]<1 || 45<N[i]){
			while(1){
				printf(" WRONG .TYPE AGAIN\n");
				printf("%d->",i+1);
				scanf("%d",&N[i]);
				if(1<=N[i] && N[i]<=45)
					break;
			}
		}
	}
	
	printf("THE LIST OF NUMBERS WILL BE SORTED IN ASCENDING ORDER\n");
	printf("NEW LIST :\n");
	for (i = 0; i <= maxN; ++i){
    	for (o = i + 1; o <= maxN; ++o){
            if (N[i] > N[o]){
                temp =  N[i];
                N[i] = N[o];
                N[o] = temp;
            }
        }
    }
    
    for(i=0; i<=maxN;i++)
    	printf("%d-> %d\n",i+1,N[i]);
    
	printf("\nType two integers X in the interval [0..5]\n");
	while(1){
		scanf("%d %d",&X1 , &X2);
		if((0 <= X1 && X1 <= 5) && (0 <= X2 && X2 <= 5) ){
			if(X1 > X2){
				temp = X1;
				X1 = X2;
				X2 = temp;
			}
			printf("X1 = %d \nX2 = %d\n",X1,X2);
			break;
		}
		printf("TYPE AGAIN. Integers are out of interval\n");
	}
	
	printf("\nType two integers Y in the interval [15..215]\n");
	while(1){
		scanf("%d %d",&Y1 , &Y2);
		if((15 <= Y1 && Y1 <= 215) && (15 <= Y2 && Y2 <= 215) ){
			if(Y1 > Y2){
				temp = Y1;
				Y1 = Y2;
				Y2 = temp;
			}
			printf("Y1 = %d \nY2 = %d\n\n",Y1,Y2);
			break;
		}
		printf("TYPE AGAIN. Integers are out of interval\n");
	}

	for(i=0;i<=maxN-4; i++){
		for(o=i+1;o<=maxN-3;o++){
			for(p=o+1;p<=maxN-2;p++){
				for(u=p+1;u<=maxN-1;u++){
					for(y=u+1;y<=maxN;y++){
						te[0] = N[i];
						te[1] = N[o];
						te[2] = N[p];
						te[3] = N[u];
						te[4] = N[y];											
						++sum5;
						if(termX(te,X1,X2) == 0)
							++sumNX;
						else if(termY(te,Y1,Y2) == 0)
							++sumNOY;
						else if(termX(te,X1,X2) == 1 && termY(te,Y1,Y2) == 1){
								printf("%d %d %d %d %d\n",N[i],N[o],N[p],N[u],N[y]);
								++sumTYP;
								++freq[i]; ++freq[o]; ++freq[p]; ++freq[u]; ++freq[y];
							}
					}
				}
			}
		}
	}
	
	printf("\nThe number of combinations of the numbers you gave per 5 : %d\n",sum5);
	printf("The number of combinations that didnt meet the first term : %d\n",sumNX);
	printf("The number of combinations that didnt meet , only the second term : %d\n", sumNOY);
	printf("The number of combinations that got typed : %d\n",sumTYP);
	printf("The frequency of appearance of every number on the list to the total of the shown combinations :\n");
	for(i=0;i<=maxN;i++)
		printf("%d-> Num : %d Freq : %.2f\n",i+1,N[i],freq[i]/sumTYP);
}
