
;************************************************************
;* Name:  Frank Ryan                                  *
;* Project:  LISP Five Crowns Project           *
;* Class:  CMPS 366 01                       *
;* Date:  10/22/2019                          *
;************************************************************


(in-package :common-graphics-user)

;* *********************************************************************
;Function Name: beginGame
;Purpose: To begin a game, brings user to main screen
;Parameters: none
;Return Value: none
;Local Variables:
;            none
;Algorithm:
;            1) Ask user to start game, load game, or exit game
;            2) Call mainScreen to validate in user input, and mainScreenDecision to decide which option taken
;********************************************************************* *

(defun beginGame()
  (princ "Welcome to Five Crowns!")
  (terpri)
  (princ "Would you like to do?")
  (terpri)
  (princ "1. Start new game.")
  (terpri)
  (princ "2. Load game.")
  (terpri)
  (princ "3. Exit Five Crowns.")	
  (terpri)
   (princ "")
  (mainScreenDecision (mainScreen (read)))
  )


;* *********************************************************************
;Function Name: mainScreen
;Purpose: To validate user main screen input
;Parameters: none
;Return Value: atom of number 1, 2, or 3
;Local Variables:
;            none
;Algorithm:
;            1) Check if the atom is a number and 1,2, or 3. If not, recursive call function.
;            2) If it is, return atom. To be now returned to mainScreenDecision.
;********************************************************************* *
(defun mainScreen(atom)
  (cond (  (and(numberp atom)(or(= atom 1)(= atom 2)(= atom 3)) )
         atom		)		 
        (  t
         (princ "You did not enter 1, 2, or 3. Please try again.")
         (terpri)
         (princ "")
         (mainScreen(read))	))
  )

;* *********************************************************************
;Function Name: mainScreenDecision
;Purpose: To begin a new game, load game, or exit game
;Parameters: atom of a number
;Return Value: function, either startNewGame, startLoadGame, or exitGame
;Local Variables:
;            none
;Algorithm:
;            1) Check if number is 1, 2, or 3 and call function depending on which number.
;********************************************************************* *
(defun mainScreenDecision(atom)
 (cond ( (= atom 1)
         (startNewGame) )
        ( (= atom 2)
         (startLoadGame) )
        ( (= atom 3)
         (exitGame))
        )
  )

;* *********************************************************************
;Function Name: startNewGame
;Purpose: To begin a new game, asks user for coin toss, calls round functions, determines winner from points
;Parameters: none
;Return Value: print line
;Local Variables:
;            bothPoints, a list of humanPoints and computerPoints
;Algorithm:
;            1) Asks user for coin toss selection through function. If human wins, start rounds with human first, else, start computer first.
;            2) After calling functions that go through all rounds, a list of humanPoints and computerPoints is returned.
;            3) Compare humanPoints and computerPoints, and determine winner.
;********************************************************************* *
(defun startNewGame()
  
  (princ "Please call the toss. H for heads and T for tails.")
  (terpri)
  (princ "")
  
  ;Calling function coinToss to determine who won coss toss. If returns 0, then computer won, else, human won.
  ;Calls round function depending on winner of coin. This returns a final list of points, that is then compared to see who won.
  
  (cond ((= (coinToss(userToss (read) )) 0)
         (let* ((bothPoints (startRoundsComputerFirst 1 '(0 0) )) 
                (humanPoints (first bothPoints))
                (computerPoints (first(last bothPoints))))
           (terpri)
           (princ "TOTAL HUMAN POINTS")
           (terpri)
           (princ humanPoints)
           (terpri)
           (princ "TOTAL COMPUTER POINTS")
           (terpri)
           (princ computerPoints)
                (cond ( (< humanPoints computerPoints)
                       (princ "You won"))
                      ( t
                       (princ "You lost"))) ) )   ;computer won
        (t
         (let* ((bothPoints (startRoundsHumanFirst 1 '(0 0)  )) 
                (humanPoints (first bothPoints))
                (computerPoints (first(last bothPoints))))
           (terpri)
           (princ "TOTAL HUMAN POINTS")
           (terpri)
           (princ humanPoints)
           (terpri)
           (princ "TOTAL COMPUTER POINTS")
           (terpri)
           (princ computerPoints)
                (cond ( (< humanPoints computerPoints)
                       (princ "You won"))
                      ( t
                       (princ "You lost"))) ) );human won
        )

  
  
  
  )
    

;* *********************************************************************
;Function Name: startLoadGame
;Purpose: To begin a loaded game by parsing text file
;Parameters: none
;Return Value: none
;Local Variables:
;            all lines of text file
;Algorithm:
;            1) Ask user for loaded text file
;            2) Stores all lines of text file. Passes the needed lines into a function called beginLoadedGame to start game.
;********************************************************************* *
(defun startLoadGame()
  
  (terpri)
  (princ "Please enter a file to load.")
  (terpri)
  (princ "(Please put quotations around it")
  (terpri)
  (princ "")
  (with-open-file (file (read))
    
    (let* (          
           (line1 (read-line file))
           (line2 (read-line file))
           (line3 (read-line file))
           (line4 (read-line file))
           (line5 (read-line file))
           (line6 (read-line file))
           (line7 (read-line file))
           (line8 (read-line file))
           (line9 (read-line file))
           (line10 (read-line file))
           (line11 (read-line file))
           (line12 (read-line file))
           (line13 (read-line file))
           (line14 (read-line file))
           (line15 (read-line file))
           (line16 (read-line file))
           (line17 (read-line file))
           (line18 (read-line file))
           (line19 (read-line file))
           (line20 (read-line file))
           (line21 (read-line file))
           (line22 (read-line file))
           (line23 (read-line file))
           (line24 (read-line file))
           (line25 (read-line file))
           
           
           (round (first (list (read-from-string line3))))
           (computerPoints (first (list (read-from-string line6))))
           (humanPoints (first (list (read-from-string line12))))
           
           (computerCards (first (list (read-from-string line9))))
           (humanCards (first (list (read-from-string line15))))
           (drawPile (first (list (read-from-string line18))))
           (discardPile (first (list (read-from-string line21))))
           
           (nextPlayer (first (list (read-from-string line24))))
           
           
           
           
           
           )
      
      
      
      
      
      ;calls function beginLoadedGame with needed game values.
      
      (beginLoadedGame round computerPoints humanPoints computerCards humanCards drawPile discardPile nextPlayer)
      
      )
    
      
    )
   
  

)

;* *********************************************************************
;Function Name: beginLoadedGame
;Purpose: To begin a loaded game with all values needed, similar to startNewGame. Determines winner after all rounds called. 
;Parameters: round as atom, computerPoints as atom, humanPoints as atom, and computerCards, humanCards, drawPile, discardPile, and nextPlayer as list.
;Return Value: print line
;Local Variables:
;            bothPoints that is final points of game
;Algorithm:
;            1) Starts loaded game based off who goes first.
;            2) Calls round functions that go through all rounds. Seperates final list as points and determines winner.
;********************************************************************* *
(defun beginLoadedGame(round computerPoints humanPoints computerCards humanCards drawPile discardPile nextPlayer)
  
  (cond ((eq nextPlayer 'COMPUTER)
         (let* ((bothPoints (startLoadedComputerRoundsFirst round computerCards humanCards drawPile discardPile (list humanPoints computerPoints) )) 
                (humanTotalPoints (first bothPoints))
                (computerTotalPoints (first(last bothPoints))))
           (terpri)
           (princ "TOTAL HUMAN POINTS")
           (terpri)
           (princ humanTotalPoints)
           (terpri)
           (princ "TOTAL COMPUTER POINTS")
           (terpri)
           (princ computerTotalPoints)
                (cond ( (< humanTotalPoints computerTotalPoints)
                       (princ "You won"))
                      ( t
                       (princ "You lost"))) ) )   ;computer won
        (t
         (let* ((bothPoints (startLoadedHumanRoundsFirst round computerCards humanCards drawPile discardPile (list humanPoints computerPoints)  )) 
                (humanTotalPoints (first bothPoints))
                (computerTotalPoints (first(last bothPoints))))
           (terpri)
           (princ "TOTAL HUMAN POINTS")
           (terpri)
           (princ humanTotalPoints)
           (terpri)
           (princ "TOTAL COMPUTER POINTS")
           (terpri)
           (princ computerTotalPoints)
                (cond ( (< humanTotalPoints computerTotalPoints)
                       (princ "You won"))
                      ( t
                       (princ "You lost"))) ) );human won
        )
  
  )


;* *********************************************************************
;Function Name: startLoadedComputerRoundsFirst
;Purpose: To begin the first round of a loaded game, and then call function to continue all rounds.
;Parameters: round as atom, and computerCards, humanCards, drawPile, discardPile, and points as list
;Return Value: calling function to resume all rounds after first round.
;Local Variables:
;            score for initial round
;Algorithm:
;            1) Begins first round by calling computerLoadedFirstRounds
;            2) Seperates list returned that obtains finalPoints for round. If the first scoreForRound is 0, then the human lost the round. Else, the computer lost the round.
;            3) Adds points to player who lost, and calls round functions to go through rest of game.
;********************************************************************* *
(defun startLoadedComputerRoundsFirst(round computerCards humanCards drawPile discardPile vector)
  
  
   (cond ( (= round 12)
         vector);exit game over
        ( t
         (let* ((scoreForRound (computerLoadedFirstRounds (+ round 2) computerCards humanCards drawPile discardPile vector)  ))
           
           (cond (  (eq (first scoreForRound) '0)
               
                  (startRoundsComputerFirst (+ round 1)(list (+ (second scoreForRound) (first vector))(second vector) ) ) 
                  )
                 ( (eq (first scoreForRound) '1)
                 
                  (startRoundsHumanFirst (+ round 1)(list (first vector)(+ (second scoreForRound) (second vector)) ) )  )   )
           
           
           )
         
         
         ) )  
  
  )

;* *********************************************************************
;Function Name: startLoadedHumanRoundsFirst
;Purpose: To begin the first round of a loaded game, and then call function to continue all rounds. Similar to startLoadedComputerRoundsFirst.
;Parameters: round as atom, and computerCards, humanCards, drawPile, discardPile, and points as list
;Return Value: calling function to resume all rounds after first round.
;Local Variables:
;            score for initial round
;Algorithm:
;            1) Begins first round by calling humanLoadedFirstRounds
;            2) Seperates list returned that obtains finalPoints for round. If the first scoreForRound is 0, then the human lost the round. Else, the computer lost the round.
;            3) Adds points to player who lost, and calls round functions to go through rest of game.
;********************************************************************* *
(defun startLoadedHumanRoundsFirst(round computerCards humanCards drawPile discardPile vector)
  
 
  (cond ( (= round 12)
         vector);exit game over
        (t
         (let* ((scoreForRound (humanLoadedFirstRounds (+ round 2) computerCards humanCards drawPile discardPile vector) ))
            
           (cond (  (eq (first scoreForRound) '0)
                  
                  (startRoundsComputerFirst (+ round 1)(list (+ (second scoreForRound) (first vector))(second vector) ) ) 
                  )
                 ( (eq (first scoreForRound) '1)
                  
                  (startRoundsHumanFirst (+ round 1)(list (first vector)(+ (second scoreForRound) (second vector)) ) )  )   )
           
           
           )  )
          )
  

 
  )

;* *********************************************************************
;Function Name: computerLoadedFirstRounds
;Purpose: To begin the round where computer plays first. Calls function to begin round.
;Parameters: round as atom, and computerCards, humanCards, drawPile, discardPile, and points as list
;Return Value: list that obtains losers points to add
;Local Variables:
;            humanPoints and computerPoints 
;Algorithm:
;            1) Calls function to begin round with values.
;********************************************************************* *
(defun computerLoadedFirstRounds(round computerCards humanCards drawPile discardPile vector)
  
  (let* ((humanPoints (first vector))
         (computerPoints (first(rest vector)))
        
         ) 
    
    (computerFirstTurns round humanCards computerCards  drawPile discardPile humanPoints computerPoints)
    
   
    )
  
  )

;* *********************************************************************
;Function Name: humanLoadedFirstRounds
;Purpose: To begin the round where human plays first. Calls function to begin round.
;Parameters: round as atom, and computerCards, humanCards, drawPile, discardPile, and points as list
;Return Value: list that obtains losers points to add
;Local Variables:
;            humanPoints and computerPoints 
;Algorithm:
;            1) Calls function to begin round with values.
;********************************************************************* *
(defun humanLoadedFirstRounds(round computerCards humanCards drawPile discardPile vector)
  
  (let* ((humanPoints (first vector))
         (computerPoints (first(rest vector)))
         
         ) 
    (princ (first discardPile))
    
    (humanFirstTurns round humanCards computerCards  drawPile discardPile humanPoints computerPoints)
    
   
    )
  
  )




  
  









;* *********************************************************************
;Function Name: exitGame
;Purpose: To exit game
;Parameters: none
;Return Value: none
;Local Variables:
;            none
;Algorithm:
;            1) exits game.
;********************************************************************* *
(defun exitGame()
  
  :exit
  
  
  )

(defun createDeck()
  (list '3C '3T '3H '3S '3D '4C '4T '4H '4S '4D '5C '5T '5H '5S '5D '6C '6T '6H '6S '6D '7C '7T '7H
        '7S '7D '8C '8T '8H '8S '8D '9C '9T '9H '9S '9D 'XC 'XT 'XH 'XS 'XD 'JC 'JT 'JH 'JS 'JD 'QC 'QT 'QH 'QS 'QD
         'KC 'KT 'KH 'KS 'KD 'J1 'J2 'J3 '3C '3T '3H '3S '3D '4C '4T '4H '4S '4D '5C '5T '5H '5S '5D '6C '6T '6H '6S '6D '7C '7T '7H
        '7S '7D '8C '8T '8H '8S '8D '9C '9T '9H '9S '9D 'XC 'XT 'XH 'XS 'XD 'JC 'JT 'JH 'JS 'JD 'QC 'QT 'QH 'QS 'QD
         'KC 'KT 'KH 'KS 'KD 'J1 'J2 'J3) 
  

  )



;* *********************************************************************
;Function Name: userToss
;Purpose: To validate user coin toss input
;Parameters: vector that is the user's input
;Return Value: inputted vector
;Local Variables:
;            none 
;Algorithm:
;            1) Validate if input is either H or T. If not, recursively call with new input.
;********************************************************************* *
(defun userToss(vector)
  
  (cond (  (or(eq vector 'H)(eq vector 'T)) 
         		vector )		 
        (  t
         (princ "You did not enter H or T. Please try again.")
         (terpri)
         (princ "")
         (userToss(read))	) )
  )

  
  
  

;* *********************************************************************
;Function Name: coinToss
;Purpose: Determines winner of coin toss
;Parameters: vector that is user's input for coin toss
;Return Value: print line
;Local Variables:
;            random number out of 1 and 0 
;Algorithm:
;            1) The random number 0 is tails, and the random number 1 is heads. Compare random number and user's input to see who won.
;********************************************************************* *
(defun coinToss(vector)
  
  
  
  (let* ((randonNumber (random 2)))
  (cond ( (and(= randonNumber 0)(eq vector 'T))
         (princ "The Random Number was 0. The human called tails. The human won the coss toss.")
          '1)
        ( (and(= randonNumber 1)(eq vector 'H))
         (princ "The Random Number was 1. The human called heads. The human won the coss toss.")
         '1)
        ( (and(= randonNumber 0)(eq vector 'H))
         (princ "The Random Number was 0. The human called heads. The computer won the coss toss.")
         '0)
        ( (and(= randonNumber 1)(eq vector 'T))
         (princ "The Random Number was 1. The human called tails. The computer won the coss toss.")
         '0)
        ))
  
  
  )




;* *********************************************************************
;Function Name: startRoundsComputerFirst
;Purpose: To go through all rounds of game, while adding points every round.
;Parameters: number for round and vector of points
;Return Value: vector of final points.
;Local Variables:
;            scoreForRound
;Algorithm:
;            1) Call function computerFirstRounds because computer goes first. Determines who won the round, if the returned value is 0, then the human lost.
;            2) Add points to loser of round, and recursive call function with new round and updated points.
;            3) Return vector of points when all rounds are over.
;********************************************************************* *
(defun startRoundsComputerFirst(number vector)
  
   
  (cond ( (= number 12)
         vector);exit game over
        ( t
         (let* ((scoreForRound (computerFirstRounds (+ number 2) vector)  ))
           
           (cond (  (eq (first scoreForRound) '0)
               
                  (startRoundsComputerFirst (+ number 1)(list (+ (second scoreForRound) (first vector))(second vector) ) ) 
                  )
                 ( (eq (first scoreForRound) '1)
                 
                  (startRoundsHumanFirst (+ number 1)(list (first vector)(+ (second scoreForRound) (second vector)) ) )  )   )
           
           
           )
         
         
         ) )  
  
  )


;* *********************************************************************
;Function Name: startRoundsHumanFirst
;Purpose: To go through all rounds of game, while adding points every round.
;Parameters: number for round and vector of points
;Return Value: vector of final points.
;Local Variables:
;            scoreForRound
;Algorithm:
;            1) Call function humanFirstRounds because human goes first. Determines who won the round, if the returned value is 0, then the human lost.
;            2) Add points to loser of round, and recursive call function with new round and updated points.
;            3) Return vector of points when all rounds are over.
;********************************************************************* *
(defun startRoundsHumanFirst(number vector)
  
 
  (cond ( (= number 12)
         vector);exit game over
        (t
         (let* ((scoreForRound (humanFirstRounds (+ number 2) vector) ))
            
           (cond (  (eq (first scoreForRound) '0)
                  
                  (startRoundsComputerFirst (+ number 1)(list (+ (second scoreForRound) (first vector))(second vector) ) ) 
                  )
                 ( (eq (first scoreForRound) '1)
                  
                  (startRoundsHumanFirst (+ number 1)(list (first vector)(+ (second scoreForRound) (second vector)) ) )  )   )
           
           
           )  )
          )
  

 
  )


;* *********************************************************************
;Function Name: computerFirstRounds
;Purpose: To deal out cards and begin a round of the game.
;Parameters: number for round and vector for points.
;Return Value: list of points.
;Local Variables:
;            scoreForRound
;Algorithm:
;            1) Call function createDeck to make all cards and dealCards to give cards to all piles and hands. 
;            2) Calls computerFirstTurns because computer goes first, with all values needed.
;********************************************************************* *
(defun computerFirstRounds(number vector)
  
  ;Gives value to all aspects of game
  (let* ((humanPoints (first vector))
         (computerPoints (first(rest vector)))
         (deck (createDeck))
         (humanCards (dealCards number () deck))
         (computerCards (dealCards number () (first (rest humanCards))))
         (discardPile (dealCards 1 () (first (rest computerCards))))
         (drawPile (first (rest discardPile)))
         ) 
    
    (computerFirstTurns number  (first humanCards) (first computerCards)  drawPile (first discardPile) humanPoints computerPoints)
    
   
    )
  
  )


;* *********************************************************************
;Function Name: humanFirstRounds
;Purpose: To deal out cards and begin a round of the game.
;Parameters: number for round and vector for points.
;Return Value: list of points.
;Local Variables:
;            scoreForRound
;Algorithm:
;            1) Call function createDeck to make all cards and dealCards to give cards to all piles and hands. 
;            2) Calls humanFirstTurns because human goes first, with all values needed.
;********************************************************************* *
(defun humanFirstRounds(number vector)
  
  (let* ((humanPoints (first vector))
         (computerPoints (first(rest vector)))
         (deck (createDeck))
         (humanCards (dealCards number () deck))
         (computerCards (dealCards number () (first (rest humanCards))))
         (discardPile (dealCards 1 () (first (rest computerCards))))
         (drawPile (first (rest discardPile)))
         ) 
    
    (humanFirstTurns number  (first humanCards) (first computerCards)  drawPile (first discardPile) humanPoints computerPoints)
    
   
    )
  
  )


;* *********************************************************************
;Function Name: dealCards
;Purpose: To deal cards to vector1 from cards of vector2, based off number of round
;Parameters: number for round, vector1 for hand/pile, vector2 for deck
;Return Value: list of pile/hand and rest of deck
;Local Variables:
;            none
;Algorithm:
;            1) If number is not 0, then deal out first card from deck to hand/pile. Once all cards are dealt, return both pile/hand and deck.
;********************************************************************* *
(defun dealCards(number vector1 vector2)
  
  
  (cond ( (= number 0)
         (list vector1 vector2))
        ( t
         (cond ( (eq vector1 ())
               
                (dealCards (- number 1) (list (first vector2)) (rest vector2)))
               ( t

                (dealCards (- number 1) (append vector1 (list (first vector2))) (rest vector2))))
                           ) )
  
  )


;* *********************************************************************
;Function Name: humanFirstTurns
;Purpose: To go through a single round. If a player does not go out, then the function is called again with updated values.
;Parameters: all values of game, all as lists except points and wild for round, which are atoms
;Return Value: list of points of loser to be added.
;Local Variables:
;            after human turn values of game, and after computer turns values of game.
;Algorithm:
;            1) Prints game board. Calls function startHumanTurn
;            2) If the human went out, then startComputerLastTurn is called, where a list of computer final points is returned.
;            3) If not, then calls function startComputerTurn. If it goes out, then startHumanLastTurn is called, where a list of human final points is returned.
;            4) If no one goes out, then function called recursively with new values of game.
;********************************************************************* *
(defun humanFirstTurns(wild humanCards computerCards drawPile discardPile humanPoints computerPoints)
  
  (terpri)
  (princ "Round:" )
  (terpri)
  (princ (- wild 2))
  (terpri)
  (terpri)
  (princ "Computer Score:")
  (terpri)
  (princ computerPoints)
  (terpri) 
  (terpri)
  (princ "Computer Hand:")
  (terpri)
  (princ computerCards)
  (terpri)
  (terpri)
  (princ "Human Score:")
  (terpri)
  (princ humanPoints)
  (terpri)
  (terpri)
  (princ "Human Hand:")
  (terpri)
  (princ humanCards)
  (terpri)
  (terpri)
  (princ "Draw Pile:")
  (terpri)
  (princ drawPile)
  (terpri)
  (terpri)
  (princ "Discard Pile:")
  (terpri)
  (princ discardPile)
  (terpri)
  
 
 
  
  ;Starts human turn through function call, seperates values of new game board.
  (let* ((afterHumanTurn (startHumanTurn wild humanCards computerCards drawPile discardPile humanPoints computerPoints)) 
         (newHumanHand (first afterHumanTurn))
         (newDrawPile (first(rest afterHumanTurn)))
         (newDiscardPile (first (rest (rest afterHumanTurn)))) )
    
    ;If the last of startHumanTurn returns 1, then the human went out, and calls function to begin computer last turn, which returns points of computer.
    (cond ( (= (first (last afterHumanTurn)) 1)
           
           (let* ((finalBoard (startComputerLastTurn wild computerCards newDrawPile newDiscardPile)))
             
                      (list 1 (fourth finalBoard) ) 
                    ) 
           
           ) 
          ( t
           
         
          ;If the human did not go out, then computer begins regular turn, seperates values of new game board.
           (let* ((afterComputerTurn (startComputerTurn wild computerCards newDrawPile newDiscardPile)) 
                  (newComputerHand (first afterComputerTurn))
                  (newDrawPile2 (second afterComputerTurn))
                  (newDiscardPile2 (third afterComputerTurn)) )
             
             ;If the last of computer turn returns 1, it went out, and calls function to begin human last turn, which returns his points.
             (cond ( (= (first (last afterComputerTurn)) 1)
                    (let* ((finalBoard (startHumanLastTurn wild newHumanHand newDrawPile2 newDiscardPile2)))
                     
                      (list 0 (fourth finalBoard) ) )
                    )          
                   ( t
                    
                    ;If no one went out, then the function is called recursively with updated game board.
                    (humanFirstTurns wild newHumanHand newComputerHand newDrawPile2 newDiscardPile2 humanPoints computerPoints)  
                    )
                ) ) ) ) )
                 
  
  )


;* *********************************************************************
;Function Name: computerFirstTurns
;Purpose: To go through a single round where computer goes first. If a player does not go out, then the function is called again with updated values.
;Parameters: all values of game, all as lists except points and wild for round, which are atoms
;Return Value: list of points of loser to be added.
;Local Variables:
;            after human turn values of game, and after computer turns values of game.
;Algorithm:
;            1) Prints game board. Calls function startComputerTurn
;            2) If the computer went out, then startHumanLastTurn is called, where a list of human final points is returned.
;            3) If not, then calls function startHumanTurn. If it goes out, then startComputerLastTurn is called, where a list of computer final points is returned.
;            4) If no one goes out, then function called recursively with new values of game.
;********************************************************************* *
(defun computerFirstTurns(wild humanCards computerCards drawPile discardPile humanPoints computerPoints)
  
  (terpri)
  (princ "Round:" )
  (terpri)
  (princ (- wild 2))
  (terpri)
  (terpri)
  (princ "Computer Score:")
  (terpri)
  (princ computerPoints)
  (terpri) 
  (terpri)
  (princ "Computer Hand:")
  (terpri)
  (princ computerCards)
  (terpri)
  (terpri)
  (princ "Human Score:")
  (terpri)
  (princ humanPoints)
  (terpri)
  (terpri)
  (princ "Human Hand:")
  (terpri)
  (princ humanCards)
  (terpri)
  (terpri)
  (princ "Draw Pile:")
  (terpri)
  (princ drawPile)
  (terpri)
  (terpri)
  (princ "Discard Pile:")
  (terpri)
  (princ discardPile)
  (terpri)
  
 
 
  
  
  ;Calls computer turn, seperates all new game board values.
  (let* ((afterComputerTurn (startComputerTurn wild computerCards drawPile discardPile)) 
                  (newComputerHand (first afterComputerTurn))
                  (newDrawPile (second afterComputerTurn))
         (newDiscardPile (third afterComputerTurn)) )
    (terpri)
    (princ "New Draw Pile:")
    (terpri)
    (princ newDrawPile)
    (terpri)
    (terpri)
    (princ "New Discard Pile:")
    (terpri)
    (princ newDiscardPile)
    (terpri)
    (terpri)
    
    ;Checks if the computer went out. If he did, then last turn of human is called and returns his points.
    (cond ( (= (first (last afterComputerTurn)) 1)
           
           (let* ((finalBoard (startHumanLastTurn wild humanCards newDrawPile newDiscardPile)))
           
                      (list 0 (fourth finalBoard) )      
                     )
           ) 
          ( t
           
           ;Calls human turn, seperates all new game board values.
           (let* ((afterHumanTurn (startHumanTurn wild humanCards newComputerHand newDrawPile newDiscardPile humanPoints computerPoints)) 
                  (newHumanHand (first afterHumanTurn))
                  (newDrawPile2 (first(rest afterHumanTurn)))
                  (newDiscardPile2 (first (rest (rest afterHumanTurn)))) )
             
             ;Checks if human went out. If he did, then last turn of computer is called and returns its points.
             (cond ( (= (first (last afterHumanTurn)) 1)
                    (let* ((finalBoard (startComputerLastTurn wild newComputerHand newDrawPile2 newDiscardPile2)))
                      
                      (list 1 (fourth finalBoard) ) )     
                     )
                   ( t
                    
                    ;If no one went out, recursivley call function with new game board values.
                    (computerFirstTurns wild newHumanHand newComputerHand newDrawPile2 newDiscardPile2 humanPoints computerPoints)  
                    )
                ) ) ) ) ) 
                 
  
  )
   
   
   
   
  
  
  
    

;* *********************************************************************
;Function Name: startHumanTurn
;Purpose: To go through a human's regular turn.
;Parameters: all values of game, all as lists except points and wild for round, which are atoms
;Return Value: If saving file, return exit. If making move, call makeHumanMoveValidation. If help, then print line. If exit, then exit.
;Local Variables:
;            read value, text file
;Algorithm:
;            1) If human saves, create save file and exit.
;            2) If human makes move, then call makeHumanMoveValidation function.
;            3) If human asks for help, then print help and recursively call function.
;            4) If human exits, exit game.
;            5) If the human did not enter 1,2,3, or 4, recursively call function.
;********************************************************************* *
(defun startHumanTurn(wild humanCards computerCards drawPile discardPile humanPoints computerPoints)
  
  (princ "What would you like to do?")
  (terpri)
  (princ "1. Save the game.")
  (terpri)
  (princ "2. Make a move.")
  (terpri)
  (princ "3. Ask for help.")
  (terpri)
  (princ "4. Exit the game.")
  (terpri)
  (princ "")
  
  (let* ((decision (read) )) 
    (cond ( (and(numberp decision)(= decision 1))
           (terpri)
           (princ "Please enter the file name to save to. (Please put whole directory and quotations around it.)")
           (terpri)
           (let* ((stream (open (read) :direction :output :if-exists :supersede)))
             (write-line "(" stream)
             (write-line "   Round:" stream)
             (write-string "   " stream)
             
             (write-line (write-to-string (- wild 2)) stream)
             (write-line " " stream)
             
             (write-line "   Computer Score:" stream)
             (write-string "   " stream)
             (write-line (write-to-string computerPoints) stream)
             (write-line " " stream)
             (write-line "   Computer Hand:" stream)
             (write-string "   " stream)
             (write-line (write-to-string computerCards) stream)
             (write-line " " stream)
             (write-line "   Human Score" stream)
             (write-string "   " stream)
             (write-line (write-to-string humanPoints) stream)
             (write-line " " stream)
             (write-line "   Human Hand:" stream)
             (write-string "   " stream)
             (write-line (write-to-string humanCards) stream)
             (write-line " " stream)
             (write-line "   Draw Pile:" stream)
             (write-string "   " stream)
             (write-line (write-to-string drawPile) stream)
             (write-line " " stream)
             (write-line "   Discard Pile:" stream)
             (write-string "   " stream)
             (write-line (write-to-string discardPile) stream)
             (write-line " " stream)
             (write-line "   Next Player:" stream)
             (write-line "   Human" stream)
             (write-line ")" stream)
 
             (close stream))
           
           (exit 0 :no-unwind t)
           )
          
          ;Calls function for making move validation
          ( (and(numberp decision)(= decision 2)) 
           (makeHumanMoveValidation wild humanCards drawPile discardPile))
          
          ;calls help function for making move. recursively call function.
          ( (and(numberp decision)(= decision 3))
                 
                 
               (askForHelpPicking wild humanCards discardPile)  
               (startHumanTurn wild humanCards computerCards drawPile discardPile humanPoints computerPoints)  
           )
          ( (and(numberp decision)(= decision 4))
           (exit 0 :no-unwind t) )
          ( t
           (princ "Please enter 1, 2, 3, or 4.")
          (startHumanTurn wild humanCards computerCards drawPile discardPile humanPoints computerPoints) )) )
  
  
  
  )

;* *********************************************************************
;Function Name: makeHumanMoveValidation
;Purpose: Asks user to pick from draw or discard, and validates it.
;Parameters: all values of game, all as lists except wild for round, which is atom
;Return Value: makingDiscardMove function.
;Local Variables:
;            none
;Algorithm:
;            1) Validates human move input. 
;            2) If user draws from pile, then create new draw pile and new human hand.
;            3) If user picks from discard, then create new discard pile and new human hand.
;            4) Call function makingDiscardMove for discarding a card.
;********************************************************************* *
(defun makeHumanMoveValidation(wild humanCards drawPile discardPile)
  
  (princ "What would you like to do?")
  (terpri)
  (princ "1. Pick from draw pile.")
  (terpri)
  (princ "2. Pick from discard pile.")
  (terpri)
  (princ "")
  
  
  ;Creating new pile and human hand depending on input.
  ;Calls function makingDiscardMove to find what to discard.
   (let* ((decision (read) )) 
    (cond ( (and(numberp decision)(= decision 1)) 
           (princ "You picked from the draw pile.")
           (let* ((newHumanCards (append humanCards (list (first drawPile)))) 
                  (newDrawPile (rest drawPile)) )
             (makingDiscardMove wild newHumanCards newDrawPile discardPile))
          
           )
          ( (and(numberp decision)(= decision 2) )
           (princ "You picked from the discard pile.")
           (let* ((newHumanCards (append humanCards (list (first discardpile)))) 
                  (newDiscardPile (rest discardpile)) )
             
             (makingDiscardMove wild newHumanCards drawPile newDiscardPile))
           ) 
          ( t
           (princ "Please enter 1 or 2.")
          (makeHumanMoveValidation wild humanCards drawPile discardPile) )) )



  )

;* *********************************************************************
;Function Name: makingDiscardMove
;Purpose: See if the user wants to ask for help discarding or just wants to discard.
;Parameters: all values of game, all as lists except wild for round, which is atom
;Return Value: function makingDiscardValidation
;Local Variables:
;            none
;Algorithm:
;            1) If user asks for help, call function to ask for help discarding and print line it, then recursive call.
;            2) If user asks to discard, call makeDiscardValidation to discard.
;********************************************************************* *
(defun makingDiscardMove(wild humanCards drawPile discardpile)
  
  (terpri)
  (princ "New Human Hand: ")
  (princ humanCards)
  (terpri)
  (terpri)
  (princ "What would you like to do")
  (terpri)
  (princ "1. Ask for help discarding.")
  (terpri)
  (princ "2. Discard a card.")
  (terpri)
  (princ "")
  
  (let* ((decision (read) )) 
    (cond ( (and(numberp decision)(= decision 1)) 
           
           (askForHelpDiscarding wild humanCards)
          (makingDiscardMove wild humanCards drawPile discardpile)
           )
          ( (and(numberp decision)(= decision 2) )
           (makeDiscardValidation wild humanCards drawPile discardpile)
           ) 
          ( t
           (princ "Please enter 1 or 2.")
          (makingDiscardMove wild humanCards drawPile discardpile) )) )
  
  
  
  
  )


;* *********************************************************************
;Function Name: makeDiscardValidation
;Purpose: Validate user discard selection.
;Parameters: all values of game, all as lists except wild for round, which is atom
;Return Value: function goOutDecision
;Local Variables:
;            none
;Algorithm:
;            1) See is discard selection is in user hand, if not, recursive call.
;            2) If it is in hand, remove from hand and call goOutDecision.
;********************************************************************* *
(defun makeDiscardValidation(wild humanCards drawPile discardpile)
  
  (princ "Please enter the card you would like to discard. Ex. 4H or 9C")
  (terpri)
  (princ "")
  
  (let* ((decision (read) )) 
    (cond ( (find decision humanCards)
           (goOutDecision wild (remove decision humanCards :count 1) drawPile (cons decision discardpile) 0)
           )
          ( t
           (princ "This value was not in your hand. ")
           (makeDiscardValidation wild humanCards drawPile discardpile))) )
  
  
  )


;* *********************************************************************
;Function Name: goOutDecision
;Purpose: See if user wants to try to go out.
;Parameters: all values of game, all as lists except wild for round, which is atom
;Return Value: function afterDiscard if wants to go out, else, returns list of new values with winningCondition =0, as the human did not go out.
;Local Variables:
;            none
;Algorithm:
;            1) See is user wants to go out. If he does, then call function afterDiscard.
;            2) If not, then return list of new game board and winningCondition = 0
;********************************************************************* *
(defun goOutDecision(wild humanHand drawPile discardPile winningCondition)
  
  (terpri)
  (princ "Final Human Hand: ")
  (princ humanHand)
  (terpri)
  (terpri)
  (princ "Would you like to see if you can go out with your hand?")
  (terpri)
  (princ "1. Yes.")
  (terpri)
  (princ "2. No.")
  (terpri)
  (princ "")
  
  (let* ((decision (read) )) 
    (cond ( (and(numberp decision)(= decision 1))
           
           (afterDiscard wild humanHand drawPile discardPile 0)
           )
          ( (and(numberp decision)(= decision 2) )
           (list humanHand drawPile discardpile 0) )
          ( t
           (princ "Please enter either 1 or 2. ")
           (goOutDecision wild humanHand drawPile discardPile winningCondition)) )
  
    


         )
  
  )


;* *********************************************************************
;Function Name: afterDiscard
;Purpose: Check if the user can go out by calling function goOutTest1
;Parameters: all values of game, all as lists except wild for round, which is atom, and winningCondition which is 0
;Return Value: function goOutDecision
;Local Variables:
;            nullList, nullCards with is a default value of cards, sortedHand which sorts player's hand, and checkOut which is best combination of player's books/runs.
;Algorithm:
;            1) Call function checkOut with a sorted user's hand and default values. This returns the best combination of runs/books.
;            2) If the first value of checkOut is NIL, then the player used all cards in books/runs.
;               3) Returns new game board with winningCondtion = 1, as the player has went out.
;            4) If not NIL, then the player cannot go out, and returns new game board and winning condition = 0.
;********************************************************************* *
(defun afterDiscard(wild humanHand drawPile discardPile winningCondition)
  
  
  
  (let* (
                 
         (nullList ())
         (nullCards (list '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 (1))) )
         (sortedHand (sortHand wild (sort (cardToNumber humanHand ()) #'string-lessp) ()))
            
         (checkOut (goOutTest1 wild sortedHand () (append (checkRuns1 wild sortedHand nullList)(checkBooks1 wild sortedHand nullList)) nullCards)))
    
    ;If checkOut has NIL in first, then user used all cards in books/runs.
    (cond ( (eq (first checkOut) NIL)
           (princ "YOU CAN GO OUT WITH THESE CARDS!")
           (terpri)
           (princ "These are your books/runs!")
           (terpri)
           
           (princ (finalCardTranslate (first (rest checkOut)) ()) )
           (terpri)
           (list humanHand drawPile discardpile 1))
          ( t
           (princ "You cannot go out with your hand. Ending your turn.")
           (terpri)
          (list humanHand drawPile discardpile 0))
    
    


         )
  
  
  
    )
  )


;* *********************************************************************
;Function Name: askForHelpPicking
;Purpose: asks computer help for picking card
;Parameters: wild for round, list of hand, and discard pile list
;Return Value: print line
;Local Variables:
;            default values for goOutTest1, discardPickCheck that finds best combination of books/runs when discard is placed in hand.
;            currentCheck that finds best combination of books/runs of initial hand.
;Algorithm:
;            1) If adding the discard card creates a combiantion of books/runs that has less leftover cards than intial hand combination, then recommend to pick from discard.
;            2) If not, then recommend to pick from draw.
;********************************************************************* *
(defun askForHelpPicking(wild hand discardPile)
  
  
  ;Sorting hands when adding discard and initial hand, finds best combination of books/runs with both hands
  (let* (
          (nullCards (list '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 (1))) )
         (possibleCardsDiscard   (append hand (list (first discardPile)) ) )
          (sortedDiscard (sortHand wild (sort (cardToNumber possibleCardsDiscard ()) #'string-lessp) ()))
         (discardPickCheck (goOutTest1 wild sortedDiscard () (append (checkRuns1 wild sortedDiscard ())(checkBooks1 wild sortedDiscard ())) nullCards))
         
         (sortedCurrent (sortHand wild (sort (cardToNumber hand ()) #'string-lessp) ()))
         (currentCheck (goOutTest1 wild sortedCurrent () (append (checkRuns1 wild sortedCurrent ())(checkBooks1 wild sortedCurrent ())) nullCards))
         )
    
    ;If the adding the discard has the same leftover cards or less leftover cards than the initial hand's combinations, then recommend draw pick.
    ;If not, then recommend to pick from discard
    (cond ( (or (equal currentCheck discardPickCheck)(< (length (first currentCheck)) (length (first discardPickCheck)) ))
           
           (cond ( (equal currentCheck discardPickCheck)
                 (princ "The computer recommends you to pick from the draw pile because the discard pile did not add to any books or runs of yours.") )
                 ( t
                  (princ "The computer recommends you to pick from the draw pile because the discard pile did not add to your books/runs of ... ") 
                  (terpri)
                  (princ (finalCardTranslate (first (rest currentCheck)) ()) ))  )
           
           )
          ( t 
           (princ "The computer recommends you to pick from the discard pile because it wants you to create ... ")
           (terpri)
           (princ (finalCardTranslate (first (rest discardPickCheck)) ()) ))    )
    
    
    )
  
  )


;* *********************************************************************
;Function Name: askForHelpDiscarding
;Purpose: calls goOutTest1 to find leftover cards when building best books/runs. Recommends to drop card that is leftover
;Parameters: all values of game, all as lists except wild for round, which is atom
;Return Value: function goOutDecision
;Local Variables:
;            sorted hand and best combination of books and runs
;Algorithm:
;            1) See is discard selection is in user hand, if not, recursive call.
;            2) If it is in hand, remove from hand and call goOutDecision.
;********************************************************************* *
(defun askForHelpDiscarding (wild hand)
  
  
  (let* ((nullCards (list '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 (1))) )
         (sortedNewHand (sortHand wild (sort (cardToNumber hand ()) #'string-lessp) ()))
          (discardDecision (goOutTest1 wild sortedNewHand () (append (checkRuns1 wild sortedNewHand ())(checkBooks1 wild sortedNewHand ())) nullCards)))       
    
    ;Checks if there were no books/runs found, if so, recommends to drop last card in hand
    (cond 
    
          ( (eq (first (first discardDecision)) '1)
         
         (terpri)
           (princ "The recommends you to drop your ... ")
           (terpri)
         (princ (finalCardTranslate (list (list (first (last hand))) ) ()))     
           (terpri)
           (princ " ... because you had no books/run in your hand, and this card is worth the most points.")
         (terpri)
         )
     
     ;Checks if length of leftover cards is greater than one, if so, recommend to discard highest card of leftover cards
        ( (> (length (first discardDecision)) 1)
         
         (terpri)
           (princ "The recommends you to drop your ... ")
           (terpri)
            (princ (finalCardTranslate (list (list (first (last (first discardDecision))))) ())  ) 
           (terpri)
           (princ " ... because it did not add to your books/runs of ... ")
         (terpri)
       
         (princ (finalCardTranslate (first (rest discardDecision)) ()) ) 
                  
        
         )
     
     ;If length of leftover cards is 1, then recommends to discard that card, and the user should be able to go out.
        ( t
         
         (terpri)
           (princ "The recommends you to drop your ... ")
           (terpri)
            (princ (finalCardTranslate (list (list (first (first discardDecision)))) () )  ) 
           (terpri)
           (princ " ... because it did not add to your books/runs of ... ")
         (terpri)
         (princ (finalCardTranslate (first (rest discardDecision)) ()) )
         


         )
        )
    
    
    
                  )
  
  
  
  )







;* *********************************************************************
;Function Name: startComputerTurn
;Purpose: Go through a computer's turn
;Parameters: all values of game board
;Return Value: function goOutDecision
;Local Variables:
;           sorted cards of potential hands, lists of goOutTest1 return
;Algorithm:
;            1) Checking to see what to pick up
;               2) If the discard adds to best possible runs/books, then picks from discard, else, picks from draw.
;            3) Call goOutTest1 to find best combination with new hand, then calls discard selection function
;            4) Calls goOutTest1 with final hand, if can go out, return winningCondition = 1, else, 0
;********************************************************************* *
(defun startComputerTurn(wild computerCards drawPile discardPile)
  
  (let* (
          (nullCards (list '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 (1))) )
         (possibleCardsDiscard   (append computerCards (list (first discardPile)) ) )
          (sortedDiscard (sortHand wild (sort (cardToNumber possibleCardsDiscard ()) #'string-lessp) ()))
         (discardPickCheck (goOutTest1 wild sortedDiscard () (append (checkRuns1 wild sortedDiscard ())(checkBooks1 wild sortedDiscard ())) nullCards))
         
         (sortedCurrent (sortHand wild (sort (cardToNumber computerCards ()) #'string-lessp) ()))
         (currentCheck (goOutTest1 wild sortedCurrent () (append (checkRuns1 wild sortedCurrent ())(checkBooks1 wild sortedCurrent ())) nullCards))
         
         
         )
    
    ;If the intial hand has less leftover cards, then pick from draw
    (cond ( (or (equal currentCheck discardPickCheck)(< (length (first currentCheck)) (length (first discardPickCheck)) ))
           
           (terpri)
           (princ "The computer picked ... ")
           (princ (first drawPile))
           (princ " ... from the draw pile.")
           (terpri)
           (princ "The computer picked from the draw pile because ... ")
           (terpri)
           
           
           (cond ( (eq (finalCardTranslate (first (rest currentCheck)) ()) NIL)
                  (princ "It could not find any books and runs from picking up from the discard pile."))
                 ( t
                  (princ "It wants to create books/runs of ... ")
                  (terpri)
                  (princ (finalCardTranslate (first (rest currentCheck)) ()) )
                  ) )
           
          
           (terpri)
           
           ;Calls findDiscardChoice, which returns card to discard
           (let* ((newComputerHand   (append computerCards (list (first drawPile)) ) )  
                  (newDrawPile (rest drawPile))
                  
                  (sortedNewHand (sortHand wild (sort (cardToNumber newComputerHand ()) #'string-lessp) ()))
                  (discardDecision (findDiscardChoice (goOutTest1 wild sortedNewHand () (append (checkRuns1 wild sortedNewHand ())(checkBooks1 wild sortedNewHand ())) nullCards) newComputerHand))
                  (finalComputerHand (remove (first discardDecision) newComputerHand :count 1) )
                  (finalDiscardPile (append discardDecision discardPile))
                  
                  )  
             
             (terpri)
             (princ "Final Computer Hand: ")
             (princ finalComputerHand)
             (terpri)
             (terpri)
             
             
             
             
             (let* ((finalSortedHand (sortHand wild (sort (cardToNumber finalComputerHand ()) #'string-lessp) ()))
                    
                    (checkOut (goOutTest1 wild finalSortedHand () (append (checkRuns1 wild finalSortedHand ())(checkBooks1 wild finalSortedHand ())) nullCards)) )  
               
               
               ;Checks if the player can go out, if so, then return updated game board with winningCondition = 1
               ;If not, return updaed game board
               (cond ( (eq (first checkOut) NIL)
                      (terpri)
                      (princ "THE COMPUTER CAN GO OUT WITH HIS HAND!")
                      (terpri)
                      (princ "These are the computer's books/runs.")
                      (terpri)
                      (princ (finalCardTranslate (first (rest checkOut)) ()) )
                      (terpri)
          
                      (list finalComputerHand newDrawPile finalDiscardPile 1))
                     ( t
                      (princ "The computer couldn't find a way to go out.") 
                      (terpri) 
                      (list finalComputerHand newDrawPile finalDiscardPile 15) ) )
               
               
               
               
               
               )
             
             
             
             
             )
           
           
           
           
           )
          ( t
           
           ;Picks from discard if it has less leftover cards than inital combination
           
           (terpri)
           (princ "The computer picked ... ")
           (princ (first discardPile))
           (princ " ... from the discard pile.")
           (terpri)
           
           (princ "The computer picked from the discard pile because ... ")
           (terpri)
           (princ "It wants to create books/runs of ... ")
           (terpri)
           (princ (finalCardTranslate (first (rest discardPickCheck)) ()) )
           (terpri)
           
           ;Calls findDiscardChoice to get discard card
           (let* ((newComputerHand   (append computerCards (list (first discardPile)) ) )  
                  (newDiscardPile (rest discardPile))
                  
                  (sortedNewHand (sortHand wild (sort (cardToNumber newComputerHand ()) #'string-lessp) ()))
                  (discardDecision (findDiscardChoice (goOutTest1 wild sortedNewHand () (append (checkRuns1 wild sortedNewHand ())(checkBooks1 wild sortedNewHand ())) nullCards) newComputerHand))
                  (finalComputerHand (remove (first discardDecision) newComputerHand :count 1) )
                  (finalDiscardPile (append discardDecision newDiscardPile))
                            
                  )  
             
             (terpri)
             (princ "Final Computer Hand: ")
             (princ finalComputerHand)
             (terpri)
             
             
             (let* ((finalSortedHand (sortHand wild (sort (cardToNumber finalComputerHand ()) #'string-lessp) ()))
                    
                    (checkOut (goOutTest1 wild finalSortedHand () (append (checkRuns1 wild finalSortedHand ())(checkBooks1 wild finalSortedHand ())) nullCards)) )  
               
               ;Checks to see if user can go out
               (cond ( (eq (first checkOut) NIL)
                      (terpri)
                      (princ "THE COMPUTER CAN GO OUT WITH HIS HAND!")
                      (terpri)
                      (princ "These are the computer's books/runs.")
                      (terpri)
                     (princ (finalCardTranslate (first (rest checkOut)) ()) )
                      (terpri)
                      
                      (list finalComputerHand drawPile finalDiscardPile 1))
                     ( t
                      (princ "The computer couldn't find a way to go out.") 
                      (terpri) 
                      (list finalComputerHand drawPile finalDiscardPile 15) ) )
               
               
               
               
               
               
               )
             
             
             
             
             )
           
           
           
           )  )
    
    )
  
  
   
   
  )



;* *********************************************************************
;Function Name: startComputerLastTurn
;Purpose: Go through a computer's last turn
;Parameters: all values of game board
;Return Value: function goOutDecision
;Local Variables:
;           sorted cards of potential hands, lists of goOutTest1 return
;Algorithm:
;            1) Checking to see what to pick up
;               2) If the discard adds to best possible runs/books, then picks from discard, else, picks from draw.
;            3) Call goOutTest1 to find best combination with new hand, then calls discard selection function
;            4) Calls goOutTest1 with final hand. If can go out, return 0 points. Else, count cards of remaining best combination.
;********************************************************************* *
(defun startComputerLastTurn(wild computerCards drawPile discardPile)
  
  
  
  (let* (
          (nullCards (list '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 (1))) )
         (possibleCardsDiscard   (append computerCards (list (first discardPile)) ) )
          (sortedDiscard (sortHand wild (sort (cardToNumber possibleCardsDiscard ()) #'string-lessp) ()))
         (discardPickCheck (goOutTest1 wild sortedDiscard () (append (checkRuns1 wild sortedDiscard ())(checkBooks1 wild sortedDiscard ())) nullCards))
         
         (sortedCurrent (sortHand wild (sort (cardToNumber computerCards ()) #'string-lessp) ()))
         (currentCheck (goOutTest1 wild sortedCurrent () (append (checkRuns1 wild sortedCurrent ())(checkBooks1 wild sortedCurrent ())) nullCards))
         
         
         )
    
    (cond ( (or (equal currentCheck discardPickCheck)(< (length (first currentCheck)) (length (first discardPickCheck))) )
          
           (terpri)
           (princ "The computer picked ... ")
           (princ (first drawPile))
           (princ " ... from the draw pile.")
           (terpri)
           
           (princ "The computer picked from the draw pile because ... ")
           (terpri)
           
           (cond ( (eq (finalCardTranslate (first (rest currentCheck)) ()) NIL)
                  (princ "It could not find any books and runs from picking up from the discard pile."))
                 ( t
                  (princ "It wants to create books/runs of ... ")
                  (terpri)
                  (princ (finalCardTranslate (first (rest currentCheck)) ()) )
                  ) )
           
           (let* ((newComputerHand   (append computerCards (list (first drawPile)) ) )  
                  (newDrawPile (rest drawPile))
                  
                  (sortedNewHand (sortHand wild (sort (cardToNumber newComputerHand ()) #'string-lessp) ()))
                  (discardDecision (findDiscardChoice (goOutTest1 wild sortedNewHand () (append (checkRuns1 wild sortedNewHand ())(checkBooks1 wild sortedNewHand ())) nullCards) newComputerHand))
                  (finalComputerHand (remove (first discardDecision) newComputerHand :count 1) )
                  (finalDiscardPile (append discardDecision discardPile))
                  
                  )  
             
             
             (terpri)
             (princ "Final Computer Hand: ")
             (princ finalComputerHand)
             (terpri)
             
             
             
             
             (let* ((finalSortedHand (sortHand wild (sort (cardToNumber finalComputerHand ()) #'string-lessp) ()))
                    
                    (checkOut (goOutTest1 wild finalSortedHand () (append (checkRuns1 wild finalSortedHand ())(checkBooks1 wild finalSortedHand ())) nullCards)) )  
               
               
               ;If computer can go out, then return 0 points. 
               ;If not, if the comptuer has no books/runs, count all cards in hand.
               ;If computer has books/runs, count leftover cards
               (cond ( (eq (first checkOut) NIL)
                      (terpri)
                      (princ "THE COMPUTER CAN GO OUT WITH HIS HAND!")
                      (terpri)
                      (princ "These are the computer's books/runs.")
                      (terpri)
                      (princ (finalCardTranslate (first (rest checkOut)) ()) )
                      (terpri)
                      (princ "Total Points for Computer this Round is: ")
                      (princ "0")
                      (terpri)
                      
                      (list finalComputerHand newDrawPile finalDiscardPile 0))
                     ( t
                      (princ "The computer couldn't find a way to go out.") 
                      (terpri) 
                      
                       (cond ( (eq (first (first checkOut)) '1)
                             (terpri)
                             (princ "The computer could not find any books/runs to put down before going out.")
                             (terpri)
                              (princ (list finalComputerHand))
                              (terpri)
                              (princ "Total Points for Computer this Round is: ")
                              (princ (countCardPoints wild (finalCardTranslate (list finalComputerHand) ()) 0))
                              (terpri)
                             (list finalComputerHand newDrawPile finalDiscardPile (countCardPoints wild (finalCardTranslate (list finalComputerHand) ()) 0)) 
                             )
                             ( t
                              (terpri)
                             (princ "The computer could not go out, but it can place down these books/runs.")
                             (terpri)
                              (princ (finalCardTranslate (first (rest checkOut)) ()))
                              (terpri)
                              (princ "Adding up all computer's card points before going out!")
                              (terpri)
                              (terpri)
                              (princ "Total Points for Computer this Round is: ")
                              (princ (countCardPoints wild (finalCardTranslate (list (first checkOut)) ()) 0))
                              (terpri)
                             (list finalComputerHand newDrawPile finalDiscardPile (countCardPoints wild (finalCardTranslate (list (first checkOut)) ()) 0)) ) )
                      
                      
                      
                      
                      
                       ) )   
               
               
               )
             )
           )
             
             
             
             
             
           
           
           
           
           
          ( t
           
           (terpri)
           (princ "The computer picked ... ")
           (princ (first discardPile))
           (princ " ... from the discard pile.")
           (terpri)
           
           (princ "The computer picked from the discard pile because ... ")
           (terpri)
           (princ "It wants to create books/runs of ... ")
           (terpri)
           (princ (finalCardTranslate (first (rest discardPickCheck)) ()) )
           (terpri)
           
           
           (let* ((newComputerHand   (append computerCards (list (first discardPile)) ) )  
                  (newDiscardPile (rest discardPile))
                  
                  (sortedNewHand (sortHand wild (sort (cardToNumber newComputerHand ()) #'string-lessp) ()))
                  (discardDecision (findDiscardChoice (goOutTest1 wild sortedNewHand () (append (checkRuns1 wild sortedNewHand ())(checkBooks1 wild sortedNewHand ())) nullCards) newComputerHand))
                  (finalComputerHand (remove (first discardDecision) newComputerHand :count 1) )
                  (finalDiscardPile (append discardDecision newDiscardPile))
                            
                  )  
             
            (terpri)
             (princ "Final Computer Hand: ")
             (princ finalComputerHand)
             (terpri)
             
             (let* ((finalSortedHand (sortHand wild (sort (cardToNumber finalComputerHand ()) #'string-lessp) ()))
                    
                    (checkOut (goOutTest1 wild finalSortedHand () (append (checkRuns1 wild finalSortedHand ())(checkBooks1 wild finalSortedHand ())) nullCards)) )  
               
               
               ;If computer can go out, then return 0 points. 
               ;If not, if the comptuer has no books/runs, count all cards in hand.
               ;If computer has books/runs, count leftover cards
               (cond ( (eq (first checkOut) NIL)
                      (terpri)
                      (princ "THE COMPUTER CAN GO OUT WITH HIS HAND!")
                      (terpri)
                      (princ "These are the computer's books/runs.")
                      (terpri)
                     (princ (finalCardTranslate (first (rest checkOut)) ()) )
                      (terpri)
                      (princ "Total Points for Computer this Round is: ")
                      (princ "0")
                      (list finalComputerHand drawPile finalDiscardPile 0))
                     ( t
                      (princ "The computer couldn't find a way to go out.") 
                      (terpri) 
                      
                      (cond ( (eq (first (first checkOut)) '1)
                             (terpri)
                             (princ "The computer could not find any books/runs to put down before going out.")
                             (terpri)
                             (terpri)
                              (princ "Total Points for Computer this Round is: ")
                              (princ (countCardPoints wild (finalCardTranslate (list finalComputerHand) ()) 0))
                              (terpri)
                             (princ (list finalComputerHand))
                             (list finalComputerHand drawPile finalDiscardPile (countCardPoints wild (finalCardTranslate (list finalComputerHand) ()) 0)) 
                             )
                            ( t
                             (terpri)
                             (princ "The computer could not go out, but it can place down these books/runs.")
                             (terpri)
                             (princ (finalCardTranslate (first (rest checkOut)) ()))
                             (princ "Adding up all leftover points for computer!")
                             (terpri)
                              (princ "Total Points for Computer this Round is: ")
                              (princ (countCardPoints wild (finalCardTranslate (list (first checkOut)) ()) 0))
                              (terpri)
                             (list finalComputerHand drawPile finalDiscardPile (countCardPoints wild (finalCardTranslate (list (first checkOut)) ()) 0)) ) )
                      
                  
                      ) )
      
           
           )  )
    
    )
  
  
   
   
           ) 
          )
    )
  
  
 


;* *********************************************************************
;Function Name: findDiscardChoice
;Purpose: finds the best card to discard from hand
;Parameters: finalBooksandRuns which is best combination of goOutTest1, and hand
;Return Value: card to discard
;Local Variables:
;            none
;Algorithm:
;            1) If computer has no books/runs, returns highest card value from hand.
;            2) If the leftover cards are greater than 1, then returns highest card value of leftover cards
;            3) If there is only one leftover card, returns that card. Computer be able should go out.
;********************************************************************* *
(defun findDiscardChoice(finalBooksandRuns hand)
  
  
  ;Checks if no books and runs were found
  (cond ( (eq (first (first finalBooksandRuns)) '1)
         
         (terpri)
         (princ "New Computer Hand: ")
         (princ hand)
         (terpri)
         
     
         (terpri)
         (princ "The computer has dropped his ... ")
         
         (princ (finalCardTranslate (list (list (first (last hand))) ) ()))
         
         (terpri)
         (princ "... because it could not find any books/runs in its hand.")
         (terpri)
         
         (first (finalCardTranslate (list (list (first (last hand))) ) ()))
         
         )
   
   
   
   ;Checks there is more than 1 leftover cards
        ( (> (length (first finalBooksandRuns)) 1)
         
         
         
         (terpri)
         (princ "New Computer Hand: ")
         (princ hand)
         (terpri)
          (terpri)
         (princ "The computer has dropped his ... ")
         
         (princ (finalCardTranslate (list (list (first (last (first finalBooksandRuns))))) ())  )
         
         (terpri)
         (princ "... because it did not add to his books/runs of ... ")
         (terpri)
        (princ (finalCardTranslate (first (rest finalBooksandRuns)) ()))

         (terpri)
         
         (first (finalCardTranslate (list (list (first (last (first finalBooksandRuns))))) ()))
                  
        
        ) 
        ( t
         
         ;Checks if there is only 1 card leftover
         
         (terpri)
         (princ "New Computer Hand: ")
         (princ hand)
         (terpri)
         (terpri)
         (princ "The computer has dropped his ... ")
         (princ (finalCardTranslate (list (list (first (first finalBooksandRuns)))) () )  ) 
         
          (terpri)
         (princ "... because it did not add to his books/runs of ... ")
         (terpri)
        (princ (finalCardTranslate (first (rest finalBooksandRuns)) ()))
         (terpri)
   
         (first (finalCardTranslate (list (list (first (first finalBooksandRuns)))) ()))


         )
        ) 
  
  )




;* *********************************************************************
;Function Name: startHumanLastTurn
;Purpose: To go through a human's last turn. Similar to startHumanTurn
;Parameters: all values of game, all as lists except points and wild for round, which are atoms
;Return Value: If saving file, return exit. If making move, call makeHumanMoveValidationLast. If help, then print line. If exit, then exit.
;Local Variables:
;            read value, text file
;Algorithm:
;            1) If human saves, create save file and exit.
;            2) If human makes move, then call makeHumanMoveValidationLast function.
;            3) If human asks for help, then print help and recursively call function.
;            4) If human exits, exit game.
;            5) If the human did not enter 1,2,3, or 4, recursively call function.
;********************************************************************* *
(defun startHumanLastTurn(wild humanCards drawPile discardPile)
  
  
  (princ "This is your last turn before the round is over!")
  (terpri)
  (princ "What would you like to do?")
  (terpri)
  (princ "1. Save the game.")
  (terpri)
  (princ "2. Make a move.")
  (terpri)
  (princ "3. Ask for help.")
  (terpri)
  (princ "4. Exit the game.")
  (terpri)
  (princ "")
  
  (let* ((decision (read) )) 
    (cond ( (and(numberp decision)(= decision 1))
           (terpri)
           (princ "You cannot save the game at this point.")
           (terpri)
          (startHumanLastTurn wild humanCards drawPile discardPile) )
     
          ( (and(numberp decision)(= decision 2)) 
           (makeHumanMoveValidationLast wild humanCards drawPile discardPile))
          ( (and(numberp decision)(= decision 3))
                 
                 
               (askForHelpPicking wild humanCards discardPile)  
               (startHumanLastTurn wild humanCards drawPile discardPile)  
           )
          ( (and(numberp decision)(= decision 4))
          (excl:exit 0 :no-unwind t :quiet t) )
          ( t
           (princ "Please enter 1, 2, 3, or 4.")
          (startHumanLastTurn wild humanCards drawPile discardPile) )) )
  
  
  
  )


;* *********************************************************************
;Function Name: makeHumanMoveValidationLast
;Purpose: Asks user to pick from draw or discard, and validates it.
;Parameters: all values of game, all as lists except wild for round, which is atom
;Return Value: makingDiscardMoveLast function.
;Local Variables:
;            none
;Algorithm:
;            1) Validates human move input. 
;            2) If user draws from pile, then create new draw pile and new human hand.
;            3) If user picks from discard, then create new discard pile and new human hand.
;            4) Call function makingDiscardMoveLast for discarding a card.
;********************************************************************* *
(defun makeHumanMoveValidationLast(wild humanCards drawPile discardPile)
  
  (princ "What would you like to do?")
  (terpri)
  (princ "1. Pick from draw pile.")
  (terpri)
  (princ "2. Pick from discard pile.")
  (terpri)
  (princ "")
  
   (let* ((decision (read) )) 
    (cond ( (and(numberp decision)(= decision 1)) 
           (princ "You picked from the draw pile.")
           (let* ((newHumanCards (append humanCards (list (first drawPile)))) 
                  (newDrawPile (rest drawPile)) )
             (makingDiscardMoveLast wild newHumanCards newDrawPile discardPile))
          
           )
          ( (and(numberp decision)(= decision 2) )
           (princ "You picked from the discard pile.")
           (let* ((newHumanCards (append humanCards (list (first discardpile)))) 
                  (newDiscardPile (rest discardpile)) )
             (makingDiscardMoveLast wild newHumanCards drawPile newDiscardPile))
           ) 
          ( t
           (princ "Please enter 1 or 2.")
          (makeHumanMoveValidationLast wild humanCards drawPile discardPile) )) )



  )


;* *********************************************************************
;Function Name: makingDiscardMoveLast
;Purpose: See if the user wants to ask for help discarding or just wants to discard.
;Parameters: all values of game, all as lists except wild for round, which is atom
;Return Value: function makingDiscardValidationLast
;Local Variables:
;            none
;Algorithm:
;            1) If user asks for help, call function to ask for help discarding and print line it, then recursive call.
;            2) If user asks to discard, call makeDiscardValidationLast to discard.
;********************************************************************* *
(defun makingDiscardMoveLast(wild humanCards drawPile discardpile)
  
  (terpri)
  (princ "New Human Hand: ")
  (princ humanCards)
  (terpri)
  (terpri)
  (princ "What would you like to do")
  (terpri)
  (princ "1. Ask for help discarding.")
  (terpri)
  (princ "2. Discard a card.")
  (terpri)
  (princ "")
  
  (let* ((decision (read) )) 
    (cond ( (and(numberp decision)(= decision 1)) 
           
           (askForHelpDiscarding wild humanCards)
          (makingDiscardMoveLast wild humanCards drawPile discardpile)
           )
          ( (and(numberp decision)(= decision 2) )
           (makeDiscardValidationLast wild humanCards drawPile discardpile)
           ) 
          ( t
           (princ "Please enter 1 or 2.")
          (makingDiscardMoveLast wild humanCards drawPile discardpile) )) )
  
  
  
  
  )


;* *********************************************************************
;Function Name: makeDiscardValidationLast
;Purpose: Validate user discard selection.
;Parameters: all values of game, all as lists except wild for round, which is atom
;Return Value: function goOutDecisionLast
;Local Variables:
;            none
;Algorithm:
;            1) See is discard selection is in user hand, if not, recursive call.
;            2) If it is in hand, remove from hand and call goOutDecisionLast.
;********************************************************************* *
(defun makeDiscardValidationLast(wild humanCards drawPile discardpile)
  
  (princ "Please enter the card you would like to discard. Ex. 4H or 9C")
  (terpri)
  (princ "")
  
  (let* ((decision (read) )) 
    (cond ( (find decision humanCards)
           (goOutDecisionLast wild (remove decision humanCards :count 1) drawPile (cons decision discardpile) 0)
           )
          ( t
           (princ "This value was not in your hand. ")
           (makeDiscardValidationLast wild humanCards drawPile discardpile))) )
  
  
  )

;* *********************************************************************
;Function Name: goOutDecisionLast
;Purpose: See if user wants to try to go out.
;Parameters: all values of game, all as lists except wild for round, which is atom
;Return Value: function afterDiscardLast if wants to go out, else, returns list of new values with winningCondition =0, as the human did not go out.
;Local Variables:
;            none
;Algorithm:
;            1) See is user wants to go out. If he does, then call function afterDiscardLast.
;            2) If not, then return list of new game board and winningCondition = 0
;********************************************************************* *
(defun goOutDecisionLast(wild humanHand drawPile discardPile winningCondition)
  
  
  (terpri)
  (princ "Final Human Hand: ")
  (princ humanHand)
  (terpri)
  (terpri)
  (princ "Would you like to see if you can go out with your hand?")
  (terpri)
  (princ "1. Yes.")
  (terpri)
  (princ "2. No.")
  (terpri)
  (princ "")
  
  (let* ((decision (read) )) 
    (cond ( (and(numberp decision)(= decision 1))
           (afterDiscardLast wild humanHand drawPile discardPile 0)
           )
          ( (and(numberp decision)(= decision 2) )
           (list humanHand drawPile discardpile 0) )
          ( t
           (princ "Please enter either 1 or 2. ")
           (goOutDecisionLast wild humanHand drawPile discardPile winningCondition)) )
  
    


         )
  
  )


;* *********************************************************************
;Function Name: afterDiscardLast
;Purpose: Check if the user can go out by calling function goOutTest1
;Parameters: all values of game, all as lists except wild for round, which is atom, and winningCondition which is 0
;Return Value: function goOutDecision
;Local Variables:
;            nullList, nullCards with is a default value of cards, sortedHand which sorts player's hand, and checkOut which is best combination of player's books/runs.
;Algorithm:
;            1) Call function checkOut with a sorted user's hand and default values. This returns the best combination of runs/books.
;            2) If the first value of checkOut is NIL, then the player used all cards in books/runs.
;               3) Returns new game board with winningCondtion = 1, as the player has went out.
;            4) If not NIL, then the player cannot go out.
;            5) If there were no books/runs found, then count all cards in hand and return
;            6) If there were, count leftover cards of best combination.
;********************************************************************* *
(defun afterDiscardLast(wild humanHand drawPile discardPile winningCondition)
  
  (let* (
         (nullList ())
         (sortedHand (sortHand wild (sort (cardToNumber humanHand ()) #'string-lessp) ()))
         (nullCards (list '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 (1))) )
         (checkOut (goOutTest1 wild sortedHand () (append (checkRuns1 wild sortedHand nullList)(checkBooks1 wild sortedHand nullList)) nullCards)))
    
    (cond ( (eq (first checkOut) NIL)
           (princ "YOU CAN GO OUT WITH YOUR HAND!")
           (terpri)
           (princ "You can go out with these books/runs.")
           (terpri)
           (princ (finalCardTranslate (first (rest checkOut)) ()) )

           
           (terpri)
           (princ "Total Points for Human Player this Round: ")
           (princ "0")
           (terpri)
          (list humanHand drawPile discardpile 0) )
          ( t
           (princ "You cannot go out with your hand.") 
           
           (cond ( (eq (first (first checkOut)) '1)
                  (terpri)
                  (princ "There were no books/runs for you to put down before going out.")
                  (terpri)
                  (princ (list humanHand))
                  (terpri)
                  (princ "Total Points for Human Player this Round: ")
                  (princ (countCardPoints wild (finalCardTranslate (list humanHand) ()) 0))
                  (terpri)
                 (list humanHand drawPile discardPile (countCardPoints wild (finalCardTranslate (list humanHand) ()) 0)) 
                  )
                 ( t
                  (terpri)
                  (princ "You cannot go out, but you can put down these books/runs to go out.")
                  (terpri)
                  (princ (finalCardTranslate (first (rest checkOut)) ()) )
                  (princ "Adding up all left over points!")
                  (terpri)
                  (terpri)
                  (princ "Total Points for Human Player this Round: ")
                  (princ (countCardPoints wild (finalCardTranslate (list (first checkOut)) ()) 0))
                  (terpri)
                 (list humanHand drawPile discardPile (countCardPoints wild (finalCardTranslate (list (first checkOut)) ()) 0)) ) )
           
           
           
          )
    
    


         )
  
  
  
    )
  )











  
;* *********************************************************************
;Function Name: checkBooks1
;Purpose: Returns all books in player's hand
;Parameters: wild for round, player's hand, and all books which starts as NULL
;Return Value: all books in hand
;Local Variables:
;            none
;Algorithm:
;            1) Calls checkBooks2 with first card in hand.
;            2) If checkBooks2 returns the same value of books, then recursively call function with leftover hand and same books.
;            3) If not same value, then recursively call function with leftover hand and adding found books found in checkBooks2.
;           
;********************************************************************* *
(defun checkBooks1(wild hand books)

  (cond ( (eq hand ())
         books )
        ( t
         
         (cond ( (eq (checkBooks2 wild wild (first (cardToNumber hand ())) (rest (cardToNumber hand ())) books) books)
                (checkBooks1 wild (rest hand) books))
               ( t
              (checkBooks1 wild (rest hand) (checkBooks2 wild wild (first (cardToNumber hand ())) (rest (cardToNumber hand ())) books) )  )  )
           )  
        )
  
  
  )



;* *********************************************************************
;Function Name: checkBooks2
;Purpose: Returns all books in player's hand for one card
;Parameters: wild for round, number for round, card to check for books, player's hand, and all books already found
;Return Value: all books found from card
;Local Variables:
;            none
;Algorithm:
;            1) Calls checkBooks3 with card.
;            2) checkBooks3 is looking for a book with size number.
;            3) If it returns a book of size number, then add that returned book to books parameter of checkBooks2.
;               4) Recursive call checkBooks2 with updated book list and decreased number size-1 to find new book of that new number size.
;           5) If it does not return book of size number, then don't add to books parameter, and recursive call with same books and number-1.
;           6) Returns all books to checkBooks1 once number is less than 3, so it doesn't look for a book of size 2
;********************************************************************* *
(defun checkBooks2(wild number card hand books)
  
  (cond ( (< number 3)
        books )
        ( t
           
         (cond ( (= (length (checkBooks3 wild number card hand (cons card ()))) number)
               (checkBooks2 wild (- number 1) card hand (cons (reverse (checkBooks3 wild number card hand (cons card ()))) books)) )
               ( t 
               (checkBooks2 wild (- number 1) card hand books) ) )
           )  
        )
  
  
  )


;* *********************************************************************
;Function Name: checkBooks3
;Purpose: Returns a book of size number, or book when there are no more cards left in hand to check
;Parameters: wild for round, number for round, card to check for books, player's hand, and book found
;Return Value: a book of size number found from card or a book that when there are no more cards in hand to check
;Local Variables:
;            none
;Algorithm:
;            1) Checks if the first card in hand is less than value 10
;               2) If that first card is the same value as checking card, then call function again with rest of hand, and adding that first card to book.
;               3) If that first card is the wild for the round, then call function again with rest of hand, and adding that first card to book.
;               4) Else, call function again with rest of hand and same book.
;            5) Checks if the first card is a wild, if so, call function again with rest of hand, and adding that first card to book.
;            6) Checks if the first card is a joker, if so, call function again with rest of hand, and adding that first card to book.
;            7) Checks if the first card value is greater than 9 and checking card value is less than 10.
;               8) If so, call function with rest of hand and same book.
;           9) Check if first card is same value as checking card, and both values are greater than 9.
;              10) If so, call function again with rest of hand, and adding that first card to book.
;           11) Else, call function again with rest of hand, and same book.
;           12) Function finally returns book when there are no more cards in hand to check, or the length of book is the number needed.
;********************************************************************* *
(defun checkBooks3(wild number card hand book)

  
  (cond ( (= number (length book))
         book )
        ( (= (length hand) 0)
         book )
         
        
        ( (< (length (string (first hand))) 3)
           (cond (  (eq (char (string card) 0) (char (string (first hand)) 0))
                  (checkBooks3 wild number card (rest hand) (cons (first hand) book))  )
                 ( (= ( digit-char-p (char (string (first hand)) 0) ) wild)
                  (checkBooks3 wild number card (rest hand) (cons (first hand) book))
                  )
                 ( t 
                 (checkBooks3 wild number card (rest hand) book)   )  )
           )
        ;check if card last digit plus 10 is equal to first hand last digit plus 10
        ;check if first hand last digit plus 10 is wild
        ( (= (+ ( digit-char-p (char (string (first hand)) 1) ) 10) wild)
        (checkBooks3 wild number card (rest hand) (cons (first hand) book)))
         
        ( (= (+ ( digit-char-p (char (string (first hand)) 1) ) 10) '15)
         
        
         (checkBooks3 wild number card (rest hand) (cons (first hand) book))  )
         
         
       ( (and (> (length (string (first hand))) 2) (< (length (string card)) 3)  )
        (checkBooks3 wild number card (rest hand) book) )
         
        
        ( (= (+ ( digit-char-p (char (string card) 1) ) 10)(+ ( digit-char-p (char (string (first hand)) 1) ) 10))
         (checkBooks3 wild number card (rest hand) (cons (first hand) book)) )
        
        
        
         
        
         
        
         ( t
                 
                 (checkBooks3 wild number card (rest hand) book) )  ) 
            
  )


;* *********************************************************************
;Function Name: checkRuns1
;Purpose: Returns all runs in player's hand
;Parameters: wild for round, player's hand, and all runs which starts as NULL
;Return Value: all runs in hand
;Local Variables:
;            none
;Algorithm:
;            1) Calls checkRuns2 with first card in hand.
;            2) If checkRuns2 returns the same value of runs, then recursively call function with leftover hand and same runs.
;            3) If not same value, then recursively call function with leftover hand and adding found runs found in checkRuns2.
;           
;********************************************************************* *
(defun checkRuns1(wild hand runs)
  

  
  (cond ( (eq hand ())
        
         (reverse runs) )
        ( t
         
      
         (cond ( (eq (checkRuns2 wild wild (first (cardToNumber hand ())) (rest (cardToNumber hand ())) runs) runs)
                (checkRuns1 wild (rest hand) runs))
               ( t

              (checkRuns1 wild (rest hand) (checkRuns2 wild wild (first (cardToNumber hand ())) (rest (cardToNumber hand ())) runs)  )  ) )
           )  
        )
  
  
  )

;* *********************************************************************
;Function Name: checkRuns2
;Purpose: Returns all runs in player's hand for one card
;Parameters: wild for round, number for round, card to check for runs, player's hand, and all runs already found
;Return Value: all runs found from card
;Local Variables:
;            none
;Algorithm:
;            1) Calls checkRuns3 with card.
;            2) checkRuns3 is looking for a run with size number.
;            3) If it returns a run of size number, then add that returned run to runs parameter of checkRuns2.
;               4) Recursive call checkRuns2. with updated run list and decreased number size-1 to find new run of that new number size.
;           5) If it does not return run of size number, then don't add to runs parameter, and recursive call with same runs and number-1.
;           6) Returns all runs to checkRuns1 once number is less than 3, so it doesn't look for a run of size 2
;********************************************************************* *
(defun checkRuns2(wild number card hand runs)
  
  (cond ( (< number 3)
         
         runs )
        ( t
       
        
         (cond ( (= (length (checkRuns3 wild number card hand (cons card ()) 1)) number)
              
                
               (checkRuns2 wild (- number 1) card hand (cons (reverse (checkRuns3 wild number card hand (cons card ()) 1)) runs)) )
               ( t 
               (checkRuns2 wild (- number 1) card hand runs) ) )
           )  
        )
  
  
  )



;* *********************************************************************
;Function Name: checkRuns3
;Purpose: Returns a run of size number, or run when there are no more cards left in hand to check
;Parameters: wild for round, number for round, card to check for runs, player's hand, and run found, runIncrement that starts at 1
;Return Value: a run of size number found from card or a run that when there are no more cards in hand to check
;Local Variables:
;            none
;Algorithm:
;            1) Checks if the first card in hand is a wild, if so, call function with rest of hand and adding that first card to run, and runIncrement +1.
;            2) Checks if the first card's value is less than 10, and if the checking card is less than 9.
;               3) Checks if the checking card's value + runIncrement is equal to the first card's value, and is both are same suit.
;                   4) If so, call function with rest of hand and adding that first card to run, and runIncrement +1.
;               5) Checks if the checking card's value is +2 runIncrement and both same suit, or if first card is a wild, or a joker.
;                 6) If so, call function with rest of hand and adding that first card to run, and runIncrement +2.
;               7) Else, call function again with rest of hand, same run, and runIncrement.
;           8) Check if checking card and first card value is 9, if so, call function again with rest of hand, same run, and runIncrement.
;           9) Check if first card is a joker, if so, call function again with rest of hand, adding that first card to run, and runIncrement +1.
;           10) Checks if the checking card is 9 and the first card is 10 with the same suit, if so, return updated runs, runIncrement, and hand.
;           11) Checks if checking card is 9 and the first card is greater than 9 but not 10. If so, return same runs, sane runIncrement, and rest of hand.
;           12) Checks if the checking card's value +runIncrement is the first cards value and same suite, if so, return updated runs, runIncrement, and hand.
;           13) Checks if the checking card's value is +2 runIncrement and both same suit, or if first card is a wild, or a joker.
;               14) If so, call function with rest of hand and adding that first card to run, and runIncrement +2.
;           15) Else, call function with rest of hand, same run, and same runIncrement.
;           16) Function finally returns run when there are no more cards in hand to check, or the length of run is the number needed.
;********************************************************************* *
(defun checkRuns3(wild number card hand run runIncrement)
  
  
         
  (cond ( (= number (length run))       
         run )
        ( (= (length hand) 0)
       
         run)
        
        ( (eq (digit-char-p (char (string (first hand)) 0)) wild)
        
         
         (checkRuns3 wild number card (rest hand) (cons (first hand) run) (+ runIncrement 1)) )
        
        ( (and (< (length (string (first hand))) 3) (< (digit-char-p (char (string card) 0)) 9)  )
         
           (cond ( (and(> (length hand) 0)(and (= (+ (digit-char-p (char (string card) 0)) runIncrement) (digit-char-p (char (string (first hand)) 0))) (eq (char (string card) 1)(char (string (first hand)) 1) ) ))
                  (checkRuns3 wild number card (rest hand) (cons (first hand) run) (+ runIncrement 1)) )
                 ( (and(> (length hand) 0)(and (= (+ (digit-char-p (char (string card) 0)) (+ runIncrement 1)) (digit-char-p (char (string (first hand)) 0))) (eq (char (string card) 1)(char (string (first hand)) 1) ) 
                                               (or (= (digit-char-p (char (string  (first (last hand))) 0)) wild)(and (> (length (string (first (last hand)))) 2) (eq (+ (digit-char-p (char (string  (first (last hand))) 1)) 10) wild))   
                                             (and (> (length (string (first (last hand)))) 2)(= (+ (digit-char-p (char (string  (first (last hand))) 1)) 10) '15) ) )  )     )
                  
                  
                  
                 
                  (let* ((pushingWild (concatenate 'list (append  (list (first hand)(first (last hand)))) run))
                         (removeWild (remove (first (last hand)) hand :count 1))
                         (lastHand (rest removeWild)))
                    
                    
                           (checkRuns3 wild number card lastHand pushingWild  (+ runIncrement 2))  )
               )
               ( t
                (checkRuns3 wild number card (rest hand) run runIncrement)) )   )
        
        
        
        
        
        ( (and (= (digit-char-p (char (string card) 0)) 9)(= (digit-char-p (char (string (first hand)) 0)) 9)  )
         (checkRuns3 wild number card (rest hand) run runIncrement) )
          ( (= (+ (digit-char-p (char (string (first hand)) 1)) 10) wild )
           (checkRuns3 wild number card (rest hand) (cons (first hand) run) (+ runIncrement 1)) )
        
        ( (= (+ (digit-char-p (char (string (first hand)) 1)) 10) '15 )
           (checkRuns3 wild number card (rest hand) (cons (first hand) run) (+ runIncrement 1)) )
        
 
        
        
        ( (and(> (length hand) 0)(and (= (+ (digit-char-p (char (string card) 0)) runIncrement) (+ ( digit-char-p (char (string (first hand)) 1) ) 10)) (eq (char (string card) 1)(char (string (first hand)) 2) ) ))
        
         (checkRuns3 wild number card (rest hand) (cons (first hand) run) (+ runIncrement 1)) ) 
        
        ( (and (> (length (string (first hand))) 2) (< (length (string card)) 3)  )
        
         (checkRuns3 wild number card (rest hand) run runIncrement)
         )
       
        
        ( (and(> (length hand) 0)(and (= (+ (+ ( digit-char-p (char (string card) 1) ) 10) runIncrement) (+ ( digit-char-p (char (string (first hand)) 1) ) 10)) (eq (char (string card) 2)(char (string (first hand)) 2) ) ))
        
        
        (checkRuns3 wild number card (rest hand) (cons (first hand) run) (+ runIncrement 1))
         
         )
        
        ( (and(> (length hand) 0)(and (= (+ (+ ( digit-char-p (char (string card) 1) ) 10) (+ runIncrement 1)) (+ ( digit-char-p (char (string (first hand)) 1) ) 10)) (eq (char (string card) 2)(char (string (first hand)) 2) ) 
                                      (or (= (+ (digit-char-p (char (string  (first (last hand))) 1)) 10) wild)(= (digit-char-p (char (string  (first (last hand))) 0)) wild)
                                          (= (+ (digit-char-p (char (string  (first (last hand))) 1)) 10) '15))   ))
         
         (let* ((pushingWild (concatenate 'list (append  (list (first hand)(first (last hand)))) run))
                (removeWild (remove (first (last hand)) hand :count 1))
                (lastHand (rest removeWild)))
           
           
           (checkRuns3 wild number card lastHand pushingWild  (+ runIncrement 2))  )
         
         )
        
        
        
        ( t
         
         (checkRuns3 wild number card (rest hand) run runIncrement) )
        
        
        
        )
  
        
  
  
  ) 








          
;* *********************************************************************
;Function Name: goOutTest1
;Purpose: Returns best possible combination of books and runs as list, with leftover card in first of list
;Parameters: wild for round, player's hand, combinations that is all books and runs of hand, wholeList that is all books and runs of hand,
;            minimum which is the best combination of books and runs that has least amount of leftover cards
;Return Value: best combination of books and runs
;Local Variables:
;            one branch of checking from possible books and runs when removing first book/run from wholeList
;Algorithm:
;            1) Call goOutTest2 with first book/run found from wholeList, and removing cards from that book/run from hand.
;               2) If the hand has more cards than the wild number, and the best combination returned NIL, 
;                  call function again with rest of books/runs from wholeList, and same minimum
;                  (This is handling when a player is looking to discard a card, and therefore must have best runs/books return a card to discard.)
;               3) If the the goOutTest2 returns leftover cards that is less than current leftover cards minimum, then call function again 
;                  with rest of wholeList and new best possible runs/books as minimum.
;               4) Else, calls function again with rest of wholeList and same best possible runs/books as minimum.
;           5) If all books and runs found from hand are gone, then return best possible runs/books found that has least amount of cards.
;********************************************************************* *
(defun goOutTest1(wild hand combinations wholeList minimum)
  


  
  (cond (  (= (length wholeList) 0)
       
         minimum )
        ( t
         
        
         (let* ((possible (goOutTest2 wild (removeFromHand (first wholeList) (cardToNumber hand ())) (list (first wholeList)))))
           (cond ( (and (> (length hand) wild) (eq (first possible) NIL))
                 (goOutTest1 wild hand (rest wholeList) (rest wholeList) minimum) )
                 ( (< (length (first possible))  (length (first minimum))) 
                 (goOutTest1 wild hand (rest wholeList) (rest wholeList) possible) )
                 ( t
                 (goOutTest1 wild hand (rest wholeList) (rest wholeList) minimum) )    )
         )   ) ) 
  
  
  
   
  
  )


;* *********************************************************************
;Function Name: goOutTest2
;Purpose: Returns a combination of books/runs when beginning with one book/run from goOutTest1
;Parameters: wild for round, player's hand, possible that is list of books/runs found when beginning with one book/run from goOutTest1
;Return Value: list of leftover cards and all books/runs found from this branch of books/runs
;Local Variables:
;            booksAndruns that is list of books/runs from hand
;Algorithm:
;            1) Create list of books/runs from leftover hand
;            2) If there are no books/runs found, return list of leftover cards and all books/runs found.
;            3) Else, Call function again with first run/book found from booksAndruns, and removing that run/book from hand.                
;               4) Else, calls function again with rest of wholeList and same best possible runs/books as minimum.
;           5) This function should finally return a list of leftover cards from hand that cannot be placed in books/runs, and books/runs used.
;********************************************************************* *
(defun goOutTest2(wild hand possible)
  
  ;make books and runs
  ;FINAL CONDITION IS, if no more books and runs to check 
  ;return (cards remaining (books and runs that were made))
  ;else
  ;we must make a tree
  
  ;check first combination of book/run
  ;looks to see what is returns, add as current possibility
  ;check second combination of book/run
  ;looks to see what returns, if more cards that previous possibility, then do nothing
  ;if less, then replace it
  ;check third combination of book/run
  ;looks to see what returns, if more cards that previous possibility, then do nothing
  ;if less, then replace it
  
  
  
  (let* ((booksAndruns  (append (checkRuns1 wild hand ())(checkBooks1 wild hand ()))))
    
    (cond ( (= (length booksAndruns) 0)
           
           (list hand possible) )   
          ( t
           (let* ((test (goOutTest2 wild (removeFromHand (first booksAndruns) hand) (cons (first booksAndRuns) possible)) ))
             (cond ( (= (length (first test)) 0)
                    
                    test )
                   ( t
                    ; (goOutTest2 wild (removeFromHand (first(rest booksAndruns)) hand) (append (first (rest booksAndRuns)) possible))
                    
                    test) 
                   )
            
            )
          )
      )
    )
  )
  
  
 



;* *********************************************************************
;Function Name: removeFromHand
;Purpose: Removes all cards from a book/run from a player's hand
;Parameters: run/book, and player's hand
;Return Value: new hand when removing run/book
;Local Variables:
;            none
;Algorithm:
;            1) If the run/book is empty, then the all cards from the run/book should be removed from hand. And returns that new hand.
;            2) Else, remove the first card in book/run from hand, and recursively call function with new run/book and new hand
;********************************************************************* *
(defun removeFromHand(runOrbook hand)
  
  (cond ( (= (length runOrbook) 0)
         hand )
        ( t
         (removeFromHand (remove (first runOrbook) runOrbook :count 1)  (remove (first runOrbook) hand :count 1) ))
        )
  
  
  )




;(defun makeNumber(hand newNumberHand)
;  
;  (cond ( (eq hand ())
;       newNumberHand)
;        ( (eq (first hand) '3C)
;         (makeNumber (remove '3C hand) (cons 3 newNumberHand)))
;        ( (eq (first hand) '4C)
;         (makeNumber (remove '4C hand) (cons 4 newNumberHand)))
;        ( (eq (first hand) '5C)
;         (makeNumber (remove '5C hand) (cons 5 newNumberHand)))
;        ( (eq (first hand) '6C)
;         (makeNumber (remove '7C hand) (cons 6 newNumberHand)))
;        ( (eq (first hand) '7C)
;         (makeNumber (remove '7C hand) (cons 7 newNumberHand)))
;        ( (eq (first hand) '8C)
;         (makeNumber (remove '8C hand) (cons 8 newNumberHand)))
;        ( (eq (first hand) '9C)
;         (makeNumber (remove '9C hand) (cons 9 newNumberHand)))
;        ( (eq (first hand) 'XC)
;         (makeNumber (remove 'XC hand) (cons 10 newNumberHand)))
;        ( (eq (first hand) 'JC)
;         (makeNumber (remove 'JC hand) (cons 11 newNumberHand)))
;        ( (eq (first hand) 'QC)
;         (makeNumber (remove 'QC hand) (cons 12 newNumberHand)))
;        )
;  
;  
;  )

;(defun test(hand newNumberHand)
;  
;  (cond ( (eq hand ())
;         newNumberhand)
;        ( t
;          (test (remove (first hand) hand :count 1) (cons (char (string (first hand)) 0) newNumberhand)) )
;        )
;  
;  
;  )


;* *********************************************************************
;Function Name: cardToNumber
;Purpose: Translate call cards in a hand to number values
;Parameters: hand, and final translated hand
;Return Value: final translated number value hand
;Local Variables:
;            value of card
;Algorithm:
;            1) If the hand is empty, then the hand has been fully translated into translatedHand, and returns it.
;            2) Converts all face cards to their number value. ex XC = 10C
;               (for jokers, their values are 15)
;********************************************************************* *
(defun cardToNumber(hand translatedHand)
  
 
 
  (let* ((value (char (string (first hand)) 0)))
    
    (cond ( (= (length hand) 0)
           
           
         (reverse translatedHand))
        ( (string= value 'X)
         (cond ( (string= (char (string (first hand)) 1) 'S)
                (cardToNumber (remove (first hand) hand :count 1) (cons '10S translatedHand)) )
               ( (string= (char (string (first hand)) 1) 'D)
                (cardToNumber (remove (first hand) hand :count 1) (cons '10D translatedHand)) ) 
               ( (string= (char (string (first hand)) 1) 'C)
                (cardToNumber (remove (first hand) hand :count 1) (cons '10C translatedHand)) )
               ( (string= (char (string (first hand)) 1) 'T)
                (cardToNumber (remove (first hand) hand :count 1) (cons '10T translatedHand)) )
               ( (string= (char (string (first hand)) 1) 'H)
                (cardToNumber (remove (first hand) hand :count 1) (cons '10H translatedHand)) )
               
               )
         )
        ( (string= value 'J)
         
         (cond ( (string= (char (string (first hand)) 1) 'S)
                (cardToNumber (remove (first hand) hand :count 1) (cons '11S translatedHand)) )
               ( (string= (char (string (first hand)) 1) 'D)
                (cardToNumber (remove (first hand) hand :count 1) (cons '11D translatedHand)) ) 
               ( (string= (char (string (first hand)) 1) 'C)
                (cardToNumber (remove (first hand) hand :count 1) (cons '11C translatedHand)) )
               ( (string= (char (string (first hand)) 1) 'T)
                (cardToNumber (remove (first hand) hand :count 1) (cons '11T translatedHand)) )
               ( (string= (char (string (first hand)) 1) 'H)
                (cardToNumber (remove (first hand) hand :count 1) (cons '11H translatedHand)) )
               
               ( (= (digit-char-p (char (string (first hand)) 1)) '1)
                
                (cardToNumber (remove (first hand) hand :count 1) (cons '15O translatedHand)) )
               ( (= (digit-char-p (char (string (first hand)) 1)) '2)
                (cardToNumber (remove (first hand) hand :count 1) (cons '15W translatedHand)) )
               ( (= (digit-char-p (char (string (first hand)) 1)) '3)
                
                (cardToNumber (remove (first hand) hand :count 1) (cons '15R translatedHand)) )
               
               
               
               
               
               )
         )
        ( (string= value 'Q)
         (cond ( (string= (char (string (first hand)) 1) 'S)
                (cardToNumber (remove (first hand) hand :count 1) (cons '12S translatedHand)) )
               ( (string= (char (string (first hand)) 1) 'D)
                (cardToNumber (remove (first hand) hand :count 1) (cons '12D translatedHand)) ) 
               ( (string= (char (string (first hand)) 1) 'C)
                (cardToNumber (remove (first hand) hand :count 1) (cons '12C translatedHand)) )
               ( (string= (char (string (first hand)) 1) 'T)
                (cardToNumber (remove (first hand) hand :count 1) (cons '12T translatedHand)) )
               ( (string= (char (string (first hand)) 1) 'H)
                (cardToNumber (remove (first hand) hand :count 1) (cons '12H translatedHand)) )
               
               )
         )
        ( (string= value 'K)
         (cond ( (string= (char (string (first hand)) 1) 'S)
                (cardToNumber (remove (first hand) hand :count 1) (cons '13S translatedHand)) )
               ( (string= (char (string (first hand)) 1) 'D)
                (cardToNumber (remove (first hand) hand :count 1) (cons '13D translatedHand)) ) 
               ( (string= (char (string (first hand)) 1) 'C)
                (cardToNumber (remove (first hand) hand :count 1) (cons '13C translatedHand)) )
               ( (string= (char (string (first hand)) 1) 'T)
                (cardToNumber (remove (first hand) hand :count 1) (cons '13T translatedHand)) )
               ( (string= (char (string (first hand)) 1) 'H)
                (cardToNumber (remove (first hand) hand :count 1) (cons '13H translatedHand)) )
               
               )
         )
        
        
        
        ( t
         
         
         (cardToNumber (remove (first hand) hand :count 1) (cons (first hand) translatedHand)) )   )
  
  
  
  
  ))


;* *********************************************************************
;Function Name: sortHand
;Purpose: sorts a hand by placing face cards at the end, and then calling wildsInBack function to put wilds and jokers in back of hand.
;Parameters: wild for round, players hand, and faceCards for all face card values
;Return Value: calls wildsInBack function to recieve sortedHand where wilds are in the back
;Local Variables:
;            none
;Algorithm:
;            1) If the first card of hand's value is greater than 9, then place into faceCards and call function again with updated paremeters.
;            2) If the first card of hand's value is less than 9, then the hand should be all values less than 9.
;            3) So, faceCards will have all sorted values greater than 10, and append that to hand. Then calls wildsInBack to put wilds in back of hand.
;********************************************************************* *
(defun sortHand(wild hand faceCards)
  
  
  (cond ( (or (eq hand ())(= (length (string (first hand))) 2))
       
         (wildsInBack wild (append hand faceCards) () ())  )
        ( (> (length (string (first hand))) 2)
         (sortHand wild (rest hand) (append faceCards (list(first hand)) ))   )

  
  
  )
  
  
  )


;* *********************************************************************
;Function Name: wildsInBack
;Purpose: Places wilds in back of sorted hand
;Parameters: wild for round, hand, final sorted hand, and wilds found
;Return Value: sorted hand where wilds are in the back
;Local Variables:
;            none
;Algorithm:
;            1) Goes through all cards in hand
;            2) If the first card's value is greater than 10, and is a wild or joker, then place card into finalWilds
;            3) If the first card's value is less than 10, and is a wild or joker, then place card into finalWilds.
;            4) If the hand is empty, finalWilds will have all wilds, and finalHand will have all cards that are not wilds.
;            5) Then returns the hand by appending finalWilds to finalHand.
;********************************************************************* *
(defun wildsInBack(wild hand finalHand finalWilds)
  
  (cond ( (eq hand ())
         
        (append finalHand finalWilds)
          )
        ( (= (length (string (first hand))) 3)
         (cond ( (= (+ (digit-char-p (char (string (first hand)) 1)) 10) wild)
                (wildsInBack wild (rest hand) finalHand (cons (first hand) finalWilds)) )
               ( t 
                (wildsInBack wild (rest hand) (append  finalHand (list (first hand))) finalWilds) )   )
         
         )
        
        ( (= (digit-char-p (char (string (first hand)) 0)) wild)
         (wildsInBack wild (rest hand) finalHand (cons (first hand) finalWilds) ) ) 
        ( t 
         (wildsInBack wild (rest hand) (append  finalHand (list (first hand))) finalWilds ) ) )
  
  
  )

;* *********************************************************************
;Function Name: finalCardTranslate
;Purpose: Translates cards that were turned into number values back into face values
;Parameters: booksAndruns of hand, and finalTranslated which starts as NULL
;Return Value: hand that is translated back to face values
;Local Variables:
;            none
;Algorithm:
;            1) If there are no more cards to translate, then return final translated books and runs.
;            2) If there are, then call translateBacktoCards by passing first book/run, which translated the first book/run, and then 
;              recursively call the function with removing the book/run passed 
;********************************************************************* *
(defun finalCardTranslate(booksAndruns finalTranslated)
  
  
  (cond (  (eq booksAndruns ()) 
         
         
        finalTranslated )
        (  t           
        
         (finalCardTranslate (remove (first booksAndruns) booksAndruns :count 1) (cons (translateBacktoCards (first booksAndruns) () ) finalTranslated ) )  ) )
  
  
  )


;* *********************************************************************
;Function Name: translateBacktoCards
;Purpose: Translate all cards of a book/run to face value
;Parameters: hand and final translated hand, which begins as NULL
;Return Value: final translated hand
;Local Variables:
;            none
;Algorithm:
;            1) If the hand is empty, it was fully translated, and returns the final translated hand.
;            2) If the first card of hand has a value greater than 9, then translate it back to a face card and call back function with removing that card.
;            3) Else, the first card does not need to be translated.
;********************************************************************* *
(defun translateBacktoCards(hand translatedHand)
  
  
  
    (cond ( (= (length hand) 0)
           
           
          
           (reverse translatedHand))
          
          
          ( (> (length (string (first hand))) 2)
           
           
           
           
           (cond ( (string= (string (first hand)) '10S)
                  (translateBacktoCards (remove (first hand) hand :count 1) (cons 'XS translatedHand)) )
                 ( (string= (string (first hand)) '10D)
                  (translateBacktoCards (remove (first hand) hand :count 1) (cons 'XD translatedHand)) ) 
                 ( (string= (string (first hand)) '10C)
                  (translateBacktoCards (remove (first hand) hand :count 1) (cons 'XC translatedHand)) )
                 ( (string= (string (first hand)) '10T)
                  (translateBacktoCards (remove (first hand) hand :count 1) (cons 'XT translatedHand)) )
                 ( (string= (string (first hand)) '10H)
                  (translateBacktoCards (remove (first hand) hand :count 1) (cons 'XH translatedHand)) )
               
               
                 ( (string= (string (first hand)) '11S)
                  (translateBacktoCards (remove (first hand) hand :count 1) (cons 'JS translatedHand)) )
                 ( (string= (string (first hand)) '11D)
                  (translateBacktoCards (remove (first hand) hand :count 1) (cons 'JD translatedHand)) ) 
                 ( (string= (string (first hand)) '11C)
                  (translateBacktoCards (remove (first hand) hand :count 1) (cons 'JC translatedHand)) )
                 ( (string= (string (first hand)) '11T)
                  (translateBacktoCards (remove (first hand) hand :count 1) (cons 'JT translatedHand)) )
                 ( (string= (string (first hand)) '11H)
                  (translateBacktoCards (remove (first hand) hand :count 1) (cons 'JH translatedHand)) )
               
               
               
                 ( (string= (string (first hand)) '12S)
                  (translateBacktoCards (remove (first hand) hand :count 1) (cons 'QS translatedHand)) ) 
                 ( (string= (string (first hand)) '12D)
                  (translateBacktoCards (remove (first hand) hand :count 1) (cons 'QD translatedHand)) ) 
                 ( (string= (string (first hand)) '12C)
                  (translateBacktoCards (remove (first hand) hand :count 1) (cons 'QC translatedHand)) )
                 ( (string= (string (first hand)) '12T)
                  (translateBacktoCards (remove (first hand) hand :count 1) (cons 'QT translatedHand)) )
                 ( (string= (string (first hand)) '12H)
                  (translateBacktoCards (remove (first hand) hand :count 1) (cons 'QH translatedHand)) )
               
               
                 ( (string= (string (first hand)) '13S)
                  (translateBacktoCards (remove (first hand) hand :count 1) (cons 'KS translatedHand)) )
                 ( (string= (string (first hand)) '13D)
                  (translateBacktoCards (remove (first hand) hand :count 1) (cons 'KD translatedHand)) ) 
                 ( (string= (string (first hand)) '13C)
                  (translateBacktoCards (remove (first hand) hand :count 1) (cons 'KC translatedHand)) )
                 ( (string= (string (first hand)) '13T)
                  (translateBacktoCards (remove (first hand) hand :count 1) (cons 'KT translatedHand)) )
                 ( (string= (string (first hand)) '13H)
                  (translateBacktoCards (remove (first hand) hand :count 1) (cons 'KH translatedHand)) )
                      
                 ( (string= (string (first hand)) '15O)
                  (translateBacktoCards (remove (first hand) hand :count 1) (cons 'J1 translatedHand)) )
                 ( (string= (string (first hand)) '15W)
                  (translateBacktoCards (remove (first hand) hand :count 1) (cons 'J2 translatedHand)) )
                 ( (string= (string (first hand)) '15R)
                  (translateBacktoCards (remove (first hand) hand :count 1) (cons 'J3 translatedHand)) )
                 
                 
                 
                 )
           )
        
        
        ( t
         
        
         (translateBacktoCards (remove (first hand) hand :count 1) (cons (first hand) translatedHand)) )   )
  
  
  
  
  
  
  
  
  
  )



;* *********************************************************************
;Function Name: countCardPoints
;Purpose: Returns a number that is all points from the hand
;Parameters: wild for round, player's hand, and total number of points which starts at 0
;Return Value: number of hand points
;Local Variables:
;            value of card
;Algorithm:
;            1) If the hand is null, then all have been translated to points, and returns the number.
;            2) Checks for face value cards, and adds them as appropriate.
;            3) Checks for the case of wilds and jokers.
;            4) If not face value or wild, then add number of value of card.
;            5) These conditions return the function call back by removing the card from hand and adding that card points to the number.
;********************************************************************* *
(defun countCardPoints(wild hand number)
  
  
  
  
  (let* ((value (string (first (first hand))) ))
    
    (cond ( (eq (first hand) NIL)
           
         number )
          ( (string= (char value 0) 'X)
           
         (cond ( (= wild 10)
               (countCardPoints wild (list (rest (first hand))) (+ number 20)) )
               ( t
                
              (countCardPoints wild (list (rest (first hand))) (+ number 10))  )  )
          )
        
        ( (string= (char value 0) 'J)
         (cond ( (= wild 11)
                (countCardPoints wild (list (rest (first hand))) (+ number 20)) )
                ( (eq (char value 1) '1)
                (countCardPoints wild (list (rest (first hand))) (+ number 50)) )
               ( (eq (char value 1) '2)
                (countCardPoints wild (list (rest (first hand))) (+ number 50)) ) 
               ( (eq (char value 1) '3)
                (countCardPoints wild (list (rest (first hand))) (+ number 50)) )
               ( t
               (countCardPoints wild (list (rest (first hand))) (+ number 11)) )
               )
         )
        ( (string= (char value 0) 'Q)
         (cond ( (= wild 12)
               (countCardPoints wild (list (rest (first hand))) (+ number 20)) )
               ( t
              (countCardPoints wild (list (rest (first hand))) (+ number 12))  )  ) )
        
         ( (string= (char value 0) 'K)
          (cond ( (= wild 13)
               (countCardPoints wild (list (rest (first hand))) (+ number 20)) )
               ( t
              (countCardPoints wild (list (rest (first hand))) (+ number 13))  )  )
          )
        
        ( (= (digit-char-p (char value 0)) wild)
          (countCardPoints wild (list (rest (first hand))) (+ number 20))
         )
        ( t
         
        (countCardPoints wild (list (rest (first hand))) (+ (digit-char-p (char value 0)) number)   )   )
        
        
        
        
        
        
              )
  )
  
  )









(defun permutations (bag)
  "Return a list of all the permutations of the input."
  ;; If the input is nil, there is only one permutation:
  ;; nil itself
  (if (null bag) 
      '(())
      ;; Otherwise, take an element, e, out of the bag.
      ;; Generate all permutations of the remaining elements,
      ;; And add e to the front of each of these.
      ;; Do this for all possible e to generate all permutations.
      (mapcan #'(lambda (e)
                  (mapcar #'(lambda (p) (cons e p))
                          (permutations
                            (remove e bag :count 1))))
        bag))
  )
  


  












  





