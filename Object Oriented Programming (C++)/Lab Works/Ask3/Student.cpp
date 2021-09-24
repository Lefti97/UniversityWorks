#include "Student.h"

// Κατασκευαστής με default παραμέτρους.
Student::Student(const char *idF, std::string fullNameF, unsigned int curSemesterF, 
    unsigned int passedLessonsF, const float *passedGradesF, 
    unsigned int declaredLessonsNumF, Lesson *declaredLessonsF)
{
    // Δεσμεύουμαι τον id με χώρο όσο το μέθεθος του idF string.
    id = new char [strlen(idF)];
    strcpy(id, idF); // Αντιγράφουμε το idF στο id.
    
    // Απλή αντιγραφή στοιχείων.
    fullName = fullNameF;
    curSemester = curSemesterF;
    passedLessons = passedLessonsF;
    declaredLessonsNum = declaredLessonsNumF;

    // Δεσμεύουμαι τον passedGrades με χώρο όσο ο αριθμός περασμένων μαθημάτων.
    passedGrades = new float[passedLessons];
    // Αντιγράφουμε τα περιεχόμενα του πίνακα passedGradesF στον passedGrades.
    // Μόνο στην περίπτωση που ο πίνακας passedGradesF είναι δεσμευμένος.
    if(passedGradesF)
        for(int i=0; i<passedLessons;i++)
            passedGrades[i] = passedGradesF[i];

    declaredLessons = new Lesson[declaredLessonsNum];

    if(declaredLessons)
        for(int i=0; i<declaredLessonsNum; i++)
            declaredLessons[i] = declaredLessonsF[i];
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
    << "\tSemester: " << curSemester 
    << "\nPassedLessons: " << passedLessons 
    << "\tDeclaredLessons: " << declaredLessonsNum << std::endl;
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
    output << "Average Grade : " << avg << std::endl;
}

// Παίρνουμε ως παράμετρο reference σε τύπο std::ostream (πχ std::cout)
// και τυπώνουμε όλα τα δηλωμένα μαθήματα του φοιτητή.
void Student::printDeclaredLessons(std::ostream &output){
    output << "Declared Lessons" << std::endl;
    for(int i=0; i<declaredLessonsNum; i++)
        output << declaredLessons[i].getId() << '\t'
        << declaredLessons[i].getName() << '\t'
        << declaredLessons[i].getSemester() << std::endl;
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


// Αλλάζει τον αριθμό δηλωμένων μαθημάτων και το 
// μέγεθος του δυναμικού  πίνακα declaredLessons.
void Student::setDeclaredLessonsNum(unsigned int newNum){
    Lesson *tmp = new Lesson[declaredLessonsNum];

    if(declaredLessons)
        for(int i=0; i<declaredLessonsNum; i++)
            tmp[i] = declaredLessons[i];
    delete[] declaredLessons;
    declaredLessons = new Lesson[newNum];
    setDeclaredLessons(tmp);
    declaredLessonsNum = newNum;
    delete[] tmp;
}

// Κάνει επαναλήψεις όσες ο αριθμός περασμένων μαθημάτων, 
// και αντιγράφει τον πίνακα που έχει δοθεί.
void Student::setDeclaredLessons(Lesson *declaredLessonsF){
    for(int i=0; i<declaredLessonsNum; i++)
        declaredLessons[i] = declaredLessonsF[i];
}


// Υπερφόρτωση τελεστή εκχώρησεις. Αντιγραφή Student.
Student& Student::operator= (const Student &stu){
    strcpy(id, stu.id);
    fullName = stu.fullName;
    curSemester = stu.curSemester;
    setPassedLessons(stu.passedLessons);
    setPassedGrades(stu.passedGrades);
    setDeclaredLessonsNum(stu.declaredLessonsNum);
    setDeclaredLessons(stu.declaredLessons);
    return *this;
}


// Υπερφόρτωση τελεστή += ώστε να προσθέτει ένα 
// μάθημα στον πίνακα δηλωμένων μαθημάτων.
void Student::operator+= (const Lesson &l){
    setDeclaredLessonsNum(declaredLessonsNum + 1);
    declaredLessons[declaredLessonsNum - 1] = l;
}


// Υπερφόρτωση τελεστών σύγκρισης εξαμήνων φοιτητών.
bool Student::operator== (const Student &stu){
    return curSemester == stu.curSemester;
}
bool Student::operator!= (const Student &stu){
    return curSemester != stu.curSemester;
}
bool Student::operator< (const Student &stu){
    return curSemester < stu.curSemester;
}
bool Student::operator<= (const Student &stu){
    return curSemester <= stu.curSemester;
}
bool Student::operator> (const Student &stu){
    return curSemester > stu.curSemester;
}
bool Student::operator>= (const Student &stu){
    return curSemester >= stu.curSemester;
}