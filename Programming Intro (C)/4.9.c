#include <stdio.h>

 void towers(int num, char A, char C, char B)
{
    if (num == 1){
        printf("\n Disk 1 : %c --> %c", A, C);
        return;
    }
    
    towers(num - 1, A, B, C);
    printf("\n Disk %d : %c --> %c", num, A, C);
    towers(num - 1, B, C, A);
}

int main()
{
    int num;
 
    printf("Type number of disks : ");
    scanf("%d", &num);
    
    printf("The moves needed to complete Tower of Hanoi are :\n");
    towers(num, 'A', 'C', 'B');
}
