import java.util.ArrayList;

public class ErlProcess {
    private BeamVM vm;
    private Register x_reg;
    private Register y_reg;
    private int ip;
    private BeamFile file;
    private Stack<Integer> ip_stack;
    private Stack<Register> reg_stack;
    private Import mfa;

    public ErlProcess(BeamVM bv) {
        vm = bv;
        x_reg = new Register();
        y_reg = new Register();
        ip_stack = new Stack<Integer>();
        reg_stack = new Stack<Register>();
    }

    public void apply(String module, String function, ErlTerm[] args) {
        file = vm.getModule(module).file;
        int argc = args.length;
        int label = file.getLabel(function, argc);
        ip = file.getLabelRef(label);
        System.out.print("apply " + module + ":" + function + "/" + argc);
        for (int i = 0; i < argc; i++) {
            x_reg.set(i, args[i]);
            System.out.print("\t" + args[i]);
        }
        System.out.println();
        run();
    }

    public void run() {
        ErlTerm result = null;

        while (result == null || !ip_stack.isEmpty()) {
            if (result != null) {
                ip = ip_stack.pop(); // TODO: check if only occurs on return
                System.out.println("pop: " + ip + " size " + ip_stack.size());
                ip++;
            }
            if (ip == -1) {
                result = new ErlException("badarg");
            } else {
                ErlOp op = file.getOp(ip);
                result = execute(op);
            }
        }
        System.out.println("result: " + result.toString());
    }

    public ErlTerm execute(ErlOp op) {
        System.out.print("  ip(" + ip + ")\t" + OpCode.name(op.opcode) + "(" + op.opcode + ")");
        for (int i = 0; i < OpCode.arity(op.opcode); i++) System.out.print("\t" + op.args.get(i).toString());
        System.out.println();
        //x_reg.dump();
        //y_reg.dump();
        switch (op.opcode) {
        case 1: ip++; return null; // skip label
        case 2: // func_info
            String func_info = op.args.get(0) + ":" + op.args.get(1) + "(";
            int argc = ((ErlInt) op.args.get(2)).getValue();
            for (int i = 0; i < argc; i++) {
                if (i > 0) func_info += ",";
                func_info += x_reg.get(i).toString();
            }
            func_info += ")";
            return new ErlException("function_clause " + func_info);
        case 4: // call
            ip_stack.push(ip); System.out.println("push: " + ip + " size " + ip_stack.size());
            save();
            jump(op.args.get(1));
            return null;
        case 5: // call_last
            jump(op.args.get(1));
            return null;
        case 6: // call_only
            jump(op.args.get(1));
            return null;
        case 7: // call_ext
            // TODO: save module, ip, regs
            ip_stack.push(ip); System.out.println("push: " + ip + " size " + ip_stack.size());
            mfa = file.getImport(((ErlInt) op.args.get(1)).getValue());
            return setCallExt(mfa);
        case 12: // allocate
            ip++; return null;
        case 13: ip++; return null; // skip allocate_heap
        case 16: ip++; return null; // skip test_heap
        case 18: // deallocate
            ip++; return null;
        case 19:
            if (!reg_stack.isEmpty()) restore();
            System.out.println("return: " + x_reg.get(0));
            return x_reg.get(0);
        case 43: // is_eq_exact, TODO: apply for all types
            if (getValue(op.args.get(1)).toId().equals(getValue(op.args.get(2)).toId())) {
                ip++;
            } else {
                jump(op.args.get(0));
            }
            return null;
        case 45: // is_integer
            if (getValue(op.args.get(1)) instanceof ErlInt) ip++;
            else jump(op.args.get(0));
            return null;
        case 46: // is_float
            if (getValue(op.args.get(1)) instanceof ErlFloat) ip++;
            else jump(op.args.get(0));
            return null;
        case 48: // is_atom
            if (getValue(op.args.get(1)) instanceof ErlAtom) ip++;
            else jump(op.args.get(0));
            return null;
        case 52: // is_nil
            ErlTerm is_nil_list = getValue(op.args.get(1));
            if (is_nil_list instanceof ErlList) {
                if (((ErlList) is_nil_list).isNil()) {
                    ip++;
                    return null;
                }
            }
            jump(op.args.get(0));
            return null;
        case 55: // is_list
            if (getValue(op.args.get(1)) instanceof ErlList) ip++;
            else jump(op.args.get(0));
            return null;
        case 56: // is_nonempty_list
            ErlTerm listarg = getValue(op.args.get(1));
            if (listarg instanceof ErlList && !((ErlList) listarg).isNil())
                ip++;
            else jump(op.args.get(0));
            return null;
        case 64:
            ErlTerm value = getValue(op.args.get(0));
            ErlTerm reg = op.args.get(1);
            set_reg(op.args.get(1), value);
            ip++;
            return null;
        case 65: // get_list
            ErlTerm get_list = getValue(op.args.get(0));
            set_reg(op.args.get(1), ((ErlList) get_list).head);
            set_reg(op.args.get(2), ((ErlList) get_list).tail);
            ip++;
            return null;
        case 69: // put_list
            ErlTerm head = getValue(op.args.get(0));
            ErlTerm tail = getValue(op.args.get(1));
            ErlList list = new ErlList(head, tail);
            set_reg(op.args.get(2), list);
            ip++;
            return null;
        case 78: // call_ext_only
            mfa = file.getImport(((ErlInt) op.args.get(1)).getValue());
            return setCallExtOnly(mfa);
        case 125: // gc_bif2
            Import bif2_mfa = file.getImport(((ErlInt) op.args.get(2)).getValue());
            ErlTerm bif2_result = gc_bif2(bif2_mfa, getValue(op.args.get(3)), getValue(op.args.get(4)));
            if (bif2_result == null) return new ErlException("bif2 error");
            set_reg(op.args.get(5), bif2_result);
            ip++;
            return null;
        case 153: ip++; return null; // skip line
        case 163: // get_tl
            ErlTerm get_tl_tail = ((ErlList) getValue(op.args.get(0))).tail;
            set_reg(op.args.get(1), get_tl_tail);
            ip++;
            return null;
        case 164: // put_tuple2
            ErlList elements = (ErlList) op.args.get(1);
            ErlTuple tuple = new ErlTuple();
            while (!elements.isNil()) {
                tuple.add(getValue(elements.head));
                elements = (ErlList) elements.tail;
            }
            set_reg(op.args.get(0), tuple);
            ip++;
            return null;
        default: System.out.println("UNKNOWN op: " + op.opcode + " (" + OpCode.name(op.opcode) + ")");
        }
        ip++; return null;
    }

    private ErlTerm gc_bif2(Import mfa, ErlTerm arg1, ErlTerm arg2) {
        String mod = file.getAtomName(mfa.getModule());
        String function = file.getAtomName(mfa.getFunction());
        if (mod.equals("erlang")) {
            if (function.equals("+")) {
                if (arg1 instanceof ErlInt) {
                    if (arg2 instanceof ErlInt) {
                        return new ErlInt(((ErlInt) arg1).getValue() + ((ErlInt) arg2).getValue());
                    }
                }
            } else if (function.equals("-")) {
                if (arg1 instanceof ErlInt) {
                    if (arg2 instanceof ErlInt) {
                        return new ErlInt(((ErlInt) arg1).getValue() - ((ErlInt) arg2).getValue());
                    }
                }
            }
        }
        return new ErlException("gc_bif2 " + arg1.toString() + " " + arg2.toString());
    }

    private void set_reg(ErlTerm reg, ErlTerm value) {
        if (reg instanceof Xregister) {
            x_reg.set(((Xregister) reg).getIndex(), value);
        } else if (reg instanceof Yregister) {
            y_reg.set(((Yregister) reg).getIndex(), value);
        }
    }

    public ErlTerm setCallExt(Import mfa) {
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
                x_reg.set(0, new ErlString(res));
            } else if (function.equals("atom_to_list")) {
                String atomstr = ((ErlAtom) x_reg.get(0)).getValue();
                ErlList atomlist = string_to_list(atomstr);
                x_reg.set(0, atomlist);
                return atomlist;
            } else if (function.equals("integer_to_list")) {
                String intstr = Integer.toString(((ErlInt) x_reg.get(0)).getValue());
                ErlList intlist = string_to_list(intstr);
                x_reg.set(0, intlist);
                return intlist;
            } else if (function.equals("float_to_list")) {
                String floatstr = Float.toString(((ErlFloat) x_reg.get(0)).getValue());
                ErlList floatlist = string_to_list(floatstr);
                x_reg.set(0, floatlist);
                return floatlist;
            }
        } else {
            save();
            file = vm.getModule(mod).file;
            int label = file.getLabel(function, arity);
            ip = file.getLabelRef(label);
        }
        return null;
    }

    private ErlList string_to_list(String str) {
        ErlList list = new ErlList();
        for (char c : str.toCharArray()) {
            list.add(new ErlInt((int) c));
        }
        return list;
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

    private void save() {
        reg_stack.push(y_reg.clone());
    }

    private void restore() {
        y_reg = reg_stack.pop();
    }

    private void jump(ErlTerm label) {
        ip = file.getLabelRef(((ErlLabel) label).getValue());
    }
}

class Register {
    ArrayList<ErlTerm> slots;
    int maxindex = -1;

    public Register() {
        slots = new ArrayList<ErlTerm>();
    }

    public Register clone() {
        Register reg = new Register();
        for (int i = 0; i < size(); i++) {
            reg.set(i, get(i));
        }
        return reg;
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
        System.out.print("    reg(" + slots.size() + "):");
        for (int i = 0; i < slots.size(); i++) {
            System.out.print("\t" + slots.get(i));
        }
        System.out.println();
    }

    public int size() {
        return slots.size();
    }
}

class Stack<T> {
    ArrayList<T> items;
    public Stack() {
        items = new ArrayList<T>();
    }

    public void push(T item) {
        items.add(item);
    }

    public T pop() {
        int index = items.size() - 1;
        T item = items.get(index);
        items.remove(index);
        return item;
    }

    public boolean isEmpty() {
        return items.size() == 0;
    }

    public int size() {
        return items.size();
    }
}
