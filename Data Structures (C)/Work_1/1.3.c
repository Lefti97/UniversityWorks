
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int strFunc(char str1[],char str2[]);

int main()
{
	char strn1[100],strn2[100];
	
	printf("Type two strings with MAX 100 chars.\n");
	scanf("%s",strn1);
	scanf("%s",strn2);
	
	printf("Is the 2nd string contained in the end of the 1st string?\n");
	if(strFunc(strn1,strn2)==1)
		printf("YES.\n");
	else if(strFunc(strn1,strn2)==0)
		printf("NO.\n");
}

int strFunc(char str1[],char str2[])
{
	int i,cnt=0,len1=strlen(str1),len2=strlen(str2);
	
	for(i=1;i<=len2;i++){
		if(str1[len1-i] == str2[len2-i])
			cnt++;
	}
	if(cnt == len2)
		return 1;
	else
		return 0;
}
