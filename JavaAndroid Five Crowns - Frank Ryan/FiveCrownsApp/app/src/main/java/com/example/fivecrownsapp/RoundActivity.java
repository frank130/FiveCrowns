package com.example.fivecrownsapp;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.os.Vibrator;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.GridView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import com.google.android.material.snackbar.Snackbar;

import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Vector;

public class RoundActivity extends AppCompatActivity {

    private Round roundObj;
    private LinearLayout humanLayout;
    private LinearLayout computerLayout;
    private LinearLayout drawLayout;
    private LinearLayout discardLayout;

    private Game game;


    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.round_activity);

        //Called when a player goes out
        final Vibrator v = (Vibrator) getSystemService(Context.VIBRATOR_SERVICE);


        Intent intent = getIntent();

        //Default values
        int humanScore = 0;
        int computerScore = 0;
        int round = 0;
        boolean humanTurn = false;


        //Values of Android design, including round, points, human player buttons
        final TextView pickUpText = findViewById(R.id.pickUpText);

        TextView roundNum = findViewById(R.id.roundNumber);

        TextView humanPts = findViewById(R.id.humanPoints);

        TextView computerPts = findViewById(R.id.computerPoints);

        final Button newRound = findViewById(R.id.nextRoundButton);

        final Button makeMove = findViewById(R.id.makeMoveButton);
        final Button save = findViewById(R.id.saveGameButton);
        final Button askForHelp = findViewById(R.id.askHelpMoveButton);
        final Button quit = findViewById(R.id.quitGameButton);

        final Button tryToGoOut = findViewById(R.id.tryToGoOut);

        final Button startTurnButton = findViewById(R.id.startTurnButton);
        final Button endTurnButton = findViewById(R.id.endTurn);


        //Layouts for each card hand/pile
         humanLayout = findViewById(R.id.humanLayout);
         computerLayout = findViewById(R.id.computerLayout);
         drawLayout = findViewById(R.id.drawLayout);
         discardLayout = findViewById(R.id.discardLayout);




        boolean loadedGame = intent.getBooleanExtra("LoadExtra", false);



        //Checks if the game was loaded
        if(loadedGame == true)
        {
            //load the game with recieved intent
            humanScore = intent.getIntExtra("HumanScoreExtra", 0);
            computerScore = intent.getIntExtra("ComputerScoreExtra", 0);
            round = intent.getIntExtra("RoundNumberExtra",    1);
            humanTurn = intent.getBooleanExtra("TurnExtra", true);

            Round savedRoundObj = (Round) intent.getSerializableExtra("RoundExtra");

            //Constructs private round object and game object with values of loaded game
            roundObj = new Round(savedRoundObj.getRoundNumber(), savedRoundObj.getHumanHand(), savedRoundObj.getComputerHand(), savedRoundObj.getDrawPile(), savedRoundObj.getDiscardPile(), savedRoundObj.getHumanTurn());
            game = new Game(humanScore, computerScore, round);





        }
        //New game was started/Next round of game
        else
        {
            //Gets intent from previous activity
            humanScore = intent.getIntExtra("HumanPoints", 5);
            computerScore = intent.getIntExtra("ComputerPoints", 0);
            round = intent.getIntExtra("RoundNumber", 0);
            humanTurn = intent.getBooleanExtra("HumanTurn", true);


            game = new Game(humanScore, computerScore, round);

            roundObj = new Round(round);
            roundObj.setHumanTurn(humanTurn);

        }

        Deck deck = new Deck();







        //Setting text of game

        roundNum.setText(Integer.toString(round));

        humanPts.setText(Integer.toString(humanScore));

        computerPts.setText(Integer.toString(computerScore));








        //Calling updateBoard function to display all cards inside hands/piles
        updateBoard();

        newRound.setVisibility(View.INVISIBLE);

        tryToGoOut.setVisibility(View.INVISIBLE);
        endTurnButton.setVisibility(View.INVISIBLE);

        pickUpText.setVisibility(View.INVISIBLE);








        //START FIRST COMPUTER TURN
        if (roundObj.getHumanTurn() == false) {

            //Start computer pick up turn, string holds what happened
            String pickResult = roundObj.startComputerTurnPickup();

            //Start computer discard turn, string holds what happened
           final String discardResult =  roundObj.startComputerTurnDiscard();

           //Trys to go out
            boolean canGoOut = roundObj.goOutTry(false);

            //If computer can go out
            String result = "";
            if(canGoOut == true)
            {
                //sets the winning condition to true
                roundObj.setWinningCondition(true);


                result = "The computer has gone out with these cards! ... " + roundObj.getGoOutCards(false);

                v.vibrate(400);

                newRound.setVisibility(View.INVISIBLE);

            }
            //computer could not go out
            else
            {
                result = "The computer could not find a way to go out ... ";


                roundObj.setWinningCondition(false);
            }

            final String goOutResult = result;

            //Calling function to update view of cards
            updateBoard();

            //Snackbars that hold string of what the computer did
            final Snackbar snackbar = Snackbar
                    .make(computerLayout, pickResult, Snackbar.LENGTH_INDEFINITE)
                    .setAction("OK", new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {

                            final Snackbar snackbar2 = Snackbar
                                    .make(computerLayout, discardResult, Snackbar.LENGTH_INDEFINITE)
                                    .setAction("OK", new View.OnClickListener() {
                                        @Override
                                        public void onClick(View view) {


                                            final Snackbar snackbar3 = Snackbar
                                                    .make(computerLayout, goOutResult, Snackbar.LENGTH_INDEFINITE)
                                                    .setAction("OK", new View.OnClickListener() {
                                                        @Override
                                                        public void onClick(View view) {


                                                        }
                                                    });

                                            View snackbarView = snackbar3.getView();
                                            TextView tv= (TextView) snackbarView.findViewById(R.id.snackbar_text);
                                            tv.setMaxLines(10);
                                            snackbar3.show();






                                        }
                                    });
                            View snackbarView = snackbar2.getView();
                            TextView tv= (TextView) snackbarView.findViewById(R.id.snackbar_text);
                            tv.setMaxLines(10);
                            snackbar2.show();



                        }
                    });
            View snackbarView = snackbar.getView();
            TextView tv= (TextView) snackbarView.findViewById(R.id.snackbar_text);
            tv.setMaxLines(10);
            snackbar.show();







            //Setting start turn button to visible

            makeMove.setVisibility(View.INVISIBLE);
            save.setVisibility(View.INVISIBLE);
            askForHelp.setVisibility(View.INVISIBLE);
            quit.setVisibility(View.INVISIBLE);

            startTurnButton.setVisibility(View.VISIBLE);





        }
        //The human goes first in the beginning of the round
        else
        {
            makeMove.setVisibility(View.INVISIBLE);
            save.setVisibility(View.INVISIBLE);
            askForHelp.setVisibility(View.INVISIBLE);
            quit.setVisibility(View.INVISIBLE);

            startTurnButton.setVisibility(View.VISIBLE);

        }


        //Sets help to picking help
        roundObj.setWhichHelp(1);

        //Click listener for picking move
        makeMove.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {


                makeMove.setVisibility(View.INVISIBLE);
                save.setVisibility(View.INVISIBLE);
                quit.setVisibility(View.INVISIBLE);


                pickUpText.setText("Please tap which pile you want to pick up from!");


                pickUpText.setVisibility(View.VISIBLE);




                //Sets first card of draw pile to button, if clicked, puts into human hand
                drawLayout.getChildAt(0).setOnClickListener(new View.OnClickListener() {

                    @Override
                    public void onClick(View view) {

                        String pickedCard = roundObj.getDrawPile().get(0).printCard();
                        roundObj.pickFromDraw(true);



                        //Updated the board view
                        updateBoard();
                        roundObj.setCanDiscard(true);

                        //sets help to discard help
                        roundObj.setWhichHelp(2);

                        pickUpText.setText("Please tap which card you want to discard!");

                        final Snackbar snackbar = Snackbar
                                .make(computerLayout, "You picked up ... " + pickedCard + " ... from the draw pile.", Snackbar.LENGTH_LONG)
                                .setAction("OK", new View.OnClickListener() {
                                    @Override
                                    public void onClick(View view) {

                                    }
                                });
                        snackbar.show();

                        //Sets button listener for each card in humanhand
                        for(int i = 0; i < humanLayout.getChildCount(); i++)
                        {
                            View v = humanLayout.getChildAt(i);

                            final int index = i;
                            v.setOnClickListener(new View.OnClickListener() {


                                @Override
                                public void onClick(View view) {

                                    //Discards the card that was chosen/tapped
                                    roundObj.discardCard(true, roundObj.getHumanHand().get(index));
                                    updateBoard();

                                    roundObj.setGoOutDecision(true);
                                    roundObj.setHumanTurn(false);

                                    pickUpText.setVisibility(View.INVISIBLE);

                                    //Sets help to building
                                    roundObj.setWhichHelp(3);


                                    //Checks if the computer went out
                                    if(roundObj.getWinningCondition() == true)
                                    {

                                        tryToGoOut.setText("Put Down Cards");

                                        endTurnButton.setVisibility(View.INVISIBLE);

                                    }
                                    else
                                    {
                                        endTurnButton.setVisibility(View.VISIBLE);

                                    }

                                    tryToGoOut.setVisibility(View.VISIBLE);


                                }
                            });
                        }



                    }
                });

                //Sets button listener for first card of discard pile
                discardLayout.getChildAt(0).setOnClickListener(new View.OnClickListener() {

                    @Override
                    public void onClick(View view) {


                        String pickedCard = roundObj.getDiscardPile().get(0).printCard();

                        roundObj.pickFromDiscard(true);

                        //Updated view
                        updateBoard();

                        roundObj.setCanDiscard(true);

                        //Sets human help to disacrding
                        roundObj.setWhichHelp(2);


                        pickUpText.setText("Please tap which card you want to discard!");

                        final Snackbar snackbar = Snackbar
                                .make(computerLayout, "You picked up ... " + pickedCard + " ... from the discard pile.", Snackbar.LENGTH_LONG)
                                .setAction("OK", new View.OnClickListener() {
                                    @Override
                                    public void onClick(View view) {

                                    }
                                });
                        snackbar.show();



                        //Creates button for each card in human hand to discard if tapped
                        for(int i = 0; i < humanLayout.getChildCount(); i++)
                        {
                            View v = humanLayout.getChildAt(i);

                            final int index = i;
                            v.setOnClickListener(new View.OnClickListener() {


                                @Override
                                public void onClick(View view) {


                                    roundObj.discardCard(true, roundObj.getHumanHand().get(index));
                                    updateBoard();

                                    roundObj.setGoOutDecision(true);
                                    roundObj.setHumanTurn(false);

                                    pickUpText.setVisibility(View.INVISIBLE);


                                //Sets the help to building books/runs
                                    roundObj.setWhichHelp(3);


                                    //Checks if the computer already went out
                                    if(roundObj.getWinningCondition() == true)
                                    {

                                        tryToGoOut.setText("Put Down Cards");

                                        endTurnButton.setVisibility(View.INVISIBLE);

                                    }
                                    else
                                    {
                                        endTurnButton.setVisibility(View.VISIBLE);

                                    }

                                    tryToGoOut.setVisibility(View.VISIBLE);




                                }
                            });
                        }


                    }
                });




            }
        });

        //Quit button listener, goes back to main activity screen
        quit.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {

                Intent intent = new Intent(RoundActivity.this, MainActivity.class);


                RoundActivity.this.startActivity(intent);
            }
        });

    //Start turn listener, sets first human play buttons to visible
        startTurnButton.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {

                makeMove.setVisibility(View.VISIBLE);
                save.setVisibility(View.VISIBLE);
                askForHelp.setVisibility(View.VISIBLE);
                quit.setVisibility(View.VISIBLE);

                startTurnButton.setVisibility(View.INVISIBLE);
                roundObj.setHumanTurn(true);
            }
        });

        //End turn listener, begins a computer's play
        endTurnButton.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {

                //Sets human help to picking
                roundObj.setWhichHelp(1);


                //Computer picks from appropriate pile
                String pickResult = roundObj.startComputerTurnPickup();

                //Computer discards
                final String discardResult =  roundObj.startComputerTurnDiscard();


                String result = "";

                //Checks if the human already went out
                if(roundObj.getWinningCondition() == true)
                {


                    // PUT DOWN BEST RUNS AND BOOKS, SET NEXT ROUND TO VISIBLE

                    int pointsToAdd = roundObj.countCardPoints(false);


                    result = "The computer was able to put down these cards before going out ... " + roundObj.getCountCardPoints(false) + "\nTotal points added up is: " + pointsToAdd;





                    roundObj.setHumanTurn(true);


                    game.setComputerPoints(pointsToAdd);

                    newRound.setVisibility(View.VISIBLE);

                    startTurnButton.setVisibility(View.INVISIBLE);


                }
                //Human did not go out, computer tries to go out
                else
                {
                    boolean canGoOut = roundObj.goOutTry(false);


                    //If computer can go out, set winning condition to true
                    if(canGoOut == true)
                    {
                        roundObj.setWinningCondition(true);


                        result = "The computer has gone out with these cards! ... " + roundObj.getGoOutCards(false);


                        v.vibrate(400);

                        newRound.setVisibility(View.INVISIBLE);
                    }
                    //Computer cannot go out, set winning to false, and start Turn button to true
                    else
                    {
                        result = "The computer could not find a way to go out ... ";



                        roundObj.setWinningCondition(false);
                    }


                    startTurnButton.setVisibility(View.VISIBLE);


                }

                final String goOutResult = result;



                //Updates card view
                updateBoard();

                //Snackbar for all computer play
                final Snackbar snackbar = Snackbar
                        .make(computerLayout, pickResult, Snackbar.LENGTH_INDEFINITE)
                        .setAction("OK", new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {

                                final Snackbar snackbar2 = Snackbar
                                        .make(computerLayout, discardResult, Snackbar.LENGTH_INDEFINITE)
                                        .setAction("OK", new View.OnClickListener() {
                                            @Override
                                            public void onClick(View view) {



                                                final Snackbar snackbar3 = Snackbar
                                                        .make(computerLayout, goOutResult, Snackbar.LENGTH_INDEFINITE)
                                                        .setAction("OK", new View.OnClickListener() {
                                                            @Override
                                                            public void onClick(View view) {






                                                            }
                                                        });
                                                View snackbarView = snackbar3.getView();
                                                TextView tv= (TextView) snackbarView.findViewById(R.id.snackbar_text);
                                                tv.setMaxLines(10);
                                                snackbar3.show();

                                            }
                                        });


                                View snackbarView = snackbar2.getView();
                                TextView tv= (TextView) snackbarView.findViewById(R.id.snackbar_text);
                                tv.setMaxLines(10);
                                snackbar2.show();



                            }
                        });
                View snackbarView = snackbar.getView();
                TextView tv= (TextView) snackbarView.findViewById(R.id.snackbar_text);
                tv.setMaxLines(10);
                snackbar.show();




                askForHelp.setVisibility(View.INVISIBLE);

                endTurnButton.setVisibility(View.INVISIBLE);

                tryToGoOut.setVisibility(View.INVISIBLE);








                roundObj.setHumanTurn(true);
            }
        });

        //Save button listener
        save.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v)
            {
                //Alert box to enter filename for save
                AlertDialog.Builder saveBox = new AlertDialog.Builder(RoundActivity.this);

                //eext whereuser input
                final EditText file = new EditText(RoundActivity.this);
                saveBox.setMessage("Exclude file extension");
                saveBox.setTitle("Enter Save Name");

                saveBox.setView(file);

                //Alert box for save button
                saveBox.setPositiveButton(
                        "Save",
                        new DialogInterface.OnClickListener()
                        {
                            //on click for when the user clicks save
                            public void onClick(DialogInterface dialog, int id)
                            {
                                //Gets the file name
                                String fileName = file.getText().toString();

                                //Does not allow for empty name
                                if (fileName.isEmpty()){
                                    Toast.makeText(RoundActivity.this, "Blank File Name", Toast.LENGTH_SHORT).show();
                                    dialog.cancel();
                                }
                                else
                                {
                                    //saves he game
                                    saveGame(fileName);
                                }
                            }
                        });

                //cancel button to save
                saveBox.setNegativeButton(
                        "Cancel",
                        new DialogInterface.OnClickListener()
                        {
                            public void onClick(DialogInterface dialog, int id)
                            {
                                dialog.cancel();
                            }
                        });

                AlertDialog saveAlert = saveBox.create();
                saveAlert.show();
            }
        });

        //Button that listens for help
        askForHelp.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {

                //Calls the function help for whichever help is set to (picking, discarding, building)
                String help = roundObj.help();
                final Snackbar snackbar = Snackbar
                        .make(computerLayout, help, Snackbar.LENGTH_INDEFINITE)
                        .setAction("OK", new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {




                            }
                        });
                View snackbarView = snackbar.getView();
                TextView tv= (TextView) snackbarView.findViewById(R.id.snackbar_text);
                tv.setMaxLines(10);
                snackbar.show();




            }
        });

        //Try to go out button for human
        tryToGoOut.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {


                //Checks if the computer already went out
            if(roundObj.getWinningCondition() == true)
            {

                //puts down cards before the player goes out as integer
                int pointsToAdd = roundObj.countCardPoints(true);

                String cardsResult = "You were able to put down these cards before going out ... " + roundObj.getCountCardPoints(true)+ "\nTotal points added up is: " + pointsToAdd;

                final Snackbar snackbar = Snackbar
                        .make(computerLayout, cardsResult, Snackbar.LENGTH_INDEFINITE)
                        .setAction("OK", new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {




                            }
                        });
                View snackbarView = snackbar.getView();
                TextView tv= (TextView) snackbarView.findViewById(R.id.snackbar_text);
                tv.setMaxLines(10);
                snackbar.show();

                //Player must tap new round button to go to next round
                roundObj.setHumanTurn(false);
                newRound.setVisibility(View.VISIBLE);

                game.setHumanPoints(pointsToAdd);
                tryToGoOut.setVisibility(View.INVISIBLE);
                return;
            }

                //else the human tries to go out
                boolean canGoOut =  roundObj.goOutTry(true);

            //If can go out, go out and set winning condition to true
                if(canGoOut == true)
                {
                    roundObj.setWinningCondition(true);
                    String result = "You've gone out with these cards! ... " + roundObj.getGoOutCards(true);

                    v.vibrate(400);

                    final Snackbar snackbar = Snackbar
                            .make(computerLayout, result, Snackbar.LENGTH_INDEFINITE)
                            .setAction("OK", new View.OnClickListener() {
                                @Override
                                public void onClick(View view) {




                                }
                            });
                    View snackbarView = snackbar.getView();
                    TextView tv= (TextView) snackbarView.findViewById(R.id.snackbar_text);
                    tv.setMaxLines(10);
                    snackbar.show();


                    tryToGoOut.setVisibility(View.INVISIBLE);

                }
                //Human could not go out, set winning condition to false
                else
                {
                    roundObj.setWinningCondition(false);

                    String result = "There was no way you could go out with these cards ... ";


                    final Snackbar snackbar = Snackbar
                            .make(computerLayout, result, Snackbar.LENGTH_INDEFINITE)
                            .setAction("OK", new View.OnClickListener() {
                                @Override
                                public void onClick(View view) {




                                }
                            });
                    View snackbarView = snackbar.getView();
                    TextView tv= (TextView) snackbarView.findViewById(R.id.snackbar_text);
                    tv.setMaxLines(10);
                    snackbar.show();




                    tryToGoOut.setVisibility(View.INVISIBLE);

                }





            }
        });


        //Button listener for new round, only is visible if player went out and other player had one more turn
        newRound.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {





                //Checks if the next round is 12
                if(roundObj.getRoundNumber()+1 == 12)
                {
                    //If so, send human points and computer points to final screen
                    Intent intent2 = new Intent(RoundActivity.this, GameEndActivity.class);

                    int newHumanPoints = game.getHumanPoints();
                    int newComputerPoints = game.getComputerPoints();

                    intent2.putExtra("ComputerPoints", newComputerPoints);
                    intent2.putExtra("HumanPoints", newHumanPoints);


                    RoundActivity.this.startActivity(intent2);

                    finish();

                }
                // If not last round, set round number to +1 and human Points and computer Points to new added numbers, send to RoundActivity with new intent
                else
                {
                    Intent intent1 = new Intent(RoundActivity.this, RoundActivity.class);

                    int newRound = roundObj.getRoundNumber() + 1;
                    int newHumanPoints = game.getHumanPoints();
                    int newComputerPoints = game.getComputerPoints();

                    intent1.putExtra("RoundNumber", newRound);
                    intent1.putExtra("HumanPoints", newHumanPoints);
                    intent1.putExtra("ComputerPoints", newComputerPoints);


                    if(roundObj.getHumanTurn() == true)
                    {
                        intent1.putExtra("HumanTurn", true);
                    }
                    else
                    {

                        intent1.putExtra("HumanTurn", false);

                    }


                    RoundActivity.this.startActivity(intent1);

                }








            }
        });




    }



    //Returns human layout
    public LinearLayout getHumanLayout(LinearLayout humanLay)
    {
        return humanLay;
    }


    //Saves a game
    private void saveGame(String a_fileName)
    {
        try
        {

            //holds humans score
            int humanScore = game.getHumanPoints();
            //holds computer score
            int computerScore = game.getComputerPoints();

            int round = roundObj.getRoundNumber();



            Deck deck = new Deck();

            //Stores all cards
            String humanCards = deck.printCards(roundObj.getHumanHand());
            String computerCards = deck.printCards(roundObj.getComputerHand());
            String drawCards = deck.printCards(roundObj.getDrawPile());
            String discardCards = deck.printCards(roundObj.getDiscardPile());






            //Makes the save state game
            String gameToSave = "Round: " + round + "\n\n" +
                    "Computer:" + "\n" +
                    "   Score: " + computerScore + "\n" +
                    "   Hand: " + computerCards + "\n\n" +
                    "Human:" + "\n" +
                    "   Score: " + humanScore + "\n" +
                    "   Hand: " + humanCards + "\n\n" +
                    "Draw Pile: " + drawCards + "\n\n" +
                     "Discard Pile: " + discardCards +"\n\n" +
                    "Next Player: Human";

            //creates a file
            FileOutputStream fos = openFileOutput(a_fileName + ".txt", MODE_PRIVATE);
            //writes the file
            fos.write(gameToSave.getBytes());
            fos.close();

            Toast.makeText(RoundActivity.this, "Game Saved", Toast.LENGTH_SHORT).show();
            Intent intent = new Intent(RoundActivity.this, MainActivity.class);

            RoundActivity.this.startActivity(intent);
        }
        catch(Exception e)
        {
            Toast.makeText(RoundActivity.this, "Something went wrong", Toast.LENGTH_SHORT).show();
        }
    }











    //Function that updates the card views of the board
    public void updateBoard()
    {


        //Removes all current button views from the card layouts
        if( humanLayout.getChildCount() > 0) {
            humanLayout.removeAllViews();
        }
        if( computerLayout.getChildCount() > 0) {
            computerLayout.removeAllViews();
        }
        if(drawLayout.getChildCount() > 0) {
            drawLayout.removeAllViews();
        }
        if( discardLayout.getChildCount() > 0) {
            discardLayout.removeAllViews();
        }



        Deck deck = new Deck();


        //Calls function transferCardToImage on each card inside human hand
        for(int i = 0; i < roundObj.getHumanHand().size(); i++)
        {

            transferCardtoImage(roundObj.getHumanHand().get(i), humanLayout);
        }
        //Calls function transferCardToImage on each card inside computer hand
        for(int j =0; j < roundObj.getComputerHand().size(); j++)
        {
            transferCardtoImage(roundObj.getComputerHand().get(j), computerLayout);
        }
        //Calls function transferCardToImage on each card inside draw hand
        for(int k = 0; k < roundObj.getDrawPile().size(); k++)
        {
            transferCardtoImage(roundObj.getDrawPile().get(k), drawLayout);
        }
        //Calls function transferCardToImage on each card inside discard hand
        for(int q = 0; q < roundObj.getDiscardPile().size(); q++)
        {
            transferCardtoImage(roundObj.getDiscardPile().get(q), discardLayout);
        }






    }

    //Function that transfers a card object to a drawable in android studio, puts inside desired layout
    public void transferCardtoImage(Card desiredCard, LinearLayout desiredLayout)
    {

        Deck deck = new Deck();



        //ALL CONDITIONS CHECK FOR WHICH CARD IS BEING TRANSFERRED
        //creates each card as a button, with background resource to their respected card
        //sets layout parameter so there is a little space in between each card
        if(desiredCard.getSuite().equals("C"))
        {



            if(desiredCard.getStringValue().equals("3"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.clubs_3);
                desiredLayout.addView(textView);


                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);



            }
            if(desiredCard.getStringValue().equals("4"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.clubs_4);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("5"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.clubs_5);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("6"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.clubs_6);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("7"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.clubs_7);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("8"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.clubs_8);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("9"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.clubs_9);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("X"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.clubs_10);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("J"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.clubs_j);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("Q"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.clubs_q);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("K"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.clubs_k);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
        }
        if(desiredCard.getSuite().equals("D"))
        {
            if(desiredCard.getStringValue().equals("3"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.diamonds_3);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("4"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.diamonds_4);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("5"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.diamonds_5);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("6"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.diamonds_6);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("7"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.diamonds_7);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("8"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.diamonds_8);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("9"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.diamonds_9);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);

            }
            if(desiredCard.getStringValue().equals("X"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.diamonds_10);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("J"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.diamonds_j);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("Q"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.diamonds_q);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("K"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.diamonds_k);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
        }
        if(desiredCard.getSuite().equals("S"))
        {
            if(desiredCard.getStringValue().equals("3"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.spades_3);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("4"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.spades_4);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("5"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.spades_5);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("6"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.spades_6);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("7"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.spades_7);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("8"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.spades_8);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("9"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.spades_9);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("X"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.spades_10);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("J"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.spades_j);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("Q"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.spades_q);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("K"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.spades_k);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
        }
        if(desiredCard.getSuite().equals("T"))
        {
            if(desiredCard.getStringValue().equals("3"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.tridents_3);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("4"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.tridents_4);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("5"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.tridents_5);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("6"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.tridents_6);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("7"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.tridents_7);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("8"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.tridents_8);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("9"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.tridents_9);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("X"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.tridents_10);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("J"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.tridents_j);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("Q"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.tridents_q);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("K"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.tridents_k);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
        }
        if(desiredCard.getSuite().equals("H"))
        {
            if(desiredCard.getStringValue().equals("3"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.hearts_3);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("4"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.hearts_4);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("5"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.hearts_5);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("6"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.hearts_6);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("7"))
            {

                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.hearts_7);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("8"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.hearts_8);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("9"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.hearts_9);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("X"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.hearts_10);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("J"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.hearts_j);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("Q"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.hearts_q);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
            if(desiredCard.getStringValue().equals("K"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.hearts_k);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }
        }
        if(desiredCard.getSuite().equals("1"))
        {
            if(desiredCard.getStringValue().equals("J"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.joker_1);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }

        }
        if(desiredCard.getSuite().equals("2"))
        {
            if(desiredCard.getStringValue().equals("J"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.joker_2);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }

        }
        if(desiredCard.getSuite().equals("3"))
        {
            if(desiredCard.getStringValue().equals("J"))
            {
                Button textView = new Button(RoundActivity.this);
                textView.setBackgroundResource(R.drawable.joker_3);
                desiredLayout.addView(textView);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams. MATCH_PARENT ,
                        LinearLayout.LayoutParams. WRAP_CONTENT ) ;
                layoutParams.setMargins( 0 , 0 , 15 , 0 ) ;
                textView.setLayoutParams(layoutParams);
            }

        }
    }

}
