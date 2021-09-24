#ifndef AppSystem_h
#define AppSystem_h

#include <iostream>
#include <vector>
#include "Application.h"
#include "VideoGame.h"
#include "OfficeApp.h"
#include "AppManufacturer.h"
#include "UserEvaluation.h"

class AppSystem
{
private:
    std::vector<Application *> appList;
public:

    AppSystem(){}

    void addApplication(Application *newApp)
    {   
        appList.push_back(newApp);  
    }

    void addManufacturer(const char *appId, const AppManufacturer &newMan)
    {
        for(int i=0; i<appList.size();i++)
            if(strcmp(appId, appList.at(i)->getId()) == 0)
                appList.at(i)->setMan(newMan);
    }
    void addUserEvaluation(const char *appId, const UserEvaluation& newEval)
    {
        for(int i=0; i<appList.size();i++)
            if(strcmp(appId, appList.at(i)->getId()) == 0)
                appList.at(i)->getEvaluations().push_back(newEval);
    }

    void editId(const char *appId, const char* newId)
    {
        for(int i=0; i<appList.size();i++)
            if(strcmp(appId, appList.at(i)->getId()) == 0)
                appList.at(i)->setId(newId);
    }
    void editName(const char *appId, std::string newName)
    {
        for(int i=0; i<appList.size();i++)
            if(strcmp(appId, appList.at(i)->getId()) == 0)
                appList.at(i)->setName(newName);
    }
    void editVersion(const char *appId, unsigned int newVersion)
    {
        for(int i=0; i<appList.size();i++)
            if(strcmp(appId, appList.at(i)->getId()) == 0)
                appList.at(i)->setVersion(newVersion);
    }
    void editPrice(const char *appId, float newPrice)
    {
        for(int i=0; i<appList.size();i++)
            if(strcmp(appId, appList.at(i)->getId()) == 0)
                appList.at(i)->setPrice(newPrice);
    }
    void editOnline(const char *appId, bool newOnline)
    {
        for(int i=0; i<appList.size();i++)
            if(strcmp(appId, appList.at(i)->getId()) == 0)
                appList.at(i)->setOnline(newOnline);
    }
    void editCategory(const char *appId, std::string newCategory)
    {
        for(int i=0; i<appList.size();i++)
            if(strcmp(appId, appList.at(i)->getId()) == 0)
                appList.at(i)->setCategory(newCategory);
    }


    void deleteByManufacturerId(std::string id)
    {
        for(int i=appList.size()-1; i<appList.size();i--)
            if(appList.at(i)->getMan().getId() == id)
                appList.erase(appList.begin() + i);
    }

    void printFullReport()
    {
        std::cout << "FULL REPORT" << std::endl;
        for(int i=0; i<appList.size(); i++){
            std::cout << "-----------------------" << std::endl;
            appList.at(i)->printData();
        }
        std::cout << "-----------------------" << std::endl;
    }

    // Save/Retrieve from file.

    std::vector<Application *> getAppList(){return appList;}

};

#endif