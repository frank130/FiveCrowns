package com.example.fivecrownsapp;

import java.io.Serializable;
import java.util.ArrayList;

public class Computer extends Player implements Serializable
{
    private Deck deck = new Deck();

    public Computer()
    {

    }


    /* *********************************************************************
    Function Name: startTurnPickup
    Purpose: Computer logic to pick from draw pile or discard pile.
    Parameters:
                integer for wild, card array list of computer hand, draw pile, and discard pile.
    Return Value: String of the computer's decision.

    Algorithm:
                1) Create a null value for best books and runs.
                2) Call functions checkRun1 and checkBook1 to get all possible books and runs of current computer hand.
                3) Add discard pile card to computer hand, and call checkRun1 and checkBook1 to get possible books and runs of that hand with discard,
                4) Call goOutTest1 for hand with discard and current hand
                5) Compare best books and runs from current hand and discard hand
                6) Pick from draw if the discard does not create better books and runs than current.
                7) Pick from discard if the discard does create better books and runs than current.
    Assistance Received: none
    ********************************************************************* */
    public String startTurnPickup(int wild, ArrayList<Card> computerHand, ArrayList<Card> drawPile, ArrayList<Card> discardPile, boolean winningCondition)
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

        ArrayList<ArrayList<Card>> justRuns = checkRun1(wild, computerHand, nullRuns);
        ArrayList<ArrayList<Card>> justBooks = checkBook1(wild, computerHand, nullBooks);


        justBooks.addAll(justRuns);

        ArrayList<ArrayList<Card>> booksAndruns = justBooks;


        //Gets best books and runs current hand
        ArrayList<ArrayList<Card>> bestRunsAndBooksCurrentHand = goOutTest1(wild, computerHand, booksAndruns, booksAndruns, nullMinimum);


        //Adds discard to current hand
        ArrayList<Card> copyDiscard = new ArrayList<>(discardPile);

        ArrayList<Card> handWithDiscard = new ArrayList<>(computerHand);
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

        //Gets best books and runs with discard hand
        ArrayList<ArrayList<Card>> bestRunsAndBooksDiscardHand = goOutTest1(wild, handWithDiscard, booksAndruns, booksAndruns, nullMinimum);


        justRuns.clear();
        justBooks.clear();
        booksAndruns.clear();

        justRuns = checkSmallRun1(wild, computerHand, nullRuns);
        justBooks = checkSmallBook1(wild, computerHand, nullBooks);

        justBooks.addAll(justRuns);

        booksAndruns = justBooks;


        ArrayList<ArrayList<Card>> bestRunsAndBooksSmallCurrent = goOutTestSmall1(wild, computerHand, booksAndruns, booksAndruns, nullMinimum);



        justRuns.clear();
        justBooks.clear();
        booksAndruns.clear();

        justRuns = checkSmallRun1(wild, handWithDiscard, nullRuns);
        justBooks = checkSmallBook1(wild, handWithDiscard, nullBooks);

        justBooks.addAll(justRuns);

        booksAndruns = justBooks;


        ArrayList<ArrayList<Card>> bestRunsAndBooksSmallDiscard = goOutTestSmall1(wild, handWithDiscard, booksAndruns, booksAndruns, nullMinimum);






        String result = "";

      //If the discard if a wild, pick it up
        if(discardPile.get(0).getValue() == 50 || discardPile.get(0).getValue() == wild)
        {


                result = "The computer picked ... " + deck.printCard(discardPile.get(0)) + " from the discard pile, because it is a wild card.\n";
                pickFromDiscard(computerHand, discardPile);
                return result;


        }




        //If no books and runs were found in both current and discard hand, then pick from draw pile
        if(bestRunsAndBooksCurrentHand.get(0).size() > 13 && bestRunsAndBooksDiscardHand.get(0).size() > 13)
        {


                result = "The computer picked ... " + deck.printCard(drawPile.get(0)) + " from the draw pile, because it could not find any books/runs in its hand.\n";
                pickFromDraw(computerHand, drawPile);
                return result;




        }



        //If best books and runs of current hand has equal or more leftover cards than discard hand's best books and runs, then pick from discard pile
        if(bestRunsAndBooksCurrentHand.get(0).size() >= bestRunsAndBooksDiscardHand.get(0).size())
        {
            ArrayList<ArrayList<Card>> resultBest = new ArrayList<ArrayList<Card>>(bestRunsAndBooksDiscardHand);
            resultBest.remove(0);

            result = "The computer picked ... " + deck.printCard(discardPile.get(0)) + " from the discard pile, because it wants to build ... \n" + printDoubleArrayList(resultBest) + "\n";
            pickFromDiscard(computerHand, discardPile);

        return result;

        }

        //If best books and runs of discard hand has more leftover cards than current hand's best books and runs, then pick from draw pile
        else
        {
            ArrayList<ArrayList<Card>> resultBest = new ArrayList<ArrayList<Card>>(bestRunsAndBooksCurrentHand);
            resultBest.remove(0);

            result = "The computer picked ... " + deck.printCard(drawPile.get(0)) + " from the draw pile, because it wants to build ... \n" + printDoubleArrayList(resultBest) + "\n";
            pickFromDraw(computerHand, drawPile);


        }

    return result;



    }



    /* *********************************************************************
      Function Name: startTurnDiscard
      Purpose: Computer logic to discard a card.
      Parameters:
                  integer for wild, card array list of computer hand, draw pile, and discard pile.
      Return Value: String of the computer's decision.

      Algorithm:
                  1) Create a null value for best books and runs.
                  2) Call functions checkRun1 and checkBook1 to get all possible books and runs of current computer hand.
                  3) Call goOutTest1 to get best books and runs.
                  4) Discard a leftover card of best books and runs.
                  5) Else, discard the last card of computer's hand.
      ********************************************************************* */
    public String startTurnDiscard(int wild, ArrayList<Card> computerHand, ArrayList<Card> discardPile, boolean winningCondition)
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


        //Creating all books and runs from current computer hand
        ArrayList<ArrayList<Card>> nullRuns = new ArrayList<ArrayList<Card>>(20);
        ArrayList<ArrayList<Card>> nullBooks = new ArrayList<ArrayList<Card>>(20);

        ArrayList<ArrayList<Card>> justRuns = checkRun1(wild, computerHand, nullRuns);
        ArrayList<ArrayList<Card>> justBooks = checkBook1(wild, computerHand, nullBooks);

        justBooks.addAll(justRuns);

        ArrayList<ArrayList<Card>> booksAndruns = justBooks;

        //Calling go out function to get best books and runs
        ArrayList<ArrayList<Card>> bestRunsandBooksBeforeDiscard = goOutTest1(wild, computerHand, booksAndruns, booksAndruns, nullMinimum);

        //look to discard
        //make best runs and books
        //try to discard last one

        justRuns.clear();
        justBooks.clear();
        booksAndruns.clear();

        justRuns = checkSmallRun1(wild, computerHand, nullRuns);
        justBooks = checkSmallBook1(wild, computerHand, nullBooks);

        justBooks.addAll(justRuns);

        booksAndruns = justBooks;


        ArrayList<ArrayList<Card>> bestRunsandBooksBeforeDiscardSmall = goOutTestSmall1(wild, computerHand, booksAndruns, booksAndruns, nullMinimum);





        String result = "";

        ArrayList<ArrayList<Card>> resultBest = new ArrayList<ArrayList<Card>>(bestRunsandBooksBeforeDiscard);
        resultBest.remove(0);


        ArrayList<ArrayList<Card>> resultBestSmall = new ArrayList<ArrayList<Card>>(bestRunsandBooksBeforeDiscardSmall);
        resultBestSmall.remove(0);

        //If no books and runs were found, then discard last card of hand
        if(bestRunsandBooksBeforeDiscard.get(0).size() > 13)
        {


                result = "The computer discarded ... " + deck.printCard(computerHand.get(0)) + " ... because it could not find any books/runs in his hand.\n";
                discardCard(computerHand, discardPile, computerHand.get(0));

                return result;

        }
        //Discard the last leftover card of best books and runs
        else
        {
            result = "The computer discarded ... " + deck.printCard(bestRunsandBooksBeforeDiscard.get(0).get(bestRunsandBooksBeforeDiscard.get(0).size()-1)) + " ... from its hand because it didn't add to ... \n" + printDoubleArrayList(resultBest) + "\n";
            discardCard(computerHand, discardPile, bestRunsandBooksBeforeDiscard.get(0).get(bestRunsandBooksBeforeDiscard.get(0).size()-1));

        }





        return result;

    }
}
