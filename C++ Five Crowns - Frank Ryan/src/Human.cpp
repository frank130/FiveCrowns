#include "pch.h"
#include "Human.h"
#include "Player.h"
#include <algorithm>
#include <vector>
#include "Card.h"
#include "Deck.h"
#include <iomanip>
#include "Computer.h"


using namespace std;
Human::Human()
{
}

/****************************************************
Function Name: startTurn
Purpose: Begin a human player's turn
Parameters: vector<Card> hand, vector<Card> drawPile, vector<Card> discardPile, deck, int round, int winningCondition, int save. All passed by reference except deck and round.
Return Value: vector<Card>
Algorithim:
	1. Ask user for input for what to do.
	2. Input Valid his answer.
		3. Check if user asks for help.
			4. Copy computer functionalities for picking up cards.
			5. Ask for input for which card to draw.
				6. Input validation answer.
	7. Check if user asks for help when discarding.
		8. Copy computer functionalities for dropping a card.
			9. Ask for input for which card to discard.
				10. Input validate answer.
	11. Check if user asks for help when going out.
		12. Copy computer functionalities for going out.
			13. Ask for input on going out.
				14. Validate answer.


*****************************************************/
vector<Card> Human::startTurn(vector<Card> &hand, vector<Card> &drawPile, vector<Card> &discardPile, Deck *deck, int round, int &winningCondition, int &save)
{
	vector<Card> newhumanHand;
	vector<Card> finalHand;

	//Print options for starting user turn
	cout << "What would you like to do?\n";
	cout << "1. Save the game.\n";
	cout << "2. Make a move.\n";
	cout << "3. Ask for help.\n";
	cout << "4. Quit the game.\n";

	string answer;
	cin >> answer;
	//Input validate the user input, ask for another if not valid
	while (answer != "1" && answer != "2" && answer != "3" && answer != "4")
	{
		cout << "Please enter either 1,2,3, or 4.\n";
		cin >> answer;
	}

	//Condition that checks if user wants to save
	//If true, set save reference parameter to 1 and return hand.
	if (answer.compare("1") == 0)
	{
		save = 1;
		return hand;
	}
	//Condition that check if user wants to exit
	if (answer.compare("4") == 0)
	{
		exit(0);
	}
	//Condition that checks if user wants help picking up card
	while (answer.compare("3") == 0)
	{
		//calling player function.
		//sets card vector to the largest possible book in the user's hand, calling checkPossibleBook from player Class
		vector<Card> largestBook = checkPossibleBook(hand, round, 0);

		//Condition that checks if the book vector isn't empty
		if (largestBook.size() != 0)
		{

			//Condition that looks at discardPile. If the discard Pile can add to his book, the computer lets the player know. Breaks out of help.
			if (discardPile.at(0).getNumValue() == largestBook.at(0).getNumValue() || discardPile.at(0).getNumValue() == 50 || discardPile.at(0).getNumValue() == round)
			{
				cout << "\nThe computer recommends you to pick up " + discardPile.at(0).getVal() + discardPile.at(0).getSuite() << " from the discard pile because it can add to your possible book of ... ";
				printCards(largestBook);
				cout << "\n";
				break;
			}

			//calling player function.
			//sets card vector to largest possible run
			vector<Card> largestRun = checkPossibleRun(hand, round, 0);
			if (largestRun.size() != 0)
			{

				//Condition that looks at discardPile. If the discard pile can add to this run, the computer lets the player know. Breaks out of help.
				if ((discardPile.at(0).getNumValue() == largestRun.at(largestRun.size() - 1).getNumValue() + 1 && discardPile.at(0).getSuite() == largestRun.at(largestRun.size() - 1).getSuite()) || discardPile.at(0).getNumValue() == 50 || discardPile.at(0).getNumValue() == round)
				{
					cout << "\nThe computer recommends you to pick up " + discardPile.at(0).getVal() + discardPile.at(0).getSuite() << " from the discard pile because it can add to your possible run of ... ";
					printCards(largestRun);
					cout << "\n";
					break;

				}
			}

			//Letting the player know that the discard pile cannot add to his book, so tells it to pick from draw.
			cout << "\nThe computer recommends you to pick from the draw pile because ... ";
			cout << "the discard pile card cannot add to your possible book of ... ";
			printCards(largestBook);
			cout << "\n";
			break;



		}

		//calling player function.
		//sets card vector to largest possible run
		vector<Card> largestRun = checkPossibleRun(hand, round, 0);

		//Checks if the largest run vector isnt empty
		if (largestRun.size() != 0)
		{
			//Condition that looks at discardPile. If the discard pile can add to this run, the computer lets the player know. Breaks out of help.
			if ((discardPile.at(0).getNumValue() == largestRun.at(largestRun.size() - 1).getNumValue() + 1 && discardPile.at(0).getSuite() == largestRun.at(largestRun.size() - 1).getSuite()) || discardPile.at(0).getNumValue() == 50 || discardPile.at(0).getNumValue() == round)
			{
				cout << "\nThe computer recommends you to pick up " + discardPile.at(0).getVal() + discardPile.at(0).getSuite() << " from the discard pile because it can add to your possible run of ... ";
				printCards(largestRun);
				cout << "\n";
				break;

			}
			//If the discard pile cannot add to run, computer tells player to get draw card
			cout << "\nThe computer recommends you to pick from the draw pile because ... ";
			cout << "the discard pile card did not add to your possible run of ... ";
			printCards(largestRun);
			cout << "\n";
			break;

		}

		//If there is no run or book inside the hand, the code is here
		//Checks if the discard pile has a joker on it
		//If so, computer tells player to pick it up
		if (discardPile.at(0).getNumValue() == 50)
		{
			cout << "\nThe computer recommends you to pick up " + discardPile.at(0).getVal() + discardPile.at(0).getSuite() + " from the discard pile because it is a wild card.\n";
			cout << "\n";
			break;


		}
		//Checks if the discard pile has a wild on it
		//If so, computer tells player to pick it up
		if (discardPile.at(0).getNumValue() == round)
		{
			cout << "\nThe computer recommends you to pick up " + discardPile.at(0).getVal() + discardPile.at(0).getSuite() + " from the discard pile because it is a wild card.\n";
			cout << "\n";
			break;

		}
		//If the discard pile doesnt not have a wild or joker on it, computer recommends to pick from draw pile.
		if (discardPile.at(0).getNumValue() != 50)
		{
			if (discardPile.at(0).getNumValue() != round)
			{
				cout << "\nThe computer recommends you to pick from the draw pile because the discard pile does not have a wild and does not add to any of your current possible runs or books.\n";
				cout << "\n";
				break;

			}

		}
	
	}
	//sets answer variable to 2, so that the player can pick card now
	answer = "2";

	if (answer.compare("2") == 0)
	{
		string answer2;
		cout << "What would you like to do?\n";
		cout << "1. Pick from the draw pile.\n";
		cout << "2. Pick from the discard pile.\n";
		cin >> answer2;

		//Input validates the user's input to pick a card
		while (answer2 != "1" & answer2 != "2")
		{
			cout << "Please enter either 1 or 2.\n";
			cin >> answer2;
		}

		//Condition if user decides to pick from draw
		if (answer2.compare("1") == 0)
		{
			//sets vector<Card> newhumanHand to a function in Player class called pickDrawCard, which picks top draw card and adds to hand
			newhumanHand = pickDrawCard(hand, drawPile);
		}

		//Condition if user decides to pick from draw
		else if (answer2.compare("2") == 0)
		{
			//sets vector<Card> newhumanHand to a function in Player class called pickDiscCard, which picks top discard card and adds to hand
			newhumanHand = pickDiscCard(hand, discardPile);
		}

		cout << "This is your new hand!\n";
		cout << "\n";

		
		//Printing new human's hand to screen

		string humanHand = deck->printCardHand(newhumanHand);
		cout << setw(15) << "Hand: " << humanHand << "\n";
		cout << "\n";

		cout << "\nYou must now discard a card in your hand. What would you like to do?\n";
		cout << "1. Choose a card to discard.\n";
		cout << "2. Ask for help.\n";
		string discardHelp;
		cin >> discardHelp;

		//Input validation after asking for help or choosing to discard a card
		while (discardHelp != "1" && discardHelp != "2")
		{
			cout << "\nPlease enter either 1 or 2.\n";
			cin >> discardHelp;
		}

		//Condition that checks if the computer chose to ask computer for help
		while (discardHelp.compare("2") == 0)
		{	
			int breakRecommend = 0;

			//Calls player class function checkPossibleBook
			//Finds largest book in players hand, sets to card vector
			vector<Card> largestBook = checkPossibleBook(hand, round, 0);

			//Checks if the largest book size is not empty and is less than 9
			if (largestBook.size() != 0 && largestBook.size() < 9)
			{
				
				//Iterates through hand to find a card in the hand that is not inside the largest book
				for (int i = 0; i < newhumanHand.size();i++)
				{
					int found = 0;
					for (int j = 0; j < largestBook.size();j++)
					{
						//changes found variable to 1 if it finds a card that is inside book
						if (newhumanHand[i] == largestBook[j])
						{
							found = 1;
						}
					}
					//If there is a card that is not inside book, computer recommmends player to drop that card, breaks from while
					if (found == 0)
					{
						cout << "\nThe computer recommends you to drop your " + newhumanHand.at(i).getVal() + newhumanHand.at(i).getSuite() + " because it does not add to your book of ... ";
						printCards(largestBook);
						breakRecommend = 1;
						break;
					}
				}
				if (breakRecommend == 1)
				{
					break;
				}

				//Calls player class function checkPossibleRun
				//Finds largest run in players hand, sets to card vector
				vector<Card> largestRun = checkPossibleRun(hand, round, 0);
				
				//Checks if there is a largest run inside the hand
				if (largestRun.size() != 0)
				{
					//Iterates through hand to find a card in the hand that is not inside the largest run
					for (int i = 0; i < newhumanHand.size();i++)
					{
						int found = 0;

						//changes found variable to 1 if it finds a card that is inside book
						for (int j = 0; j < largestRun.size();j++)
						{
							if (newhumanHand[i] == largestRun[j])
							{
								found = 1;
							}
						}

						//If there is a card that is not inside run, computer recommmends player to drop that card, breaks from while
						if (found == 0)
						{
							cout << "\nThe computer recommends you to drop your " + newhumanHand.at(i).getVal() + newhumanHand.at(i).getSuite() + " because it does not add to your run of ... ";
							printCards(largestRun);
							breakRecommend = 1;
							break;
							
						}
					}
					if (breakRecommend == 1)
					{
						break;
					}
					
				}

			}
			//Calls player class function checkPossibleRun
			//Finds largest run in players hand, sets to card vector
			vector<Card> largestRun = checkPossibleRun(hand, round, 0);
			if (largestRun.size() != 0)
			{
				//Iterates through hand to find a card in the hand that is not inside the largest run
				for (int i = 0; i < newhumanHand.size();i++)
				{
					int found = 0;

					//changes found variable to 1 if it finds a card that is inside book
					for (int j = 0; j < largestRun.size();j++)
					{
						if (newhumanHand[i] == largestRun[j])
						{
							found = 1;
						}
					}

					//If there is a card that is not inside run, computer recommmends player to drop that card, breaks from while
					if (found == 0)
					{
						cout << "\nThe computer recommends you to drop your " + newhumanHand.at(i).getVal() + newhumanHand.at(i).getSuite() + " because it does not add to your run of ... ";
						printCards(largestRun);
						breakRecommend = 1;
						break;

					}
				}
				if (breakRecommend == 1)
				{
					break;
				}

			}
			//Code reaches here if there is no run or book inside player's hand
			//If the first card in players hand is not wild or joker, computer recommends to drop it
			if (newhumanHand.at(0).getNumValue() != round)
			{
				if (newhumanHand.at(0).getNumValue() != 50)
				{
					cout << "\nThe computer recommends you to drop your " + newhumanHand.at(0).getVal() + newhumanHand.at(0).getSuite() + " because it was not adding to any of your possible runs or books the computer found.\n";
					break;
				}
			}
			//If the first card in players hand is wild, computer recommends to drop the card that is second in the hand
			if (newhumanHand.at(0).getNumValue() == round)
			{
				cout << "\nThe computer recommends you to drop your  " + newhumanHand.at(1).getVal() + newhumanHand.at(1).getSuite() + " because it was not adding to any of your possible runs or books the computer found.\n";
				break;
			}

			//If the first card in players hand is joker, computer recommends to drop the card that is second in the hand
			if (newhumanHand.at(0).getNumValue() == 50)
			{
				cout << "\nThe computer recommends you to drop your  " + newhumanHand.at(1).getVal() + newhumanHand.at(1).getSuite() + " because it was not adding to any of your possible runs or books the computer found.\n";
				break;
			}


		}
		
		cout << "\nWhich card would you like to discard? (Please enter the name of the card, eg. QH or 4D)\n";
		
		string discardValue;
		cin >> discardValue;

		
		//Takes in discard card that the user wants to drop and passes to this function
		//function searchDiscCard is found in human class, which removes the designated card from the human's hand
		searchDiscCard(newhumanHand, discardPile, discardValue);
		
		cout << "\nThis is your new hand! ";
		printCards(newhumanHand);
		cout << "\n";
		cout << "\n";

		cout << "Would you like to try to go out with this hand? \n";
		cout << "1. Try to go out with this hand.\n";
		cout << "2. Ask for help.\n";
		cout << "3. No thanks.\n";
		string goOutResponse;
		cin >> goOutResponse;

		//Input validates the player's response to go out
		while (goOutResponse != "1" && goOutResponse != "2" && goOutResponse != "3")
		{
			cout << "Please enter 1, 2 or 3.\n";
			cin >> goOutResponse;
		}
		//Condition that exists function if the player doesnt wanna go out, returns new human hand
		if (goOutResponse == "3")
		{
			cout << "Ending your turn.\n";
			return newhumanHand;
		}
		
		//Condition that checks if the user asked for help
		while (goOutResponse == "2")
		{
			//Calling player function checkComputerGoOut, which goes through all possibilities of humans hand to go out.
			//Sets it to vector Card
			vector<Card> outHelp = checkComputerGoOut(newhumanHand, round, "player");

			//If outHelp is a null hand, the computer has found a way for the computer to go out. Recommends it to go out.
			if (outHelp.size() == 0)
			{
				cout << "The computer recommends you to go out!\n";
				
				break;
			}

			//If not found, breaks out of while
			cout << "The computer couldn't find any way for you to go out.\n";
			
			break;
		}
		string secondOut;
		//Goes into this condition if user asked for help
		if (goOutResponse != "1")
		{
			cout << "Would you like to enter cards to go out?\n";
			cout << "1. Yes.\n";
			cout << "2. No.\n";
			
			cin >> secondOut;

			//Condition that validates the user input for going out
			while (secondOut != "1" && secondOut != "2")
			{
				cout << "Please enter 1 or 2.\n";
				cin >> secondOut;
			}

			//Condition that returns new human hand if the user doesnt want to go out
			if (secondOut == "2")
			{
				cout << "Ending your turn.\n";
				return newhumanHand;
			}
		}
		secondOut = "1";

		//Condition that is met if the human wants to try to go out
		while (secondOut == "1")
		{	
			cout << "Please enter how you would like to go out. \n(Enter runs and books seperated by a colon, and cards seperated by a comma, ex. 4H,5H,6H:8C,J2,8T\n";
			string goOut;
			cin >> goOut;

			//Calls boolean function checkHumanGoOut to validate the user's inputted go out runs and books
			//If false, the input was not books and runs and asks the user if he would like to try again
			if (checkHumanGoOut(goOut, round, newhumanHand) == false)
			{
				cout << "\nWould you still like to try to go out with this hand?\n";
				cout << "1. Yes.\n";
				cout << "2. No.\n";
				cin >> secondOut;
			}
			//Calling of boolean function again
			//If true, then the user has went out.
			//Sets winningCondition to 1 through reference and returns the new human's hand
			else if (checkHumanGoOut(goOut, round, newhumanHand) == true)
			{
				cout << "You've gone out. Congradulations! The other player now gets 1 more turn before the round is over.\n";
				winningCondition = 1;
				return newhumanHand;
			}
			//Condition that input validates the users deciding to try to go out again
			while (secondOut != "1" && secondOut != "2")
			{
				cout << "Please enter 1 or 2.\n";
				cin >> secondOut;
			}
		}

		//If the user does not wish to try to go out again, then returns new human's hand
		if (secondOut == "2");
		{
			return newhumanHand;
		}
		
		
	}

	return newhumanHand;
}

/****************************************************
Function Name: startLastTurn
Purpose: Begin a human player's last turn of round
Parameters: vector<Card> hand, vector<Card> drawPile, vector<Card> discardPile, deck, int round. All passed by reference except deck and round.
Return Value: int
Algorithim:
	1. Ask user for input for what to do.
	2. Input Valid his answer.
		3. Check if user asks for help.
			4. Copy computer functionalities for picking up cards.
			5. Ask for input for which card to draw.
				6. Input validation answer.
	7. Check if user asks for help when discarding.
		8. Copy computer functionalities for dropping a card.
			9. Ask for input for which card to discard.
				10. Input validate answer.
	11. Check if user asks for help when going out.
		12. Copy computer functionalities for going out.
			13. Ask for input on going out.
				14. Validate answer.
				15. If human cannot go out, ask for possible runs or books to go out
				16. Count up cards that are not books or runs, return it.


*****************************************************/
int Human::startLastTurn(vector<Card> &hand, vector<Card> &drawPile, vector<Card> &discardPile, Deck *deck, int round)
{
	vector<Card> newhumanHand;
	vector<Card> finalHand;

	//Print options for starting user turn
	cout << "What would you like to do?\n";
	cout << "1. Save the game.\n";
	cout << "2. Make a move.\n";
	cout << "3. Ask for help.\n";
	cout << "4. Quit the game.\n";

	string answer;
	cin >> answer;
	
	//Input validate the user input, ask for another if not valid
	while (answer != "1" && answer != "2" && answer != "3" && answer != "4")
	{
		cout << "Please enter either 1,2,3, or 4.\n";
		cin >> answer;
	}

	//Condition that check if user wants to exit
	if (answer.compare("4") == 0)
	{
		exit(0);
	}
	
	//Condition that checks if user wants help picking up card
	while (answer.compare("3") == 0)
	{
		//calling player function.
		//sets card vector to the largest possible book in the user's hand, calling checkPossibleBook from player Class
		vector<Card> largestBook = checkPossibleBook(hand, round, 0);

		//Condition that checks if the book vector isn't empty
		if (largestBook.size() != 0 && largestBook.size() < 9)
		{

			//Condition that looks at discardPile. If the discard Pile can add to his book, the computer lets the player know. Breaks out of help.
			if (discardPile.at(0).getNumValue() == largestBook.at(0).getNumValue() || discardPile.at(0).getNumValue() == 50 || discardPile.at(0).getNumValue() == round)
			{
				cout << "\nThe computer recommends you to pick up " + discardPile.at(0).getVal() + discardPile.at(0).getSuite() << " from the discard pile because it can add to your book of ... ";
				printCards(largestBook);
				cout << "\n";
				break;
			}
			
			//calling player function.
			//sets card vector to largest possible run
			vector<Card> largestRun = checkPossibleRun(hand, round, 0);

			//Checks if largestRun isnt empty
			if (largestRun.size() != 0)
			{
				
				//Condition that looks at discardPile. If the discard pile can add to this run, the computer lets the player know. Breaks out of help.
				if ((discardPile.at(0).getNumValue() == largestRun.at(largestRun.size() - 1).getNumValue() + 1 && discardPile.at(0).getSuite() == largestRun.at(largestRun.size() - 1).getSuite()) || discardPile.at(0).getNumValue() == 50 || discardPile.at(0).getNumValue() == round)
				{
					cout << "\nThe computer recommends you to pick up " + discardPile.at(0).getVal() + discardPile.at(0).getSuite() << " from the discard pile because it can add to your run of ... ";
					printCards(largestRun);
					cout << "\n";
					break;

				}
			}
			//Letting the player know that the discard pile cannot add to his book, so tells it to pick from draw.
			cout << "\nThe computer recommends you to pick from the draw pile because ... ";
			cout << "the discard pile card cannot add to your book of ... ";
			printCards(largestBook);
			cout << "\n";
			break;



		}
		//calling player function.
		//sets card vector to largest possible run
		vector<Card> largestRun = checkPossibleRun(hand, round, 0);

		//Checks if the largest run vector isnt empty
		if (largestRun.size() != 0)
		{
			
			//Condition that looks at discardPile. If the discard pile can add to this run, the computer lets the player know. Breaks out of help.
			if ((discardPile.at(0).getNumValue() == largestRun.at(largestRun.size() - 1).getNumValue() + 1 && discardPile.at(0).getSuite() == largestRun.at(largestRun.size() - 1).getSuite()) || discardPile.at(0).getNumValue() == 50 || discardPile.at(0).getNumValue() == round)
			{
				cout << "\nThe computer recommends you to pick up " + discardPile.at(0).getVal() + discardPile.at(0).getSuite() << " from the discard pile because it can add to your run of ... ";
				printCards(largestRun);
				cout << "\n";
				break;

			}
			//If the discard pile cannot add to run, computer tells player to get draw card
			cout << "\nThe computer recommends you to pick from the draw pile because ... ";
			cout << "the discard pile card did not add to your run of ... ";
			printCards(largestRun);
			cout << "\n";
			break;

		}
		
		//If there is no run or book inside the hand, the code is here
		//Checks if the discard pile has a joker on it	
		//If so, computer tells player to pick it up
		if (discardPile.at(0).getNumValue() == 50)
		{
			cout << "\nThe computer recommends you to pick up " + discardPile.at(0).getVal() + discardPile.at(0).getSuite() + " from the discard pile because it is a wild card.\n";
			cout << "\n";
			break;


		}
		
		//Checks if the discard pile has a wild on it
		//If so, computer tells player to pick it up
		if (discardPile.at(0).getNumValue() == round)
		{
			cout << "\nThe computer recommends you to pick up " + discardPile.at(0).getVal() + discardPile.at(0).getSuite() + " from the discard pile because it is a wild card.\n";
			cout << "\n";
			break;

		}
		
		//If the discard pile doesnt not have a wild or joker on it, computer recommends to pick from draw pile.
		if (discardPile.at(0).getNumValue() != 50)
		{
			if (discardPile.at(0).getNumValue() != round)
			{
				cout << "\nThe computer recommends you to pick from the draw pile because the discard pile does not have a wild and does not add to any of your current runs or books.\n";
				cout << "\n";
				break;

			}

		}

	}
	answer = "2";
	//sets answer variable to 2, so that the player can pick card now
	if (answer.compare("2") == 0)
	{
		string answer2;
		cout << "What would you like to do?\n";
		cout << "1. Pick from the draw pile.\n";
		cout << "2. Pick from the discard pile.\n";
		cin >> answer2;
		
		//Input validates the user's input to pick a card
		while (answer2 != "1" & answer2 != "2")
		{
			cout << "Please enter either 1 or 2.\n";
			cin >> answer2;
		}
		
		//Condition if user decides to pick from draw
		if (answer2.compare("1") == 0)
		{
			
			//sets vector<Card> newhumanHand to a function in Player class called pickDrawCard, which picks top draw card and adds to hand
			newhumanHand = pickDrawCard(hand, drawPile);
		}
		else if (answer2.compare("2") == 0)
		{
			//sets vector<Card> newhumanHand to a function in Player class called pickDiscCard, which picks top discard card and adds to hand
			newhumanHand = pickDiscCard(hand, discardPile);
		}

		hand = newhumanHand;
		cout << "This is your new hand!\n";
		cout << "\n";
		
		//Printing new human's hand to screen


	

		string humanHand = deck->printCardHand(newhumanHand);
		cout << setw(15) << "Hand: " << humanHand << "\n";
		cout << "\n";

		cout << "You must now discard a card in your hand. What would you like to do?\n";
		cout << "1. Choose a card to discard.\n";
		cout << "2. Ask for help.\n";
		string discardHelp;
		cin >> discardHelp;
		
		//Input validation after asking for help or choosing to discard a card
		while (discardHelp != "1" && discardHelp != "2")
		{
			cout << "\nPlease enter either 1 or 2.\n";
			cin >> discardHelp;
		}
		
		//Condition that checks if the computer chose to ask computer for help
		while (discardHelp.compare("2") == 0)
		{
			int breakRecommend = 0;
			
			//Calls player class function checkPossibleBook
			//Finds largest book in players hand, sets to card vector
			vector<Card> largestBook = checkPossibleBook(hand, round, 0);

			//Checks if the largest book size is not empty and is less than 9




			if (largestBook.size() != 0)
			{
				//Iterates through hand to find a card in the hand that is not inside the largest book
				for (int i = 0; i < newhumanHand.size();i++)
				{
					int found = 0;
					for (int j = 0; j < largestBook.size();j++)
					{
						
						//changes found variable to 1 if it finds a card that is inside book
						//changes found variable to 1 if it finds a card that is inside book
						if (newhumanHand[i] == largestBook[j])
						{
							found = 1;
						}
					}
					
					//If there is a card that is not inside book, computer recommmends player to drop that card, breaks from while
					if (found == 0)
					{
						cout << "\nThe computer recommends you to drop your " + newhumanHand.at(i).getVal() + newhumanHand.at(i).getSuite() + " because it does not add to your book of ... ";
						printCards(largestBook);
						breakRecommend = 1;
						break;
					}
				}
				if (breakRecommend == 1)
				{
					break;
				}

				//Calls player class function checkPossibleRun
				//Finds largest run in players hand, sets to card vector
				vector<Card> largestRun = checkPossibleRun(hand, round, 0);
				
				//Checks if there is a largest run inside the hand
				if (largestRun.size() != 0)
				{
					//Iterates through hand to find a card in the hand that is not inside the largest run
					for (int i = 0; i < newhumanHand.size();i++)
					{
						int found = 0;
						for (int j = 0; j < largestRun.size();j++)
						{
							
							//changes found variable to 1 if it finds a card that is inside book
							if (newhumanHand[i] == largestRun[j])
							{
								found = 1;
							}
						}
						if (found == 0)
						{
							
							//If there is a card that is not inside run, computer recommmends player to drop that card, breaks from while
							cout << "\nThe computer recommends you to drop your " + newhumanHand.at(i).getVal() + newhumanHand.at(i).getSuite() + " because it does not add to your run of ... ";
							printCards(largestRun);
							breakRecommend = 1;
							break;

						}
					}
					if (breakRecommend == 1)
					{
						break;
					}

				}

			}

			//Calls player class function checkPossibleRun
			//Finds largest run in players hand, sets to card vector
			vector<Card> largestRun = checkPossibleRun(hand, round, 0);
			if (largestRun.size() != 0)
			{
				
				//Iterates through hand to find a card in the hand that is not inside the largest run
				for (int i = 0; i < newhumanHand.size();i++)
				{
					int found = 0;
					for (int j = 0; j < largestRun.size();j++)
					{
						//changes found variable to 1 if it finds a card that is inside book
						if (newhumanHand[i] == largestRun[j])
						{
							found = 1;
						}
					}
					
					//If there is a card that is not inside run, computer recommmends player to drop that card, breaks from while
					if (found == 0)
					{
						cout << "\nThe computer recommends you to drop your " + newhumanHand.at(i).getVal() + newhumanHand.at(i).getSuite() + " because it does not add to your run of ... ";
						printCards(largestRun);
						breakRecommend = 1;
						break;

					}
				}
				if (breakRecommend == 1)
				{
					break;
				}

			}
			//Code reaches here if there is no run or book inside player's hand
			//If the first card in players hand is not wild or joker, computer recommends to drop it
			if (newhumanHand.at(0).getNumValue() != round)
			{
				if (newhumanHand.at(0).getNumValue() != 50)
				{
					cout << "\nThe computer recommends you to drop your " + newhumanHand.at(0).getVal() + newhumanHand.at(0).getSuite() + " because it was not adding to any of your possible runs or books the computer found.\n";
					break;
				}
			}
			
			//If the first card in players hand is wild, computer recommends to drop the card that is second in the hand
			if (newhumanHand.at(0).getNumValue() == round)
			{
				cout << "\nThe computer recommends you to drop your  " + newhumanHand.at(1).getVal() + newhumanHand.at(1).getSuite() + " because it was not adding to any of your possible runs or books the computer found.\n";
				break;
			}
			
			//If the first card in players hand is joker, computer recommends to drop the card that is second in the hand
			if (newhumanHand.at(0).getNumValue() == 50)
			{
				cout << "\nThe computer recommends you to drop your  " + newhumanHand.at(1).getVal() + newhumanHand.at(1).getSuite() + " because it was not adding to any of your possible runs or books the computer found.\n";
				break;
			}


		}

		cout << "\nWhich card would you like to discard? (Please enter the name of the card, eg. QH or 4D)\n";
		string discardValue;
		cin >> discardValue;

		//Takes in discard card that the user wants to drop and passes to this function
		//function searchDiscCard is found in human class, which removes the designated card from the human's hand
		searchDiscCard(newhumanHand, discardPile, discardValue);

		cout << "\nThis is your new hand! ";
		printCards(newhumanHand);
		cout << "\n";
		cout << "\n";

		cout << "Would you like to try to go out with this hand or put down runs/books before the round is over? \n";
		cout << "1. Try to go out with this hand.\n";
		cout << "2. Ask for help.\n";
		cout << "3. No thanks.\n";
		string goOutResponse;
		cin >> goOutResponse;
		
		//Input validates the player's response to go out
		while (goOutResponse != "1" && goOutResponse != "2" && goOutResponse != "3")
		{
			cout << "Please enter 1, 2 or 3.\n";
			cin >> goOutResponse;
		}
		
		//Condition that exists function if the player doesnt wanna go out, returns new human hand
		if (goOutResponse == "3")
		{
			cout << "Now counting up all your points!\n";
			int totalPoints = countCardPoints(newhumanHand, round);
			cout << "Total Points: " << totalPoints << "\n";
			return totalPoints;
		}
		
		//Condition that checks if the user asked for help
		while (goOutResponse == "2")
		{
			//Calling player function checkComputerGoOut, which goes through all possibilities of humans hand to go out.
			//Sets it to vector Card
			vector<Card> outHelp = checkComputerGoOut(newhumanHand, round, "player");//If outHelp is a null hand, the computer has found a way for the computer to go out. Recommends it to go out.
			if (outHelp.size() == 0)
			{
				cout << "The computer recommends you to go out!\n";

				break;
			}
			//If not found, checks for largest Run and largest Book in hand with previously used functions
			if (outHelp.size() != 0)
			{
				vector<Card> largestBook = checkPossibleBook(hand, round, 1);
				vector<Card> largestRun = checkPossibleRun(hand, round, 1);

				//If not book or run is found, let the player know
				if (largestBook.size() == 0 && largestRun.size() == 0)
				{
					cout << "The computer couldn't find any books or runs for you to put down.\n";
					break;
				}

				//Recommends book to place before going out
				if (largestBook.size() > largestRun.size())
				{
					cout << "The computer recommends you to put down your book of ... ";
					printCards(largestBook);
					cout << " before you go out.\n";
					break;
				}
				//Recommends run to place before going out
				if (largestBook.size() < largestRun.size())
				{
					cout << "The computer recommends you to put down your run of ... ";
					printCards(largestRun);
					cout << " before you go out.\n";
					break;
				}
				//Recommends book to place before going out
				if (largestBook.size() == largestRun.size())
				{
					cout << "The computer recommends you to put down your book of ... ";
					printCards(largestBook);
					cout << " before you go out.\n";
					break;
				}
				
				
			}

			cout << "The computer couldn't find any way for you to go out.\n";

			break;
		}
		string secondOut;

		//Checks if user asked for help previously
		if (goOutResponse != "1")
		{
			cout << "Would you like to enter cards to go out or put down runs/books before the round is over?\n";
			cout << "1. Yes.\n";
			cout << "2. No.\n";

			cin >> secondOut;
			//Input validation for trying to go out
			while (secondOut != "1" && secondOut != "2")
			{
				cout << "Please enter 1 or 2.\n";
				cin >> secondOut;
			}

			//Condition that checks if human decides to not book down any runs or books before he goes out
			if (secondOut == "2")
			{
				cout << "Ending your turn.\n";

				//Calls function countCardPoints in Player class
				//returns points of hand
				int totalPoints = countCardPoints(newhumanHand, round);
				cout << "Total Points: " << totalPoints << "\n";
				return totalPoints;
			}
		}
		secondOut = "1";

		//Condition that checks if user decided not to place anything down
		if (goOutResponse == "3")
		{
			cout << "Now counting up all your points!\n";

			//Calls function countCardPoints in Player class
			//returns points of hand
			int totalPoints = countCardPoints(newhumanHand, round);
			cout << "Total Points: " << totalPoints << "\n";
			return totalPoints;
		}

		//Condition that checks if the user wants to put down before the round is over
		while (secondOut == "1")
		{
			cout << "Please enter any runs or books in your hand. \n(Enter runs and books seperated by a colon, and cards seperated by a comma, ex. 4H,5H,6h:8C,J2,8T\n";
			string goOut;
			cin >> goOut;

			//Calling function humanLastGoOut in human class
			//returns null if human used all cards in hand
			//returns leftover cards if human placed any books or runs
			vector<Card> lastHand = humanLastGoOut(goOut, newhumanHand, round);
		
			//Condition that checks if human went out. Returns 0 points.
			if (lastHand.size() == 0)
			{
				cout << "Now counting up all your points!\n";
				int totalPoints = 0;
				cout << "Total Points: " << totalPoints << "\n";
				return totalPoints;
			}
			
			//Condition that counts up left over cards in humans hand after putting down books and runs
			//Returns points.
			else if(lastHand.size() != newhumanHand.size())
			{
				cout << "Now counting up all your points!\n";
				int totalPoints = countCardPoints(lastHand, round);
				cout << "Total Points: " << totalPoints << "\n";
				return totalPoints;
			}

			//Condition that checks if the returned hand is the same cards as the passed hand
			//If so, then the books and runs placed aren't valid. Asks if human would like to try again.
			if(lastHand.size() == newhumanHand.size())
			{
				cin >> secondOut;
				while (secondOut != "1" && secondOut != "2")
				{
					cout << "Please enter 1 or 2.\n";
					cin >> secondOut;
				}
			}

			//Checks if human doesnt wish to place any runs or books down
			if (secondOut == "2")
			{
				cout << "Now counting up all your points!\n";
				int totalPoints = countCardPoints(lastHand, round);
				cout << "Total Points: " << totalPoints << "\n";
				return totalPoints;
			}
			
		}
	}
	return 0;
}

/****************************************************
Function Name: searchDiscCard
Purpose: searching for inputted card to discard
Parameters: vector card of humans hand, vector card of discard pile, and string of wanted discarded card
Return Value: int
Algorithim:
	1. Check if the inputted card exists in deck
		2. Discard card from user's hand.


*****************************************************/
int Human::searchDiscCard(vector<Card> &humanHand, vector<Card> &discardPile, string discard)
{

	Deck *deck = new Deck();

	unsigned int size = humanHand.size();
	bool found = false;
	
	//While loop that is false until the card is found and removed
	while (!found)
	{

		//Calls deck function searchDeck
		//returns false if card is not found
		//This while is false until the card is found inside the deck
		while (!deck->searchDeck(deck, discard))
		{
			cout << "This card does not exist in the deck. Please enter a valid card.\n";
			cin >> discard;
		}

		//Seperating cards value and suite into seperate strings
		string s1 = discard;
		string s2 = s1.substr(0, 1); // Card Value
		string s3 = s1.substr(1, 1); // Card Suite

		//Iterate through humans hand to find position of card in user's hand, and discard it
		for (unsigned int i = 0; i < size; i++)
		{
			if ((humanHand[i].getVal() == s2) & (humanHand[i].getSuite() == s3))
			{
				found = true;

				//Calling dropCard function in Player class
				//Removes card from hand and exits function
				dropCard(humanHand, discardPile, i);
				return i;

			}
		}

		//Take in discard again if the card was not found in hand
	cout << "This card was not found in your hand. Please enter a card in your hand to discard.\n";
	cin >> discard;
	}

return 1;
}

/****************************************************
Function Name: searchGoOutCards
Purpose: Checks if inputted vector card is inside a different vector card
Parameters: vector card for human hand, vector string for inputted book or run
Return Value: boolean
Algorithim:
	1. Iterate through card hand and check if one vector string card is inside
		2. If true, insert into seperate new vector Card
	3. Check if new vector card size is equal to vector string size parameter
		4. If true, return true.
		5. If not the same size, then return false.


*****************************************************/
bool Human::searchGoOutCards(vector<Card> hand, vector<string> cards)
{
	unsigned int size = hand.size();

	//vector that should be the same size as vector<string> cards if value is true
	vector<string> check;

	//Iterate through vector string of cards
	for (int i = 0; i < cards.size();i++)
	{
		//Seperate value and suite into seperate strings
		string s1 = cards[i];
		string s2 = s1.substr(0, 1); // Card Value
		string s3 = s1.substr(1, 1); // Card Suite

		//Iterate through vector card of hand
		for (unsigned int j = 0; j < size; j++)
		{
			//If found, then push back card into new vector
			if ((hand[j].getVal() == s2) && (hand[j].getSuite() == s3))
			{
				check.push_back(cards[i]);
				break;
			}
		}
	}

	//If all cards in vector string are found inside vector card, return true, if not, return false.
	if (check.size() == cards.size())
	{
		return true;
	}

	return false;

}

/****************************************************
Function Name: checkHumanGoOut
Purpose: Check if inputted books and runs are valid and remove all cards from human's hand
Parameters: string of inputted books and runs, int of round, vector card of human's hand
Return Value: boolean
Algorithim:
	1. Validate that all cards inputted are valid cards and are inside the user's hand
	2. Check if the inputted cards are books and runs
		3. Return true if true, else return false.


*****************************************************/
bool Human::checkHumanGoOut(string finalHand, int round, vector<Card> &hand)
{
	vector<string> possibleCombination;

	//Validate input by checking if there are commas seperating cards, if not return false
	if (finalHand.find(",") == string::npos) {
		cout << "You did not input your hand properly to go out.\n";
		return false;
	}

	//Repalcing all colons with commans to check if cards exist in human's hand
	string checkingHand = finalHand;
	replace(checkingHand.begin(), checkingHand.end(), ':', ',');

	vector<string> checkingCards;

	for (stringstream sst(checkingHand); getline(sst, checkingHand, ','); )
	{
		checkingCards.push_back(checkingHand);
	}

	//Checks if all inputted cards count up to all cards in the human's hand
	if (checkingCards.size() != hand.size())
	{
		cout << "You did not enter all cards in your hand or entered too few. You need to go out using all cards in your hand.\n";
		return false;
	}

	//Calls function searchGoOutCards from human class
	//Checks if inputted cards are inside the human's hand, if not, return false.
	if (searchGoOutCards(hand, checkingCards) == false)
	{
		cout << "You entered a card that is not in your hand.\n";
		return false;
	}

	//Seperates each book and run and places into vector string
	for (stringstream sst(finalHand); getline(sst, finalHand, ':'); )
	{
		possibleCombination.push_back(finalHand);
	}


	unsigned int size = possibleCombination.size();

	//Iterate through all inputted books and runs
	for (unsigned int i = 0; i < size; i++)
	{
		//Calls function checkBook in human class
		//Checks if the inputted cards is a book
		if (checkBook(possibleCombination[i], hand, round) == false)
		{

			//Calls function checkRun in human class
			//Checks if the inputted cards is a run
			//If inputted cards is neither a book nor a run, then return function as false
			if (checkRun(possibleCombination[i], hand, round) == false)
			{
				cout << "The cards: " << possibleCombination[i] << "is not a run or a book";
				return false;
			}

		}

	}
	//All inputted cards are in a book or run, return true.
	return true;
}

/****************************************************
Function Name: humanLastGoOut
Purpose: Check if inputted books and runs are valid
Parameters: string of inputted books and runs, int of round, vector card of human's hand
Return Value: vector card that is meant to be counted for points
Algorithim:
	1. Validate that all cards inputted are valid cards and are inside the user's hand
	2. Check if the inputted cards are books and runs
		3. Return same vector hand if false
	4. Remove inputted books and runs from human's hand. Returns final vector card.


*****************************************************/
vector<Card> Human::humanLastGoOut(string finalHand, vector<Card> hand, int round)
{
	vector<string> possibleCombination;

	//Checks if the user used commans to seperate cards
	if (finalHand.find(",") == string::npos) {
		cout << "You did not input your hand properly to go out.\n";
		cout << "Would you like to try to input your runs and books again before the round is over?\n";
		return hand;
	}

	//replaces colons with commas to check if inputted cards are inside hand
	string checkingHand = finalHand;
	replace(checkingHand.begin(), checkingHand.end(), ':', ',');

	vector<string> checkingCards;

	//places inputted cards into vector string
	for (stringstream sst(checkingHand); getline(sst, checkingHand, ','); )
	{
		checkingCards.push_back(checkingHand);
	}

	//Calls searchGoOutCards function in human class
	//return false if there is a inputted card that is not inside the human's hand
	if (searchGoOutCards(hand, checkingCards) == false)
	{
		cout << "You entered a card that is not in your hand.\n";
		cout << "Would you like to try to input your runs and books again before the round is over?\n";
		return hand;
	}

	//Seperates runs and books and places them into string vector
	for (stringstream sst(finalHand); getline(sst, finalHand, ':'); )
	{
		possibleCombination.push_back(finalHand);
	}




	unsigned int size = possibleCombination.size();

	//Iterate through all inputted books and runs
	for (unsigned int i = 0; i < size; i++)
	{
		//Calls function checkBook in human class
		//Checks if the inputted cards is a book
		if (checkBook(possibleCombination[i], hand, round) == false)
		{	
			
			//Calls function checkRun in human class
			//Checks if the inputted cards is a run
			//If inputted cards is neither a book nor a run, then return function as original hand
			if (checkRun(possibleCombination[i], hand, round) == false)
			{
				cout << "The cards: " << possibleCombination[i] << "  is not a run or a book\n";
				cout << "Would you like to try to input your runs and books again before the round is over?\n";
				cout << "1. Yes.\n";
				cout << "2. No.\n";

				return hand;
			}

		}

	}

	//Code reaches here if inputted books and runs are valid
	//Iterates through inputted cards
	for (int i = 0; i < checkingCards.size(); i++)
	{

		//Seperates each cards value and suite
		string s1 = checkingCards[i];
		string s2 = s1.substr(0, 1); // Card Value
		string s3 = s1.substr(1, 1); // Card Suite

		//Iterate through human's hand
		for (unsigned int k = 0; k < hand.size(); k++)
		{
			//If card is found that is inside inputted string and hand, remove it
			if ((hand[k].getVal() == s2) & (hand[k].getSuite() == s3))
			{
				hand.erase(hand.begin() + k);

			}
		}
	}

	//returns the leftover cards inside the human's hand
	return hand;
}

/****************************************************
Function Name: checkRun
Purpose: Check if inputted string is a run
Parameters: string of run, vector card of hand, int of round
Return Value: boolean
Algorithim:
	1. Deseperate each card by commas
	2. Create a null vector of inputted cards size, and set that vector to inputted cards
	3. Iterate through cards to check if it is a round.
		4. Account for wilds
	4. Return true if it is a run, else false.


*****************************************************/
bool Human::checkRun(string check, vector<Card> hand, int round)
{
	vector<string> cards;
	string finalHand = check;

	//Seperates commans from inserted run
	for (stringstream sst(check); getline(sst, check, ','); )
	{
		cards.push_back(check);
	}

	unsigned int cardsSize = cards.size();

	vector<Card> run;

	//Creates card vector of inputted run
	for (int p = 0; p < cardsSize; p++)
	{
		run.push_back(Card("0", "0", 0));
	}


	//Creates card vector of inputted run
	for (unsigned int i = 0; i < cardsSize; i++)
	{
		string s1 = cards[i];
		string s2 = s1.substr(0, 1); // Card Value
		string s3 = s1.substr(1, 1); // Card Suit
		run[i] = Card(s2, s3, 0);


	}


	unsigned int runSize = run.size();

	int j = 0;
	for (j; j < runSize; j++)
	{
		if (run[j].getNumValue() != 50)
		{
			if (run[j].getNumValue() != round)
			{
				break;
			}

		}
	}
	if (run.size() < 3)
	{
		return false;
	}
	//set variable to handle run increments
	//Iterate through inputted cards
	int nextNumber = 1;
	for (int k = j + 1; k < runSize; k++)
	{
		//Conditions that check if the card is not a wild, if it is not the previous card's value +1 and same suite, then return false.
		if (run[k].getNumValue() != round)
		{
			if (run[k].getNumValue() != run[j].getNumValue() + nextNumber)
			{
				if (run[k].getSuite() != run[j].getSuite())
				{
					if (run[k].getNumValue() != 50)
					{
						return false;

					}
				}
			}
		}
		if (run[k].getNumValue() != round)
		{
			if (run[k].getNumValue() != run[j].getNumValue() + nextNumber)
			{
				if (run[k].getSuite() != run[j].getSuite())
				{
					if (run[k].getNumValue() != 50)
					{
						return false;
					}

				}
			}
		}
		//Incrementing the run increment in order to increase the run size as it keeps going
		nextNumber++;
	}
	
	//Return true if the cards are a run
	cout << "The entered cards: " << finalHand << " is a run!\n";
	return true;

}
bool Human::checkBook(string check, vector<Card> hand, int round)
{
	vector<string> cards;
	string finalHand = check;

	//Seperates commans from inserted book
	for (stringstream sst(check); getline(sst, check, ','); )
	{
		cards.push_back(check);
	}
	vector<Card> book;

	unsigned int cardsSize = cards.size();

	//Creates card vector of inputted book
	for (int p = 0; p < cardsSize; p++)
	{
		book.push_back(Card("0", "0", 0));
	}


	//Creates card vector of inputted book
	for (unsigned int i = 0; i < cardsSize; i++)
	{
		string s1 = cards[i];
		string s2 = s1.substr(0, 1); // Card Value
		string s3 = s1.substr(1, 1); // Card Suit
		book[i] = Card(s2, s3, 0);


	}

	//Checks if the inputted cards have a size greater than 2, if not return false.
	if (cardsSize < 3)
	{
		cout << "You did not enter enough cards for one of your runs/books. You must have a run or book of at least three.\n";
		return false;
	}

	unsigned int bookSize = book.size();

	int j = 0;
	for (j; j < bookSize; j++)
	{
		if (book[j].getNumValue() != 50)
		{
			if (book[j].getNumValue() != round)
			{
				break;
			}

		}
	}

	//Iterate through inputted book
	for (int k = j + 1; k < bookSize; k++)
	{
		//Conditions that check if the card is not a wild, or the same value of the previous card. If not, then return false.
		if (book[k].getNumValue() != book[j].getNumValue())
		{
			if (book[k].getNumValue() != 50)
			{
				if (book[k].getNumValue() != round)
				{
					return false;
				}

			}

		}
	}

	//The inputted cards have been found to be a book, return true.
	cout << "The entered cards: " << finalHand << " is a book!\n";
	return true;

}


/****************************************************
Function Name: checkEqualHands
Purpose: Check if vector cards are the same
Parameters: two vector cards
Return Value: boolean
Algorithim:
	1. Iterate through first vector card.
	2. If a card does not equal the other vector's card, then return false. Else, return true.



*****************************************************/
bool Human::checkEqualHands(vector<Card> firstHand, vector<Card> secondHand)
{

	//Iterate through first vector Card
	for (int i = 0; i < firstHand.size();i++)
	{
		//If the card does not equal the other vector's card, then return false.
		if (secondHand[i] != firstHand[i])
		{
			return false;
		}
	}

	//Return true if vectors are the same.
	return true;
}

Human::~Human()
{
}
