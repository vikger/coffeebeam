package coffeebeam.types;

public class ErlPid extends ErlTerm {
    private long pid;

    public ErlPid(long p) {
	super("pid", 6);
	pid = p;
    }
    public String toString() { return "PID<" + pid + ">"; }
    public String toId() { return tag + "(" + pid + ")"; }
    public long getValue() { return pid; }
}

