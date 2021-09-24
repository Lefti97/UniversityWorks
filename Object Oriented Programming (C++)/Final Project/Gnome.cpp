#include "Gnome.h"

void Gnome::move(const std::vector<std::string>& map)
{
    // [0] = right, [1] = left, [2] = down, [3] = up
    int steps[4] = {3000, 3000, 3000, 3000};

    // RIGHT
    if((map.at(getPos().Y).at(getPos().X+1) == 'P')){
        getPos().X += 1;
        return;
    }
    else if(   (map.at(getPos().Y).at(getPos().X+1) == ' ')
            || (map.at(getPos().Y).at(getPos().X+1) == '+')
            || (map.at(getPos().Y).at(getPos().X+1) == 'x')){
        CoordsXY tmpCoords;
        tmpCoords.Y = getPos().Y;
        tmpCoords.X = getPos().X+1;
        steps[0] = leastMoves(tmpCoords, map);
    }
        
    // LEFT
    if((map.at(getPos().Y).at(getPos().X-1) == 'P')){
        getPos().X -= 1;
        return;
    }
    else if(   (map.at(getPos().Y).at(getPos().X-1) == ' ')
            || (map.at(getPos().Y).at(getPos().X-1) == '+')
            || (map.at(getPos().Y).at(getPos().X-1) == 'x')){
        CoordsXY tmpCoords;
        tmpCoords.Y = getPos().Y;
        tmpCoords.X = getPos().X-1;
        steps[1] = leastMoves(tmpCoords, map);
    }


    // DOWN
    if((map.at(getPos().Y+1).at(getPos().X) == 'P')){
        getPos().Y += 1;
        return;
    }
    else if(   (map.at(getPos().Y+1).at(getPos().X) == ' ')
            || (map.at(getPos().Y+1).at(getPos().X) == '+')
            || (map.at(getPos().Y+1).at(getPos().X) == 'x')){
        CoordsXY tmpCoords;
        tmpCoords.Y = getPos().Y+1;
        tmpCoords.X = getPos().X;
        steps[2] = leastMoves(tmpCoords, map);
    }


    // UP
    if((map.at(getPos().Y-1).at(getPos().X) == 'P')){
        getPos().Y -= 1;
        return;
    }
    else if(   (map.at(getPos().Y-1).at(getPos().X) == ' ')
            || (map.at(getPos().Y-1).at(getPos().X) == '+')
            || (map.at(getPos().Y-1).at(getPos().X) == 'x')){
        CoordsXY tmpCoords;
        tmpCoords.Y = getPos().Y-1;
        tmpCoords.X = getPos().X;
        steps[3] = leastMoves(tmpCoords, map);
    }

    int choice = 0;
    for(int i=0; i<4; i++)
        if(steps[i] < steps[choice])
            choice = i;

    if(choice == 0)
        getPos().X += 1;
    else if(choice == 1)
        getPos().X -= 1;
    else if(choice == 2)
        getPos().Y += 1;
    else if(choice == 3)
        getPos().Y -= 1;

}