import java.io.*;
import java.util.ArrayList;

public class BeamVM {
    private ArrayList<BeamModule> modules;
    private Scheduler scheduler;

    public BeamVM() {
        modules = new ArrayList<BeamModule>();
	scheduler = new Scheduler(this);
	scheduler.start();
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

    public ErlProcess newProcess(BeamClient client) {
        return scheduler.newProcess(client);
    }

    public void halt() {
        scheduler.halt();
    }

    public void send(ErlPid pid, ErlTerm message) {
        scheduler.send(pid, message);
    }

    public void setTimeout(ErlPid pid, int timeout) {
        scheduler.setTimeout(pid, timeout);
    }

    public Scheduler getScheduler() { return scheduler; }

}

class BeamModule {
    String name;
    BeamFile file;

    public BeamModule(String n, BeamFile f) {
        name = n;
        file = f;
    }
}

class Scheduler extends Thread {
    private BeamVM vm;
    private long nextPid = 1;
    private ArrayList<ErlProcess> processes;
    private ArrayList<Timeout> timeouts;
    private volatile boolean stop = false;

    public Scheduler(BeamVM bv) {
        super();
	vm = bv;
	processes = new ArrayList<ErlProcess>();
        timeouts = new ArrayList<Timeout>();
    }
    public ErlProcess newProcess(BeamClient client) {
	ErlProcess p = new ErlProcess(vm, new ErlPid(nextPid++), client);
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
        super.start();
    }

    public void halt() {
        stop = true;
    }

    public void run() {
        while (!stop) {
            if (processes.size() > 0) {
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
                        removeProcess(p);
                        processes.add(p);
                    } else {
                        System.out.println("result: " + result.toString());
                        removeProcess(p);
                        BeamClient client = p.getClient();
                        if (client != null)
                            client.handleResult(result);
                    }
                } else {
                    removeProcess(p);
                    processes.add(p);
                }
            }
        }
        System.out.println("Scheduler exited.");
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
