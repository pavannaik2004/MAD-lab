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
public class MainActivity extends AppCompatActivity implements View.OnClickListener {
    private static final String TAG = MainActivity.class.getSimpleName();
    private Button buttonstart, buttonStop;
    private boolean mStopLoop;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_main);
        Log.i(TAG, "Thread id" + Thread.currentThread().getId());
        buttonstart = (Button) findViewById(R.id.buttonthreadStarter);
        buttonStop = (Button) findViewById(R.id.buttonStopThread);
        buttonstart.setOnClickListener(this);
        buttonStop.setOnClickListener(this);
    }
    @Override
    public void onClick(View view) {
        if (view.getId() == R.id.buttonthreadStarter) {
            mStopLoop = true;
            while( mStopLoop = true){
                Log.i(TAG, "Start clicked");
                Thread.currentThread().getName();
            }
        }
        else if (view.getId() == R.id.buttonStopThread) {
            mStopLoop = false;
            Log.i(TAG, "Stop clicked");
        }
    }
}
