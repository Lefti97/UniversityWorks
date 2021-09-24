#include <iostream>
#include <string.h>
#include <string>

class Student
{
    char *id;
    std::string fullName;
    unsigned int curSemester;
    unsigned int passedLessons;
    float *passedGrades;

public:
    // CONSTRUCTORS
    Student(const char *, std::string, unsigned int, 
        unsigned int, const float *);
    Student(const Student &);

    // FUNCTIONS
    void addPassed(unsigned int);
    void printStudentInfo(std::ostream &);
    void printGradeDetails(std::ostream &);

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
};


// Κατασκευαστής με default παραμέτρους.
Student::Student(const char *idF, std::string fullNameF,
    unsigned int curSemesterF=1, unsigned int passedLessonsF=0,
    const float *passedGradesF=nullptr)
{
    // Δεσμεύουμαι τον id με χώρο όσο το μέθεθος του idF string.
    id = new char [strlen(idF)];
    strcpy(id, idF); // Αντιγράφουμε το idF στο id.
    
    // Απλή αντιγραφή στοιχείων.
    fullName = fullNameF;
    curSemester = curSemesterF;
    passedLessons = passedLessonsF;

    // Δεσμεύουμαι τον passedGrades με χώρο όσο ο αριθμός περασμένων μαθημάτων.
    passedGrades = new float[passedLessons];
    // Αντιγράφουμε τα περιεχόμενα του πίνακα passedGradesF στον passedGrades.
    // Μόνο στην περίπτωση που ο πίνακας passedGradesF είναι δεσμευμένος.
    if(passedGradesF)
        for(int i=0; i<passedLessons;i++)
            passedGrades[i] = passedGradesF[i];
}


// Κατασκευαστής ανιγραφής Student.
// Λειτουργεί με τον ίδιο τρόπο όπως τον από πάνω κατασκευαστή, μόνο που
// αντιγράφει όλα τα χαρακτηριστικά του Student που θα δώσουμε, αντί για
// χαρακτηριστικά που δίνουμε εμείς.
Student::Student(const Student &stu)
{
    id = new char [strlen(stu.id)];
    strcpy(id, stu.id);

    fullName = stu.fullName;
    curSemester = stu.curSemester;
    passedLessons = stu.passedLessons;

    passedGrades = new float[passedLessons];
    if(stu.passedGrades)
        for(int i=0; i<passedLessons;i++)
            passedGrades[i] = stu.passedGrades[i];
}


// Αυξάνουμε κατά ένα τον αριθμό περασμένων μαθημάτων με το setPassedLessons,
// και βάζουμε τον βαθμό που δώσαμε στην τελευταία(νέα) θέση του πίνακα.
void Student::addPassed(unsigned int grade){
    setPassedLessons(passedLessons + 1);
    passedGrades[passedLessons - 1] = grade;
}

// Παίρνουμε ως παράμετρο reference σε τύπο std::ostream (πχ std::cout)
// και τυπώνουμε id, fullName, curSemester.
void Student::printStudentInfo(std::ostream &output){
    output << "ID: " << id 
    << "\tFullname: " << fullName 
    << "\tSemester: " << curSemester << std::endl;
}

// Παίρνουμε ως παράμετρο reference σε τύπο std::ostream (πχ std::cout)
// και τυπώνουμε όλους τους βαθμούς και τον μέσο όρο αυτών.
void Student::printGradeDetails(std::ostream &output){
    float avg = 0;
    for(int i=0; i<passedLessons; i++){
        output << "Lesson " << i+1 << ": " << passedGrades[i] << std::endl;
        avg += passedGrades[i];
    }
    if(avg)
        avg = avg / passedLessons;
    output << "Average Grade : " << avg << std::endl << std::endl;
}


// Αποδεσμεύει και ξανά δεσμεύει το id με το μέγεθος
// του idF string, στην συνέχεια αντιγράφει το idF.
void Student::setId(const char *idF){
    delete[] id;
    id = new char [strlen(idF)];
    strcpy(id, idF);
}


// Αλλάζει τον αριθμό περασμένων μαθημάτων και το 
// μέγεθος του δυναμικού  πίνακα passedGrades.
void Student::setPassedLessons(unsigned int passedLessonsF){
    // Κρατάμε τα τωρινά στοιχεία του passedGrades στο tmp.
    float *tmp = new float[passedLessons]; 
    if(passedGrades)
        for(int i=0; i<passedLessons;i++)
            tmp[i] = passedGrades[i];
    // Αποδεσμεύουμαι και ξανα δεσμεύουμε τον πίνακα με το νέο μέγεθος.
    delete[] passedGrades;
    passedGrades = new float[passedLessonsF];
    // Επιστρέφουμε τις προηγούμενες τιμές στον πίνακα.
    setPassedGrades(tmp);
    passedLessons = passedLessonsF;
    delete[] tmp;
}


// Κάνει επαναλήψεις όσες ο αριθμός περασμένων μαθημάτων, 
// και αντιγράφει τον πίνακα που έχει δοθεί.
void Student::setPassedGrades(const float *passedGradesF){
    for(int i=0; i<passedLessons; i++)
        passedGrades[i] = passedGradesF[i];
}




int main(){
    float a[6] = {5, 6, 8, 9, 10, 6};

    Student stu1("123456789", "Marina");
    Student stu2("987654321", "Giorgos", 3);
    Student stu3("18390008", "Lefteris", 5, 6, a);
    Student stu4(stu3);

    stu1.printStudentInfo(std::cout);
    stu1.printGradeDetails(std::cout);
    stu2.printStudentInfo(std::cout);
    stu2.printGradeDetails(std::cout);
    stu3.printStudentInfo(std::cout);
    stu3.printGradeDetails(std::cout);
    stu4.printStudentInfo(std::cout);
    stu4.printGradeDetails(std::cout);

    std::cout << "=========================" << std::endl;

    stu1.addPassed(7);
    stu1.setCurSemester(stu2.getCurSemester());
    stu1.setId("55555");
    stu2.addPassed(5);
    stu2.setPassedLessons(stu4.getPassedLessons());
    stu2.setPassedGrades(stu4.getPassedGrades());
    stu3.addPassed(10);
    stu4.setFullName(stu1.getFullName());
    stu4.setPassedLessons(0);

    stu1.printStudentInfo(std::cout);
    stu1.printGradeDetails(std::cout);
    stu2.printStudentInfo(std::cout);
    stu2.printGradeDetails(std::cout);
    stu3.printStudentInfo(std::cout);
    stu3.printGradeDetails(std::cout);
    stu4.printStudentInfo(std::cout);
    stu4.printGradeDetails(std::cout);
}