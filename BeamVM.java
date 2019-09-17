import java.io.IOException;
import java.util.ArrayList;

public class BeamVM {
    private ArrayList<BeamModule> modules;
    public BeamVM() {
        modules = new ArrayList<BeamModule>();
    }

    public void load(String filename) throws IOException, BeamFormatException {
        BeamReader br = new BeamReader(filename);
        BeamFile bf = br.read();
        modules.add(new BeamModule(bf.getModuleName(), bf));
        bf.dump();
        System.out.println("BeamVM: loaded '" + bf.getModuleName() + "'");
    }

    public BeamModule getModule(String name) {
        for (int i = 0; i < modules.size(); i++) {
            if (modules.get(i).name.equals(name)) return modules.get(i);
        }
        return null;
    }

    public static void main(String[] args) {
	try {
            BeamVM vm = new BeamVM();
            vm.load(args[0]);
            ErlProcess p = new ErlProcess(vm);
            p.apply("example", "module_info");
	} catch (Exception e) { System.out.println(e.toString()); }
    }
}

class BeamModule {
    String name;
    BeamFile file;

    public BeamModule(String n, BeamFile f) {
        name = n;
        file = f;
    }
}
