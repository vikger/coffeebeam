package coffeebeam.types;

public class ErlException extends ErlTerm {
    private ErlTerm type;
    private ErlTerm value;
    public ErlException(ErlTerm v) { super("exception", 0); type = new ErlAtom("error"); value = v; }
    public ErlException(ErlTerm t, ErlTerm v) { super("exception", 0); type = t; value = v; }
    public String toString() { return "** exception " + type.toString() + ": " + value.toString(); }
    public String toId() { return tag + "(" + value.toId() + ")"; }
    public ErlTerm getType() { return type; }
    public ErlTerm getValue() { return value; }
}
