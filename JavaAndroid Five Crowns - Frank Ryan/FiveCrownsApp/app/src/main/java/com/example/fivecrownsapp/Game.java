package com.example.fivecrownsapp;

public class Game {

    private int humanPoints;
    private int computerPoints;
    private int roundNumber;

    public Game()
    {
        humanPoints = 0;
        computerPoints = 0;
        roundNumber = 1;
    }

    //Game Class constructor if there are human points and computer points other than 0
    public Game(int a_humanPoints, int a_computerPoints, int a_roundNumber)
    {
        humanPoints = a_humanPoints;
        computerPoints = a_computerPoints;
        roundNumber = a_roundNumber;
    }

    //Setters and Getters for points
    public void setHumanPoints(int pointsToAdd)
    {
        humanPoints += pointsToAdd;
    }

    public void setComputerPoints(int pointsToAdd)
    {
        computerPoints += pointsToAdd;
    }


    public int getHumanPoints()
    {
        return humanPoints;
    }

    public int getComputerPoints()
    {
        return computerPoints;
    }

    public void nextRound()
    {
        roundNumber = roundNumber + 1;
    }


}
