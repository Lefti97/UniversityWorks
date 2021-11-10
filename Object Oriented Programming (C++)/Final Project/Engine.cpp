#include "Engine.h"
#include "Moving.h"
#include "HiScore.h"
#include <fstream>
#include <iostream>
#include <string>
#include <stdlib.h>
#include <time.h>
#include <ncurses.h>

#define ENEMY_COLOR     1
#define PLAYER_COLOR    2
#define WALL_COLOR      3
#define HALL_COLOR      4
#define ITEM_COLOR      5
#define HISCORE_COLOR   6
#define STATE_COLOR     7

Engine::Engine(char *mapPath, char *scorePath)
{
    initscr();
    keypad(stdscr, true);

    start_color();
    init_pair(ENEMY_COLOR, COLOR_YELLOW, COLOR_BLUE);
    init_pair(PLAYER_COLOR, COLOR_BLACK, COLOR_RED);
    init_pair(WALL_COLOR, COLOR_BLACK, COLOR_MAGENTA);
    init_pair(HALL_COLOR, COLOR_WHITE, COLOR_WHITE);
    init_pair(ITEM_COLOR, COLOR_MAGENTA, COLOR_YELLOW); 
    init_pair(HISCORE_COLOR, COLOR_BLACK, COLOR_YELLOW);
    init_pair(STATE_COLOR, COLOR_BLACK, COLOR_RED);

    loadMap(mapPath);
    scoreTable.loadTable(scorePath);
    start();
    
    while(playing)
    {
        refreshMap();
        playTurn();
        refresh();
    }

    scoreTable << playerName.c_str() << playerScore;
    
    refreshMap();
    printw("\n\nGame Ending");
    refresh();
    scoreTable.saveTable(scorePath);
    getch();
    
	endwin();
}

// Load map from text file.
void Engine::loadMap(char *mapPath)
{
    try{
        std::ifstream mapFile (mapPath);
        
        while(!mapFile.eof())
        {
            std::string str;
            std::getline(mapFile, str);
            
            for(int i=0; i<str.size();i++)
            {
                // FIX: Problem with windows text files when using WSL
                if(str.at(i) == 13){ // ASCII 13 == Carriage Return
                    str.erase(str.begin() + i); // Remove Carriage Return
                    continue;
                } 
                    
                // Check if map has only '*', ' ' and newlines.
                if((str.at(i) != '*') && (str.at(i) != ' ') && (str.at(i) != '\n'))
                    throw "Map file has invalid characters.";                
            }
            str.push_back('\n'); // Add newline
            map.push_back(str);
        }
        mapFile.close();
    }
    catch(const char* str){
        throw str;
    }
    catch(...){
        throw "Loading map.";
    }

}


// Initialize game variables.
// Randomize positions for Player, Monsters and Stones.
// Player name input.
void Engine::start()
{
    playing = true;
    alive = true;
    parchment = false;
    stones = 10;
    playerScore = 0;

    std::vector<CoordsXY> emptyHalls;

    for(int y=0; y<map.size(); y++)
        for(int x=0; x<map.at(y).size(); x++)
            if(map.at(y).at(x) == ' '){
                CoordsXY tmp;
                tmp.X = x;
                tmp.Y = y;
                emptyHalls.push_back(tmp);
            }
            
    srand(time(0));
    int randNum;

    for(int i=0; i<stones; i++)
    {
        CoordsXY tmp;
        randNum = rand() % emptyHalls.size();
        map.at(emptyHalls.at(randNum).Y).at(emptyHalls.at(randNum).X) = '+';        
        tmp.X = emptyHalls.at(randNum).X;
        tmp.Y = emptyHalls.at(randNum).Y;
        stonesCoords.push_back(tmp);
        emptyHalls.erase(emptyHalls.begin() + randNum);
    }

    randNum = rand() % emptyHalls.size();
    map.at(emptyHalls.at(randNum).Y).at(emptyHalls.at(randNum).X) = 'P';
    player.setPos(emptyHalls.at(randNum).X, emptyHalls.at(randNum).Y);
    emptyHalls.erase(emptyHalls.begin() + randNum);

    randNum = rand() % emptyHalls.size();
    map.at(emptyHalls.at(randNum).Y).at(emptyHalls.at(randNum).X) = 'G';
    gno.setPos(emptyHalls.at(randNum).X, emptyHalls.at(randNum).Y);
    emptyHalls.erase(emptyHalls.begin() + randNum);

    randNum = rand() % emptyHalls.size();
    map.at(emptyHalls.at(randNum).Y).at(emptyHalls.at(randNum).X) = 'T';
    tra.setPos(emptyHalls.at(randNum).X, emptyHalls.at(randNum).Y);
    emptyHalls.erase(emptyHalls.begin() + randNum);

    printw("Player name : ");
    char tmp[10];
    scanw("%s", tmp);
    playerName = tmp;
}


// Print colorized map, game state and high scores.
void Engine::refreshMap()
{
    clear();        

    for(int y=0; y<map.size(); y++){
        for(int x=0; x<map.at(y).size(); x++){
            char tmp = map.at(y).at(x);

            if(tmp == '*'){
                attron(COLOR_PAIR(WALL_COLOR));
                addch(tmp);
                attroff(COLOR_PAIR(WALL_COLOR));
            }
            else if(tmp == ' '){
                attron(COLOR_PAIR(HALL_COLOR));
                addch(tmp);
                attroff(COLOR_PAIR(HALL_COLOR));
            }
            else if(tmp == 'P'){
                attron(COLOR_PAIR(PLAYER_COLOR));
                addch(tmp);
                attroff(COLOR_PAIR(PLAYER_COLOR));
            }
            else if((tmp == 'G') || (tmp == 'T')){
                attron(COLOR_PAIR(ENEMY_COLOR));
                addch(tmp);
                attroff(COLOR_PAIR(ENEMY_COLOR));
            }
            else if((tmp == '+') || (tmp == 'x')){
                attron(COLOR_PAIR(ITEM_COLOR));
                addch(tmp);
                attroff(COLOR_PAIR(ITEM_COLOR));
            }
            else{
                addch(tmp);
            }
        }
    }

    attron(COLOR_PAIR(STATE_COLOR));
    printw("\n\n%s score: %d\t\t", playerName.c_str(), playerScore);
    printw("\nStones Left: %d\t\t", stones);

    if(alive == false)
        printw("\n\t\t\t\nYOU LOST\t\t");
    else if(parchment)
        printw("\n\t\t\t\nYOU WON\t\t\t");
    else if(stones == 0)
        printw("\n\t\t\t\nGet Parchment x to win.\t");
    else
        printw("\n\t\t\t\nCollect the stones +.\t");
    attroff(COLOR_PAIR(STATE_COLOR));

    
    attron(COLOR_PAIR(HISCORE_COLOR));
    printw("%s", scoreTable.print().c_str());
    attroff(COLOR_PAIR(HISCORE_COLOR));
}


// This method is executed for every move.
void Engine::playTurn()
{
    // Get player move.
    int ch = getch();

    if(ch == 27) // ESCAPE
    {
        playing = false;
    }
    else if((ch == KEY_UP) || (ch == KEY_DOWN) || (ch == KEY_RIGHT) || (ch == KEY_LEFT) || (ch == 32))
    {
        CoordsXY playerStartPos = player.getPos();
        CoordsXY gnomeStartPos = gno.getPos();
        CoordsXY traalStartPos = tra.getPos();

        player.move(ch);
        
        // If new player position is not in a wall. Else repeat.
        if(map.at(player.getPos().Y).at(player.getPos().X) != '*')
        {
            gno.move(map);
            tra.move(map);

            // If both monsters are in the same position ... return Traal to starting position.
            if(cmpCoordsXY(gno.getPos(), tra.getPos()))
                tra.setPos(traalStartPos.X, traalStartPos.Y);

            // If player is in the same position as a monster ... lose game.
            if(cmpCoordsXY(player.getPos(), gno.getPos()) || cmpCoordsXY(player.getPos(), tra.getPos())){
                alive = false;
                playing = false;
            }
            // This is needed in order to avoid the player "going through" 
            // a monster and not losing.
            else if(cmpCoordsXY(player.getPos(), gnomeStartPos) && cmpCoordsXY(gno.getPos(), playerStartPos)){
                alive = false;
                playing = false;
                map.at(player.getPos().Y).at(player.getPos().X) = ' ';
            } // Same as previous.
            else if(cmpCoordsXY(player.getPos(), traalStartPos) && cmpCoordsXY(tra.getPos(), playerStartPos)){
                alive = false;
                playing = false;
                map.at(player.getPos().Y).at(player.getPos().X) = ' ';
            }

            
            // If all stones and parchment have been taken ... end game.
            if((stones == 0) && cmpCoordsXY(player.getPos(), parchmentCoords)  ){
                parchment = true;
                playing = false;
                playerScore += 100;
            }
            else{
                // Check if player is in the same position as a stone's.
                for(int i=0; i<stonesCoords.size(); i++)
                    if(cmpCoordsXY(stonesCoords.at(i), player.getPos()))
                    {
                        stones--;
                        playerScore += 10;
                        stonesCoords.erase(stonesCoords.begin() + i);

                        // If all stones are taken ... randomly place parchment.
                        if(stones == 0)
                        {
                            std::vector<CoordsXY> emptyHalls;

                            for(int y=0; y<map.size(); y++)
                                for(int x=0; x<map.at(y).size(); x++)
                                    if(map.at(y).at(x) == ' '){
                                        CoordsXY tmp;
                                        tmp.X = x;
                                        tmp.Y = y;
                                        emptyHalls.push_back(tmp);
                                    }
                                    
                            srand(time(0));
                            int randNum;
                            randNum = rand() % emptyHalls.size();
                            map.at(emptyHalls.at(randNum).Y).at(emptyHalls.at(randNum).X) = 'x';
                            parchmentCoords.X = emptyHalls.at(randNum).X;
                            parchmentCoords.Y = emptyHalls.at(randNum).Y;
                            emptyHalls.erase(emptyHalls.begin() + randNum);
                        }
                    }
            }


            map.at(playerStartPos.Y).at(playerStartPos.X) = ' ';
            map.at(gnomeStartPos.Y).at(gnomeStartPos.X) = ' ';
            map.at(traalStartPos.Y).at(traalStartPos.X) = ' ';

            for(int i=0; i<stonesCoords.size(); i++)
                map.at(stonesCoords[i].Y).at(stonesCoords[i].X) = '+';
            if(stones==0)
                map.at(parchmentCoords.Y).at(parchmentCoords.X) = 'x';
            
            if(alive)
                map.at(player.getPos().Y).at(player.getPos().X) = 'P';
            map.at(gno.getPos().Y).at(gno.getPos().X) = 'G';
            map.at(tra.getPos().Y).at(tra.getPos().X) = 'T';
        }
        else
            player.setPos(playerStartPos.X, playerStartPos.Y);
        
    }
}