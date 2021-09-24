#include <iostream>
#include "Engine.h"

int main(int argc, char **argv)
{
    try{
        if(argc != 3)
            throw "Program must be called with only two file arguments.";

        Engine eng(argv[1], argv[2]);
    }
    catch(const char* str){
        std::cout << "ERROR: " << str << std::endl;
    }
}