#include <stdio.h>

int power(int a , int b)
{
	int x,i;
	x=1;
	for(i=1;i<=b;i++)
		x = x * a;
	return x;
}

int factorial(int n)
{
	int x,i;
	x=1;
	for(i=1; i<=n; i++)
		x = x * i;
	return x;
}

int combinations(int a , int b)
{
	int x;
	x = factorial(a)/(factorial(b)*factorial(a-b));
	return x;
}

int main()
{
	int A , B , x , count , ch;
	
	count = 0 ;
	
	printf("Give integer A : ");
	scanf("%d",&A);
	printf("Give integer B : ");
	scanf("%d",&B);
	
	printf("\nCHOOSE TYPE OF CALCULATION FROM THE MENU BELOW\n");
	printf("----------------------------------------------\n");
	printf("(Type the number next to the options to choose)\n");
	printf("\n1.A to the power of B\n2.Factorial of A and B\n3.Combinations of A per B\n0.EXIT\n");
	
	while(1){
		scanf("%d",&ch);
		if(ch == 0){
			printf("You exited.\nYou made %d choices.",count);
			break;
		}
		else if(ch == 1){
			x = power(A,B);
			printf("	A^B = %d\n",x);
			count += 1;
		}
		else if(ch == 2){
			x = factorial(A);
			printf("	A! = %d\n", x);
			x = factorial(B);
			printf("	B! = %d\n", x);
			count += 1;
		}
		else if(ch == 3){
			x = combinations(A,B);
			printf("	Combs A per B = %d\n", x);
			count += 1;
		}
		else
			printf("^--Number of option does not exist\n");
	}
}
