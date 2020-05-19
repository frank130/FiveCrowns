package com.example.fivecrownsapp;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.GridView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import com.google.android.material.snackbar.Snackbar;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Vector;

public class GameEndActivity extends AppCompatActivity {

    private Round roundObj;
    private LinearLayout humanLayout;
    private LinearLayout computerLayout;
    private LinearLayout drawLayout;
    private LinearLayout discardLayout;

    private Game game;


    @Override
    protected void onCreate(Bundle savedInstanceState) {


        super.onCreate(savedInstanceState);
        setContentView(R.layout.game_end_activity);

        //Setting intent from final round to variables
        Intent intent = getIntent();
        final int humanScore = intent.getIntExtra("HumanPoints", 5);
        final int computerScore = intent.getIntExtra("ComputerPoints", 0);

        final TextView humanPts = findViewById(R.id.humanPointsText);

        final TextView computerPts = findViewById(R.id.computerPointsText);

        final TextView winner = findViewById(R.id.winnerText);


        final Button endGame = findViewById(R.id.exitGamebtn);

        final Button mainScreen = findViewById(R.id.mainScreenbtn);


        //Sets the text of points to display
        humanPts.setText(Integer.toString(humanScore));

        computerPts.setText(Integer.toString(computerScore));


        //Checking who has more points and displaying winner
        if(humanScore < computerScore)
        {
            winner.setText("You have less points than the computer. You won ! ! !");
        }
        else
        {
            winner.setText("You have more points than the computer. You lost ! ! !");
        }


        //Looks for main screen button click, sends to mainactivity
        mainScreen.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {

                Intent intent = new Intent(GameEndActivity.this, MainActivity.class);


                GameEndActivity.this.startActivity(intent);
            }
        });

        //If end game is clicked, exit game
        endGame.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {

            finish();


            }
        });

    }

}