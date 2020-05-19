package com.example.fivecrownsapp;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Vector;

import java.util.Collections;

public class Deck implements Serializable {

    ArrayList<Card> cards = new ArrayList<>(116);

    //Deck constructor that creates the deck of cards through Card objects
    public Deck()
    {

        for(int i = 0; i < 2; i++)
        {


           cards.add(new Card("3","C"));
            cards.add(new Card("4","C"));
            cards.add(new Card("5","C"));
            cards.add(new Card("6","C"));
            cards.add(new Card("7","C"));
            cards.add(new Card("8","C"));
            cards.add(new Card("9","C"));
            cards.add(new Card("X","C"));
            cards.add(new Card("Q","C"));
            cards.add(new Card("K","C"));

            cards.add(new Card("3","H"));
            cards.add(new Card("4","H"));
            cards.add(new Card("5","H"));
            cards.add(new Card("6","H"));
            cards.add(new Card("7","H"));
            cards.add(new Card("8","H"));
            cards.add(new Card("9","H"));
            cards.add(new Card("X","H"));
            cards.add(new Card("Q","H"));
            cards.add(new Card("K","H"));

            cards.add(new Card("3","D"));
            cards.add(new Card("4","D"));
            cards.add(new Card("5","D"));
            cards.add(new Card("6","D"));
            cards.add(new Card("7","D"));
            cards.add(new Card("8","D"));
            cards.add(new Card("9","D"));
            cards.add(new Card("X","D"));
            cards.add(new Card("Q","D"));
            cards.add(new Card("K","D"));

            cards.add(new Card("3","S"));
            cards.add(new Card("4","S"));
            cards.add(new Card("5","S"));
            cards.add(new Card("6","S"));
            cards.add(new Card("7","S"));
            cards.add(new Card("8","S"));
            cards.add(new Card("9","S"));
            cards.add(new Card("X","S"));
            cards.add(new Card("Q","S"));
            cards.add(new Card("K","S"));

            cards.add(new Card("3","T"));
            cards.add(new Card("4","T"));
            cards.add(new Card("5","T"));
            cards.add(new Card("6","T"));
            cards.add(new Card("7","T"));
            cards.add(new Card("8","T"));
            cards.add(new Card("9","T"));
            cards.add(new Card("X","T"));
            cards.add(new Card("Q","T"));
            cards.add(new Card("K","T"));

            cards.add(new Card("J","1"));
            cards.add(new Card("J","2"));
            cards.add(new Card("J","3"));

        }
    }

    //Function to shuffle Cards in deck
    public void shuffleDeck()
    {
        Collections.shuffle(cards);

    }

    //Function to sort a player's hand, calls Card function to handle Card objects
    //If the card is a wild, then put it to the back
    public void sortHand(ArrayList<Card> hand, int wild)
    {
        Collections.sort(hand, new Card.OrderByValue());




        ArrayList<Card> wilds = new ArrayList<>(13);


        int handsize = hand.size();
        ArrayList<Card> copyHand = new ArrayList<>(hand);
        hand.clear();

        for(int i =0; i < copyHand.size(); i++)
        {
            if(copyHand.get(i).getValue() == wild)
            {
                wilds.add(copyHand.get(i));
            }
            else
            {
                hand.add(copyHand.get(i));
            }

        }

        hand.addAll(wilds);






    }

    //Gets a Card object as a string
    public String printCard(Card card)
    {
        String returnedCard = card.getStringValue() + "" + card.getSuite();
        return returnedCard;
    }



    //Creates the draw pile by returning the rest of cards
    public ArrayList<Card> createDraw()
    {
        return cards;
    }



    /* *********************************************************************
    Function Name: createDiscard
    Purpose: Creates the discard pile
    Parameters:
                Draw pile array list
    Return Value: String of the computer's decision.

    Algorithm:
                1) Gets the first card of draw pile and put into an array list.
                2) returns that array list as the discard pile, and removes that first card of the draw pile.
    Assistance Received: none
    ********************************************************************* */
    public ArrayList<Card> createDiscard(ArrayList<Card> drawPile)
    {
        ArrayList<Card> discardPile = new ArrayList<>(1);
        discardPile.add(drawPile.get(0));
        drawPile.remove(0);
        return discardPile;
    }

    //Creates a player hand based on the round number for how many cards each player needs
    public ArrayList<Card> createPlayerHand(int roundNumber)
    {
        ArrayList<Card> hand = new ArrayList<>(roundNumber+2);
        for(int i =0; i < roundNumber+2; i++)
        {
            hand.add(cards.get(0));
            cards.remove(0);
        }

        return hand;

    }



    //returns a whole array list of cards as a string
    public String printCards(ArrayList<Card> cardVector)
    {
        String finalCards = "";
        for(int i = 0; i < cardVector.size(); i++)
        {
            finalCards += cardVector.get(i).getStringValue() + "" + cardVector.get(i).getSuite() + " ";
        }
        return finalCards;
    }


}

