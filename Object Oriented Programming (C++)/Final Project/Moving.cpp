#include "Moving.h"

void Moving::setPos(int x, int y)
{
    pos.X = x;
    pos.Y = y;
}

CoordsXY& Moving::getPos()
{
    return pos;
}

// Calculate least amount of moves to Potter starting from a set of coords.
int Moving::leastMoves(CoordsXY coords, const std::vector<std::string>& map){

    std::vector<std::string> localMap = map;
    char tmpChar = -100;

    localMap.at(coords.Y).at(coords.X) = tmpChar;

    for(int i=0;i<100;i++){

        for(int y=0; y<localMap.size();y++){

            for(int x=0; x<localMap.at(y).size();x++){

                if(localMap.at(y).at(x) == tmpChar){
                    
                    if(   (localMap.at(y).at(x+1) == ' ') || (localMap.at(y).at(x+1) == '+') || (localMap.at(y).at(x+1) == 'x'))
                    {
                        localMap.at(y).at(x+1) = tmpChar+1;
                    }
                    else if(localMap.at(y).at(x+1) == 'P'){
                        return i;
                    }

                    if(   (localMap.at(y).at(x-1) == ' ') || (localMap.at(y).at(x-1) == '+') || (localMap.at(y).at(x-1) == 'x'))
                    {
                        localMap.at(y).at(x-1) = tmpChar+1;
                    }
                    else if(localMap.at(y).at(x-1) == 'P'){
                        return i;
                    }

                    if(   (localMap.at(y+1).at(x) == ' ') || (localMap.at(y+1).at(x) == '+') || (localMap.at(y+1).at(x) == 'x'))
                    {
                        localMap.at(y+1).at(x) = tmpChar+1;
                    }
                    else if(localMap.at(y+1).at(x) == 'P'){
                        return i;
                    }

                    if(   (localMap.at(y-1).at(x) == ' ') || (localMap.at(y-1).at(x) == '+') || (localMap.at(y-1).at(x) == 'x'))
                    {
                        localMap.at(y-1).at(x) = tmpChar+1;
                    }
                    else if(localMap.at(y-1).at(x) == 'P'){
                        return i;
                    }
                }
            }
        }
        tmpChar++;
    }
    
    return 2000;
}