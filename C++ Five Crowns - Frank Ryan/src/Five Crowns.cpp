  /****************************************************
Name: Frank Ryan
Project: C++ Five Crowns project
Class: CMPS 366 01
Date Submitted:
*****************************************************/


#include "pch.h"
#include <iostream>
#include "Card.h"
#include "Deck.h"
#include <string>
#include "Round.h"
#include "Game.h"


int main()
{
    //Game object creation and startGame function call to begin the game.
	Game *game = new Game();
	game->startGame();


	return 0;
}

