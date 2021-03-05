
#include "myStack.h"

int main(){
	system("chcp 1253");
	int top=-1, sta[N] , temp ,i , optor=0;
	char c;
	
	printf("���� ���� ��������� �� ���� ���������.\n");//Dose enan xaraktira se kathe epanalipsi.
	while(1){
		optor=0;//Me aftin tin metavliti elegxoume an tha dothi telestis. Stin sinexeia to xreiazomaste gia na doume an vreikame to apotelesma.
		c = getchar();
		getchar(); // "Aporrofa" to \n pou dimiourgei to proigoumeno getchar. Xwris afto, to loop den zitaei kathe fora apo ton xrhsth na grapsei.
		
		if(isdigit(c)){
			push(sta,&top,c-48);
			printf("��������� : %c\n",c); //Telesteos :
		}
		else{
			if(c == '+'){
				temp = pop(sta,&top);// To pop epistrefi tin timi pou HTAN sto top kai to diwxni apo tin stoiva.
				temp += pop(sta,&top);//Edw ginetai i praksi me ton proigoumeno kai torino top diwxnete kai o allos top.
				push(sta,&top,temp);//To proigoumeno apotelesma prosthetete stin stoiva.
				printf("�������� : %c\n",c);//Telestis :
				optor=1;
			}
			else if(c == '-'){//Paromoios me to proigoumeno
				temp = pop(sta,&top);
				temp = pop(sta,&top) - temp;
				push(sta,&top,temp);
				printf("�������� : %c\n",c);//Telestis :
				optor=1;
			}
			else if(c == '*'){//Paromoios me to proigoumeno
				temp = pop(sta,&top);
				temp *= pop(sta,&top);
				push(sta,&top,temp);
				printf("�������� : %c\n",c);//Telestis :
				optor=1;
			}
			else if(c == '/'){//Paromoios me to proigoumeno kai ginete elegxos gia diairesi me 0
				if(sta[top]!=0){
					temp = pop(sta,&top);
					temp = pop(sta,&top) / temp;
					push(sta,&top,temp);
					optor=1;
				}
				else printf("��� ������� �� ���������� �� �� 0.\n");//Den mporeis na diaireseis me to 0.
				printf("�������� : %c\n",c);//Telestis :
			}
			else{
				printf("������. ��������� ������� , 0 ��� 9 , + , - , * , / \n");//SFALMA. Apodektoi eisodoi , 0 ews 9 , + , - , * , /
				//An meta apo sfalma proklithei provlima me tin enarksei timwn , paikste me to ENTER.
			}
		}
		
		for(i=top;i>=0;i--){//Tupwnetai olh i stoiva.
			printf("\t������[%d] = %d\n",i,sta[i]);//Stoiva[] =
		}
		
		if(top==0 && optor==1){//Elegxoume an eimaste sto teleftaio stoixeio tis stoivas kai an hrthame apo praksi.
			printf("�����?? ����� � �� ��� , ���� �� ���.\n"); //TELOS?? Grapse N an Nai , allo an oxi.
			c = getchar();
			if(c == 'n'|| c == 'N'){
				printf("���������� = %d\n",sta[top]);//APOTELESMA = %d
				break;
			}
			getchar();
			printf("��������\n");//SYNEXEIA
			printf("\t������[%d] = %d\n",top,sta[top]);
		}
	}
}
