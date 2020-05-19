package com.example.fivecrownsapp;

import java.io.Serializable;
import java.util.ArrayList;

public class Human extends Player implements Serializable
{
    public Human()
    {

    }


    public ArrayList<Card> startHumanTurn(int roundNumber, ArrayList<Card> humanHand, ArrayList<Card> drawPile, ArrayList<Card> discardPile)
    {
        return humanHand;
    }
}
