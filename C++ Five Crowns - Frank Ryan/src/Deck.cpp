#include "pch.h"
#include "Deck.h"
#include "Card.h"
#include "Round.h"
#include <vector>
#include <iostream>
#include <iterator>
#include <algorithm>
#include <string>
#include <time.h>

using namespace std;

/****************************************************
Function Name: Deck Constructor
Purpose: Creates deck for one round. Deck object consists of 2 decks of cards.
Parameters: none
Algorithim:
	1. Create vector of cards that contain all cards in deck. Iterate twice.

*****************************************************/
Deck::Deck()
{
	//Loop that creates two decks of cards. The i at the end of the card signifies which deck it is in ( 1 or 2) .
	for (int i = 0; i < 2; i++)
	{


		
		cards.push_back(*new Card("3", "H", i));
		cards.push_back(*new Card("4", "H", i));
		cards.push_back(*new Card("5", "H", i));
		cards.push_back(*new Card("6", "H", i));
		cards.push_back(*new Card("7", "H", i));
		cards.push_back(*new Card("8", "H", i));
		cards.push_back(*new Card("9", "H", i));
		cards.push_back(*new Card("X", "H", i));
		cards.push_back(*new Card("J", "H", i));
		cards.push_back(*new Card("Q", "H", i));
		cards.push_back(*new Card("K", "H", i));
	
		cards.push_back(*new Card("3", "S", i));
		cards.push_back(*new Card("4", "S", i));
		cards.push_back(*new Card("5", "S", i));
		cards.push_back(*new Card("6", "S", i));
		cards.push_back(*new Card("7", "S", i));
		cards.push_back(*new Card("8", "S", i));
		cards.push_back(*new Card("9", "S", i));
		cards.push_back(*new Card("X", "S", i));
		cards.push_back(*new Card("J", "S", i));
		cards.push_back(*new Card("Q", "S", i));
		cards.push_back(*new Card("K", "S", i));
		
		cards.push_back(*new Card("3", "C", i));
		cards.push_back(*new Card("4", "C", i));
		cards.push_back(*new Card("5", "C", i));
		cards.push_back(*new Card("6", "C", i));
		cards.push_back(*new Card("7", "C", i));
		cards.push_back(*new Card("8", "C", i));
		cards.push_back(*new Card("9", "C", i));
		cards.push_back(*new Card("X", "C", i));
		cards.push_back(*new Card("J", "C", i));
		cards.push_back(*new Card("Q", "C", i));
		cards.push_back(*new Card("K", "C", i));

		cards.push_back(*new Card("3", "D", i));
		cards.push_back(*new Card("4", "D", i));
		cards.push_back(*new Card("5", "D", i));
		cards.push_back(*new Card("6", "D", i));
		cards.push_back(*new Card("7", "D", i));
		cards.push_back(*new Card("8", "D", i));
		cards.push_back(*new Card("9", "D", i));
		cards.push_back(*new Card("X", "D", i));
		cards.push_back(*new Card("J", "D", i));
		cards.push_back(*new Card("Q", "D", i));
		cards.push_back(*new Card("K", "D", i));
	
		cards.push_back(*new Card("3", "T", i));
		cards.push_back(*new Card("4", "T", i));
		cards.push_back(*new Card("5", "T", i));
		cards.push_back(*new Card("6", "T", i));
		cards.push_back(*new Card("7", "T", i));
		cards.push_back(*new Card("8", "T", i));
		cards.push_back(*new Card("9", "T", i));
		cards.push_back(*new Card("X", "T", i));
		cards.push_back(*new Card("J", "T", i));
		cards.push_back(*new Card("Q", "T", i));
		cards.push_back(*new Card("K", "T", i));

		cards.push_back(*new Card("J", "1", i));
		cards.push_back(*new Card("J", "2", i));
		cards.push_back(*new Card("J", "3", i));
		
	}
	
}

/****************************************************
Function Name: printDeck
Purpose: prints the deck to the screen
Parameters: none
Return Value: none
Algorithim:
	1. Iterate through deck of cards and print out its value and suite.

*****************************************************/
void Deck::printDeck()
{
	unsigned int size = cards.size();

	//iterate through deck, print out each card
	for (unsigned int i = 0; i < size; i++)
	{
		cout << cards[i].getVal() + cards[i].getSuite()  << endl;
		
	}
}

/****************************************************
Function Name: printCardHand
Purpose: Returns a card vector as a string.
Parameters: vector<Card>
Return Value: string
Algorithim:
	1. Create string.
	2. Iterate through vector parameter, place each card into the string

*****************************************************/
string Deck::printCardHand(vector<Card> hand)
{
	string printHand;
	unsigned int size = hand.size();

	//iterate through cards, place each card into string
	for (unsigned int i = 0; i < size; i++)
	{

		printHand += hand[i].getVal() + hand[i].getSuite() +  " ";

	}
	return printHand;
}

/****************************************************
Function Name: shuffle
Purpose: Shuffle all cards in deck.
Parameters: none
Return Value: int
Algorithim:
	1. Call random function shuffle for private cards variable.

*****************************************************/
void Deck::shuffle()
{
	srand(time(0));

	//call function random_shuffle that shuffles the card vector
	std::random_shuffle(cards.begin(), cards.end());
	
}

/****************************************************
Function Name: searchDeck
Purpose: Used for human player, searches deck to see if inputted discard is a card inside the deck.
Parameters: deck object, string
Return Value: boolean
Algorithim:
	1. Check to see if discard card has only two character.
		2. If not, ask for new discard.
	3. Seperate discard into characters.
		4. Iterate through deck and check if the card value and suite is a pair inside the deck.
		5. Return true if found.
	6. If not found, return false.

*****************************************************/
bool Deck::searchDeck(Deck *deck, string &discard)
{
	//While loop that checks for string length of 2
	//If not, ask for new input
	while (discard.length() != 2)
	{
		if (discard.length() < 2)
		{
			cout << "Not enough input. Please enter a valid card in your hand.\n";
			cin >> discard;
		}
		if (discard.length() > 2)
		{
			cout << "Too much input. Please enter a valid card in your hand.\n";
			cin >> discard;
		}
	}
	
	//Seperating discard by each character into a new string
	string s1 = discard;
	string s2 = s1.substr(0, 1); // Card Value
	string s3 = s1.substr(1, 1); // Card Suite

	unsigned int size = cards.size();
	//Iterate through deck and check if the card exists by using new strings, if it does, return true.
	for (unsigned int i = 0; i < size; i++)
	{
		
		if ((s2 == cards[i].getVal()) && (s3 == cards[i].getSuite() ))
		{
			return true;
		}

	}

	//If iteration did not return true, return false, it was not found in deck.
	return false;
}


/****************************************************
Function Name: dealCards
Purpose: deal cards from deck to a player 
Parameters: deck object, int
Return Value: vector<Card>
Algorithim:
	1. Iterate through beginning of deck and move cards into the vector<Card>
		2. Only add cards up to int parameter.
	3. Return vector<Card>

*****************************************************/
vector<Card> Deck::dealCards(Deck deck, int wild)
{
	int amountofCards = wild;
	vector<Card> playersCards;

	//Start at beginning of deck and push back cards into vector<Card>
	//keep pushing cards until the int parameter wild is reached
	for (int i = 0; i < amountofCards; i++)
	{
		playersCards.push_back(cards.at(i));
		
	}

	//erase the cards that were taken and put into vector
	cards.erase(cards.begin(),cards.begin()+amountofCards);
	
	//return new cards for player
	return playersCards;
}


/****************************************************
Function Name: drawPile
Purpose: Deal out drawpile by taking rest of cards from deck
Parameters: deck object
Return Value: vector<Card>
Algorithim:
	1. Move rest of deck cards into vector<Card>

*****************************************************/
vector<Card> Deck::drawPile(Deck deck)
{
	//Move all cards into vector<Card>
	vector<Card> drawPile;
	for (int i = 0; i < cards.size(); i++)
	{
		drawPile.push_back(cards.at(i));
	}
	
	//return vector<Card>
	return drawPile;
}

/****************************************************
Function Name: discardPile
Purpose: Create the discard pile
Parameters: vector<Card>
Return Value: vector<Card>
Algorithim:
	1. Put first card in draw pile into a new vector<Card> to create discardPile

*****************************************************/
vector<Card> Deck::discardPile(vector<Card> &drawPile)
{
	vector<Card> discardPile;

	//Puts first card in drawPile into discardPile
	discardPile.push_back(drawPile.at(0));

	//Erases the card that was taken from discard pile.
	drawPile.erase(drawPile.begin());
	return discardPile;
	
}



Deck::~Deck()
{
}
