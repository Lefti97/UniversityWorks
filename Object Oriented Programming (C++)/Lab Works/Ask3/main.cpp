#include <iostream>
#include "Student.h"

// Compile: g++ main.cpp Student.cpp

int main(){
    float a[2] = {5, 6};
    Lesson lessons[2] = {Lesson("432145","OOP",2), Lesson("12345","Physics",1)};

    Student stu1("123456789", "Marina", 3, 2, a);
    Student stu2("18390008", "Lefteris", 5, 2, a, 2, lessons);
    Student stu3;
    stu3 = stu1;

    stu3 += Lesson("9876", "Network Programming", 4);

    std::cout << "\nstu1" << std::endl;
    stu1.printStudentInfo(std::cout);
    stu1.printGradeDetails(std::cout);
    stu1.printDeclaredLessons(std::cout);
    std::cout << "\nstu2" << std::endl;
    stu2.printStudentInfo(std::cout);
    stu2.printGradeDetails(std::cout);
    stu2.printDeclaredLessons(std::cout);
    std::cout << "\nstu3" << std::endl;
    stu3.printStudentInfo(std::cout);
    stu3.printGradeDetails(std::cout);
    stu3.printDeclaredLessons(std::cout);

    std::cout << std::boolalpha << std::endl;
    std::cout << "(stu1 == stu2) == " << (stu1 == stu2) << std::endl;
    std::cout << "(stu1 == stu3) == " << (stu1 == stu3) << std::endl;
    std::cout << "(stu1 != stu2) == " << (stu1 != stu2) << std::endl;
    std::cout << "(stu1 != stu3) == " << (stu1 != stu3) << std::endl;
    std::cout << "(stu1 < stu2) == " << (stu1 < stu2) << std::endl;
    std::cout << "(stu1 < stu3) == " << (stu1 < stu3) << std::endl;
    std::cout << "(stu1 <= stu2) == " << (stu1 <= stu2) << std::endl;
    std::cout << "(stu1 <= stu3) == " << (stu1 <= stu3) << std::endl;
    std::cout << "(stu1 > stu2) == " << (stu1 > stu2) << std::endl;
    std::cout << "(stu1 > stu3) == " << (stu1 > stu3) << std::endl;
    std::cout << "(stu1 >= stu2) == " << (stu1 >= stu2) << std::endl;
    std::cout << "(stu1 >= stu3) == " << (stu1 >= stu3) << std::endl;
}