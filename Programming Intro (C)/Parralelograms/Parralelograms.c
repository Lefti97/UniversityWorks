#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct POINT{
	float x,y;
};

struct RECTANGLE{
	char color[6];
	struct POINT PA;
	struct POINT KD;
};

//Function Declerations
float MAX(float flt1,float flt2);
float MIN(float flt1,float flt2);
int intersection(struct RECTANGLE *rect1, struct RECTANGLE *rect2);
int max_area(struct RECTANGLE arr[], int arrSize, char *color);
int max_per(struct RECTANGLE arr[], int arrSize, char *color);

int main()
{
	struct RECTANGLE *rect;
	struct RECTANGLE interRect;
	FILE *fp;
	int N , i , j , temp;
	char colInp[6], actInp[5];
	
	fp = fopen("data.txt" , "r");
	fscanf(fp , "%*s %d" , &N);
	rect = (struct RECTANGLE*) malloc(N * sizeof(struct RECTANGLE)); 
	for(i=0;i<N;i++){
		fscanf(fp,"%f %f %f %f %s", &rect[i].PA.x, &rect[i].PA.y, &rect[i].KD.x, &rect[i].KD.y,&rect[i].color);
	}
	fclose(fp);
	
	while(1)
	{	
		printf("\nTYPE 'STOP' ANYTIME TO EXIT PROGRAM.\n");
		printf("Choose the color of the rectangles to be used : \n1.RED\n2.GREEN\n3.BLUE\n");
		scanf("%s",colInp);
		if(strcmp(colInp,"STOP")==0)
			break;
		else if(strcmp(colInp,"1")==0){
			strcpy(colInp,"red");
			i=1;
		}
		else if(strcmp(colInp,"2")==0){
			strcpy(colInp,"green");
			i=1;
		}
		else if(strcmp(colInp,"3")==0){
			strcpy(colInp,"blue");
			i=1;	
		}
		else{
			printf("\nWRONG INPUT.TYPE AGAIN.");
			i=0;
		}
		
		if(i==1)
		{
			printf("Choose action for the rectangles : \n1.INTERSECTION\n2.MAX AREA\n3.MAX PERIMETER\n");
			scanf("%s",actInp);
			if(strcmp(actInp,"STOP")==0)
				break;
			else if(strcmp(actInp,"1")==0)
			{
				for(i=0;i<N;i++)
				{
					if(strcmp(rect[i].color,colInp)==0) //Searches for the first element in the array that has the color that was given by the user.
					{
						interRect = rect[i]; //The struct that holds the intersection is initialized with that first element.
						for(j=i+1;j<N;j++) //This for loop starts from the next number of the initialization's index.
						{
							if(j==i+1)
								i=N+1;//This statement makes sure that once this for loop ends the previous one wont continue.
							if(strcmp(rect[j].color,colInp)==0)//Searches for the next element in the array that has the color that was given by the user.
							{
								if(intersection(&interRect,&rect[j]) == 0) //The intersection function is called here. And checks if it returns 1 or 0.
									break;
							}
						}
					}
				}
				printf("Coordinations of the Intersection:\nUpper Left.X: %.2f\nUpper Left.Y: %.2f\nLower Right.X: %.2f\nLower Right.Y: %.2f\n",interRect.PA.x,interRect.PA.y,interRect.KD.x,interRect.KD.y);
			}
			else if(strcmp(actInp,"2")==0){
				printf("%s\n","MAX AREA");
				temp = max_area(rect,N,colInp);//Index of element of the array that has largest area.
				if(temp == -1)
					printf("Color doesnt exist in file.\n");
				else
					printf("Largest area of the rectangles is : %.2f\n",(rect[temp].PA.y - rect[temp].KD.y)*(rect[temp].KD.x - rect[temp].PA.x));
			}
			else if(strcmp(actInp,"3")==0){
				printf("%s\n","MAX PERIMETER");
				temp = max_per(rect,N,colInp);//Index of element of the array that has largest perimeter.
				if(temp == -1)
					printf("Color doesnt exist in file.\n");
				else
					printf("Largest perimeter of the rectangles is : %.2f\n",((rect[temp].PA.y - rect[temp].KD.y)*2)+((rect[temp].KD.x - rect[temp].PA.x)*2));
			}
			else
				printf("WRONG INPUT.TYPE AGAIN.\n");
		}
		printf("\n");
	}
	
}

float MAX(float flt1,float flt2)// Returns largest float.
{
	if(flt1 > flt2)
		return flt1;
	else
		return flt2;
}

float MIN(float flt1,float flt2)// Returns smalles float.
{
	if(flt1 < flt2)
		return flt1;
	else
		return flt2;
}

int intersection(struct RECTANGLE *rect1, struct RECTANGLE *rect2)
{
	int temp=0;
	
	if(((*rect1).PA.x <= (*rect2).PA.x && (*rect2).PA.x <= (*rect1).KD.x) || ((*rect1).PA.x <= (*rect2).KD.x && (*rect2).KD.x <= (*rect1).KD.x))//IF(x1<=x1'<=x2 || x1<=x2'<=x2)
		++temp;
	else if(((*rect2).PA.x <= (*rect1).PA.x && (*rect1).PA.x <= (*rect2).KD.x) || ((*rect2).PA.x <= (*rect1).KD.x && (*rect1).KD.x <= (*rect2).KD.x))//IF(x1'<=x1<=x2' || x1'<=x2<=x2')
		++temp;
	if(((*rect1).KD.y <= (*rect2).KD.y && (*rect2).KD.y <= (*rect1).PA.y) || ((*rect1).KD.y <= (*rect2).PA.y && (*rect2).PA.y <= (*rect1).PA.y))//IF(y2<=y2'<=y1 || y2<=y1'<=y1)
		++temp;
	else if(((*rect2).KD.y <= (*rect1).KD.y && (*rect1).KD.y <= (*rect2).PA.y) || ((*rect2).KD.y <= (*rect1).PA.y && (*rect1).PA.y <= (*rect2).PA.y))//IF(y2'<=y2<=y1' || y2'<=y1<=y1')
		++temp;
	
	if(temp==0 || temp == 1) //Makes intersection PA and KD (0,0)
	{
		if(temp == 0)
			printf("The parallelograms dont intersect.\n");
		else if(temp == 1)
			printf("The parallelograms intersect on one plane only.Thus the parralelograms dont intersect.\n");
		(*rect1).PA.x = 0; 
		(*rect1).PA.y = 0;
		(*rect1).KD.x = 0; 
		(*rect1).KD.y = 0;
		return 0;
	}
	else if(temp == 2) // Gives the intersection of the two rectangles.
	{
		(*rect1).PA.x = MAX((*rect1).PA.x , (*rect2).PA.x); 
		(*rect1).PA.y = MIN((*rect1).PA.y , (*rect2).PA.y);
		(*rect1).KD.x = MIN((*rect1).KD.x , (*rect2).KD.x); 
		(*rect1).KD.y = MAX((*rect1).KD.y , (*rect2).KD.y);
		return 1;
	}
	else
		printf("ERROR in intersection function.\n");
}

int max_area(struct RECTANGLE arr[], int arrSize, char *color)
{
	int i , j , indMax = -1;
	
	for(i=0;i<arrSize;i++)
	{
		if(strcmp(arr[i].color,color)==0)
		{
			indMax=i;
			for(j=i+1;j<arrSize;j++)
			{
				if(j==i+1)
					i = arrSize + 1;
				if(strcmp(arr[j].color,color)==0)
				{
					if(((arr[j].PA.y - arr[j].KD.y)*(arr[j].KD.x - arr[j].PA.x)) >= ((arr[indMax].PA.y - arr[indMax].KD.y)*(arr[indMax].KD.x - arr[indMax].PA.x)))
						indMax = j;
				}
			}
		}
	}
	return indMax;
}

int max_per(struct RECTANGLE arr[], int arrSize, char *color)
{
	int i , j , indMax = -1;
	
	for(i=0;i<arrSize;i++)
	{
		if(strcmp(arr[i].color,color)==0)
		{
			indMax=i;
			for(j=i+1;j<arrSize;j++)
			{
				if(j==i+1)
					i = arrSize + 1;
				if(strcmp(arr[j].color,color)==0)
				{
					if(((arr[j].PA.y - arr[j].KD.y)*2)+((arr[j].KD.x - arr[j].PA.x)*2) >= ((arr[indMax].PA.y - arr[indMax].KD.y)*2)+((arr[indMax].KD.x - arr[indMax].PA.x)*2))
						indMax = j;
				}
			}
		}
	}
	return indMax;
}

