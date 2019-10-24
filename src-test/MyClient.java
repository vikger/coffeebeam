import coffeebeam.beam.BeamDebug;
import coffeebeam.client.BeamClient;
import coffeebeam.types.*;
import java.io.*;

public class MyClient extends BeamClient {
    public MyClient() {
        super(new BeamDebug());
    }

    public void loadModules(String filename) throws Exception {
        BufferedReader reader = new BufferedReader(new FileReader(filename));
        String module;
        while ((module = reader.readLine()) != null)
            loadModule(module);
        reader.close();
    }

    public void runApplies(String filename) throws Exception {
        BufferedReader reader = new BufferedReader(new FileReader(filename));
        String line;
        String[] mfa;
        ErlList args;
        while ((line = reader.readLine()) != null) {
            if (!line.startsWith("%") && !line.equals("")) {
                mfa = line.split(" ", 3);
                args = (ErlList) ErlTerm.parse(mfa[2]);
                apply(mfa[0], mfa[1], args);
                waitForResult();
            }
        }
        reader.close();
    }

    public static void main(String[] args) throws Exception {
	if (args.length > 0)
	    BeamDebug.loglevel = Integer.valueOf(args[0]);
        MyClient client = new MyClient();
        client.startVM();
        client.loadModules("load.txt");
        client.runApplies("apply.txt");
        client.stopVM();
    }
}
