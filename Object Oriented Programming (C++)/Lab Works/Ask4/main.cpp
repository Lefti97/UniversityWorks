/*
    Απο τα απαιτούμενα της άσκησης λείπουν
    -Επιστρέφει λίστα με τις δωρεάν εφαρμογές γραφείου και λίστα 
    με τα παιχνίδια που έχουν μέσο όρο αξιολόγησης > του 4.
    -Αποθηκεύει / ανακτά σε / από αρχείο το σύνολο των στοιχείων του συστήματος.
*/

#include <iostream>
#include "Application.h"
#include "VideoGame.h"
#include "OfficeApp.h"
#include "AppSystem.h"

int main(){

    std::cout << std::boolalpha;

    std::vector<class UserEvaluation> comments;
    comments.push_back(UserEvaluation(5, "Giorgos97", "Good app"));
    comments.push_back(UserEvaluation(1, "Kitsos Makis", "App is bad, i delete"));

    std::vector<std::string> fileTypes1;
    fileTypes1.push_back("pdf");
    fileTypes1.push_back("txt");

    VideoGame game1("1234", "Skyrim", 143, 50.32, false, "RPG",
        AppManufacturer("4325345", "Lefteris", "vlefti@hotmail.com"),
        comments);

    VideoGame game2("1234", "Skyrim", 143, 50.32, false, "RPG",
        AppManufacturer("4325345", "Lefteris", "vlefti@hotmail.com"),
        comments);

    VideoGame game3("1234", "Skyrim", 143, 50.32, false, "RPG",
        AppManufacturer("4325345", "Lefteris", "vlefti@hotmail.com"),
        comments);

    VideoGame game4("1234", "Skyrim", 143, 50.32, false, "RPG",
        AppManufacturer("4325345", "Lefteris", "vlefti@hotmail.com"),
        comments);

    OfficeApp officeApp1("2345", "LibreOffice", 267, 13.10, fileTypes1,
        AppManufacturer("123454362", "Gjerg", "gjerg@hotmail.com"),
        comments);

    OfficeApp officeApp2("2345", "Word", 267, 13.10, fileTypes1,
        AppManufacturer("123454362", "Gjerg", "gjerg@hotmail.com"),
        comments);


    AppSystem appSystem;
    
    appSystem.addApplication(&game1);
    appSystem.addApplication(&game2);
    appSystem.addApplication(&officeApp1);
    appSystem.addApplication(&game3);
    appSystem.addApplication(&game4);
    appSystem.addApplication(&officeApp2);

    appSystem.printFullReport();

    appSystem.deleteByManufacturerId("4325345");

    appSystem.printFullReport();
}