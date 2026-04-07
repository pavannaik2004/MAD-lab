package com.example.activitytoactivity;

import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

public class Screen2 extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_screen2);

        Intent i = getIntent();
        String message = i.getStringExtra("message");

        TextView textView = findViewById(R.id.showmessage);
        textView.setText(message);
    }
}