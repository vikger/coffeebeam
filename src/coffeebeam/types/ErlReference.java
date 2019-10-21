package coffeebeam.types;

import java.util.Random;

public class ErlReference extends ErlTerm {
    private long ref;

    public ErlReference() {
        super("reference", 3);
        ref = (new Random()).nextLong();
    }
    public String toString() { return "#Ref<" + ref + ">"; }
    public String toId() { return tag + "(" + ref + ")"; }
    public long getValue() { return ref; }
}
