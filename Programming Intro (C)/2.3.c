#include <stdio.h>
#include <math.h>

int main()
{
	int a,b,c; //Factors
	float dia,r1,r2; //Discriminant and roots
	
	a = 0;
	printf("Give the factors of a quadratic equation ax^2 + bx + c .\n");

	while (a == 0){
		printf("Factor A : ");
		scanf("%d", &a);
	 	if(a == 0){
	 		printf("Factor A cannot be 0.\n");	
	 	}
	}
	printf("Factor B : ");
	scanf("%d",&b);
	printf("Factor C : ");
	scanf("%d",&c);
	printf("The equation is : %dx^2 + %dx + %d \n", a , b , c);
	
	printf("We find the discriminant of the equation from the formula B^2-4*A*C.\n");
	dia = b*b-4*a*c;
	printf("%d^2-4*%d*%d\n",b,b,a,c);
	printf("Discriminant : %.2f\n", dia);
	
	if (dia > 0){
		printf("D > 0 therefore we can find two roots from the formulas : \n");
		printf("(-B + sqrt(Diakr)/2a ) and (-B - sqrt(Diakr)/2a)\n");
		r1 = (-b + sqrt(dia))/2*a;
		r2 = (-b - sqrt(dia))/2*a;
		printf("Root 1 : %.2f\n",r1);
		printf("Root 2 : %.2f\n",r2);
	}
	else if (dia == 0){
		printf("D = 0 therefore we can find one root from the formula : (-b/(2*a)\n");
		r1 = -b/(2*a);
		printf("Root : %.2f\n",r1);
	}
	else
		printf("D< 0 therefore the equation has 2 imaginary roots");
}
