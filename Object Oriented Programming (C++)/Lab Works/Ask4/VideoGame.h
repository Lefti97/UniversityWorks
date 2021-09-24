#ifndef VideoGame_h
#define VideoGame_h

#include <iostream>
#include <string>
#include <vector>
#include "Application.h"

class VideoGame : public Application
{
private:
    bool online;
    std::string category;
public:
    VideoGame(const char *idF="-", std::string nameF="-", unsigned int versionF=0, 
        float priceF=0, bool onlineF=false, std::string categoryF="-", 
        AppManufacturer manF=AppManufacturer(), 
        std::vector<class UserEvaluation> evaluationsF=std::vector<class UserEvaluation>())
    {
        setId(idF);
        setName(nameF);
        setVersion(versionF);
        setPrice(priceF);
        setMan(manF);
        setEvaluations(evaluationsF);
        online = onlineF;
        category = categoryF;
    }

    virtual void printData()
    {
        std::cout << "ID: " << getId() << "\tName: " << getName() << std::endl;
        std::cout << "Version: " << getVersion() << "\tPrice: " << getPrice() << std::endl;
        std::cout << "Online: " << online << "\tCategory: " << category << std::endl;
        std::cout << "Manufacturer Info:" << std::endl;
        getMan().printData();
        std::cout << "User Evaluations:" << std::endl;
        for(int i=0; i<getEvaluations().size(); i++)
        {
            std::cout << i+1 << ":";
            getEvaluations().at(i).printData();
        }
    }

    virtual bool getOnline(){return online;}
    virtual std::string getCategory(){return category;}
    virtual void setOnline(bool onlineF){online = onlineF;}
    virtual void setCategory(std::string categoryF){category = categoryF;}
};

#endif