#pragma once
#include "Player.h"
#include "Card.h"

using namespace std;
class Computer: public Player
{
public:
	Computer();
	vector<Card> startTurn(vector<Card> &hand, vector<Card> &drawPile, vector<Card> &discardPile, int round, int &winningCondition);

	int startLastTurn(vector<Card> &hand, vector<Card> &drawPile, vector<Card> &discardPile, int round, int &winningCondition);
	
	int checkFinalHand(vector<Card> hand, int round);



	
	~Computer();
};

