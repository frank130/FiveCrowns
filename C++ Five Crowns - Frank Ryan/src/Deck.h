#pragma once
#include <vector>
#include <iostream>
#include "Card.h"
#include "Round.h"


using std::string;
using namespace std;
class Deck
{
public:
	Deck();
	void shuffle();
	void printDeck();
	

	vector<Card> dealCards(Deck playersCards, int wild);
	vector<Card> drawPile(Deck deck);
	vector<Card> discardPile(vector<Card> &drawPile);
	string printCardHand(vector<Card> hand);

	bool searchDeck(Deck *deck, string &discard);

	~Deck();
	
private: 
	vector<Card> cards;
};

