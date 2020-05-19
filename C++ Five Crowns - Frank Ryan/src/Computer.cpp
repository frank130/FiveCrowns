#include "pch.h"
#include "Computer.h"
#include <algorithm>

using namespace std;
Computer::Computer()
{
}
/****************************************************
Function Name: startTurn
Purpose: Start a computer player's regular turn
Parameters: card vector for player's hand, drawPile, and discardPile, an int of the round, int that checks if the computer player goes out. All passed by reference except round.
Return Value: return card vector 
Algorithim:
	1. Checks the hand if it can go out.
		2. If so, pick from the draw pile and discard it. Set winningcondition to 1 and return players hand.
	3. Find the largest book of hand.
		4. If found, check discard pile if it can add to it.
		5. If it can, add it to hand, then discard a card that is not inside the book. Check if computer can go out.
		6. If it can't, find the largest run of hand.
		7. If found, check discard pile if it can add to it.
		8. If it can, add it to hand, then discard a card that is not inside the run. Check if computer can go out.
		9. If it can't, pick up card from draw pile. Then discard a card that is not a wild or joker. Check if computer can go out.
	10. If no book is found, find the largest run of hand.
		11. If found, check discard pile if it can add to it.
		12. If it can, add it to hand, then discard a card that is not inside the run. Check if computer can go out.
		13. If it can't, pick up card from draw pile. Then discard a card that is not a wild or joker. Check if computer can go out.
	14. If no book or run are found, pick from draw pile.
	15. Discard a card that is not a wild or joker.
	16. Check if computer can go out. 
	17. Return hand

*****************************************************/
vector<Card> Computer::startTurn(vector<Card> &hand, vector<Card> &drawPile, vector<Card> &discardPile, int round, int &winningCondition)
{
	vector<Card> newcomputerHand;

	//Calling checkComputerGoOut from Player class
	//Returns a null vector of size 0 if the computer can go out
	vector<Card> checkOut = checkComputerGoOut(hand, round, "computer");

	//Computer can go out with current hand
	if (checkOut.size() == 0)
	{
		cout << "The computer has already found out that it can go out!\n";
		cout << "It is picking up from the draw pile and discarding that card.\n";
		
		//Calls functions pickDrawCard and dropCard from Player class
		//Adds card from draw pile and discards it
		newcomputerHand = pickDrawCard(hand, drawPile);
		newcomputerHand = dropCard(newcomputerHand, discardPile, newcomputerHand.size()-1);

		//Setting winningcondition to 1 because it is passed by reference and needed. Then returning player's hand.
		cout << "\nThe computer has went out!\n";
		winningCondition = 1;
		return newcomputerHand;
	}

	//Calls checkPossibleBook from Player class
	vector<Card> largestBook = checkPossibleBook(hand, round, 0);
	
	//Checks if there is a possible book that is less than size 9
	if (largestBook.size() != 0 && largestBook.size() < 9)
	{
		//Checks if the discard pile can add to its book
		if (discardPile.at(0).getNumValue() == largestBook.at(0).getNumValue() || discardPile.at(0).getNumValue() == 50 || discardPile.at(0).getNumValue() == round)
		{
			cout << "\nThe computer picked up the " + discardPile.at(0).getVal() + discardPile.at(0).getSuite() << " from the discard pile because it can add to his possible book of ... ";
			printCards(largestBook);
			cout << "\n";

			//Calls function pickDiscCard from Player class
			//Adds card from discard pile to hand
			newcomputerHand = pickDiscCard(hand, discardPile);

			//Iterate through players hand to find a card that is not inside the book
			for (int i = 0; i < newcomputerHand.size();i++)
			{
				int found = 0;
				for (int j = 0; j < largestBook.size();j++)
				{
					if (newcomputerHand[i] == largestBook[j])
					{
						found = 1;
					}
				}
				if (found == 0)
				{
					cout << "\nThe computer has dropped his " + newcomputerHand.at(i).getVal() + newcomputerHand.at(i).getSuite() + " because it did not add to his possible book of ... ";
					printCards(largestBook);
					cout << "\n";

					//calls dropCard from Player class
					//drops a card that is not inside book
					vector<Card> droppedHand = dropCard(newcomputerHand, discardPile, i);

					//calls checkComputerGoOut from Player class
					vector<Card> finalHand = checkComputerGoOut(droppedHand, round, "computer");

					//vector is size 0 if player can go out. set winning condition to 1 and return computers hand
					if (finalHand.size() == 0)
					{
						cout << "\nThe computer has went out!\n";
						winningCondition = 1;
						return droppedHand;
					}
					return droppedHand;
				}
			}
		}
		//Calls checkPossibleRun from Player class
		vector<Card> largestRun = checkPossibleRun(hand, round, 0);
		
		//Checks if there is a run
		if (largestRun.size() != 0)
		{
			//Checks if the discard pile can add to its run
			if ((discardPile.at(0).getNumValue() == largestRun.at(largestRun.size() - 1).getNumValue() + 1 && discardPile.at(0).getSuite() == largestRun.at(largestRun.size() - 1).getSuite()) || discardPile.at(0).getNumValue() == 50 || discardPile.at(0).getNumValue() == round)
			{
				cout << "\nThe computer picked up the " + discardPile.at(0).getVal() + discardPile.at(0).getSuite() << " from the discard pile because it can add to his possible run of ... ";
				printCards(largestRun);
				cout << "\n";

				//Calls function pickDiscCard from Player class
				//Adds card from discard pile to hand
				newcomputerHand = pickDiscCard(hand, discardPile);

				//Iterate through players hand to find a card that is not inside the run
				for (int i = 0; i < newcomputerHand.size();i++)
				{
					int found = 0;
					for (int j = 0; j < largestRun.size();j++)
					{
						if (newcomputerHand[i] == largestRun[j])
						{
							found = 1;
						}
					}
					if (found == 0)
					{
						cout << "\nThe computer has dropped his " + newcomputerHand.at(i).getVal() + newcomputerHand.at(i).getSuite() + " because it did not add to his possible run of ... ";
						printCards(largestRun);
						cout << "\n";

						//calls dropCard from Player class
						//drops a card that is not inside run
						vector<Card> droppedHand = dropCard(newcomputerHand, discardPile, i);
						
						//calls checkComputerGoOut from Player class
						vector<Card> finalHand = checkComputerGoOut(droppedHand, round, "computer");
				
						//vector is size 0 if player can go out. set winningcondtion to 1 and return computers hand
						if (finalHand.size() == 0)
						{
							cout << "\nThe computer has went out!\n";
							winningCondition = 1;
							return droppedHand;
						}
						return droppedHand;
					}
				}
			}
		}
		
		//The discard pile couldn't add to computers largest book or run
		cout << "\nThe computer picked from the draw pile because ... ";
		cout << "the discard pile card did not add to his possible book of ... ";
		printCards(largestBook);
		cout << "\n";
		
		//calls pickDrawCard from Player class
		//adds draw pile card to computers hand
		newcomputerHand = pickDrawCard(hand, drawPile);

		//Iterate through players hand to find a card that is not inside the computers book
		for (int i = 0; i < newcomputerHand.size();i++)
		{
			int found = 0;
			for (int j = 0; j < largestBook.size();j++)
			{
				if (newcomputerHand[i] == largestBook[j])
				{
					found = 1;
				}
			}
			if (found == 0)
			{
				cout << "\nThe computer has dropped his " + newcomputerHand.at(i).getVal() + newcomputerHand.at(i).getSuite() + " because it did not add to his possible book of ... ";
				printCards(largestBook);
				cout << "\n";
				
				//Drops the card that is not inside the computers book
				vector<Card> droppedHand = dropCard(newcomputerHand, discardPile, i);

				//Checking if the computer can go out, If so, make winningcondition = 1 and return hand.
				vector<Card> finalHand = checkComputerGoOut(droppedHand, round, "computer");
				if (finalHand.size() == 0)
				{
					cout << "\nThe computer has went out!\n";
					winningCondition = 1;
					return droppedHand;
				}
				return droppedHand;
			}
		}

	}
	
	//Calls checkPossibleRun from Player class, gets largest run of computers hand
	vector<Card> largestRun = checkPossibleRun(hand, round, 0);
	
	//Checks if there is a run
	if (largestRun.size() != 0)
	{
		//Checks if the discard pile can add to computers run
		if ((discardPile.at(0).getNumValue() == largestRun.at(largestRun.size() - 1).getNumValue() + 1 && discardPile.at(0).getSuite() == largestRun.at(largestRun.size() - 1).getSuite()) || discardPile.at(0).getNumValue() == 50 || discardPile.at(0).getNumValue() == round)
		{
			cout << "\nThe computer picked up the " + discardPile.at(0).getVal() + discardPile.at(0).getSuite() << " from the discard pile because it can add to his possible run of ... ";
			printCards(largestRun);
			cout << "\n";

			//Calls function pickDiscCard from Player class
			//Adds card from discard pile to hand
			newcomputerHand = pickDiscCard(hand, discardPile);
			
			//Iterate through players hand to find a card that is not inside the run
			for (int i = 0; i < newcomputerHand.size();i++)
			{
				int found = 0;
				for (int j = 0; j < largestRun.size();j++)
				{
					if (newcomputerHand[i] == largestRun[j])
					{
						found = 1;
					}
				}
				if (found == 0)
				{
					cout << "\nThe computer has dropped his " + newcomputerHand.at(i).getVal() + newcomputerHand.at(i).getSuite() + " because it did not add to his possible run of ... ";
					printCards(largestRun);
					cout << "\n";
					
					//calls dropCard from Player class
					//drops a card that is not inside run
					vector<Card> droppedHand = dropCard(newcomputerHand, discardPile, i);
					
					//calls checkComputerGoOut from Player class
					vector<Card> finalHand = checkComputerGoOut(droppedHand, round, "computer");
					
					//vector is size 0 if player can go out. set winningcondtion to 1 and return computers hand
					if (finalHand.size() == 0)
					{
						cout << "\nThe computer has went out!\n";
						winningCondition = 1;
						return droppedHand;
					}
					return droppedHand;
				}
			}
		}

		//Computer picks up draw pile if discard pile cannot add to run, calling function pickDrawCard from Player class
		cout << "\nThe computer picked from the draw pile because ... ";
		cout << "the discard pile card did not add to his possible run of ... ";
		printCards(largestRun);
		cout << "\n";

		newcomputerHand = pickDrawCard(hand, drawPile);

		//Iterate through hand to discard a card that is not inside computers run
		for (int i = 0; i < newcomputerHand.size();i++)
		{
				int found = 0;
				for (int j = 0; j < largestRun.size();j++)
				{
					if (newcomputerHand[i] == largestRun[j])
					{
						found = 1;
					}
				}
				if (found == 0)
				{
					cout << "\nThe computer has dropped his " + newcomputerHand.at(i).getVal() + newcomputerHand.at(i).getSuite() + " because it did not add to his possible run of ... ";
					printCards(largestRun);
					cout << "\n";

					//Calling dropCard from Player class to drop card
					vector<Card> droppedHand = dropCard(newcomputerHand, discardPile, i);
					vector<Card> finalHand = checkComputerGoOut(droppedHand, round, "computer");

					//Checking if the computer can go out, 
					if (finalHand.size() == 0)
					{
						cout << "The computer has went out!\n";
						winningCondition = 1;
						return droppedHand;
					}
					return droppedHand;
				}
		}

	}
	
	//No possible book or run were found inside the computers hand
	//Checks if the discard pile has a joker on it
	if (discardPile.at(0).getNumValue() == 50)
	{
		cout << "\nThe computer picked the " + discardPile.at(0).getVal() + discardPile.at(0).getSuite() + " from the discard pile because it is a wild card.\n";

		//picks up discard pile from function in Player class
		newcomputerHand = pickDiscCard(hand, discardPile);

		//Checks if the first card in computers hand is not a wild or joker
		if (newcomputerHand.at(0).getNumValue() != round)
		{
			if (newcomputerHand.at(0).getNumValue() != 50)
			{
				//Discards the first card in hand with dropCard from Player class
				cout << "\nThe computer dropped the " + newcomputerHand.at(0).getVal() + newcomputerHand.at(0).getSuite() + " because it was not adding to a possible run or book it was looking for.\n";
				newcomputerHand = dropCard(newcomputerHand, discardPile, 0);
				vector<Card> finalHand = checkComputerGoOut(newcomputerHand, round, "computer");

				//Checks if the computer can go out
				if (finalHand.size() == 0)
				{
					cout << "\nThe computer has went out!\n";
					winningCondition = 1;
					return newcomputerHand;
				}
				return newcomputerHand;
			}
		}
		//Checks if the first card in computer hand is a wild
		if (newcomputerHand.at(0).getNumValue() == round)
		{
			//if so, drop the second card in computers hand with dropCard function
			cout << "\nThe computer dropped the " + newcomputerHand.at(1).getVal() + newcomputerHand.at(1).getSuite() + " because it was not adding to a possible run or book it was looking for.\n";
			newcomputerHand = dropCard(newcomputerHand, discardPile, 1);
			vector<Card> finalHand = checkComputerGoOut(newcomputerHand, round, "computer");

			//Checks if the computer can go out
			if (finalHand.size() == 0)
			{
				cout << "\nThe computer has went out!\n";
				winningCondition = 1;
				return newcomputerHand;
			}
			return newcomputerHand;
		}
		//Checks if the first card in computer hand is a joker
		if (newcomputerHand.at(0).getNumValue() == 50)
		{
			//if so, drop the second card in computers hand with dropCard function
			cout << "\nThe computer dropped the " + newcomputerHand.at(1).getVal() + newcomputerHand.at(1).getSuite() + " because it was not adding to a possible run or book it was looking for.\n";
			newcomputerHand = dropCard(newcomputerHand, discardPile, 1);
			vector<Card> finalHand = checkComputerGoOut(newcomputerHand, round, "computer");

			//Checks if the computer can go out
			if (finalHand.size() == 0)
			{
				cout << "\nThe computer has went out!\n";
				winningCondition = 1;
				return newcomputerHand;
			}
			return newcomputerHand;
		}
		
	}
	//Checks if the discard pile has a joker on it
	if (discardPile.at(0).getNumValue() == round)
	{
		//picks up discard pile from function in Player class
		cout << "\nThe computer picked the " + discardPile.at(0).getVal() + discardPile.at(0).getSuite() + " from the discard pile because it is a wild card.\n";
		newcomputerHand = pickDiscCard(hand, discardPile);

		//Checks if the first card in computers hand is not a wild or joker
		if (newcomputerHand.at(0).getNumValue() != round)
		{
			if (newcomputerHand.at(0).getNumValue() != 50)
			{
				//Discards the first card in hand with dropCard from Player class
				cout << "\nThe computer dropped the " + newcomputerHand.at(0).getVal() + newcomputerHand.at(0).getSuite() + " because it was not adding to a possible run or book it was looking for.\n";
				newcomputerHand = dropCard(newcomputerHand, discardPile, 0);
				vector<Card> finalHand = checkComputerGoOut(newcomputerHand, round, "computer");

				//Checks if the computer can go out
				if (finalHand.size() == 0)
				{
					cout << "\nThe computer has went out!\n";
					winningCondition = 1;
					return newcomputerHand;
				}
				return newcomputerHand;

			}
		}
		//Checks if the first card in computer hand is a wild
		if (newcomputerHand.at(0).getNumValue() == round)
		{
			//if so, drop the second card in computers hand with dropCard function
			cout << "\nThe computer dropped the " + newcomputerHand.at(1).getVal() + newcomputerHand.at(1).getSuite() + " because it was not adding to a possible run or book it was looking for.\n";
			newcomputerHand = dropCard(newcomputerHand, discardPile, 1);
			vector<Card> finalHand = checkComputerGoOut(newcomputerHand, round, "computer");
			
			//Checks if the computer can go out
			if (finalHand.size() == 0)
			{
				cout << "The computer has went out!\n";
				winningCondition = 1;
				return newcomputerHand;
			}
			return newcomputerHand;
		}
		
		//Checks if the first card in computer hand is a joker
		if (newcomputerHand.at(0).getNumValue() == 50)
		{
			//if so, drop the second card in computers hand with dropCard function
			cout << "\nThe computer dropped the " + newcomputerHand.at(1).getVal() + newcomputerHand.at(1).getSuite() + " because it was not adding to a possible run or book it was looking for.\n";
			newcomputerHand = dropCard(newcomputerHand, discardPile, 1);
			vector<Card> finalHand = checkComputerGoOut(newcomputerHand, round, "computer");
			
			//Checks if the computer can go out
			if (finalHand.size() == 0)
			{
				cout << "\nThe computer has went out!\n";
				winningCondition = 1;
				return newcomputerHand;
			}
			return newcomputerHand;
		}
	
		
	}
	//Checks if the discard pile is neither a joker nor a wild
	if (discardPile.at(0).getNumValue() != 50)
	{
		if (discardPile.at(0).getNumValue() != round)
		{
			//picks up draw card through Player class function
			cout << "The computer picked the draw pile because the discard pile does not have a wild and does not add to any of his current runs or books.\n";
			newcomputerHand = pickDrawCard(hand, drawPile);

			//Checks if the first computer card is not a joker or wild
			if (newcomputerHand.at(0).getNumValue() != round)
			{
				if (newcomputerHand.at(0).getNumValue() != 50)
				{
					//Drops that card through Player class function
					cout << "\nThe computer dropped the " + newcomputerHand.at(0).getVal() + newcomputerHand.at(0).getSuite() + " because it was not adding to a possible run or book it was looking for.\n";
					newcomputerHand = dropCard(newcomputerHand, discardPile, 0);
					vector<Card> finalHand = checkComputerGoOut(newcomputerHand, round, "computer");

					//Checks if computer can go out
					if (finalHand.size() == 0)
					{
						cout << "\nThe computer has went out!\n";
						winningCondition = 1;
						return newcomputerHand;
					}
					return newcomputerHand;
				}
			}
			//Checks if the first computer card is a wild
			if (newcomputerHand.at(0).getNumValue() == round)
			{
				//Drops the second card of hand through Player class function
				cout << "\nThe computer dropped the " + newcomputerHand.at(1).getVal() + newcomputerHand.at(1).getSuite() + " because it was not adding to a possible run or book it was looking for.\n";
				newcomputerHand = dropCard(newcomputerHand, discardPile, 1);
				vector<Card> finalHand = checkComputerGoOut(newcomputerHand, round, "computer");

				//checks if computer can go out
				if (finalHand.size() == 0)
				{
					cout << "\nThe computer has went out!\n";
					winningCondition = 1;
					return newcomputerHand;
				}
				return newcomputerHand;
			}
			//Checks if the first computer card is a joker
			if (newcomputerHand.at(0).getNumValue() == 50)
			{
				//If so, drop the second card in hand through Player class function
				cout << "\nThe computer dropped the " + newcomputerHand.at(1).getVal() + newcomputerHand.at(1).getSuite() + " because it was not adding to a possible run or book it was looking for.\n";
				newcomputerHand = dropCard(newcomputerHand, discardPile, 1);
				vector<Card> finalHand = checkComputerGoOut(newcomputerHand, round, "computer");

				//Check if the computer can go out
				if (finalHand.size() == 0)
				{
					cout << "\nThe computer has went out!\n";
					winningCondition = 1;
					return newcomputerHand;
				}
				return newcomputerHand;
			}
		}
		
	}


	return newcomputerHand;
}

/****************************************************
Function Name: startLastTurn
Purpose: Similar to startTurn Computer class function. Start a computer player's last turn. Returns the total of computer player's hand points.
Parameters: card vector for player's hand, drawPile, and discardPile, an int of the round, int that checks if the computer player goes out. All passed by reference except round.
Return Value: return int for total round points added up
Algorithim:
	1. Checks the hand if it can go out.
		2. If so, pick from the draw pile and discard it. Return 0.
	3. Find the largest book of hand.
		4. If found, check discard pile if it can add to it.
		5. If it can, add it to hand, then discard a card that is not inside the book. Check if computer can go out. If not, place largest book down and count remaining points to return.
		6. If it can't, find the largest run of hand.
		7. If found, check discard pile if it can add to it.
		8. If it can, add it to hand, then discard a card that is not inside the run. Check if computer can go out.If not, place largest run down and count remaining points to return.
		9. If it can't, pick up card from draw pile. Then discard a card that is not a wild or joker. Check if computer can go out. If not, place largest book down and count remaining points to return.
	10. If no book is found, find the largest run of hand.
		11. If found, check discard pile if it can add to it.
		12. If it can, add it to hand, then discard a card that is not inside the run. Check if computer can go out.If not, place largest run down and count remaining points to return.
		13. If it can't, pick up card from draw pile. Then discard a card that is not a wild or joker. Check if computer can go out.
	14. If no book or run are found, pick from draw pile.
	15. Discard a card that is not a wild or joker.
	16. Check if computer can go out. Return 0 if it can.
	17. Return total points of computers hand.

*****************************************************/
int Computer::startLastTurn(vector<Card> &hand, vector<Card> &drawPile, vector<Card> &discardPile, int round, int &winningCondition)
{
	//Calling checkComputerGoOut from Player class
	//Returns 0 if the computer can go out
	vector<Card> newcomputerHand;
	vector<Card> checkOut = checkComputerGoOut(hand, round, "computer");
	if (checkOut.size() == 0)
	{
		cout << "The computer has already found out that it can go out!\n";
		cout << "It is picking up from the draw pile and discarding that card.\n";
		newcomputerHand = pickDrawCard(hand, drawPile);
		newcomputerHand = dropCard(newcomputerHand, discardPile, newcomputerHand.size() - 1);

		cout << "\nThe computer has went out!\n";
		
		return 0;
	}
	//Calls checkPossibleBook from Player class
	vector<Card> largestBook = checkPossibleBook(hand, round, 1);
	
	//Checks if there is a possible book that is less than size 9
	if (largestBook.size() != 0 && largestBook.size() < 9)
	{
		//Checks if the discard pile can add to its book
		if (discardPile.at(0).getNumValue() == largestBook.at(0).getNumValue() || discardPile.at(0).getNumValue() == 50 || discardPile.at(0).getNumValue() == round)
		{
			cout << "\nThe computer picked up the " + discardPile.at(0).getVal() + discardPile.at(0).getSuite() << " from the discard pile because it can add to his book of ... ";
			printCards(largestBook);
			cout << "\n";

			//Calls function pickDiscCard from Player class
			//Adds card from discard pile to hand
			newcomputerHand = pickDiscCard(hand, discardPile);

			//Iterate through players hand to find a card that is not inside the book
			for (int i = 0; i < newcomputerHand.size();i++)
			{
				int found = 0;
				for (int j = 0; j < largestBook.size();j++)
				{
					if (newcomputerHand[i] == largestBook[j])
					{
						found = 1;
					}
				}
				if (found == 0)
				{
					cout << "\nThe computer has dropped his " + newcomputerHand.at(i).getVal() + newcomputerHand.at(i).getSuite() + " because it did not add to his book of ... ";
					printCards(largestBook);
					cout << "\n";

					//calls dropCard from Player class
					//drops a card that is not inside book
					vector<Card> droppedHand = dropCard(newcomputerHand, discardPile, i);

					cout << "This is the computer's final hand ... ";
					printCards(droppedHand);
					cout << "\n";
					cout << "\n";

					//calls checkComputerGoOut from Player class
					vector<Card> finalHand = checkComputerGoOut(droppedHand, round, "computer");

					//vector is size 0 if player can go out. return 0
					if (finalHand.size() == 0)
					{
						cout << "\nThe computer has went out!\n";
						
						return 0;
					}

					//If computer did not go out, erase the largest book from the computers hand
					for (int i = 0; i < largestBook.size(); i++)
					{
						for (unsigned int k = 0; k < droppedHand.size(); k++)
						{
							if ((droppedHand[k] == largestBook[i]))
							{
								droppedHand.erase(droppedHand.begin() + k);

							}
						}
					}
					cout << "\nThe computer has put down a book! It is a book of ... ";
					printCards(largestBook);
					cout << "\nNow counting up all computer points!\n";

					//call countCardPoints from Player class
					//counts all points of cards' values in the computers hand
					//returns that int
					int totalPoints = countCardPoints(droppedHand, round);
					cout << "Total Points: " << totalPoints << "\n";
					return totalPoints;
				}
			}
		}
		//Calls checkPossibleRun from Player class
		vector<Card> largestRun = checkPossibleRun(hand, round, 1);
		if (largestRun.size() != 0)
		{
			//Checks if the discard pile can add to its run
			if ((discardPile.at(0).getNumValue() == largestRun.at(largestRun.size() - 1).getNumValue() + 1 && discardPile.at(0).getSuite() == largestRun.at(largestRun.size() - 1).getSuite()) || discardPile.at(0).getNumValue() == 50 || discardPile.at(0).getNumValue() == round)
			{
				cout << "\nThe computer picked up the " + discardPile.at(0).getVal() + discardPile.at(0).getSuite() << " from the discard pile because it can add to his run of ... ";
				printCards(largestRun);
				cout << "\n";

				//Calls function pickDiscCard from Player class
				//Adds card from discard pile to hand
				newcomputerHand = pickDiscCard(hand, discardPile);

				//Iterate through players hand to find a card that is not inside the run
				for (int i = 0; i < newcomputerHand.size();i++)
				{
					int found = 0;
					for (int j = 0; j < largestRun.size();j++)
					{
						if (newcomputerHand[i] == largestRun[j])
						{
							found = 1;
						}
					}
					if (found == 0)
					{
						cout << "\nThe computer has dropped his " + newcomputerHand.at(i).getVal() + newcomputerHand.at(i).getSuite() + " because it did not add to his run of ... ";
						printCards(largestRun);
						cout << "\n";

						//calls dropCard from Player class
						//drops a card that is not inside run
						vector<Card> droppedHand = dropCard(newcomputerHand, discardPile, i);

						cout << "This is the computer's final hand ... ";
						printCards(droppedHand);
						cout << "\n";
						cout << "\n";

						//calls checkComputerGoOut from Player class
						vector<Card> finalHand = checkComputerGoOut(droppedHand, round, "computer");

						//vector is size 0 if player can go out. return 0
						if (finalHand.size() == 0)
						{
							cout << "\nThe computer has went out!\n";
						
							return 0;
						}

						//If computer did not go out, erase the largest run from the computers hand
						for (int i = 0; i < largestRun.size(); i++)
						{
							for (unsigned int k = 0; k < droppedHand.size(); k++)
							{
								if ((droppedHand[k] == largestRun[i]))
								{
									droppedHand.erase(droppedHand.begin() + k);

								}
							}
						}
						//call countCardPoints from Player class
						//counts all points of cards' values in the computers hand
						//returns that int
						cout << "\nThe computer has put down a run! It is a run of ... ";
						printCards(largestRun);
						cout << "\nNow counting up all computer points!\n";
						int totalPoints = countCardPoints(droppedHand, round);
						cout << "Total Points: " << totalPoints << "\n";
						return totalPoints;
					}
				}
			}
		}
		//The discard pile couldn't add to computers largest book or run

		cout << "\nThe computer picked from the draw pile because ... ";
		cout << "the discard pile card did not add to his book of ... ";
		printCards(largestBook);
		cout << "\n";

		//calls pickDrawCard from Player class
		//adds draw pile card to computers hand
		newcomputerHand = pickDrawCard(hand, drawPile);

		//Iterate through players hand to find a card that is not inside the computers book
		for (int i = 0; i < newcomputerHand.size();i++)
		{
			int found = 0;
			for (int j = 0; j < largestBook.size();j++)
			{
				if (newcomputerHand[i] == largestBook[j])
				{
					found = 1;
				}
			}
			if (found == 0)
			{
				cout << "\nThe computer has dropped his " + newcomputerHand.at(i).getVal() + newcomputerHand.at(i).getSuite() + " because it did not add to his book of ... ";
				printCards(largestBook);
				cout << "\n";

				//Drops the card that is not inside the computers book
				vector<Card> droppedHand = dropCard(newcomputerHand, discardPile, i);

				cout << "This is the computer's final hand ... ";
				printCards(droppedHand);
				cout << "\n";
				cout << "\n";

				//Checking if the computer can go out, If so, return 0.
				vector<Card> finalHand = checkComputerGoOut(droppedHand, round, "computer");
				if (finalHand.size() == 0)
				{
					cout << "\nThe computer has went out!\n";

					return 0;
				}

				//If computer did not go out, erase the largest book from the computers hand
				for (int i = 0; i < largestBook.size(); i++)
				{
					for (unsigned int k = 0; k < droppedHand.size(); k++)
					{
						if ((droppedHand[k] == largestBook[i]))
						{
							droppedHand.erase(droppedHand.begin() + k);

						}
					}
				}
				//call countCardPoints from Player class
				//counts all points of cards' values in the computers hand
				//returns that int
				cout << "\nThe computer has put down a book! It is a book of ... ";
				printCards(largestBook);
				cout << "\nNow counting up all computer points!\n";
				int totalPoints = countCardPoints(droppedHand, round);
				cout << "Total Points: " << totalPoints << "\n";
				return totalPoints;
			}
		}
	}
	//Calls checkPossibleRun from Player class, gets largest run of computers hand
	vector<Card> largestRun = checkPossibleRun(hand, round, 1);
	
	//Checks if there is a run
	if (largestRun.size() != 0)
	{
		//Checks if the discard pile can add to computers run
		if ((discardPile.at(0).getNumValue() == largestRun.at(largestRun.size() - 1).getNumValue() + 1 && discardPile.at(0).getSuite() == largestRun.at(largestRun.size() - 1).getSuite()) || discardPile.at(0).getNumValue() == 50 || discardPile.at(0).getNumValue() == round)
		{
			cout << "\nThe computer picked up the " + discardPile.at(0).getVal() + discardPile.at(0).getSuite() << " from the discard pile because it can add to his run of ... ";
			printCards(largestRun);
			cout << "\n";

			//Calls function pickDiscCard from Player class
			//Adds card from discard pile to hand
			newcomputerHand = pickDiscCard(hand, discardPile);

			//Iterate through players hand to find a card that is not inside the run
			for (int i = 0; i < newcomputerHand.size();i++)
			{
				int found = 0;
				for (int j = 0; j < largestRun.size();j++)
				{
					if (newcomputerHand[i] == largestRun[j])
					{
						found = 1;
					}
				}
				if (found == 0)
				{
					cout << "\nThe computer has dropped his " + newcomputerHand.at(i).getVal() + newcomputerHand.at(i).getSuite() + " because it did not add to his run of ... ";
					printCards(largestRun);
					cout << "\n";

					//calls dropCard from Player class
					//drops a card that is not inside run
					vector<Card> droppedHand = dropCard(newcomputerHand, discardPile, i);

					cout << "This is the computer's final hand ... ";
					printCards(droppedHand);
					cout << "\n";
					cout << "\n";

					vector<Card> finalHand = checkComputerGoOut(droppedHand, round, "computer");

					//vector is size 0 if player can go out. return 0.
					if (finalHand.size() == 0)
					{
						cout << "\nThe computer has went out!\n";
						
						return 0;
					}
					//Iterate through computers hand and remove all cards in largest run
					for (int i = 0; i < largestRun.size(); i++)
					{
						for (unsigned int k = 0; k < droppedHand.size(); k++)
						{
							if ((droppedHand[k] == largestRun[i]))
							{
								droppedHand.erase(droppedHand.begin() + k);

							}
						}
					}
					//call countCardPoints from Player class
					//counts all points of cards' values in the computers hand
					//returns that int
					cout << "\nThe computer has put down a run! It is a run of ... ";
					printCards(largestRun);
					cout << "\nNow counting up all computer points!\n";
					int totalPoints = countCardPoints(droppedHand, round);
					cout << "Total Points: " << totalPoints << "\n";
					return totalPoints;
				}
			}
		}

		//Computer picks up draw pile if discard pile cannot add to run, calling function pickDrawCard from Player class
		cout << "\nThe computer picked from the draw pile because ... ";
		cout << "the discard pile card did not add to his run of ... ";
		printCards(largestRun);
		cout << "\n";

		newcomputerHand = pickDrawCard(hand, drawPile);

		//Iterate through hand to discard a card that is not inside computers run
		for (int i = 0; i < newcomputerHand.size();i++)
		{
			int found = 0;
			for (int j = 0; j < largestRun.size();j++)
			{
				if (newcomputerHand[i] == largestRun[j])
				{
					found = 1;
				}
			}
			if (found == 0)
			{
				cout << "\nThe computer has dropped his " + newcomputerHand.at(i).getVal() + newcomputerHand.at(i).getSuite() + " because it did not add to his run of ... ";
				printCards(largestRun);
				cout << "\n";

				//Calling dropCard from Player class to drop card
				vector<Card> droppedHand = dropCard(newcomputerHand, discardPile, i);

				cout << "This is the computer's final hand ... ";
				printCards(droppedHand);
				cout << "\n";
				cout << "\n";

				vector<Card> finalHand = checkComputerGoOut(droppedHand, round, "computer");

				//Checking if the computer can go out, 
				if (finalHand.size() == 0)
				{
					cout << "\nThe computer has went out!\n";

					return 0;
				}

				//Iterate through computers hand and remove all cards in largest run
				for (int i = 0; i < largestRun.size(); i++)
				{
					for (unsigned int k = 0; k < droppedHand.size(); k++)
					{
						if ((droppedHand[k] == largestRun[i]))
						{
							droppedHand.erase(droppedHand.begin() + k);

						}
					}
				}
				//call countCardPoints from Player class
				//counts all points of cards' values in the computers hand
				//returns that int
				cout << "\nThe computer has put down a run! It is a run of ... ";
				printCards(largestRun);
				cout << "\nNow counting up all computer points!\n";
				int totalPoints = countCardPoints(droppedHand, round);
				cout << "Total Points: " << totalPoints << "\n";
				return totalPoints;
			}
		}
	}

	//No possible book or run were found inside the computers hand
	//Checks if the discard pile has a joker on it
	if (discardPile.at(0).getNumValue() == 50)
	{
		cout << "\nThe computer picked the " + discardPile.at(0).getVal() + discardPile.at(0).getSuite() + " from the discard pile because it is a wild card.\n";

		//picks up discard pile from function in Player class
		newcomputerHand = pickDiscCard(hand, discardPile);

		//Checks if the first card in computers hand is not a wild or joker
		if (newcomputerHand.at(0).getNumValue() != round)
		{
			if (newcomputerHand.at(0).getNumValue() != 50)
			{
				//Discards the first card in hand with dropCard from Player class
				cout << "\nThe computer dropped the " + newcomputerHand.at(0).getVal() + newcomputerHand.at(0).getSuite() + " because it was not adding to a run or book it was looking for.\n";
				newcomputerHand = dropCard(newcomputerHand, discardPile, 0);

				cout << "This is the computer's final hand ... ";
				printCards(newcomputerHand);
				cout << "\n";
				cout << "\n";

				vector<Card> finalHand = checkComputerGoOut(newcomputerHand, round, "computer");

				//Checks if the computer can go out
				if (finalHand.size() == 0)
				{
					cout << "\nThe computer has went out!\n";

					return 0;
				}

				//Calling checkFinalHand in Computer class
				//Looks for any books or runs to place before going out
				//Count up total points of hand if computer cannot go out
				int totalPoints = checkFinalHand(newcomputerHand, round);
				return totalPoints;
			}
		}
		//Checks if the first card in computer hand is a wild
		if (newcomputerHand.at(0).getNumValue() == round)
		{
			//if so, drop the second card in computers hand with dropCard function
			cout << "\nThe computer dropped the " + newcomputerHand.at(1).getVal() + newcomputerHand.at(1).getSuite() + " because it was not adding to a run or book it was looking for.\n";
			newcomputerHand = dropCard(newcomputerHand, discardPile, 1);

			cout << "This is the computer's final hand ... ";
			printCards(newcomputerHand);
			cout << "\n";
			cout << "\n";

			vector<Card> finalHand = checkComputerGoOut(newcomputerHand, round, "computer");

			//Checks if the computer can go out
			if (finalHand.size() == 0)
			{
				cout << "\nThe computer has went out!\n";

				return 0;
			}
			//Count up total points of hand if computer cannot go out
			int totalPoints = checkFinalHand(newcomputerHand, round);
			return totalPoints;
			
		}
		//Checks if the first card in computer hand is a joker
		if (newcomputerHand.at(0).getNumValue() == 50)
		{
			//if so, drop the second card in computers hand with dropCard function
			cout << "\nThe computer dropped the " + newcomputerHand.at(1).getVal() + newcomputerHand.at(1).getSuite() + " because it was not adding to a run or book it was looking for.\n";
			newcomputerHand = dropCard(newcomputerHand, discardPile, 1);

			cout << "This is the computer's final hand ... ";
			printCards(newcomputerHand);
			cout << "\n";
			cout << "\n";

			vector<Card> finalHand = checkComputerGoOut(newcomputerHand, round, "computer");

			//Checks if the computer can go out
			if (finalHand.size() == 0)
			{
				cout << "The computer has went out!\n";

				return 0;
			}

			//Count up total points of hand if computer cannot go out
			int totalPoints = checkFinalHand(newcomputerHand, round);
			return totalPoints;
		}

	}
	//Checks if the discard pile has a joker on it
	if (discardPile.at(0).getNumValue() == round)
	{
		//picks up discard pile from function in Player class
		cout << "\nThe computer picked the " + discardPile.at(0).getVal() + discardPile.at(0).getSuite() + " from the discard pile because it is a wild card.\n";
		newcomputerHand = pickDiscCard(hand, discardPile);

		//Checks if the first card in computers hand is not a wild or joker
		if (newcomputerHand.at(0).getNumValue() != round)
		{
			if (newcomputerHand.at(0).getNumValue() != 50)
			{
				//Discards the first card in hand with dropCard from Player class
				cout << "\nThe computer dropped the " + newcomputerHand.at(0).getVal() + newcomputerHand.at(0).getSuite() + " because it was not adding to a run or book it was looking for.\n";
				newcomputerHand = dropCard(newcomputerHand, discardPile, 0);

				cout << "This is the computer's final hand ... ";
				printCards(newcomputerHand);
				cout << "\n";
				cout << "\n";

				vector<Card> finalHand = checkComputerGoOut(newcomputerHand, round, "computer");

				//Checks if the computer can go out
				if (finalHand.size() == 0)
				{
					cout << "\nThe computer has went out!\n";

					return 0;
				}

				//Count up total points of hand if computer cannot go out
				int totalPoints = checkFinalHand(newcomputerHand, round);
				return totalPoints;

			}
		}
		//Checks if the first card in computer hand is a wild
		if (newcomputerHand.at(0).getNumValue() == round)
		{
			//if so, drop the second card in computers hand with dropCard function
			cout << "\nThe computer dropped the " + newcomputerHand.at(1).getVal() + newcomputerHand.at(1).getSuite() + " because it was not adding to a run or book it was looking for.\n";
			newcomputerHand = dropCard(newcomputerHand, discardPile, 1);

			cout << "This is the computer's final hand ... ";
			printCards(newcomputerHand);
			cout << "\n";
			cout << "\n";

			vector<Card> finalHand = checkComputerGoOut(newcomputerHand, round, "computer");
			//Checks if the computer can go out
			if (finalHand.size() == 0)
			{
				cout << "\nThe computer has went out!\n";

				return 0;
			}

			//Count up total points of hand if computer cannot go out
			int totalPoints = checkFinalHand(newcomputerHand, round);
			return totalPoints;
		}

		//Checks if the first card in computer hand is a joker
		if (newcomputerHand.at(0).getNumValue() == 50)
		{
			//if so, drop the second card in computers hand with dropCard function
			cout << "\nThe computer dropped the " + newcomputerHand.at(1).getVal() + newcomputerHand.at(1).getSuite() + " because it was not adding to a run or book it was looking for.\n";
			newcomputerHand = dropCard(newcomputerHand, discardPile, 1);

			cout << "This is the computer's final hand ... ";
			printCards(newcomputerHand);
			cout << "\n";
			cout << "\n";

			vector<Card> finalHand = checkComputerGoOut(newcomputerHand, round, "computer");

			//Checks if the computer can go out
			if (finalHand.size() == 0)
			{
				cout << "\nThe computer has went out!\n";

				return 0;
			}
			//Count up total points of hand if computer cannot go out
			int totalPoints = checkFinalHand(newcomputerHand, round);
			return totalPoints;
		}


	}

	//Checks if the discard pile is neither a joker nor a wild
	if (discardPile.at(0).getNumValue() != 50)
	{
		if (discardPile.at(0).getNumValue() != round)
		{
			//picks up draw card through Player class function
			cout << "\nThe computer picked the draw pile because the discard pile does not have a wild and does not add to any of his current runs or books.\n";
			newcomputerHand = pickDrawCard(hand, drawPile);

			//Checks if the first computer card is not a joker or wild
			if (newcomputerHand.at(0).getNumValue() != round)
			{
				if (newcomputerHand.at(0).getNumValue() != 50)
				{
					//Drops that card through Player class function
					cout << "\nThe computer dropped the " + newcomputerHand.at(0).getVal() + newcomputerHand.at(0).getSuite() + " because it was not adding to a run or book it was looking for.\n";
					newcomputerHand = dropCard(newcomputerHand, discardPile, 0);

					cout << "This is the computer's final hand ... ";
					printCards(newcomputerHand);
					cout << "\n";
					cout << "\n";

					vector<Card> finalHand = checkComputerGoOut(newcomputerHand, round, "computer");

					//Checks if computer can go out
					if (finalHand.size() == 0)
					{
						cout << "\nThe computer has went out!\n";

						return 0;
					}

					//Count up total points of hand if computer cannot go out
					int totalPoints = checkFinalHand(newcomputerHand, round);
					return totalPoints;
				}
			}

			//Checks if the first computer card is a wild
			if (newcomputerHand.at(0).getNumValue() == round)
			{
				//Drops the second card of hand through Player class function
				cout << "\nThe computer dropped the " + newcomputerHand.at(1).getVal() + newcomputerHand.at(1).getSuite() + " because it was not adding to a run or book it was looking for.\n";
				newcomputerHand = dropCard(newcomputerHand, discardPile, 1);

				cout << "This is the computer's final hand ... ";
				printCards(newcomputerHand);
				cout << "\n";
				cout << "\n";

				vector<Card> finalHand = checkComputerGoOut(newcomputerHand, round, "computer");

				//checks if computer can go out
				if (finalHand.size() == 0)
				{
					cout << "\nThe computer has went out!\n";

					return 0;
				}

				//Count up total points of hand if computer cannot go out
				int totalPoints = checkFinalHand(newcomputerHand, round);
				return totalPoints;
			}

			//Checks if the first computer card is a joker
			if (newcomputerHand.at(0).getNumValue() == 50)
			{

				//If so, drop the second card in hand through Player class function
				cout << "\nThe computer dropped the " + newcomputerHand.at(1).getVal() + newcomputerHand.at(1).getSuite() + " because it was not adding to a run or book it was looking for.\n";
				newcomputerHand = dropCard(newcomputerHand, discardPile, 1);

				cout << "This is the computer's final hand ... ";
				printCards(newcomputerHand);
				cout << "\n";
				cout << "\n";

				vector<Card> finalHand = checkComputerGoOut(newcomputerHand, round, "computer");

				//Check if the computer can go out
				if (finalHand.size() == 0)
				{
					cout << "\nThe computer has went out!\n";

					return 0;
				}

				//Count up total points of hand if computer cannot go out
				int totalPoints = checkFinalHand(newcomputerHand, round);
				return totalPoints;
			}
		}

	}


	return 0;
	
}

/****************************************************
Function Name: checkFinalHand
Purpose: Checks for any books or runs to place down before computer goes out, then counts total points and returns points for all cards.
Parameters: card vector for player's hand, integer for round
Return Value: return int for total round points added up
Algorithim:
	1. Call checkPossibleBook and checkPossibleRun functions in Player class. Pass 1 as final parameter for last turn.
	2. Check if there is a largest book, if so, remove it from computers hand, and count up remaining card points to return.
	3. If there is no largest book, check if there is a largest run.
	4. If there is a run, remove it from computers hand, and count up remaining card points to return.
	5. If no books or runs found, count up all card points and return it.

*****************************************************/
int Computer::checkFinalHand(vector<Card> hand, int round)
{
	//Calling function checkPossibleBook and checkPossibleRun from Player class
	//Recieve largest book and largest run in computers hand

	vector<Card> lastBook = checkPossibleBook(hand, round, 1);
	vector<Card> lastRun = checkPossibleRun(hand, round, 1);

	//Checks if there is a largeset book
	if (lastBook.size() != 0)
	{
		//Iterates through hand and removes largest book
		for (int i = 0; i < lastBook.size(); i++)
		{
			for (unsigned int k = 0; k < hand.size(); k++)
			{
				if ((hand[k] == lastBook[i]))
				{
					hand.erase(hand.begin() + k);

				}
			}
		}
		//Calls countCardPoints in Player class to count up remaining card points
		//Returns that int
		cout << "The computer has put down a book! It is a book of ... ";
		printCards(lastBook);
		cout << "\nNow counting up all computer points!\n";
		int totalPoints = countCardPoints(hand, round);
		cout << "Total Points: " << totalPoints << "\n";
		return totalPoints;
	}

	//Checks if there is a largeset run
	if (lastRun.size() != 0)
	{
		//Iterates through hand and removes largest run
		for (int i = 0; i < lastRun.size(); i++)
		{
			for (unsigned int k = 0; k < hand.size(); k++)
			{
				if ((hand[k] == lastRun[i]))
				{
					hand.erase(hand.begin() + k);

				}
			}
		}
		//Calls countCardPoints in Player class to count up remaining card points
		//Returns that int
		cout << "The computer has put down a run! It is a run of ... ";
		printCards(lastRun);
		cout << "\nNow counting up all computer points!\n";
		int totalPoints = countCardPoints(hand, round);
		cout << "Total Points: " << totalPoints << "\n";
		return totalPoints;
	}

	//No books or runs were found in computer hand
	//Calls countCardPoints in Player class to count up remaining card points
	//Returns that int
	int totalPoints = countCardPoints(hand, round);
	cout << "The computer could not find any cards to put down before the round ends.\n";
	cout << "Now counting up all computer points!.\n";
	cout << "Total Points: " << totalPoints << "\n";
	return totalPoints;

}

Computer::~Computer()
{
}


