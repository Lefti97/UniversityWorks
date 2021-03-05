#include <stdio.h>

float power(float a , int b)
{
	int i;
	float x;
	x=1;
	for(i=1;i<=b;i++)
		x = x * a;
	return x;
}

int eisGwn()
{
	int deg;
	scanf("%d", &deg);
	return deg;
}

float rad(int degrees)
{
	float pi, radians;
	pi = 3.14159265359;
	radians = degrees*(pi/180);
	return radians;
}

float sine(float x)
{
	float apot;
	apot = x - (power(x,3)/6) + (power(x,5)/120) - (power(x,7)/5040) + (power(x,9)/362880);
	return apot;
	//Results above 180 degrees are false
}

float cosine(float x)
{
	float apot;
	apot = 1 - (power(x,2)/2) + (power(x,4)/24) - (power(x,6)/720) + (power(x,8)/40320);
	return apot;
	//Results above 180 degrees are false
}

int comp(float a , float b)
{
	int apot;
	float sum;
	
	sum = a-b;
	if (-0.2<sum && sum<0.2)
		apot = 1;
	else
		apot = 0;
	return apot;
}

int main()
{
	int moires,sigkr;
	float aktinia,_sin,_cos;
	
	printf("Give angle degrees : ");
	moires = eisGwn();
	
	aktinia = rad(moires);
	printf("Angle in radians : %.2f\n", aktinia);
	
	_sin = sine(aktinia);
	printf("SINE : %.2f\n", _sin);
	
	_cos = cosine(aktinia);
	printf("COSINE : %.2f\n", _cos);
	
	sigkr = comp(_sin,_cos);
	if(sigkr == 1)
		printf("The values are almost equal.\n");
	else
		printf("The values are far apart.\n");
}
