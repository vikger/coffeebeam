import java.util.ArrayList;

public class ErlProcess {
    private BeamVM vm;
    private Register x_reg;
    private Register y_reg;
    private int ip;
    private BeamFile file;
    public ErlProcess(BeamVM bv) {
        vm = bv;
        x_reg = new Register();
        y_reg = new Register();
    }

    public void apply(String module, String function) {
        file = vm.getModule(module).file;
        int label = file.getLabel(function, 0); // TODO: add arguments to apply
        ip = file.getLabelRef(label);
        System.out.println("apply " + module + ":" + function + " ip: " + ip);
        run();
    }

    public void run() {
        ErlTerm result = null;

        while (result == null) {
            ip++; // step over label
            System.out.println("ip -> " + ip);
            ErlOp op = file.getOp(ip);
            result = execute(op);
        }
        System.out.println("result: " + result.toString());
    }

    public ErlTerm execute(ErlOp op) {
        System.out.println("execute op " + op.opcode);
        switch (op.opcode) {
        case 19: return x_reg.get(0);
        case 64:
            ErlTerm reg = op.args.get(1);
            switch (reg.getTag()) {
            case "X register": x_reg.set(((Xregister) reg).getIndex(), op.args.get(0)); return null;
            case "Y register": y_reg.set(((Yregister) reg).getIndex(), op.args.get(0)); return null;
            }
        case 153: return null; // skip line
        default: System.out.println("UNKNOWN op: " + op.opcode + " (" + OpCode.name(op.opcode) + ")");
        }
        return null;
    }

    private void move(Xregister source, Xregister dest) {
    }

    private void move(ErlTerm source, Xregister dest) {
        x_reg.set(dest.getIndex(), source);
    }
}

class Register {
    ArrayList<ErlTerm> slots;
    int maxindex = -1;

    public Register() {
        slots = new ArrayList<ErlTerm>();
    }

    public void set(int index, ErlTerm value) {
        while (index > maxindex) {
            slots.add(new ErlNil());
            maxindex++;
        }
        slots.set(index, value);
    }

    public ErlTerm get(int index) {
        return slots.get(index);
    }

    public void dump() {
        System.out.println("reg: " + slots.size() + " |");
        for (int i = 0; i < slots.size(); i++) {
            System.out.print(" " + slots.get(i));
        }
    }
}
