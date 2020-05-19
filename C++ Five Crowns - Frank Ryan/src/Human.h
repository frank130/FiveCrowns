#pragma once
#include "Player.h"
#include "Card.h"
#include "Deck.h"
#include "Computer.h"


class Human: public Player
{
public: 
	Human();

	bool checkEqualHands(vector<Card> firstHand, vector<Card> secondHand);

	vector<Card> startTurn(vector<Card> &hand, vector<Card> &drawPile, vector<Card> &discardPile, Deck *deck, int round, int &winningCondition, int &save);

	int startLastTurn(vector<Card> &hand, vector<Card> &drawPile, vector<Card> &discardPile, Deck *deck, int round);


	bool checkHumanGoOut(string finalHand, int round, vector<Card> &hand);
	vector<Card> humanLastGoOut(string finalHand, vector<Card> hand, int round);

	int searchDiscCard(vector<Card> &humanHand, vector<Card> &discardPile, string discard);

	bool searchGoOutCards(vector<Card> hand, vector<string> cards);

	bool checkRun(string check, vector<Card> hand, int round);

	bool checkBook(string check, vector<Card> hand, int round);

	~Human();
};

