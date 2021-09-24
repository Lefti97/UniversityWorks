#include <iostream>
#include <fstream>
#include <string.h>
#include <string>
#include "HiScore.h"

HiScore::HiScore()
{
    // Initialize table.
    for(int i=0; i<5; i++)
    {
        names[i][0] = '-';
        names[i][1] = '\0';
        scores[i] = -1;
    }
}

void HiScore::loadTable(char* scorePath)
{
    try{
        std::ifstream file(scorePath, std::ios::out | std::ios::binary);
        if(file)
        {
            // Check if scorePath file is same size as HiScore class.
            file.seekg(0,std::ios::end);
            if(file.tellg() != sizeof(HiScore))
                throw "High score filepath given is incorrect.";

            // Change read position to beginning of file and read high score file.
            file.seekg(0,std::ios::beg);
            file.read((char *) this, sizeof(HiScore));
            file.close();
        }
        else // If the file doesnt exist, create an empty one.
        {
            saveTable(scorePath);
            loadTable(scorePath);
        }
    }
    catch(const char* str){
        throw str;
    }
    catch(...){
        throw "Loading high score table.";
    }
}



HiScore& HiScore::operator<<(const char* newName)
{
    strcpy(tmpName,newName);
    return *this;
}


// Adds new score only if it is higher than any of the scores.
// Also sorts the table by score value.
void HiScore::operator<<(int newScore)
{
    int newPosition = -1;

    for(int i=0; i<5; i++)
        if(scores[i] <= newScore)
        {
            newPosition = i;
            break;
        }
            
    if(newPosition != -1)
    {
        for(int i=3; i>=newPosition; i--){
            strcpy(names[i+1], names[i]);
            scores[i+1] = scores[i];
        }

        strcpy(names[newPosition], tmpName);
        scores[newPosition] = newScore;
    }
}


void HiScore::saveTable(char* scorePath)
{
    try{
        std::ofstream file(scorePath, std::ios::out | std::ios::binary);
        if(file){
            file.write((char *) this, sizeof(HiScore));
            file.close();
        }
    }
    catch(...){
        throw "Saving high score table.";
    }
}


std::string HiScore::print()
{
    std::string tmp = "\n\nSCORE TABLE\n";

    for(int i=0; i<5; i++)
    {
        if(scores[i] > -1)
            tmp += std::string(names[i]) + "\t" + std::to_string(scores[i]) + "\n";
        else
            tmp += std::string(names[i]) + "\n";
    }
        
    return tmp;
}