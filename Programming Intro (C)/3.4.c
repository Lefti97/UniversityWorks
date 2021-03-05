#include <stdio.h>

int main()
{
	int lines,i,o;
	
	printf("Give number of lines : ");
	scanf("%d", &lines);
	
	for(i = 1; i <= lines; i++){
		for(o = 1; o <= i; o++)
			printf("*");
		printf("\n");
	}
	
	for(i = 1; i <= lines; i++){
		for(o = 1;o <= lines-i; o++)
			printf(" ");
		for(o = 1; o <= i; o++)
			printf("*");
		printf("\n");
	}
	
	for(i = 1; i <= lines; i++){
		for(o = 1;o <= lines-i; o++)
			printf(" ");
		for(o = 1; o <= (i*2)-1; o++)
			printf("*");
		printf("\n");
	}
	
	for(i = 1; i <= lines; i++){
		if(i == 1 || i == lines)
			printf("*****");
		else if((i%2)==0)
			printf("*. .*");
		else if((i%2)==1)
			printf("* . *");
		printf("\n");
	}
}
