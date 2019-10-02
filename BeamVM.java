import java.io.*;
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

    public void loadModules(String filename) throws Exception {
        BufferedReader reader = new BufferedReader(new FileReader(filename));
        String module;
        while ((module = reader.readLine()) != null) {
            load(module);
        }
        reader.close();
    }

    public void runApplies(String filename) throws Exception {
        BufferedReader reader = new BufferedReader(new FileReader(filename));
        String module;
        String function;
        ErlTerm[] args;
        int arity;
        while ((module = reader.readLine()) != null) {
            function = reader.readLine();
            arity = Integer.valueOf(reader.readLine());
            args = new ErlTerm[arity];
            for (int i = 0; i < arity; i++) {
                args[i] = readTerm(reader);
            }
            ErlProcess p = new ErlProcess(this);
            p.apply(module, function, args);
        }
        reader.close();
    }

    private ErlTerm readTerm(BufferedReader reader) throws Exception {
        String type = reader.readLine();
        if (type.equals("ErlInt")) return new ErlInt(Integer.valueOf(reader.readLine()));
        else if (type.equals("ErlAtom")) return new ErlAtom(reader.readLine());
        else if (type.equals("ErlList")) {
            int length = Integer.valueOf(reader.readLine());
            ErlList list = new ErlList();
            for (int i = 0; i < length; i++) {
                list.add(readTerm(reader));
            }
            list.setTail(readTerm(reader));
            return list;
        } else if (type.equals("ErlNil")) return new ErlNil();
        else System.out.println("Unknown type: '" + type + "'");
        return null;
    }

    public static void main(String[] args) throws Exception {
        BeamVM vm = new BeamVM();
        vm.loadModules("load.txt");
        vm.runApplies("apply.txt");
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
