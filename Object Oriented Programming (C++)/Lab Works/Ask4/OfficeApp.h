#ifndef OfficeApp_h
#define OfficeApp_h

#include <iostream>
#include <string>
#include <vector>
#include "Application.h"

class OfficeApp : public Application
{
private:
    std::vector<std::string> fileTypes;
public:
    OfficeApp(const char *idF="-", std::string nameF="-", 
        unsigned int versionF=0, float priceF=0, 
        std::vector<std::string> fileTypesF=std::vector<std::string>(),
        AppManufacturer manF=AppManufacturer(), 
        std::vector<class UserEvaluation> evaluationsF=std::vector<class UserEvaluation>())
    {
        setId(idF);
        setName(nameF);
        setVersion(versionF);
        setPrice(priceF);
        setMan(manF);
        setEvaluations(evaluationsF);
        fileTypes=fileTypesF;
    }

    OfficeApp(OfficeApp &tmp)
    {
        setId(tmp.getId());
        setName(tmp.getName());
        setVersion(tmp.getVersion());
        setPrice(tmp.getPrice());
        setMan(tmp.getMan());
        setEvaluations(tmp.getEvaluations());
        fileTypes=tmp.getFileTypes();
    }

    virtual void printData()
    {
        std::cout << "ID: " << getId() << "\tName: " << getName() << std::endl;
        std::cout << "Version: " << getVersion() << "\tPrice: " << getPrice() << std::endl;
        std::cout << "File types that can be handled:" << std::endl;
        for(int i=0; i<fileTypes.size(); i++)
            std::cout << i+1 << ": " << fileTypes.at(i) << std::endl;
        std::cout << "Manufacturer Info:" << std::endl;
        getMan().printData();
        std::cout << "User Evaluations:" << std::endl;
        for(int i=0; i<getEvaluations().size(); i++)
        {
            std::cout << i+1 << ": ";
            getEvaluations().at(i).printData();
        }
    }

    virtual std::vector<std::string> getFileTypes(){return fileTypes;}
    virtual void setFileTypes(std::vector<std::string> fileTypesF){fileTypes = fileTypesF;}
};

#endif