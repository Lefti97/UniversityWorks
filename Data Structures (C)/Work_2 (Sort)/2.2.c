
#include <stdio.h>
#include <string.h>
#define sLen 8

void quicksort_string(int left,int right,char *p);
void quicksort_int(int left,int right,int *s);

int main(){
	char p[]= "ASORTINGEXAMPLE";
	int s[sLen]={44,55,12,42,94,18,6,67} , pLen=strlen(p);
	
	quicksort_string(0,pLen-1,p);
	system("pause");
	quicksort_int(0,sLen-1,s);
}

void quicksort_string(int left,int right,char *p){
	int i,j,temp,mid,k;
	char x;
	
	if(left<right){
		i=left;
		j=right;
		mid=(left+right)/2;
		printf("\nLeft=s[%d] Right=s[%d] Pivot Elem=%c\n",left,right,p[mid]);
		x=p[mid];
		while(i<j){
			while(p[i]<x) i++;
			while(p[j]>x) j--;
			if(i<j){
				if(p[i]==p[j]){
					if(i<mid) i++;
					if(j>mid) j--;
				}
				else{
					temp=p[i];
					p[i]=p[j];
					p[j]=temp;
				}
			}
		}
		printf("\tSTRING = %s\n",p);
		
		quicksort_string(left,j-1,p);
		quicksort_string(j+1,right,p);
	}
}

void quicksort_int(int left,int right,int *s){
	int i,j,temp,mid,k,x;
	
	if(left<right){
		i=left;
		j=right;
		mid=(left+right)/2;
		printf("\nLeft=s[%d] Right=s[%d] Pivot Elem=%d\n",left,right,s[mid]);
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
		for(k=0;k<(right+1);k++) printf("%d  ",s[k]);
		printf("\n");
		
		quicksort_int(left,j-1,s);
		quicksort_int(j+1,right,s);
	}
}
