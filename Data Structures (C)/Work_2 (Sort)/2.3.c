
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void straight_insert_int(int *s, int n);
void quicksort_int(int left,int right,int *s);

int main(){
	FILE *fp;
	int j, i, *p,*pIn , pSize=200000 , t;
	double time_taken;
	
	pIn = (int *) malloc(pSize * sizeof(int));
	p = (int *) malloc(pSize * sizeof(int));
	srand(time(NULL));
	
	fp=fopen("results.txt","w");
	
	for(j=0;j<100;j++){
		for(i=0;i<pSize;i++){
			pIn[i]=rand();
			p[i]=pIn[i];
		}
		
		t=clock();
		straight_insert_int(p,pSize);
		t=clock() - t;
		time_taken = ((double)t)*1000/CLOCKS_PER_SEC;
		fprintf(fp,"%ld\t",(int)time_taken);
		
		for(i=0;i<pSize;i++)
			p[i]=pIn[i];
			
		t=clock();
		quicksort_int(0,pSize-1,p);
		t=clock() - t;
		time_taken = ((double)t)*1000/CLOCKS_PER_SEC;
		fprintf(fp,"%ld\n",(int)time_taken);
		
	}
	fclose(fp);
}

void straight_insert_int(int *s, int n){
	int i , j , x , o;
	
	for(i=1; i<n;i++){
		x = s[i];
		j = i-1;
		while((x < s[j]) && (j >= 0)){
			s[j+1] = s[j];
			j--;
		}
		s[j+1] = x;
	}
}

void quicksort_int(int left,int right,int *s){
	int i,j,temp,mid,k,x;
	
	if(left<right){
		i=left;
		j=right;
		mid=(left+right)/2;
		x=s[mid];
		while(i<j){
			while(s[i]<x) i++;
			while(s[j]>x) j--;
			if(i<j){
				if(s[i]==s[j]){
					if(i<mid) i++;
					if(j>mid) j--;
				}
				else{
					temp=s[i];
					s[i]=s[j];
					s[j]=temp;
				}
			}
		}
		quicksort_int(left,j-1,s);
		quicksort_int(j+1,right,s);
	}
}
