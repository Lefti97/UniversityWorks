
#include <stdio.h>
#include <string.h>
#define sLen 8

void straight_insert_string(char *p, int n);
void straight_insert_int(int *s, int n);

int main(){
	char p[]= "ASORTINGEXAMPLE";
	int s[sLen]={44,55,12,42,94,18,6,67} , pLen=strlen(p);
	
	straight_insert_string(p,pLen);
	system("pause");
	straight_insert_int(s,sLen);
}

void straight_insert_string(char *p, int n){
	int i , j;
	char x;
	
	printf("String = %s\n",p);
	for(i=1; i<n;i++){
		x = p[i];
		j = i-1;
		while((x < p[j]) && (j >= 0)){
			p[j+1] = p[j];
			j--;
		}
		p[j+1] = x;
		printf("String = %s , i=%d\n",p,i);
	}
}

void straight_insert_int(int *s, int n){
	int i , j , x , o;
	
	for(o=0;o<n;o++){
		printf("%d ",s[o]);}
	printf("\n");
	for(i=1; i<n;i++){
		x = s[i];
		j = i-1;
		while((x < s[j]) && (j >= 0)){
			s[j+1] = s[j];
			j--;
		}
		s[j+1] = x;
		for(o=0;o<n;o++){
			printf("%d ",s[o]);}
		printf(", i=%d\n",i);
	}
}
