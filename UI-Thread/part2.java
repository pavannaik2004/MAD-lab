package com.example.thread_myapplication;
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
 mStopLoop = false;
 new Thread(new Runnable() {
 @Override
 public void run() {
 while (!mStopLoop) {
 Log.i(TAG, "Thread running... ID: " +
 Thread.currentThread().getId());
 try {
 Thread.sleep(1000); // prevent CPU overload
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
