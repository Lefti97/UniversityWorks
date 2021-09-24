#include <iostream>

void power(int &num, int pow);
int &power2(int num);
void multiply(int a=0, int b=1, int c=1);

int main (int argc, char **argv){

    //1. Η αλλαγή τιμής σε const integer.
    std::cout << "1. Changing const int integer."<< std::endl;
    int a = 10;
    int b = 17;
    const int *ptr1 = &a;
    std::cout << "Const int first value = " << *ptr1 << std::endl;
    ptr1 = &b;
    std::cout << "Const int second value = " << *ptr1 << std::endl;
    std::cout << std::endl;


    //2. H χρήση των τελεστών new, new[], delete και delete[].
    std::cout << "2. Dynamic Memory Allocation." << std::endl;
    int *c;
    int *d;

    std::cout << "Memory not yet allocated(garbage values)." << std::endl;
    std::cout << "*c = " << *c << std::endl;
    std::cout << "*d = " << *d << std::endl;

    c = new int(15);
    d = new int[5];
    for(int i=0; i<5; i++)
        d[i] = i;

    std::cout << "Memory allocated." << std::endl;
    std::cout << "*c = " << *c << std::endl;
    for(int i=0; i<5; i++)
        std::cout << "d["<< i <<"] = " << d[i] << std::endl;

    std::cout << std::endl;

    //3. Η χρήση της αναφοράς στις παραμέτρους και τον τύπο 
    //επιστροφής των συναρτήσεων (δύο συναρτήσεις)
    std::cout << "3a. Reference in function parameter."<< std::endl;
    int someNum = 2;
    std::cout << "someNum = "<< someNum << std::endl;
    power(someNum, 6);
    std::cout << "someNum = "<< someNum << std::endl;

    std::cout << std::endl;

    std::cout << "3b. Reference in function return."<< std::endl;
    int someNum2 = power2(5);
    std::cout << "someNum2 = "<< someNum2 << std::endl;

    std::cout << std::endl;

    //4. Τις συναρτήσεις με παραμέτρους οι οποίες έχουν default τιμές.
    std::cout << "4. Function with default parameters."<< std::endl;
    multiply();
    multiply(2);
    multiply(2,3);
    multiply(2,3,4);
}


void power(int &num, int pow){
    std::cout << num << "^" << pow << std::endl;

    int tmpNum = num;

    for(int i=1; i<pow; i++){
        num = num * tmpNum;
    }
    if(pow == 0)
        num = 1;
}


int &power2(int num){
    static int tmp = num * num;
    return tmp;
}


void multiply(int a, int b, int c){
    std::cout << a << " * " << b << " * " << c  << " = " << a*b*c << std::endl;
}
