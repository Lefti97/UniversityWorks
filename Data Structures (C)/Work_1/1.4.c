
#include <stdio.h>

int func(int arr[] , int arrSz);

int main(){
	int i , pin[10];
	
	printf("Type 10 numbers.\n");
	for(i=0;i<10;i++){
		scanf("%d",&pin[i]);
	}
	system("pause");
	printf("Appearances of the number that is included most times. : %d\n",func(pin,10));
}

int func(int arr[], int szArr){
	int i,j, curCn , maxCn=0;
	
	for(i=0;i<szArr;i++){
		curCn = 1;
		for(j=i+1;j<szArr;j++){
			if(arr[i] == arr[j])
				curCn++;
		}
		if(curCn > maxCn)
			maxCn = curCn;
	}
	return maxCn;
}
