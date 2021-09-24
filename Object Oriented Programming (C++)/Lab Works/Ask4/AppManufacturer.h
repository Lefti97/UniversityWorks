#ifndef AppManufacturer_h
#define AppManufacturer_h

#include <string>
#include <string.h>

class AppManufacturer
{
private:
    std::string id;
    char* name;
    std::string email;
public:

    AppManufacturer(std::string idF="", const char* nameF="", std::string emailF="-")
    {
        name = new char [strlen(nameF)];
        strcpy(name, nameF);
        setId(idF);
        setEmail(emailF);
    }

    //TODO Destructor

    AppManufacturer(const AppManufacturer &app)
    {
        setId(app.id);
        setName(app.name);
        setEmail(app.email);
    }

    AppManufacturer& operator= (const AppManufacturer &app)
    {
        setId(app.id);
        setName(app.name);
        setEmail(app.email);
        return *this;
    }

    std::string getId(){return id;}
    char* getName(){return name;}
    std::string getEmail(){return email;}
    
    void setId(std::string idF){id = idF;}
    void setEmail(std::string emailF){email = emailF;}
    void setName(const char* nameF){
        delete[] name;
        name = new char [strlen(nameF)];
        strcpy(name, nameF);
    }

    void printData()
    {
        std::cout << "ID: " << id << "\tName: " << name << "\tEmail: " << email << std::endl;
    }
};

#endif