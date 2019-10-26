package com.vikger.coffeebeamclient;

//import androidx.appcompat.app.AppCompatActivity;
import android.app.Activity;
import android.os.Bundle;
import android.os.Environment;
import android.provider.DocumentsContract;
import android.util.Log;
import android.view.View;
import android.widget.*;
import android.content.Intent;
import android.net.Uri;
import java.io.*;

import coffeebeam.beam.BeamDebug;
import coffeebeam.client.BeamClient;
import coffeebeam.types.*;
import coffeebeam.erts.Logger;

public class MainActivity extends Activity {
    Client client;
    TextView resultText;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        resultText = (TextView) findViewById(R.id.resultText);
        BeamDebug.loglevel = 0;
        client = new Client(this);
        client.startVM();
        Button loadButton = (Button) findViewById(R.id.loadBeamButton);
        loadButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                showFileChooser();
            }
        });
        Button applyButton = (Button) findViewById(R.id.applyButton);
        applyButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                final EditText moduleText = (EditText) findViewById(R.id.moduleText);
                String module = moduleText.getText().toString();
                final EditText functionText = (EditText) findViewById(R.id.functionText);
                String function = functionText.getText().toString();
                final EditText argsText = (EditText) findViewById(R.id.argsText);
                String argsString = argsText.getText().toString();
                appendText(module + " " + function + " " + argsString);
                try {
                    ErlList args = (ErlList) ErlTerm.parse(argsString);
                    client.apply(module, function, args);
                } catch (Exception e) {
                    appendText("Exception: " + e.toString());
                }
            }
        });
        /*try {
            client.loadModule("/storage/sdcard/Download/pizza.beam");
        } catch (Exception e) {
            resultText.setText(getExternalFilesDir(null) + "\nload error" + e.toString());
        }*/
    }

    @Override
    protected void onResume() {
        super.onResume();
        try {
//            client.apply("pizza", "order", (ErlList) ErlTerm.parse("[margherita]"));
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            String exceptionAsString = sw.toString();
            //resultText.setText(e.toString() + "\n" + exceptionAsString);
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        client.stopVM();
    }

    private static final int FILE_SELECT_CODE = 0;

    private void showFileChooser() {
        Intent intent = new Intent(Intent.ACTION_GET_CONTENT);
        intent.setType("*/*");
        intent.addCategory(Intent.CATEGORY_OPENABLE);


        try {
            startActivityForResult(
                    Intent.createChooser(intent, "Select beam file"),
                    FILE_SELECT_CODE);
        } catch (android.content.ActivityNotFoundException ex) {
            // Potentially direct the user to the Market with a Dialog
            //Toast.makeText(this.getActivity(), "Please install a File Manager.",
              //      Toast.LENGTH_SHORT).show();
        }
    }
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        appendText(String.valueOf(requestCode));
        switch (requestCode) {
            case FILE_SELECT_CODE:
                if (resultCode == Activity.RESULT_OK) {
                    // Get the Uri of the selected file
                    Uri uri = data.getData();
                    try {
                        InputStream is = getContentResolver().openInputStream(uri);
                        client.loadModule(is);
                    } catch (Exception e) {
                        appendText(e.toString());
                    }
                }
                break;
        }
        super.onActivityResult(requestCode, resultCode, data);
    }

    private void appendText(String t) {
        resultText.append(t + "\n");
    }

    public void updateResult(String result) {
        resultText.setText(result);
    }

    private String getFilename(String path) {
        String filename;
        String[] parts = path.split(":", 2);
        if (parts[0].equals("/document/raw"))
            return parts[1];
        // external storage
        return Environment.getExternalStorageDirectory() + "/" + parts[1];
    }
}

class Client extends BeamClient {
    MainActivity activity;
    public Client(MainActivity a) {
        super(new AndLogger());
        activity = a;
    }
    public void handleResult(ErlTerm r) {
        final String res = r.toString();
        Log.d("Client", "handleResult: " + res);
        activity.runOnUiThread(new Runnable() {
            public void run() {
                activity.updateResult(res);
            }
        });
    }
}

class AndLogger implements Logger {
    private final String tag = "CoffeeBeam";
    public void e(String s) { Log.e(tag, s); }
    public void w(String s) { Log.w(tag, s); }
    public void i(String s) { Log.i(tag, s); }
    public void d(String s) { Log.d(tag, s); }
}