package coffeebeam.erts;

import coffeebeam.types.*;
import coffeebeam.beam.BeamFormatException;
import coffeebeam.client.BeamClient;
import coffeebeam.beam.BeamFile;
import coffeebeam.beam.BeamReader;
import java.io.*;
import java.util.*;

public class BeamVM {
    private ArrayList<BeamModule> modules;
    private Scheduler scheduler;
    private HashMap<String, ErlPid> regs;
    private Logger logger;

    public BeamVM(Logger l) {
        logger = l;
        modules = new ArrayList<BeamModule>();
	scheduler = new Scheduler(this, logger);
	regs = new HashMap<String, ErlPid>();
	scheduler.start();
    }

    public void load(InputStream is) throws IOException, BeamFormatException {
        BeamReader br = new BeamReader(is);
        BeamFile bf = br.read();
        modules.add(new BeamModule(bf.getModuleName(), bf));
        bf.dump();
        logger.i("BeamVM: loaded '" + bf.getModuleName() + "'");
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

    public ErlTerm send(ErlTerm p, ErlTerm message) {
        ErlPid pid = null;
	if (p instanceof ErlPid) {
	    pid = (ErlPid) p;
	} else if (p instanceof ErlAtom) {
	    pid = getProcess((ErlAtom) p);
            if (pid == null)
                return new ErlException(new ErlAtom("badarg"));
	} // TODO: send to tuple {proc, node}
        return scheduler.send(pid, message);
    }

    public void setTimeout(ErlPid pid, int timeout) {
        scheduler.setTimeout(pid, timeout);
    }

    public Scheduler getScheduler() { return scheduler; }

    private ErlPid getProcess(ErlAtom name) {
	return regs.get(name.getValue());
    }

    public ErlAtom register(ErlAtom name, ErlPid pid) {
	regs.put(name.getValue(), pid);
	return new ErlAtom("true");
    }

    public ErlTerm unregister(ErlAtom name) {
        ErlPid removed = regs.remove(name.getValue());
        if (removed == null) {
            return new ErlException(new ErlAtom("badarg"));
        } else {
            return new ErlAtom("true");
        }
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

class Scheduler extends Thread {
    private BeamVM vm;
    private long nextPid = 1;
    private ArrayList<ErlProcess> processes;
    private ArrayList<Timeout> timeouts;
    private volatile boolean stop = false;
    private Logger logger;

    public Scheduler(BeamVM bv, Logger l) {
        super();
	vm = bv;
        logger = l;
	processes = new ArrayList<ErlProcess>();
        timeouts = new ArrayList<Timeout>();
    }
    public ErlProcess newProcess(BeamClient client) {
	ErlProcess p = new ErlProcess(vm, new ErlPid(nextPid++), client, logger);
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
        super.run();
        while (!stop) {
            if (processes.size() > 0) {
		//dump();
                ErlProcess p = checkTimeout();
                if (p != null) {
                    p.timeout();
                    p.setState(ErlProcess.State.RUNNABLE);
                }
                else p = processes.get(0);
                if (p.getState() == ErlProcess.State.RUNNABLE) {
                    ErlTerm result = p.run();
                    if (result == null) {
                        logger.i("VM: reschedule " + p.getPid());
                        removeProcess(p);
                        processes.add(p);
                    } else {
                        logger.i("result: " + result.toString());
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
        logger.i("Scheduler exited.");
    }

    private void dump() {
	for (int i = 0; i < processes.size(); i++) {
	    ErlProcess p = processes.get(i);
	    logger.d("process " + i + " " + p.getPid() + " " + p.getState());
	    logger.d("");
	}
    }

    public ErlTerm send(ErlPid pid, ErlTerm message) {
        ErlProcess p = getProcess(pid);
        p.put_message(message);
        return message;
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

class ProcReg {
    ErlAtom name;
    ErlPid pid;

    public ProcReg(ErlAtom n, ErlPid p) { name = n; pid = p; }
}
