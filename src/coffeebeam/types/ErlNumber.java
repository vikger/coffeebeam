package coffeebeam.types;

public abstract class ErlNumber extends ErlTerm {
    public ErlNumber(String tag) {
        super(tag, 1);
    }
}
