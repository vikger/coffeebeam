package coffeebeam.types;

public class ErlInt extends ErlNumber {
    int value;

    public ErlInt(int v) {
        super("integer");
        value = v;
    }
    public String toString() { return Integer.toString(value); }

    public String toId() { return tag + "(" + value + ")"; }

    public int getValue() { return value; }
}
