package coffeebeam.types;

public class ErlLabel extends ErlTerm {
    private int value;
    public ErlLabel(int v) {
        super("label", 0);
        value = v;
        reference = true;
    }
    public int getValue() { return value; }
    public String toString() { return "label(" + value + ")"; }
    public String toId() { return tag + "(" + value + ")"; }
}
