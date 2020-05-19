package com.example.fivecrownsapp;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.RadioButton;
import android.widget.TextView;


import java.util.Collections;
import java.util.Random;
import java.util.Vector;

import androidx.appcompat.app.AppCompatActivity;

import com.google.android.material.snackbar.Snackbar;


public class GameSetup extends AppCompatActivity {


    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.cointoss_activity);

        //Sets all values of design to respected variables to be called inside event handlers
        final RadioButton headsFlip = findViewById(R.id.headsRadio);

        final RadioButton tailsFlip = findViewById(R.id.tailsRadio);

        final TextView humanWonToss = findViewById(R.id.humanCoinWin);
        final TextView computerWonToss = findViewById(R.id.computerCoinWin);

        final Button coinFlip = findViewById(R.id.flipButton);



        //Event handler for heads radio button, sets tails radio button to false
        headsFlip.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                boolean checked = ((RadioButton) v).isChecked();
                // Check which radiobutton was pressed
                if (checked){
                    tailsFlip.setChecked(false);
                }

            }
        });
        //Event handler for tails radio button, sets heads radio button to false
        tailsFlip.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                boolean checked = ((RadioButton) v).isChecked();
                // Check which radiobutton was pressed
                if (checked){
                    headsFlip.setChecked(false);
                }

            }
        });



        //Event handler for coin flip button
        coinFlip.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {

                Random rand = new Random();
                int randomFlip = rand.nextInt(2);




                //If random number is 1 and heads is checked, then human won toss
                if(randomFlip == 1)
                {
                    if(headsFlip.isChecked())
                    {

                        coinFlip.setVisibility(View.INVISIBLE);
                        //passes default values to round activity
                        final Intent intent = new Intent(GameSetup.this, RoundActivity.class);
                        intent.putExtra("RoundNumber", 1);
                        intent.putExtra("HumanPoints", 0);
                        intent.putExtra("ComputerPoints", 0);
                        intent.putExtra("HumanTurn", true);


                        humanWonToss.setVisibility(View.VISIBLE);

                        //Button to go to round activity
                        final Snackbar snackbar = Snackbar
                                .make(humanWonToss, "The toss was heads! Please click PROCEED to begin game.", Snackbar.LENGTH_INDEFINITE)
                                .setAction("PROCEED", new View.OnClickListener() {
                                    @Override
                                    public void onClick(View view) {


                                        GameSetup.this.startActivity(intent);
                                        finish();

                                    }
                                });
                        View snackbarView = snackbar.getView();
                        TextView tv= (TextView) snackbarView.findViewById(R.id.snackbar_text);
                        tv.setMaxLines(10);
                        snackbar.show();






                    }
                    //If tails was checked and random number was 1, then computer won toss
                    else if(tailsFlip.isChecked())
                    {

                        coinFlip.setVisibility(View.INVISIBLE);

                        final Intent intent = new Intent(GameSetup.this, RoundActivity.class);
                        intent.putExtra("RoundNumber", 1);
                        intent.putExtra("HumanPoints", 0);
                        intent.putExtra("ComputerPoints", 0);
                        intent.putExtra("HumanTurn", false);

                        computerWonToss.setVisibility(View.VISIBLE);


                        final Snackbar snackbar = Snackbar
                                .make(humanWonToss, "The toss was heads! Please click PROCEED to begin game.", Snackbar.LENGTH_INDEFINITE)
                                .setAction("PROCEED", new View.OnClickListener() {
                                    @Override
                                    public void onClick(View view) {


                                        GameSetup.this.startActivity(intent);
                                        finish();

                                    }
                                });
                        View snackbarView = snackbar.getView();
                        TextView tv= (TextView) snackbarView.findViewById(R.id.snackbar_text);
                        tv.setMaxLines(10);
                        snackbar.show();




                    }
                    else
                    {
                        String result = "Please select either heads or tails.";


                        final Snackbar snackbar = Snackbar
                                .make(humanWonToss, result, Snackbar.LENGTH_INDEFINITE)
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
                }
                else
                {
                    //if toss is tails and human checked tails, then human won
                    if(tailsFlip.isChecked())
                    {
                        coinFlip.setVisibility(View.INVISIBLE);
                        final Intent intent = new Intent(GameSetup.this, RoundActivity.class);
                        intent.putExtra("RoundNumber", 1);
                        intent.putExtra("HumanPoints", 0);
                        intent.putExtra("ComputerPoints", 0);
                        intent.putExtra("HumanTurn", true);

                        humanWonToss.setVisibility(View.VISIBLE);

                        final Snackbar snackbar = Snackbar
                                .make(humanWonToss, "The toss was tails! Please click PROCEED to begin game.", Snackbar.LENGTH_INDEFINITE)
                                .setAction("PROCEED", new View.OnClickListener() {
                                    @Override
                                    public void onClick(View view) {


                                        GameSetup.this.startActivity(intent);
                                        finish();

                                    }
                                });
                        View snackbarView = snackbar.getView();
                        TextView tv= (TextView) snackbarView.findViewById(R.id.snackbar_text);
                        tv.setMaxLines(10);
                        snackbar.show();


                    }
                    //If toss is tails and human checked heads, then computer won
                    else if(headsFlip.isChecked())
                    {
                        coinFlip.setVisibility(View.INVISIBLE);

                        final Intent intent = new Intent(GameSetup.this, RoundActivity.class);
                        intent.putExtra("RoundNumber", 1);
                        intent.putExtra("HumanPoints", 0);
                        intent.putExtra("ComputerPoints", 0);
                        intent.putExtra("HumanTurn", false);

                        computerWonToss.setVisibility(View.VISIBLE);



                        final Snackbar snackbar = Snackbar
                                .make(humanWonToss, "The toss was tails! Please click PROCEED to begin game.", Snackbar.LENGTH_INDEFINITE)
                                .setAction("PROCEED", new View.OnClickListener() {
                                    @Override
                                    public void onClick(View view) {


                                        GameSetup.this.startActivity(intent);
                                        finish();

                                    }
                                });
                        View snackbarView = snackbar.getView();
                        TextView tv= (TextView) snackbarView.findViewById(R.id.snackbar_text);
                        tv.setMaxLines(10);
                        snackbar.show();





                    }
                    else
                    {

                        String result = "Please select either heads or tails.";


                        final Snackbar snackbar = Snackbar
                                .make(humanWonToss, result, Snackbar.LENGTH_INDEFINITE)
                                .setAction("OK", new View.OnClickListener() {
                                    @Override
                                    public void onClick(View view) {


                                        coinFlip.setVisibility(View.VISIBLE);

                                    }
                                });
                        View snackbarView = snackbar.getView();
                        TextView tv= (TextView) snackbarView.findViewById(R.id.snackbar_text);
                        tv.setMaxLines(10);
                        snackbar.show();


                    }
                }




            }

        });


    }


}
