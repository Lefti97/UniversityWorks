#ifndef Traal_h
#define Traal_h

#include "Moving.h"
#include <vector>
#include <string>

class Traal : public Moving
{
public:
    void move(const std::vector<std::string>& map);
};

#endif