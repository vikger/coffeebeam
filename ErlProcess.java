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

    public void apply(String module, String function, ErlTerm[] args) {
        file = vm.getModule(module).file;
        int argc = args.length;
        int label = file.getLabel(function, argc);
        ip = file.getLabelRef(label);
        System.out.println("apply " + module + ":" + function + "/" + argc + " ip: " + ip);
        for (int i = 0; i < argc; i++) {
            x_reg.set(i, args[i]);
        }
        run();
    }

    public void run() {
        ErlTerm result = null;

        while (result == null) {
            System.out.println("ip -> " + ip);
            ErlOp op = file.getOp(ip);
            result = execute(op);
        }
        System.out.println("result: " + result.toString());
    }

    public ErlTerm execute(ErlOp op) {
        System.out.println("execute op " + op.opcode + " " + OpCode.name(op.opcode));
        switch (op.opcode) {
        case 1: ip++; return null; // skip label
            // case 7 call_ext: save module, ip, x, y on stack
        case 19: return x_reg.get(0);
        case 64:
            ErlTerm value = getValue(op.args.get(0));
            ErlTerm reg = op.args.get(1);
            if (reg instanceof Xregister) {
                x_reg.set(((Xregister) reg).getIndex(), value); ip++; return null;
            } else if (reg instanceof Yregister) {
                y_reg.set(((Yregister) reg).getIndex(), value); ip++; return null;
            }
        case 78:
            Import mfa = file.getImport(((ErlInt) op.args.get(1)).getValue());
            return setCallExtOnly(mfa);
        case 153: ip++; return null; // skip line
        default: System.out.println("UNKNOWN op: " + op.opcode + " (" + OpCode.name(op.opcode) + ")");
        }
        ip++; return null;
    }

    public ErlTerm setCallExtOnly(Import mfa) {
        String mod = file.getAtomName(mfa.getModule());
        String function = file.getAtomName(mfa.getFunction());
        int arity = mfa.getArity();
        if (mod.equals("erlang")) {
            if (function.equals("get_module_info")) {
                return new ErlString("module_info(" + x_reg.get(0).toString() + ")");
            }
        } else {
            file = vm.getModule(mod).file;
            int label = file.getLabel(function, arity);
            ip = file.getLabelRef(label);
        }
        return null;
    }

    private ErlTerm getValue(ErlTerm source) {
        if (source instanceof Xregister) {
            return x_reg.get(((Xregister) source).getIndex());
        } else if (source instanceof Yregister) {
            return y_reg.get(((Yregister) source).getIndex());
        } else {
            return source;
        }
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
