#ifndef Student_h
#define Student_h

#include <iostream>
#include <string.h>
#include <string>
//#include "Lesson.h"

class Student
{
    char *id;
    std::string fullName;
    unsigned int curSemester;
    unsigned int passedLessons;
    float *passedGrades;
    unsigned int declaredLessonsNum;
    class Lesson *declaredLessons;

public:
    // CONSTRUCTORS
    Student(const char *idF="-", std::string fullNameF="-", unsigned int curSemesterF=1, 
    unsigned int passedLessonsF=0, const float *passedGradesF=nullptr, 
    unsigned int declaredLessonsNumF=0, Lesson *declaredLessonsF=nullptr);
    Student(const Student &);

    // FUNCTIONS
    void addPassed(unsigned int);
    void printStudentInfo(std::ostream &);
    void printGradeDetails(std::ostream &);
    void printDeclaredLessons(std::ostream &);

    // GETTERS/SETTERS FUNCTIONS
    void setId(const char *);
    char* getId(){return id;}
    void setFullName(std::string fullNameF){fullName = fullNameF;}
    std::string getFullName(){return fullName;}
    void setCurSemester(unsigned int curSemesterF){curSemester = curSemesterF;}
    unsigned int getCurSemester(){return curSemester;}
    void setPassedLessons(unsigned int);
    unsigned int getPassedLessons(){return passedLessons;}
    void setPassedGrades(const float *);
    float* getPassedGrades(){return passedGrades;}
    void setDeclaredLessonsNum(unsigned int);
    unsigned int getDeclaredLessonsNum(){return declaredLessonsNum;}
    void setDeclaredLessons(Lesson *);
    Lesson* getDeclaredLessons(){return declaredLessons;}

    // Operator Overload
    Student& operator= (const Student &stu);
    void operator+= (const Lesson &l);
    bool operator== (const Student &stu);
    bool operator!= (const Student &stu);
    bool operator< (const Student &stu);
    bool operator<= (const Student &stu);
    bool operator> (const Student &stu);
    bool operator>= (const Student &stu);
};



class Lesson{
    std::string l_id;
    std::string l_name;
    unsigned int l_semester;
public:
    Lesson(std::string id="-", std::string name="-", unsigned int semester=0){
        l_id = id;
        l_name = name;
        l_semester = semester;
    }

    Lesson operator= (const Lesson &l){
        l_id        = l.l_id;
        l_name      = l.l_name;
        l_semester  = l.l_semester;
        return *this;
    }

    std::string getId(){return l_id;}
    std::string getName(){return l_name;}
    unsigned int getSemester(){return l_semester;}
    void setId(std::string id){l_id = id;}
    void setName(std::string name){l_name = name;}
    void setSemester(unsigned int semester){l_semester = semester;}
};

#endif