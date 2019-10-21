package coffeebeam.types;

public class ErlFloat extends ErlNumber {
    float value;

    public ErlFloat(float v) {
        super("float");
        value = v;
    }
    public ErlFloat(ErlTerm t) {
        super("float");
        if (t instanceof ErlInt) {
            value = (float) ((ErlInt) t).getValue();
        }
    }
    public String toString() { return Float.toString(value); }
    public String toId() { return tag + "(" + value + ")"; }
    public float getValue() { return value; }
}
