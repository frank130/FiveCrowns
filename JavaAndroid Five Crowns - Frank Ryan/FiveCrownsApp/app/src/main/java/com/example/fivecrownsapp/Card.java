package com.example.fivecrownsapp;

import java.io.Serializable;
import java.util.Comparator;

public class Card implements Serializable {

    private String a_value;
    private String a_suite;

    /* *********************************************************************
    Function Name: Card constructor
    Purpose: Create a Card object
    Parameters:
                string value, string suite
    Return Value: none
    Local Variables:
                none
    Algorithm:
                1) Sets parameters to private value and suite.
    Assistance Received: none
    ********************************************************************* */
    public Card(String value,String suite)
    {
        a_value = value;
        a_suite = suite;
    }

    //Get Value of card as Int
    public int getValue()
    {
        if(a_value.equals("X"))
        {
            return 10;
        }
        if(a_value.equals("J"))
        {
            if(a_suite.equals("1"))
            {
                return 50;
            }
            if(a_suite.equals("2"))
            {
                return 50;
            }
            if(a_suite.equals("3"))
            {
                return 50;
            }
            else
            {
                return 11;
            }
        }
        if(a_value.equals("Q"))
        {
            return 12;
        }
        if(a_value.equals("K"))
        {
            return 13;
        }
        else
        {
            return Integer.parseInt(a_value);
        }
    }

    //Gets value of card as string
    public String getStringValue()
    {
        return a_value;
    }

    //Gets suite of card as string
    public String getSuite()
    {
        return a_suite;
    }


    //Puts the value and suite as a string
    public String printCard()
    {
        String card = a_value + "" + a_suite;
        return card;
    }

    //Function that is used to sort cards in deck class.
    public static class OrderByValue implements Comparator<Card> {

        @Override
        public int compare(Card o1, Card o2) {
            return o1.getValue() > o2.getValue() ? 1 : (o1.getValue() < o2.getValue() ? -1 : 0);
        }
    }

}
