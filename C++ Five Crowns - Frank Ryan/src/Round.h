#pragma once
#include <vector>
#include "Card.h"


using namespace std;
class Round
{
public:
	Round();

	int startRound1(int round, int &winner, int &humanTotalPoints, int &computerTotalPoints);

	int startSavedGame(vector<Card> playerHand1, vector<Card> playerHand2, vector<Card> drawDeck, vector<Card> discardDeck, int round, int &winner, int &humanTotalPoints, int &computerTotalPoints);

	~Round();
private:
	int roundNumber;

};

