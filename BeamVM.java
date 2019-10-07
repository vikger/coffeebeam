import java.io.*;
import java.util.ArrayList;

public class BeamVM {
    private ArrayList<BeamModule> modules;
    private Scheduler scheduler;

    public BeamVM() {
        modules = new ArrayList<BeamModule>();
	scheduler = new Scheduler(this);
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
                    args[i] = readTerm(reader);
                }
                ErlProcess p = scheduler.newProcess();
                p.prepare(mfa[0], mfa[1], args);
            }
        }
        reader.close();
	scheduler.start();
    }

    private ErlTerm readTerm(BufferedReader reader) throws Exception {
        String line = reader.readLine();
        String[] term = line.split(" ", 2);
        if (term[0].equals("ErlInt")) return new ErlInt(Integer.valueOf(term[1]));
        else if (term[0].equals("ErlFloat")) return new ErlFloat(Float.valueOf(term[1]));
        else if (term[0].equals("ErlAtom")) return new ErlAtom(term[1]);
        else if (term[0].equals("ErlList")) {
            int length = Integer.valueOf(term[1]);
            ErlList list = new ErlList();
            for (int i = 0; i < length; i++) {
                list.add(readTerm(reader));
            }
            list.setTail(readTerm(reader));
            return list;
        } else if (term[0].equals("ErlNil")) return new ErlList();
        else if (term[0].equals("ErlMap")) {
            int maplength = Integer.valueOf(term[1]);
            ErlMap map = new ErlMap();
            for (int i = 0; i < maplength; i++) {
                map.add(readTerm(reader), readTerm(reader));
            }
            return map;
        } else System.out.println("Unknown type: '" + term[0] + "'");
        return null;
    }

    public Scheduler getScheduler() { return scheduler; }

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

class Scheduler {
    private BeamVM vm;
    private long nextPid = 1;
    private ArrayList<ErlProcess> processes;

    public Scheduler(BeamVM bv) {
	vm = bv;
	processes = new ArrayList<ErlProcess>();
    }
    public ErlProcess newProcess() {
	ErlProcess p = new ErlProcess(vm, new ErlPid(nextPid++));
	processes.add(p);
	return p;
    }
    public ErlProcess getProcess(ErlPid pid) {
	for (int i = 0; i < processes.size(); i++) {
	    if (processes.get(i).getPid().getValue() == pid.getValue())
		return processes.get(i);
	}
	return null;
    }
    public void start() {
	while (processes.size() > 0) {
	    ErlTerm result = processes.get(0).run();
	    System.out.println("result: " + result.toString());
	    processes.remove(0);
	}
    }
}
