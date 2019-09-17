import java.util.ArrayList;

public class ErlProcess {
    private BeamVM vm;
    private Register x_reg;
    private Register y_reg;
    public ErlProcess(BeamVM bv) {
        vm = bv;
    }
}

class Register {
    ArrayList<ErlTerm> slots;
    public Register() {
        slots = new ArrayList<ErlTerm>();
    }
    public void set(int index, ErlTerm value) {
        slots.set(index, value);
    }

    public ErlTerm get(int index) {
        return slots.get(index);
    }
}
