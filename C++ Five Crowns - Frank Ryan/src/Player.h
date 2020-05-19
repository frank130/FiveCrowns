#pragma once
#include "Card.h"
#include <vector>
#include "Deck.h"

using namespace std;
class Player
{
public:
	Player();
	vector<Card> dropCard(vector<Card> &newHand, vector<Card> &discardPile, int i);

	vector<Card> pickDrawCard(vector<Card> &previousHand, vector<Card> &drawPile);

	vector<Card> pickDiscCard(vector<Card> previousHand, vector<Card> &discardPile);


	vector<Card> sortHand(vector<Card> hand);

	int countCardPoints(vector<Card> hand, int wild);

	void printCards(vector<Card> hand);

	void eraseCard(vector<Card> &finalHand, int position);

	vector<vector<Card>> checkBook(vector<Card> hand, int round, int wantedSize);

	vector<vector<Card>> checkRun(vector<Card> hand, int round, int wantedSize);

	vector<Card> checkComputerGoOut(vector<Card> hand, int round, string player);

	int checkOutPossibilites(vector<vector<Card>> possibility1, vector<vector<Card>> possibility2, string player);
	int checkOutThree(vector<vector<Card>> possibility1, vector<vector<Card>> possibility2, vector<vector<Card>> possibility3, string player);
	int checkOutFour(vector<vector<Card>> possibility1, vector<vector<Card>> possibility2, vector<vector<Card>> possibility3, vector<vector<Card>> possibility4, string player);


	bool checkDuplicates(vector<Card> book, vector<Card> run);

	bool searchUsedWild(vector<Card> cards, Card wild);

	vector<Card> checkPossibleBook(vector<Card> hand, int round, int lastTurn);

	vector<Card> checkPossibleRun(vector<Card> hand, int round, int lastTurn);


	~Player();
};

