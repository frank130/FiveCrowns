#include "pch.h"
#include "Round.h"
#include "Deck.h"
#include "Card.h"
#include <stdlib.h>
#include <time.h>
#include <vector>
#include "Player.h"
#include <iomanip>
#include "Computer.h"
#include "Human.h"
#include <algorithm>
#include "Card.h"
#include <fstream>


using namespace std;
Round::Round()
{
}

/****************************************************
Function Name: startRound1
Purpose: Begins a round of five crowns. Meant to be iterated through multiple times.
Parameters: int round for round number, int winner for which player plays first, humanTotalPoints for humans points, computerTotalPoints for computer points. All passed by reference except round.
Return Value: int
Algorithim:
	1. Handle if the round is the first round of game.
		2. Take in user input for coin toss. Then begin player's turn for who ever won.
	3. Condition if human or computer begins first. 
		4. Deal cards to human first, then computer. Then deal out draw pile and give discard pile a card from top of draw pile.
		5. While condition that is false until a player goes out.
			6. Alternate through players turns, checking if either goes out. If they do, change winning condition to leave while loop and end function.
			7. Handle if the human decides to save, if so, put all data into text file.

*****************************************************/
int Round::startRound1(int round, int &winner, int &humanTotalPoints, int &computerTotalPoints)
{

	
	
	Human *human1 = new Human();
	Computer *computer = new Computer();



		//cards to each it set to round+2, as well as the wildcard for the round
		int cardsToEach = round + 2;
		int wildCard = cardsToEach;

		//Deck object contains all cards from 2 decks 
		Deck *deck = new Deck();
		//Function from deck class that shuffles all cards inside the two decks
		deck->shuffle();




		
		//Condition that handles first round, flips coin to determine who goes first
		if (round == 1)
		{
			//creates random number either 1 or 0, assigns 0 as tails and 1 as heads
			srand(time(NULL));
			int coin = rand() % 2;
			string coinCall;
			cout << "Please call the coin toss to see who goes first! ( Enter H for heads and T for tails )\n";
			
			cin >> coinCall;

			//While loop that handles input validation of coin toss 
			while (coinCall != "T" & coinCall != "H")
			{
				cout << "The call was " + coinCall;
				cout << "\nPlease enter either H for heads or T for tails.\n";
				cin >> coinCall;
			}

			//Condition that handle coin toss, if toss is 1 and player chooses heads, he wins coin toss, winner var is set to 1
			if ((coinCall.compare("H") == 0) & (coin == 1))
			{
				cout << "The toss is heads, the player will go first.\n";
				winner = 1;
			}
			//Condition that handle coin toss, if toss is 0 and player chooses tails, he wins coin toss, winner var is set to 1
			if ((coinCall.compare("T") == 0) & (coin == 0))
			{
				cout << "The toss is tails, the player will go first.\n";
				winner = 1;

			}
			//Condition that handle coin toss, if toss is 0 and player chooses heads, computer wins coin toss, winner var is set to 2
			if ((coinCall.compare("H") == 0) & (coin == 0))
			{
				cout << "The toss is tails, the computer will go first.\n";
				winner = 2;
			}
			//Condition that handle coin toss, if toss is 1 and player chooses tails, computer wins coin toss, winner var is set to 2
			if ((coinCall.compare("T") == 0) & (coin == 1))
			{
				cout << "The toss is heads, the computer will go first.\n" << endl;
				winner = 2;
			}

		}

		//Condition that begins round if the human goes first
		if (winner == 1)
		{
			//vector variables that contain cards
			//Calling deck functions to recieve cards


			//humanCards calls dealCards function from deck to get the humans hand
			vector<Card> humanCards = deck->dealCards(*deck, cardsToEach);
			//computerCards gets the computers hand
			vector<Card> computerCards = deck->dealCards(*deck, cardsToEach);
			//drawPile gets the remaining cards
			vector<Card> drawPile = deck->drawPile(*deck);
			//discardPile calls discardPile function from deck to take first card from drawPile and place into vector of discardPile
			vector<Card> discardPile = deck->discardPile(drawPile);

			
			//strings that call printCardHand function from deck class
			//strings hold all cards for each hand, including draw and discard pile
			string computerHand = deck->printCardHand(computerCards);
			string humanHand = deck->printCardHand(humanCards);
			string drawHand = deck->printCardHand(drawPile);
			string discardHand = deck->printCardHand(discardPile);


			//displaying game board setup, using newly created strings
			cout << "Round: " << round << endl;
			cout << "\n";
			cout << "\n";

			cout << "Computer\n";
			cout << setw(15) << "Score: " << computerTotalPoints << "\n";
			cout << setw(15) << "Hand: " << computerHand << "\n";
			cout << "\n";


			cout << "Human\n";
			cout << setw(15) << "Score: " << humanTotalPoints << "\n";
			cout << setw(15) << "Hand: " << humanHand << "\n";
			cout << "\n";


			cout << "Draw Pile: " << drawHand << "\n";
			cout << "\n";

			cout << "Discard Pile: " << discardHand << "\n";
			cout << "\n";

			//initializes variable that determines whether or not a player has went out
			//While loop is true until this variable is changed
			int winningCondition = 0;
			while (winningCondition == 0)
			{
				cout << "Next Player: Human\n";

				//creates variable save that is changed to 1 if user decides to save
				int save = 0;
				//uses human object to call startTurn in human class, stores return into vector newhumanHand
				//This function takes parameters of humans cards, the draw and discardpile, deck, wildCard for round, winningCondition, and save
				//All parameters are passed by reference except deck object, and wildCard
				vector<Card> newhumanHand = human1->startTurn(humanCards, drawPile, discardPile, deck, wildCard, winningCondition, save);

				//changes string of humans hand to the newhumanHand
				humanHand = deck->printCardHand(newhumanHand);

				//Condition that handles if the user wants to save, this variable can be changed to 1 in the human function startTurn
				if (save == 1)
				{
					ofstream saveFile;
					string fileName;
					cout << "Please type the file name for your new save file. Make sure you end your file name with .txt\n";
					
					//Condition that takes in input validation for file name
					//initializes variable that is changed to 1 if the file is valid, if not, the while continues
					int correctFile = 0;
					while (correctFile == 0)
					{
						//takes in fileName, looks for a period.
						//If no period found, asks for new file name until a period is inside the input
						cin >> fileName;
						while (fileName.find(".") == string::npos) {

							cout << "You did not insert a valid file name. Please try again, with a .txt at the end of the file.\n";
							cin >> fileName;
						}
						stringstream ss(fileName);
						string finalfile;
						vector<string> splitFile;

						//a vector string splitFile is created by seperating the input string by periods, and pushing back the splitted string
						while (getline(ss, finalfile, '.'))
						{
							splitFile.push_back(finalfile);
						}

						//Condition that checks if the period is at the end of the input string. If not, this condition is true
						if (splitFile.size() > 1)
						{

							//Condition that makes sure the file ends in .txt
							if (splitFile[1] != "txt") {
								cout << "Please make sure you end your file name with a .txt.\n";
							}
							//Condition that is true if it does end in .txt
							//Sets while loop variable to false
							if (splitFile[1] == "txt")
							{
								correctFile = 1;
							}
							//Condition that checks if there is more than 1 period inside the input file
							//Sets while loop variable back to true
							if (splitFile.size() > 2)
							{
								cout << "Please make sure you end your file name with a .txt.\n";
								correctFile = 0;
							}
							//Condition that makes sure there are no / inside the string
							//Sets while loop variable back to true
							if (splitFile[0].find("/") != string::npos)
							{
								cout << "Please do not insert a / inside you text file.\n";
								correctFile = 0;
							}

						}
						//Condition that looks to see if the file was ended with a period.
						//Sets while loop variable back to true
						if (splitFile.size() == 1)
						{
							cout << "You did not end your file with a .txt. Please try again.\n";
							correctFile = 0;
						}

					}

					//Outputs the save file into a .txt file.
					//Passes all data that is needed for text file, including round, scores, and hands. Then exits program.
					saveFile.open(fileName);
					saveFile << "Round: " << round << endl;
					saveFile << endl;
					saveFile << "Computer: " << endl;
					saveFile << "   Score: " << computerTotalPoints << endl;
					saveFile << "   Hand: " << computerHand << endl;
					saveFile << endl;
					saveFile << "Human: " << endl;
					saveFile << "   Score: " << humanTotalPoints << endl;
					saveFile << "   Hand: " << humanHand << endl;
					saveFile << endl;
					string drawHand = deck->printCardHand(drawPile);
					saveFile << "Draw Pile: " << drawHand << endl;
					saveFile << endl;
					string discardHand = deck->printCardHand(discardPile);
					saveFile << "Discard Pile: " << discardHand << endl;
					saveFile << endl;
					if (winner == 1)
					{
						saveFile << "Next Player: Human" << endl;
					}
					saveFile.close();
					exit(0);

				}

				//humanCards variable is now changed to newhumanHand from the human function startTurn
				humanCards = newhumanHand;

				//Condition that looks for a change in winningCondition.
				//This can be changed from 0 to 1 through the human function startTurn that was called before. This is possible because it is passed through reference in function.
				if (winningCondition == 1)
				{
					cout << "Next Player: Computer\n";
					//computer object calls computer function startLastTurn, that sends parameters of change that are all passed by reference except wildCard.
					//This returned int will be added to computer's total points.
					int computerPoints = computer->startLastTurn(computerCards, drawPile, discardPile, wildCard, winningCondition);

					//setting winner variable to 1, which is passed back by reference to game class, allowing to human to start next round
					winner = 1;

					//adding computerPoints for round into its total points.
					computerTotalPoints = computerTotalPoints + computerPoints;
					cout << "COMPUTER TOTAL POINTS: " << computerTotalPoints << "\n";
					cout << "\nWe are moving to the next round!\n";

					//exiting function to be iterated again in game class.
					return 0;
				}
				
				cout << "Next Player: Computer\n";

				cout << "\nIt is now the computer's turn!\n";
				cout << "\n";

				//uses computer object to call startTurn in computer class, stores return into vector newcomputerHand
				//This function takes parameters of computer cards, the draw and discardpile, wildCard for round, and winningCondition
				//All parameters are passed by reference except for wildCard
				vector<Card> newcomputerHand = computer->startTurn(computerCards, drawPile, discardPile, wildCard, winningCondition);

				//computerCards variable is now changed to newcomputerHand for printout of cards
				computerCards = newcomputerHand;

				//Condition that looks for a change in winningCondition.
				//This can be changed from 0 to 1 through the computer function startTurn that was called before. This is possible because it is passed through reference in function.
				if (winningCondition == 1)
				{
					cout << "The computer has gone out with his hand! This is your last turn of this round.\n";

					//prints computers hand to screen through new varibale computerHand, calling deck function printCardHand
					string computerHand = deck->printCardHand(newcomputerHand);
					cout << setw(15) << "This is the computer's hand: " << computerHand << "\n";
					cout << "\n";

					//prints draw and discard pile to screen, calling deck function printCardHand
					string drawHand1 = deck->printCardHand(drawPile);
					string discardHand1 = deck->printCardHand(discardPile);

					cout << "Next Player: Human\n";

					cout << "New Draw Pile: " << drawHand1 << "\n";
					cout << "\n";

					cout << "New Discard Pile: " << discardHand1 << "\n";
					cout << "\n";

					cout << "Human Hand: " << humanHand << "\n";
					
					//human object calls human function startLastTurn, that sends parameters of change that are all passed by reference except wildCard and deck.
					//This returned int will be added to human's total points.
					int humanPoints = human1->startLastTurn(humanCards, drawPile, discardPile, deck, wildCard);
					humanTotalPoints = humanTotalPoints + humanPoints;
					cout << "HUMAN TOTAL POINTS: " << humanTotalPoints << "\n";

					//setting winner variable to 2, which is passed back by reference to game class, allowing the computer to start next round
					winner = 2;

					//exiting function to be iterated again in game class.
					return 0;
				}
				
				//prints computers hand to screen through new varibale computerHand, calling deck function printCardHand
				string computerHand = deck->printCardHand(newcomputerHand);
				cout << setw(15) << "This is the computer's new hand: " << computerHand << "\n";

				//prints draw and discard pile to screen, calling deck function printCardHand
				string drawHand = deck->printCardHand(drawPile);
				string discardHand = deck->printCardHand(discardPile);


				//printing out all data of game to gameboard, then going back to while for next turn, since no player has gone out
				cout << "Round: " << round << endl;
				cout << "\n";
				cout << "\n";

				cout << "Computer\n";
				cout << setw(15) << "Score: " << computerTotalPoints << "\n";
				cout << setw(15) << "Hand: " << computerHand << "\n";
				cout << "\n";


				cout << "Human\n";
				cout << setw(15) << "Score: " << humanTotalPoints << "\n";
				cout << setw(15) << "Hand: " << humanHand << "\n";
				cout << "\n";


				cout << "Draw Pile: " << drawHand << "\n";
				cout << "\n";

				cout << "Discard Pile: " << discardHand << "\n";
				cout << "\n";

				
			}
			  
			

		}

		//Condition that begins round if the computer goes first
		if (winner == 2)
		{

			//vector variables that contain cards
			//Calling deck functions to recieve cards


			//computerCards calls dealCards function from deck to get the computer hand
			vector<Card> computerCards = deck->dealCards(*deck, cardsToEach);
			//humanCards gets the humans hand
			vector<Card> humanCards = deck->dealCards(*deck, cardsToEach);

			//drawPile gets the remaining cards
			vector<Card> drawPile = deck->drawPile(*deck);
			//discardPile calls discardPile function from deck to take first card from drawPile and place into vector of discardPile
			vector<Card> discardPile = deck->discardPile(drawPile);


			//strings that call printCardHand function from deck class
			//strings hold all cards for each hand, including draw and discard pile
			string computerHand = deck->printCardHand(computerCards);
			string humanHand = deck->printCardHand(humanCards);
			string drawHand = deck->printCardHand(drawPile);
			string discardHand = deck->printCardHand(discardPile);


			//printing out game board
			cout << "Round: " << round << endl;
			cout << "\n";
			cout << "\n";

			cout << "Computer\n";
			cout << setw(15) << "Score: " << computerTotalPoints << "\n";
			cout << setw(15) << "Hand: " << computerHand << "\n";
			cout << "\n";


			cout << "Human\n";
			cout << setw(15) << "Score: " << humanTotalPoints << "\n";
			cout << setw(15) << "Hand: " << humanHand << "\n";
			cout << "\n";


			cout << "Draw Pile: " << drawHand << "\n";
			cout << "\n";

			cout << "Discard Pile: " << discardHand << "\n";
			cout << "\n";


			//initializes variable that determines whether or not a player has went out
			//While loop is true until this variable is changed
			int winningCondition = 0;
			while (winningCondition == 0)
			{
				cout << "Next Player: Computer\n";

				cout << "It is now the computer's turn!\n";
				cout << "\n";

				//uses computer object to call startTurn in computer class, stores return into vector newcomputerHand
				//This function takes parameters of computer cards, the draw and discardpile, wildCard for round, and winningCondition
				//All parameters are passed by reference except for wildCard
				vector<Card> newcomputerHand = computer->startTurn(computerCards, drawPile, discardPile, wildCard, winningCondition);

				//computerCards variable is now changed to newcomputerHand for printout of cards
				computerCards = newcomputerHand;


				//Condition that looks for a change in winningCondition.
				//This can be changed from 0 to 1 through the computer function startTurn that was called before. This is possible because it is passed through reference in function.
				if (winningCondition == 1)
				{
					cout << "The computer has gone out with his hand! This is your last turn of this round.\n";

					//prints computers hand to screen through new varibale computerHand, calling deck function printCardHand

					string computerHand = deck->printCardHand(newcomputerHand);
					cout << setw(15) << "This is the computer's hand: " << computerHand << "\n";
					cout << "\n";
					
					//prints draw and discard pile to screen, calling deck function printCardHand
					string drawHand1 = deck->printCardHand(drawPile);
					string discardHand1 = deck->printCardHand(discardPile);


					cout << "Next Player: Human\n";
					cout << "New Draw Pile: " << drawHand1 << "\n";
					cout << "\n";

					cout << "New Discard Pile: " << discardHand1 << "\n";
					cout << "\n";

					cout << "Human Hand: " << humanHand << "\n";

					//human object calls human function startLastTurn, that sends parameters of change that are all passed by reference except wildCard and deck.
					//This returned int will be added to human's total points.
					int humanPoints = human1->startLastTurn(humanCards, drawPile, discardPile, deck, wildCard);
					humanTotalPoints = humanTotalPoints + humanPoints;
					cout << "HUMAN TOTAL POINTS: " << humanTotalPoints << "\n";
					
					//setting winner variable to 2, which is passed back by reference to game class, allowing the computer to start next round
					winner = 2;
					
					//exiting function to be iterated again in game class.
					return 0;
				}

				//prints computers hand to screen through new varibale computerHand, calling deck function printCardHand
				string computerHand = deck->printCardHand(newcomputerHand);
				cout << setw(15) << "This is the computer's new hand: " << computerHand << "\n";
				cout << "\n";

				//prints draw and discard pile to screen, calling deck function printCardHand
				string drawHand1 = deck->printCardHand(drawPile);
				string discardHand1 = deck->printCardHand(discardPile);

				cout << "New Draw Pile: " << drawHand1 << "\n";
				cout << "\n";

				cout << "New Discard Pile: " << discardHand1 << "\n";
				cout << "\n";

				
				cout << "Next Player: Human\n";
				cout << "Human Hand: " << humanHand << "\n";

				//creates variable save that is changed to 1 if user decides to save
				int save = 0;
				
				//uses human object to call startTurn in human class, stores return into vector newhumanHand
				//This function takes parameters of humans cards, the draw and discardpile, deck, wildCard for round, winningCondition, and save
				//All parameters are passed by reference except deck object, and wildCard
				vector<Card> newhumanHand = human1->startTurn(humanCards, drawPile, discardPile, deck, wildCard, winningCondition, save);
				humanCards = newhumanHand;

				//checks if user decides to save
				if (save == 1)
				{
					ofstream saveFile;
					string fileName;
					cout << "Please type the file name for your new save file. Make sure you end your file name with .txt\n";

					//Condition that takes in input validation for file name
					//initializes variable that is changed to 1 if the file is valid, if not, the while continues
					int correctFile = 0;
					while (correctFile == 0)
					{
						//takes in fileName, looks for a period.
						//If no period found, asks for new file name until a period is inside the input
						cin >> fileName;
						while (fileName.find(".") == string::npos) {

							cout << "You did not insert a valid file name. Please try again, with a .txt at the end of the file.\n";
							cin >> fileName;
						}

						//a vector string splitFile is created by seperating the input string by periods, and pushing back the splitted string
						stringstream ss(fileName);
						string finalfile;
						vector<string> splitFile;

						while (getline(ss, finalfile, '.'))
						{
							splitFile.push_back(finalfile);
						}

						//Condition that checks if the period is at the end of the input string. If not, this condition is true
						if (splitFile.size() > 1)
						{

							//Condition that makes sure the file ends in .txt
							if (splitFile[1] != "txt")
							{
								cout << "Please make sure you end your file name with a .txt.\n";
							}

							//Condition that is true if it does end in .txt
							//Sets while loop variable to false
							if (splitFile[1] == "txt")
							{
								correctFile = 1;
							}
							
							//Condition that checks if there is more than 1 period inside the input file
							//Sets while loop variable back to true
							if (splitFile.size() > 2)
							{
								cout << "Please make sure you end your file name with a .txt.\n";
								correctFile = 0;
							}
							
							//Condition that makes sure there are no / inside the string
							//Sets while loop variable back to true
							if (splitFile[0].find("/") != string::npos)
							{
								cout << "Please do not insert a / inside you text file.\n";
								correctFile = 0;
							}

						}
						//Condition that looks to see if the file was ended with a period.
						//Sets while loop variable back to true
						if (splitFile.size() == 1)
						{
							cout << "You did not end your file with a .txt. Please try again.\n";
							correctFile = 0;
						}

					}

					//Outputs the save file into a .txt file.
					//Passes all data that is needed for text file, including round, scores, and hands. Then exits program.
					saveFile.open(fileName);
					saveFile << "Round: " << round << endl;
					saveFile << endl;
					saveFile << "Computer: " << endl;
					saveFile << "   Score: " << computerTotalPoints << endl;
					saveFile << "   Hand: " << computerHand << endl;
					saveFile << endl;
					saveFile << "Human: " << endl;
					saveFile << "   Score: " << humanTotalPoints << endl;
					saveFile << "   Hand: " << humanHand << endl;
					saveFile << endl;
					string drawHand = deck->printCardHand(drawPile);
					saveFile << "Draw Pile: " << drawHand << endl;
					saveFile << endl;
					string discardHand = deck->printCardHand(discardPile);
					saveFile << "Discard Pile: " << discardHand << endl;
					saveFile << endl;
					if (winner == 2)
					{
						saveFile << "Next Player: Human" << endl;
					}
					saveFile.close();
					exit(0);

				}

				//Condition that looks for a change in winningCondition.
				//This can be changed from 0 to 1 through the human function startTurn that was called before. This is possible because it is passed through reference in function.
				if (winningCondition == 1)
				{
					cout << "Next Player: Computer\n";

					//computer object calls computer function startLastTurn, that sends parameters of change that are all passed by reference except wildCard.
					//This returned int will be added to computer's total points.
					int computerPoints = computer->startLastTurn(computerCards, drawPile, discardPile, wildCard, winningCondition);

					//setting winner variable to 1, which is passed back by reference to game class, allowing to human to start next round
					winner = 1;

					//adding computerPoints for round into its total points.
					computerTotalPoints = computerTotalPoints + computerPoints;
					cout << "COMPUTER TOTAL POINTS: " << computerTotalPoints << "\n";
					cout << "\nWe are moving to the next round!\n";
					
					//exiting function to be iterated again in game class.
					return 0;
				}

				//changes humanHand string to newhumanHand in order to print its new cards
				humanHand = deck->printCardHand(newhumanHand);

				//creates strings that hold the new draw and discard piles
				string drawHand2 = deck->printCardHand(drawPile);
				string discardHand2 = deck->printCardHand(discardPile);

				//printing out gameboard
				cout << "Round: " << round << endl;
				cout << "\n";
				cout << "\n";

				cout << "Computer\n";
				cout << setw(15) << "Score: " << computerTotalPoints << "\n";
				cout << setw(15) << "Hand: " << computerHand << "\n";
				cout << "\n";


				cout << "Human\n";
				cout << setw(15) << "Score: " << humanTotalPoints << "\n";
				cout << setw(15) << "Hand: " << humanHand << "\n";
				cout << "\n";


				cout << "Draw Pile: " << drawHand2 << "\n";
				cout << "\n";

				cout << "Discard Pile: " << discardHand2 << "\n";
				cout << "\n";



			}

			

		}




	}


	/****************************************************
	Function Name: startSavedGame
	Purpose: Resume a round of five crowns. Meant to be only called once after loading a game.
	Parameters: int round for round number, int winner for which player plays first, humanTotalPoints for humans points, computerTotalPoints for computer points, and player hands. Only winner and points are passed by reference.
	Return Value: int
	Algorithim:

		1. Condition if human or computer begins first.
			2. While condition that is false until a player goes out.
				3. Alternate through players turns, checking if either goes out. If they do, change winning condition to leave while loop and end function.
				4. Handle if the human decides to save, if so, put all data into text file.

	*****************************************************/
int Round::startSavedGame(vector<Card> playerHand1, vector<Card> playerHand2, vector<Card> drawDeck, vector<Card> discardDeck, int round, int &winner, int &humanTotalPoints, int &computerTotalPoints)
{
	
	
	Human *human1 = new Human();
	Computer *computer = new Computer();

	//cards to each it set to round+2, as well as the wildcard for the round
	int cardsToEach = round + 2;
	int wildCard = cardsToEach;

	//Deck object contains all cards from 2 decks 
	Deck *deck = new Deck();


	
	//Condition that checks if human goes first
	if (winner == 1)
	{
		//setting loaded hands to new card vectors
		vector<Card> humanCards = playerHand1;
		vector<Card> computerCards = playerHand2;
		vector<Card> drawPile = drawDeck;
		vector<Card> discardPile = discardDeck;

		string computerHand = deck->printCardHand(computerCards);
		string humanHand = deck->printCardHand(humanCards);
		string drawHand = deck->printCardHand(drawPile);
		string discardHand = deck->printCardHand(discardPile);


		//printing out gameboard
		cout << "Round: " << round << endl;
		cout << "\n";
		cout << "\n";

		cout << "Computer\n";
		cout << setw(15) << "Score: " << computerTotalPoints << "\n";
		cout << setw(15) << "Hand: " << computerHand << "\n";
		cout << "\n";


		cout << "Human\n";
		cout << setw(15) << "Score: " << humanTotalPoints << "\n";
		cout << setw(15) << "Hand: " << humanHand << "\n";
		cout << "\n";


		cout << "Draw Pile: " << drawHand << "\n";
		cout << "\n";

		cout << "Discard Pile: " << discardHand << "\n";
		cout << "\n";


		//initializes variable that determines whether or not a player has went out
		//While loop is true until this variable is changed
		int winningCondition = 0;
		while (winningCondition == 0)
		{			
			cout << "Next Player: Human\n";
			//creates variable save that is changed to 1 if user decides to save
			int save = 0;
			
			//uses human object to call startTurn in human class, stores return into vector newhumanHand
			//This function takes parameters of humans cards, the draw and discardpile, deck, wildCard for round, winningCondition, and save
			//All parameters are passed by reference except deck object, and wildCard
			vector<Card> newhumanHand = human1->startTurn(humanCards, drawPile, discardPile, deck, wildCard, winningCondition, save);

			//setting newhumanHand card vector to string humanHand by calling deck function
			humanHand = deck->printCardHand(newhumanHand);
			
			//Condition that handles if the user wants to save, this variable can be changed to 1 in the human function startTurn
			if (save == 1)
			{
				ofstream saveFile;
				string fileName;
				cout << "Please type the file name for your new save file. Make sure you end your file name with .txt\n";
				
				//Condition that takes in input validation for file name
				//initializes variable that is changed to 1 if the file is valid, if not, the while continues
				int correctFile = 0;
				while (correctFile == 0)
				{

					//takes in fileName, looks for a period.
					//If no period found, asks for new file name until a period is inside the input
					cin >> fileName;
					while (fileName.find(".") == string::npos) {

						cout << "You did not insert a valid file name. Please try again, with a .txt at the end of the file.\n";
						cin >> fileName;
					}
					stringstream ss(fileName);
					string finalfile;
					vector<string> splitFile;

					//a vector string splitFile is created by seperating the input string by periods, and pushing back the splitted string
					while (getline(ss, finalfile, '.'))
					{
							splitFile.push_back(finalfile);
					}

					//Condition that checks if the period is at the end of the input string. If not, this condition is true
					if (splitFile.size() > 1)
					{
						
						//Condition that makes sure the file ends in .txt
						if (splitFile[1] != "txt")
						{
							cout << "Please make sure you end your file name with a .txt.\n";
						}
						
						//Condition that is true if it does end in .txt
						//Sets while loop variable to false
						if (splitFile[1] == "txt")
						{
							correctFile = 1;
						}
						
						//Condition that checks if there is more than 1 period inside the input file
						//Sets while loop variable back to true
						if (splitFile.size() > 2)
						{
							cout << "Please make sure you end your file name with a .txt.\n";
							correctFile = 0;
						}
						
						//Condition that makes sure there are no / inside the string
						//Sets while loop variable back to true
						if (splitFile[0].find("/") != string::npos)
						{
							cout << "Please do not insert a / inside you text file.\n";
							correctFile = 0;
						}

					}
					//Condition that looks to see if the file was ended with a period.
					//Sets while loop variable back to true
					if (splitFile.size() == 1)
					{
						cout << "You did not end your file with a .txt. Please try again.\n";
						correctFile = 0;
					}

				}
				//Outputs the save file into a .txt file.
				//Passes all data that is needed for text file, including round, scores, and hands. Then exits program.
				saveFile.open(fileName);
				saveFile << "Round: " << round << endl;
				saveFile << endl;
				saveFile << "Computer: " << endl;
				saveFile << "   Score: " << computerTotalPoints << endl;
				saveFile << "   Hand: " << computerHand << endl;
				saveFile << endl;
				saveFile << "Human: " << endl;
				saveFile << "   Score: " << humanTotalPoints << endl;
				saveFile << "   Hand: " << humanHand << endl;
				saveFile << endl;
				string drawHand = deck->printCardHand(drawPile);
				saveFile << "Draw Pile: " << drawHand << endl;
				saveFile << endl;
				string discardHand = deck->printCardHand(discardPile);
				saveFile << "Discard Pile: " << discardHand << endl;
				saveFile << endl;
				if (winner == 1)
				{
					saveFile << "Next Player: Human" << endl;
				}
				saveFile.close();
				exit(0);

			}

			//humanCards variable is now changed to newhumanHand from the human function startTurn
			humanCards = newhumanHand;

			//Condition that looks for a change in winningCondition.
			//This can be changed from 0 to 1 through the human function startTurn that was called before. This is possible because it is passed through reference in function.
			if (winningCondition == 1)
			{
				cout << "Next Player: Computer\n";

				//computer object calls computer function startLastTurn, that sends parameters of change that are all passed by reference except wildCard.
				//This returned int will be added to computer's total points.
				int computerPoints = computer->startLastTurn(computerCards, drawPile, discardPile, wildCard, winningCondition);
				
				//setting winner variable to 1, which is passed back by reference to game class, allowing to human to start next round
				winner = 1;

				//adding round points to total computer points
				computerTotalPoints = computerTotalPoints + computerPoints;
				cout << "COMPUTER TOTAL POINTS: " << computerTotalPoints << "\n";
				cout << "\nWe are moving to the next round!\n";

				//exits the function by returning 0
				return 0;
			}

			cout << "Next Player: Computer\n";

			cout << "\nIt is now the computer's turn!\n";
			cout << "\n";

			//uses computer object to call startTurn in computer class, stores return into vector newcomputerHand
			//This function takes parameters of computer cards, the draw and discardpile, wildCard for round, and winningCondition
			//All parameters are passed by reference except for wildCard
			vector<Card> newcomputerHand = computer->startTurn(computerCards, drawPile, discardPile, wildCard, winningCondition);
			
			//computerCards variable is now changed to newcomputerHand for printout of cards
			computerCards = newcomputerHand;

			//Condition that looks for a change in winningCondition.
			//This can be changed from 0 to 1 through the computer function startTurn that was called before. This is possible because it is passed through reference in function.
			if (winningCondition == 1)
			{
				cout << "The computer has gone out with his hand! This is your last turn of this round.\n";

				//prints computers hand to screen through new varibale computerHand, calling deck function printCardHand
				string computerHand = deck->printCardHand(newcomputerHand);
				cout << setw(15) << "This is the computer's hand: " << computerHand << "\n";
				cout << "\n";
				
				//prints draw and discard pile to screen, calling deck function printCardHand
				string drawHand1 = deck->printCardHand(drawPile);
				string discardHand1 = deck->printCardHand(discardPile);

				cout << "Next Player: Human\n";
				cout << "New Draw Pile: " << drawHand1 << "\n";
				cout << "\n";

				cout << "New Discard Pile: " << discardHand1 << "\n";
				cout << "\n";

				cout << "Human Hand: " << humanHand << "\n";

				//human object calls human function startLastTurn, that sends parameters of change that are all passed by reference except wildCard and deck.
				//This returned int will be added to human's total points.
				int humanPoints = human1->startLastTurn(humanCards, drawPile, discardPile, deck, wildCard);
				humanTotalPoints = humanTotalPoints + humanPoints;
				cout << "HUMAN TOTAL POINTS: " << humanTotalPoints << "\n";

				//setting winner variable to 2, which is passed back by reference to game class, allowing the computer to start next round
				winner = 2;
				
				//exiting function to be iterated again in game class.
				return 0;
			}

			//prints computers hand to screen through new varibale computerHand, calling deck function printCardHand
			string computerHand = deck->printCardHand(newcomputerHand);
			cout << setw(15) << "This is the computer's new hand: " << computerHand << "\n";
			
			//prints draw and discard pile to screen, calling deck function printCardHand
			string drawHand = deck->printCardHand(drawPile);
			string discardHand = deck->printCardHand(discardPile);

			//printing out all data of game to gameboard, then going back to while for next turn, since no player has gone out
			cout << "Round: " << round << endl;
			cout << "\n";
			cout << "\n";

			cout << "Computer\n";
			cout << setw(15) << "Score: " << computerTotalPoints << "\n";
			cout << setw(15) << "Hand: " << computerHand << "\n";
			cout << "\n";


			cout << "Human\n";
			cout << setw(15) << "Score: " << humanTotalPoints << "\n";
			cout << setw(15) << "Hand: " << humanHand << "\n";
			cout << "\n";


			cout << "Draw Pile: " << drawHand << "\n";
			cout << "\n";

			cout << "Discard Pile: " << discardHand << "\n";
			cout << "\n";


		}



	}
	//Condition that begins round if the computer goes first
	if (winner == 2)
	{
		//setting loaded hands to new card vectors
		vector<Card> computerCards = playerHand2;
		vector<Card> humanCards = playerHand1;

		vector<Card> drawPile = drawDeck;
		vector<Card> discardPile = discardDeck;

		string computerHand = deck->printCardHand(computerCards);
		string humanHand = deck->printCardHand(humanCards);
		string drawHand = deck->printCardHand(drawPile);
		string discardHand = deck->printCardHand(discardPile);


		//printing out gameboard with data
		cout << "Round: " << round << endl;
		cout << "\n";
		cout << "\n";

		cout << "Computer\n";
		cout << setw(15) << "Score: " << computerTotalPoints << "\n";
		cout << setw(15) << "Hand: " << computerHand << "\n";
		cout << "\n";


		cout << "Human\n";
		cout << setw(15) << "Score: " << humanTotalPoints << "\n";
		cout << setw(15) << "Hand: " << humanHand << "\n";
		cout << "\n";


		cout << "Draw Pile: " << drawHand << "\n";
		cout << "\n";

		cout << "Discard Pile: " << discardHand << "\n";
		cout << "\n";

		//initializes variable that determines whether or not a player has went out
		//While loop is true until this variable is changed
		int winningCondition = 0;
		while (winningCondition == 0)
		{

			cout << "Next Player: Computer\n";
			cout << "It is now the computer's turn!\n";
			cout << "\n";

			//uses computer object to call startTurn in computer class, stores return into vector newcomputerHand
			//This function takes parameters of computer cards, the draw and discardpile, wildCard for round, and winningCondition
			//All parameters are passed by reference except for wildCard
			vector<Card> newcomputerHand = computer->startTurn(computerCards, drawPile, discardPile, wildCard, winningCondition);
			
			//computerCards variable is now changed to newcomputerHand for printout of cards
			computerCards = newcomputerHand;

			//Condition that looks for a change in winningCondition.
				//This can be changed from 0 to 1 through the computer function startTurn that was called before. This is possible because it is passed through reference in function.
			if (winningCondition == 1)
			{
				cout << "The computer has gone out with his hand! This is your last turn of this round.\n";

				//prints computers hand to screen through new varibale computerHand, calling deck function printCardHand
				string computerHand = deck->printCardHand(newcomputerHand);
				cout << setw(15) << "This is the computer's hand: " << computerHand << "\n";
				cout << "\n";
				
				//prints draw and discard pile to screen, calling deck function printCardHand
				string drawHand1 = deck->printCardHand(drawPile);
				string discardHand1 = deck->printCardHand(discardPile);

				cout << "Next Player: Human\n";

				cout << "New Draw Pile: " << drawHand1 << "\n";
				cout << "\n";

				cout << "New Discard Pile: " << discardHand1 << "\n";
				cout << "\n";

				cout << "Human Hand: " << humanHand << "\n";
				
				//human object calls human function startLastTurn, that sends parameters of change that are all passed by reference except wildCard and deck.
				//This returned int will be added to human's total points.
				int humanPoints = human1->startLastTurn(humanCards, drawPile, discardPile, deck, wildCard);
				humanTotalPoints = humanTotalPoints + humanPoints;
				cout << "HUMAN TOTAL POINTS: " << humanTotalPoints << "\n";

				//setting winner variable to 2, which is passed back by reference to game class, allowing the computer to start next round
				winner = 2;
				
				//exiting function to be iterated again in game class.
				return 0;
			}
			//prints computers hand to screen through new varibale computerHand, calling deck function printCardHand
			string computerHand = deck->printCardHand(newcomputerHand);
			cout << setw(15) << "This is the computer's new hand: " << computerHand << "\n";
			cout << "\n";

			//prints draw and discard pile to screen, calling deck function printCardHand
			string drawHand1 = deck->printCardHand(drawPile);
			string discardHand1 = deck->printCardHand(discardPile);

			cout << "New Draw Pile: " << drawHand1 << "\n";
			cout << "\n";

			cout << "New Discard Pile: " << discardHand1 << "\n";
			cout << "\n";
			
			//creates variable save that is changed to 1 if user decides to save
			int save = 0;
			
			cout << "Next Player: Human\n";
			
			cout << "\n";
			cout << "Human Hand: " << humanHand << "\n";
			
			//uses human object to call startTurn in human class, stores return into vector newhumanHand
			//This function takes parameters of humans cards, the draw and discardpile, deck, wildCard for round, winningCondition, and save
			//All parameters are passed by reference except deck object, and wildCard
			vector<Card> newhumanHand = human1->startTurn(humanCards, drawPile, discardPile, deck, wildCard, winningCondition, save);
			humanCards = newhumanHand;

			

					

			//checks if user decides to save
			if (save == 1)
			{
				ofstream saveFile;
				string fileName;
				cout << "Please type the file name for your new save file. Make sure you end your file name with .txt\n";

				//Condition that takes in input validation for file name
				//initializes variable that is changed to 1 if the file is valid, if not, the while continues
				int correctFile = 0;
				while (correctFile == 0)
				{
					//takes in fileName, looks for a period.
					//If no period found, asks for new file name until a period is inside the input
					cin >> fileName;
					while (fileName.find(".") == string::npos) {

						cout << "You did not insert a valid file name. Please try again, with a .txt at the end of the file.\n";
						cin >> fileName;
					}
					stringstream ss(fileName);
					string finalfile;
					vector<string> splitFile;
							
					//a vector string splitFile is created by seperating the input string by periods, and pushing back the splitted string
					while (getline(ss, finalfile, '.'))
					{
						splitFile.push_back(finalfile);
					}
					
					//Condition that checks if the period is at the end of the input string. If not, this condition is true
					if (splitFile.size() > 1)
					{

						//Condition that makes sure the file ends in .txt
						if (splitFile[1] != "txt")
						{
							cout << "Please make sure you end your file name with a .txt.\n";
						}
						
						//Condition that is true if it does end in .txt
						//Sets while loop variable to false
						if (splitFile[1] == "txt")
						{
							correctFile = 1;
						}
						
						//Condition that checks if there is more than 1 period inside the input file
						//Sets while loop variable back to true
						if (splitFile.size() > 2)
						{
							cout << "Please make sure you end your file name with a .txt.\n";
							correctFile = 0;
						}
						
						//Condition that makes sure there are no / inside the string
						//Sets while loop variable back to true
						if (splitFile[0].find("/") != string::npos)
						{
							cout << "Please do not insert a / inside you text file.\n";
							correctFile = 0;
						}
						
					}
					
					//Condition that looks to see if the file was ended with a period.
					//Sets while loop variable back to true
					if (splitFile.size() == 1)
					{
						cout << "You did not end your file with a .txt. Please try again.\n";
						correctFile = 0;
					}
				}
				//Outputs the save file into a .txt file.
				//Passes all data that is needed for text file, including round, scores, and hands. Then exits program.
				saveFile.open(fileName);
				saveFile << "Round: " << round << endl;
				saveFile << endl;
				saveFile << "Computer: " << endl;
				saveFile << "   Score: " << computerTotalPoints << endl;
				saveFile << "   Hand: " << computerHand << endl;
				saveFile << endl;
				saveFile << "Human: " << endl;
				saveFile << "   Score: " << humanTotalPoints << endl;
				saveFile << "   Hand: " << humanHand << endl;
				saveFile << endl;
				string drawHand = deck->printCardHand(drawPile);
				saveFile << "Draw Pile: " << drawHand << endl;
				saveFile << endl;
				string discardHand = deck->printCardHand(discardPile);
				saveFile << "Discard Pile: " << discardHand << endl;
				saveFile << endl;
				if (winner == 2)
				{
					saveFile << "Next Player: Human" << endl;
				}
				saveFile.close();
				exit(0);

			}

			//Condition that looks for a change in winningCondition.
			//This can be changed from 0 to 1 through the human function startTurn that was called before. This is possible because it is passed through reference in function.
			if (winningCondition == 1)
			{
				cout << "Next Player: Computer\n";
				
				//computer object calls computer function startLastTurn, that sends parameters of change that are all passed by reference except wildCard.
				//This returned int will be added to computer's total points.
				int computerPoints = computer->startLastTurn(computerCards, drawPile, discardPile, wildCard, winningCondition);
				//setting winner variable to 1, which is passed back by reference to game class, allowing to human to start next round
				winner = 1;
				
				//adding computerPoints for round into its total points.
				computerTotalPoints = computerTotalPoints + computerPoints;
				cout << "COMPUTER TOTAL POINTS: " << computerTotalPoints << "\n";
				cout << "\nWe are moving to the next round!\n";
				
				//exiting function to be iterated again in game class.
				return 0;
			}

			//changes humanHand string to newhumanHand in order to print its new cards
			humanHand = deck->printCardHand(newhumanHand);

			//creates strings that hold the new draw and discard piles
			string drawHand2 = deck->printCardHand(drawPile);
			string discardHand2 = deck->printCardHand(discardPile);

			//printing out gameboard
			cout << "Round: " << round << endl;
			cout << "\n";
			cout << "\n";

			cout << "Computer\n";
			cout << setw(15) << "Score: " << computerTotalPoints << "\n";
			cout << setw(15) << "Hand: " << computerHand << "\n";
			cout << "\n";


			cout << "Human\n";
			cout << setw(15) << "Score: " << humanTotalPoints << "\n";
			cout << setw(15) << "Hand: " << humanHand << "\n";
			cout << "\n";


			cout << "Draw Pile: " << drawHand2 << "\n";
			cout << "\n";

			cout << "Discard Pile: " << discardHand2 << "\n";
			cout << "\n";



		}



	}




}


Round::~Round()
{
}
