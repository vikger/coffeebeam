package coffeebeam.client;

import coffeebeam.erts.*;
import coffeebeam.types.*;
import coffeebeam.beam.BeamDebug;

public class BeamClient {
    public BeamVM vm = null;
    public volatile ErlTerm result = null;

    public void startVM() { vm = new BeamVM(); }
    public void stopVM() { vm.halt(); }
    public void attachToVM(BeamVM othervm) { vm = othervm; }

    public void loadModule(String filename) throws Exception { vm.load(filename); }
    public void apply(String module, String function, ErlTerm[] args) {
        ErlProcess p = vm.newProcess(this);
        p.prepare(module, function, args);
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
}
