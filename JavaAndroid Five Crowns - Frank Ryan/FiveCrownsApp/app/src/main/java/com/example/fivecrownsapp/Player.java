package com.example.fivecrownsapp;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Vector;

public class Player implements Serializable {

    private Deck deck = new Deck();

    public Player() {

    }

    public Player(ArrayList<Card> a_drawPile, ArrayList<Card> a_discardPile) {

    }

    //pickFromDraw function, adds first card from drawpile to hand parameter, removes first of draw pile
    public void pickFromDraw(ArrayList<Card> hand, ArrayList<Card> drawPile) {
        hand.add(drawPile.get(0));
        drawPile.remove(0);

    }

    //pickFromDiscard function, adds first card from discard to hand parameter, removes first of discard pile
    public void pickFromDiscard(ArrayList<Card> hand, ArrayList<Card> discardPile) {
        hand.add(discardPile.get(0));
        discardPile.remove(0);

    }

    //discardCard function, removes card from a hand, places it into the first of discard pile
    public void discardCard(ArrayList<Card> hand, ArrayList<Card> discardPile, Card card) {
        hand.remove(card);
        discardPile.add(0, card);
    }

    /* *********************************************************************
    Function Name: goOut
    Purpose: Checks if a player can go out with a hand
    Parameters:
                integer for wild, and a players hand
    Return Value: boolean

    Algorithm:
                1) Calls functions checkRun1 and checkBook1 on a hand to get all books and runs
                2) Calls go out function with those books and runs
                3) Checks if there are leftover cards, if so , return true, if not, return false

    Assistance Received: none
    ********************************************************************* */
    public boolean goOut(int wild, ArrayList<Card> hand) {
        ArrayList<ArrayList<Card>> nullRuns = new ArrayList<ArrayList<Card>>(20);
        ArrayList<ArrayList<Card>> nullBooks = new ArrayList<ArrayList<Card>>(20);

        //Calling player functions to recieve all runs and books
        ArrayList<ArrayList<Card>> justRuns = checkRun1(wild, hand, nullRuns);
        ArrayList<ArrayList<Card>> justBooks = checkBook1(wild, hand, nullBooks);


        justBooks.addAll(justRuns);

        //Appends runs and books
        ArrayList<ArrayList<Card>> booksAndruns = justBooks;


        ArrayList<ArrayList<Card>> nullMinimum = new ArrayList<>(10);

        ArrayList<Card> nullCardsForMinimum = new ArrayList<>(20);
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));

        nullMinimum.add(nullCardsForMinimum);

        //Calls function goOutTest1 to get best runs and books from players hand
        ArrayList<ArrayList<Card>> bestRunsAndBooks = goOutTest1(wild, hand, booksAndruns, booksAndruns, nullMinimum);



        //If there are no left over cards, this is true
        if (bestRunsAndBooks.get(0).size() < 1) {
            return true;
        } else {
            return false;
        }

    }


    /* *********************************************************************
   Function Name: getGoOutCards
   Purpose: Same function as goOut, but returns string, to be called if a player can go out for view
   Parameters:
               integer for wild, and a players hand
   Return Value: string

   Algorithm:
               1) Calls functions checkRun1 and checkBook1 on a hand to get all books and runs
               2) Calls go out function with those books and runs
               3) returns the books and runs returned from this function
   Assistance Received: none
   ********************************************************************* */
    public String getGoOutCards(int wild, ArrayList<Card> hand) {
        ArrayList<ArrayList<Card>> nullRuns = new ArrayList<ArrayList<Card>>(20);
        ArrayList<ArrayList<Card>> nullBooks = new ArrayList<ArrayList<Card>>(20);

        ArrayList<ArrayList<Card>> justRuns = checkRun1(wild, hand, nullRuns);
        ArrayList<ArrayList<Card>> justBooks = checkBook1(wild, hand, nullBooks);


        justBooks.addAll(justRuns);

        ArrayList<ArrayList<Card>> booksAndruns = justBooks;


        ArrayList<ArrayList<Card>> nullMinimum = new ArrayList<>(10);

        ArrayList<Card> nullCardsForMinimum = new ArrayList<>(20);
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));

        nullMinimum.add(nullCardsForMinimum);

        ArrayList<ArrayList<Card>> bestRunsAndBooks = goOutTest1(wild, hand, booksAndruns, booksAndruns, nullMinimum);

        //Calling printDoubleArrayList to get bestRunsandBooks as string

        return printDoubleArrayList(bestRunsAndBooks);


    }



    /* *********************************************************************
Function Name: putDownCards
Purpose: Gets best runs and books from a players hand and counts leftover cards
Parameters:
           integer for wild, and a players hand
Return Value: string

Algorithm:
           1) Calls functions checkRun1 and checkBook1 on a hand to get all books and runs
           2) Calls go out function with those books and runs
           3) Count the rest of cards that are not in books and runs
Assistance Received: none
********************************************************************* */
    public int putDownCards(int wild, ArrayList<Card> hand) {
        ArrayList<ArrayList<Card>> nullRuns = new ArrayList<ArrayList<Card>>(20);
        ArrayList<ArrayList<Card>> nullBooks = new ArrayList<ArrayList<Card>>(20);

        ArrayList<ArrayList<Card>> justRuns = checkRun1(wild, hand, nullRuns);
        ArrayList<ArrayList<Card>> justBooks = checkBook1(wild, hand, nullBooks);


        justBooks.addAll(justRuns);

        ArrayList<ArrayList<Card>> booksAndruns = justBooks;


        ArrayList<ArrayList<Card>> nullMinimum = new ArrayList<>(10);

        ArrayList<Card> nullCardsForMinimum = new ArrayList<>(20);
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));

        nullMinimum.add(nullCardsForMinimum);

        ArrayList<ArrayList<Card>> bestRunsAndBooks = goOutTest1(wild, hand, booksAndruns, booksAndruns, nullMinimum);



        //Use getValue Card function to get integer for each cards, add to total points to return
        //If there are no leftover cards
        if (bestRunsAndBooks.get(0).size() < 1) {
            return 0;
        }
        //If no books and runs were found, count all points of players hand
        else if (bestRunsAndBooks.get(0).size() > 13)
        {
            int totalPoints = 0;

            for(int i =0; i < hand.size(); i++)
            {
                if(hand.get(i).getValue() == wild)
                {
                    totalPoints += 20;
                }
                else
                {
                    totalPoints += hand.get(i).getValue();
                }
            }

            return totalPoints;
        }
        //Count leftover cards of best books and runs
        else
            {

                int totalPoints = 0;

            for(int i = 0; i < bestRunsAndBooks.get(0).size(); i++)
            {
                if(bestRunsAndBooks.get(0).get(i).getValue() == wild)
                {
                    totalPoints += 20;
                }
                else
                {
                    totalPoints += bestRunsAndBooks.get(0).get(i).getValue();
                }
            }

            return totalPoints;
        }

    }



    /* *********************************************************************
Function Name: getPutDownCards
Purpose: Same function as putDownCards, but returns string of cards that are put down for view activity
Parameters:
          integer for wild, and a players hand
Return Value: string

Algorithm:
          1) Calls functions checkRun1 and checkBook1 on a hand to get all books and runs
          2) Calls go out function with those books and runs
          3) Return the string of best books and runs
Assistance Received: none
********************************************************************* */
    public String getPutDownCards(int wild, ArrayList<Card> hand) {
        ArrayList<ArrayList<Card>> nullRuns = new ArrayList<ArrayList<Card>>(20);
        ArrayList<ArrayList<Card>> nullBooks = new ArrayList<ArrayList<Card>>(20);

        ArrayList<ArrayList<Card>> justRuns = checkRun1(wild, hand, nullRuns);
        ArrayList<ArrayList<Card>> justBooks = checkBook1(wild, hand, nullBooks);


        justBooks.addAll(justRuns);

        ArrayList<ArrayList<Card>> booksAndruns = justBooks;


        ArrayList<ArrayList<Card>> nullMinimum = new ArrayList<>(10);

        ArrayList<Card> nullCardsForMinimum = new ArrayList<>(20);
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));
        nullCardsForMinimum.add(new Card("3", "2"));

        nullMinimum.add(nullCardsForMinimum);

        ArrayList<ArrayList<Card>> bestRunsAndBooks = goOutTest1(wild, hand, booksAndruns, booksAndruns, nullMinimum);



        //If there are no leftover cards, return the whole books and runs from goOutTest1
        if (bestRunsAndBooks.get(0).size() < 1) {

            return printDoubleArrayList(bestRunsAndBooks);
        }
        //If no books and runs were found, return none
        else if (bestRunsAndBooks.get(0).size() > 13)
        {



            String nothing = "None! ... ";
            return nothing;
        }
        //If there are leftover cards, remove the leftover cards and return the best books and runs as string
        else
        {



            ArrayList<ArrayList<Card>> finalList = new ArrayList<>(bestRunsAndBooks);
            finalList.remove(0);

            return printDoubleArrayList(finalList);
        }

    }








    /* *********************************************************************
Function Name: checkRuns1
Purpose: Returns all runs in player's hand
Parameters: wild for round, player's hand, and all runs which starts as NULL
Return Value: all runs in hand
Local Variables:
            none
Algorithm:
            1) Calls checkRuns2 with first card in hand.
            2) If checkRuns2 returns the same value of runs, then recursively call function with leftover hand and same runs.
            3) If not same value, then recursively call function with leftover hand and adding found runs found in checkRuns2.
Assistance Received: none
********************************************************************* */

    public ArrayList<ArrayList<Card>> checkRun1(int wild, ArrayList<Card> hand, ArrayList<ArrayList<Card>> runs) {
        Deck deck = new Deck();
        if (hand.size() == 0) {
            return runs;
        } else {
            ArrayList<Card> copyHand = new ArrayList<Card>(hand);
            copyHand.remove(0);


            ArrayList<ArrayList<Card>> firstRunCheck = checkRun2(wild, wild, hand.get(0), copyHand, runs);

            if (firstRunCheck.size() == runs.size()) {
                return checkRun1(wild, copyHand, runs);
            } else {
                return checkRun1(wild, copyHand, firstRunCheck);
            }
        }

    }


    /* *********************************************************************
    Function Name: checkRuns2
    Purpose: Returns all runs in player's hand for one card
    Parameters: wild for round, number for round, card to check for runs, player's hand, and all runs already found
    Return Value: all runs found from card
    Local Variables:
                none
    Algorithm:
                1) Calls checkRuns3 with card.
                2) checkRuns3 is looking for a run with size number.
                3) If it returns a run of size number, then add that returned run to runs parameter of checkRuns2.
                   4) Recursive call checkRuns2. with updated run list and decreased number size-1 to find new run of that new number size.
               5) If it does not return run of size number, then don't add to runs parameter, and recursive call with same runs and number-1.
               6) Returns all runs to checkRuns1 once number is less than 3, so it doesn't look for a run of size 2
    ********************************************************************* */


    public ArrayList<ArrayList<Card>> checkRun2(int wild, int number, Card checkingCard, ArrayList<Card> restOfHand, ArrayList<ArrayList<Card>> runs) {
        Deck deck = new Deck();
        if (number < 3) {
            return runs;
        } else {
            ArrayList<Card> firstCheckingRun = new ArrayList<Card>(13);
            firstCheckingRun.add(checkingCard);

            ArrayList<Card> firstRunSize = checkRun3(wild, number, checkingCard, restOfHand, firstCheckingRun, 1);

            if (firstRunSize.size() == number) {

                runs.add(firstRunSize);


                return checkRun2(wild, number - 1, checkingCard, restOfHand, runs);
            } else {
                return checkRun2(wild, number - 1, checkingCard, restOfHand, runs);
            }
        }

    }




    /* *********************************************************************
Function Name: checkRuns3
Purpose: Returns a run of size number, or run when there are no more cards left in hand to check
Parameters: wild for round, number for round, card to check for runs, player's hand, and run found, runIncrement that starts at 1
Return Value: a run of size number found from card or a run that when there are no more cards in hand to check
Local Variables:
            none
Algorithm:
           1) Function finally returns run when there are no more cards in hand to check, or the length of run is the number needed.
           2) Checks if the checking cards value + runIncrement is the same value as first of restOfHand and if they have the same suite
           3) Checks if the rest of hand first value is a wild
           4) Checks if the rest of hand first value is a joker
           5) Checks if the checking cards value + runIncrement+1 is the same value as the first of restOfHand and if they have the same suite.
                6) Checks if there is a wild/joker at the end of the hand. If so, Adds that card to the run.
           7) Else, return the rest of hand without the first card of it, not adding to the run.
    ********************************************************************* */
    public ArrayList<Card> checkRun3(int wild, int number, Card checkingCard, ArrayList<Card> restOfHand, ArrayList<Card> run, int runIncrement) {

        Deck deck = new Deck();
        if (run.size() == number) {
            return run;
        } else if (restOfHand.size() == 0) {

            return run;
        }
        ArrayList<Card> newHand = new ArrayList<Card>(restOfHand);
        newHand.remove(0);

        ArrayList<Card> newRun = new ArrayList<Card>(run);
        newRun.add(restOfHand.get(0));



        if (checkingCard.getValue() + runIncrement == restOfHand.get(0).getValue() && checkingCard.getSuite().equals(restOfHand.get(0).getSuite())) {
            return checkRun3(wild, number, checkingCard, newHand, newRun, runIncrement + 1);

        } else if (restOfHand.get(0).getValue() == 50) {
            return checkRun3(wild, number, checkingCard, newHand, newRun, runIncrement + 1);
        } else if (restOfHand.get(0).getValue() == wild) {
            return checkRun3(wild, number, checkingCard, newHand, newRun, runIncrement + 1);
        } else if ((checkingCard.getSuite().equals(restOfHand.get(0).getSuite()) && checkingCard.getValue() + (runIncrement + 1) == restOfHand.get(0).getValue()) && (restOfHand.get(restOfHand.size() - 1).getValue() == 50 || restOfHand.get(restOfHand.size() - 1).getValue() == wild)) {
            ArrayList<Card> newGapHand = new ArrayList<Card>(restOfHand);
            newGapHand.remove(newGapHand.size() - 1);
            newGapHand.remove(0);

            ArrayList<Card> newGapRun = new ArrayList<Card>(run);
            newGapRun.add(restOfHand.get(restOfHand.size() - 1));
            newGapRun.add(restOfHand.get(0));

            return checkRun3(wild, number, checkingCard, newGapHand, newGapRun, runIncrement + 2);
        } else {
            return checkRun3(wild, number, checkingCard, newHand, run, runIncrement);
        }


    }


    /* *********************************************************************
Function Name: checkBooks1
Purpose: Returns all books in player's hand
Parameters: wild for round, player's hand, and all books which starts as NULL
Return Value: all books in hand
Local Variables:
            none
Algorithm:
            1) Calls checkBooks2 with first card in hand.
            2) If checkBooks2 returns the same value of books, then recursively call function with leftover hand and same books.
            3) If not same value, then recursively call function with leftover hand and adding found books found in checkBooks2.

  ********************************************************************* */
    public ArrayList<ArrayList<Card>> checkBook1(int wild, ArrayList<Card> hand, ArrayList<ArrayList<Card>> books) {
        Deck deck = new Deck();
        if (hand.size() == 0) {

            return books;
        } else {
            ArrayList<Card> copyHand = new ArrayList<Card>(hand);
            copyHand.remove(0);

            ArrayList<ArrayList<Card>> firstBookCheck = checkBook2(wild, wild, hand.get(0), copyHand, books);

            if (firstBookCheck.size() == books.size()) {
                return checkBook1(wild, copyHand, books);
            } else {
                return checkBook1(wild, copyHand, firstBookCheck);
            }
        }

    }


        /* *********************************************************************
Function Name: checkBooks2
Purpose: Returns all books in player's hand for one card
Parameters: wild for round, number for round, card to check for books, player's hand, and all books already found
Return Value: all books found from card
Local Variables:
            none
Algorithm:
            1) Calls checkBooks3 with card.
            2) checkBooks3 is looking for a book with size number.
            3) If it returns a book of size number, then add that returned book to books parameter of checkBooks2.
               4) Recursive call checkBooks2 with updated book list and decreased number size-1 to find new book of that new number size.
           5) If it does not return book of size number, then don't add to books parameter, and recursive call with same books and number-1.
           6) Returns all books to checkBooks1 once number is less than 3, so it doesn't look for a book of size 2

  ********************************************************************* */

    public ArrayList<ArrayList<Card>> checkBook2(int wild, int number, Card checkingCard, ArrayList<Card> restOfHand, ArrayList<ArrayList<Card>> books) {
        if (number < 3) {
            return books;
        } else {
            ArrayList<Card> firstCheckingBook = new ArrayList<Card>(13);
            firstCheckingBook.add(checkingCard);

            ArrayList<Card> firstBookSize = checkBook3(wild, number, checkingCard, restOfHand, firstCheckingBook);

            if (firstBookSize.size() == number) {

                books.add(firstBookSize);

                return checkBook2(wild, number - 1, checkingCard, restOfHand, books);
            } else {
                return checkBook2(wild, number - 1, checkingCard, restOfHand, books);
            }
        }

    }


         /* *********************************************************************
Function Name: checkBooks3
Purpose: Returns a book of size number, or book when there are no more cards left in hand to check
Parameters: wild for round, number for round, card to check for books, player's hand, and book found
Return Value: a book of size number found from card or a book that when there are no more cards in hand to check
Local Variables:
            none
Algorithm:
            1) Function finally returns book when there are no more cards in hand to check, or the length of book is the number needed.
            2) Checks if the checking card's value is the same as the rest of hand first value, if so, add that first card to the book
            3) Checks if the first card of rest of hand is a wild
            4) Checks if the first card of rest of hand is a joker
            5) Else, recursively call with removing the first card of rest of hand, and the same book

  ********************************************************************* */

    public ArrayList<Card> checkBook3(int wild, int number, Card checkingCard, ArrayList<Card> restOfHand, ArrayList<Card> book) {


        if (book.size() == number) {
            return book;
        } else if (restOfHand.size() == 0) {
            return book;
        }
        ArrayList<Card> newHand = new ArrayList<Card>(restOfHand);
        newHand.remove(0);

        ArrayList<Card> newBook = new ArrayList<Card>(book);
        newBook.add(restOfHand.get(0));


        if (checkingCard.getValue() == restOfHand.get(0).getValue()) {
            return checkBook3(wild, number, checkingCard, newHand, newBook);
        } else if (restOfHand.get(0).getValue() == wild) {
            return checkBook3(wild, number, checkingCard, newHand, newBook);
        } else if (restOfHand.get(0).getValue() == 50) {
            return checkBook3(wild, number, checkingCard, newHand, newBook);
        } else {
            return checkBook3(wild, number, checkingCard, newHand, book);
        }


    }

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
    public ArrayList<ArrayList<Card>> goOutTest1(int wild, ArrayList<Card> hand, ArrayList<ArrayList<Card>> combinations, ArrayList<ArrayList<Card>> wholeList, ArrayList<ArrayList<Card>> minimum) {

        if (wholeList.size() == 0) {
            return minimum;
        } else {
            ArrayList<Card> removedHand = new ArrayList<Card>(hand);
            removedHand.removeAll(wholeList.get(0));

            ArrayList<ArrayList<Card>> copyWholeList = new ArrayList<ArrayList<Card>>(wholeList);
            copyWholeList.remove(0);

            ArrayList<ArrayList<Card>> firstOfWholeList = new ArrayList<ArrayList<Card>>();
            firstOfWholeList.add(0, wholeList.get(0));

            ArrayList<ArrayList<Card>> possible = goOutTest2(wild, removedHand, firstOfWholeList);

            if (hand.size() > wild && possible.get(0).size() < 1) {
                return goOutTest1(wild, hand, copyWholeList, copyWholeList, minimum);
            } else if (possible.get(0).size() < minimum.get(0).size()) {
                return goOutTest1(wild, hand, copyWholeList, copyWholeList, possible);
            } else {
                return goOutTest1(wild, hand, copyWholeList, copyWholeList, minimum);

            }
        }


    }


    /* *********************************************************************
Function Name: goOutTest2
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
    public ArrayList<ArrayList<Card>> goOutTest2(int wild, ArrayList<Card> hand, ArrayList<ArrayList<Card>> possible) {
        ArrayList<ArrayList<Card>> nullRuns = new ArrayList<ArrayList<Card>>(1);
        ArrayList<ArrayList<Card>> nullBooks = new ArrayList<ArrayList<Card>>(1);

        ArrayList<ArrayList<Card>> justRuns = checkRun1(wild, hand, nullRuns);
        ArrayList<ArrayList<Card>> justBooks = checkBook1(wild, hand, nullBooks);

        justBooks.addAll(justRuns);

        ArrayList<ArrayList<Card>> booksAndruns = justBooks;

        if (booksAndruns.size() == 0) {
            ArrayList<ArrayList<Card>> finalPossible = new ArrayList<ArrayList<Card>>(20);


            finalPossible.add(0, hand);
            finalPossible.addAll(1, possible);

            return finalPossible;
        } else {
            ArrayList<Card> removedHand = new ArrayList<Card>(hand);
            removedHand.removeAll(booksAndruns.get(0));

            ArrayList<ArrayList<Card>> newPossible = new ArrayList<ArrayList<Card>>(possible);
            newPossible.add(0, booksAndruns.get(0));

            ArrayList<ArrayList<Card>> test = goOutTest2(wild, removedHand, newPossible);


            if (test.get(0).size() < 1) {
                return test;
            } else {
                return test;
            }


        }


    }





 /* *********************************************************************
Function Name: askHelpPicking
Purpose: EXACT same function as computer startTurnPickup, put returns string, and does not call function pickFromDraw or pickFromDiscard
Parameters: wild for round, player's hand, draw Pile, and discard Pile
Return Value: String of help

Algorithm:
           1) Create a null value for best books and runs.
           2) Call functions checkRun1 and checkBook1 to get all possible books and runs of current computer hand.
           3) Add discard pile card to computer hand, and call checkRun1 and checkBook1 to get possible books and runs of that hand with discard,
           4) Call goOutTest1 for hand with discard and current hand
           5) Compare best books and runs from current hand and discard hand
           6) Pick from draw String if the discard does not create better books and runs than current.
           7) Pick from discard String if the discard does create better books and runs than current.
   ********************************************************************* */

    public String askHelpPicking(int wild, ArrayList<Card> humanHand, ArrayList<Card> drawPile, ArrayList<Card> discardPile)
    {




        ArrayList<ArrayList<Card>> nullMinimum = new ArrayList<>(10);

        ArrayList<Card> nullCardsForMinimum = new ArrayList<>(20);
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));

        nullMinimum.add(nullCardsForMinimum);


        //THIS IS CHECKING FOR COMPUTER PICK UP CURRENT HAND
        ArrayList<ArrayList<Card>> nullRuns = new ArrayList<ArrayList<Card>>(20);
        ArrayList<ArrayList<Card>> nullBooks = new ArrayList<ArrayList<Card>>(20);

        ArrayList<ArrayList<Card>> justRuns = checkRun1(wild, humanHand, nullRuns);
        ArrayList<ArrayList<Card>> justBooks = checkBook1(wild, humanHand, nullBooks);


        justBooks.addAll(justRuns);



        ArrayList<ArrayList<Card>> booksAndruns = justBooks;




        ArrayList<ArrayList<Card>> bestRunsAndBooksCurrentHand = goOutTest1(wild, humanHand, booksAndruns, booksAndruns, nullMinimum);


        ArrayList<Card> copyDiscard = new ArrayList<>(discardPile);

        ArrayList<Card> handWithDiscard = new ArrayList<>(humanHand);
        handWithDiscard.add(copyDiscard.get(0));
        copyDiscard.remove(0);

        deck.sortHand(handWithDiscard, wild);

        justRuns.clear();
        justBooks.clear();
        booksAndruns.clear();

        justRuns = checkRun1(wild, handWithDiscard, nullRuns);
        justBooks = checkBook1(wild, handWithDiscard, nullBooks);

        justBooks.addAll(justRuns);

        booksAndruns = justBooks;


        ArrayList<ArrayList<Card>> bestRunsAndBooksDiscardHand = goOutTest1(wild, handWithDiscard, booksAndruns, booksAndruns, nullMinimum);




        justRuns.clear();
        justBooks.clear();
        booksAndruns.clear();

        justRuns = checkSmallRun1(wild, humanHand, nullRuns);
        justBooks = checkSmallBook1(wild, humanHand, nullBooks);

        justBooks.addAll(justRuns);

        booksAndruns = justBooks;


        ArrayList<ArrayList<Card>> bestRunsAndBooksSmallCurrent = goOutTestSmall1(wild, humanHand, booksAndruns, booksAndruns, nullMinimum);



        justRuns.clear();
        justBooks.clear();
        booksAndruns.clear();

        justRuns = checkSmallRun1(wild, handWithDiscard, nullRuns);
        justBooks = checkSmallBook1(wild, handWithDiscard, nullBooks);

        justBooks.addAll(justRuns);

        booksAndruns = justBooks;


        ArrayList<ArrayList<Card>> bestRunsAndBooksSmallDiscard = goOutTestSmall1(wild, handWithDiscard, booksAndruns, booksAndruns, nullMinimum);







        String result = "";


        if(discardPile.get(0).getValue() == 50 || discardPile.get(0).getValue() == wild)
        {


            result = "The computer recommends you to pick ... " + deck.printCard(discardPile.get(0)) + " from the discard pile, because it is a wild card.\n";
            return result;


        }






        if(bestRunsAndBooksCurrentHand.get(0).size() > 13 && bestRunsAndBooksDiscardHand.get(0).size() > 13)
        {

                result = "The computer recommends you to pick ... " + deck.printCard(drawPile.get(0)) + " from the draw pile, because it could not find any books/runs in your hand.\n";
                return result;

        }


        if(bestRunsAndBooksCurrentHand.get(0).size() >= bestRunsAndBooksDiscardHand.get(0).size())
        {
            ArrayList<ArrayList<Card>> resultBest = new ArrayList<ArrayList<Card>>(bestRunsAndBooksDiscardHand);
            resultBest.remove(0);

            result = "The computer recommends you to pick ... " + deck.printCard(discardPile.get(0)) + " from the discard pile, because it wants to build ... \n" + printDoubleArrayList(resultBest) + "\n";
        }
        else
        {
            ArrayList<ArrayList<Card>> resultBest = new ArrayList<ArrayList<Card>>(bestRunsAndBooksCurrentHand);
            resultBest.remove(0);

            result = "The computer recommends you to pick from the draw pile because it wants to build ... \n" + printDoubleArrayList(resultBest) + "\n";
        }

        return result;


    }

    /* *********************************************************************
         Function Name: askHelpDiscarding
         Purpose: EXACT same function as startTurnDiscard from computer class, except return string of help
         Parameters:
                     integer for wild, card array list of computer hand, draw pile, and discard pile.
         Return Value: String of the computer's decision.

         Algorithm:
                     1) Create a null value for best books and runs.
                     2) Call functions checkRun1 and checkBook1 to get all possible books and runs of current computer hand.
                     3) Call goOutTest1 to get best books and runs.
                     4) Return string to Discard a leftover card of best books and runs.
                     5) Else, return string to discard the last card of computer's hand.
         ********************************************************************* */
    public String askHelpDiscarding(int wild, ArrayList<Card> humanHand, ArrayList<Card> drawPile, ArrayList<Card> discardPile)
    {

        ArrayList<ArrayList<Card>> nullMinimum = new ArrayList<>(10);

        ArrayList<Card> nullCardsForMinimum = new ArrayList<>(20);
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));

        nullMinimum.add(nullCardsForMinimum);



        ArrayList<ArrayList<Card>> nullRuns = new ArrayList<ArrayList<Card>>(20);
        ArrayList<ArrayList<Card>> nullBooks = new ArrayList<ArrayList<Card>>(20);

        ArrayList<ArrayList<Card>> justRuns = checkRun1(wild, humanHand, nullRuns);
        ArrayList<ArrayList<Card>> justBooks = checkBook1(wild, humanHand, nullBooks);

        justBooks.addAll(justRuns);

        ArrayList<ArrayList<Card>> booksAndruns = justBooks;


        ArrayList<ArrayList<Card>> bestRunsandBooksBeforeDiscard = goOutTest1(wild, humanHand, booksAndruns, booksAndruns, nullMinimum);

        //look to discard
        //make best runs and books
        //try to discard last one



        justRuns.clear();
        justBooks.clear();
        booksAndruns.clear();

        justRuns = checkSmallRun1(wild, humanHand, nullRuns);
        justBooks = checkSmallBook1(wild, humanHand, nullBooks);

        justBooks.addAll(justRuns);

        booksAndruns = justBooks;


        ArrayList<ArrayList<Card>> bestRunsandBooksBeforeDiscardSmall = goOutTestSmall1(wild, humanHand, booksAndruns, booksAndruns, nullMinimum);






        String result = "";

        ArrayList<ArrayList<Card>> resultBest = new ArrayList<ArrayList<Card>>(bestRunsandBooksBeforeDiscard);
        resultBest.remove(0);


        ArrayList<ArrayList<Card>> resultBestSmall = new ArrayList<ArrayList<Card>>(bestRunsandBooksBeforeDiscardSmall);
        resultBestSmall.remove(0);

        if(bestRunsandBooksBeforeDiscard.get(0).size() > 13)
        {

                result = "The computer recommends you to discard ... " + deck.printCard(humanHand.get(0)) + " ... because it could not find any books/runs in your hand.\n";
                return result;


        }
        else
        {
            result = "The computer recommends you to discard ... " + deck.printCard(bestRunsandBooksBeforeDiscard.get(0).get(bestRunsandBooksBeforeDiscard.get(0).size()-1)) + " ... from your hand because it didn't add to ... \n" + printDoubleArrayList(resultBest) + "\n";

        }




        return result;


    }

    /* *********************************************************************
          Function Name: askHelpBuilding
          Purpose: Help for human building books/runs
          Parameters:
                      integer for wild, card array list of computer hand, draw pile, and discard pile.
          Return Value: String of the computer's decision.

          Algorithm:
                      1) Create a null value for best books and runs.
                      2) Call functions checkRun1 and checkBook1 to get all possible books and runs of current computer hand.
                      3) Call goOutTest1 to get best books and runs.
                      4) Call same smallCheckRun1 and smallCheckBook1 to get runs and books size less than 3
                      5) Call goOutTestSmall1 function to get best books and runs of those
                      4) Return string of best books and runs found if there are any, if not, return no books and runs

          ********************************************************************* */
    public String askHelpBuilding(int wild, ArrayList<Card> humanHand, ArrayList<Card> drawPile, ArrayList<Card> discardPile)
    {
        ArrayList<ArrayList<Card>> nullMinimum = new ArrayList<>(10);

        ArrayList<Card> nullCardsForMinimum = new ArrayList<>(20);
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));
        nullCardsForMinimum.add(new Card("3","2"));

        nullMinimum.add(nullCardsForMinimum);


        //THIS IS CHECKING FOR COMPUTER PICK UP CURRENT HAND
        ArrayList<ArrayList<Card>> nullRuns = new ArrayList<ArrayList<Card>>(20);
        ArrayList<ArrayList<Card>> nullBooks = new ArrayList<ArrayList<Card>>(20);

        ArrayList<ArrayList<Card>> justRuns = checkRun1(wild, humanHand, nullRuns);
        ArrayList<ArrayList<Card>> justBooks = checkBook1(wild, humanHand, nullBooks);


        justBooks.addAll(justRuns);

        ArrayList<ArrayList<Card>> booksAndruns = justBooks;


        ArrayList<ArrayList<Card>> bestRunsAndBooksCurrentHand = goOutTest1(wild, humanHand, booksAndruns, booksAndruns, nullMinimum);


        ArrayList<ArrayList<Card>> resultBest = new ArrayList<ArrayList<Card>>(bestRunsAndBooksCurrentHand);
        resultBest.remove(0);




        justRuns.clear();
        justBooks.clear();
        booksAndruns.clear();

        justRuns = checkSmallRun1(wild, humanHand, nullRuns);
        justBooks = checkSmallBook1(wild, humanHand, nullBooks);

        justBooks.addAll(justRuns);

        booksAndruns = justBooks;


        ArrayList<ArrayList<Card>> bestRunsandBooksCurrentHandSmall = goOutTestSmall1(wild, humanHand, booksAndruns, booksAndruns, nullMinimum);


        ArrayList<ArrayList<Card>> resultBestSmall = new ArrayList<ArrayList<Card>>(bestRunsandBooksCurrentHandSmall);
        resultBestSmall.remove(0);





        String result = "";


        if(bestRunsAndBooksCurrentHand.get(0).size() > 13)
        {
            if(bestRunsandBooksCurrentHandSmall.get(0).size() > 13)
            {
                result = "The computer could not find any way to build runs/books in your hand.\n";
                return result;

            }
            else
            {
                result = "The computer recommends you to build books/runs of ... \n" + printDoubleArrayList(resultBestSmall);
                return result;
            }

        }
        else
        {
            result = "The computer recommends you to build books/runs of ... \n" + printDoubleArrayList(resultBest);


            return result;
        }



    }




    /* *********************************************************************
Function Name: checkSmallRun1
Purpose: EXACT same function as checkRun1, but is also looking for smaller books and runs
Parameters: wild for round, player's hand, and all runs which starts as NULL
Return Value: all runs in hand
Local Variables:
            none
Algorithm:
            1) Calls checkRuns2 with first card in hand.
            2) If checkRuns2 returns the same value of runs, then recursively call function with leftover hand and same runs.
            3) If not same value, then recursively call function with leftover hand and adding found runs found in checkRuns2.
Assistance Received: none
********************************************************************* */
    public ArrayList<ArrayList<Card>> checkSmallRun1(int wild, ArrayList<Card> hand, ArrayList<ArrayList<Card>> runs) {
        Deck deck = new Deck();
        if (hand.size() == 0) {
            return runs;
        } else {
            ArrayList<Card> copyHand = new ArrayList<Card>(hand);
            copyHand.remove(0);


            ArrayList<ArrayList<Card>> firstRunCheck = checkSmallRun2(wild, wild, hand.get(0), copyHand, runs);

            if (firstRunCheck.size() == runs.size()) {
                return checkSmallRun1(wild, copyHand, runs);
            } else {
                return checkSmallRun1(wild, copyHand, firstRunCheck);
            }
        }

    }



    /* *********************************************************************
    Function Name: checkSmallRun2
    Purpose: EXACT same function as checkRun2, but is also looking for smaller books and runs
    Parameters: wild for round, number for round, card to check for runs, player's hand, and all runs already found
    Return Value: all runs found from card
    Local Variables:
                none
    Algorithm:
                1) Calls checkRuns3 with card.
                2) checkRuns3 is looking for a run with size number.
                3) If it returns a run of size number, then add that returned run to runs parameter of checkRuns2.
                   4) Recursive call checkRuns2. with updated run list and decreased number size-1 to find new run of that new number size.
               5) If it does not return run of size number, then don't add to runs parameter, and recursive call with same runs and number-1.
               6) Returns all runs to checkRuns1 once number is less than 3, so it doesn't look for a run of size 2
    ********************************************************************* */
    public ArrayList<ArrayList<Card>> checkSmallRun2(int wild, int number, Card checkingCard, ArrayList<Card> restOfHand, ArrayList<ArrayList<Card>> runs) {
        Deck deck = new Deck();
        if (number < 2) {
            return runs;
        } else {
            ArrayList<Card> firstCheckingRun = new ArrayList<Card>(13);
            firstCheckingRun.add(checkingCard);

            ArrayList<Card> firstRunSize = checkSmallRun3(wild, number, checkingCard, restOfHand, firstCheckingRun, 1);

            if (firstRunSize.size() == number) {

                runs.add(firstRunSize);


                return checkSmallRun2(wild, number - 1, checkingCard, restOfHand, runs);
            } else {
                return checkSmallRun2(wild, number - 1, checkingCard, restOfHand, runs);
            }
        }

    }



    /* *********************************************************************
Function Name: checkSmallRun3
Purpose: EXACT same function as checkRun3, but is also looking for smaller books and runs
Parameters: wild for round, number for round, card to check for runs, player's hand, and run found, runIncrement that starts at 1
Return Value: a run of size number found from card or a run that when there are no more cards in hand to check
Local Variables:
            none
Algorithm:
           1) Function finally returns run when there are no more cards in hand to check, or the length of run is the number needed.
           2) Checks if the checking cards value + runIncrement is the same value as first of restOfHand and if they have the same suite
           3) Checks if the rest of hand first value is a wild
           4) Checks if the rest of hand first value is a joker
           5) Checks if the checking cards value + runIncrement+1 is the same value as the first of restOfHand and if they have the same suite.
                6) Checks if there is a wild/joker at the end of the hand. If so, Adds that card to the run.
           7) Else, return the rest of hand without the first card of it, not adding to the run.
    ********************************************************************* */
    public ArrayList<Card> checkSmallRun3(int wild, int number, Card checkingCard, ArrayList<Card> restOfHand, ArrayList<Card> run, int runIncrement) {

        Deck deck = new Deck();
        if (run.size() == number) {
            return run;
        } else if (restOfHand.size() == 0) {

            return run;
        }
        ArrayList<Card> newHand = new ArrayList<Card>(restOfHand);
        newHand.remove(0);

        ArrayList<Card> newRun = new ArrayList<Card>(run);
        newRun.add(restOfHand.get(0));


        if (checkingCard.getValue() + runIncrement == restOfHand.get(0).getValue() && checkingCard.getSuite() == restOfHand.get(0).getSuite()) {
            return checkSmallRun3(wild, number, checkingCard, newHand, newRun, runIncrement + 1);
        } else if (restOfHand.get(0).getValue() == 50) {
            return checkSmallRun3(wild, number, checkingCard, newHand, newRun, runIncrement + 1);
        } else if (restOfHand.get(0).getValue() == wild) {
            return checkSmallRun3(wild, number, checkingCard, newHand, newRun, runIncrement + 1);
        } else if ((checkingCard.getSuite() == restOfHand.get(0).getSuite() && checkingCard.getValue() + (runIncrement + 1) == restOfHand.get(0).getValue()) && (restOfHand.get(restOfHand.size() - 1).getValue() == 50 || restOfHand.get(restOfHand.size() - 1).getValue() == wild)) {
            ArrayList<Card> newGapHand = new ArrayList<Card>(restOfHand);
            newGapHand.remove(newGapHand.size() - 1);
            newGapHand.remove(0);

            ArrayList<Card> newGapRun = new ArrayList<Card>(run);
            newGapRun.add(restOfHand.get(restOfHand.size() - 1));
            newGapRun.add(restOfHand.get(0));


            return checkSmallRun3(wild, number, checkingCard, newGapHand, newGapRun, runIncrement + 2);
        } else {
            return checkSmallRun3(wild, number, checkingCard, newHand, run, runIncrement);
        }


    }


    /* *********************************************************************
Function Name: checkBooks1
Purpose: EXACT same function as checkBook1, but looking for books size < 3
Parameters: wild for round, player's hand, and all books which starts as NULL
Return Value: all books in hand
Local Variables:
            none
Algorithm:
            1) Calls checkBooks2 with first card in hand.
            2) If checkBooks2 returns the same value of books, then recursively call function with leftover hand and same books.
            3) If not same value, then recursively call function with leftover hand and adding found books found in checkBooks2.

  ********************************************************************* */
    public ArrayList<ArrayList<Card>> checkSmallBook1(int wild, ArrayList<Card> hand, ArrayList<ArrayList<Card>> books) {
        Deck deck = new Deck();
        if (hand.size() == 0) {

            return books;
        } else {
            ArrayList<Card> copyHand = new ArrayList<Card>(hand);
            copyHand.remove(0);

            ArrayList<ArrayList<Card>> firstBookCheck = checkSmallBook2(wild, wild, hand.get(0), copyHand, books);

            if (firstBookCheck.size() == books.size()) {
                return checkSmallBook1(wild, copyHand, books);
            } else {
                return checkSmallBook1(wild, copyHand, firstBookCheck);
            }
        }

    }


    /* *********************************************************************
Function Name: checkSmallBook2
Purpose: EXACT same function as checkBook2, but looking for books size < 3
Parameters: wild for round, number for round, card to check for books, player's hand, and all books already found
Return Value: all books found from card
Local Variables:
          none
Algorithm:
          1) Calls checkBooks3 with card.
          2) checkBooks3 is looking for a book with size number.
          3) If it returns a book of size number, then add that returned book to books parameter of checkBooks2.
             4) Recursive call checkBooks2 with updated book list and decreased number size-1 to find new book of that new number size.
         5) If it does not return book of size number, then don't add to books parameter, and recursive call with same books and number-1.
         6) Returns all books to checkBooks1 once number is less than 3, so it doesn't look for a book of size 2

********************************************************************* */
    public ArrayList<ArrayList<Card>> checkSmallBook2(int wild, int number, Card checkingCard, ArrayList<Card> restOfHand, ArrayList<ArrayList<Card>> books) {
        if (number < 2) {
            return books;
        } else {
            ArrayList<Card> firstCheckingBook = new ArrayList<Card>(13);
            firstCheckingBook.add(checkingCard);

            ArrayList<Card> firstBookSize = checkSmallBook3(wild, number, checkingCard, restOfHand, firstCheckingBook);

            if (firstBookSize.size() == number) {

                books.add(firstBookSize);

                return checkSmallBook2(wild, number - 1, checkingCard, restOfHand, books);
            } else {
                return checkSmallBook2(wild, number - 1, checkingCard, restOfHand, books);
            }
        }

    }




         /* *********************************************************************
Function Name: checkSmallBook3
Purpose: EXACT same function as checkBook3, but looking for books size < 3
Parameters: wild for round, number for round, card to check for books, player's hand, and book found
Return Value: a book of size number found from card or a book that when there are no more cards in hand to check
Local Variables:
            none
Algorithm:
            1) Function finally returns book when there are no more cards in hand to check, or the length of book is the number needed.
            2) Checks if the checking card's value is the same as the rest of hand first value, if so, add that first card to the book
            3) Checks if the first card of rest of hand is a wild
            4) Checks if the first card of rest of hand is a joker
            5) Else, recursively call with removing the first card of rest of hand, and the same book

  ********************************************************************* */

    public ArrayList<Card> checkSmallBook3(int wild, int number, Card checkingCard, ArrayList<Card> restOfHand, ArrayList<Card> book) {


        if (book.size() == number) {
            return book;
        } else if (restOfHand.size() == 0) {
            return book;
        }
        ArrayList<Card> newHand = new ArrayList<Card>(restOfHand);
        newHand.remove(0);

        ArrayList<Card> newBook = new ArrayList<Card>(book);
        newBook.add(restOfHand.get(0));


        if (checkingCard.getValue() == restOfHand.get(0).getValue()) {
            return checkSmallBook3(wild, number, checkingCard, newHand, newBook);
        } else if (restOfHand.get(0).getValue() == wild) {
            return checkSmallBook3(wild, number, checkingCard, newHand, newBook);
        } else if (restOfHand.get(0).getValue() == 50) {
            return checkSmallBook3(wild, number, checkingCard, newHand, newBook);
        } else {
            return checkSmallBook3(wild, number, checkingCard, newHand, book);
        }


    }


    /* *********************************************************************
   Function Name: goOutTestSmall1
  Purpose: EXACT same function as goOutTest1. BUT looks for books and runs size < 3 .Returns best possible combination of books and runs as list, with leftover card in first of list
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
    public ArrayList<ArrayList<Card>> goOutTestSmall1(int wild, ArrayList<Card> hand, ArrayList<ArrayList<Card>> combinations, ArrayList<ArrayList<Card>> wholeList, ArrayList<ArrayList<Card>> minimum) {
        if (wholeList.size() == 0) {
            return minimum;
        } else {
            ArrayList<Card> removedHand = new ArrayList<Card>(hand);
            removedHand.removeAll(wholeList.get(0));

            ArrayList<ArrayList<Card>> copyWholeList = new ArrayList<ArrayList<Card>>(wholeList);
            copyWholeList.remove(0);

            ArrayList<ArrayList<Card>> firstOfWholeList = new ArrayList<ArrayList<Card>>();
            firstOfWholeList.add(0, wholeList.get(0));

            ArrayList<ArrayList<Card>> possible = goOutTestSmall2(wild, removedHand, firstOfWholeList);

            if (possible.get(0).size() < 1) {
            }

            if (hand.size() > wild && possible.get(0).size() < 1) {
                return goOutTestSmall1(wild, hand, copyWholeList, copyWholeList, minimum);
            } else if (possible.get(0).size() < minimum.get(0).size()) {
                return goOutTestSmall1(wild, hand, copyWholeList, copyWholeList, possible);
            } else {
                return goOutTestSmall1(wild, hand, copyWholeList, copyWholeList, minimum);

            }
        }


    }


    /* *********************************************************************
Function Name: goOutTest2
Purpose: EXACT same function as goOutTest2. BUT looks for books and runs size < 3 .Returns a combination of books/runs when beginning with one book/run from goOutTest1
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
    public ArrayList<ArrayList<Card>> goOutTestSmall2(int wild, ArrayList<Card> hand, ArrayList<ArrayList<Card>> possible) {
        ArrayList<ArrayList<Card>> nullRuns = new ArrayList<ArrayList<Card>>(1);
        ArrayList<ArrayList<Card>> nullBooks = new ArrayList<ArrayList<Card>>(1);

        ArrayList<ArrayList<Card>> justRuns = checkSmallRun1(wild, hand, nullRuns);
        ArrayList<ArrayList<Card>> justBooks = checkSmallBook1(wild, hand, nullBooks);

        justBooks.addAll(justRuns);

        ArrayList<ArrayList<Card>> booksAndruns = justBooks;

        if (booksAndruns.size() == 0) {
            ArrayList<ArrayList<Card>> finalPossible = new ArrayList<ArrayList<Card>>(20);


            finalPossible.add(0, hand);
            finalPossible.addAll(1, possible);

            return finalPossible;
        } else {
            ArrayList<Card> removedHand = new ArrayList<Card>(hand);
            removedHand.removeAll(booksAndruns.get(0));

            ArrayList<ArrayList<Card>> newPossible = new ArrayList<ArrayList<Card>>(possible);
            newPossible.add(0, booksAndruns.get(0));

            ArrayList<ArrayList<Card>> test = goOutTestSmall2(wild, removedHand, newPossible);


            if (test.get(0).size() < 1) {
                return test;
            } else {
                return test;
            }


        }


    }



   //Returns a string value of a double array list of card objects.
    public String printDoubleArrayList(ArrayList<ArrayList<Card>> doubleArray)
    {
        String noRuns = "No runs";
        if(doubleArray.size() < 1)
        {
            return noRuns;
        }

        String finalDoubleArray = "";
        for(int i = 0; i < doubleArray.size(); i++)
        {
            for(int j=0; j < doubleArray.get(i).size(); j++)
            {
                finalDoubleArray += doubleArray.get(i).get(j).getStringValue() + "" + doubleArray.get(i).get(j).getSuite() + " ";
            }
            finalDoubleArray += "\n";
        }
        return finalDoubleArray;
    }




}
