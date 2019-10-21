package coffeebeam.beam;

import coffeebeam.types.*;
import java.util.ArrayList;

public class ErlOp {
    public int opcode;
    public ArrayList <ErlTerm> args;
    public ErlOp(int oc, ArrayList<ErlTerm> a) {
        opcode = oc;
        args = a;
    }
}
