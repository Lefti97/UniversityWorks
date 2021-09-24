#ifndef Application_h
#define Application_h

#include <string>
#include <vector>
#include "AppManufacturer.h"
#include "UserEvaluation.h"

class Application
{
private:
    int type; // 0 = Application, 1 = VideoGame, 2 = OfficeApp
    char* id;
    std::string name;
    unsigned int version;
    class AppManufacturer man; 
    std::vector<class UserEvaluation> evaluations;
    float price;

public:

    Application(const char *idF="-", std::string nameF="-", unsigned int versionF=0, 
        float priceF=0, AppManufacturer manF=AppManufacturer(), 
        std::vector<class UserEvaluation> evaluationsF=std::vector<class UserEvaluation>())
    {
        id = new char [strlen(idF)];
        strcpy(id, idF);
        name = nameF;
        version = versionF;
        price = priceF;
        man = manF;
        evaluations = evaluationsF;
        type = 0;
    }

    virtual void printData() = 0;

    char* getId(){return id;}
    std::string getName(){return name;}
    unsigned int getVersion(){return version;}
    AppManufacturer& getMan(){return man;}
    std::vector<class UserEvaluation>& getEvaluations(){return evaluations;}
    float getPrice(){return price;}

    void setId(const char* idF)
    {
        delete[] id;
        id = new char [strlen(idF)];
        strcpy(id, idF);
    }
    void setName(std::string nameF){name = nameF;}
    void setVersion(unsigned int versionF){version = versionF;}
    void setMan(const AppManufacturer &manF){man = manF;}
    void setEvaluations(std::vector<class UserEvaluation> evaluationsF){evaluations = evaluationsF;}
    void setPrice(float priceF){price = priceF;}

    float getEvaluationsAvg()
    {
        float avg=0;
        for(int i=0; i<evaluations.size();i++)
            avg += evaluations.at(i).getStars();

        avg = avg / evaluations.size();
        return avg;
    }

    virtual bool getOnline(){return false;}
    virtual std::string getCategory(){return "";}

    virtual void setOnline(bool onlineF){}
    virtual void setCategory(std::string categoryF){}

    virtual std::vector<std::string> getFileTypes(){return std::vector<std::string>();}
    virtual void setFileTypes(std::vector<std::string> fileTypesF){}
};

#endif