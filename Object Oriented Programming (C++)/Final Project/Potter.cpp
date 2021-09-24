#include "Potter.h"
#include <ncurses.h>

void Potter::move(int ch)
{
    switch (ch)
    {
    case KEY_UP:
        getPos().Y -= 1;
        break;
    case KEY_DOWN:
        getPos().Y += 1;
        break;
    case KEY_LEFT:
        getPos().X -= 1;
        break;
    case KEY_RIGHT:
        getPos().X += 1;
        break;
    case 32:
        break;
    }
}