#include "pch.h"
#include "Player.h"
#include <vector>
#include "Card.h"
#include <iostream>
#include <sstream>
#include <algorithm>
#include "Deck.h"
#include <string>

using namespace std;
Player::Player()
{
}
/****************************************************
Function Name: pickDrawCard
Purpose: Picks a card from the draw pile, moves it into player's hand, and erases it from draw pile
Parameters: vector card player hand, vector card draw pile, both passed by reference
Return Value: vector card that is new players hand
Algorithim:
	1. Push back first draw pile card into players hand.
	2. Remove card from draw pile.


*****************************************************/
vector<Card> Player::pickDrawCard(vector<Card> &previousHand, vector<Card> &drawPile)
{
	vector<Card> newHand = previousHand;
	cout << "\nThe player has picked up ... " << drawPile.at(0).getVal() + drawPile.at(0).getSuite() << " from the draw pile!\n";

	//Puts first draw pile card into player's hand
	newHand.push_back(drawPile.at(0));

	//Erases picked card from draw pile, returns players hand
	drawPile.erase(drawPile.begin());
	return newHand;
}

/****************************************************
Function Name: pickDiscCard
Purpose: Picks a card from the discard pile, moves it into player's hand, and erases it from discard pile
Parameters: vector card player hand, vector card discard pile passed by reference
Return Value: vector card that is players hand
Algorithim:
	1. Push back first discard pile card into players hand.
	2. Remove card from discard pile.


*****************************************************/
vector<Card> Player::pickDiscCard(vector<Card> previousHand, vector<Card> &discardPile)
{
	vector<Card> newHand = previousHand;
	//Puts first draw pile card into player's hand
	newHand.push_back(discardPile.at(0));
	
	//Erases picked card from draw pile, returns players hand
	discardPile.erase(discardPile.begin());
	return newHand;
}

/****************************************************
Function Name: dropCard
Purpose: Removes a card from player's hand at a position
Parameters: vector card player hand passed by reference, vector card discard pile passed by reference, integer that is the position of the card
Return Value: vector card that is players hand
Algorithim:
	1. Insert discarded card into discard pile.
	2. Erase discarded card from players hand.


*****************************************************/
vector<Card> Player::dropCard(vector<Card> &newHand, vector<Card> &discardPile, int i)
{
	vector<Card>::iterator it;
	it = discardPile.begin();
	cout << "\nThe player has dropped ... " << newHand.at(i).getVal() + newHand.at(i).getSuite() << " from their hand!\n";

	//Inserts card into first spot of discard pile
	it = discardPile.insert(it, newHand.at(i));

	//Erases card in player's hand at position i
	newHand.erase(newHand.begin() + i);

	return newHand;
}


/*
vector<Card> Player::sortHand(vector<Card> hand)
{
	vector<Card> finalHand;
		
	unsigned int size = hand.size();
	vector<int> values;
	for (unsigned int i = 0; i < size; i++)
	{
		values.push_back(hand[i].getNumValue());

	}
	
	sort(hand.begin(), hand.end());
	finalHand = hand;
	return finalHand;
		
}*/


/*void Player::eraseCard(vector<Card> &finalHand, int position)
{
	finalHand.erase(finalHand.begin() + position);
}*/


/****************************************************
Function Name: countCardPoints
Purpose: Counts the amount of points from the player's hand and returns it
Parameters: vector card of players hand and integer for wild card
Return Value: int of players total points
Algorithim:
	1. Iterate through players hand and add each card's value to an integer variable.
	2. Return that integer.


*****************************************************/
int Player::countCardPoints(vector<Card> hand, int wild)
{
	int total = 0;

	//Iterates through players hand
	for (int i = 0; i < hand.size();i++)
	{
		//If the cards value is wild for the round, make that value = 20
		if (hand[i].getNumValue() == wild)
		{
			total = total + 20;
		}
		//If the cards value is not wild for the round, call getNumValue from Card class to get the cards value in points
		else if(hand[i].getNumValue() != wild)
		{
			total = total + hand[i].getNumValue();
		}
	}
	//returns the total points added up
	return total;
}



/****************************************************
Function Name: printCards
Purpose: Stores the players hand as a string and prints it to screen
Parameters: vector card player hand
Return Value: none
Algorithim:
	1. Create string, iterate through players hand and place each card into the string
	2. Print out that string.


*****************************************************/
void Player::printCards(vector<Card> hand)
{
	string printHand;
	unsigned int size = hand.size();
	//Iterates through each card in player's hand
	for (unsigned int i = 0; i < size; i++)
	{
		//Add each card to the string
		printHand += hand[i].getVal() + hand[i].getSuite() + " ";

	}

	//Printing out players complete hand
	cout << printHand;
}

/****************************************************
Function Name: checkRun
Purpose: Checks for all runs of a particular size in the player's hand
Parameters: vector card player hand, integer for round and integer for wanted run size
Return Value: a double vector of card that stores all runs of wanted size
Algorithim:
	1. Create iteration that begins at first card in players hand.
		2. Create another iteration that begins at the card after the previous iteration.
		3. Check if these two cards can qualitfy for a run. Push back cards into vector if they do.
		4. Continue to each card. If the vector of cards is of wanted size parameter, then push back vector into double vector of Card.
	5. Each run of size wantedSize should be inside the double vector Card. Return that double vector.


*****************************************************/
vector<vector<Card>> Player::checkRun(vector<Card> hand, int round, int wantedSize)
{

	vector<Card> run;
	vector<vector<Card>> wantedRuns;


	//Iteration that goes through each card of players hand
	for (int j = 0; j < hand.size(); j++)
	{
		//Pushing back the card that we begin this iteration on
		//Set runIncrement to 1 and increment it if a card is found.
		run.push_back(hand[j]);
		int runIncrement = 1;

		//Iteration that goes through the players hand, but start at the card after the first iteration.
		for (int k = j + 1; k < hand.size(); k++)
		{

			//Check if this card is of the same suite as previous card, and if the value is +1 of the previous card.
			if (hand[k].getNumValue() == hand[j].getNumValue() + runIncrement)
			{

				if (hand[k].getSuite() == hand[j].getSuite())
				{
					//Pushing back this card into vector and incrementing runIncrement for next iteration
					run.push_back(hand[k]);
					runIncrement++;

					//Check if the vector is of wantedSize parameter, If so, push back this vector into double vector and break out of this iteration.
					if (run.size() == wantedSize)
					{

						wantedRuns.push_back(run);

						break;
					}
				}


			}
			//Check if this card is a joker
			if (hand[k].getNumValue() == 50)
			{
				//Calls function in Player Class
				//Searches through players current run vector and checks if this joker card has already been used in it.
				if (searchUsedWild(run, hand[k]) == false)
				{

					//Pushing back this card into vector and incrementing runIncrement for next iteration
					run.push_back(hand[k]);
					runIncrement++;
					if (run.size() == wantedSize)
					{

						//Check if the vector is of wantedSize parameter, If so, push back this vector into double vector and break out of this iteration.
						wantedRuns.push_back(run);

						break;
					}
				}
			}

			//Check if this card is a wild card for round
			if (hand[k].getNumValue() == round)
			{
				//Calls function in Player Class
				//Searches through players current run vector and checks if this wild card has already been used in it.
				if (searchUsedWild(run, hand[k]) == false)
				{

					//Pushing back this card into vector and incrementing runIncrement for next iteration
					run.push_back(hand[k]);
					runIncrement++;

					//Check if the vector is of wantedSize parameter, If so, push back this vector into double vector and break out of this iteration.
					if (run.size() == wantedSize)
					{
						wantedRuns.push_back(run);

						break;
					}
				}
			}

			//Checks if the card is same suite as previous card, but its value is +2 of the previous card
			if (hand[k].getNumValue() == hand[j].getNumValue() + (runIncrement + 1))
			{
				if (hand[k].getSuite() == hand[j].getSuite())
				{

					//Checks if the last card of the player's hand is a wild or joker
					if (hand[hand.size() - 1].getNumValue() == 50 || hand[hand.size() - 1].getNumValue() == round)
					{

						//Checks if this joker or wild has been already used in the run
						if (searchUsedWild(run, hand[hand.size() - 1]) == false)
						{

							//Pushes back the joker or wild first, then the card thats value is +2 of previous card
							run.push_back(hand[hand.size() - 1]);
							run.push_back(hand[k]);
							runIncrement++;

							//Check if the vector is of wantedSize parameter, If so, push back this vector into double vector and break out of this iteration.
							if (run.size() == wantedSize)
							{
								wantedRuns.push_back(run);

								break;
							}
						}
					}
				}
			}

		}
		//Clears out the run in order to build onto the next card, and iterate through that card

		run.clear();
	}
	//Returing double vector that contains all runs of players hand of wantedSize

	return wantedRuns;


}
/****************************************************
Function Name: checkBook
Purpose: Checks for all books of a particular size in the player's hand
Parameters: vector card player hand, integer for round and integer for wanted book size
Return Value: a double vector of card that stores all books of wanted size
Algorithim:
	1. Create iteration that begins at first card in players hand.
		2. Create another iteration that begins at the card after the previous iteration.
		3. Check if these two cards can qualitfy for a book. Push back cards into vector if they do.
		4. Continue to each card. If the vector of cards is of wanted size parameter, then push back vector into double vector of Card.
	5. Each book of size wantedSize should be inside the double vector Card. Return that double vector.


*****************************************************/
vector<vector<Card>> Player::checkBook(vector<Card> hand, int round, int wantedSize)
{

	vector<Card> book;
	vector<vector<Card>> wantedBooks;

	//Iteration that goes through each card of players hand
	for (int j = 0; j < hand.size(); j++)
	{
		
		//Pushing back the card that we begin this iteration on

		book.push_back(hand[j]);

		//Iteration that goes through the players hand, but start at the card after the first iteration.
		for (int k = j + 1; k < hand.size(); k++)
		{
			//Check if this card is of the same value of the previous card
			if (hand[k].getNumValue() == hand[j].getNumValue())
			{
				//Pushing back this card into vector and incrementing runIncrement for next iteration
				book.push_back(hand[k]);
				
				//Check if the vector is of wantedSize parameter, If so, push back this vector into double vector and break out of this iteration.
				if (book.size() == wantedSize)
				{
					wantedBooks.push_back(book);
					break;
				}

			}
			//Check if this card is a joker
			if (hand[k].getNumValue() == 50)
			{
				//Checks if the current book size is of wanted size -1, and if it is, push back that joker and return the book vector
				if (book.size() == wantedSize - 1)
				{

					for (int i = k; i < hand.size(); i++)
					{
						vector<Card> wildCase = book;
						wildCase.push_back(hand[i]);
						wantedBooks.push_back(wildCase);
					}
					break;
				}

				//Checks if the current book size is of wanted size -2 and if there are two wilds or jokers at the end of the player's hand
				//If there is, push back those wilds or jokers and return the book vector
				if (book.size() == wantedSize - 2)
				{

					for (int i = k; i < hand.size(); i++)
					{
						if ((i + 1) < hand.size())
						{
							vector<Card> wildCase = book;
							wildCase.push_back(hand[i]);
							wildCase.push_back(hand[i + 1]);
							wantedBooks.push_back(wildCase);

						}
					}
					break;
				}
				//Checks if the current book size is of wanted size -3 and if there are three wilds or jokers at the end of the player's hand
				//If there is, push back those wilds or jokers and return the book vector
				if (book.size() == wantedSize - 3)
				{

					for (int i = k; i < hand.size(); i++)
					{

						if ((i + 2) < hand.size())
						{
							vector<Card> wildCase = book;
							wildCase.push_back(hand[i]);
							wildCase.push_back(hand[i + 1]);
							wildCase.push_back(hand[i + 2]);
							wantedBooks.push_back(wildCase);

						}

					}
					break;
				}
				//Checks if the current book size is of wanted size -4 and if there are four wilds or jokers at the end of the player's hand
				//If there is, push back those wilds or jokers and return the book vector
				if (book.size() == wantedSize - 4)
				{

					for (int i = k; i < hand.size(); i++)
					{

						if ((i + 3) < hand.size())
						{
							vector<Card> wildCase = book;
							wildCase.push_back(hand[i]);
							wildCase.push_back(hand[i + 1]);
							wildCase.push_back(hand[i + 2]);
							wildCase.push_back(hand[i + 3]);
							wantedBooks.push_back(wildCase);
						}


					}
					break;
				}

			}
			//Check if this card is a wild
			if (hand[k].getNumValue() == round)
			{
				//Checks if the current book size is of wanted size -1, and if it is, push back that wild and return the book vector
				if (book.size() == wantedSize - 1)
				{

					for (int i = k; i < hand.size(); i++)
					{
						vector<Card> wildCase = book;
						wildCase.push_back(hand[i]);
						wantedBooks.push_back(wildCase);
					}
					break;
				}
				//Checks if the current book size is of wanted size -2 and if there are two wilds or jokers at the end of the player's hand
				//If there is, push back those wilds or jokers and return the book vector
				if (book.size() == wantedSize - 2)
				{

					for (int i = k; i < hand.size(); i++)
					{
						if ((i + 1) < hand.size())
						{
							vector<Card> wildCase = book;
							wildCase.push_back(hand[i]);
							wildCase.push_back(hand[i + 1]);
							wantedBooks.push_back(wildCase);

						}
					}
					break;
				}
				//Checks if the current book size is of wanted size -3 and if there are three wilds or jokers at the end of the player's hand
				//If there is, push back those wilds or jokers and return the book vector
				if (book.size() == wantedSize - 3)
				{

					for (int i = k; i < hand.size(); i++)
					{

						if ((i + 2) < hand.size())
						{
							vector<Card> wildCase = book;
							wildCase.push_back(hand[i]);
							wildCase.push_back(hand[i + 1]);
							wildCase.push_back(hand[i + 2]);
							wantedBooks.push_back(wildCase);
						}


					}
					break;
				}
				//Checks if the current book size is of wanted size -4 and if there are four wilds or jokers at the end of the player's hand
				//If there is, push back those wilds or jokers and return the book vector
				if (book.size() == wantedSize - 4)
				{
					for (int i = k; i < hand.size(); i++)
					{

						if ((i + 3) < hand.size())
						{
							vector<Card> wildCase = book;
							wildCase.push_back(hand[i]);
							wildCase.push_back(hand[i + 1]);
							wildCase.push_back(hand[i + 2]);
							wildCase.push_back(hand[i + 3]);
							wantedBooks.push_back(wildCase);
						}


					}
					break;
				}
			}

		}
		//Clears out the book in order to build onto the next card, and iterate through that card
		book.clear();
	}

	//Returning double vector that contains all books of players hand of wantedSize
	return wantedBooks;

}


/****************************************************
Function Name: checkComputerGoOut
Purpose: Go through all combinations of runs and books a player can have depending on the round, 
		and check if there is a combination that has no duplicate cards and uses all cards in player's hand
Parameters: vector card player hand, integer for round and string for which player is calling the function
Return Value: a vector Card that returns null if the player can go out, if not, returns the players whole hand
Algorithim:
	1. Sort the player's hand and put all wilds and jokers at the end of the hand.
	2. Have a condition for each round of the game. In each condition, call the functions checkRun and checkBook in Player class.
	3. Depending on the round, call these functions with a particular wanted Size that can let the player go out.
		Ex. If the round is 6, the player gets 8 cards. So, call checkBook and checkRun with wanted size 8, 5, 4, and 3.
		Then, call function checkPossibilites in player class with parameters that can add up to total cards in players hand,
		such as, checkPossibilies( book5, run 3).
		If this function returns true, then there exists a book of 5 and run of 3 in the player's hand that do not have duplicate cards.
		Thus, the player can go out with this combination.
	4. Go through all these possibilites for every round.
	5. Return a null hand if the player can go out. Else, return the original hand.


*****************************************************/
vector<Card> Player::checkComputerGoOut(vector<Card> hand, int round, string player)
{
	//Sorting the players hand except for wilds
	sort(hand.begin(), hand.end());

	vector<Card> wilds;
	vector<Card> searchingHand;

	//Creating a vector Card of the player's hand that does not contain wilds or joker
	for (int i = 0; i < hand.size(); i++)
	{
		if (hand[i].getNumValue() != 50)
		{
			if (hand[i].getNumValue() != round)
			{
				searchingHand.push_back(hand[i]);
			}
		}
	}
	//Creating a vector Card of the player's hand that only contains wilds and jokers
	for (int i = 0; i < hand.size(); i++)
	{
		if (hand[i].getNumValue() == 50)
		{
			wilds.push_back(hand[i]);
		}
		if (hand[i].getNumValue() == round)
		{
			wilds.push_back(hand[i]);
		}
	}

	//Place all wilds and jokers to the back of the players hand.
	if (wilds.size() != 0)
	{
		for (int i = 0; i < wilds.size();i++)
		{
			searchingHand.push_back(wilds[i]);
		}
	}

	//Condition when player's recieve 3 cards.
	if (round == 3)
	{


		//Call function checkBook to recieve all books of wanted size
		vector<vector<Card>> book3 = checkBook(searchingHand, 3, 3);

		//If there is a book of 3, the player can go out, return nullHand.
		if (book3.empty() != true)
		{

			cout << "The " << player << " has a: Book of 3 ... ";
			printCards(book3[0]);
			vector<Card> nullHand;
			return nullHand;

		}

		//Call function checkRun to recieve all runs of wanted size
		vector<vector<Card>> run3 = checkRun(searchingHand, 3, 3);

		//If there is a run of 3, the player can go out, return nullHand.
		if (run3.empty() != true)
		{
			cout << "The " << player << " has a: Run of 3 ... ";
			printCards(run3[0]);
			vector<Card> nullHand;
			return nullHand;

		}

	}
	if (round == 4)
	{
		//Call function checkBook to recieve all books of wanted size
		vector<vector<Card>> book4 = checkBook(searchingHand, 4, 4);

		//If there is a book of 4, the player can go out, return nullHand.
		if (book4.empty() != true)
		{

			cout << "The " << player << " has a: Book of 4 ... ";
			printCards(book4[0]);
			vector<Card> nullHand;
			return nullHand;

		}

		//Call function checkRun to recieve all runs of wanted size
		vector<vector<Card>> run4 = checkRun(searchingHand, 4, 4);

		//If there is a run of 4, the player can go out, return nullHand.
		if (run4.empty() != true)
		{
			cout << "The " << player << " has a: Run of 4 ... ";
			printCards(run4[0]);
			vector<Card> nullHand;
			return nullHand;

		}

	}
	if (round == 5)
	{
		//Call function checkBook to recieve all books of wanted size
		vector<vector<Card>> book5 = checkBook(searchingHand, 5, 5);

		//If there is a book of 5, the player can go out, return nullHand.
		if (book5.empty() != true)
		{

			cout << "The " << player << " has a: Book of 5 ... ";
			printCards(book5[0]);
			vector<Card> nullHand;
			return nullHand;

		}

		//Call function checkRun to recieve all runs of wanted size
		vector<vector<Card>> run5 = checkRun(searchingHand, 5, 5);

		//If there is a run of 5, the player can go out, return nullHand.
		if (run5.empty() != true)
		{
			cout << "The " << player << " has a: Run of 5 ... ";
			printCards(run5[0]);
			vector<Card> nullHand;
			return nullHand;

		}

	}
	if (round == 6)
	{
		//Call function checkBook to recieve all books of wanted size that can be possible for the round
		vector<vector<Card>> book6 = checkBook(searchingHand, 6, 6);
		vector<vector<Card>> book3 = checkBook(searchingHand, 6, 3);

		//Call function checkRun to recieve all runs of wanted size that can be possible for the round
		vector<vector<Card>> run6 = checkRun(searchingHand, 6, 6);
		vector<vector<Card>> run3 = checkRun(searchingHand, 6, 3);

		//If there is a book of 6, the player can go out, return nullHand.
		if (book6.empty() != true)
		{

			cout << "The " << player << " has a: Book of 6 ... ";
			printCards(book6[0]);
			vector<Card> nullHand;
			return nullHand;

		}
		//If there is a run of 6, the player can go out, return nullHand.
		if (run6.empty() != true)
		{
			cout << "The " << player << " has a: Run of 6 ... ";
			printCards(run6[0]);
			vector<Card> nullHand;
			return nullHand;

		}

		//GOING THROUGH ALL POSSIBILITES OF ROUND
		//Calling checkOutPossibilites from Player class
		//The # of cards are: 6
		//The possible combinations tested are ... book3 run3, book3 book3, run3 run3
		//If a combination is true, return null vector for player to go out
		int win1 = checkOutPossibilites(book3, run3, player);
		if (win1 == 1)
		{
			cout << "\nThe first set is used as a book of 3\n";
			cout << "The second set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}

		int win2 = checkOutPossibilites(book3, book3, player);
		if (win2 == 1)
		{
			cout << "\nThe first set is used as a book of 3\n";
			cout << "The second set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}

		int win3 = checkOutPossibilites(run3, run3, player);
		if (win3 == 1)
		{
			cout << "\nThe first set is used as a run of 3\n";
			cout << "The second set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}

	}
	if (round == 7)
	{
		//Call function checkBook to recieve all books of wanted size that can be possible for the round
		vector<vector<Card>> book7 = checkBook(searchingHand, 7, 7);
		vector<vector<Card>> book4 = checkBook(searchingHand, 7, 4);
		vector<vector<Card>> book3 = checkBook(searchingHand, 7, 3);

		//Call function checkRun to recieve all runs of wanted size that can be possible for the round
		vector<vector<Card>> run7 = checkRun(searchingHand, 7, 7);
		vector<vector<Card>> run4 = checkRun(searchingHand, 7, 4);
		vector<vector<Card>> run3 = checkRun(searchingHand, 7, 3);

		//If there is a book of 7, the player can go out, return nullHand.
		if (book7.empty() != true)
		{

			cout << "The " << player << " has a: Book of 7 ... ";
			printCards(book7[0]);
			vector<Card> nullHand;
			return nullHand;

		}
		//If there is a run of 7, the player can go out, return nullHand.
		if (run7.empty() != true)
		{
			cout << "The " << player << " has a: Run of 7 ... ";
			printCards(run7[0]);
			vector<Card> nullHand;
			return nullHand;

		}

		//GOING THROUGH ALL POSSIBILITES OF ROUND
		//Calling checkOutPossibilites from Player class
		//The # of cards are: 7
		//The possible combinations tested are ... (book4 run3), (book4 book3), (run4 run3), (run4 book3)
		//If a combination is true, return null vector for player to go out
		int win1 = checkOutPossibilites(book4, book3, player);
		if (win1 == 1)
		{
			cout << "\nThe first set is used as a book of 4\n";
			cout << "The second set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}

		int win2 = checkOutPossibilites(book4, run3, player);
		if (win2 == 1)
		{
			cout << "\nThe first set is used as a book of 4\n";
			cout << "The second set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}

		int win3 = checkOutPossibilites(run4, run3, player);
		if (win3 == 1)
		{
			cout << "\nThe first set is used as a run of 4\n";
			cout << "The second set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win4 = checkOutPossibilites(run4, book3, player);
		if (win4 == 1)
		{
			cout << "\nThe first set is used as a book of 4\n";
			cout << "The second set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
	}
	if (round == 8)
	{
		//Call function checkBook to recieve all books of wanted size that can be possible for the round
		vector<vector<Card>> book8 = checkBook(searchingHand, 8, 8);
		vector<vector<Card>> book5 = checkBook(searchingHand, 8, 5);
		vector<vector<Card>> book4 = checkBook(searchingHand, 8, 4);
		vector<vector<Card>> book3 = checkBook(searchingHand, 8, 3);

		//Call function checkRun to recieve all runs of wanted size that can be possible for the round
		vector<vector<Card>> run8 = checkRun(searchingHand, 8, 8);
		vector<vector<Card>> run5 = checkRun(searchingHand, 8, 5);
		vector<vector<Card>> run4 = checkRun(searchingHand, 8, 4);
		vector<vector<Card>> run3 = checkRun(searchingHand, 8, 3);

		//If there is a book of 8, the player can go out, return nullHand.
		if (book8.empty() != true)
		{

			cout << "The " << player << " has a: Book of 8 ... ";
			printCards(book8[0]);
			vector<Card> nullHand;
			return nullHand;

		}
		//If there is a run of 8, the player can go out, return nullHand.
		if (run8.empty() != true)
		{
			cout << "The " << player << " has a: Run of 8 ... ";
			printCards(run8[0]);
			vector<Card> nullHand;
			return nullHand;

		}

		//GOING THROUGH ALL POSSIBILITES OF ROUND
		//Calling checkOutPossibilites from Player class
		//The # of cards are: 8
		//The possible combinations tested are ... (book5 run3), (book5 book3), (run5 run3), (run5 book3)
		//											(book4 run4), (book4 book4), (run4 run4)
		//If a combination is true, return null vector for player to go out
		int win1 = checkOutPossibilites(book5, book3, player);
		if (win1 == 1)
		{
			cout << "\nThe first set is used as a book of 5\n";
			cout << "The second set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}

		int win2 = checkOutPossibilites(book5, run3, player);
		if (win2 == 1)
		{
			cout << "\nThe first set is used as a book of 5\n";
			cout << "The second set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}

		int win3 = checkOutPossibilites(run5, run3, player);
		if (win3 == 1)
		{
			cout << "\nThe first set is used as a run of 5\n";
			cout << "The second set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}

		int win4 = checkOutPossibilites(run5, book3, player);
		if (win4 == 1)
		{
			cout << "\nThe first set is used as a run of 5\n";
			cout << "The second set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}

		int win5 = checkOutPossibilites(book4, book4, player);
		if (win5 == 1)
		{
			cout << "\nThe first set is used as a book of 4\n";
			cout << "The second set is used as a book of 4\n";
			vector<Card> nullHand;
			return nullHand;
		}

		int win6 = checkOutPossibilites(book4, run4, player);
		if (win6 == 1)
		{
			cout << "\nThe first set is used as a book of 4\n";
			cout << "The second set is used as a run of 4\n";
			vector<Card> nullHand;
			return nullHand;
		}

		int win7 = checkOutPossibilites(run4, run4, player);
		if (win7 == 1)
		{
			cout << "\nThe first set is used as a run of 4\n";
			cout << "The second set is used as a run of 4\n";
			vector<Card> nullHand;
			return nullHand;
		}


	}
	if (round == 9)
	{
		//Call function checkBook to recieve all books of wanted size that can be possible for the round
		vector<vector<Card>> book9 = checkBook(searchingHand, 9, 9);
		vector<vector<Card>> book6 = checkBook(searchingHand, 9, 6);
		vector<vector<Card>> book5 = checkBook(searchingHand, 9, 5);
		vector<vector<Card>> book4 = checkBook(searchingHand, 9, 4);
		vector<vector<Card>> book3 = checkBook(searchingHand, 9, 3);

		//Call function checkRun to recieve all runs of wanted size that can be possible for the round
		vector<vector<Card>> run9 = checkRun(searchingHand, 9, 9);
		vector<vector<Card>> run6 = checkRun(searchingHand, 9, 6);
		vector<vector<Card>> run5 = checkRun(searchingHand, 9, 5);
		vector<vector<Card>> run4 = checkRun(searchingHand, 9, 4);
		vector<vector<Card>> run3 = checkRun(searchingHand, 9, 3);

		//If there is a book of 9, the player can go out, return nullHand.
		if (book9.empty() != true)
		{

			cout << "The " << player << " has a: Book of 9 ... ";
			printCards(book9[0]);
			vector<Card> nullHand;
			return nullHand;

		}
		//If there is a run of 9, the player can go out, return nullHand.
		if (run9.empty() != true)
		{
			cout << "The " << player << " has a: Run of 9 ... ";
			printCards(run9[0]);
			vector<Card> nullHand;
			return nullHand;

		}

		//GOING THROUGH ALL POSSIBILITES OF ROUND
		//Calling checkOutPossibilites from Player class
		//The # of cards are: 9
		//The possible combinations tested are ... (book6 run3), (book6 book3), (run6 run3), (run6 book3)
		//											(book5 run4), (book5 book4), (run5 run4), (run5 book4)
		//											(book3 book3 book3), (book3 book3 run3), (book3 run3 run3), (run3 run3 run3)
		//If a combination is true, return null vector for player to go out
		int win1 = checkOutPossibilites(book6, book3, player);
		if (win1 == 1)
		{
			cout << "\nThe first set is used as a book of 6\n";
			cout << "The second set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win2 = checkOutPossibilites(book6, run3, player);
		if (win2 == 1)
		{
			cout << "\nThe first set is used as a book of 6\n";
			cout << "The second set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win3 = checkOutPossibilites(run6, book3, player);
		if (win3 == 1)
		{
			cout << "\nThe first set is used as a run of 6\n";
			cout << "The second set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win4 = checkOutPossibilites(run6, run3, player);
		if (win4 == 1)
		{
			cout << "\nThe first set is used as a run of 6\n";
			cout << "The second set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}

		int win5 = checkOutPossibilites(book5, book4, player);
		if (win5 == 1)
		{
			cout << "\nThe first set is used as a book of 5\n";
			cout << "The second set is used as a book of 4\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win6 = checkOutPossibilites(book5, run4, player);
		if (win6 == 1)
		{
			cout << "\nThe first set is used as a book of 5\n";
			cout << "The second set is used as a run of 4\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win7 = checkOutPossibilites(run5, run4, player);
		if (win7 == 1)
		{
			cout << "\nThe first set is used as a run of 5\n";
			cout << "The second set is used as a book of 4\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win8 = checkOutPossibilites(run5, book4, player);
		if (win8 == 1)
		{
			cout << "\nThe first set is used as a run of 5\n";
			cout << "The second set is used as a book of 4\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win9 = checkOutThree(book3, book3, book3, player);
		if (win9 == 1)
		{
			cout << "\nThe first set is used as a book of 3\n";
			cout << "The second set is used as a book of 3\n";
			cout << "The third set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win10 = checkOutThree(book3, book3, run3, player);
		if (win10 == 1)
		{
			cout << "\nThe first set is used as a book of 3\n";
			cout << "The second set is used as a book of 3\n";
			cout << "The third set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win11 = checkOutThree(book3, run3, run3, player);
		if (win11 == 1)
		{
			cout << "\nThe first set is used as a book of 3\n";
			cout << "The second set is used as a run of 3\n";
			cout << "The third set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win12 = checkOutThree(run3, run3, run3, player);
		if (win12 == 1)
		{
			cout << "\nThe first set is used as a run of 3\n";
			cout << "The second set is used as a run of 3\n";
			cout << "The third set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}



	}
	if (round == 10)
	{

		//Call function checkBook to recieve all books of wanted size that can be possible for the round
		vector<vector<Card>> book10 = checkBook(searchingHand, 10, 10);
		vector<vector<Card>> book7 = checkBook(searchingHand, 10, 7);
		vector<vector<Card>> book6 = checkBook(searchingHand, 10, 6);
		vector<vector<Card>> book5 = checkBook(searchingHand, 10, 5);
		vector<vector<Card>> book4 = checkBook(searchingHand, 10, 4);
		vector<vector<Card>> book3 = checkBook(searchingHand, 10, 3);

		//Call function checkRun to recieve all runs of wanted size that can be possible for the round
		vector<vector<Card>> run10 = checkRun(searchingHand, 10, 10);
		vector<vector<Card>> run7 = checkBook(searchingHand, 10, 7);
		vector<vector<Card>> run6 = checkRun(searchingHand, 10, 6);
		vector<vector<Card>> run5 = checkRun(searchingHand, 10, 5);
		vector<vector<Card>> run4 = checkRun(searchingHand, 10, 4);
		vector<vector<Card>> run3 = checkRun(searchingHand, 10, 3);

		//If there is a book of 10, the player can go out, return nullHand.
		if (book10.empty() != true)
		{


			cout << "The " << player << " has a: Book of 10 ... ";
			printCards(book10[0]);
			vector<Card> nullHand;
			return nullHand;

		}
		//If there is a run of 10, the player can go out, return nullHand.
		if (run10.empty() != true)
		{

			cout << "The " << player << " has a: Run of 10 ... ";
			printCards(run10[0]);
			vector<Card> nullHand;
			return nullHand;

		}

		//GOING THROUGH ALL POSSIBILITES OF ROUND
		//Calling checkOutPossibilites from Player class
		//The # of cards are: 10
		//The possible combinations tested are ... (book7 run3), (book7 book3), (run7 run3), (run7 book3)
		//											(book6 run4), (book6 book4), (run6 run4), (run6 book4)
		//											(book5 run5), (book5 book5), (run5 run5)
		//											(book4 book3 book3), (book4 book3 run3), (book4 run3 run3), (run4 run3 run3)
		//If a combination is true, return null vector for player to go out
		int win1 = checkOutPossibilites(book7, book3, player);
		if (win1 == 1)
		{
			cout << "\nThe first set is used as a book of 7\n";
			cout << "The second set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win2 = checkOutPossibilites(book7, run3, player);
		if (win2 == 1)
		{
			cout << "\nThe first set is used as a book of 7\n";
			cout << "The second set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win3 = checkOutPossibilites(run7, book3, player);
		if (win3 == 1)
		{
			cout << "\nThe first set is used as a run of 7\n";
			cout << "The second set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win4 = checkOutPossibilites(run7, run3, player);
		if (win4 == 1)
		{
			cout << "\nThe first set is used as a run of 7\n";
			cout << "The second set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}

		int win5 = checkOutPossibilites(book6, book4, player);
		if (win5 == 1)
		{
			cout << "\nThe first set is used as a book of 6\n";
			cout << "The second set is used as a book of 4\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win6 = checkOutPossibilites(book6, run4, player);
		if (win6 == 1)
		{
			cout << "\nThe first set is used as a book of 6\n";
			cout << "The second set is used as a run of 4\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win7 = checkOutPossibilites(run6, run4, player);
		if (win7 == 1)
		{
			cout << "\nThe first set is used as a run of 6\n";
			cout << "The second set is used as a book of 4\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win8 = checkOutPossibilites(run6, book4, player);
		if (win8 == 1)
		{
			cout << "\nThe first set is used as a run of 6\n";
			cout << "The second set is used as a book of 4\n";
			vector<Card> nullHand;
			return nullHand;
		}

		int win9 = checkOutPossibilites(book5, run5, player);
		if (win9 == 1)
		{
			cout << "\nThe first set is used as a book of 5\n";
			cout << "The second set is used as a run of 5\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win10 = checkOutPossibilites(run5, run5, player);
		if (win10 == 1)
		{
			cout << "\nThe first set is used as a run of 5\n";
			cout << "The second set is used as a run of 5\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win11 = checkOutPossibilites(book5, book5, player);
		if (win11 == 1)
		{
			cout << "\nThe first set is used as a book of 5\n";
			cout << "The second set is used as a book of 5\n";
			vector<Card> nullHand;
			return nullHand;
		}
		//
		int win12 = checkOutThree(book4, book3, book3, player);
		if (win12 == 1)
		{
			cout << "\nThe first set is used as a book of 4\n";
			cout << "The second set is used as a book of 3\n";
			cout << "The third set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win13 = checkOutThree(book4, run3, book3, player);
		if (win13 == 1)
		{
			cout << "\nThe first set is used as a book of 4\n";
			cout << "The second set is used as a run of 3\n";
			cout << "The third set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win14 = checkOutThree(book4, run3, run3, player);
		if (win14 == 1)
		{
			cout << "\nThe first set is used as a book of 4\n";
			cout << "The second set is used as a run of 3\n";
			cout << "The third set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win15 = checkOutThree(run4, book3, book3, player);
		if (win15 == 1)
		{
			cout << "\nThe first set is used as a run of 4\n";
			cout << "The second set is used as a book of 3\n";
			cout << "The third set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win16 = checkOutThree(run4, run3, book3, player);
		if (win16 == 1)
		{
			cout << "\nThe first set is used as a run of 4\n";
			cout << "The second set is used as a run of 3\n";
			cout << "The third set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win17 = checkOutThree(run4, run3, run3, player);
		if (win17 == 1)
		{
			cout << "\nThe first set is used as a run of 4\n";
			cout << "The second set is used as a run of 3\n";
			cout << "The third set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}


	}
	if (round == 11)
	{

		//Call function checkBook to recieve all books of wanted size that can be possible for the round
		vector<vector<Card>> book11 = checkBook(searchingHand, 11, 11);
		vector<vector<Card>> book8 = checkBook(searchingHand, 11, 8);
		vector<vector<Card>> book7 = checkBook(searchingHand, 11, 7);
		vector<vector<Card>> book6 = checkBook(searchingHand, 11, 6);
		vector<vector<Card>> book5 = checkBook(searchingHand, 11, 5);
		vector<vector<Card>> book4 = checkBook(searchingHand, 11, 4);
		vector<vector<Card>> book3 = checkBook(searchingHand, 11, 3);

		//Call function checkRun to recieve all runs of wanted size that can be possible for the round
		vector<vector<Card>> run11 = checkRun(searchingHand, 11, 11);
		vector<vector<Card>> run8 = checkRun(searchingHand, 11, 8);
		vector<vector<Card>> run7 = checkBook(searchingHand, 11, 7);
		vector<vector<Card>> run6 = checkRun(searchingHand, 11, 6);
		vector<vector<Card>> run5 = checkRun(searchingHand, 11, 5);
		vector<vector<Card>> run4 = checkRun(searchingHand, 11, 4);
		vector<vector<Card>> run3 = checkRun(searchingHand, 11, 3);

		//If there is a book of 11, the player can go out, return nullHand.
		if (book11.empty() != true)
		{


			cout << "The " << player << " has a: Book of 11 ... ";
			printCards(book11[0]);
			vector<Card> nullHand;
			return nullHand;

		}//If there is a run of 11, the player can go out, return nullHand.
		if (run11.empty() != true)
		{

			cout << "The " << player << " has a: Run of 11 ... ";
			printCards(run11[0]);
			vector<Card> nullHand;
			return nullHand;

		}

		//GOING THROUGH ALL POSSIBILITES OF ROUND
		//Calling checkOutPossibilites from Player class
		//The # of cards are: 11
		//The possible combinations tested are ... (book8 run3), (book8 book3), (run8 run3), (run8 book3)
		//											(book7 run4), (book7 book4), (run7 run4), (run7 book4)
		//											(book6 run5), (book6 book5), (run6 run5), (run6 book5)
		//											(book5 book3 book3), (book5 book3 run3), (book5 run3 run3), (run5 run3 run3)
		//											(book4 book4 book3), (book4 book4 run3), (book4 run4 run3), (run4 run4 run3)
		//If a combination is true, return null vector for player to go out
		int win1 = checkOutPossibilites(book8, book3, player);
		if (win1 == 1)
		{
			cout << "\nThe first set is used as a book of 8\n";
			cout << "The second set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win2 = checkOutPossibilites(book8, run3, player);
		if (win2 == 1)
		{
			cout << "\nThe first set is used as a book of 8\n";
			cout << "The second set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win3 = checkOutPossibilites(run8, book3, player);
		if (win3 == 1)
		{
			cout << "\nThe first set is used as a run of 8\n";
			cout << "The second set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win4 = checkOutPossibilites(run8, run3, player);
		if (win4 == 1)
		{
			cout << "\nThe first set is used as a run of 8\n";
			cout << "The second set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}

		int win5 = checkOutPossibilites(book7, book4, player);
		if (win5 == 1)
		{
			cout << "\nThe first set is used as a book of 7\n";
			cout << "The second set is used as a book of 4\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win6 = checkOutPossibilites(book7, run4, player);
		if (win6 == 1)
		{
			cout << "\nThe first set is used as a book of 7\n";
			cout << "The second set is used as a run of 4\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win7 = checkOutPossibilites(run7, run4, player);
		if (win7 == 1)
		{
			cout << "\nThe first set is used as a run of 7\n";
			cout << "The second set is used as a book of 4\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win8 = checkOutPossibilites(run7, book4, player);
		if (win8 == 1)
		{
			cout << "\nThe first set is used as a run of 7\n";
			cout << "The second set is used as a book of 4\n";
			vector<Card> nullHand;
			return nullHand;
		}

		int win9 = checkOutPossibilites(book6, run5, player);
		if (win9 == 1)
		{
			cout << "\nThe first set is used as a book of 6\n";
			cout << "The second set is used as a run of 5\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win10 = checkOutPossibilites(run6, run5, player);
		if (win10 == 1)
		{
			cout << "\nThe first set is used as a run of 6\n";
			cout << "The second set is used as a run of 5\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win11 = checkOutPossibilites(book6, book5, player);
		if (win11 == 1)
		{
			cout << "\nThe first set is used as a book of 6\n";
			cout << "The second set is used as a book of 5\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win12 = checkOutPossibilites(run6, book5, player);
		if (win12 == 1)
		{
			cout << "\nThe first set is used as a run of 6\n";
			cout << "The second set is used as a book of 5\n";
			vector<Card> nullHand;
			return nullHand;
		}


		int win13 = checkOutThree(book5, book3, book3, player);
		if (win13 == 1)
		{
			cout << "\nThe first set is used as a book of 5\n";
			cout << "The second set is used as a book of 3\n";
			cout << "The third set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win14 = checkOutThree(book5, run3, book3, player);
		if (win14 == 1)
		{
			cout << "\nThe first set is used as a book of 5\n";
			cout << "The second set is used as a run of 3\n";
			cout << "The third set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win15 = checkOutThree(book5, run3, run3, player);
		if (win15 == 1)
		{
			cout << "\nThe first set is used as a book of 5\n";
			cout << "The second set is used as a run of 3\n";
			cout << "The third set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win16 = checkOutThree(run5, book3, book3, player);
		if (win16 == 1)
		{
			cout << "\nThe first set is used as a run of 5\n";
			cout << "The second set is used as a book of 3\n";
			cout << "The third set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win17 = checkOutThree(run5, run3, book3, player);
		if (win17 == 1)
		{
			cout << "\nThe first set is used as a run of 5\n";
			cout << "The second set is used as a run of 3\n";
			cout << "The third set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win18 = checkOutThree(run5, run3, run3, player);
		if (win18 == 1)
		{
			cout << "\nThe first set is used as a run of 5\n";
			cout << "The second set is used as a run of 3\n";
			cout << "The third set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win19 = checkOutThree(run4, book4, book3, player);
		if (win19 == 1)
		{
			cout << "\nThe first set is used as a run of 4\n";
			cout << "The second set is used as a book of 4\n";
			cout << "The third set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}


	}

	if (round == 12)
	{
		//Call function checkBook to recieve all books of wanted size that can be possible for the round
		vector<vector<Card>> book12 = checkBook(searchingHand, 12, 12);
		vector<vector<Card>> book9 = checkBook(searchingHand, 12, 9);
		vector<vector<Card>> book8 = checkBook(searchingHand, 12, 8);
		vector<vector<Card>> book7 = checkBook(searchingHand, 12, 7);
		vector<vector<Card>> book6 = checkBook(searchingHand, 12, 6);
		vector<vector<Card>> book5 = checkBook(searchingHand, 12, 5);
		vector<vector<Card>> book4 = checkBook(searchingHand, 12, 4);
		vector<vector<Card>> book3 = checkBook(searchingHand, 12, 3);

		//Call function checkRun to recieve all runs of wanted size that can be possible for the round
		vector<vector<Card>> run12 = checkRun(searchingHand, 12, 12);
		vector<vector<Card>> run9 = checkRun(searchingHand, 12, 9);
		vector<vector<Card>> run8 = checkRun(searchingHand, 12, 8);
		vector<vector<Card>> run7 = checkBook(searchingHand, 12, 7);
		vector<vector<Card>> run6 = checkRun(searchingHand, 12, 6);
		vector<vector<Card>> run5 = checkRun(searchingHand, 12, 5);
		vector<vector<Card>> run4 = checkRun(searchingHand, 12, 4);
		vector<vector<Card>> run3 = checkRun(searchingHand, 12, 3);

		//If there is a book of 11, the player can go out, return nullHand.
		if (book12.empty() != true)
		{


			cout << "The " << player << " has a: Book of 12 ... ";
			printCards(book12[0]);
			vector<Card> nullHand;
			return nullHand;

		}
		//If there is a run of 11, the player can go out, return nullHand.
		if (run12.empty() != true)
		{

			cout << "The " << player << " has a: Run of 12 ... ";
			printCards(run12[0]);
			vector<Card> nullHand;
			return nullHand;

		}

		//GOING THROUGH ALL POSSIBILITES OF ROUND
		//Calling checkOutPossibilites from Player class
		//The # of cards are: 12
		//The possible combinations tested are ... (book9 run3), (book9 book3), (run9 run3), (run9 book3)
		//											(book8 run4), (book8 book4), (run8 run4), (run8 book4)
		//											(book7 run5), (book7 book5), (run7 run5), (run7 book5)
		//											(book6 run6), (book6 book6), (run6 run6), (run6 book6)
		//											(book6 book3 book3), (book6 book3 run3), (book6 run3 run3), (run6 run3 run3)
		//											(book5 book4 book3), (book5 book4 run3), (book5 run4 run3), (run5 run4 run3)
		//											(book3 book3 book3 book3), (book3 book3 book3 run3), (book3 run3 run3 book3), (book3 run3 run3 run3), (run3 run3 run3 run3)
		//If a combination is true, return null vector for player to go out
		int win1 = checkOutPossibilites(book9, book3, player);
		if (win1 == 1)
		{
			cout << "\nThe first set is used as a book of 9\n";
			cout << "The second set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win2 = checkOutPossibilites(book9, run3, player);
		if (win2 == 1)
		{
			cout << "\nThe first set is used as a book of 9\n";
			cout << "The second set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win3 = checkOutPossibilites(run9, book3, player);
		if (win3 == 1)
		{
			cout << "\nThe first set is used as a run of 9\n";
			cout << "The second set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win4 = checkOutPossibilites(run9, run3, player);
		if (win4 == 1)
		{
			cout << "\nThe first set is used as a run of 9\n";
			cout << "The second set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}

		int win5 = checkOutPossibilites(book8, book4, player);
		if (win5 == 1)
		{
			cout << "\nThe first set is used as a book of 8\n";
			cout << "The second set is used as a book of 4\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win6 = checkOutPossibilites(book8, run4, player);
		if (win6 == 1)
		{
			cout << "\nThe first set is used as a book of 8\n";
			cout << "The second set is used as a run of 4\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win7 = checkOutPossibilites(run8, run4, player);
		if (win7 == 1)
		{
			cout << "\nThe first set is used as a run of 8\n";
			cout << "The second set is used as a book of 4\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win8 = checkOutPossibilites(run8, book4, player);
		if (win8 == 1)
		{
			cout << "\nThe first set is used as a run of 8\n";
			cout << "The second set is used as a book of 4\n";
			vector<Card> nullHand;
			return nullHand;
		}

		int win9 = checkOutPossibilites(book7, run5, player);
		if (win9 == 1)
		{
			cout << "\nThe first set is used as a book of 7\n";
			cout << "The second set is used as a run of 5\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win10 = checkOutPossibilites(run7, run5, player);
		if (win10 == 1)
		{
			cout << "\nThe first set is used as a run of 7\n";
			cout << "The second set is used as a run of 5\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win11 = checkOutPossibilites(book7, book5, player);
		if (win11 == 1)
		{
			cout << "\nThe first set is used as a book of 7\n";
			cout << "The second set is used as a book of 5\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win12 = checkOutPossibilites(run7, book5, player);
		if (win12 == 1)
		{
			cout << "\nThe first set is used as a run of 7\n";
			cout << "The second set is used as a book of 5\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win13 = checkOutPossibilites(run6, book6, player);
		if (win13 == 1)
		{
			cout << "\nThe first set is used as a run of 6\n";
			cout << "The second set is used as a book of 6\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win14 = checkOutPossibilites(book6, book6, player);
		if (win14 == 1)
		{
			cout << "\nThe first set is used as a book of 6\n";
			cout << "The second set is used as a book of 6\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win15 = checkOutPossibilites(run6, run6, player);
		if (win15 == 1)
		{
			cout << "\nThe first set is used as a run of 6\n";
			cout << "The second set is used as a run of 6\n";
			vector<Card> nullHand;
			return nullHand;
		}


		int win16 = checkOutThree(book6, book3, book3, player);
		if (win16 == 1)
		{
			cout << "\nThe first set is used as a book of 6\n";
			cout << "The second set is used as a book of 3\n";
			cout << "The third set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win17 = checkOutThree(book6, run3, book3, player);
		if (win17 == 1)
		{
			cout << "\nThe first set is used as a book of 6\n";
			cout << "The second set is used as a run of 3\n";
			cout << "The third set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win18 = checkOutThree(book6, run3, run3, player);
		if (win18 == 1)
		{
			cout << "\nThe first set is used as a book of 6\n";
			cout << "The second set is used as a run of 3\n";
			cout << "The third set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win19 = checkOutThree(run6, book3, book3, player);
		if (win19 == 1)
		{
			cout << "\nThe first set is used as a run of 6\n";
			cout << "The second set is used as a book of 3\n";
			cout << "The third set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win20 = checkOutThree(run6, run3, book3, player);
		if (win20 == 1)
		{
			cout << "\nThe first set is used as a run of 6\n";
			cout << "The second set is used as a run of 3\n";
			cout << "The third set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win21 = checkOutThree(run6, run3, run3, player);
		if (win21 == 1)
		{
			cout << "\nThe first set is used as a run of 6\n";
			cout << "The second set is used as a run of 3\n";
			cout << "The third set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win22 = checkOutThree(run4, book5, book3, player);
		if (win22 == 1)
		{
			cout << "\nThe first set is used as a run of 4\n";
			cout << "The second set is used as a book of 5\n";
			cout << "The third set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win23 = checkOutThree(run3, book5, book4, player);
		if (win23 == 1)
		{
			cout << "\nThe first set is used as a run of 4\n";
			cout << "The second set is used as a book of 5\n";
			cout << "The third set is used as a book of 4\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win24 = checkOutFour(book3, book3, book3, book3, player);
		if (win24 == 1)
		{
			cout << "\nThe first set is used as a book of 3\n";
			cout << "The second set is used as a book of 3\n";
			cout << "The third set is used as a book of 3\n";
			cout << "The fourth set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win25 = checkOutFour(book3, book3, book3, run3, player);
		if (win25 == 1)
		{
			cout << "\nThe first set is used as a book of 3\n";
			cout << "The second set is used as a book of 3\n";
			cout << "The third set is used as a book of 3\n";
			cout << "The fourth set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win26 = checkOutFour(book3, book3, run3, run3, player);
		if (win26 == 1)
		{
			cout << "\nThe first set is used as a book of 3\n";
			cout << "The second set is used as a book of 3\n";
			cout << "The third set is used as a run of 3\n";
			cout << "The fourth set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win27 = checkOutFour(book3, run3, run3, run3, player);
		if (win27 == 1)
		{
			cout << "\nThe first set is used as a book of 3\n";
			cout << "The second set is used as a run of 3\n";
			cout << "The third set is used as a run of 3\n";
			cout << "The fourth set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win28 = checkOutFour(run3, run3, run3, run3, player);
		if (win28 == 1)
		{
			cout << "\nThe first set is used as a run of 3\n";
			cout << "The second set is used as a run of 3\n";
			cout << "The third set is used as a run of 3\n";
			cout << "The fourth set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}

	}
	if (round == 13)
	{

		//Call function checkBook to recieve all books of wanted size that can be possible for the round	
		vector<vector<Card>> book13 = checkBook(searchingHand, 13, 13);
		vector<vector<Card>> book10 = checkBook(searchingHand, 13, 10);
		vector<vector<Card>> book9 = checkBook(searchingHand, 13, 9);
		vector<vector<Card>> book8 = checkBook(searchingHand, 13, 8);
		vector<vector<Card>> book7 = checkBook(searchingHand, 13, 7);
		vector<vector<Card>> book6 = checkBook(searchingHand, 13, 6);
		vector<vector<Card>> book5 = checkBook(searchingHand, 13, 5);
		vector<vector<Card>> book4 = checkBook(searchingHand, 13, 4);
		vector<vector<Card>> book3 = checkBook(searchingHand, 13, 3);

		//Call function checkRun to recieve all runs of wanted size that can be possible for the round
		vector<vector<Card>> run13 = checkRun(searchingHand, 13, 13);
		vector<vector<Card>> run10 = checkRun(searchingHand, 13, 10);
		vector<vector<Card>> run9 = checkRun(searchingHand, 13, 9);
		vector<vector<Card>> run8 = checkRun(searchingHand, 13, 8);
		vector<vector<Card>> run7 = checkBook(searchingHand, 13, 7);
		vector<vector<Card>> run6 = checkRun(searchingHand, 13, 6);
		vector<vector<Card>> run5 = checkRun(searchingHand, 13, 5);
		vector<vector<Card>> run4 = checkRun(searchingHand, 13, 4);
		vector<vector<Card>> run3 = checkRun(searchingHand, 13, 3);

		//If there is a book of 11, the player can go out, return nullHand.
		if (book13.empty() != true)
		{


			cout << "The " << player << " has a: Book of 13 ... ";
			printCards(book13[0]);
			vector<Card> nullHand;
			return nullHand;

		}
		//If there is a run of 11, the player can go out, return nullHand.
		if (run13.empty() != true)
		{

			cout << "The " << player << " has a: Run of 13 ... ";
			printCards(run13[0]);
			vector<Card> nullHand;
			return nullHand;

		}

		//GOING THROUGH ALL POSSIBILITES OF ROUND
		//Calling checkOutPossibilites from Player class
		//The # of cards are: 13
		//The possible combinations tested are ... (book10 run3), (book10 book3), (run10 run3), (run10 book3)
		//											(book9 run4), (book9 book4), (run9 run4), (run9 book4)
		//											(book8 run5), (book8 book5), (run8 run5), (run8 book5)
		//											(book7 run6), (book7 book6), (run7 run6), (run7 book6)
		//											(book7 book3 book3), (book7 book3 run3), (book7 run3 run3), (run7 run3 run3)
		//											(book6 book4 book3), (book6 book4 run3), (book6 run4 run3), (run6 run4 run3)
		//											(book4 book3 book3 book3), (book4 book3 book3 run3), (book4 run3 run3 book3), (book4 run3 run3 run3), (run4 run3 run3 run3)
		//If a combination is true, return null vector for player to go out
		int win1 = checkOutPossibilites(book10, book3, player);
		if (win1 == 1)
		{
			cout << "\nThe first set is used as a book of 10\n";
			cout << "The second set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win2 = checkOutPossibilites(book10, run3, player);
		if (win2 == 1)
		{
			cout << "\nThe first set is used as a book of 10\n";
			cout << "The second set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win3 = checkOutPossibilites(run10, book3, player);
		if (win3 == 1)
		{
			cout << "\nThe first set is used as a run of 10\n";
			cout << "The second set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win4 = checkOutPossibilites(run10, run3, player);
		if (win4 == 1)
		{
			cout << "\nThe first set is used as a run of 10\n";
			cout << "The second set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}

		int win5 = checkOutPossibilites(book9, book4, player);
		if (win5 == 1)
		{
			cout << "\nThe first set is used as a book of 9\n";
			cout << "The second set is used as a book of 4\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win6 = checkOutPossibilites(book9, run4, player);
		if (win6 == 1)
		{
			cout << "\nThe first set is used as a book of 9\n";
			cout << "The second set is used as a run of 4\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win7 = checkOutPossibilites(run9, run4, player);
		if (win7 == 1)
		{
			cout << "\nThe first set is used as a run of 9\n";
			cout << "The second set is used as a book of 4\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win8 = checkOutPossibilites(run9, book4, player);
		if (win8 == 1)
		{
			cout << "\nThe first set is used as a run of 9\n";
			cout << "The second set is used as a book of 4\n";
			vector<Card> nullHand;
			return nullHand;
		}

		int win9 = checkOutPossibilites(book8, run5, player);
		if (win9 == 1)
		{
			cout << "\nThe first set is used as a book of 8\n";
			cout << "The second set is used as a run of 5\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win10 = checkOutPossibilites(run8, run5, player);
		if (win10 == 1)
		{
			cout << "\nThe first set is used as a run of 8\n";
			cout << "The second set is used as a run of 5\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win11 = checkOutPossibilites(book8, book5, player);
		if (win11 == 1)
		{
			cout << "\nThe first set is used as a book of 8\n";
			cout << "The second set is used as a book of 5\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win12 = checkOutPossibilites(run8, book5, player);
		if (win12 == 1)
		{
			cout << "\nThe first set is used as a run of 8\n";
			cout << "The second set is used as a book of 5\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win13 = checkOutPossibilites(book7, run6, player);
		if (win13 == 1)
		{
			cout << "\nThe first set is used as a book of 7\n";
			cout << "The second set is used as a run of 6\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win14 = checkOutPossibilites(book7, book6, player);
		if (win14 == 1)
		{
			cout << "\nThe first set is used as a book of 7\n";
			cout << "The second set is used as a book of 6\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win15 = checkOutPossibilites(run7, book6, player);
		if (win15 == 1)
		{
			cout << "\nThe first set is used as a run of 7\n";
			cout << "The second set is used as a book of 6\n";
			vector<Card> nullHand;
			return nullHand;
		}


		int win16 = checkOutThree(book5, book5, book3, player);
		if (win16 == 1)
		{
			cout << "\nThe first set is used as a book of 5\n";
			cout << "The second set is used as a book of 5\n";
			cout << "The third set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win17 = checkOutThree(book5, book5, run3, player);
		if (win17 == 1)
		{
			cout << "\nThe first set is used as a book of 5\n";
			cout << "The second set is used as a book of 5\n";
			cout << "The third set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win18 = checkOutThree(book6, book4, book3, player);
		if (win18 == 1)
		{
			cout << "\nThe first set is used as a book of 6\n";
			cout << "The second set is used as a book of 4\n";
			cout << "The third set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win19 = checkOutThree(book6, book4, run3, player);
		if (win19 == 1)
		{
			cout << "\nThe first set is used as a book of 6\n";
			cout << "The second set is used as a book of 4\n";
			cout << "The third set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win20 = checkOutThree(book6, run4, run3, player);
		if (win20 == 1)
		{
			cout << "\nThe first set is used as a book of 6\n";
			cout << "The second set is used as a run of 4\n";
			cout << "The third set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}

		int win21 = checkOutFour(book4, book3, book3, book3, player);
		if (win21 == 1)
		{
			cout << "\nThe first set is used as a book of 4\n";
			cout << "The second set is used as a book of 3\n";
			cout << "The third set is used as a book of 3\n";
			cout << "The fourth set is used as a book of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win22 = checkOutFour(book4, book3, book3, run3, player);
		if (win22 == 1)
		{
			cout << "\nThe first set is used as a book of 4\n";
			cout << "The second set is used as a book of 3\n";
			cout << "The third set is used as a book of 3\n";
			cout << "The fourth set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win23 = checkOutFour(book4, book3, run3, run3, player);
		if (win23 == 1)
		{
			cout << "\nThe first set is used as a book of 4\n";
			cout << "The second set is used as a book of 3\n";
			cout << "The third set is used as a run of 3\n";
			cout << "The fourth set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win24 = checkOutFour(book4, run3, run3, run3, player);
		if (win24 == 1)
		{
			cout << "\nThe first set is used as a book of 4\n";
			cout << "The second set is used as a run of 3\n";
			cout << "The third set is used as a run of 3\n";
			cout << "The fourth set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}
		int win25 = checkOutFour(run4, run3, run3, run3, player);
		if (win25 == 1)
		{
			cout << "\nThe first set is used as a run of 4\n";
			cout << "The second set is used as a run of 3\n";
			cout << "The third set is used as a run of 3\n";
			cout << "The fourth set is used as a run of 3\n";
			vector<Card> nullHand;
			return nullHand;
		}

	}

	//Returning original hand if no possible way to go out is found

	return hand;

}

/****************************************************
Function Name: checkOutPossibilites
Purpose: Go through all combinations of two double vectors, if there are no cards that are duplicates in both vectors, the player can go out with that combination.
Parameters: double card vector for first book or run combination, double card vector for second book or run combination, string for which player
Return Value: return 1 is found, return 0 if not
Algorithim:
	1. Iterate through first double vector.
		2. Inside this iteration, iterate through second double vector.
			3. Call checkDuplicates from Player class.
			4. If this function returns false, (There are no duplicate cards in the vectors) then the player can go out with this combination.
			5. If true, continue to next combination.
	6. If the double iteration doesn't return 1, then return 0. There are no possible combinations found with these double vectors.


*****************************************************/
int Player::checkOutPossibilites(vector<vector<Card>> possibility1, vector<vector<Card>> possibility2, string player)
{
	//Iterate through each vector in first double vector
	for (int i = 0; i < possibility1.size(); i++)
	{
		//Iterate through each vector in second double vector
		for (int j = 0; j < possibility2.size(); j++)
		{

			//Calls function checkDuplicates from Player class
			//Return false if no duplicate cards found between vectors, found a combination to go out with
			if (checkDuplicates(possibility1[i], possibility2[j]) == false)
			{

				cout << "The " << player << "'s first set is ... ";
				printCards(possibility1[i]);
				cout << "\nThe " << player << "'s second set is ... ";
				printCards(possibility2[j]);
				return 1;
			}
		}
	}

	//No found combination between both double vectors
	return 0;
}

/****************************************************
Function Name: checkOutThree
Purpose: Similar to checkOutPossibilites. Takes in three double vectors instead.
		Go through all combinations of three double vectors, if there are no cards that are duplicates in all vectors, the player can go out with that combination.
Parameters: double card vector for first book or run combination, double card vector for second book or run combination, double card vector for third book or run combination string for which player
Return Value: return 1 is found, return 0 if not
Algorithim:
	1. Iterate through first double vector.
		2. Inside this iteration, iterate through second double vector.
			3. Call checkDuplicates from Player class.
			4. If this function returns false, (There are no duplicate cards in the vectors) then the player can continue with this combination.
				5. Inside this iteration, iterate through third double vector.
					6. Call checkDuplicates from Player class.
					7. If this function returns false, (There are no duplicate cards in the vectors) then the player can go out with this combination of three vectors.
	8. If the triple iteration doesn't return 1, then return 0. There are no possible combinations found with these double vectors.


*****************************************************/
int Player::checkOutThree(vector<vector<Card>> possibility1, vector<vector<Card>> possibility2, vector<vector<Card>> possibility3, string player)
{
	//Iterate through each vector in first double vector
	for (int i = 0; i < possibility1.size(); i++)
	{
		//Iterate through each vector in second double vector
		for (int j = 0; j < possibility2.size(); j++)
		{
			//Call function checkDuplicates from player class
			//Returns false if no duplicate cards found
			if (checkDuplicates(possibility1[i], possibility2[j]) == false)
			{
				//Iterate through each vector in third double vector
				for (int k = 0; k < possibility3.size(); k++)
				{
					//Call function checkDuplicates
					//Call it comparing first vector and second vector
					if (checkDuplicates(possibility1[i], possibility3[k]) == false)
					{
						if (checkDuplicates(possibility2[j], possibility3[k]) == false)
						{
							//A combination of three vectors was found with no duplicate cards
							cout << "The " << player << "'s first set is ... ";
							printCards(possibility1[i]);
							cout << "\nThe " << player << "'s second set is ... ";
							printCards(possibility2[j]);
							cout << "\nThe " << player << "'s third set is ... ";
							printCards(possibility3[k]);
							return 1;
						}
					}

				}

			}
		}
	}

	//No combination of three vectors was found without duplicates
	return 0;
}

/****************************************************
Function Name: checkOutFour
Purpose: Similar to checkOutPossibilites. Takes in four double vectors instead.
		Go through all combinations of four double vectors, if there are no cards that are duplicates in all vectors, the player can go out with that combination.
Parameters: double card vector for first book or run combination, double card vector for second book or run combination, double card vector for third book or run combination, double card vector for fourth book or run combination, string for which player
Return Value: return 1 is found, return 0 if not
Algorithim:
	1. Iterate through first double vector.
		2. Inside this iteration, iterate through second double vector.
			3. Call checkDuplicates from Player class.
			4. If this function returns false, (There are no duplicate cards in the vectors) then the player can continue with this combination.
				5. Inside this iteration, iterate through third double vector.
					6. Call checkDuplicates from Player class.
					7. If this function returns false, (There are no duplicate cards in the vectors) then the player can continue with this combination. 
						8. Inside this iteration, iterate through fourth double vector.
						9. Call checkDuplicates from Player class.
						10. If this function returns false, (There are no duplicate cards in the vectors) then the player can go out with this combination of three vectors.
	11. If the quadra iteration doesn't return 1, then return 0. There are no possible combinations found with these double vectors.


*****************************************************/
int Player::checkOutFour(vector<vector<Card>> possibility1, vector<vector<Card>> possibility2, vector<vector<Card>> possibility3, vector<vector<Card>> possibility4, string player)
{
	//Iterate through each vector in first double vector
	for (int i = 0; i < possibility1.size(); i++)
	{
		//Iterate through each vector in second double vector
		for (int j = 0; j < possibility2.size(); j++)
		{
			//Call function checkDuplicates from player class
			//Returns false if no duplicate cards found
			if (checkDuplicates(possibility1[i], possibility2[j]) == false)
			{
				//Iterate through each vector in third double vector
				for (int k = 0; k < possibility3.size(); k++)
				{
					//Call function checkDuplicates
					//Call it comparing first vector and second vector
					if (checkDuplicates(possibility1[i], possibility3[k]) == false)
					{
						if (checkDuplicates(possibility2[j], possibility3[k]) == false)
						{
							//Iterate through each vector in fourth double vector
							for (int p = 0; p < possibility4.size(); p++)
							{
								//Call function checkDuplicates
								//Call it comparing first vector, second, and third vector
								if (checkDuplicates(possibility1[i], possibility4[p]) == false)
								{
									if (checkDuplicates(possibility2[j], possibility4[p]) == false)
									{
										if (checkDuplicates(possibility3[k], possibility4[p]) == false)
										{
											//A combination of four vectors was found with no duplicate cards
											cout << "The " << player << "'s first set is ... ";
											printCards(possibility1[i]);
											cout << "\nThe " << player << "'s second set is ... ";
											printCards(possibility2[j]);
											cout << "\nThe " << player << "'s third set is ... ";
											printCards(possibility3[k]);
											cout << "\nThe " << player << "'s fourth set is ... ";
											printCards(possibility4[p]);
											return 1;
										}
									}
								}
							}
						}
					}

				}

			}
		}
	}
	//No combination of four vectors was found without duplicates
	return 0;
}




/****************************************************
Function Name: checkDuplicates
Purpose: Checks if there are duplicate cards between two card vectors.
Parameters: two card vectors
Return Value: return true if found, else false
Algorithim:
	1. Iterate through first vector.
		2. Inside this, iterate through second vector.
		3. Check if the card in first vector iteration is the same as second vector card.
		4. If so return true.
	5. If not found, return false;


*****************************************************/
bool Player::checkDuplicates(vector<Card> book, vector<Card> run)
{
	//Iterate through first card vector
	for (int i = 0; i < book.size(); i++)
	{
		//Iterate through second card vector
		for (int j = 0; j < run.size(); j++)
		{
			//Checks if the card has all same properties of comparision card
			//If so return true.
			if (book[i].getVal() == run[j].getVal())
			{
				if (book[i].getSuite() == run[j].getSuite())
				{
					if (book[i].getDeck() == run[j].getDeck())
					{
						return true;
					}

				}
			}

		}

	}

	return false;
}

/****************************************************
Function Name: searchUsedWild
Purpose: Checks a wild card is inside a card vector
Parameters: card vector and single card for wild
Return Value: return true if found, else false
Algorithim:
	1. Iterate through the card vector.
		2. Checks if the card is equal to the wild.
		3. Return true if equal.
	4. No wild found, return false.


*****************************************************/
bool Player::searchUsedWild(vector<Card> cards, Card wild)
{
	for (int i = 0; i < cards.size(); i++)
	{
		if (cards[i] == wild)
		{
			return true;
		}
	}
	return false;
}

/****************************************************
Function Name: checkPossibleBook
Purpose: Checks for the largest book inside a player's hand
Parameters: card vector for player's hand, int of the round, int that checks if the player is on its last turn
Return Value: return card vector of largest book if found, else return null card vector
Algorithim:
	1. Sort hand and place wilds at the end of hand.
	2. Iterate through sorted hand vector at position i. Push back hand at i to vector.
		3. Iterate through sorted hand vector at position i+1.
			4. If hand at i+1 adds to a book, push back to hand.
			5. Check if it is the player's last turn. 
			6. If it is, Push back the new book vector into a double card vector if the book vector size is at least 3.
			7. If not, push back the new book vector into a double card vector if the book vector size is at least 2.
	8. Now that all books of hand are placed inside a double card vector, iterate through that double vector to find the largest size book vector.
	9. Return that book vector.
	10. If no books were found, return a null card vector.


*****************************************************/
vector<Card> Player::checkPossibleBook(vector<Card> hand, int round, int lastTurn)
{
	//Sorting players hand
	sort(hand.begin(), hand.end());

	vector<Card> wilds;
	vector<Card> searchingHand;

	//Placing wilds at the end of the player's hand
	for (int i = 0; i < hand.size(); i++)
	{
		if (hand[i].getNumValue() != 50)
		{
			if (hand[i].getNumValue() != round)
			{
				searchingHand.push_back(hand[i]);
			}
		}
	}
	for (int i = 0; i < hand.size(); i++)
	{
		if (hand[i].getNumValue() == 50)
		{
			wilds.push_back(hand[i]);
		}
		if (hand[i].getNumValue() == round)
		{
			wilds.push_back(hand[i]);
		}
	}

	if (wilds.size() != 0)
	{
		for (int i = 0; i < wilds.size();i++)
		{
			searchingHand.push_back(wilds[i]);
		}
	}

	vector<vector <Card>> books;
	//Iterating through the sorted hand, pushing back card into a possible book vector
	for (int i = 0; i < searchingHand.size(); i++)
	{
		vector<Card> possibleBook;
		possibleBook.push_back(searchingHand[i]);
		//Iterating through the next card after position i
		for (int j = i + 1; j < searchingHand.size(); j++)
		{
			//Checks if the cards value is the same as the previous card
			//If so, push back into the possible book vector
			if (searchingHand[i].getNumValue() == searchingHand[j].getNumValue())
			{
				possibleBook.push_back(searchingHand[j]);
			}
			//Checks if the cards value is a joker
			//If so, push back into the possible book vector
			if (searchingHand[j].getNumValue() == 50)
			{
				possibleBook.push_back(searchingHand[j]);
			}
			//Checks if the cards value is a wild
			//If so, push back into the possible book vector
			if (searchingHand[j].getNumValue() == round)
			{
				possibleBook.push_back(searchingHand[j]);
			}
		}
		//Checks if it is not the players last turn
		if (lastTurn == 0)
		{
			if (possibleBook.size() > 1)
			{
				books.push_back(possibleBook);
			}
		}
		//Checks if it is the players last turn
		if (lastTurn == 1)
		{
			if (possibleBook.size() > 2)
			{
				books.push_back(possibleBook);
			}
		}
		possibleBook.clear();
	}

	//Condtion that checks that books were found
	if (books.empty() == false)
	{
		vector<Card> finalBook;
		int maxSize = 0;
		//Iteration that finds the largest book vector inside the double vector
		for (int i = 0; i < books.size(); i++)
		{

			if (books[i].size() > maxSize)
			{
				finalBook = books[i];
				maxSize = books[i].size();
			}

		}
		return finalBook;
	}
	//Return null vector if no books were found

	vector<Card> nullHand;
	return nullHand;

}

/****************************************************
Function Name: checkPossibleRun
Purpose: Checks for the largest run inside a player's hand
Parameters: card vector for player's hand, int of the round, int that checks if the player is on its last turn
Return Value: return card vector of largest run if found, else return null card vector
Algorithim:
	1. Sort hand and place wilds at the end of hand.
	2. Iterate through sorted hand vector at position i. Push back hand at i to vector.
		3. Iterate through sorted hand vector at position i+1.
			4. If hand at i+1 adds to a run, push back to hand.
			5. Check if it is the player's last turn.
			6. If it is, Push back the new run vector into a double card vector if the run vector size is at least 3.
			7. If not, push back the new run vector into a double card vector if the run vector size is at least 2.
	8. Now that all run of hand are placed inside a double card vector, iterate through that double vector to find the largest size run vector.
	9. Return that run vector.
	10. If no runs were found, return a null card vector.


*****************************************************/
vector<Card> Player::checkPossibleRun(vector<Card> hand, int round, int lastTurn)
{
	//Sorting the player's hand, and placing wilds at the back of hand
	sort(hand.begin(), hand.end());

	vector<Card> wilds;
	vector<Card> searchingHand;
	for (int i = 0; i < hand.size(); i++)
	{
		if (hand[i].getNumValue() != 50)
		{
			if (hand[i].getNumValue() != round)
			{
				searchingHand.push_back(hand[i]);
			}
		}
	}
	for (int i = 0; i < hand.size(); i++)
	{
		if (hand[i].getNumValue() == 50)
		{
			wilds.push_back(hand[i]);
		}
		if (hand[i].getNumValue() == round)
		{
			wilds.push_back(hand[i]);
		}
	}

	//Wilds are now placed at the back of the card vector
	if (wilds.size() != 0)
	{
		for (int i = 0; i < wilds.size();i++)
		{
			searchingHand.push_back(wilds[i]);
		}
	}

	vector<vector <Card>> runs;

	//Iterating through the sorted hand, pushing back card into a possible book vector
	for (int i = 0; i < searchingHand.size(); i++)
	{
		vector<Card> possibleRun;
		possibleRun.push_back(searchingHand[i]);
		int runIncrement = 1;
		
		//Iterating through the next card after position i
		for (int j = i + 1; j < searchingHand.size(); j++)
		{
			//Checks if the card can attribute to a run, having the same suite and value +runIncrement 
			//If so, push back into the possible run vector
			if (searchingHand[i].getNumValue() + runIncrement == searchingHand[j].getNumValue())
			{
				if (searchingHand[i].getSuite() == searchingHand[j].getSuite())
				{
					possibleRun.push_back(searchingHand[j]);
					runIncrement++;
				}
			}
			//Checks if the card can attribute to a run, being a joker
			//If so, push back into the possible run vector
			if (searchingHand[j].getNumValue() == 50)
			{
				possibleRun.push_back(searchingHand[j]);
				runIncrement++;
			}
			//Checks if the card can attribute to a run, being a wild
			//If so, push back into the possible run vector
			if (searchingHand[j].getNumValue() == round)
			{
				possibleRun.push_back(searchingHand[j]);
				runIncrement++;
			}
		}
		
		//Checks if it is not the players last turn
		if (lastTurn == 0)
		{
			
			if (possibleRun.size() > 1)
			{
				
				runs.push_back(possibleRun);
			}
		}
		//Checks if it is the players last turn
		if (lastTurn == 1)
		{
			if (possibleRun.size() > 2)
			{
				runs.push_back(possibleRun);
			}
		}
		possibleRun.clear();
	}

	//Checks if there were runs found
	if (runs.empty() == false)
	{
		vector<Card> finalRun;
		int maxSize = 0;
		//Iterates through the double vector of runs to find the largest vector and return it
		for (int i = 0; i < runs.size(); i++)
		{

			if (runs[i].size() > maxSize)
			{
				finalRun = runs[i];
				maxSize = runs[i].size();
			}

		}
		return finalRun;
	}

	//Returns a null vector if no runs were found
	vector<Card> nullHand;
	return nullHand;

}








Player::~Player()
{
}
