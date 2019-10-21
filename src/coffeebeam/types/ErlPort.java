package coffeebeam.types;

public class ErlPort extends ErlTerm {
    private long id;

    public ErlPort() {
        super("port", 5);
    }
    public String toString() { return "#Port<" + id + ">"; }
    public String toId() { return tag + "(" + id + ")"; }
    public long getValue() { return id; }
}
