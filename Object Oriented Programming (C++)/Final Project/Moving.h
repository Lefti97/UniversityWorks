#ifndef Moving_h
#define Moving_h

#include "CoordsXY.h"
#include <vector>
#include <string>

class Moving
{
private:
    CoordsXY pos;
public:

    void setPos(int x, int y);
    CoordsXY& getPos();
    int leastMoves(CoordsXY coords, const std::vector<std::string>& map);
};

#endif