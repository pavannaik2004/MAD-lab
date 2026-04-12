package com.example.uithreads;

import android.os.Bundle;
import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {
    private static final String TAG = MainActivity.class.getSimpleName();
    private Button buttonstart, buttonStop;
    private boolean mStopLoop;
    private TextView textView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_main);
        Log.i(TAG, "Thread id" + Thread.currentThread().getId());
        buttonstart = findViewById(R.id.buttonthreadStarter);
        buttonStop = findViewById(R.id.buttonStopThread);
        textView = findViewById(R.id.textViewResult); // MUST EXIST
        buttonstart.setOnClickListener(this);
        buttonStop.setOnClickListener(this);
    }

    @Override
    public void onClick(View view) {
        if (view.getId() == R.id.buttonthreadStarter) {
            mStopLoop = false;
            new Thread(new Runnable() {
                @Override
                public void run() {
                    int i = 1;
                    while (!mStopLoop) {
                        int finalI = i;
                        Log.i(TAG, "Count: " + i);
                        runOnUiThread(() -> {
                            textView.setText("Count: " + finalI);
                        });
                        i++;
                        try {
                            Thread.sleep(1000); // 1 sec delay
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                    }
                    Log.i(TAG, "Thread stopped");
                }
            }).start();
        }
        else if (view.getId() == R.id.buttonStopThread) {
            mStopLoop = true;
            Log.i(TAG, "Stop clicked");
        }
    }
}
