



/* *********************************************************************
Predicate Name: beginGame
Purpose: To start five crowns main screen
Parameters: none
Return Value: none

Algorithm:
            1) Display Main Screen, take in input from user for game.

********************************************************************* */
beginGame :- set_prolog_stack(global, limit(100 000 000 000)), writeln('Welcome to Five Crowns. Please enter 1 for new game, 2 for load game, 3 for quit game.'), read(X), start(X).

/* *********************************************************************
Predicate Name: startGameInvalid
Purpose: Handles input error for main screen.
Parameters: none
Return Value: none

Algorithm:
            1) Read in another input for main screen.

********************************************************************* */
startGameInvalid :- writeln('Please enter 1 for new game, 2 for load game, 3 for quit game.'), read(X), start(X).


%Predicate to get the first of a list, used in future computations
getFirst([H|T], H, T).

%Predicate to start selected game, new, load, or quit
start(X) :- integer(X), X<4, X>0, game(X).

%Predicate that handles main screen input error.
start(X) :- writeln("Input Error."),
		startGameInvalid.

%Predicate that reads in a loaded file name.
game(2) :- writeln("Please enter a file name to load from."),
			read(FileName),

			loadGame(FileName).


/* *********************************************************************
Predicate Name: loadGame
Purpose: Begins a loaded game from text file.
Parameters: File name
Return Value: none

Algorithm:
            1) Open file, parse file, and start game.

********************************************************************* */
loadGame(FileName) :- 
		open(FileName,read,Str),
         readWord(Str,Line1),
        
         readWord(Str,Line2),
         read_string(Str, ",", "  ", EndR, Line3),
         
         readWord(Str, GarbageLine1),
         readWord(Str,Line4),
         readWord(Str,Line5),
        
        read_string(Str, ",", "   ", EndCP, Line6),
         readWord(Str, GarbageLineCP),
         readWord(Str,Line7),
         
         readWord(Str,Line8),

         read_string(Str, "]", "   [", End, Line9),

         readWord(Str, GarbageLine),
         readWord(Str,Line10),
         readWord(Str,Line11),
         
         read_string(Str, ",", "   ", EndHP, Line12),

		readWord(Str, GarbageLineHP),
         readWord(Str,Line13),
        
         readWord(Str,Line14),
         read_string(Str, "]", "   [", End2, Line15),
         
         readWord(Str, GarbageLine2),
         readWord(Str,Line16),
         readWord(Str,Line17),
        
         read_string(Str, "]", "   [", End3, Line18),
         readWord(Str, GarbageLine3),
         readWord(Str,Line19),
         
         readWord(Str,Line20),

         read_string(Str, "]", "   [", End4, Line21),
         readWord(Str, GarbageLine4),
         readWord(Str,Line22),
        
         readWord(Str,Line23),
         read_string(Str, "\n", "   ", EndPlayer, Line24),
         
         readWord(Str, GarbageLinePlayer),
         readWord(Str,Line25),


         close(Str),
         
         

         

         %Converts all information to strings or numbers
         atom_string(RoundNumberAtom, Line3),
         atom_string(ComputerPointsAtom, Line6),
         atom_string(HumanPointsAtom, Line12),
         atom_string(NextPlayer, Line24),

         atom_number(RoundNumberAtom, RoundNumber),
         atom_number(ComputerPointsAtom, ComputerPoints),
         atom_number(HumanPointsAtom, HumanPoints),


         
         %Converts all card strings to a list of atoms
         split_string(Line9, ",", " ", ComputerHand),
         convertStringListToAtoms(ComputerHand, [], FinalComputerHand),

         split_string(Line15, ",", " ", HumanHand),
         convertStringListToAtoms(HumanHand, [], FinalHumanHand),

         split_string(Line18, ",", " ", DrawHand),
         convertStringListToAtoms(DrawHand, [], FinalDrawHand),

         split_string(Line21, ",", " ", DiscardHand),
         convertStringListToAtoms(DiscardHand, [], FinalDiscardHand),
         


         %Call saved game iterate function with all info from saved game
		iterateRoundsSavedGame([RoundNumber, HumanPoints, ComputerPoints, NextPlayer], FinalComputerHand, FinalHumanHand, FinalDrawHand, FinalDiscardHand).


%Converts a String from a saved text file into a list of atoms
convertStringListToAtoms(StringList, AtomList, FinalAtomList) :- length(StringList, 0),
										FinalAtomList = AtomList.
	
 convertStringListToAtoms(StringList, AtomList, FinalAtomList) :- getFirst(StringList, FirstAtom, RestAtoms),
 									atom_string(ConvertedAtom, FirstAtom),
 									append(AtomList, [ConvertedAtom], NextAtomList),
 									convertStringListToAtoms(RestAtoms, NextAtomList, FinalAtomList).      






%Predicate to get characters from a text file and convert them to atoms
readWord(Stream,Word):-
 get_code(Stream,Char),

 checkCharAndReadRest(Char,Chars,Stream),
 atom_codes(Word,Chars).

checkCharAndReadRest(10, [], _):- !.

%Predicates that convert each string in text file to atoms
checkCharAndReadRest(-1, [], _):- !.
checkCharAndReadRest(Char,[Char|Chars],S):-
 get_code(S,NextChar),
 checkCharAndReadRest(NextChar,Chars,S).


%Predicate that exits game if user inputted 3 at main screen
game(3) :- halt.			


/* *********************************************************************
Predicate Name: game
Purpose: Starts a new game
Parameters: integer 

Algorithm:
            1) Generate random number 1 or 0.
            2) Read in input from user for coin toss.
            3)Call predicate compareCoinToss to start game.

********************************************************************* */
game(1) :- random_between(0,1, R),
			
			writeln('Please call the toss! Enter 1 for heads, 0 for tails.'),
			read(X),
			coinToss(X, CoinFlip),
			
			writeln('This is your toss'),
			writeln(CoinFlip),
			writeln('This is the coin flip.'),
			writeln(R),
			compareCoinToss(CoinFlip, R).



%Predicate to check if user inputted 1 or 0 for toss, makes X = the coinflip if it is valid.
coinToss(X, CoinFlip) :- integer(X), X>=0, X<2,
					CoinFlip = X.
coinToss(X, CoinFlip) :- writeln("Input Error."),
				writeln('Please enter 1 for heads, 0 for tails.'), read(Y), coinToss(Y, CoinFlip).
		



/* *********************************************************************
Predicate Name: compareCoinToss
Purpose: Initializes game and starts it, human won toss.
Parameters: Coin toss and user input 

Algorithm:
            1) Initialize game points and round, call iterateRounds with human going first

********************************************************************* */
compareCoinToss(CoinFlip, R) :- CoinFlip=:=R,
				Turn = 'true',
				RoundNumber = 1,
				HumanPoints = 0,
				ComputerPoints = 0,
				iterateRounds([RoundNumber, HumanPoints, ComputerPoints, Turn]).

/* *********************************************************************
Predicate Name: compareCoinToss
Purpose: Initializes game and starts it, human lost toss.
Parameters: Coin toss and user input 

Algorithm:
            1) Initialize game points and round, call iterateRounds with computer going first

********************************************************************* */
compareCoinToss(CoinFlip, R) :- CoinFlip=\=R,
				Turn = 'false',
				RoundNumber = 1,
				HumanPoints = 0,
				ComputerPoints = 0,
				iterateRounds([RoundNumber, HumanPoints, ComputerPoints, Turn]).
				

/* *********************************************************************
Predicate Name: finalGameDecision
Purpose: Compare human and computer points
Parameters: Human points integer and computer points integer

Algorithm:
            1) Display winner of game and points.

********************************************************************* */
finalGameDecision(HumanPoints, ComputerPoints) :- HumanPoints < ComputerPoints,
							writeln("***********************"),
							writeln("GAME OVER"),
							writeln("***********************"),
							writeln(''),
							writeln("FINAL COMPUTER POINTS: "),
							writeln(ComputerPoints),
							writeln(''),
							writeln("FINAL HUMAN POINTS: "),
							writeln(HumanPoints),
							writeln(''),
							writeln("You have less points than the computer."),
							writeln("You won.").

finalGameDecision(HumanPoints, ComputerPoints) :- HumanPoints > ComputerPoints,
							writeln("***********************"),
							writeln("GAME OVER"),
							writeln("***********************"),
							writeln(''),
							writeln("FINAL COMPUTER POINTS: "),
							writeln(ComputerPoints),
							writeln(''),
							writeln("FINAL HUMAN POINTS: "),
							writeln(HumanPoints),
							writeln(''),
							writeln("You have more points than the computer."),
							writeln("You lost!").



/* *********************************************************************
Predicate Name: iterateRounds
Purpose: Call final game decision if round is 12.
Parameters: Round number, points for players, and who goes next

Algorithm:
            1) Call finalGameDecision

********************************************************************* */
iterateRounds([RoundNumber, HumanPoints, ComputerPoints, Turn]) :- RoundNumber=:=12,
										finalGameDecision(HumanPoints, ComputerPoints).




/* *********************************************************************
Predicate Name: iterateRoundsSavedGame
Purpose: Start a saved game with loaded info.
Parameters: Round number, points for players, who goes next, players' hands and piles

Algorithm:
            1) Call practiceRoundsHumanFirst or ComputerFirst depending on who goes next.
            2) Add that returned value to previous points and call iterateRounds for next round.

********************************************************************* */
iterateRoundsSavedGame([RoundNumber, HumanPoints, ComputerPoints, Turn], ComputerHand, HumanHand, DrawHand, DiscardHand) :-
								
								Turn == 'human',

								plus(2, RoundNumber, Wild),

								%Calls rounds for human first
								practiceRoundHumanFirst(Wild, HumanPoints, ComputerPoints, HumanHand, ComputerHand, DrawHand, DiscardHand, 
									0, 0, RoundHumanPoints, RoundComputerPoints, RoundWinner, FinalRoundHumanPoints, FinalRoundComputerPoints, FinalRoundWhoWon),

								%Adds points from round to previous points and call next round
								plus(RoundNumber, 1, NextRoundNumber),
								plus(HumanPoints, FinalRoundHumanPoints, NextHumanPoints),
								plus(ComputerPoints, FinalRoundComputerPoints, NextComputerPoints),


								iterateRounds([NextRoundNumber, NextHumanPoints, NextComputerPoints, FinalRoundWhoWon]).	

%Similar to above predicate, but with computer playing first.
iterateRoundsSavedGame([RoundNumber, HumanPoints, ComputerPoints, Turn], ComputerHand, HumanHand, DrawHand, DiscardHand) :-
								
								Turn == 'computer',

								plus(2, RoundNumber, Wild),
								practiceRoundComputerFirst(Wild, HumanPoints, ComputerPoints, HumanHand, ComputerHand, DrawHand, DiscardHand, 
									0, 0, RoundHumanPoints, RoundComputerPoints, RoundWinner, FinalRoundHumanPoints, FinalRoundComputerPoints, FinalRoundWhoWon),

								plus(RoundNumber, 1, NextRoundNumber),
								plus(HumanPoints, FinalRoundHumanPoints, NextHumanPoints),
								plus(ComputerPoints, FinalRoundComputerPoints, NextComputerPoints),

								iterateRounds([NextRoundNumber, NextHumanPoints, NextComputerPoints, FinalRoundWhoWon]).


/* *********************************************************************
Predicate Name: iterateRounds
Purpose: Calls for new round if it is not a saved game
Parameters: Round number, points for players, and who goes next

Algorithm:
            1) Call beginRound to deal cards and start round.
            2)Add points from round to previous points.
            3)Call next round.

********************************************************************* */
iterateRounds([RoundNumber, HumanPoints, ComputerPoints, Turn]) :- 
				
				beginRound([RoundNumber, HumanPoints, ComputerPoints, Turn], AddHumanPoints, AddComputerPoints, WhoWon),	


				plus(RoundNumber, 1, NextRoundNumber),
				plus(HumanPoints, AddHumanPoints, NextHumanPoints),
				plus(ComputerPoints, AddComputerPoints, NextComputerPoints),
			
				iterateRounds([NextRoundNumber, NextHumanPoints, NextComputerPoints, WhoWon]).




/* *********************************************************************
Predicate Name: beginRound
Purpose: Deal cards to each player, call predicate to begin round
Parameters: Round number, points for players, who goes next, and AddHumanPoints for returned points, AddComputerPoints for returned points, and whowon for who won round

Algorithm:
            1) Create a deck of cards, shuffle it, and deal all hands and piles.
            2) Call round predicate to begin round.

********************************************************************* */
beginRound([RoundNumber, HumanPoints, ComputerPoints, Turn], AddHumanPoints, AddComputerPoints, WhoWon) :- Turn == 'true',

									deck(UnShuffledDeck),
									shuffle(UnShuffledDeck, Deck),


									plus(2, RoundNumber, Wild),

									
									dealCards(Wild, Deck, HumanCards, FinalHumanCards, ReturnedDeck),

									dealCards(Wild, ReturnedDeck, ComputerCards, FinalComputerCards, NextReturnedDeck),
									dealCards(1, NextReturnedDeck, DiscardPile, FinalDiscardPile, FinalDrawPile),
			
					


									
									




									%CALL practiceRoundsHumanFirst, it will eventually return true, will make AddHumanPoints a number, will make AddComputerPoints a number, and WhoWon
									practiceRoundHumanFirst(Wild, HumanPoints, ComputerPoints, FinalHumanCards, FinalComputerCards, FinalDrawPile, FinalDiscardPile, 
										0, 0, RoundHumanPoints, RoundComputerPoints, RoundWinner, 
										FinalRoundHumanPoints, FinalRoundComputerPoints, FinalRoundWhoWon),
									WhoWon = FinalRoundWhoWon,
									AddHumanPoints = FinalRoundHumanPoints,
									AddComputerPoints = FinalRoundComputerPoints.







%Similar to above predicate, but with computer going first
beginRound([RoundNumber, HumanPoints, ComputerPoints, Turn], AddHumanPoints, AddComputerPoints, WhoWon) :- Turn == 'false',
									deck(UnShuffledDeck),
									shuffle(UnShuffledDeck, Deck),


									plus(2, RoundNumber, Wild),

									
									dealCards(Wild, Deck, HumanCards, FinalHumanCards, ReturnedDeck),

									dealCards(Wild, ReturnedDeck, ComputerCards, FinalComputerCards, NextReturnedDeck),
									dealCards(1, NextReturnedDeck, DiscardPile, FinalDiscardPile, FinalDrawPile),
			
					


									
									




									%CALL practiceRoundComputerFirst, it will eventually return true, will make AddHumanPoints a number, will make AddComputerPoints a number, and WhoWon
									practiceRoundComputerFirst(Wild, HumanPoints, ComputerPoints, FinalHumanCards, FinalComputerCards, FinalDrawPile, FinalDiscardPile, 
										0, 0, RoundHumanPoints, RoundComputerPoints, RoundWinner, 
										FinalRoundHumanPoints, FinalRoundComputerPoints, FinalRoundWhoWon),
									WhoWon = FinalRoundWhoWon,
									AddHumanPoints = FinalRoundHumanPoints,
									AddComputerPoints = FinalRoundComputerPoints.


/* *********************************************************************
Predicate Name: practiceRoundComputerFirst
Purpose: Round where computer intially went first, but human won, so computer plays one more turn.
Parameters: All info for game, including all hands, points, and round numbers.
			Return values are new human and computer points, and who won the round.

Algorithm:
            1) Call computerPlay for its last turn
            2) Set points from round to variable.
            3)Returns to have points added.

********************************************************************* */
practiceRoundComputerFirst(Wild, HumanPoints, ComputerPoints, HumanHand, ComputerHand, DrawHand, DiscardHand, 
	HumanWinningCondition, ComputerWinningCondition, RoundHumanPoints, RoundComputerPoints, RoundWinner, 
										FinalRoundHumanPoints, FinalRoundComputerPoints, FinalRoundWhoWon) :- 
										%Computer Plays Another
										HumanWinningCondition =:= 1,


										computerPlay(Wild, ComputerHand, DrawHand, DiscardHand, NewComputerHand, NewDrawHand, NewDiscardHand, 
								FinalPointsToAdd, HumanWinningCondition, ComputerWinningCondition),

										

										FinalRoundHumanPoints = 0,
										FinalRoundComputerPoints = FinalPointsToAdd,
										
										FinalRoundWhoWon = 'true'.



/* *********************************************************************
Predicate Name: practiceRoundComputerFirst
Purpose: Round where computer intially went first, and computer won round, so add points.
Parameters: All info for game, including all hands, points, and round numbers.
			Return values are new human and computer points, and who won the round.

Algorithm:
            1) Set points from round to variable.
            2)Returns to have points added.

********************************************************************* */
practiceRoundComputerFirst(Wild, HumanPoints, ComputerPoints, HumanHand, ComputerHand, DrawHand, DiscardHand, 
	HumanWinningCondition, ComputerWinningCondition, RoundHumanPoints, RoundComputerPoints, RoundWinner, 
										FinalRoundHumanPoints, FinalRoundComputerPoints, FinalRoundWhoWon) :- 
										
										ComputerWinningCondition =:= 1,
										FinalRoundHumanPoints = RoundHumanPoints,
										FinalRoundComputerPoints = 0,
										
										FinalRoundWhoWon = 'false'.




/* *********************************************************************
Predicate Name: practiceRoundComputerFirst
Purpose: Predicate that iterates through a round until a player has went out, then goes to base condition.
Parameters: All info for game, including all hands, points, and round numbers.
			Return values are new human and computer points, and who won the round.

Algorithm:
            1) Call computerPlay, and then humanPlay.
            2) Variables NewComputerWinningCondition and NewHumanWinningCondition are set to 1 if either or them go out. If not, set to 0.
            3) Calls itself again and continues if no one went out.

********************************************************************* */
practiceRoundComputerFirst(Wild, HumanPoints, ComputerPoints, HumanHand, ComputerHand, DrawHand, DiscardHand, 
	HumanWinningCondition, ComputerWinningCondition, RoundHumanPoints, RoundComputerPoints, RoundWinner, 
										FinalRoundHumanPoints, FinalRoundComputerPoints, FinalRoundWhoWon) :- 

							%Call HumanPlay
							%Call ComputerPlay

							plus(-2, Wild, RoundNumber),
							printBoard(RoundNumber, ComputerPoints, ComputerHand, HumanPoints, HumanHand, DrawHand, DiscardHand),


							
							
							computerPlay(Wild, ComputerHand, DrawHand, DiscardHand, NewComputerHand, NewDrawHand, NewDiscardHand, 
								RoundComputerPoints, HumanWinningCondition, NewComputerWinningCondition),

							humanPlay(Wild, HumanHand, NewComputerHand, ComputerPoints, HumanPoints, NewDrawHand, NewDiscardHand, NewHumanHand, FinalDrawHand, FinalDiscardHand, 
								RoundHumanPoints, NewHumanWinningCondition, NewComputerWinningCondition),


							 
								
		
							
							
							practiceRoundComputerFirst(Wild, HumanPoints, ComputerPoints, NewHumanHand, NewComputerHand,
							 FinalDrawHand, FinalDiscardHand, NewHumanWinningCondition, NewComputerWinningCondition, RoundHumanPoints, RoundComputerPoints, RoundWinner, 
										FinalRoundHumanPoints, FinalRoundComputerPoints, FinalRoundWhoWon).









/* *********************************************************************
Predicate Name: practiceRoundHumanFirst
Purpose: Round where human intially went first, and human won round, so set points.
Parameters: All info for game, including all hands, points, and round numbers.
			Return values are new human and computer points, and who won the round.

Algorithm:
            1) Set final points to points from round and return to base predicate to be added.

********************************************************************* */
practiceRoundHumanFirst(Wild, HumanPoints, ComputerPoints, HumanHand, ComputerHand, DrawHand, DiscardHand, 
	HumanWinningCondition, ComputerWinningCondition, RoundHumanPoints, RoundComputerPoints, RoundWinner, 
										FinalRoundHumanPoints, FinalRoundComputerPoints, FinalRoundWhoWon) :- 
										
										HumanWinningCondition =:= 1,
										FinalRoundHumanPoints = 0,
										FinalRoundComputerPoints = RoundComputerPoints,
										
										FinalRoundWhoWon = 'true'.





/* *********************************************************************
Predicate Name: practiceRoundHumanFirst
Purpose: Round where human intially went first, but computer won, so human plays one more turn.
Parameters: All info for game, including all hands, points, and round numbers.
			Return values are new human and computer points, and who won the round.

Algorithm:
			1) Call humanPlay to get points.
            2) Set final points to points from round and return to base predicate to be added.

********************************************************************* */
practiceRoundHumanFirst(Wild, HumanPoints, ComputerPoints, HumanHand, ComputerHand, DrawHand, DiscardHand, 
	HumanWinningCondition, ComputerWinningCondition, RoundHumanPoints, RoundComputerPoints, RoundWinner, 
										FinalRoundHumanPoints, FinalRoundComputerPoints, FinalRoundWhoWon) :- 
										%HUMAN PLAYS ANOTHER TURN
										ComputerWinningCondition =:= 1,


							humanPlay(Wild, HumanHand, ComputerHand, ComputerPoints, HumanPoints, DrawHand, DiscardHand, NewHumanHand, NewDrawHand, NewDiscardHand, 
								FinalPointsToAdd, HumanWinningCondition, ComputerWinningCondition),

										

										FinalRoundHumanPoints = FinalPointsToAdd,
										FinalRoundComputerPoints = 0,

										
										FinalRoundWhoWon = 'false'.





/* *********************************************************************
Predicate Name: practiceRoundHumanFirst
Purpose: Predicate that iterates through a human goes first round if no player has gone out yet.
Parameters: All info for game, including all hands, points, and round numbers.
			Return values are new human and computer points, and who won the round.

Algorithm:
            1) Call humanPlay, and then computerPlay.
            2) NewhumanWinningCondition and NewComputerWinningCondition are 0 if no player goes out, and 1 if they do.
            3) Iterate predicate again if no one went out.
********************************************************************* */
practiceRoundHumanFirst(Wild, HumanPoints, ComputerPoints, HumanHand, ComputerHand, DrawHand, DiscardHand, HumanWinningCondition, ComputerWinningCondition, RoundHumanPoints, RoundComputerPoints, RoundWinner, 
										FinalRoundHumanPoints, FinalRoundComputerPoints, FinalRoundWhoWon) :- 

							%Call HumanPlay
							%Call ComputerPlay

							plus(-2, Wild, RoundNumber),
							printBoard(RoundNumber, ComputerPoints, ComputerHand, HumanPoints, HumanHand, DrawHand, DiscardHand),




						

							

							humanPlay(Wild, HumanHand, ComputerHand, ComputerPoints, HumanPoints, DrawHand, DiscardHand, NewHumanHand, NewDrawHand, NewDiscardHand, 
								RoundHumanPoints, NewHumanWinningCondition, ComputerWinningCondition),

							computerPlay(Wild, ComputerHand, NewDrawHand, NewDiscardHand, NewComputerHand, FinalDrawHand, FinalDiscardHand, 
								RoundComputerPoints, NewHumanWinningCondition, NewComputerWinningCondition),
							 

								
							
							
							
							practiceRoundHumanFirst(Wild, HumanPoints, ComputerPoints, NewHumanHand, NewComputerHand,
							 FinalDrawHand, FinalDiscardHand, NewHumanWinningCondition, NewComputerWinningCondition, RoundHumanPoints, RoundComputerPoints, RoundWinner, 
										FinalRoundHumanPoints, FinalRoundComputerPoints, FinalRoundWhoWon).


%Predicate that removes a list of cards from a hand
removeListFromHand(Hand, List, FinalHand) :- length(List, 0),
					FinalHand = Hand.

removeListFromHand(Hand, List, FinalHand) :- getFirst(List, FirstList, RestList),
						remove(FirstList, Hand, RemovedHand),
						removeListFromHand(RemovedHand, RestList, FinalHand).




/* *********************************************************************
Predicate Name: humanPlay
Purpose: Predicate where human plays and computer has already went out
Parameters: All info for game, including all hands, points, and round numbers.
			Return values are new human and computer points, and who won the round.

Algorithm:
            1) Call FirstHumanDecision for picking
            2) Call secondHumanDecision for discarding
            3) Call tryToPutDownCards to get final points to return.

********************************************************************* */
humanPlay(Wild, HumanHand, ComputerHand, RoundComputerPoints, HumanPoints, DrawHand, DiscardHand, NewHumanHand, NewDrawHand, NewDiscardHand, FinalPointsToAdd, HumanWinningCondition, ComputerWinningCondition) :-
						%PutDownCards  
							ComputerWinningCondition =:= 1,
							writeln("The computer went out! This is your last turn before the round is over."),
							writeln("This is your hand!"),
							writeln(HumanHand),
							writeln('Its your turn!'),
							writeln('1. Save Game.'),
							writeln('2. Make a Move.'),
							writeln('3. Ask for Help.'),
							writeln('4. Quit Game.'),
							writeln(''),
							read(FirstDecision),
							firstHumanDecisionValidate(FirstDecision, Wild, HumanHand, ComputerHand, RoundComputerPoints, HumanPoints, DrawHand, DiscardHand, FirstHumanHand, FinalDrawHand, FirstDiscardHand, WinningCondition),

							
							writeln("This is your new hand!"),
							writeln(FirstHumanHand),
							writeln(''),
							writeln('1. Discard a Card.'),
							writeln('2. Ask for Help'),
							writeln(''),						
							read(SecondDecision),
							secondHumanDecision(SecondDecision, Wild, FirstHumanHand, FirstDiscardHand, FinalHumanHand, FinalDiscardHand),

							writeln("This is your final hand!"),
							writeln(FinalHumanHand),
							writeln(''),
							writeln('1. Try to Go Out.'),
							writeln('2. Ask for Help in Building Runs.'),
							writeln(''),
							

							tryToPutDownCards(Wild, FinalHumanHand, PointsToAdd),

						

							HumanWinningCondition = 0,
							FinalPointsToAdd = PointsToAdd,
							NewHumanHand = FinalHumanHand,
							NewDrawHand = FinalDrawHand,
							NewDiscardHand = FinalDiscardHand.
					

/* *********************************************************************
Predicate Name: humanPlay
Purpose: Predicate where human plays and computer has not went out already
Parameters: All info for game, including all hands, points, and round numbers.
			Return values are new human and computer points, and who won the round.

Algorithm:
            1) Call FirstHumanDecision for picking
            2) Call secondHumanDecision for discarding
            3) Call thirdHumanDecision to see if player wants to go out.
            4) Return value if human went out.

********************************************************************* */
humanPlay(Wild, HumanHand, ComputerHand, RoundComputerPoints, HumanPoints, DrawHand, DiscardHand, NewHumanHand, NewDrawHand, NewDiscardHand, RoundHumanPoints, HumanWinningCondition, ComputerWinningCondition) :- 
							%NORMAL HUMAN TURN, TRY TO GO OUT

							writeln("This is your hand!"),
							writeln(HumanHand),


							writeln('Its your turn!'),
							writeln('1. Save Game.'),
							writeln('2. Make a Move.'),
							writeln('3. Ask for Help.'),
							writeln('4. Quit Game.'),
							writeln(''),
							read(FirstDecision),
							firstHumanDecisionValidate(FirstDecision, Wild, HumanHand, ComputerHand, RoundComputerPoints, HumanPoints, DrawHand, DiscardHand, FirstHumanHand, FinalDrawHand, FirstDiscardHand, WinningCondition),

							
							writeln("This is your new hand!"),
							writeln(FirstHumanHand),
							writeln(''),
							writeln('1. Discard a Card.'),
							writeln('2. Ask for Help'),
							writeln(''),						
							read(SecondDecision),
							secondHumanDecision(SecondDecision, Wild, FirstHumanHand, FirstDiscardHand, FinalHumanHand, FinalDiscardHand),

							writeln("This is your final hand!"),
							writeln(FinalHumanHand),
							writeln(''),
							writeln('1. Try to Go Out.'),
							writeln('2. Ask for Help in Building Runs.'),
							writeln(''),
							
							read(ThirdDecision),
							thirdHumanDecision(ThirdDecision, Wild, RoundHumanPoints, FinalHumanHand, BestHumanHand, HumanWinningCondition),


							NewHumanHand = FinalHumanHand,
							NewDrawHand = FinalDrawHand,
							NewDiscardHand = FinalDiscardHand.
					



/* *********************************************************************
Predicate Name: firstHumanDecisionValidate
Purpose: Saves game and exits.
Parameters: All info for game, including all hands, points, and round numbers.
			Return values are new human and computer points, and who won the round.

Algorithm:
            1) Call FirstHumanDecision for picking
            2) Call secondHumanDecision for discarding
            3) Call tryToPutDownCards to get final points to return.

********************************************************************* */
firstHumanDecisionValidate(Decision, Wild, HumanHand, ComputerHand, RoundComputerPoints, HumanPoints, DrawHand, DiscardHand, NewHumanHand, 
	NewDrawHand, NewDiscardHand, RoundHumanPoints) :- integer(Decision), Decision =:= 1,
								writeln("Enter name of save file."),
								read(X),
								open(X,write,Stream),
        						writeln(Stream, "["),
        						writeln(Stream, "  Round:"),
        						plus(-2, Wild, RoundNumber),
        						write(Stream, "  "),
        						write(Stream, RoundNumber), 
        						writeln(Stream, ","),
        						writeln(Stream, " "),

        						writeln(Stream, "   Computer Score:"),
        						write(Stream, "   "),
        						write(Stream, RoundComputerPoints), 
        						writeln(Stream, ","),
        						writeln(Stream, " "),

        						writeln(Stream, "   Computer Hand:"),
        						write(Stream, "   "),
        						write(Stream, ComputerHand), 
        						writeln(Stream, ","),
        						writeln(Stream, " "),

        						writeln(Stream, "   Human Score:"),
        						write(Stream, "   "),
        						write(Stream, HumanPoints), 
        						writeln(Stream, ","),
        						writeln(Stream, " "),

								writeln(Stream, "   Human Hand:"),
        						write(Stream, "   "),
        						write(Stream, HumanHand), 
        						writeln(Stream, ","),
        						writeln(Stream, " "),

        						writeln(Stream, "   Draw Pile:"),
        						write(Stream, "   "),
        						write(Stream, DrawHand), 
        						writeln(Stream, ","),
        						writeln(Stream, " "),


        						writeln(Stream, "   Discard Hand:"),
        						write(Stream, "   "),
        						write(Stream, DiscardHand), 
        						writeln(Stream, ","),
        						writeln(Stream, " "),

        						writeln(Stream, "   Next Player:"),
        						write(Stream, "   "),
        						writeln(Stream, "human"), 
        						
        						writeln(Stream, "]"),

         						close(Stream),


         						halt.
	

/* *********************************************************************
Predicate Name: firstHumanDecisionValidate
Purpose: Human Decided to make a move, call makeHumanMoveDecision with new read value.
Parameters: All info for game, including all hands, points, and round numbers.
			

Algorithm:
            1) Display options, and call makeHumanMoveDecision to pick from draw or discard

********************************************************************* */
firstHumanDecisionValidate(Decision, Wild, HumanHand, ComputerHand, RoundComputerPoints, HumanPoints, DrawHand, DiscardHand, NewHumanHand, 
	NewDrawHand, NewDiscardHand, RoundHumanPoints) :- integer(Decision), Decision =:= 2,
											writeln('1. Pick from Draw Pile.'),
											writeln('2. Pick from Discard Pile.'),
											writeln(''),
														
											read(X),
											makeHumanMoveDecision(X, Wild, HumanHand, DrawHand, DiscardHand, NewHumanHand, NewDrawHand, NewDiscardHand, RoundHumanPoints).


/* *********************************************************************
Predicate Name: firstHumanDecisionValidate
Purpose: Human Asked for help picking
Parameters: All info for game, including all hands, points, and round numbers.
			

Algorithm:
            1) Find best combination of books/runs in current hand.
            2) Find best combination of books/runs if human picks from discard
            3) Call askForHelpPicking predicate.
            4) Predicate returns back to first decision.

********************************************************************* */
firstHumanDecisionValidate(Decision, Wild, HumanHand, ComputerHand, RoundComputerPoints, HumanPoints, DrawHand, DiscardHand, NewHumanHand, 
	NewDrawHand, NewDiscardHand, RoundHumanPoints) :- integer(Decision), Decision =:= 3,


											%Convert hand to numbers with suite, sort the hand, and make books and runs by calling predicates
											convertToNumbers(Wild, HumanHand, [], FinalHand),
							
												sort(0, @=<, FinalHand,  Sorted),
							
												sortHand(Sorted, Sorted, [], FinalSortedHand),
						
												checkBooksFinal(Wild, FinalSortedHand, [], FinalBooks),

												checkRunsFinal(Wild, FinalSortedHand, [], FinalRuns),
									

												append(FinalRuns, FinalBooks, BooksAndRuns),



												DefaultMinimum = [['4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s'],[]],


												%Call goOutTest1 to get best combo of books and runs

												goOutTest1(Wild, FinalSortedHand, BooksAndRuns, DefaultMinimum, FinalMinimum),


												%Adds the discard card to human hand, and calls goOutTest1 with that new hand
												getFirst(DiscardHand, AddedCardFromDiscard, RestDiscard),

												
												append([AddedCardFromDiscard], HumanHand, HandWithDiscard),
											
												convertToNumbers(Wild, HandWithDiscard, [], FinalHandWithDiscard),
							
												sort(0, @=<, FinalHandWithDiscard,  SortedWithDiscard),
							
												sortHand(SortedWithDiscard, SortedWithDiscard, [], FinalSortedHandWithDiscard),
						

												checkBooksFinal(Wild, FinalSortedHandWithDiscard, [], FinalBooksWithDiscard),

												checkRunsFinal(Wild, FinalSortedHandWithDiscard, [], FinalRunsWithDiscard),
									
												append(FinalRunsWithDiscard, FinalBooksWithDiscard, BooksAndRunsWithDiscard),




								NewDefaultMinimum = [['4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s'],[]],


												goOutTest1(Wild, FinalSortedHandWithDiscard, BooksAndRunsWithDiscard, NewDefaultMinimum, FinalMinimumWithDiscard),

												convertToCards(Wild, FinalMinimum, [], BestBooksAndRunsCurrent),
												convertToCards(Wild, FinalMinimumWithDiscard, [], BestBooksAndRunsDiscard),

												%Call askForHelpPicking by compaing the best books and runs from the two combinations
												askForHelpPicking(BestBooksAndRunsCurrent, BestBooksAndRunsDiscard),

												writeln('1. Save Game.'),
												writeln('2. Make a Move.'),
												writeln('3. Ask for Help.'),
												writeln('4. Quit Game.'),
												writeln(''),

												read(Y),
												firstHumanDecisionValidate(Y, Wild, HumanHand, ComputerHand, RoundComputerPoints, HumanPoints, DrawHand, DiscardHand, NewHumanHand, 
												NewDrawHand, NewDiscardHand, RoundHumanPoints).





%Human decided to exit game
firstHumanDecisionValidate(Decision, Wild, HumanHand, ComputerHand, RoundComputerPoints, HumanPoints, DrawHand, DiscardHand, NewHumanHand, 
	NewDrawHand, NewDiscardHand, RoundHumanPoints) :- integer(Decision), Decision =:= 4,
												halt.												 

%Human inputted invalid for first decision, call again with new input.
firstHumanDecisionValidate(Decision, Wild, HumanHand, ComputerHand, RoundComputerPoints, HumanPoints, DrawHand, DiscardHand, NewHumanHand, 
	NewDrawHand, NewDiscardHand, RoundHumanPoints) :- writeln('Input error. Please enter 1 to save, 2 to make move, 3 for help, or 4 to quit.'),
													 read(X),
													 firstHumanDecisionValidate(X, Wild, HumanHand, ComputerHand, RoundComputerPoints, HumanPoints, DrawHand, DiscardHand, NewHumanHand, 
												NewDrawHand, NewDiscardHand, RoundHumanPoints).

%Predicate that is called if no books and runs were found when askForHelpPicking
askForHelpPicking(CurrentHandBest, DiscardHandBest) :- CurrentHandBest = DiscardHandBest,
											writeln("The computer recommends you to pick from the draw pile because the discard pile card did not create any books/runs.").


/* *********************************************************************
Predicate Name: askForHelpPicking
Purpose: Compare best books and runs from current hand and discard hand.
Parameters: All info for game, including all hands, points, and round numbers.
			

Algorithm:
            1) Adding the discard created more books/runs, recommend to pick from discard.

********************************************************************* */
askForHelpPicking(CurrentHandBest, DiscardHandBest) :- getFirst(CurrentHandBest, LeftOverHandCurrent, BooksRunsCurrentHand),
											length(LeftOverHandCurrent, SizeOfCurrent),

											getFirst(DiscardHandBest,LeftOverHandDiscard, BooksRunsDiscardHand),
											length(LeftOverHandDiscard, SizeOfDiscard),

											SizeOfCurrent >= SizeOfDiscard,


											writeln("The computer recommends you to pick from the discard pile to build ... "),
											writeln(BooksRunsDiscardHand).


/* *********************************************************************
Predicate Name: askForHelpPicking
Purpose: Compare best books and runs from current hand and discard hand.
Parameters: All info for game, including all hands, points, and round numbers.
			

Algorithm:
            1) Adding the discard didn't create more books/runs, recommend to pick from draw.

********************************************************************* */
askForHelpPicking(CurrentHandBest, DiscardHandBest) :- getFirst(CurrentHandBest, LeftOverHandCurrent, BooksRunsCurrentHand),
											length(LeftOverHandCurrent, SizeOfCurrent),

											getFirst(DiscardHandBest, LeftOverHandDiscard, BooksRunsDiscardHand),
											length(LeftOverHandDiscard, SizeOfDiscard),

											SizeOfCurrent < SizeOfDiscard,

											writeln("The computer recommends you to pick from the draw pile to build ... "),
											writeln(BooksRunsCurrentHand).







/* *********************************************************************
Predicate Name: makeHumanMoveDecision
Purpose: Pick from draw pile.
Parameters: All info for game, including all hands, points, and round numbers.
			

Algorithm:
            1) Call pickFromDrawPile predicate to get card and new hand/pile.

********************************************************************* */
makeHumanMoveDecision(MoveDecision, Wild, HumanHand, DrawHand, DiscardHand, NewHumanHand, 
	NewDrawHand, NewDiscardHand, RoundHumanPoints) :- integer(MoveDecision), MoveDecision =:= 1,
									pickFromDrawPile(HumanHand, DrawHand, NewHumanHand, NewDrawHand),
									NewDiscardHand = DiscardHand.


/* *********************************************************************
Predicate Name: makeHumanMoveDecision
Purpose: Pick from discard pile.
Parameters: All info for game, including all hands, points, and round numbers.
			

Algorithm:
            1) Call pickFromDiscardPile predicate to get card and new hand/pile.

********************************************************************* */
makeHumanMoveDecision(MoveDecision, Wild, HumanHand, DrawHand, DiscardHand, NewHumanHand, 
	NewDrawHand, NewDiscardHand, RoundHumanPoints) :- integer(MoveDecision), MoveDecision =:= 2,
									pickFromDiscardPile(HumanHand, DiscardHand, NewHumanHand, NewDiscardHand),
									NewDrawHand = DrawHand.


%Input was invalid for picking, get new input
makeHumanMoveDecision(MoveDecision, Wild, HumanHand, DrawHand, DiscardHand, NewHumanHand, 
	NewDrawHand, NewDiscardHand, RoundHumanPoints) :- writeln('Input error. Please enter 1 to pick from draw pile, or 2 to pick from discard.'),
													read(X),
													makeHumanMoveDecision(X, Wild, HumanHand, DrawHand, DiscardHand, NewHumanHand, 
													NewDrawHand, NewDiscardHand, RoundHumanPoints).



/* *********************************************************************
Predicate Name: secondHumanDecision
Purpose: Ask user for card to discard
Parameters: All info for game, including all hands, points, and round numbers.
			

Algorithm:
            1) Get card input and discard it.

********************************************************************* */
secondHumanDecision(SecondDecision, Wild, FirstHumanHand, FirstDiscardHand, FinalHumanHand, FinalDiscardHand) :- integer(SecondDecision), SecondDecision =:= 1,
														writeln('Enter the card you would like to discard.'),
														read(X),
														discardCard(Wild, X, FirstHumanHand, FirstDiscardHand, FinalHumanHand, FinalDiscardHand).


/* *********************************************************************
Predicate Name: secondHumanDecision
Purpose: Gets help for discarding
Parameters: All info for game, including all hands, points, and round numbers.
			

Algorithm:
            1) Gets best possible books/runs from hand and recommend to discard last card from hand.

********************************************************************* */
secondHumanDecision(SecondDecision, Wild, FirstHumanHand, FirstDiscardHand, FinalHumanHand, FinalDiscardHand) :- integer(SecondDecision), SecondDecision =:= 2,

												convertToNumbers(Wild, FirstHumanHand, [], FinalHand),
							
												sort(0, @=<, FinalHand,  Sorted),
							
												sortHand(Sorted, Sorted, [], FinalSortedHand),
						
												checkBooksFinal(Wild, FinalSortedHand, [], FinalBooks),

												checkRunsFinal(Wild, FinalSortedHand, [], FinalRuns),
									
							


												append(FinalRuns, FinalBooks, BooksAndRuns),



												DefaultMinimum = [['4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s'],[]],

												goOutTest1(Wild, FinalSortedHand, BooksAndRuns, DefaultMinimum, FinalMinimum),

	
												convertToCards(Wild, FinalMinimum, [], BestBooksAndRuns),

											askForHelpDiscarding(FirstHumanHand, BestBooksAndRuns),

												writeln(""),
												writeln('1. Discard a card.'),
												writeln('2. Ask For Help.'),
												writeln(""),
												read(X),
												secondHumanDecision(X, Wild, FirstHumanHand, FirstDiscardHand, FinalHumanHand, FinalDiscardHand).


/* *********************************************************************
Predicate Name: askForHelpDiscarding
Purpose: Recommednds to discard card that is not inside books/runs
Parameters: All info for game, including all hands, points, and round numbers.
			

Algorithm:
            1) Recommend highest card that does not add to books/runs.

********************************************************************* */
askForHelpDiscarding(Hand, BestBooksAndRuns) :- getFirst(BestBooksAndRuns, LeftOverHand, FinalBooksAndRuns),
										length(LeftOverHand, LeftLength),
										LeftLength > 13,
										lastd(Hand, LastOfHand),
										writeln("The computer recommends you to discard ... "),
										writeln(LastOfHand),
										writeln(" ... because it could not find any books/runs in your hand.").

askForHelpDiscarding(Hand, BestBooksAndRuns) :- getFirst(BestBooksAndRuns, LeftOverHand, FinalBooksAndRuns),
										length(LeftOverHand, LeftLength),
										LeftLength < 13,
										getFirst(LeftOverHand, RestOfHand, NullValue),

										lastd([RestOfHand], LastOfRestHand),
										writeln("The computer recommends you to discard ... "),
										writeln(LastOfRestHand),
										writeln(" ... because it wants you to build ... "),
										
										writeln(FinalBooksAndRuns).
														

												

%Checks if the input for discarding decision is invalid
secondHumanDecision(SecondDecision, Wild, FirstHumanHand, FirstDiscardHand, FinalHumanHand, FinalDiscardHand) :- writeln('Input error. Please enter 1 to discard a card, or 2 for help.'),
																				read(X),
																				secondHumanDecision(X, Wild, FirstHumanHand, FirstDiscardHand, FinalHumanHand, FinalDiscardHand).
												


/* *********************************************************************
Predicate Name: thirdHumanDecision
Purpose: Human Decided to try to go out. If he can, then set humanWinningCondition to 1, if not, set to 0.
Parameters: All info for game, including all hands, points, and round numbers.
			

Algorithm:
            1) Gets best possible books/runs and see if there are no cards leftover.
            2) Set HumanWInningCondition.

********************************************************************* */
thirdHumanDecision(ThirdDecision, Wild, RoundHumanPoints, HumanHand, BestHumanHand, HumanWinningCondition) :- integer(ThirdDecision), ThirdDecision =:= 1,
					
												convertToNumbers(Wild, HumanHand, [], FinalHand),
							
												sort(0, @=<, FinalHand,  Sorted),
							
												sortHand(Sorted, Sorted, [], FinalSortedHand),
						
												checkBooksFinal(Wild, FinalSortedHand, [], FinalBooks),

												checkRunsFinal(Wild, FinalSortedHand, [], FinalRuns),
									
							


												append(FinalRuns, FinalBooks, BooksAndRuns),

												DefaultMinimum = [['4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s'],[]],

												goOutTest1(Wild, FinalSortedHand, BooksAndRuns, DefaultMinimum, FinalMinimum),


												convertToCards(Wild, FinalMinimum, [], BestBooksAndRuns),

												humanTryToGoOut(BestBooksAndRuns, WinQuestion),
							


													HumanWinningCondition = WinQuestion.
													
													
%Same as above predicate, but is instead when the user asking for help building
thirdHumanDecision(ThirdDecision, Wild, RoundHumanPoints, HumanHand, BestHumanHand, HumanWinningCondition) :- integer(ThirdDecision), ThirdDecision =:= 2,

												convertToNumbers(Wild, HumanHand, [], FinalHand),
							
												sort(0, @=<, FinalHand,  Sorted),
							
												sortHand(Sorted, Sorted, [], FinalSortedHand),
						
												checkBooksFinal(Wild, FinalSortedHand, [], FinalBooks),

												checkRunsFinal(Wild, FinalSortedHand, [], FinalRuns),
									
							


												append(FinalRuns, FinalBooks, BooksAndRuns),

												DefaultMinimum = [['4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s'],[]],

												

												goOutTest1(Wild, FinalSortedHand, BooksAndRuns, DefaultMinimum, FinalMinimum),

												convertToCards(Wild, FinalMinimum, [], BestBooksAndRuns),

												askForHelpBuilding(BestBooksAndRuns),
												

											
												writeln(''),

												writeln(''),
												writeln('1. Try to Go Out.'),
												writeln('2. Ask for Help in Building Runs.'),
												writeln(''),

												read(Y),
												thirdHumanDecision(Y, Wild, RoundHumanPoints, HumanHand, BestHumanHand, HumanWinningCondition).
												
													%ASK HELP BUILDING .
	
	/* *********************************************************************
Predicate Name: askForHelpBuidling
Purpose: Gets best books/runs from user hand.
Parameters: All info for game, including all hands, points, and round numbers.
			

Algorithm:
            1) Displays best books/runs from hand, if none found, recommends none.

********************************************************************* */												
askForHelpBuilding(BestBooksAndRuns) :-  getFirst(BestBooksAndRuns, LeftOverHand, FinalBooksAndRuns),

										getFirst(FinalBooksAndRuns, FirstOf, AllBooksAndRuns),
										length(FirstOf, ItsLength),
										
										ItsLength > 1,
										writeln("The computer recommends you to build ... "),
										writeln(FinalBooksAndRuns).

askForHelpBuilding(BestBooksAndRuns) :-  getFirst(BestBooksAndRuns, LeftOverHand, FinalBooksAndRuns),
										
										getFirst(FinalBooksAndRuns, FirstOf, AllBooksAndRuns),
										length(FirstOf, ItsLength),
										

										ItsLength < 2,
										writeln("The computer couldn't find any books/runs in your hand.").




%Handles input error for third decision
thirdHumanDecision(ThirdDecision, Wild, RoundHumanPoints, HumanHand, BestHumanHand, HumanWinningCondition) :- writeln('Input error. Please enter 1 to try to go out, or 2 for help building books/runs.'),
													 
													read(X),

													thirdHumanDecision(X,  Wild, HumanHand, BestHumanHand, HumanWinningCondition).


%Human was able to go out, display books/runs and set winningcondition to 1
humanTryToGoOut(BestBooksAndRuns, WinQuestion) :- getFirst(BestBooksAndRuns, LeftOverHand, BooksAndRuns),
										length(LeftOverHand, 0),
										writeln('You can go out! These are your cards!'),
										writeln(BooksAndRuns),
										WinQuestion = 1.

%Human was not able to go out, set winningcondition to 0.
humanTryToGoOut(BestBooksAndRuns, WinQuestion) :- getFirst(BestBooksAndRuns, LeftOverHand, BooksAndRuns),
										length(LeftOverHand, X),
										X > 0,
										writeln('You cannot go out with your cards ... '),
										
										WinQuestion = 0.





/* *********************************************************************
Predicate Name: computerPlay
Purpose: Goes through computer last play, human already went out, try to put down cards
Parameters: All info for game, including all hands, points, and round numbers.
			

Algorithm:
            1) Compare best books/runs for current hand and discard hand, pick from discard if the card creates better books/runs.
            2) Discard any card that does not add to books/runs.
            3) Try to put down Cards before next round.

********************************************************************* */
computerPlay(Wild, ComputerHand, DrawHand, DiscardHand, NewComputerHand, NewDrawHand, NewDiscardHand, FinalPointsToAdd, HumanWinningCondition, ComputerWinningCondition) :- 
							%PUT DOWN CARDS

							HumanWinningCondition =:= 1,

							writeln(''),
							writeln("Its the computers last turn before the round is over!"),
							convertToNumbers(Wild, ComputerHand, [], FinalHand),
							
												sort(0, @=<, FinalHand,  Sorted),
							
												sortHand(Sorted, Sorted, [], FinalSortedHand),
						
												checkBooksFinal(Wild, FinalSortedHand, [], FinalBooks),

												checkRunsFinal(Wild, FinalSortedHand, [], FinalRuns),
									
							


												append(FinalRuns, FinalBooks, BooksAndRuns),



												DefaultMinimum = [['4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s'],[]],

												goOutTest1(Wild, FinalSortedHand, BooksAndRuns, DefaultMinimum, FinalMinimum),

												getFirst(DiscardHand, AddedCardFromDiscard, RestDiscard),

												
												append([AddedCardFromDiscard], ComputerHand, HandWithDiscard),
											
												convertToNumbers(Wild, HandWithDiscard, [], FinalHandWithDiscard),
							
												sort(0, @=<, FinalHandWithDiscard,  SortedWithDiscard),
							
												sortHand(SortedWithDiscard, SortedWithDiscard, [], FinalSortedHandWithDiscard),
						

												checkBooksFinal(Wild, FinalSortedHandWithDiscard, [], FinalBooksWithDiscard),

												checkRunsFinal(Wild, FinalSortedHandWithDiscard, [], FinalRunsWithDiscard),
									
												append(FinalRunsWithDiscard, FinalBooksWithDiscard, BooksAndRunsWithDiscard),



								NewDefaultMinimum = [['4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s'],[]],


												goOutTest1(Wild, FinalSortedHandWithDiscard, BooksAndRunsWithDiscard, NewDefaultMinimum, FinalMinimumWithDiscard),



												convertToCards(Wild, FinalMinimum, [], BestBooksAndRunsCurrent),
												convertToCards(Wild, FinalMinimumWithDiscard, [], BestBooksAndRunsDiscard),

				computerPickDecision(BestBooksAndRunsCurrent, BestBooksAndRunsDiscard ,ComputerHand, DrawHand, DiscardHand, NextComputerHand, NextDrawPile, NextDiscardPile),

							
										NewDrawHand = NextDrawPile,					

%NOW DISCARD 
									convertToNumbers(Wild, NextComputerHand, [], FinalHandForDiscarding),
							
												sort(0, @=<, FinalHandForDiscarding,  SortedHandForDiscarding),
							
												sortHand(SortedHandForDiscarding, SortedHandForDiscarding, [], FinalSortedHandForDiscarding),
						
												checkBooksFinal(Wild, FinalSortedHandForDiscarding, [], FinalBooksForDiscarding),

												checkRunsFinal(Wild, FinalSortedHandForDiscarding, [], FinalRunsForDiscarding),
									
							


												append(FinalRunsForDiscarding, FinalBooksForDiscarding, BooksAndRunsForDiscarding),



								goOutTest1(Wild, FinalSortedHandForDiscarding, BooksAndRunsForDiscarding, DefaultMinimum, FinalMinimumForDiscarding),

								convertToCards(Wild, FinalMinimumForDiscarding, [], BestBooksAndRunsDiscardDecision),

		computerDiscardDecision(Wild, NextComputerHand, BestBooksAndRunsDiscardDecision, NextComputerHand, NextDiscardPile, FinalComputerHand, FinalDiscardAfter),

								
							tryToPutDownCards(Wild, FinalComputerHand, PointsToAdd),

							FinalPointsToAdd = PointsToAdd, 


							ComputerWinningCondition = 0.

							

/* *********************************************************************
Predicate Name: computerPlay
Purpose: Goes through computer normal play, try to go out.
Parameters: All info for game, including all hands, points, and round numbers.
			

Algorithm:
            1) Compare best books/runs for current hand and discard hand, pick from discard if the card creates better books/runs.
            2) Discard any card that does not add to books/runs.
            3) Try to go out, if so, set computerwinningcondition to 1, if not, set to 0.

********************************************************************* */
computerPlay(Wild, ComputerHand, DrawHand, DiscardHand, NewComputerHand, NewDrawHand, NewDiscardHand, RoundComputerPoints, HumanWinningCondition, ComputerWinningCondition) :- 
											%NORMAL COMPUTER TURN, TRY TO GO OUT

											writeln(''),
											writeln("It is the computers turn!"),
											convertToNumbers(Wild, ComputerHand, [], FinalHand),
							
												sort(0, @=<, FinalHand,  Sorted),
							
												sortHand(Sorted, Sorted, [], FinalSortedHand),
						
												checkBooksFinal(Wild, FinalSortedHand, [], FinalBooks),

												checkRunsFinal(Wild, FinalSortedHand, [], FinalRuns),
									
							


												append(FinalRuns, FinalBooks, BooksAndRuns),



												DefaultMinimum = [['4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s'],[]],

												goOutTest1(Wild, FinalSortedHand, BooksAndRuns, DefaultMinimum, FinalMinimum),

												getFirst(DiscardHand, AddedCardFromDiscard, RestDiscard),

												
												append([AddedCardFromDiscard], ComputerHand, HandWithDiscard),
											
												convertToNumbers(Wild, HandWithDiscard, [], FinalHandWithDiscard),
							
												sort(0, @=<, FinalHandWithDiscard,  SortedWithDiscard),
							
												sortHand(SortedWithDiscard, SortedWithDiscard, [], FinalSortedHandWithDiscard),
						

												checkBooksFinal(Wild, FinalSortedHandWithDiscard, [], FinalBooksWithDiscard),

												checkRunsFinal(Wild, FinalSortedHandWithDiscard, [], FinalRunsWithDiscard),
									
												append(FinalRunsWithDiscard, FinalBooksWithDiscard, BooksAndRunsWithDiscard),



								NewDefaultMinimum = [['4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s'],[]],


												goOutTest1(Wild, FinalSortedHandWithDiscard, BooksAndRunsWithDiscard, NewDefaultMinimum, FinalMinimumWithDiscard),



												convertToCards(Wild, FinalMinimum, [], BestBooksAndRunsCurrent),
												convertToCards(Wild, FinalMinimumWithDiscard, [], BestBooksAndRunsDiscard),

				computerPickDecision(BestBooksAndRunsCurrent, BestBooksAndRunsDiscard ,ComputerHand, DrawHand, DiscardHand, NextComputerHand, NextDrawPile, NextDiscardPile),

							
										NewDrawHand = NextDrawPile,					

%NOW DISCARD 
									convertToNumbers(Wild, NextComputerHand, [], FinalHandForDiscarding),
							
												sort(0, @=<, FinalHandForDiscarding,  SortedHandForDiscarding),
							
												sortHand(SortedHandForDiscarding, SortedHandForDiscarding, [], FinalSortedHandForDiscarding),
						
												checkBooksFinal(Wild, FinalSortedHandForDiscarding, [], FinalBooksForDiscarding),

												checkRunsFinal(Wild, FinalSortedHandForDiscarding, [], FinalRunsForDiscarding),
									
							


												append(FinalRunsForDiscarding, FinalBooksForDiscarding, BooksAndRunsForDiscarding),



								goOutTest1(Wild, FinalSortedHandForDiscarding, BooksAndRunsForDiscarding, DefaultMinimum, FinalMinimumForDiscarding),

								convertToCards(Wild, FinalMinimumForDiscarding, [], BestBooksAndRunsDiscardDecision),

		computerDiscardDecision(Wild, NextComputerHand, BestBooksAndRunsDiscardDecision, NextComputerHand, NextDiscardPile, FinalComputerHand, FinalDiscardAfter),


								convertToNumbers(Wild, FinalComputerHand, [], FinalHandForGoOut),
							
												sort(0, @=<, FinalHandForGoOut,  SortedHandForGoOut),
							
												sortHand(SortedHandForGoOut, SortedHandForGoOut, [], FinalSortedHandForGoOut),
						
												checkBooksFinal(Wild, FinalSortedHandForGoOut, [], FinalBooksForGoOut),

												checkRunsFinal(Wild, FinalSortedHandForGoOut, [], FinalRunsForGoOut),
									
											append(FinalRunsForGoOut, FinalBooksForGoOut, BooksAndRunsForGoOut),

							goOutTest1(Wild, FinalSortedHandForGoOut, BooksAndRunsForGoOut, DefaultMinimum, FinalMinimumForGoOut),


										convertToCards(Wild, FinalMinimumForGoOut, [], BestBooksAndRunsGoOut),


												computerGoOutDecision(BestBooksAndRunsGoOut, WinQuestion),

												writeln(''),
												writeln("New Draw Pile: "),
												writeln(NewDrawHand),
												writeln(''),
												writeln("New Discard Pile: "),
												writeln(FinalDiscardAfter),
												writeln(''),

												ComputerWinningCondition = WinQuestion,
												NewComputerHand = FinalComputerHand,
												NewDiscardHand = FinalDiscardAfter.
						


%Computer was able to go out, set condition to 1
computerGoOutDecision(BestBooksAndRuns, WinQuestion) :- getFirst(BestBooksAndRuns, LeftOverHand, BooksAndRuns),
										length(LeftOverHand, 0),
										writeln('The computer can go out! These are its cards!'),
										writeln(BooksAndRuns),
										WinQuestion = 1.

%Computer not able to go out, set condition to 0
computerGoOutDecision(BestBooksAndRuns, WinQuestion) :- getFirst(BestBooksAndRuns, LeftOverHand, BooksAndRuns),
										length(LeftOverHand, X),
										X > 0,
										writeln('The computer cannot go out with its cards ... '),
										
										WinQuestion = 0.


%Displays computer decision for picking
computerPickDecision(CurrentHandBest, DiscardHandBest, ComputerHand, DrawHand, DiscardHand, NextComputerHand, NextDrawPile, NextDiscardPile) :-CurrentHandBest = DiscardHandBest,
							writeln("The computer picked from the draw pile because the discard pile card did not create any books/runs."),
										pickFromDrawPile(ComputerHand, DrawHand, NextComputerHand, NextDrawPile),
										writeln("New Computer Hand: "),
										writeln(NextComputerHand),
										NextDiscardPile = DiscardHand.




computerPickDecision(CurrentHandBest, DiscardHandBest, ComputerHand, DrawHand, DiscardHand, NextComputerHand, NextDrawPile, NextDiscardPile) :- getFirst(CurrentHandBest, LeftOverHandCurrent, BooksRunsCurrentHand),
											length(LeftOverHandCurrent, SizeOfCurrent),

											getFirst(DiscardHandBest,LeftOverHandDiscard, BooksRunsDiscardHand),
											length(LeftOverHandDiscard, SizeOfDiscard),

											SizeOfCurrent >= SizeOfDiscard,

											writeln("The computer picked from the discard pile to build ... "),

											writeln(BooksRunsDiscardHand),

											pickFromDiscardPile(ComputerHand, DiscardHand, NextComputerHand, NextDiscardPile),

											writeln("New Computer Hand: "),
											writeln(NextComputerHand),
											DrawHand = NextDrawPile.



computerPickDecision(CurrentHandBest, DiscardHandBest, ComputerHand, DrawHand, DiscardHand, NextComputerHand, NextDrawPile, NextDiscardPile) :- getFirst(CurrentHandBest, LeftOverHandCurrent, BooksRunsCurrentHand),
											length(LeftOverHandCurrent, SizeOfCurrent),

											getFirst(DiscardHandBest, LeftOverHandDiscard, BooksRunsDiscardHand),
											length(LeftOverHandDiscard, SizeOfDiscard),

											SizeOfCurrent < SizeOfDiscard,

											writeln("The computer picked from the draw pile to build ... "),


											writeln(BooksRunsCurrentHand),
										pickFromDrawPile(ComputerHand, DrawHand, NextComputerHand, NextDrawPile),
										NextDiscardPile = DiscardHand.


%Display computer discard decision 
computerDiscardDecision(Wild, Hand, BestBooksAndRuns, OriginalComputerHand, OriginalDiscardPile,ComputerHandAfterDiscard, DiscardHandAfterComputer) :- getFirst(BestBooksAndRuns, LeftOverHand, FinalBooksAndRuns),
										length(LeftOverHand, LeftLength),
										LeftLength > 13,
										lastd(Hand, LastOfHand),
										writeln("The computer discarded ... "),
										writeln(LastOfHand),
										writeln(" ... because it could not find any books/runs in its hand."),
										discardCard(Wild, LastOfHand, OriginalComputerHand, OriginalDiscardPile, ComputerHandAfterDiscard, DiscardHandAfterComputer),
										writeln("Final Computer Hand: "),
										writeln(ComputerHandAfterDiscard).

computerDiscardDecision(Wild, Hand, BestBooksAndRuns, OriginalComputerHand, OriginalDiscardPile, ComputerHandAfterDiscard, DiscardHandAfterComputer) :- getFirst(BestBooksAndRuns, LeftOverHand, FinalBooksAndRuns),
										length(LeftOverHand, LeftLength),
										LeftLength < 13,
										getFirst(LeftOverHand, RestOfHand, NullValue),

										lastd([RestOfHand], LastOfRestHand),
										writeln("The computer discarded ... "),
										writeln(LastOfRestHand),
										writeln(" ... because it wants to build ... "),
										
										writeln(FinalBooksAndRuns),
							discardCard(Wild, LastOfRestHand, OriginalComputerHand, OriginalDiscardPile, ComputerHandAfterDiscard, DiscardHandAfterComputer),

										writeln("Final Computer Hand: "),
										writeln(ComputerHandAfterDiscard).




/* *********************************************************************
Predicate Name: tryToPutDownCards
Purpose: puts down cards better going out, gathers up remaing card points
Parameters: All info for game, including all hands, points, and round numbers.
			

Algorithm:
            1) Get best books/runs
            2) Count up leftover cards.

********************************************************************* */
tryToPutDownCards(Wild, Hand, Points) :- convertToNumbers(Wild, Hand, [], FinalHandForPutDown),
							
								DefaultMinimum = [['4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s','4s'],[]],

									sort(0, @=<, FinalHandForPutDown,  SortedHandForPutDown),
							
									sortHand(SortedHandForPutDown, SortedHandForPutDown, [], FinalSortedHandForPutDown),
						
									checkBooksFinal(Wild, FinalSortedHandForPutDown, [], FinalBooksForPutDown),

									checkRunsFinal(Wild, FinalSortedHandForPutDown, [], FinalRunsForPutDown),
									
									append(FinalRunsForPutDown, FinalBooksForPutDown, BooksAndRunsForGoOut),

									goOutTest1(Wild, FinalSortedHandForPutDown, BooksAndRunsForGoOut, DefaultMinimum, FinalMinimumForPutDown),

									convertToCards(Wild, FinalMinimumForPutDown, [], BestBooksAndRunsGoOut),

									putDown(Wild, Hand, BestBooksAndRunsGoOut, FinalPoints),

									Points = FinalPoints.

/* *********************************************************************
Predicate Name: putDown
Purpose: Player was able to put down all cards in hand, return points as 0.
Parameters: All info for game, including all hands, points, and round numbers.
			

Algorithm:
            1) Display books/runs and return 0 for points

********************************************************************* */
putDown(Wild, Hand, FinalMinimumForPutDown, Points):- getFirst(FinalMinimumForPutDown, LeftOverCards, BooksAndRuns),
												length(LeftOverCards, 0),
												
												writeln("These cards were put down before going out ... "),
												writeln(BooksAndRuns),
												writeln("Final Points Added Up: "),
												writeln("0"),

												writeln("Moving Onto Next Round!"),
												writeln(''),

												Points = 0.

/* *********************************************************************
Predicate Name: putDown
Purpose: Player was not able to put down cards before next round, return all points in hand
Parameters: All info for game, including all hands, points, and round numbers.
			

Algorithm:
            1) Display books/runs and return all card points.

********************************************************************* */
putDown(Wild, Hand, FinalMinimumForPutDown, Points):- getFirst(FinalMinimumForPutDown, LeftOverCards, BooksAndRuns),
												length(LeftOverCards, LengthLeftOver),
												LengthLeftOver > 13,
												
												calculatePoints(Wild, Hand, 0, ResultPoints),

												writeln("No cards were found to put down before going out."),
												writeln("Final Points Added up from round: "),
												writeln(ResultPoints),
												writeln("Moving Onto Next Round!"),
												writeln(''),

												Points = ResultPoints.

/* *********************************************************************
Predicate Name: putDown
Purpose: Player was able to put down some books/runs before going out, add up remaining cards.
Parameters: All info for game, including all hands, points, and round numbers.
			

Algorithm:
            1) Display books/runs and return leftover card points.

********************************************************************* */
putDown(Wild, Hand, FinalMinimumForPutDown, Points):- getFirst(FinalMinimumForPutDown, LeftOverCards, BooksAndRuns),
												length(LeftOverCards, LengthLeftOver),
												LengthLeftOver > 0,
												
												append(LeftOverCards, [], FinalLeftOverCards),
												calculatePoints(Wild, FinalLeftOverCards, 0, ResultPoints),

												writeln("These cards were put down before going out ... "),
												writeln(BooksAndRuns),
												writeln("Final Points Added Up: "),
												writeln(ResultPoints),

												writeln("Moving Onto Next Round!"),
												writeln(''),

												Points = ResultPoints.


%Predicate that add up points from a hand
calculatePoints(Wild, Cards, AddingPoints, ResultPoints) :- Cards = [],
									ResultPoints = AddingPoints.

calculatePoints(Wild, Cards, AddingPoints, ResultPoints) :- getFirst(Cards, CardToAdd, RestOfCards),
										getCardPoint(Wild, CardToAdd, NumberToAdd),
										plus(AddingPoints, NumberToAdd, FinalPointToAdd),

										calculatePoints(Wild, RestOfCards, FinalPointToAdd, ResultPoints).




/* *********************************************************************
Predicate Name: getCardPoint
Purpose: Get the points from a single card, considering if that card is wild as well.
Parameters: All info for game, including all hands, points, and round numbers.
			

Algorithm:
            1) Return the integer point depending on which card it is.

********************************************************************* */
getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'j1',
									NumberCard = 50.
getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'j2',
									NumberCard = 50.
getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'j3',
									NumberCard = 50.


getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'xc',
									Wild == 10,
									NumberCard = 20.



getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'jc',
									Wild == 11,
									NumberCard = 20.


getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'qc',
									Wild == 12,
									NumberCard = 20.



getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'kc',
									Wild == 13,
									NumberCard = 20.



getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '3c',
									Wild == 3,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '4c',
									Wild == 4,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '5c',
									Wild == 5,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '6c',
									Wild == 6,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '7c',
									Wild == 7,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '8c',
									Wild == 8,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '9c',
									Wild == 9,
									NumberCard = 20.


getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'xc',
									NumberCard = 10.



getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'jc',
									NumberCard = 11.


getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'qc',
									NumberCard = 12.



getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'kc',
									NumberCard = 13.


getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '3c',
									NumberCard = 3.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '4c',
									NumberCard = 4.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '5c',
									NumberCard = 5.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '6c',
									NumberCard = 6.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '7c',
									NumberCard = 7.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '8c',
									NumberCard = 8.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '9c',
									NumberCard = 9.





getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'xs',
									Wild == 10,
									NumberCard = 20.



getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'js',
									Wild == 11,
									NumberCard = 20.


getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'qs',
									Wild == 12,
									NumberCard = 20.



getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'ks',
									Wild == 13,
									NumberCard = 20.



getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '3s',
									Wild == 3,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '4s',
									Wild == 4,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '5s',
									Wild == 5,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '6s',
									Wild == 6,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '7s',
									Wild == 7,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '8s',
									Wild == 8,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '9s',
									Wild == 9,
									NumberCard = 20.


getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'xs',
									NumberCard = 10.



getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'js',
									NumberCard = 11.


getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'qs',
									NumberCard = 12.



getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'ks',
									NumberCard = 13.


getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '3s',
									NumberCard = 3.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '4s',
									NumberCard = 4.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '5s',
									NumberCard = 5.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '6s',
									NumberCard = 6.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '7s',
									NumberCard = 7.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '8s',
									NumberCard = 8.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '9s',
									NumberCard = 9.


%HEARTS

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'xh',
									Wild == 10,
									NumberCard = 20.



getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'jh',
									Wild == 11,
									NumberCard = 20.


getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'qh',
									Wild == 12,
									NumberCard = 20.



getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'kh',
									Wild == 13,
									NumberCard = 20.



getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '3h',
									Wild == 3,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '4h',
									Wild == 4,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '5h',
									Wild == 5,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '6h',
									Wild == 6,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '7h',
									Wild == 7,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '8h',
									Wild == 8,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '9h',
									Wild == 9,
									NumberCard = 20.


getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'xh',
									NumberCard = 10.



getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'jh',
									NumberCard = 11.


getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'qh',
									NumberCard = 12.



getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'kh',
									NumberCard = 13.


getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '3h',
									NumberCard = 3.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '4h',
									NumberCard = 4.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '5h',
									NumberCard = 5.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '6h',
									NumberCard = 6.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '7h',
									NumberCard = 7.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '8h',
									NumberCard = 8.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '9h',
									NumberCard = 9.



%DIAMONDS
getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'xd',
									Wild == 10,
									NumberCard = 20.



getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'jd',
									Wild == 11,
									NumberCard = 20.


getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'qd',
									Wild == 12,
									NumberCard = 20.



getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'kd',
									Wild == 13,
									NumberCard = 20.



getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '3d',
									Wild == 3,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '4d',
									Wild == 4,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '5d',
									Wild == 5,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '6d',
									Wild == 6,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '7d',
									Wild == 7,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '8d',
									Wild == 8,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '9d',
									Wild == 9,
									NumberCard = 20.


getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'xd',
									NumberCard = 10.



getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'jd',
									NumberCard = 11.


getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'qd',
									NumberCard = 12.



getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'kd',
									NumberCard = 13.


getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '3d',
									NumberCard = 3.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '4d',
									NumberCard = 4.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '5d',
									NumberCard = 5.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '6d',
									NumberCard = 6.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '7d',
									NumberCard = 7.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '8d',
									NumberCard = 8.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '9d',
									NumberCard = 9.


%TRIDENTS


getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'xt',
									Wild == 10,
									NumberCard = 20.



getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'jt',
									Wild == 11,
									NumberCard = 20.


getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'qt',
									Wild == 12,
									NumberCard = 20.



getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'kt',
									Wild == 13,
									NumberCard = 20.



getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '3t',
									Wild == 3,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '4t',
									Wild == 4,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '5t',
									Wild == 5,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '6t',
									Wild == 6,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '7t',
									Wild == 7,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '8t',
									Wild == 8,
									NumberCard = 20.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '9t',
									Wild == 9,
									NumberCard = 20.


getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'xt',
									NumberCard = 10.



getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'jt',
									NumberCard = 11.


getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'qt',
									NumberCard = 12.



getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == 'kt',
									NumberCard = 13.


getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '3t',
									NumberCard = 3.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '4t',
									NumberCard = 4.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '5t',
									NumberCard = 5.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '6t',
									NumberCard = 6.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '7t',
									NumberCard = 7.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '8t',
									NumberCard = 8.

getCardPoint(Wild, FirstCard, NumberCard) :- FirstCard == '9t',
									NumberCard = 9.








/* *********************************************************************
Predicate Name: pickFromDrawPile
Purpose: Picks the first card in the draw pile and return new hand/pile.
Parameters: Cards in hand and draw pile, returns new hand/pile
			

Algorithm:
            1) Append the first of draw to cards, return those in new variables.

********************************************************************* */

pickFromDrawPile(Cards, DrawPile, NewCards, NewDrawPile) :- 
						
									selectchk(X, DrawPile, Y),
									GetCard = [X],

									append(Cards, GetCard, AddedCard),
									NewDrawPile = Y,
									NewCards = AddedCard.


%Similar to above preciate, but picks from discard pile instead.
pickFromDiscardPile(Cards, DiscardPile, NewCards, NewDiscardPile) :- 
						
									selectchk(X, DiscardPile, Y),
									GetCard = [X],

									append(Cards, GetCard, AddedCard),
									NewDiscardPile = Y,
									NewCards = AddedCard.


/* *********************************************************************
Predicate Name: discardCard
Purpose: Discard a card from user input if it was found and return new hand/pile.
Parameters: Wild, Cards in hand and discard pile, returns new hand/pile
			

Algorithm:
            1) Remove the card inputted, add to discard pile, and  intialize new hand/pile.

********************************************************************* */
discardCard(Wild, CardToDiscard, Cards, DiscardPile, NewCards, NewDiscardPile) :- member(CardToDiscard, Cards),
									
									append([CardToDiscard], DiscardPile, FinalDiscardPile),
									remove(CardToDiscard, Cards, FinalCards),
									NewDiscardPile = FinalDiscardPile,
									NewCards = FinalCards.



discardCard(Wild, CardToDiscard, Cards, DiscardPile, NewCards, NewDiscardPile) :- 
							writeln("Card was not found, try again."),
							writeln(CardToDiscard),
							read(X),
							discardCard(Wild, X, Cards, DiscardPile, NewCards, NewDiscardPile).
							








%Predicate to deal cards for hand/pile. Depends on what round it is.
dealCards(Wild, Deck, Hand, ReturnHand, ReturnedDeck) :- Wild =:= 0,
									ReturnHand = Hand,
									ReturnedDeck = Deck.

								   
	

dealCards(Wild, Deck, Hand, ReturnHand, ReturnedDeck) :-

									selectchk(X, Deck, Y),

									AddedCard = [X],

									append(Hand, AddedCard, NewCards),

									plus(-1, Wild, NewWild),
									dealCards(NewWild, Y, NewCards, ReturnHand, ReturnedDeck).


%All 2 decks of cards.
deck(['3c','4c','5c','6c','7c','8c','9c','xc','jc','qc','kc','j1','j2','j3',
	'3s','4s','5s','6s','7s','8s','9s', 'xs','js','qs','ks',
	'3t','5t','6t','7t','8t','9t','xt','jt','qt','kt',
	'3d','5d','6d','7d','8d','9d','xd','jd','qd','kd',
	'3h','5h','6h','7h','8h','9h','xh','jh','qh','kh',
	'3c','4c','5c','6c','7c','8c','9c','xc','jc','qc','kc','j1','j2','j3',
	'3s','4s','5s','6s','7s','8s','9s', 'xs','js','qs','ks',
	'3t','5t','6t','7t','8t','9t','xt','jt','qt','kt',
	'3d','5d','6d','7d','8d','9d','xd','jd','qd','kd',
	'3h','5h','6h','7h','8h','9h','xh','jh','qh','kh']).



%Predicate to remove item from list and place into new varaible.
remove(A,[A|X],X).
remove(A,[B|X],[B|Y]) :- remove(A,X,Y).


lastd([Head],X):-
        X = Head.
        lastd([_|Tail],X):-
            lastd(Tail,X).


%Predicate that converts a card hand to only numbers and then suite
convertToNumbers(Wild, Hand, ConvertedHand, FinalHand) :- length(Hand, 0),

											FinalHand = ConvertedHand.

convertToNumbers(Wild, Hand, ConvertedHand, FinalHand) :- getFirst(Hand, FirstCard, RestofHand),

										
										whichNumber(Wild, FirstCard, NumberCard),
										
										

										append(ConvertedHand, [NumberCard], NextConvertedHand),
										convertToNumbers(Wild, RestofHand, NextConvertedHand, FinalHand).

%Predicates that sort a hand that is converted to numbers.
sortHand(Hand, OriginalHand, WorkingHand, FinalHand) :- getFirst(Hand, FirstCard, RestofHand),
					atom_length(FirstCard,X),
					X=3,
					WorkingHand = [],
					
					FinalHand = Hand.

sortHand(Hand, OriginalHand, WorkingHand, FinalHand) :- getFirst(Hand, FirstCard, RestofHand),
					atom_length(FirstCard,X),
					X=2,
					
					append(Hand, WorkingHand, FinalWorkingHand),
					FinalHand = FinalWorkingHand.

sortHand(Hand, OriginalHand, WorkingHand, FinalHand) :- getFirst(Hand, FirstCard, RestofHand),		
				atom_length(FirstCard,X),
				X = 3, 

				append(WorkingHand, [FirstCard], FinalWorkingHand),
				sortHand(RestofHand, OriginalHand, FinalWorkingHand, FinalHand).



/* *********************************************************************
Predicate Name: whichNumber
Purpose: Convert one card to number, if it is a joker, the number is 19, if it is a wild, the number is 15.
Parameters: Wild for round, card being converted, and final number card.
			

Algorithm:
            1) Convert a single card to a number card, considering the wild for the round as well.

********************************************************************* */
whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'j1',
									NumberCard = '19c'.
whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'j2',
									NumberCard = '19s'.
whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'j3',
									NumberCard = '19t'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'xc',
									Wild == 10,
									NumberCard = '15c'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'jc',
									Wild == 11,
									NumberCard = '15c'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'qc',
									Wild == 12,
									NumberCard = '15c'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'kc',
									Wild == 13,
									NumberCard = '15c'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '3c',
									Wild == 3,
									NumberCard = '15c'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '4c',
									Wild == 4,
									NumberCard = '15c'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '5c',
									Wild == 5,
									NumberCard = '15c'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '6c',
									Wild == 6,
									NumberCard = '15c'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '7c',
									Wild == 7,
									NumberCard = '15c'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '8c',
									Wild == 8,
									NumberCard = '15c'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '9c',
									Wild == 9,
									NumberCard = '15c'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'xc',
									NumberCard = '10c'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'jc',
									NumberCard = '11c'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'qc',
									NumberCard = '12c'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'kc',
									NumberCard = '13c'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '3c',
									NumberCard = '3c'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '4c',
									NumberCard = '4c'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '5c',
									NumberCard = '5c'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '6c',
									NumberCard = '6c'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '7c',
									NumberCard = '7c'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '8c',
									NumberCard = '8c'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '9c',
									NumberCard = '9c'.

% HERE


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'xs',
									Wild == 10,
									NumberCard = '15s'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'js',
									Wild == 11,
									NumberCard = '15s'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'qs',
									Wild == 12,
									NumberCard = '15s'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'ks',
									Wild == 13,
									NumberCard = '15s'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '3s',
									Wild == 3,
									NumberCard = '15s'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '4s',
									Wild == 4,
									NumberCard = '15s'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '5s',
									Wild == 5,
									NumberCard = '15s'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '6s',
									Wild == 6,
									NumberCard = '15s'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '7s',
									Wild == 7,
									NumberCard = '15s'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '8s',
									Wild == 8,
									NumberCard = '15s'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '9s',
									Wild == 9,
									NumberCard = '15s'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'xs',
									NumberCard = '10s'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'js',
									NumberCard = '11s'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'qs',
									NumberCard = '12s'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'ks',
									NumberCard = '13s'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '3s',
									NumberCard = '3s'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '4s',
									NumberCard = '4s'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '5s',
									NumberCard = '5s'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '6s',
									NumberCard = '6s'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '7s',
									NumberCard = '7s'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '8s',
									NumberCard = '8s'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '9s',
									NumberCard = '9s'.


%HEARTS

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'xh',
									Wild == 10,
									NumberCard = '15h'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'jh',
									Wild == 11,
									NumberCard = '15h'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'qh',
									Wild == 12,
									NumberCard = '15h'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'kh',
									Wild == 13,
									NumberCard = '15h'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '3h',
									Wild == 3,
									NumberCard = '15h'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '4h',
									Wild == 4,
									NumberCard = '15h'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '5h',
									Wild == 5,
									NumberCard = '15h'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '6h',
									Wild == 6,
									NumberCard = '15h'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '7h',
									Wild == 7,
									NumberCard = '15h'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '8h',
									Wild == 8,
									NumberCard = '15h'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '9h',
									Wild == 9,
									NumberCard = '15h'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'xh',
									NumberCard = '10h'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'jh',
									NumberCard = '11h'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'qh',
									NumberCard = '12h'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'kh',
									NumberCard = '13h'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '3h',
									NumberCard = '3h'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '4h',
									NumberCard = '4h'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '5h',
									NumberCard = '5h'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '6h',
									NumberCard = '6h'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '7h',
									NumberCard = '7h'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '8h',
									NumberCard = '8h'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '9h',
									NumberCard = '9h'.



%DIAMONDS
whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'xd',
									Wild == 10,
									NumberCard = '15d'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'jd',
									Wild == 11,
									NumberCard = '15d'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'qd',
									Wild == 12,
									NumberCard = '15d'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'kd',
									Wild == 13,
									NumberCard = '15d'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '3d',
									Wild == 3,
									NumberCard = '15d'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '4d',
									Wild == 4,
									NumberCard = '15d'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '5d',
									Wild == 5,
									NumberCard = '15d'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '6d',
									Wild == 6,
									NumberCard = '15d'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '7d',
									Wild == 7,
									NumberCard = '15d'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '8d',
									Wild == 8,
									NumberCard = '15d'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '9d',
									Wild == 9,
									NumberCard = '15d'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'xd',
									NumberCard = '10d'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'jd',
									NumberCard = '11d'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'qd',
									NumberCard = '12d'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'kd',
									NumberCard = '13d'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '3d',
									NumberCard = '3d'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '4d',
									NumberCard = '4d'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '5d',
									NumberCard = '5d'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '6d',
									NumberCard = '6d'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '7d',
									NumberCard = '7d'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '8d',
									NumberCard = '8d'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '9d',
									NumberCard = '9d'.


%TRIDENTS


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'xt',
									Wild == 10,
									NumberCard = '15t'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'jt',
									Wild == 11,
									NumberCard = '15t'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'qt',
									Wild == 12,
									NumberCard = '15t'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'kt',
									Wild == 13,
									NumberCard = '15t'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '3t',
									Wild == 3,
									NumberCard = '15t'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '4t',
									Wild == 4,
									NumberCard = '15t'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '5t',
									Wild == 5,
									NumberCard = '15t'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '6t',
									Wild == 6,
									NumberCard = '15t'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '7t',
									Wild == 7,
									NumberCard = '15t'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '8t',
									Wild == 8,
									NumberCard = '15t'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '9t',
									Wild == 9,
									NumberCard = '15t'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'xt',
									NumberCard = '10t'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'jt',
									NumberCard = '11t'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'qt',
									NumberCard = '12t'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == 'kt',
									NumberCard = '13t'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '3t',
									NumberCard = '3t'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '4t',
									NumberCard = '4t'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '5t',
									NumberCard = '5t'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '6t',
									NumberCard = '6t'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '7t',
									NumberCard = '7t'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '8t',
									NumberCard = '8t'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '9t',
									NumberCard = '9t'.


%Predicates that converts hand back to only cards from numbers
convertToCards(Wild, Hand, ConvertedHand, FinalHand) :- length(Hand, 0),
											FinalHand = ConvertedHand.


convertToCards(Wild, Hand, ConvertedHand, FinalHand) :- 
											getFirst(Hand, FirstBR, RestBR),
											FirstBR = [],
											append(ConvertedHand, [[]], NextConvertedHand),
											convertToCards(Wild, RestBR, NextConvertedHand, FinalHand).

convertToCards(Wild, Hand, ConvertedHand, FinalHand) :- 
											getFirst(Hand, FirstBR, RestBR),
											
											convertToCardsOneList(Wild, FirstBR, OneConvertedHand, FinalHandFromConversion),
											append(ConvertedHand, [FinalHandFromConversion], NextConvertedHand),
											convertToCards(Wild, RestBR, NextConvertedHand, FinalHand).


convertToCardsOneList(Wild, Hand, ConvertedHand, FinalHand) :- length(Hand, 0),

											FinalHand = ConvertedHand.

convertToCardsOneList(Wild, Hand, ConvertedHand, FinalHand) :- getFirst(Hand, FirstCard, RestofHand),

										
										whichNumber(Wild, FirstCard, NumberCard),
										
										

										append(ConvertedHand, [NumberCard], NextConvertedHand),
										convertToCardsOneList(Wild, RestofHand, NextConvertedHand, FinalHand).



/* *********************************************************************
Predicate Name: whichNumber
Purpose: Convert one number card to regular card.
Parameters: Wild for round, card being converted, and final number card.
			

Algorithm:
            1) Convert a single number card to a regular card, considering the wild for the round as well.

********************************************************************* */
whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '19c',
									NumberCard = 'j1'.
whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '19s',
									NumberCard = 'j2'.
whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '19t',
									NumberCard = 'j3'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15c',
									Wild == 10,
									NumberCard = 'xc'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15c',
									Wild == 11,
									NumberCard = 'jc'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15c',
									Wild == 12,
									NumberCard = 'qc'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15c',
									Wild == 13,
									NumberCard = 'kc'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15c',
									Wild == 3,
									NumberCard = '3c'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15c',
									Wild == 4,
									NumberCard = '4c'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15c',
									Wild == 5,
									NumberCard = '5c'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15c',
									Wild == 6,
									NumberCard = '6c'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15c',
									Wild == 7,
									NumberCard = '7c'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15c',
									Wild == 8,
									NumberCard = '8c'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15c',
									Wild == 9,
									NumberCard = '9c'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '10c',
									NumberCard = 'xc'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '11c',
									NumberCard = 'jc'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '12c',
									NumberCard = 'qc'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '13c',
									NumberCard = 'kc'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '3c',
									NumberCard = '3c'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '4c',
									NumberCard = '4c'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '5c',
									NumberCard = '5c'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '6c',
									NumberCard = '6c'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '7c',
									NumberCard = '7c'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '8c',
									NumberCard = '8c'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '9c',
									NumberCard = '9c'.

% HERE


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15s',
									Wild == 10,
									NumberCard = 'xs'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15s',
									Wild == 11,
									NumberCard = 'js'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15s',
									Wild == 12,
									NumberCard = 'qs'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15s',
									Wild == 13,
									NumberCard = 'ks'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15s',
									Wild == 3,
									NumberCard = '3s'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15s',
									Wild == 4,
									NumberCard = '4s'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '5s',
									Wild == 5,
									NumberCard = '15s'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15s',
									Wild == 6,
									NumberCard = '6s'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15s',
									Wild == 7,
									NumberCard = '7s'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15s',
									Wild == 8,
									NumberCard = '8s'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15s',
									Wild == 9,
									NumberCard = '9s'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '10s',
									NumberCard = 'xs'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '11s',
									NumberCard = 'js'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '12s',
									NumberCard = 'qs'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '13s',
									NumberCard = 'ks'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '3s',
									NumberCard = '3s'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '4s',
									NumberCard = '4s'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '5s',
									NumberCard = '5s'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '6s',
									NumberCard = '6s'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '7s',
									NumberCard = '7s'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '8s',
									NumberCard = '8s'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '9s',
									NumberCard = '9s'.


%HEARTS

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15h',
									Wild == 10,
									NumberCard = 'xh'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15h',
									Wild == 11,
									NumberCard = 'jh'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15h',
									Wild == 12,
									NumberCard = 'qh'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15h',
									Wild == 13,
									NumberCard = 'kh'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15h',
									Wild == 3,
									NumberCard = '3h'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15h',
									Wild == 4,
									NumberCard = '4h'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15h',
									Wild == 5,
									NumberCard = '5h'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15h',
									Wild == 6,
									NumberCard = '6h'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15h',
									Wild == 7,
									NumberCard = '7h'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15h',
									Wild == 8,
									NumberCard = '8h'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15h',
									Wild == 9,
									NumberCard = '9h'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '10h',
									NumberCard = 'xh'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '11h',
									NumberCard = 'jh'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '12h',
									NumberCard = 'qh'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '13h',
									NumberCard = 'kh'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '3h',
									NumberCard = '3h'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '4h',
									NumberCard = '4h'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '5h',
									NumberCard = '5h'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '6h',
									NumberCard = '6h'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '7h',
									NumberCard = '7h'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '8h',
									NumberCard = '8h'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '9h',
									NumberCard = '9h'.



%DIAMONDS
whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15d',
									Wild == 10,
									NumberCard = 'xd'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15d',
									Wild == 11,
									NumberCard = 'jd'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15d',
									Wild == 12,
									NumberCard = 'qd'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15d',
									Wild == 13,
									NumberCard = 'kd'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15d',
									Wild == 3,
									NumberCard = '3d'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15d',
									Wild == 4,
									NumberCard = '4d'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15d',
									Wild == 5,
									NumberCard = '5d'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15d',
									Wild == 6,
									NumberCard = '6d'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15d',
									Wild == 7,
									NumberCard = '7d'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15d',
									Wild == 8,
									NumberCard = '8d'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15d',
									Wild == 9,
									NumberCard = '9d'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '10d',
									NumberCard = 'xd'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '11d',
									NumberCard = 'jd'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '12d',
									NumberCard = 'qd'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '13d',
									NumberCard = 'kd'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '3d',
									NumberCard = '3d'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '4d',
									NumberCard = '4d'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '5d',
									NumberCard = '5d'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '6d',
									NumberCard = '6d'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '7d',
									NumberCard = '7d'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '8d',
									NumberCard = '8d'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '9d',
									NumberCard = '9d'.


%TRIDENTS


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15t',
									Wild == 10,
									NumberCard = 'xt'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15t',
									Wild == 11,
									NumberCard = 'jt'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15t',
									Wild == 12,
									NumberCard = 'qt'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15t',
									Wild == 13,
									NumberCard = 'kt'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15t',
									Wild == 3,
									NumberCard = '3t'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15t',
									Wild == 4,
									NumberCard = '4t'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15t',
									Wild == 5,
									NumberCard = '5t'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15t',
									Wild == 6,
									NumberCard = '6t'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15t',
									Wild == 7,
									NumberCard = '7t'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15t',
									Wild == 8,
									NumberCard = '8t'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '15t',
									Wild == 9,
									NumberCard = '9t'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '10t',
									NumberCard = 'xt'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '11t',
									NumberCard = 'jt'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '12t',
									NumberCard = 'qt'.



whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '13t',
									NumberCard = 'kt'.


whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '3t',
									NumberCard = '3t'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '4t',
									NumberCard = '4t'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '5t',
									NumberCard = '5t'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '6t',
									NumberCard = '6t'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '7t',
									NumberCard = '7t'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '8t',
									NumberCard = '8t'.

whichNumber(Wild, FirstCard, NumberCard) :- FirstCard == '9t',
									NumberCard = '9t'.







/* *********************************************************************
Predicate Name: checkBooksFinal
Purpose: Returns all books in player's hand
Parameters: wild for round, player's hand, and all books which starts as NULL
Return Value: all books in hand
Local Variables:
            none
Algorithm:
            1) Calls checkBooksMiddle with first card in hand.
            2) If checkBooksMiddle returns the same value of books, then recursively call function with leftover hand and same books.
            3) If not same value, then recursively call function with leftover hand and adding found books found in checkBooksMiddle.
           
********************************************************************* */

checkBooksFinal(Wild, Hand, Books, FinalBooks) :- length(Hand, 0),
								FinalBooks = Books.

checkBooksFinal(Wild, Hand, Books, FinalBooks) :- length(Hand, 0),
								Books = [],
								FinalBooks = [[]].


checkBooksFinal(Wild, Hand, Books, FinalBooks) :- getFirst(Hand, CheckingCard, RestofHand),
					
						checkBooksMiddle(Wild, Wild, CheckingCard, RestofHand, Books, [], FinalBooksMiddle),

						append(Books, FinalBooksMiddle, LastBooks),
						delete(LastBooks, [], LastBooksNoNull),
						checkBooksFinal(Wild, RestofHand, LastBooksNoNull, FinalBooks).






/* *********************************************************************
Function Name: checkBooksMiddle
Purpose: Returns all books in player's hand for one card
Parameters: wild for round, number for round, card to check for books, player's hand, and all books already found
Return Value: all books found from card
Local Variables:
            none
Algorithm:
            1) Calls checkBooksThird with card.
            2) checkBooksThird is looking for a book with size number.
            3) If it returns a book of size number, then add that returned book to books parameter of checkBooksMiddle.
               4) Recursive call checkBooksMiddle with updated book list and decreased number size-1 to find new book of that new number size.
           5) If it does not return book of size number, then don't add to books parameter, and recursive call with same books and number-1.
           6) Returns all books to checkBooksFinal once number is less than 3, so it doesn't look for a book of size 2
********************************************************************* */
checkBooksMiddle(Wild, Number, CheckingCard, RestofHand, OriginalBooks, Books, FinalBooksMiddle) :- Books \== [],
											Number < 3,
											FinalBooksMiddle = Books.

checkBooksMiddle(Wild, Number, CheckingCard, RestofHand, OriginalBooks, Books, FinalBooksMiddle) :- Books == [],

											Number < 3,
											FinalBooksMiddle = ''.


checkBooksMiddle(Wild, Number, CheckingCard, RestofHand, OriginalBooks, Books, FinalBooksMiddle) :-

											checkBooksThird(Wild, Number, CheckingCard, RestofHand, [CheckingCard], FinalSingleBook),
											
									
											append(Books, [FinalSingleBook], UpdatedBooks),
											

											plus(-1, Number, NextNumber),
											checkBooksMiddle(Wild, NextNumber, CheckingCard, RestofHand, OriginalBooks, UpdatedBooks, FinalBooksMiddle).




/* *********************************************************************
Function Name: checkBooksThird
Purpose: Returns a book of size number, or book when there are no more cards left in hand to check
Parameters: wild for round, number for round, card to check for books, player's hand, and book found
Return Value: a book of size number found from card or a book that when there are no more cards in hand to check
Local Variables:
            none
Algorithm:
            1) Checks if the first card in hand is less than value 10
               2) If that first card is the same value as checking card, then call function again with rest of hand, and adding that first card to book.
               3) If that first card is the wild for the round, then call function again with rest of hand, and adding that first card to book.
               4) Else, call function again with rest of hand and same book.
            5) Checks if the first card is a wild, if so, call function again with rest of hand, and adding that first card to book.
            6) Checks if the first card is a joker, if so, call function again with rest of hand, and adding that first card to book.
            7) Checks if the first card value is greater than 9 and checking card value is less than 10.
               8) If so, call function with rest of hand and same book.
           9) Check if first card is same value as checking card, and both values are greater than 9.
              10) If so, call function again with rest of hand, and adding that first card to book.
           11) Else, call function again with rest of hand, and same book.
           12) Function finally returns book when there are no more cards in hand to check, or the length of book is the number needed.
********************************************************************* */
checkBooksThird(Wild, Number, CheckingCard, RestofHand, SingleBook, FinalSingleBook) :- length(SingleBook, Number),

																	FinalSingleBook = SingleBook.

checkBooksThird(Wild, Number, CheckingCard, RestofHand, SingleBook, FinalSingleBook) :- length(RestofHand, 0),
																	length(SingleBook, BookLength),
																	BookLength \== Number,
																	
																	FinalSingleBook = [].

%CHECKING FOR SINGLE DIGIT CARD, SINGLE DIGIT FIRST CARD
checkBooksThird(Wild, Number, CheckingCard, RestofHand, SingleBook, FinalSingleBook) :- 
													getFirst(RestofHand, FirstofRest, RestofRestOfHand),
													atom_length(FirstofRest, LengthOfRestCard),
													LengthOfRestCard < 3, 
													atom_length(CheckingCard, LengthOfCheckingCard),
													LengthOfCheckingCard < 3,

													sub_atom(CheckingCard, 0, 1, A, ValueOfChecking),
													sub_atom(FirstofRest, 0, 1, B, ValueOfRestCard),

													ValueOfChecking =@= ValueOfRestCard,
													append(SingleBook, [FirstofRest], GoodSingleBook),
													
													checkBooksThird(Wild, Number, CheckingCard, RestofRestOfHand, GoodSingleBook, FinalSingleBook).


%CHECKING FOR SINGLE DIGIT CARD, SINGLE DIGIT FIRST CARD, BUT NOT EQUAL VALUES
checkBooksThird(Wild, Number, CheckingCard, RestofHand, SingleBook, FinalSingleBook) :- 

													getFirst(RestofHand, FirstofRest, RestofRestOfHand),
													atom_length(FirstofRest, LengthOfRestCard),
													atom_length(FirstofRest, LengthOfRestCard),
													LengthOfRestCard < 3, 
													atom_length(CheckingCard, LengthOfCheckingCard),
													LengthOfCheckingCard < 3,
													
												checkBooksThird(Wild, Number, CheckingCard, RestofRestOfHand, SingleBook, FinalSingleBook).

%CHECKING FOR WILD IS FIRST CARD
checkBooksThird(Wild, Number, CheckingCard, RestofHand, SingleBook, FinalSingleBook) :- 
													getFirst(RestofHand, FirstofRest, RestofRestOfHand),
													atom_length(FirstofRest, LengthOfRestCard),
													LengthOfRestCard > 2, 
													
													%BECAUSE WILDS ARE 15c, etc.
													sub_atom(FirstofRest, 1, 1, B, ValueOfRestCard),
													ValueOfRestCard == '5',



													append(SingleBook, [FirstofRest], GoodSingleBook),
													
													checkBooksThird(Wild, Number, CheckingCard, RestofRestOfHand, GoodSingleBook, FinalSingleBook).


%CHECKING FOR JOKER IS FIRST CARD
checkBooksThird(Wild, Number, CheckingCard, RestofHand, SingleBook, FinalSingleBook) :- 
													getFirst(RestofHand, FirstofRest, RestofRestOfHand),
													atom_length(FirstofRest, LengthOfRestCard),
													LengthOfRestCard > 2, 
													
													%BECAUSE JOKERS ARE 501, etc.
													sub_atom(FirstofRest, 1, 1, B, ValueOfRestCard),
													ValueOfRestCard == '9',



													append(SingleBook, [FirstofRest], GoodSingleBook),
													
													checkBooksThird(Wild, Number, CheckingCard, RestofRestOfHand, GoodSingleBook, FinalSingleBook).


%CHECKING IF CARD IS 10+
checkBooksThird(Wild, Number, CheckingCard, RestofHand, SingleBook, FinalSingleBook) :- 
													getFirst(RestofHand, FirstofRest, RestofRestOfHand),
													atom_length(FirstofRest, LengthOfRestCard),
													LengthOfRestCard > 2, 
													atom_length(CheckingCard, LengthOfCheckingCard),
													LengthOfCheckingCard > 2,

													%PLUS 10 TO SECOND DIGIT FOR BOTH
													sub_atom(CheckingCard, 1, 1, A, ValueOfChecking),
													sub_atom(FirstofRest, 1, 1, B, ValueOfRestCard),

													atom_number(ValueOfChecking, NumberValueOfChecking),
													atom_number(ValueOfRestCard, NumberValueOfRestCard),

													plus(10, NumberValueOfChecking, FinalValueOfChecking),
													plus(10, NumberValueOfRestCard, FinalValueOfRestCard),


													FinalValueOfRestCard =@= FinalValueOfChecking,
													append(SingleBook, [FirstofRest], GoodSingleBook),
													
													checkBooksThird(Wild, Number, CheckingCard, RestofRestOfHand, GoodSingleBook, FinalSingleBook).



checkBooksThird(Wild, Number, CheckingCard, RestofHand, SingleBook, FinalSingleBook) :- 

													getFirst(RestofHand, FirstofRest, RestofRestOfHand),
													atom_length(FirstofRest, LengthOfRestCard),
													atom_length(FirstofRest, LengthOfRestCard),
													LengthOfRestCard > 2, 
													atom_length(CheckingCard, LengthOfCheckingCard),
													LengthOfCheckingCard > 2,
													
												checkBooksThird(Wild, Number, CheckingCard, RestofRestOfHand, SingleBook, FinalSingleBook).

checkBooksThird(Wild, Number, CheckingCard, RestofHand, SingleBook, FinalSingleBook) :- 

													getFirst(RestofHand, FirstofRest, RestofRestOfHand),
													atom_length(FirstofRest, LengthOfRestCard),
													atom_length(FirstofRest, LengthOfRestCard),
													LengthOfRestCard > 2, 
													atom_length(CheckingCard, LengthOfCheckingCard),
													LengthOfCheckingCard < 3,
													
												checkBooksThird(Wild, Number, CheckingCard, RestofRestOfHand, SingleBook, FinalSingleBook).



/* *********************************************************************
Function Name: checkRunsFinal
Purpose: Returns all runs in player's hand
Parameters: wild for round, player's hand, and all runs which starts as NULL
Return Value: all runs in hand
Local Variables:
            none
Algorithm:
            1) Calls checkRunsMiddle with first card in hand.
            2) If checkRunsMiddle returns the same value of runs, then recursively call function with leftover hand and same runs.
            3) If not same value, then recursively call function with leftover hand and adding found runs found in checkRunsMiddle.
           
********************************************************************* */
checkRunsFinal(Wild, Hand, Runs, FinalRuns) :- length(Hand, 0),
								FinalRuns = Runs.


checkRunsFinal(Wild, Hand, Runs, FinalRuns) :- length(Hand, 0),
								Runs = [],
								FinalRuns = [[]].

checkRunsFinal(Wild, Hand, Runs, FinalRuns) :- getFirst(Hand, CheckingCard, RestofHand),
					
						checkRunsMiddle(Wild, Wild, CheckingCard, RestofHand, Runs, [], FinalRunsMiddle),

						append(Runs, FinalRunsMiddle, LastRuns),
						delete(LastRuns, [], LastRunsNoNull),
						checkRunsFinal(Wild, RestofHand, LastRunsNoNull, FinalRuns).





/* *********************************************************************
Function Name: checkRunsMiddle
Purpose: Returns all runs in player's hand for one card
Parameters: wild for round, number for round, card to check for runs, player's hand, and all runs already found
Return Value: all runs found from card
Local Variables:
            none
Algorithm:
            1) Calls checkRunsThird with card.
            2) checkRunsThird is looking for a run with size number.
            3) If it returns a run of size number, then add that returned run to runs parameter of checkRunsMiddle.
               4) Recursive call checkRunsMiddle. with updated run list and decreased number size-1 to find new run of that new number size.
           5) If it does not return run of size number, then don't add to runs parameter, and recursive call with same runs and number-1.
           6) Returns all runs to checkRuns1 once number is less than 3, so it doesn't look for a run of size 2
********************************************************************* */
checkRunsMiddle(Wild, Number, CheckingCard, RestofHand, OriginalRuns, Runs, FinalRunsMiddle) :- Runs \== [],
											Number < 3,
											FinalRunsMiddle = Runs.

checkRunsMiddle(Wild, Number, CheckingCard, RestofHand, OriginalRuns, Runs, FinalRunsMiddle) :- Runs == [],

											Number < 3,
											FinalRunsMiddle = ''.


checkRunsMiddle(Wild, Number, CheckingCard, RestofHand, OriginalRuns, Runs, FinalRunsMiddle) :-

											checkRunsThird(Wild, Number, CheckingCard, RestofHand, [CheckingCard], FinalSingleRun, 1),
											
									
											append(Runs, [FinalSingleRun], UpdatedRuns),
											
											
											plus(-1, Number, NextNumber),
											checkRunsMiddle(Wild, NextNumber, CheckingCard, RestofHand, OriginalRuns, UpdatedRuns, FinalRunsMiddle).






/* *********************************************************************
Function Name: checkRunsThird
Purpose: Returns a run of size number, or run when there are no more cards left in hand to check
Parameters: wild for round, number for round, card to check for runs, player's hand, and run found, runIncrement that starts at 1
Return Value: a run of size number found from card or a run that when there are no more cards in hand to check
Local Variables:
            none
Algorithm:
            1) Checks if the first card in hand is a wild, if so, call function with rest of hand and adding that first card to run, and runIncrement +1.
            2) Checks if the first card's value is less than 10, and if the checking card is less than 9.
               3) Checks if the checking card's value + runIncrement is equal to the first card's value, and is both are same suit.
                   4) If so, call function with rest of hand and adding that first card to run, and runIncrement +1.
               5) Checks if the checking card's value is +2 runIncrement and both same suit, or if first card is a wild, or a joker.
                 6) If so, call function with rest of hand and adding that first card to run, and runIncrement +2.
               7) Else, call function again with rest of hand, same run, and runIncrement.
           8) Check if checking card and first card value is 9, if so, call function again with rest of hand, same run, and runIncrement.
           9) Check if first card is a joker, if so, call function again with rest of hand, adding that first card to run, and runIncrement +1.
           10) Checks if the checking card is 9 and the first card is 10 with the same suit, if so, return updated runs, runIncrement, and hand.
           11) Checks if checking card is 9 and the first card is greater than 9 but not 10. If so, return same runs, sane runIncrement, and rest of hand.
           12) Checks if the checking card's value +runIncrement is the first cards value and same suite, if so, return updated runs, runIncrement, and hand.
           13) Checks if the checking card's value is +2 runIncrement and both same suit, or if first card is a wild, or a joker.
               14) If so, call function with rest of hand and adding that first card to run, and runIncrement +2.
           15) Else, call function with rest of hand, same run, and same runIncrement.
           16) Function finally returns run when there are no more cards in hand to check, or the length of run is the number needed.
********************************************************************* */
checkRunsThird(Wild, Number, CheckingCard, RestofHand, SingleRun, FinalSingleRun, RunIncrement) :- length(SingleRun, Number),
																	
																	FinalSingleRun = SingleRun.

checkRunsThird(Wild, Number, CheckingCard, RestofHand, SingleRun, FinalSingleRun, RunIncrement) :- length(RestofHand, 0),
																	length(SingleRun, RunLength),
																	RunLength \== Number,
																	
																	FinalSingleRun = [].


%FIRST, JUST CHECK IF THE FIRST CARD IS WILD OR JOKER, HAS TO BE length 3
checkRunsThird(Wild, Number, CheckingCard, RestofHand, SingleRun, FinalSingleRun, RunIncrement) :-
										getFirst(RestofHand, FirstofRest, RestofRestOfHand),
													atom_length(FirstofRest, LengthOfRestCard),
													atom_length(FirstofRest, LengthOfRestCard),
													LengthOfRestCard > 2, 
													
													sub_atom(FirstofRest, 1, 1, B, ValueOfRestCard),
													ValueOfRestCard == '9',

													plus(1, RunIncrement, FinalRunIncrement),
													append(SingleRun, [FirstofRest], GoodSingleRun),
													
												checkRunsThird(Wild, Number, CheckingCard, RestofRestOfHand, GoodSingleRun, FinalSingleRun, FinalRunIncrement).


checkRunsThird(Wild, Number, CheckingCard, RestofHand, SingleRun, FinalSingleRun, RunIncrement) :-
										getFirst(RestofHand, FirstofRest, RestofRestOfHand),
													atom_length(FirstofRest, LengthOfRestCard),
													atom_length(FirstofRest, LengthOfRestCard),
													LengthOfRestCard > 2, 
													
													sub_atom(FirstofRest, 1, 1, B, ValueOfRestCard),
													ValueOfRestCard == '5',

													plus(1, RunIncrement, FinalRunIncrement),
													append(SingleRun, [FirstofRest], GoodSingleRun),
													
												checkRunsThird(Wild, Number, CheckingCard, RestofRestOfHand, GoodSingleRun, FinalSingleRun, FinalRunIncrement).

%Check if Single Card length is 2, check if first card length is 2, check if values are good

checkRunsThird(Wild, Number, CheckingCard, RestofHand, SingleRun, FinalSingleRun, RunIncrement) :-
										getFirst(RestofHand, FirstofRest, RestofRestOfHand),
													atom_length(FirstofRest, LengthOfRestCard),
													LengthOfRestCard < 3, 
													atom_length(CheckingCard, LengthOfCheckingCard),
													LengthOfCheckingCard < 3,

													sub_atom(CheckingCard, 0, 1, A, ValueOfChecking),
													sub_atom(FirstofRest, 0, 1, B, ValueOfRestCard),

													
													atom_number(ValueOfChecking, NumberValueOfChecking),
													atom_number(ValueOfRestCard, NumberValueOfRestCard),

													plus(NumberValueOfChecking, RunIncrement, CheckingValueWithIncrement),

													NumberValueOfRestCard =@= CheckingValueWithIncrement,

													sub_atom(CheckingCard, 1, 1, C, SuiteOfChecking),
													sub_atom(FirstofRest, 1, 1, D, SuiteOfRestCard),

											
													SuiteOfChecking = SuiteOfRestCard,

										%			plus(10, RunIncrement, LookingForRunIncrement),

										%			plus(LookingForRunIncrement, NumberValueOfChecking, FinalValueOfChecking),
										%			plus(10, NumberValueOfRestCard, FinalValueOfRestCard),


													plus(1, RunIncrement, FinalRunIncrement),
													append(SingleRun, [FirstofRest], GoodSingleRun),

												
												checkRunsThird(Wild, Number, CheckingCard, RestofRestOfHand, GoodSingleRun, FinalSingleRun, FinalRunIncrement).



%Check if Single Card length is 2, check if first card length is 2, check if values are two apart, check if wild or joker is there, they are

checkRunsThird(Wild, Number, CheckingCard, RestofHand, SingleRun, FinalSingleRun, RunIncrement) :-
										getFirst(RestofHand, FirstofRest, RestofRestOfHand),
													atom_length(FirstofRest, LengthOfRestCard),
													LengthOfRestCard < 3, 
													atom_length(CheckingCard, LengthOfCheckingCard),
													LengthOfCheckingCard < 3,

													sub_atom(CheckingCard, 0, 1, A, ValueOfChecking),
													sub_atom(FirstofRest, 0, 1, B, ValueOfRestCard),

													
													atom_number(ValueOfChecking, NumberValueOfChecking),
													atom_number(ValueOfRestCard, NumberValueOfRestCard),

													plus(1, RunIncrement, NewRunIncrement),
													plus(NumberValueOfChecking, NewRunIncrement, CheckingValueWithIncrement),

													NumberValueOfRestCard =@= CheckingValueWithIncrement,

													sub_atom(CheckingCard, 1, 1, C, SuiteOfChecking),
													sub_atom(FirstofRest, 1, 1, D, SuiteOfRestCard),

											
													SuiteOfChecking = SuiteOfRestCard,



													lastd(RestofHand, PossibleJoker),


													sub_atom(PossibleJoker, 1, 1, E, Joker),
													Joker == '5',
													
													remove(PossibleJoker, RestofHand, LastRestRestOfHand),


													append(SingleRun, [PossibleJoker], GoodSingleRun),
													append(GoodSingleRun, [FirstofRest], LastGoodRun),



										%			plus(10, RunIncrement, LookingForRunIncrement),

										%			plus(LookingForRunIncrement, NumberValueOfChecking, FinalValueOfChecking),
										%			plus(10, NumberValueOfRestCard, FinalValueOfRestCard),


													plus(1, NewRunIncrement, FinalRunIncrement),
													

												
												checkRunsThird(Wild, Number, CheckingCard, LastRestRestOfHand, LastGoodRun, FinalSingleRun, FinalRunIncrement).




checkRunsThird(Wild, Number, CheckingCard, RestofHand, SingleRun, FinalSingleRun, RunIncrement) :-
										getFirst(RestofHand, FirstofRest, RestofRestOfHand),
													atom_length(FirstofRest, LengthOfRestCard),
													LengthOfRestCard < 3, 
													atom_length(CheckingCard, LengthOfCheckingCard),
													LengthOfCheckingCard < 3,

													sub_atom(CheckingCard, 0, 1, A, ValueOfChecking),
													sub_atom(FirstofRest, 0, 1, B, ValueOfRestCard),

													
													atom_number(ValueOfChecking, NumberValueOfChecking),
													atom_number(ValueOfRestCard, NumberValueOfRestCard),

													plus(1, RunIncrement, NewRunIncrement),
													plus(NumberValueOfChecking, NewRunIncrement, CheckingValueWithIncrement),

													NumberValueOfRestCard =@= CheckingValueWithIncrement,

													sub_atom(CheckingCard, 1, 1, C, SuiteOfChecking),
													sub_atom(FirstofRest, 1, 1, D, SuiteOfRestCard),

											
													SuiteOfChecking = SuiteOfRestCard,



													lastd(RestofHand, PossibleWild),


													sub_atom(PossibleWild, 1, 1, E, WildCard),
													WildCard == '9',
													
													remove(PossibleWild, RestofHand, LastRestRestOfHand),


													append(SingleRun, [PossibleWild], GoodSingleRun),
													append(GoodSingleRun, [FirstofRest], LastGoodRun),



													plus(1, NewRunIncrement, FinalRunIncrement),
													

												
												checkRunsThird(Wild, Number, CheckingCard, LastRestRestOfHand, LastGoodRun, FinalSingleRun, FinalRunIncrement).






%Check if Single Card length is 2, check if first card length is 2, check if values are NOT good, if NO WILD OR JOKER, then no good 

checkRunsThird(Wild, Number, CheckingCard, RestofHand, SingleRun, FinalSingleRun, RunIncrement) :-
										getFirst(RestofHand, FirstofRest, RestofRestOfHand),
													atom_length(FirstofRest, LengthOfRestCard),
													LengthOfRestCard < 3, 
													atom_length(CheckingCard, LengthOfCheckingCard),
													LengthOfCheckingCard < 3,

									

												checkRunsThird(Wild, Number, CheckingCard, RestofRestOfHand, SingleRun, FinalSingleRun, RunIncrement).



%Check if Single Card length is 2, check if first card length is 3, check if values are good

checkRunsThird(Wild, Number, CheckingCard, RestofHand, SingleRun, FinalSingleRun, RunIncrement) :-
										getFirst(RestofHand, FirstofRest, RestofRestOfHand),
													atom_length(FirstofRest, LengthOfRestCard),
													LengthOfRestCard > 2, 
													atom_length(CheckingCard, LengthOfCheckingCard),
													LengthOfCheckingCard < 3,

													sub_atom(CheckingCard, 0, 1, A, ValueOfChecking),
													sub_atom(FirstofRest, 1, 1, B, ValueOfRestCard),

												
													atom_number(ValueOfChecking, NumberValueOfChecking),
													atom_number(ValueOfRestCard, NumberValueOfRestCard),

													plus(NumberValueOfChecking, RunIncrement, CheckingValueWithIncrement),
													plus(10, NumberValueOfRestCard, FinalValueOfRestCard),

													FinalValueOfRestCard =@= CheckingValueWithIncrement,



													sub_atom(CheckingCard, 1, 1, C, SuiteOfChecking),
													sub_atom(FirstofRest, 2, 1, D, SuiteOfRestCard),

											
													SuiteOfChecking = SuiteOfRestCard,

										%			plus(10, RunIncrement, LookingForRunIncrement),

										%			plus(LookingForRunIncrement, NumberValueOfChecking, FinalValueOfChecking),
										%			plus(10, NumberValueOfRestCard, FinalValueOfRestCard),

													plus(1, RunIncrement, FinalRunIncrement),

													append(SingleRun, [FirstofRest], GoodSingleRun),
													
												checkRunsThird(Wild, Number, CheckingCard, RestofRestOfHand, GoodSingleRun, FinalSingleRun, FinalRunIncrement).
%Check if Single Card length is 2, check if first card length is 3, check if values are two apart, check if wild or joker is there, they are




checkRunsThird(Wild, Number, CheckingCard, RestofHand, SingleRun, FinalSingleRun, RunIncrement) :-
										getFirst(RestofHand, FirstofRest, RestofRestOfHand),
													atom_length(FirstofRest, LengthOfRestCard),
													LengthOfRestCard > 2, 
													atom_length(CheckingCard, LengthOfCheckingCard),
													LengthOfCheckingCard < 3,

													sub_atom(CheckingCard, 0, 1, A, ValueOfChecking),
													sub_atom(FirstofRest, 1, 1, B, ValueOfRestCard),

													
													atom_number(ValueOfChecking, NumberValueOfChecking),
													atom_number(ValueOfRestCard, NumberValueOfRestCard),

													plus(1, RunIncrement, NewRunIncrement),
													plus(NumberValueOfChecking, NewRunIncrement, CheckingValueWithIncrement),

													plus(10, NumberValueOfRestCard, FinalNumValueRestCard),

													FinalNumValueRestCard =@= CheckingValueWithIncrement,

													sub_atom(CheckingCard, 1, 1, C, SuiteOfChecking),
													sub_atom(FirstofRest, 2, 1, D, SuiteOfRestCard),

											
													SuiteOfChecking = SuiteOfRestCard,



													lastd(RestofHand, PossibleWild),


													sub_atom(PossibleWild, 1, 1, E, WildCard),
													WildCard == '5',
													
													remove(PossibleWild, RestofHand, LastRestRestOfHand),


													append(SingleRun, [PossibleWild], GoodSingleRun),
													append(GoodSingleRun, [FirstofRest], LastGoodRun),



													plus(1, NewRunIncrement, FinalRunIncrement),
													

												
												checkRunsThird(Wild, Number, CheckingCard, LastRestRestOfHand, LastGoodRun, FinalSingleRun, FinalRunIncrement).








checkRunsThird(Wild, Number, CheckingCard, RestofHand, SingleRun, FinalSingleRun, RunIncrement) :-
										getFirst(RestofHand, FirstofRest, RestofRestOfHand),
													atom_length(FirstofRest, LengthOfRestCard),
													LengthOfRestCard > 2, 
													atom_length(CheckingCard, LengthOfCheckingCard),
													LengthOfCheckingCard < 3,

													sub_atom(CheckingCard, 0, 1, A, ValueOfChecking),
													sub_atom(FirstofRest, 1, 1, B, ValueOfRestCard),

													
													atom_number(ValueOfChecking, NumberValueOfChecking),
													atom_number(ValueOfRestCard, NumberValueOfRestCard),

													plus(1, RunIncrement, NewRunIncrement),
													plus(NumberValueOfChecking, NewRunIncrement, CheckingValueWithIncrement),

													plus(10, NumberValueOfRestCard, FinalNumValueRestCard),

													FinalNumValueRestCard =@= CheckingValueWithIncrement,

													sub_atom(CheckingCard, 1, 1, C, SuiteOfChecking),
													sub_atom(FirstofRest, 2, 1, D, SuiteOfRestCard),

											
													SuiteOfChecking = SuiteOfRestCard,



													lastd(RestofHand, PossibleWild),


													sub_atom(PossibleWild, 1, 1, E, WildCard),
													WildCard == '9',
													
													remove(PossibleWild, RestofHand, LastRestRestOfHand),


													append(SingleRun, [PossibleWild], GoodSingleRun),
													append(GoodSingleRun, [FirstofRest], LastGoodRun),



													plus(1, NewRunIncrement, FinalRunIncrement),
													

												
												checkRunsThird(Wild, Number, CheckingCard, LastRestRestOfHand, LastGoodRun, FinalSingleRun, FinalRunIncrement).





%Check if Single Card length is 2, check if first card length is 3, check if values are NOT good, if NO wild or joker is there, then no good

checkRunsThird(Wild, Number, CheckingCard, RestofHand, SingleRun, FinalSingleRun, RunIncrement) :-
										getFirst(RestofHand, FirstofRest, RestofRestOfHand),
													atom_length(FirstofRest, LengthOfRestCard),
													LengthOfRestCard > 2, 
													atom_length(CheckingCard, LengthOfCheckingCard),
													LengthOfCheckingCard < 3,

											

												checkRunsThird(Wild, Number, CheckingCard, RestofRestOfHand, SingleRun, FinalSingleRun, RunIncrement).



%Check if Single Card length is 3, check if first card length is 3, check if values are good

checkRunsThird(Wild, Number, CheckingCard, RestofHand, SingleRun, FinalSingleRun, RunIncrement) :-
										getFirst(RestofHand, FirstofRest, RestofRestOfHand),
													atom_length(FirstofRest, LengthOfRestCard),
													LengthOfRestCard > 2, 
													atom_length(CheckingCard, LengthOfCheckingCard),
													LengthOfCheckingCard > 2,

													sub_atom(CheckingCard, 1, 1, A, ValueOfChecking),
													sub_atom(FirstofRest, 1, 1, B, ValueOfRestCard),

												
													atom_number(ValueOfChecking, NumberValueOfChecking),
													atom_number(ValueOfRestCard, NumberValueOfRestCard),


													plus(NumberValueOfChecking, RunIncrement, CheckingValueWithIncrement),
													plus(10, CheckingValueWithIncrement, FinalCheckValue),
													plus(10, NumberValueOfRestCard, FinalValueOfRestCard),

													FinalValueOfRestCard =@= FinalCheckValue,



													sub_atom(CheckingCard, 2, 1, C, SuiteOfChecking),
													sub_atom(FirstofRest, 2, 1, D, SuiteOfRestCard),

													

													SuiteOfChecking = SuiteOfRestCard,

										%			plus(10, RunIncrement, LookingForRunIncrement),

										%			plus(LookingForRunIncrement, NumberValueOfChecking, FinalValueOfChecking),
										%			plus(10, NumberValueOfRestCard, FinalValueOfRestCard),


													plus(1, RunIncrement, FinalRunIncrement),
													append(SingleRun, [FirstofRest], GoodSingleRun),
													
												checkRunsThird(Wild, Number, CheckingCard, RestofRestOfHand, GoodSingleRun, FinalSingleRun, FinalRunIncrement).


%Check if Single Card length is 3, check if first card length is 3, check if values are two apart, check if wild or joker is there, they are


checkRunsThird(Wild, Number, CheckingCard, RestofHand, SingleRun, FinalSingleRun, RunIncrement) :-
										getFirst(RestofHand, FirstofRest, RestofRestOfHand),
													atom_length(FirstofRest, LengthOfRestCard),
													LengthOfRestCard > 2, 
													atom_length(CheckingCard, LengthOfCheckingCard),
													LengthOfCheckingCard > 2,

													sub_atom(CheckingCard, 1, 1, A, ValueOfChecking),
													sub_atom(FirstofRest, 1, 1, B, ValueOfRestCard),

													
													atom_number(ValueOfChecking, NumberValueOfChecking),
													atom_number(ValueOfRestCard, NumberValueOfRestCard),

													plus(1, RunIncrement, NewRunIncrement),
													plus(NumberValueOfChecking, NewRunIncrement, CheckingValueWithIncrement),

													plus(10, CheckingValueWithIncrement, FinalCheckingValueWithIncrement),
													plus(10, NumberValueOfRestCard, FinalValueOfRestCard),



													FinalValueOfRestCard =@= FinalCheckingValueWithIncrement,

													sub_atom(CheckingCard, 2, 1, C, SuiteOfChecking),
													sub_atom(FirstofRest, 2, 1, D, SuiteOfRestCard),

											
													SuiteOfChecking = SuiteOfRestCard,



													lastd(RestofHand, PossibleWild),


													sub_atom(PossibleWild, 1, 1, E, WildCard),
													WildCard == '5',
													
													remove(PossibleWild, RestofHand, LastRestRestOfHand),


													append(SingleRun, [PossibleWild], GoodSingleRun),
													append(GoodSingleRun, [FirstofRest], LastGoodRun),



													plus(1, NewRunIncrement, FinalRunIncrement),
													

												
												checkRunsThird(Wild, Number, CheckingCard, LastRestRestOfHand, LastGoodRun, FinalSingleRun, FinalRunIncrement).



checkRunsThird(Wild, Number, CheckingCard, RestofHand, SingleRun, FinalSingleRun, RunIncrement) :-
										getFirst(RestofHand, FirstofRest, RestofRestOfHand),
													atom_length(FirstofRest, LengthOfRestCard),
													LengthOfRestCard > 2, 
													atom_length(CheckingCard, LengthOfCheckingCard),
													LengthOfCheckingCard > 2,

													sub_atom(CheckingCard, 1, 1, A, ValueOfChecking),
													sub_atom(FirstofRest, 1, 1, B, ValueOfRestCard),

													
													atom_number(ValueOfChecking, NumberValueOfChecking),
													atom_number(ValueOfRestCard, NumberValueOfRestCard),

													plus(1, RunIncrement, NewRunIncrement),
													plus(NumberValueOfChecking, NewRunIncrement, CheckingValueWithIncrement),

													plus(10, CheckingValueWithIncrement, FinalCheckingValueWithIncrement),
													plus(10, NumberValueOfRestCard, FinalValueOfRestCard),



													FinalValueOfRestCard =@= FinalCheckingValueWithIncrement,

													sub_atom(CheckingCard, 2, 1, C, SuiteOfChecking),
													sub_atom(FirstofRest, 2, 1, D, SuiteOfRestCard),

											
													SuiteOfChecking = SuiteOfRestCard,



													lastd(RestofHand, PossibleWild),


													sub_atom(PossibleWild, 1, 1, E, WildCard),
													WildCard == '9',
													
													remove(PossibleWild, RestofHand, LastRestRestOfHand),


													append(SingleRun, [PossibleWild], GoodSingleRun),
													append(GoodSingleRun, [FirstofRest], LastGoodRun),



													plus(1, NewRunIncrement, FinalRunIncrement),
													

												
												checkRunsThird(Wild, Number, CheckingCard, LastRestRestOfHand, LastGoodRun, FinalSingleRun, FinalRunIncrement).




%Check if Single Card length is 3, check if first card length is 3, check if values are NOT good, if NO wild or joker is there, then no good


checkRunsThird(Wild, Number, CheckingCard, RestofHand, SingleRun, FinalSingleRun, RunIncrement) :-
										getFirst(RestofHand, FirstofRest, RestofRestOfHand),
													atom_length(FirstofRest, LengthOfRestCard),
													LengthOfRestCard > 2, 
													atom_length(CheckingCard, LengthOfCheckingCard),
													LengthOfCheckingCard > 2,

									

												checkRunsThird(Wild, Number, CheckingCard, RestofRestOfHand, SingleRun, FinalSingleRun, RunIncrement).




/* *********************************************************************
Function Name: goOutTest1
Purpose: Returns best possible combination of books and runs as list, with leftover card in first of list
Parameters: wild for round, player's hand, combinations that is all books and runs of hand, wholeList that is all books and runs of hand,
            minimum which is the best combination of books and runs that has least amount of leftover cards
Return Value: best combination of books and runs
Local Variables:
            one branch of checking from possible books and runs when removing first book/run from wholeList
Algorithm:
            1) Call goOutTest2 with first book/run found from wholeList, and removing cards from that book/run from hand.
               2) If the hand has more cards than the wild number, and the best combination returned NIL, 
                  call function again with rest of books/runs from wholeList, and same minimum
                  (This is handling when a player is looking to discard a card, and therefore must have best runs/books return a card to discard.)
               3) If the the goOutTest2 returns leftover cards that is less than current leftover cards minimum, then call function again 
                  with rest of wholeList and new best possible runs/books as minimum.
               4) Else, calls function again with rest of wholeList and same best possible runs/books as minimum.
           5) If all books and runs found from hand are gone, then return best possible runs/books found that has least amount of cards.
********************************************************************* */


goOutTest1(Wild, Hand, WholeList, Minimum, FinalMinimum) :- length(WholeList, 0),
										FinalMinimum = Minimum.



goOutTest1(Wild, Hand, WholeList, Minimum, FinalMinimum) :- getFirst(WholeList, FirstOfWL, RestOfWL),

										removeListFromHand(Hand, FirstOfWL, FinalHand),

										getFirst(Minimum, AAAA, BBBB),
										

										checkBooksFinal(Wild, FinalHand, [], FinalBooks),

										checkRunsFinal(Wild, FinalHand, [], FinalRuns),

										append(FinalRuns, FinalBooks, BooksAndRuns),
										


										goOutTest2(Wild, Hand, FinalHand, BooksAndRuns, [FirstOfWL], Minimum, FinalPossible),

										
										goOutTest1(Wild, Hand, RestOfWL, FinalPossible, FinalMinimum).





/* *********************************************************************
Function Name: goOutTest1
Purpose: Returns a combination of books/runs when beginning with one book/run from goOutTest1
Parameters: wild for round, player's hand, possible that is list of books/runs found when beginning with one book/run from goOutTest1
Return Value: list of leftover cards and all books/runs found from this branch of books/runs
Local Variables:
            booksAndruns that is list of books/runs from hand
Algorithm:
            1) Create list of books/runs from leftover hand
            2) If there are no books/runs found, return list of leftover cards and all books/runs found.
            3) Else, Call function again with first run/book found from booksAndruns, and removing that run/book from hand.                
               4) Else, calls function again with rest of wholeList and same best possible runs/books as minimum.
           5) This function should finally return a list of leftover cards from hand that cannot be placed in books/runs, and books/runs used.
********************************************************************* */
goOutTest2(Wild, OriginalHand, Hand,  NextBooksAndRuns, Possible, OriginalMinimum, FinalPossible) :- 
							length(NextBooksAndRuns, 0),


							append([Hand], Possible, NewPossible),

							getFirst(NewPossible, FirstOfFP, RestOfFP),

							length(FirstOfFP, FPLength),

							getFirst(OriginalMinimum, FirstMinimum, RestMinimum),

							length(OriginalHand, OriginalHandLength),
							
							OriginalHandLength > Wild,

						
							FPLength <1,

					
							FinalPossible = OriginalMinimum.



goOutTest2(Wild, OriginalHand, Hand,  NextBooksAndRuns, Possible, OriginalMinimum, FinalPossible) :- 
						
							length(NextBooksAndRuns, 0),


							append([Hand], Possible, NewPossible),

							getFirst(NewPossible, FirstOfFP, RestOfFP),

							length(FirstOfFP, FPLength),

							getFirst(OriginalMinimum, FirstMinimum, RestMinimum),


						
							length(FirstMinimum, FirstMinimumLength),

							FPLength < FirstMinimumLength,


							FinalPossible = NewPossible.

goOutTest2(Wild, OriginalHand, Hand,  NextBooksAndRuns, Possible, OriginalMinimum, FinalPossible) :-
						
							length(NextBooksAndRuns, 0),

							append([Hand], Possible, NewPossible),




							getFirst(NewPossible, FirstOfFP, RestOfFP),
						
							length(FirstOfFP, FPLength),

							getFirst(OriginalMinimum, FirstMinimum, RestMinimum),



						
							length(FirstMinimum, FirstMinimumLength),

							FPLength >= FirstMinimumLength,


							
							FinalPossible = OriginalMinimum.
							






goOutTest2(Wild, OriginalHand, Hand,  NextBooksAndRuns, Possible, OriginalMinimum, FinalPossible) :- 


							getFirst(NextBooksAndRuns, FirstOfBR, RestOfBR),
							removeListFromHand(Hand, FirstOfBR, FinalHand),

							append([FirstOfBR], Possible, NewPossible),

							checkBooksFinal(Wild, FinalHand, [], FinalBooks),

							checkRunsFinal(Wild, FinalHand, [], FinalRuns),

							append(FinalRuns, FinalBooks, BooksAndRuns),


							
							goOutTest2(Wild, OriginalHand, FinalHand,  BooksAndRuns, NewPossible, OriginalMinimum, FinalPossible).


						
							






%Predicate that shuffle a list (deck)
shuffle(Tin, Tout) :-
  shuffle1(Tin, [], Tout).

  shuffle1([], A, A).
  shuffle1(Tin, A, Tout) :-
    length(Tin, L),
    N is 1 + integer( random(L) ),
    deleteN(N, Elem, Tin, Tx),
    shuffle1(Tx, [Elem|A], Tout).



deleteN(1, H, [H|Z], Z).
deleteN(_, _, [], []) :- !, fail.
deleteN(N, H, [X|Z], [X|Z2]) :-
  NN is N - 1,
  deleteN(NN, H, Z, Z2).


%Predicate that prints out all game info for the round
  printBoard(RoundNumber, ComputerScore, ComputerCards, HumanScore, HumanCards, DrawPile, DiscardPile) :- 

  									writeln('Round: '),
									writeln(RoundNumber),
									writeln(''),
									writeln('Computer Points:'),
									writeln(ComputerScore),
									writeln(''),
									writeln('Computer Hand: '),
									writeln(ComputerCards),
									writeln(''),
									writeln('Human Points: '),
									writeln(HumanScore),
									writeln(''),
									writeln('Human Hand: '),
									writeln(HumanCards),
									writeln(''),
									write('Draw Pile: '),
									write(DrawPile),
									writeln(''),
									writeln(''),
									write('Discard Pile: '),
									write(DiscardPile),
									writeln(''),
									writeln('').
