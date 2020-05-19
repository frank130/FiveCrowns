#include "pch.h"
#include "Game.h"
#include "Round.h"
#include <iostream>
#include <stdlib.h>
#include <string>
#include <fstream>
#include <vector>
#include "Card.h"
#include "Deck.h"

using namespace std;
Game::Game()
{
}
/****************************************************
Function Name: startGame
Purpose: Brings up main menu for game. Provides options to either start game, load game, or exit. Calls round class to go through rounds.
Parameters: none
Return Value: none
Algorithim: 
	1. Take input of user to either start, load, or exit.
	2. If starting new game, creates and initializes game points variables and winner variable. 
		3. Create iteration that calls startRound function 11 times.
		3. Compare human and computer points to determine winner.
	4. If loading game, takes in text file, validates it, and creates variables for round class, such as computerHand and humanHand.
		5. Conditions that check for all needed variables from text file to resume game.
	6. Stores those variables and calls function startSavedGame from round class.
	7. Then iterates through function startRound until 11 rounds have passed.
	8. Compare human and computer points to determine winner.

*****************************************************/
void Game::startGame()
{
	Round *begin = new Round();

	cout << "Welcome to Five Crowns! Would you like to start a new game?\n";
	cout << "Enter 1 for new game.\n";
	cout << "Enter 2 to load game.\n";
	cout << "Enter 3 to quit.\n";


	string answer;
	cin >> answer;
	
	

	//Input validation for user, must enter 1 2 or 3
	while (answer != "1" & answer != "2" & answer != "3")
	{
		cout << "Please enter either 1, 2, or 3.\n";
		cin >> answer;
	}
	//Condition for new game, creates computer and human point varibales, and winner variable for round function
	if (answer.compare("1") == 0)
	{
		cout << "Starting new game!\n";
		cout << "\n";

		int computerTotalPoints = 0;
		int humanTotalPoints = 0;
		int winner = 0;

		//iteration that loops through 11 function calls of startRound from round class
		for (int i = 1; i < 12; i++)
		{
			begin->startRound1(i, winner, humanTotalPoints, computerTotalPoints);

		}
		
		cout << "\nTHE GAME IS OVER! HUMAN TOTAL POINTS: " << humanTotalPoints << "\n";
		cout << "\nTHE GAME IS OVER! COMPUTER TOTAL POINTS: " << computerTotalPoints << "\n";

		//Comparing final human and computer points to determine winner.
		if (humanTotalPoints > computerTotalPoints)
		{
			cout << "The computer has less points than you. The computer won!\n";
			exit(0);
		}
		if (humanTotalPoints < computerTotalPoints)
		{
			cout << "The computer has more points than you. You won!\n";
			exit(0);
		}
		if (humanTotalPoints == computerTotalPoints)
		{
			cout << "Both players have equal points. It's a tie!\n";
			exit(0);
		}
	}

	//Condition for load game. Creates file stream and string to read each line.
	if (answer.compare("2") == 0)
	{
		string currentLine;
		ifstream infile;

		string fileName;
		cout << "Please type the file name of the file you'd like to open. Make sure you end the file name with .txt\n";

		//Variable that is created to handle errors for inputted text file. If this variable turns to 1 inside while loop, a valid text file was inputted.
		int correctFile = 0;
		while (correctFile == 0)
		{

			//Checks for a period inside the input file. If there is none, it asks the user to try again.
			cin >> fileName;
			while (fileName.find(".") == string::npos) {

				cout << "You did not insert a valid file name. Please try again, with a .txt at the end of the file.\n";
				cin >> fileName;
			}

			//Creates string vector that seperates user input file by each period.
			stringstream ss(fileName);
			string finalfile;
			vector<string> splitFile;

			while (getline(ss, finalfile, '.'))
			{
				splitFile.push_back(finalfile);
			}

			//Condition to make sure there is only 1 period inside text file input.
			if (splitFile.size() > 1)
			{

				//condition that handles an invalid extension.
				if (splitFile[1] != "txt")
				{
					cout << "Please make sure you end your file name with a .txt.\n";
				}
				//condition that handles an invalid extension. Changes correctFile variable to leave while loop.
				if (splitFile[1] == "txt")
				{
					correctFile = 1;
				}
				//condition that handles an input string with more than 1 period. Changes correctFile back to while condition.
				if (splitFile.size() > 2)
				{
					cout << "Please make sure you end your file name with a .txt.\n";
					correctFile = 0;
				}
				//condition that handles an input string with a forward slash. Changes correctFile back to while condition.
				if (splitFile[0].find("/") != string::npos)
				{
					cout << "Please do not insert a / inside you text file.\n";
					correctFile = 0;
				}
				//condition that checks for the file inside the directory. If not found, changes correctFile back to while condition.
				infile.open(fileName);
				if (!infile)
				{
					cout << "The requested save file was not find. Try again.\n";
					correctFile = 0;
				}
			}
			//Condition that checks if the input file ends with just a period and no txt extension.
			if (splitFile.size() == 1)
			{
				cout << "You did not end your file with a .txt. Please try again.\n";
				correctFile = 0;
			}
		}

		
		cout << "Opening saved file!\n";

		//Creation of variables to store text file input. Inluding round number, next player, points, card hands, draw pile, discard pile, and deck pile.
		int round = 0;
		int winner = 0;
		int computerPoints = 0;
		int humanPoints = 0;
		vector<Card> humanHand;
		vector<Card> computerHand;
		vector<Card> drawPile;
		vector<Card> discardPile;
		vector<Card> deck;

		
		//While loop that iterates through each line of file until it reaches end.
		while (!infile.eof())
		{
			//String of currentLine now holds text line
			getline(infile, currentLine);

			//Condition that makes sure line isn't blank.
			if (currentLine != "")
			{

				//Splits line by spaces and stores into vector string.
			vector<string> splittedLine;
				for (stringstream sst(currentLine); getline(sst, currentLine, ' '); )
				{
					splittedLine.push_back(currentLine);
				}
				
				//Sets round variable to round number from text file if found.
				if (splittedLine[0] == "Round:")
				{
					round = stoi(splittedLine[1]);
					
				}

				//Condition that looks for Computer's data
				if (splittedLine[0] == "Computer:")
				{

					//Seperates next line by spaces into vector. Find the computer score and sets that to computerPoints variable.
					string Score;
					getline(infile, Score);
					vector<string> splittedScore;
					for (stringstream sst(Score); getline(sst, Score, ' '); )
					{
						splittedScore.push_back(Score);
					}

					
					computerPoints = stoi(splittedScore[4]);

					//Seperates next line by spaces into vector. 
					string hand;
					getline(infile, hand);
					vector<string> splitComputerHand;
					for (stringstream sst(hand); getline(sst, hand, ' '); )
					{
						splitComputerHand.push_back(hand);
					}
					
					//The vector splitComputerHand holds cards as string. This iteration changes each card into a new Card object
					//Also pushes all cards in computer hand into the deck vector as well.
					for (int i = 4; i < splitComputerHand.size();i++)
					{
						string s1 = splitComputerHand[i];
						string s2 = s1.substr(0, 1); // Card Value
						string s3 = s1.substr(1, 1); // Card Suite
						
						computerHand.push_back(*new Card(s2, s3, 0));
						deck.push_back(*new Card(s2, s3, 0));
						

					}

				}
				//Condition that looks for Human's data
				if (splittedLine[0] == "Human:")
				{

					//Seperates next line by spaces into vector. Find the human score and sets that to humanPoints variable.
					string Score;
					getline(infile, Score);
					vector<string> splittedScore;
					for (stringstream sst(Score); getline(sst, Score, ' '); )
					{
						splittedScore.push_back(Score);
					}

					humanPoints = stoi(splittedScore[4]);

					//Seperates next line by spaces into vector.
					string hand;
					getline(infile, hand);	
					vector<string> splitHumanHand;
					for (stringstream sst(hand); getline(sst, hand, ' '); )
					{
						splitHumanHand.push_back(hand);
					}

					//The vector splitComputerHand holds cards as string. This iteration changes each card into a new Card object
					//It does this by seperating the string in half, s2 holding the cards value and s3 holding its suite.
					
					for (int i = 4; i < splitHumanHand.size();i++)
					{
						string s1 = splitHumanHand[i];
						string s2 = s1.substr(0, 1); // Card Value
						string s3 = s1.substr(1, 1); // Card Suite

						
						
						//Iteration that goes through the deck vector that holds all cards. Checks for duplicate cards, since there are two decks.
						//Since there are two decks, and integer property at end of Card determines which deck.
						//If the card in human hand is found in deck vector, the human vector pushes back card with integer value 1, as it must be in the second deck.
						int found = 0;
						for (unsigned int j = 0; j < deck.size(); j++)
						{
							
							if ((s2 == deck[j].getVal()) && (s3 == deck[j].getSuite()) && deck[j].getDeck() == 0)
							{
								found = 1;
							}

						}
						//Condtions that handle which deck the new card is in.
						if (found == 1)
						{
							humanHand.push_back(*new Card(s2, s3, 1));
							deck.push_back(*new Card(s2, s3, 1));
						}
						if (found == 0)
						{
							humanHand.push_back(*new Card(s2, s3, 0));
							deck.push_back(*new Card(s2, s3, 0));
						}

					}

				}
				//Condition that looks for Draw Pile's data
				if (splittedLine[0] == "Draw")
				{
					//Iteration that goes through the deck vector that holds all cards. Checks for duplicate cards, since there are two decks.
					//Since there are two decks, and integer property at end of Card determines which deck.
					//If the card in draw pile is found in deck vector, the draw pile vector pushes back card with integer value 1, as it must be in the second deck.
					for (int i = 2; i < splittedLine.size();i++)
					{
						if (splittedLine[i] != "")
						{
							string s1 = splittedLine[i];
							string s2 = s1.substr(0, 1); // Card Value
							string s3 = s1.substr(1, 1); // Card Suite


							int found = 0;
							for (unsigned int j = 0; j < deck.size(); j++)
							{

								if ((s2 == deck[j].getVal()) && (s3 == deck[j].getSuite()) && deck[j].getDeck() == 0)
								{
									found = 1;
								}

							}
							//Condtions that handle which deck the new card is in.
							if (found == 1)
							{
								drawPile.push_back(*new Card(s2, s3, 1));
								deck.push_back(*new Card(s2, s3, 1));
							}
							if (found == 0)
							{
								drawPile.push_back(*new Card(s2, s3, 0));
								deck.push_back(*new Card(s2, s3, 0));
							}
						}
					}
				}
				//Condition that looks for Discard Pile's data
				if (splittedLine[0] == "Discard")
				{
					//Iteration that goes through the deck vector that holds all cards. Checks for duplicate cards, since there are two decks.
					//Since there are two decks, and integer property at end of Card determines which deck.
					//If the card in discard pile is found in deck vector, the discard pile vector pushes back card with integer value 1, as it must be in the second deck.
					
					for (int i = 2; i < splittedLine.size();i++)
					{
						if (splittedLine[i] != "")
						{
							string s1 = splittedLine[i];
							string s2 = s1.substr(0, 1); // Card Value
							string s3 = s1.substr(1, 1); // Card Suite


							int found = 0;
							for (unsigned int j = 0; j < deck.size(); j++)
							{

								if ((s2 == deck[j].getVal()) && (s3 == deck[j].getSuite()) && deck[j].getDeck() == 0)
								{
									found = 1;
								}

							}
							//Condtions that handle which deck the new card is in.
							if (found == 1)
							{
								discardPile.push_back(*new Card(s2, s3, 1));
								deck.push_back(*new Card(s2, s3, 1));
							}
							if (found == 0)
							{
								discardPile.push_back(*new Card(s2, s3, 0));
								deck.push_back(*new Card(s2, s3, 0));
							}
						}
					}
				}
				//Condtion that looks to see which player play's next.
				//If human plays next, winner variable set to 1.
				//If computer plays next, winner variable set to 2.
				if (splittedLine[0] == "Next")
				{
					if (splittedLine[2] == "Human")
					{
						winner = 1;
					}
					if (splittedLine[2] == "Computer")
					{
						winner = 2;
					}
				}

			}
			

		

		}
		
		infile.close();
		
		//Calls function startSavedGame in round class.
		//Takes parameters for players' points, next player, cards in players' hands, draw and discard piles.
		begin->startSavedGame(humanHand, computerHand, drawPile, discardPile, round, winner, humanPoints, computerPoints);
		for (int i = round + 1; i < 12; i++)
		{
			begin->startRound1(i, winner, humanPoints, computerPoints);
		}


		cout << "\nTHE GAME IS OVER! HUMAN TOTAL POINTS: " << humanPoints << "\n";
		cout << "\nTHE GAME IS OVER! COMPUTER TOTAL POINTS: " << computerPoints << "\n";

		//Comparing final human and computer points to determine winner.
		if (humanPoints > computerPoints)
		{
			cout << "The computer has less points than you. The computer won!\n";
			exit(0);
		}
		if (humanPoints < computerPoints)
		{
			cout << "The computer has more points than you. You won!\n";
			exit(0);
		}
		if (humanPoints == computerPoints)
		{
			cout << "Both players have equal points. It's a tie!\n";
			exit(0);
		}
	}

	//Condition that looks to see if user would like to exit by entering 3.
	if (answer.compare("3") == 0)
	{
		cout << "Exiting Five Crowns.\n";
		exit(0);
			
	}
		
	
}

Game::~Game()
{
}
