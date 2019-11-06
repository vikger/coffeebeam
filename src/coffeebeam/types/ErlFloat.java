package coffeebeam.types;

public class ErlFloat extends ErlNumber {
    double value;

    public ErlFloat(double v) {
        super("float");
        value = v;
    }
    public ErlFloat(ErlTerm t) {
        super("float");
        if (t instanceof ErlInt) {
            value = (double) ((ErlInt) t).getValue();
        }
    }
    public String toString() { return Double.toString(value); }
    public String toId() { return tag + "(" + value + ")"; }
    public double getValue() { return value; }
}
