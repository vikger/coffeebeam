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

    public ErlTerm add(ErlTerm b) {
	if (b instanceof ErlInt)
	    return new ErlFloat(value + ((ErlInt) b).getValue());
	else if (b instanceof ErlFloat)
	    return new ErlFloat(value + ((ErlFloat) b).getValue());
	return new ErlException(new ErlAtom("badarith"));
    }

    public ErlTerm subtract(ErlTerm b) {
	if (b instanceof ErlInt)
	    return new ErlFloat(value - ((ErlInt) b).getValue());
	else if (b instanceof ErlFloat)
	    return new ErlFloat(value - ((ErlFloat) b).getValue());
	return new ErlException(new ErlAtom("badarith"));
    }

    public ErlTerm mul(ErlTerm b) {
	if (b instanceof ErlInt)
	    return new ErlFloat(value * ((ErlInt) b).getValue());
	else if (b instanceof ErlFloat)
	    return new ErlFloat(value * ((ErlFloat) b).getValue());
	return new ErlException(new ErlAtom("badarith"));
    }
}
