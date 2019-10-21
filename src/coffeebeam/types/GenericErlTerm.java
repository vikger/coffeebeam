package coffeebeam.types;

public class GenericErlTerm extends ErlTerm {
    int value;
    public GenericErlTerm(int v) {
        super("generic", 0);
        value = v;
    }

    public boolean isReference() { return false; }

    public String toString() { return "term(" + getTag() + "): " + value; }
    public String toId() { return tag + "(" + value + ")"; }
}
