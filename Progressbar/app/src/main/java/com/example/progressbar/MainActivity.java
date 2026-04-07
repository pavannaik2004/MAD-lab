package com.example.progressbar;

import android.os.Bundle;

import androidx.appcompat.app.AlertDialog;
import android.os.Handler;
import android.view.View;
import android.widget.Button;
import android.widget.ProgressBar;
import android.widget.TextView;
import java.util.Random;


import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

public class MainActivity extends AppCompatActivity {

    ProgressBar pb;
    TextView tv;
    Button sub;

    int progress = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        pb = findViewById(R.id.progressBar);
        tv = findViewById(R.id.progressStatus);
        sub = findViewById(R.id.start);

        sub.setOnClickListener(v -> {

            sub.setVisibility(View.INVISIBLE);

            if (progress == 100) {
                progress = 0;
            }

            new Thread(() -> {
                Random random = new Random();

                while (progress < 100) {
                    progress++;

                    new Handler(getMainLooper()).post(() -> {
                        pb.setProgress(progress);
                        tv.setText(progress + "%");
                    });

                    try {
                        int delay = random.nextInt(181) + 20; // 20–200 ms
                        Thread.sleep(delay);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }

                if (progress == 100) {
                    runOnUiThread(() -> {
                        AlertDialog.Builder builder =
                                new AlertDialog.Builder(MainActivity.this);

                        builder.setTitle("Download Complete");
                        builder.setIcon(R.drawable.ic_launcher_foreground);
                        builder.setMessage("Download Complete");

                        builder.setPositiveButton("OK", (dialog, which) -> finish());

                        builder.setNegativeButton("Cancel", (dialog, which) -> {
                            sub.setVisibility(View.VISIBLE);
                            dialog.dismiss();
                        });

                        builder.show();
                    });
                }

            }).start();
        });
    }
}