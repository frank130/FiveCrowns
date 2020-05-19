package com.example.fivecrownsapp;


import java.io.Serializable;
import java.util.ArrayList;

public class Round implements Serializable {

    private ArrayList<Card> drawPile;
    private ArrayList<Card> discardPile;
    private ArrayList<Card> computerHand;
    private ArrayList<Card> humanHand;

    private Human human = new Human();
    private Computer computer = new Computer();

    private Deck deck = new Deck();
    private int roundNumber;

    private boolean canDiscard = false;

    private boolean goOutDecision = false;

    private boolean humanTurn;

    private boolean winningCondition;

    private int whichHelp;

    public Round()
    {

    }
    public Round (int a_roundNumber)
    {
        roundNumber = a_roundNumber;


        deck.shuffleDeck();
        drawPile = deck.createDraw();
        discardPile = deck.createDiscard(drawPile);

        computerHand = deck.createPlayerHand(roundNumber);
        humanHand = deck.createPlayerHand(roundNumber);

        deck.sortHand(humanHand, roundNumber+2);
        deck.sortHand(computerHand, roundNumber+2);


        System.out.println(deck.printCards(humanHand));
        System.out.println(deck.printCards(computerHand));


    }

    public Round (int a_roundNumber, ArrayList<Card> humanCards, ArrayList<Card> computerCards, ArrayList<Card> drawCards, ArrayList<Card> discardCards, boolean whichTurn)
    {
        roundNumber = a_roundNumber;

        humanHand = humanCards;

        computerHand = computerCards;

        drawPile = drawCards;

        discardPile = discardCards;

        humanTurn = whichTurn;


    }



    public String help()
    {
        String nullResult = "";
        if(getWhichHelp() == 1)
        {
            ArrayList<Card> copyHand = new ArrayList<>(humanHand);
            deck.sortHand(copyHand, roundNumber+2);



            String result = human.askHelpPicking(roundNumber+2, copyHand, drawPile, discardPile);
            return result;
        }
        else if(getWhichHelp() == 2)
        {
            ArrayList<Card> copyHand = new ArrayList<>(humanHand);
            deck.sortHand(copyHand, roundNumber+2);

            String result = human.askHelpDiscarding(roundNumber+2, copyHand, drawPile, discardPile);
            return result;
        }
        else if(getWhichHelp() == 3)
        {

            ArrayList<Card> copyHand = new ArrayList<>(humanHand);
            deck.sortHand(copyHand, roundNumber+2);


           String result = human.askHelpBuilding(roundNumber+2, copyHand, drawPile, discardPile);
           return result;
        }
        return nullResult;
    }




    public void pickFromDraw(boolean humanTurn)
    {
        if(humanTurn == true)
        {
            human.pickFromDraw(humanHand, drawPile);
            deck.sortHand(humanHand, roundNumber+2);
        }
        else
        {
            computer.pickFromDraw(computerHand, drawPile);
            deck.sortHand(computerHand, roundNumber+2);

        }


    }

    public void pickFromDiscard(boolean humanTurn)
    {
        if(humanTurn == true)
        {
            human.pickFromDiscard(humanHand, discardPile);
            deck.sortHand(humanHand, roundNumber+2);

        }
        else
        {
            computer.pickFromDiscard(computerHand, discardPile);
            deck.sortHand(computerHand, roundNumber+2);

        }


    }


    public boolean goOutTry(boolean whichPlayer)
    {


        if(whichPlayer == true)
        {
            deck.sortHand(humanHand, roundNumber+2);
            boolean humanOut = human.goOut(roundNumber+2, humanHand);
            return humanOut;
        }
        else
        {
            deck.sortHand(computerHand, roundNumber+2);
            boolean computerOut = computer.goOut(roundNumber+2, computerHand);
            return computerOut;
        }

    }

    public String getGoOutCards(boolean whichPlayer)
    {
        String result = "";
        if(whichPlayer == true)
        {
            deck.sortHand(humanHand, roundNumber+2);

            result = human.getGoOutCards(roundNumber+2, humanHand);
            return result;
        }
        else
        {
            deck.sortHand(computerHand, roundNumber+2);
            result = computer.getGoOutCards(roundNumber+2, computerHand);
            return result;
        }
    }







    public String startComputerTurnPickup()
    {
        deck.sortHand(computerHand, roundNumber+2);

       String result = computer.startTurnPickup(roundNumber+2, computerHand, drawPile, discardPile, winningCondition);

       return result;
    }

    public String startComputerTurnDiscard()
    {
        deck.sortHand(computerHand, roundNumber+2);

        String result = computer.startTurnDiscard(roundNumber+2, computerHand, discardPile, winningCondition);
        return result;
    }







    public void discardCard(boolean humanTurn, Card card)
    {
        if(humanTurn == true)
        {
            human.discardCard(humanHand, discardPile, card);

        }
        else
        {
            computer.discardCard(computerHand, discardPile, card);
        }
    }

    public int countCardPoints(boolean whichPlayer)
    {
        int points = 0;

        if(whichPlayer == true)
        {
            deck.sortHand(humanHand, roundNumber+2);
            points = human.putDownCards(roundNumber+2, humanHand);
        }
        else
        {
            deck.sortHand(computerHand, roundNumber+2);
            points = computer.putDownCards(roundNumber+2, computerHand);
        }


        return points;
    }


    public String getCountCardPoints(boolean whichPlayer)
    {

        String finalList = "";

        if(whichPlayer == true)
        {
            deck.sortHand(humanHand, roundNumber+2);
            finalList = human.getPutDownCards(roundNumber+2, humanHand);
        }
        else
        {
            deck.sortHand(computerHand, roundNumber+2);
            finalList = computer.getPutDownCards(roundNumber+2, computerHand);
        }


        return finalList;

    }







    public void setCanDiscard(boolean optionToDiscard)
    {
        if(optionToDiscard == true)
        {
            canDiscard = true;
        }
        else
        {
            canDiscard = false;
        }

    }

    public void setHumanTurn(boolean optionForTurn)
    {
        if(optionForTurn == true)
        {
            humanTurn = true;
        }
        else
        {
            humanTurn = false;
        }

    }

    public boolean getHumanTurn()
    {
        return humanTurn;

    }

    public void setGoOutDecision(boolean goOutOption)
    {
        if(goOutOption == true)
        {
            goOutDecision = true;
        }
        else
        {
            goOutDecision = false;
        }
    }

    public void setWinningCondition(boolean winning)
    {
        if(winning == true)
        {
            winningCondition = true;
        }
        else
        {
            winningCondition = false;
        }
    }

    public int getRoundNumber()
    {
        return roundNumber;

    }


    public boolean getWinningCondition()
    {
        return winningCondition;

    }

    public boolean getGoOutDecisionBoolean()
    {
        return goOutDecision;
    }



    public void setWhichHelp(int which)
    {
        if(which == 1)
        {
            whichHelp = 1;
        }
        else if(which == 2)
        {
            whichHelp = 2;
        }
        else
        {
            whichHelp = 3;
        }
    }

    public int getWhichHelp()
    {
        return whichHelp;
    }

    public ArrayList<Card> getHumanHand()
    {
        return humanHand;
    }
    public ArrayList<Card> getComputerHand()
    {
        return computerHand;
    }
    public ArrayList<Card> getDrawPile()
    {
        return drawPile;
    }
    public ArrayList<Card> getDiscardPile()
    {
        return discardPile;
    }

    public boolean getDiscardBoolean()
    {
        return canDiscard;
    }



    public void callHumanTurn()
    {
        human.startHumanTurn(roundNumber, humanHand, drawPile, discardPile);
    }


}
