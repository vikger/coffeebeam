import java.util.ArrayList;

public class ErlProcess {
    private BeamVM vm;
    private Register x_reg;
    private Register y_reg;
    private int ip;
    private BeamFile file;
    private Stack<Integer> ip_stack;
    private Stack<Register> reg_stack;
    private Stack<BeamFile> module_stack;
    private Stack<TryCatch> try_catch_stack;
    private Import mfa;
    private ErlPid pid;
    public static enum State {RUNNING, RUNNABLE, WAITING}
    private State state = State.RUNNABLE;
    private final long reduction_max = 1000;
    private long reduction;
    private ErlTerm result = null;
    private MessageQueue mq;
    private boolean timeout = false;
    private ErlBinary binary = null;
    private ErlBinary match_binary = null;
    private int match_position;

    public ErlProcess(BeamVM bv, ErlPid p) {
        vm = bv;
	pid = p;
        x_reg = new Register();
        y_reg = new Register();
        ip_stack = new Stack<Integer>();
        reg_stack = new Stack<Register>();
        module_stack = new Stack<BeamFile>();
        reduction = reduction_max;
        mq = new MessageQueue();
        try_catch_stack = new Stack<TryCatch>();
    }

    public void prepare(String module, String function, ErlTerm[] args) {
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
    }

    public void prepare(BeamFile f, ErlFun fun, ErlTerm[] args) {
	file = f;
	int arity = fun.getArity();
	for (int i = 0; i < arity; i++) {
	    x_reg.set(i, args[i]);
	}
	jump(fun.getLabel());
    }

    public ErlTerm run() {
	state = State.RUNNING;

        while (reduction > 0 && state == State.RUNNING) {
            reduction--;
            if (result == null) {
                if (ip == -1) {
                    if (!try_catch_stack.isEmpty()) {
                        TryCatch tc = try_catch_stack.pop();
                        set_reg(tc.register, new ErlAtom("badarg"));
                        if (tc.type.equals("try"))
                            x_reg.set(0, new ErlAtom("error")); // TODO: needed?
                        jump(tc.label);
                    } else
                        return new ErlException(new ErlAtom("badarg"));
                }
            } else {
                if (result instanceof ErlException) {
                    if (!try_catch_stack.isEmpty()) {
                        TryCatch tc = try_catch_stack.pop();
                        set_reg(tc.register, ((ErlException) result).getValue());
                        jump(tc.label);
                    } else
                        return result;
                } else if (!ip_stack.isEmpty()) {
                    restore_ip(); // TODO: check if only occurs on return
                } else {
                    return result;
                }
            }
            ErlOp op = file.getOp(ip);
            result = execute(op);
        }
        if (state == State.RUNNING) {
            state = State.RUNNABLE;
            reduction = reduction_max;
            return null;
        }
	return null;
    }

    public ErlTerm execute(ErlOp op) {
        System.out.print("  ip(" + ip + ")\t" + OpCode.name(op.opcode) + "(" + op.opcode + ")");
        for (int i = 0; i < OpCode.arity(op.opcode); i++) System.out.print("\t" + op.args.get(i).toString());
        System.out.println();
        x_reg.dump();
        y_reg.dump();
        switch (op.opcode) {
        case 1: ip++; return null; // skip label
        case 2: // func_info
            ErlTuple func = new ErlTuple();
            func.add(op.args.get(0));
            func.add(op.args.get(1));
            ErlList arglist = new ErlList();
            int argc = ((ErlInt) op.args.get(2)).getValue();
            for (int i = 0; i < argc; i++) {
                arglist.add(x_reg.get(i));
            }
            func.add(arglist);
            ErlTuple func_info = new ErlTuple();
            func_info.add(new ErlAtom("function_clause"));
            func_info.add(func);
            return new ErlException(func_info);
        case 4: // call
            save_ip(ip + 1);
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
            save_ip(ip + 1);
            mfa = file.getImport(((ErlInt) op.args.get(1)).getValue());
            return setCallExt(mfa, false);
        case 8: // call_ext_last
            mfa = file.getImport(((ErlInt) op.args.get(1)).getValue());
            return setCallExt(mfa, true);
        case 9: // bif0
            Import bif0_mfa = file.getImport(((ErlInt) op.args.get(0)).getValue());
            ErlTerm bif0_result = bif0(bif0_mfa);
            if (bif0_result instanceof ErlException)
                return bif0_result;
            set_reg(op.args.get(1), bif0_result);
            ip++;
            return null;
        case 12: ip++; return null; // skip allocate
        case 13: ip++; return null; // skip allocate_heap
        case 14: // allocate_zero
            int zeros = ((ErlInt) op.args.get(0)).getValue();
            for (int i = 0; i < zeros; i++)
                y_reg.set(i, null);
            ip++;
            return null;
        case 16: ip++; return null; // skip test_heap
        case 18: ip++; return null; // skip deallocate
        case 19: // return
            if (!reg_stack.isEmpty()) restore();
            System.out.println("return: " + x_reg.get(0));
            return x_reg.get(0);
        case 20: // send
            ErlTerm message = getValue(x_reg.get(1));
            vm.send((ErlPid) x_reg.get(0), message);
            x_reg.set(0, message);
            ip++;
            return null;
        case 21: // remove_message
            mq.remove();
            ip++;
            return null;
        case 22: // timeout
            ip++;
            return null;
        case 23: // loop_rec
            if (mq.size() > 0) {
                x_reg.set(0, mq.getNext());
                ip++;
            } else {
                jump((ErlLabel) op.args.get(0));
            }
            return null;
        case 25: // wait
            if (mq.size() == 0) {
                state = State.WAITING;
                jump((ErlLabel) op.args.get(0));
            } else {
                ip++;
            }
            return null;
        case 26: // wait_timeout
            if (timeout) {
                timeout = false;
                ip++;
                return null;
            }
            state = State.WAITING;
            vm.setTimeout(pid, ((ErlInt) op.args.get(1)).getValue());
            jump((ErlLabel) op.args.get(0));
            return null;
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
        case 57: // is_tuple
            if (getValue(op.args.get(1)) instanceof ErlTuple) ip++;
            else jump(op.args.get(0));
            return null;
        case 58: // test_arity
            if (((ErlTuple) getValue(op.args.get(1))).size() == ((ErlInt) getValue(op.args.get(2))).getValue()) ip++;
            else jump(op.args.get(0));
            return null;
        case 59: // select_val
            ErlTerm select_match = getValue(op.args.get(0));
            ErlList dest = (ErlList) op.args.get(2);
            while (!dest.isNil()) {
                ErlTerm dest_match = dest.head;
                ErlList dest_tail = (ErlList) dest.tail;
                ErlLabel dest_value = (ErlLabel) dest_tail.head;
                if (dest_match.toId().equals(select_match.toId())) {
                    jump(dest_value);
                    return null;
                }
                dest = (ErlList) dest_tail.tail;
            }
            jump(op.args.get(1));
            return null;
        case 62: // catch
            try_catch_stack.push(new TryCatch("catch", (ErlLabel) op.args.get(1), (ErlRegister) op.args.get(0)));
            set_reg((ErlRegister) op.args.get(0), null);
            ip++;
            return null;
        case 63: // catch_end
            if (getValue(op.args.get(0)) != null)
                x_reg.set(0, getValue(op.args.get(0)));
            ip++;
            return null;
        case 64: // move
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
        case 66: // get_tuple_element
            set_reg(op.args.get(2), ((ErlTuple) getValue(op.args.get(0))).get(((ErlInt) op.args.get(1)).getValue()));
            ip++;
            return null;
        case 69: // put_list
            ErlTerm head = getValue(op.args.get(0));
            ErlTerm tail = getValue(op.args.get(1));
            ErlList list = new ErlList(head, tail);
            set_reg(op.args.get(2), list);
            ip++;
            return null;
        case 75: // call_fun
            int fun_arity = ((ErlInt) op.args.get(0)).getValue();
            ErlFun fun = (ErlFun) x_reg.get(fun_arity);
            save();
            save_ip(ip + 1);
            file = fun.getModule();
            jump(fun.getLabel());
            return null;
        case 78: // call_ext_only
            mfa = file.getImport(((ErlInt) op.args.get(1)).getValue());
            return setCallExt(mfa, true);
	case 89: // bs_put_integer
	    ErlTerm bs_put_value = getValue(op.args.get(4));
	    if (bs_put_value instanceof ErlInt) {
		binary.add(((ErlInt) bs_put_value).getValue());
		ip++;
	    } else {
		jump(op.args.get(0)); // error
	    }
	    return null;
	case 92: // bs_put_string
	    int bs_put_index = ((ErlInt) op.args.get(1)).getValue();
	    int bs_put_length = ((ErlInt) op.args.get(0)).getValue();
	    for (int i = bs_put_index; i < bs_put_index + bs_put_length; i++)
		binary.add(file.getStrByte(i));
	    ip++;
	    return null;
        case 103: // make_fun2
            x_reg.set(0, file.getLocalFunction(((ErlInt) op.args.get(0)).getValue()));
            ip++;
            return null;
        case 104: // try
            try_catch_stack.push(new TryCatch("try", (ErlLabel) op.args.get(1), (ErlRegister) op.args.get(0)));
            ip++;
            return null;
        case 105: // try_end
            try_catch_stack.pop();
            ip++;
            return null;
        case 106: // try_case
            x_reg.set(1, getValue(op.args.get(0)));
            ip++;
            return null;
	case 109: // bs_init2
	    binary = new ErlBinary();
	    set_reg((ErlRegister) op.args.get(5), binary); // target register
	    ip++;
	    return null;
	case 117: // bs_get_integer2
	    ErlBinary getintbin = (ErlBinary) getValue(op.args.get(1));
	    int getintlength = ((ErlInt) op.args.get(3)).getValue();
	    if (getintbin.bitSize() >= getintlength) {
		int getintvalue = getintbin.getInteger(getintlength);
		set_reg((ErlRegister) op.args.get(6), new ErlInt(getintvalue));
		ip++;
		return null;
	    }
	    jump((ErlLabel) op.args.get(0));
	    return null;
	case 121: // bs_test_tail2
	    if (((ErlBinary) getValue(op.args.get(1))).bitSize() == ((ErlInt) op.args.get(2)).getValue()) {
		ip++;
		return null;
	    }
	    jump((ErlLabel) op.args.get(0));
	    return null;
        case 125: // gc_bif2
            Import bif2_mfa = file.getImport(((ErlInt) op.args.get(2)).getValue());
            ErlTerm bif2_result = gc_bif2(bif2_mfa, getValue(op.args.get(3)), getValue(op.args.get(4)));
            if (bif2_result instanceof ErlException) {
                return bif2_result;
            }
            set_reg(op.args.get(5), bif2_result);
            ip++;
            return null;
	case 131: // bs_test_unit
	    if (((ErlBinary) getValue(op.args.get(1))).position != 0) {
		jump((ErlLabel) op.args.get(0));
		return null;
	    }
	    ip++;
	    return null;
        case 136: // trim
            y_reg.trim(((ErlInt) op.args.get(0)).getValue());
            ip++;
            return null;
        case 153: ip++; return null; // skip line
        case 154: // put_map_assoc
            ErlTerm mapbase = getValue(op.args.get(1));
            ErlMap map;
            if (mapbase instanceof ErlLiteral) map = (ErlMap) ((ErlLiteral) mapbase).getValue();
            else map = (ErlMap) mapbase;
            ErlList maplist = (ErlList) op.args.get(4);
            while (!maplist.isNil()) {
                ErlTerm mapkey = getValue(maplist.head);
                maplist = (ErlList) maplist.tail;
                ErlTerm mapvalue = getValue(maplist.head);
                map.add(mapkey, mapvalue);
                maplist = (ErlList) maplist.tail;
            }
            set_reg(op.args.get(2), map);
            ip++;
            return null;
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
	case 166: // bs_start_match3
	    ErlTerm matchbin = getValue(op.args.get(1));
	    if (matchbin instanceof ErlBinary) {
		ErlBinary bin = (ErlBinary) matchbin;
		set_reg(op.args.get(3), matchbin); // TODO: clone, startMatch, set startpos
		ip++;
	    } else {
		jump(op.args.get(0));
	    }
	    return null;
	case 167: // bs_get_position
	    ErlBinary bin = (ErlBinary) getValue(op.args.get(0));
	    set_reg(op.args.get(1), new ErlInt(bin.getPosition()));
	    ip++;
	    return null;
	case 168: // bs_set_position
	    ((ErlBinary) getValue(op.args.get(0))).position = ((ErlInt) getValue(op.args.get(1))).getValue();
	    ip++;
	    return null;
        default: System.out.println("UNKNOWN op: " + op.opcode + " (" + OpCode.name(op.opcode) + ")");
        }
        ip++; return null;
    }

    public void timeout() {
        timeout = true;
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
        return new ErlException(new ErlAtom("badarg"));
    }

    private ErlTerm bif0(Import mfa) {
        String mod = file.getAtomName(mfa.getModule());
        String function = file.getAtomName(mfa.getFunction());
        if (mod.equals("erlang")) {
            if (function.equals("self")) {
                return getPid();
            }
        }
        return new ErlException(new ErlAtom("badarg"));
    }

    private void set_reg(ErlTerm reg, ErlTerm value) {
        ErlRegister register = (ErlRegister) reg;
        if (register.getType().equals("X")) {
            x_reg.set(register.getIndex(), value);
        } else if (register.getType().equals("Y")) {
            y_reg.set(register.getIndex(), value);
        }
    }

    public ErlTerm setCallExt(Import mfa, boolean last) {
        String mod = file.getAtomName(mfa.getModule());
        String function = file.getAtomName(mfa.getFunction());
        int arity = mfa.getArity();
        System.out.println("CALL_EXT: " + mod + " " + function + " " + arity);
        if (mod.equals("erlang")) {
            if (function.equals("get_module_info")) {
                return new ErlString("module_info(" + x_reg.get(0).toString() + ")");
            } else if (function.equals("spawn")) {
		ErlProcess p = vm.getScheduler().newProcess();
		// TODO: check argument input (start / end)
		int spawnarity = ((ErlFun) x_reg.get(0)).getArity();
		ErlTerm[] spawnargs = new ErlTerm[spawnarity];
		for (int i = 0; i < spawnarity; i++)
		    spawnargs[i] = x_reg.get(i);
		p.prepare(file, ((ErlFun) x_reg.get(spawnarity)), spawnargs);
		x_reg.set(0, p.getPid());
		return p.getPid();
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
            } else if (function.equals("setelement")) {
                int setindex = ((ErlInt) x_reg.get(0)).getValue() - 1; // tuple indexing starts with 1
                ErlTuple oldtuple = (ErlTuple) x_reg.get(1);
                ErlTuple newtuple = new ErlTuple();
                for (int i = 0; i < oldtuple.size(); i++) {
                    if (i == setindex)
                        newtuple.add(x_reg.get(2));
                    else
                        newtuple.add(oldtuple.getElement(i));
                }
                x_reg.set(0, newtuple);
                return newtuple;
            } else if (function.equals("throw")) {
                if (!last) { ip_stack.pop(); module_stack.pop(); }
                return new ErlException(x_reg.get(0));
            }
            x_reg.set(0, new ErlAtom("error"));
            if (!last) { ip_stack.pop(); module_stack.pop(); }
            return new ErlException(new ErlAtom("undef"));
        } else {
            if (!last) { save(); save_ip(ip + 1); }
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

    private ErlTerm getValue(ErlTerm source) {
        ErlTerm value = null;
        if (source instanceof ErlRegister) {
            ErlRegister reg = (ErlRegister) source;
            if (reg.getType().equals("X")) {
                value = x_reg.get(reg.getIndex());
            } else if (reg.getType().equals("Y")) {
                value = y_reg.get(reg.getIndex());
            }
        } else {
            value = source;
        }
        if (value instanceof ErlLiteral) {
            value = ((ErlLiteral) value).getValue();
        }
        return value;
    }

    private void save() {
        reg_stack.push(y_reg.clone()); System.out.println("save: y_reg(" + y_reg.size() + ")");
    }

    private void restore() {
        y_reg = reg_stack.pop(); System.out.println("restore: y_reg(" + y_reg.size() + ")");
    }

    private void save_ip(int cp) {
        ip_stack.push(cp); System.out.println("push: " + file.getModuleName() + " " + cp + " size " + ip_stack.size());
        module_stack.push(file);
    }

    private void restore_ip() {
        ip = ip_stack.pop();
        file = module_stack.pop(); System.out.println("pop: " + file.getModuleName() + " " + ip + " size " + ip_stack.size());
    }

    private void jump(ErlTerm label) {
        ip = file.getLabelRef(((ErlLabel) label).getValue());
    }

    public ErlPid getPid() { return pid; }
    public void setState(State s) { state = s; }
    public State getState() { return state; }

    public void put_message(ErlTerm message) {
        mq.put(message);
        if (state == State.WAITING) {
            state = state.RUNNABLE;
        }
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

    public void trim(int n) {
        for (int i = 0; i < n; i++) {
            slots.remove(0);
            maxindex--;
        }
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

    public T get() {
        return items.get(items.size() - 1);
    }

    public boolean isEmpty() {
        return items.size() == 0;
    }

    public int size() {
        return items.size();
    }
}

class MessageQueue {
    ArrayList<ErlTerm> messages;
    int current;

    public MessageQueue() {
        messages = new ArrayList<ErlTerm>();
    }

    public void put(ErlTerm message) {
        messages.add(message);
    }

    public ErlTerm getNext() {
        ErlTerm message = messages.get(current++);
        if (current >= size()) current = 0;
        return message;
    }

    public void remove() {
        messages.remove(current);
    }

    public void reset() {
        current = 0;
    }

    public int size() {
        return messages.size();
    }
}

class TryCatch {
    String type;
    ErlLabel label;
    ErlRegister register;
    public TryCatch(String t, ErlLabel l, ErlRegister r) {
        type = t;
        label = l;
        register = r;
    }
}
