#ifndef Gnome_h
#define Gnome_h

#include "Moving.h"
#include <vector>
#include <string>

class Gnome : public Moving
{
public:
    void move(const std::vector<std::string>& map);
};

#endif