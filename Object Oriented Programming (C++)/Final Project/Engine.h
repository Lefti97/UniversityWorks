#ifndef Engine_h
#define Engine_h

#include <vector>
#include <string>
#include <ncurses.h>
#include "CoordsXY.h"
#include "Potter.h"
#include "Gnome.h"
#include "Traal.h"
#include "HiScore.h"

class Engine
{
private:
    std::vector<std::string> map;
    std::string playerName;
    int playerScore;
    bool playing;
    bool alive;
    int stones;
    bool parchment;
    CoordsXY parchmentCoords;
    std::vector<CoordsXY> stonesCoords;
    Potter player;
    Gnome gno;
    Traal tra;
    HiScore scoreTable;

public:
    Engine(char *mapPath, char *scorePath);

    void loadMap(char *mapPath);
    void start();
    void refreshMap();
    void playTurn();
};

#endif