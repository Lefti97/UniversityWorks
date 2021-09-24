#include "CoordsXY.h"

bool cmpCoordsXY(CoordsXY a, CoordsXY b)
{
    if((a.X == b.X) && (a.Y == b.Y))
        return true;
    else
        return false;
}
