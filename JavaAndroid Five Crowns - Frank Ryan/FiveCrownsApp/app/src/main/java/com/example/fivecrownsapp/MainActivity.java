package com.example.fivecrownsapp;

import androidx.appcompat.app.AppCompatActivity;

import android.content.res.AssetManager;
import android.widget.Button;
import android.os.Bundle;
import android.view.View;
import android.content.Intent;
import android.widget.EditText;
import android.widget.Toast;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Serializable;
import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //Setting design objects to respected variables
        final Button newGame = findViewById(R.id.newGame);

        final Button loadGame = findViewById(R.id.loadGame);

        final Button assetLoad = findViewById(R.id.assetButton);

        final Button deviceLoad = findViewById(R.id.deviceLoad);

        final EditText loadFile = findViewById(R.id.textView);



        loadFile.setVisibility(View.INVISIBLE);
        assetLoad.setVisibility(View.INVISIBLE);
        deviceLoad.setVisibility(View.INVISIBLE);


      //  loadFile.setText("Enter File Here");

        //Event handler for new game, sends to coin toss activity
        newGame.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {

                Intent intent = new Intent(MainActivity.this, GameSetup.class);

                MainActivity.this.startActivity(intent);

                finish();

            }

        });

        //If load game button is pressed, then set asset load and device load to visible
        loadGame.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {



                newGame.setVisibility(View.INVISIBLE);
                loadGame.setVisibility(View.INVISIBLE);
                assetLoad.setVisibility(View.VISIBLE);
                deviceLoad.setVisibility(View.VISIBLE);

                loadFile.setVisibility(View.VISIBLE);




            }

        });





                //Loads a text file from assets, using edit text field, calls load file
        assetLoad.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {

                //get the edit text area
                EditText file = findViewById(R.id.textView);
                //retrieve the filename
                String fileToLoad = file.getText().toString();

                //if the user didn't type anything, do not continue
                if (fileToLoad.equals(""))
                {
                    Toast.makeText(MainActivity.this, "Please Enter a filename", Toast.LENGTH_SHORT).show();
                }
                //load the file
                else
                {
                    loadFile(fileToLoad, true);
                }




            }

        });

            //Loads a text file from device load, using edit text field, calls load file
        deviceLoad.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {

                //get the edit text area
                EditText file = findViewById(R.id.textView);
                //retrieve the filename
                String fileToLoad = file.getText().toString();

                //if the user didn't type anything, do not continue
                if (fileToLoad.equals(""))
                {
                    Toast.makeText(MainActivity.this, "Please Enter a filename", Toast.LENGTH_SHORT).show();
                }
                //load the file
                else
                {
                    loadFile(fileToLoad, false);
                }




            }

        });

    }

    /* *********************************************************************
    Function Name: loadFile
    Purpose: Parses a loaded text file and passes to round activity
    Parameters:
                String of file name and boolean of asset load
    Return Value: The average grade in the class, a real value
    Local Variables:
                temp[], an integer array used to sort the grades
    Algorithm:
                1) Add all the grades
                2) Divide the sum by the number of students in class to calculate the average
    Assistance Received: none
    ********************************************************************* */
    public void loadFile(String a_fileName, boolean a_assetLoad)
    {
        //used if game is an asset load
        AssetManager assetMgmt;
        //buffer used to read the file
        BufferedReader buff;
        //used to open the file if load is from device
        FileInputStream fis;
        //used to read the file
        InputStreamReader isr;
        //used to open the file if it is being loaded from assets
        InputStream IS;


        //If the game is loaded from assets, then use assetmanager to load file
        try
        {
            //holds the line being parsed
            String line;

            //if file is in assets
            if(a_assetLoad)
            {
                assetMgmt = getAssets();
                IS = assetMgmt.open(a_fileName);
                buff = new BufferedReader(new InputStreamReader(IS));
            }
            //if the file is on the device
            else
            {
                fis = openFileInput(a_fileName);
                isr = new InputStreamReader(fis);
                buff = new BufferedReader(isr);
            }

            //used to store the loaded game info
            Game game = new Game();

            int round = 0;

            int humanScore = 0;
            int computerScore = 0;

            //Default variables for cards of text file
            ArrayList<Card> humanCards = new ArrayList<>(13);
            ArrayList<Card> computerCards = new ArrayList<>(13);
            ArrayList<Card> drawCards = new ArrayList<>(13);
            ArrayList<Card> discardCards = new ArrayList<>(13);


            boolean humanTurn = true;

            //retrieve the file
            while ((line = buff.readLine()) != null)
            {
                //if the line is blank, continue
                if(line.isEmpty())
                {
                    continue;
                }

                //trim the whitespace and split the line
                line = line.trim();
                String[] lineContents = line.split(" ");



                //if the round is being parsed
                if(lineContents[0].equals("Round:"))
                {
                    round = Integer.parseInt(lineContents[1]);
                    continue;
                }
                //if the computer info is being parsed
                else if(lineContents[0].equals("Computer:"))
                {
                    line = buff.readLine();
                    line = line.trim();
                    lineContents = line.split(" ");

                    //parse the computers score
                    computerScore = Integer.parseInt(lineContents[1]);

                    line = buff.readLine();
                    line = line.trim();
                    lineContents = line.split(" ");


                    //Parses the computer Hand
                    for(int i =1; i < lineContents.length; i++ )
                    {
                        lineContents[i].trim();

                        String value = lineContents[i].substring(0, (lineContents[i].length()/2));
                        String suite = lineContents[i].substring((lineContents[i].length()/2));

                        computerCards.add(new Card(value, suite));

                    }

                    continue;
                }
                //if the human info is being parsed
                else if(lineContents[0].equals("Human:"))
                {
                    line = buff.readLine();
                    line = line.trim();
                    lineContents = line.split(" ");

                    //pa rse the humans score
                    humanScore = Integer.parseInt(lineContents[1]);

                    line = buff.readLine();
                    line = line.trim();
                    lineContents = line.split("\\s+");


                    //Parses the human Hand
                    for(int i =1; i < lineContents.length; i++ )
                    {
                        lineContents[i].trim();

                        String value = lineContents[i].substring(0, (lineContents[i].length()/2));
                        String suite = lineContents[i].substring((lineContents[i].length()/2), 2);


                        humanCards.add(new Card(value, suite));

                    }


                    continue;
                }
                //Parses the Draw Hand
                else if(lineContents[0].equals("Draw"))
                {

                    lineContents[2].trim();

                    for(int i =2; i < lineContents.length; i++ )
                    {
                        lineContents[i].trim();

                        String value = lineContents[i].substring(0, (lineContents[i].length()/2));
                        String suite = lineContents[i].substring((lineContents[i].length()/2));

                        drawCards.add(new Card(value, suite));

                    }

                }
                //Parses the Discard Hand
                else if(lineContents[0].equals("Discard"))
                {
                    lineContents[2].trim();



                    for(int i =2; i < lineContents.length; i++ )
                    {
                        lineContents[i].trim();
                        String value = lineContents[i].substring(0, (lineContents[i].length()/2));
                        String suite = lineContents[i].substring((lineContents[i].length()/2));


                        discardCards.add(new Card(value, suite));

                    }

                }
                //Parsing who goes first
                else if(lineContents[0].equals("Next"))
                {

                    if(lineContents[2].trim().equals("Human"))
                    {
                        humanTurn = true;
                    }
                    else
                    {
                        humanTurn = false;
                    }
                }
                //if the files format is un recognized
                else
                {
                    Toast.makeText(MainActivity.this, "Unrecognized File Format: " + lineContents[0], Toast.LENGTH_SHORT).show();
                    return;
                }

            }
            Toast.makeText(MainActivity.this, "File Read Successfully", Toast.LENGTH_SHORT).show();


            //Constructs a round object with new values
            Round roundObj = new Round(round, humanCards, computerCards, drawCards, discardCards, humanTurn);

            Intent intent = new Intent(MainActivity.this, RoundActivity.class);

            Deck deck = new Deck();





            //Sets the intent variables to loaded cards and values
            intent.putExtra("RoundNumberExtra", round);
            intent.putExtra("ComputerScoreExtra", computerScore);
            intent.putExtra("HumanScoreExtra", humanScore);
            intent.putExtra("TurnExtra", humanTurn);
            intent.putExtra("RoundExtra", (Serializable) roundObj);
            intent.putExtra("LoadExtra", true);
            System.out.println("WHAT");

            MainActivity.this.startActivity(intent);


        }
        //Catching exceptions
        catch(FileNotFoundException e)
        {
            Toast.makeText(MainActivity.this, "The file was not found", Toast.LENGTH_SHORT).show();
        }
        catch (Exception e)
        {
            System.out.println(e);
            Toast.makeText(MainActivity.this, "Something went wrong", Toast.LENGTH_SHORT).show();
        }
    }
}
