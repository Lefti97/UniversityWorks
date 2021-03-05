
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{
	char str1[13],str2[13],strEv[7];
	int len1,len2 , i , j=0;
	
	//Upoerwtima A
	// max 12 epeidh to 13o stoixeio tha einai to NULL an grapsei 12 grammata.
	printf("Type two strings with MIN 4 and MAX 12 letters.\n"); 
	while(1)
	{
		scanf("%s",str1);
		scanf("%s",str2);
		len1 = strlen(str1);
		len2 = strlen(str2);
		if(len1 < 4 || 12 < len1 || len2 < 4 || 12 < len2)
			printf("TYPE AGAIN.\n");
		else
			break;
	}

	//Upoerwtima B
	for(i=1;i<5;i++){
		if(str1[len1-i] != str2[len2-i]){
			printf("The last 4 letters of the two strings are not the same.\n");
			break;
		}
		else if((str1[len1-i] == str2[len2-i]) && i==4)
			printf("The last 4 letters of the two strings are the same.\n");
	}
	
	//Upoerwtima G
	/* Theoro tin artia thesi me vasi tin "pragmatiki" thesi kai oxi me ta index tou pinaka.
	Diladi stin "pragmatiki" thesi 2 to index einai str1[1].. thesi 4 , str1[3] .. thesi n , str1[n-1]
	An ennousate tin artia thesi me vasi ta index tou pinaka tha xreiastoun allages ston kwdika. */
	for(i=1;i<len1;i=i+2){
		strEv[j++] = str1[i];
	}
	strEv[j] = '\0';
	printf("%s",strEv);
}
