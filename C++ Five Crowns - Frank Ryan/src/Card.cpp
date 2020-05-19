#include "pch.h"
#include "Card.h"
#include <iostream>
#include <sstream>

/****************************************************
Function Name: Card (constructor)
Purpose: Creates a single Card object.
Parameters: string val, holds data of cards value. string a_suite: holds value of card's suite. int deckNumber, holds which deck the card is in.
Return Value: none
Algorithim:
	1. Sets parameters to private variables of card.

*****************************************************/
Card::Card(string val, string a_suite, int deckNumber)
{
	suite = a_suite;
	value = val;
	deckTag = deckNumber;
}

//All my getters
string Card::getVal()
{
	
	return value;
}
string Card::getSuite()
{
	return suite;
}
int Card::getDeck()
{
	return deckTag;
}

//Translates value string to int, accounts for jokers
int Card::getNumValue()
{
	if (value == "3")
	{
		return 3;
	}
	if (value == "4")
	{
		return 4;
	}
	if (value == "5")
	{
		return 5;
	}
	if (value == "6")
	{
		return 6;
	}
	if (value == "7")
	{
		return 7;
	}
	if (value == "8")
	{
		return 8;
	}
	if (value == "9")
	{
		return 9;
	}
	if (value == "X")
	{
		return 10;
	}
	if (value == "J" && (suite == "1" || suite == "2" || suite == "3"))
	{
		return 50;
	}
	if (value == "J")
	{
		return 11;
	}
	
	if (value == "Q")
	{
		return 12;
	}
	if (value == "K")
	{
		return 13;
	}
	
	
}



//Returns wild card for the round, which is the parameter.
bool Card::getWild(int round)
{
	if (value == "3" && round == 3)
	{
		return true;
	}
	if (value == "4" && round == 4)
	{
		return true;
	}if (value == "5" && round == 5)
	{
		return true;
	}if (value == "6" && round == 6)
	{
		return true;
	}if (value == "7" && round == 8)
	{
		return true;
	}if (value == "8" && round == 8)
	{
		return true;
	}if (value == "9" && round == 9)
	{
		return true;
	}if (value == "X" && round == 10)
	{
		return true;
	}if (value == "J" && round == 11)
	{
		return true;
	}if (value == "Q" && round == 12)
	{
		return true;
	}if (value == "K" && round == 13)
	{
		return true;
	}
	return false;
}



Card::~Card()
{
}
