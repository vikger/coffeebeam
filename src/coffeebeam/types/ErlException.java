package coffeebeam.types;

public class ErlException extends ErlTerm {
    private ErlTerm value;
    public ErlException(ErlTerm v) { super("exception", 0); value = v; }
    public String toString() { return "** exception: " + value.toString(); }
    public String toId() { return tag + "(" + value.toId() + ")"; }
    public ErlTerm getValue() { return value; }
}
