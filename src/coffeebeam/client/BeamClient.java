package coffeebeam.client;

import coffeebeam.erts.*;
import coffeebeam.types.*;
import coffeebeam.beam.BeamFile;
import coffeebeam.beam.BeamDebug;
import java.io.*;

public class BeamClient {
    BeamVM vm;
    volatile ErlTerm result = null;

    public BeamClient() {
        vm = new BeamVM();
    }

    public void loadModules(String filename) throws Exception {
        BufferedReader reader = new BufferedReader(new FileReader(filename));
        String module;
        while ((module = reader.readLine()) != null) {
            vm.load(module);
        }
        reader.close();
    }

    public void runApplies(String filename) throws Exception {
        BufferedReader reader = new BufferedReader(new FileReader(filename));
        String line;
        String[] mfa;
        ErlTerm[] args;
        int arity;
        while ((line = reader.readLine()) != null) {
            if (!line.startsWith("%") && !line.equals("")) {
                mfa = line.split(" ", 3);
                arity = Integer.valueOf(mfa[2]);
                args = new ErlTerm[arity];
                for (int i = 0; i < arity; i++) {
                    line = reader.readLine();
                    args[i] = ErlTerm.parse(line);
                }
                ErlProcess p = vm.newProcess(this);
                p.prepare(mfa[0], mfa[1], args);
                waitForResult();
            }
        }
        reader.close();
        stopVM();
    }

    public void handleCall(String function, ErlTerm arg) {
        BeamDebug.debug("client handleCall " + function + " " + arg);
    }

    public void handleResult(ErlTerm r) {
        result = r;
    }

    public ErlTerm test(String module, String function, ErlTerm[] args) {
        ErlProcess p = vm.newProcess(this);
        p.prepare(module, function, args);
        ErlTerm r = waitForResult();
        BeamDebug.debug("client result: " + r);
        return r;
    }

    public ErlTerm waitForResult() {
        while (result == null) {}
        ErlTerm r = result;
        result = null;
        return r;
    }

    public void stopVM() { vm.halt(); }

    public static void main(String[] args) throws Exception {
	if (args.length > 0)
	    BeamDebug.loglevel = Integer.valueOf(args[0]);
        BeamClient client = new BeamClient();
        client.loadModules("load.txt");
        client.runApplies("apply.txt");
    }
}
