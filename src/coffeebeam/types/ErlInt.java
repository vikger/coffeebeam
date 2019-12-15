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

    public ErlTerm add(ErlTerm b) {
	if (b instanceof ErlInt)
	    return new ErlInt(value + ((ErlInt) b).getValue());
	else if (b instanceof ErlFloat)
	    return new ErlFloat(value + ((ErlFloat) b).getValue());
	return new ErlException(new ErlAtom("badarith"));
    }

    public ErlTerm subtract(ErlTerm b) {
	if (b instanceof ErlInt)
	    return new ErlInt(value - ((ErlInt) b).getValue());
	else if (b instanceof ErlFloat)
	    return new ErlFloat(value - ((ErlFloat) b).getValue());
	return new ErlException(new ErlAtom("badarith"));
    }

    public ErlTerm mul(ErlTerm b) {
	if (b instanceof ErlInt)
	    return new ErlInt(value * ((ErlInt) b).getValue());
	else if (b instanceof ErlFloat)
	    return new ErlFloat(value * ((ErlFloat) b).getValue());
	return new ErlException(new ErlAtom("badarith"));
    }

    public ErlTerm div(ErlTerm b) {
	if (b instanceof ErlInt)
	    return new ErlInt(value / ((ErlInt) b).getValue());
	return new ErlException(new ErlAtom("badarith"));
    }

    public ErlTerm rem(ErlTerm b) {
	if (b instanceof ErlInt)
	    return new ErlInt(value % ((ErlInt) b).getValue());
	return new ErlException(new ErlAtom("badarith"));
    }

    public ErlTerm bsr(ErlTerm b) {
	if (b instanceof ErlInt)
	    return new ErlInt(value >> ((ErlInt) b).getValue());
	return new ErlException(new ErlAtom("badarith"));
    }

    public ErlTerm band(ErlTerm b) {
	if (b instanceof ErlInt)
	    return new ErlInt(value & ((ErlInt) b).getValue());
	return new ErlException(new ErlAtom("badarith"));
    }

    public ErlTerm bor(ErlTerm b) {
	if (b instanceof ErlInt)
	    return new ErlInt(value | ((ErlInt) b).getValue());
	return new ErlException(new ErlAtom("badarith"));
    }

    public ErlTerm bxor(ErlTerm b) {
	if (b instanceof ErlInt)
	    return new ErlInt(value ^ ((ErlInt) b).getValue());
	return new ErlException(new ErlAtom("badarith"));
    }

    public ErlTerm bnot() {
	return new ErlInt(~value);
    }
}
