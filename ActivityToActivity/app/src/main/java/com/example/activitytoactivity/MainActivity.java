package com.example.activitytoactivity;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;

import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        EditText edittext = findViewById(R.id.sendmessage);
        Button sub = findViewById(R.id.button);

        sub.setOnClickListener(v -> {

            String message = edittext.getText().toString();

            Intent intent = new Intent(MainActivity.this, Screen2.class);
            intent.putExtra("message", message);

            startActivity(intent);
        });
    }
}