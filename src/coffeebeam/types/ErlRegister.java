package coffeebeam.types;

public class ErlRegister extends ErlTerm {
    private int index;
    private String type;
    public ErlRegister(String t, int i) {
        super(t + "register", 0);
        type = t;
        index = i;
    }
    public String toString() { return type + "(" + index + ")"; }
    public String toId() { return tag + "(" + index + ")"; }
    public int getIndex() { return index; }
    public String getType() { return type; }
}
