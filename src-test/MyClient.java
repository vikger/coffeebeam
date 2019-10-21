import coffeebeam.beam.BeamDebug;
import coffeebeam.client.BeamClient;
import java.io.*;

public class MyClient extends BeamClient {
    public static void main(String[] args) throws Exception {
	if (args.length > 0)
	    BeamDebug.loglevel = Integer.valueOf(args[0]);
        MyClient client = new MyClient();
        client.loadModules("load.txt");
        client.runApplies("apply.txt");
    }
}
