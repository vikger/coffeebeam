package coffeebeam.client;

import coffeebeam.erts.*;
import coffeebeam.types.*;
import coffeebeam.beam.BeamDebug;
import java.io.FileInputStream;
import java.io.InputStream;

public class BeamClient {
    public BeamVM vm = null;
    public volatile ErlTerm result = null;
    private Logger logger;

    private BeamClient() {}
    public BeamClient(Logger l) { logger = l; }
    public void startVM() { vm = new BeamVM(logger); }
    public void stopVM() { vm.halt(); }
    public void attachToVM(BeamVM othervm) { vm = othervm; }

    public void loadModule(String filename) throws Exception {
        InputStream file = new FileInputStream(filename);
        vm.load(file);
    }

    public void loadModule(InputStream is) throws Exception {
        vm.load(is);
    }

    public void apply(String module, String function, ErlList args) {
        ErlProcess p = vm.newProcess(this);
        p.prepare(module, function, args);
    }

    public void handleCall(String function, ErlTerm arg) {
        BeamDebug.debug("client handleCall " + function + " " + arg);
    }

    public void handleResult(ErlTerm r) {
        result = r;
    }

    public ErlTerm test(String module, String function, ErlList args) {
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
}
