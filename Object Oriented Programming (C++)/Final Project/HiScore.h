#ifndef HiScore_h
#define HiScore_h

#include <string>

class HiScore
{
private:
    char names[5][10];
    int scores[5];
    char tmpName[10];
public:
    HiScore();

    void loadTable(char* scorePath);
    HiScore& operator<<(const char* newName);
    void operator<<(int newScore);
    void saveTable(char* scorePath);
    std::string print();
};

#endif