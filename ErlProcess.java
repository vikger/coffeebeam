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
        case 2: // func_info
            String func_info = "Error: " + op.args.get(0) + ":" + op.args.get(1) + "(";
            int argc = ((ErlInt) op.args.get(2)).getValue();
            for (int i = 0; i < argc; i++) {
                if (i > 0) func_info += ",";
                func_info += x_reg.get(i).toString();
            }
            func_info += ")";
            return new ErlString(func_info);
        case 19: return x_reg.get(0);
        case 43: // is_eq_exact, TODO: apply for all types
            if (getValue(op.args.get(1)).toString().equals(getValue(op.args.get(2)).toString())) {
                ip++;
            } else {
                ip = file.getLabelRef(((ErlLabel) op.args.get(0)).getValue());
            }
            return null;
        case 56: // is_nonempty_list
            ErlTerm listarg = getValue(op.args.get(1));
            if (listarg instanceof ErlList) ip++;
            else ip = file.getLabelRef(((ErlLabel) op.args.get(0)).getValue());
            return null;
        case 64:
            ErlTerm value = getValue(op.args.get(0));
            ErlTerm reg = op.args.get(1);
            if (reg instanceof Xregister) {
                x_reg.set(((Xregister) reg).getIndex(), value);
            } else if (reg instanceof Yregister) {
                y_reg.set(((Yregister) reg).getIndex(), value);
            }
            ip++;
            return null;
        case 69: // put_list
            ErlTerm head = getValue(op.args.get(0));
            ErlTerm tail = getValue(op.args.get(1));
            ErlList list = new ErlList(head, tail);
            ErlTerm listreg = op.args.get(2);
            if (listreg instanceof Xregister) {
                x_reg.set(((Xregister) listreg).getIndex(), list);
            } else if (listreg instanceof Yregister) {
                y_reg.set(((Yregister) listreg).getIndex(), list);
            }
            ip++;
            return null;
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
            } else if (function.equals("spawn")) { // TODO: extend with new process
                String res = "spawn(";
                for (int i = 0; i < arity; i++) {
                    res += x_reg.get(i).toString() + " ";
                }
                res += ")";
                return new ErlString(res);
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
            slots.add(new ErlList()); // can be any ErlTerm instance
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
