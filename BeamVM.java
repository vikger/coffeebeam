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

    public void send(ErlPid pid, ErlTerm message) {
        scheduler.send(pid, message);
    }

    public void setTimeout(ErlPid pid, int timeout) {
        scheduler.setTimeout(pid, timeout);
    }

    public ErlTerm test(String module, String function, ErlTerm[] args) {
        ErlProcess p = scheduler.newProcess();
        p.prepare(module, function, args);
        ErlTerm result;
        do {
            result = p.run();
        } while (result == null);
        return result;
    }

    private ErlTerm readTerm(BufferedReader reader) throws Exception {
        String line = reader.readLine();
        return ErlTerm.parse(line);
    }

    public Scheduler getScheduler() { return scheduler; }

    public static void main(String[] args) throws Exception {
	if (args.length > 0 && args[0].equals("debug"))
	    BeamDebug.debug = true;
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
    private ArrayList<Timeout> timeouts;

    public Scheduler(BeamVM bv) {
	vm = bv;
	processes = new ArrayList<ErlProcess>();
        timeouts = new ArrayList<Timeout>();
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
    public void removeProcess(ErlProcess p) {
        for (int i = 0; i < processes.size(); i++) {
            if (p == processes.get(i)) {
                processes.remove(i);
                return;
            }
        }
    }

    public void start() {
	while (processes.size() > 0) {
            ErlProcess p = checkTimeout();
            if (p != null) {
                p.timeout();
                p.setState(ErlProcess.State.RUNNABLE);
            }
            else p = processes.get(0);
            if (p.getState() == ErlProcess.State.RUNNABLE) {
                ErlTerm result = p.run();
                if (result == null) {
                    System.out.println("VM: reschedule " + p.getPid());
                    processes.remove(0);
                    processes.add(p);
                } else {
                    System.out.println("result: " + result.toString());
                    processes.remove(0);
                }
            } else {
                removeProcess(p);
                processes.add(p);
            }
	}
    }
    public void send(ErlPid pid, ErlTerm message) {
        ErlProcess p = getProcess(pid);
        p.put_message(message);
    }

    public void setTimeout(ErlPid pid, int timeout) {
        timeouts.add(new Timeout(pid, timeout));
    }

    private ErlProcess checkTimeout() {
        long currentTime = System.currentTimeMillis();
        for (int i = 0; i < timeouts.size(); i++) {
            if (timeouts.get(i).timeout < currentTime)
                return getProcess(timeouts.get(i).pid);
        }
        return null;
    }
}

class Timeout {
    ErlPid pid;
    long timeout;

    public Timeout(ErlPid p, int t) {
        pid = p;
        timeout = System.currentTimeMillis() + t;
    }
}
