# Project description
The aim of this project is to provide interface for Erlang applications to communicate with Android devices through BEAM file interpretation and execution.

# Library
## Compilation
Create a `jar` library using `ant`:

    $ ant

The generated file is located at `dist/lib/`.

Alternatively, you can create a non-versioned `jar` library for testing purposes:

    $ ant test

The generated file is located at `test/`.

## Types

Each Erlang term is represented as a java class. The generic term class is `coffeebeam.types.ErlTerm` that can be specified as inherited classes e.g. `coffeebeam.types.ErlInt`, `coffeebeam.types.ErlList` etc.

# Android application

To interact with an Android application, you have to import the `CoffeeBeam.jar` library into your application, and inherit the `coffeebeam.client.BeamClient`. The following methods are provided:

* constructor `BeamClient(Logger logger)`: creates a new `BeamClient` instance attaching a logger customized for Android.
* `void startVM()`: starts the Erlang VM.
* `void stopVM()`: stops the Erlang VM. All previously loaded modules are lost.
* `void attachToVM(BeamVM otherVM)`: attaches to an existing running Erlang VM.
* `void loadModule(String filename)`: loads a BEAM file specified by path into the running Erlang VM.
* `loadModule(InputStream is)`: loads a BEAM file specified by `InputStream` into the running Erlang VM. This is the preferred method for Android.
* `void apply(String module, String function, ErlList args)`: applies the given function (module name, function name, argument list) in a new process.
* `void handleCall(String function, ErlTerm arg)`: applies a function `beamclient:<function>(<arg>)` invoked from a BEAM file. To be redefined in `BeamClient` subclass for custom behavior.
* `void handleResult(ErlTerm result)`: handles result of the initial function call. To be redefined in `BeamClient` subclass for custom behavior.
* `ErlTerm test(String module, String function, ErlList args)`: runs the given function and returns the result for testing purposes. To be avoided in production use.
* `ErlTerm waitForResult()`: waits for the result of the initial function call. To be used with care as this call blocks the running thread in the Android application. `handleResult(ErlTerm)` should be used in production.

## Logger example

A typical implementation of the `Logger` for Android looks like:

    class MyLogger implements Logger {
        private final String tag = "CoffeeBeam";
    	public void e(String s) { Log.e(tag, s); }
    	public void w(String s) { Log.w(tag, s); }
    	public void i(String s) { Log.i(tag, s); }
    	public void d(String s) { Log.d(tag, s); }
    }

## Client example

A basic client implementation example:

    class MyClient extends BeamClient {
        public Client() {
            super(new MyLogger());
        }
        public void handleResult(ErlTerm result) {
            // ... do something with the result
        }
        public void handleCall(String function, ErlTerm arg) {
            // ... handle when beamclient:function(arg) is called
        }
    }

## Client usage in Activity

To use the implemented Client in an Activity, add the corresponding operations inside the Activity callback functions. The following examples shows starting the Erlang VM when the activity is created, and stopping it when the activity is destroyed:

    public class MyActivity extends Activity {
        MyClient client;
        // ...
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            // ... needed initializations
            client = new Client();
            client.startVM();
        }

        protected void onDestroy() {
            super.onDestroy();
            client.stopVM();
        }
    }

Loading a selected BEAM file can be initiated based on the result of the file choosing activity, for example:

    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        // ... check if file is selected with OK result code
        Uri uri = data.getData()
        try {
            InputStream is = getContentResolver().openInputStream(uri);
            client.loadModule(is);
        } catch ... // handle file access of BEAM file errors
    }
