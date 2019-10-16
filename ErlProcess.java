import java.util.ArrayList;

public class ErlProcess {
    private BeamVM vm;
    private Register x_reg;
    private Register fp_reg;
    private boolean ferror = false;
    private int ip;
    private CP cp;
    private BeamFile file;
    private Stack<ErlTerm> stack;
    private Stack<BeamFile> module_stack;
    private Stack<TryCatch> try_catch_stack;
    private Stack<ErlBinary> binary_stack;
    private Import mfa;
    private ErlPid pid;
    public static enum State {RUNNING, RUNNABLE, WAITING}
    private State state = State.WAITING;
    private final long reduction_max = 1000;
    private long reduction;
    private ErlTerm result = null;
    private MessageQueue mq;
    private boolean timeout = false;
    private ErlBinary binary = null;
    private ErlRegister put_tuple_dest = null;
    private BeamClient client = null;

    public ErlProcess(BeamVM bv, ErlPid p, BeamClient c) {
        vm = bv;
	pid = p;
        x_reg = new Register();
        fp_reg = new Register();
        stack = new Stack<ErlTerm>();
        module_stack = new Stack<BeamFile>();
        reduction = reduction_max;
        mq = new MessageQueue();
        try_catch_stack = new Stack<TryCatch>();
        binary_stack = new Stack<ErlBinary>();
        client = c;
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
        state = State.RUNNABLE;
    }

    public void prepare(BeamFile f, ErlFun fun, ErlTerm[] args) {
	file = f;
	int arity = fun.getArity();
	for (int i = 0; i < arity; i++) {
	    x_reg.set(i, args[i]);
	}
	jump(fun.getLabel());
        state = State.RUNNABLE;
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
                } else if (ip == -1) {
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
        stack.dump();
        fp_reg.dump();
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
        case 3: // int_code_end
            return new ErlException(new ErlAtom("unexpected_end_of_file"));
        case 4: // call
            save_ip(ip + 1);
            jump(op.args.get(1));
            return null;
        case 5: // call_last
            stack.dealloc(((ErlInt) op.args.get(2)).getValue());
            jump(op.args.get(1));
            return null;
        case 6: // call_only
            jump(op.args.get(1));
            return null;
        case 7: // call_ext
            // TODO: save module, ip, regs
            save_ip(ip + 1);
            mfa = file.getImport(((ErlInt) op.args.get(1)).getValue());
            return setCallExt(mfa);
        case 8: // call_ext_last
            stack.dealloc(((ErlInt) op.args.get(2)).getValue());
            mfa = file.getImport(((ErlInt) op.args.get(1)).getValue());
            return setCallExt(mfa);
        case 9: // bif0
            Import bif0_mfa = file.getImport(((ErlInt) op.args.get(0)).getValue());
            ErlTerm bif0_result = bif0(bif0_mfa);
            if (bif0_result instanceof ErlException)
                return bif0_result;
            set_reg(op.args.get(1), bif0_result);
            ip++;
            return null;
        case 10: // bif1
            Import bif1_mfa = file.getImport(((ErlInt) op.args.get(1)).getValue());
            ErlTerm bif1_result = bif1(bif1_mfa, getValue(op.args.get(2)));
            if (bif1_result instanceof ErlException) {
                return bif1_result;
            }
            set_reg(op.args.get(3), bif1_result);
            ip++;
            return null;
        case 11: // bif2
            Import bif2_mfa = file.getImport(((ErlInt) op.args.get(1)).getValue());
            ErlTerm bif2_result = bif2(bif2_mfa, getValue(op.args.get(2)), getValue(op.args.get(3)));
            if (bif2_result instanceof ErlException) {
                return bif2_result;
            }
            set_reg(op.args.get(4), bif2_result);
            ip++;
            return null;
        case 12: // allocate
            stack.alloc(((ErlInt) op.args.get(0)).getValue());
            ip++;
            return null;
        case 13: // allocate_heap
            stack.alloc(((ErlInt) op.args.get(0)).getValue());
            ip++;
            return null;
        case 14: // allocate_zero
            stack.alloc(((ErlInt) op.args.get(0)).getValue());
            ip++;
            return null;
        case 15: // allocate_heap_zero
            stack.alloc(((ErlInt) op.args.get(0)).getValue());
            ip++;
            return null;
        case 16: ip++; return null; // skip test_heap
        case 17: // init
            set_reg(op.args.get(0), null);
            ip++;
            return null;
        case 18: // deallocate
            stack.dealloc(((ErlInt) op.args.get(0)).getValue());
            ip++;
            return null;
        case 19: // return
            restore_ip();
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
            ErlTerm loop_rec_msg = mq.getNext();
            if (loop_rec_msg != null) {
                x_reg.set(0, loop_rec_msg);
                ip++;
            } else {
                jump((ErlLabel) op.args.get(0));
            }
            return null;
        case 24: // loop_rec_end
            mq.setNext();
            jump((ErlLabel) op.args.get(0));
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
            // 27..38 deprecated
        case 39: // is_lt
            if (ErlBif.compare(getValue(op.args.get(1)), getValue(op.args.get(2))) < 0) {
                ip++;
                return null;
            }
            jump((ErlLabel) op.args.get(0));
            return null;
        case 40: // is_ge
            if (ErlBif.compare(getValue(op.args.get(1)), getValue(op.args.get(2))) >= 0) {
                ip++;
                return null;
            }
            jump((ErlLabel) op.args.get(0));
            return null;
        case 41: // is_eq
            if (ErlBif.compare(getValue(op.args.get(1)), getValue(op.args.get(2))) == 0) {
                ip++;
                return null;
            }
            jump((ErlLabel) op.args.get(0));
            return null;
        case 42: // is_ne
            if (ErlBif.compare(getValue(op.args.get(1)), getValue(op.args.get(2))) != 0) {
                ip++;
                return null;
            }
            jump((ErlLabel) op.args.get(0));
            return null;
        case 43: // is_eq_exact
            if (getValue(op.args.get(1)).toId().equals(getValue(op.args.get(2)).toId())) {
                ip++;
            } else {
                jump(op.args.get(0));
            }
            return null;
        case 44: // is_ne_exact
            if (!getValue(op.args.get(1)).toId().equals(getValue(op.args.get(2)).toId())) {
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
        case 47: // is_number
            if (getValue(op.args.get(1)) instanceof ErlNumber) ip++;
            else jump(op.args.get(0));
            return null;
        case 48: // is_atom
            if (getValue(op.args.get(1)) instanceof ErlAtom) ip++;
            else jump(op.args.get(0));
            return null;
        case 49: // is_pid
            if (getValue(op.args.get(1)) instanceof ErlPid) ip++;
            else jump(op.args.get(0));
            return null;
        case 50: // is_reference
            if (getValue(op.args.get(1)) instanceof ErlReference) ip++;
            else jump(op.args.get(0));
            return null;
        case 51: // is_port
            if (getValue(op.args.get(1)) instanceof ErlPort) ip++;
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
        case 53: // is_binary
	    ErlTerm ib_bin = getValue(op.args.get(1));
            if (ib_bin instanceof ErlBinary) {
		if (((ErlBinary) ib_bin).getPosition() == 0) {
		    ip++;
		    return null;
		}
	    }
            jump(op.args.get(0));
            return null;
            // 54 deprecated
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
        case 60: // select_tuple_arity
            ErlTuple sta_tuple = (ErlTuple) getValue(op.args.get(0));
            ErlList sta_dest = (ErlList) op.args.get(2);
            System.out.println("select_tuple_arity " + sta_tuple + " " + sta_dest); // TODO: remove after testing
            for (int i = 0; !sta_dest.isNil(); i++) {
                if (i == sta_tuple.size()) {
                    jump(sta_dest.head);
                    return null;
                }
                sta_dest = (ErlList) sta_dest.tail;
            }
            jump((ErlLabel) op.args.get(1));
            return null;
        case 61: // jump
            jump((ErlLabel) op.args.get(0));
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
        case 67: // set_tuple_element
            ErlTuple ste_tuple = (ErlTuple) getValue(op.args.get(1));
            ste_tuple.setElement(((ErlInt) op.args.get(2)).getValue() - 1, getValue(op.args.get(0)));
            System.out.println("set_tuple_element " + getValue(op.args.get(0)) + " " + ste_tuple + " " + op.args.get(2)); // TODO: remove after testing
            ip++;
            return null;
            // 68 deprecated
        case 69: // put_list
            ErlTerm head = getValue(op.args.get(0));
            ErlTerm tail = getValue(op.args.get(1));
            ErlList list = new ErlList(head, tail);
            set_reg(op.args.get(2), list);
            ip++;
            return null;
        case 70: // put_tuple
            // arg0 (size) is not used, tuple is dynamic
            System.out.println("put_tuple " + (ErlInt) op.args.get(0) + " " + op.args.get(1)); // TODO: remove after testing
            put_tuple_dest = (ErlRegister) op.args.get(1);
            set_reg(put_tuple_dest, new ErlTuple());
            ip++;
            return null;
        case 71: // put
            System.out.println("put " + getValue(op.args.get(0))); // TODO: remove after testing
            ((ErlTuple) getValue(put_tuple_dest)).add(getValue(op.args.get(0)));
            ip++;
            return null;
        case 72: // badmatch
            System.out.println("badmatch " + op.args.get(0)); // TODO: remove after testing
            return new ErlException(new ErlAtom("badmatch"));
        case 73: // if_end
            System.out.println("if_end"); // TODO: remove after testing
            return new ErlException(new ErlAtom("if_clause"));
        case 74: // case_end
            System.out.println("case_end " + getValue(op.args.get(0))); // TODO: remove after testing
            return new ErlException(new ErlAtom("case_clause"));
        case 75: // call_fun
            int fun_arity = ((ErlInt) op.args.get(0)).getValue();
            ErlFun fun = (ErlFun) x_reg.get(fun_arity);
            save_ip(ip + 1);
            file = fun.getModule();
            jump(fun.getLabel());
            return null;
            // 76 deprecated
        case 77: // is_function
            System.out.println("is_function " + op.args.get(0) + " " + op.args.get(1)); // TODO: remove after testing
            if (getValue(op.args.get(1)) instanceof ErlFun) ip++;
            else jump(op.args.get(0));
            return null;
        case 78: // call_ext_only
            mfa = file.getImport(((ErlInt) op.args.get(1)).getValue());
            return setCallExt(mfa);
            // 79..88 deprecated
	case 89: // bs_put_integer
	    ErlTerm bs_put_value = getValue(op.args.get(4));
            int bs_put_int_length = ((ErlInt) getValue(op.args.get(1))).getValue(); // bit size
	    if (bs_put_value instanceof ErlInt) {
		binary.putInteger(((ErlInt) bs_put_value).getValue(), bs_put_int_length);
		ip++;
	    } else {
		jump(op.args.get(0)); // error
	    }
	    return null;
	case 90: // bs_put_binary
	    // TODO: what is field_flag: all?
	    ErlTerm put_bin = getValue(op.args.get(4));
	    if (put_bin instanceof ErlBinary) {
		ErlBinary put_bin2 = (ErlBinary) put_bin;
		for (int i = 0; i < put_bin2.size(); i++) {
		    binary.add(put_bin2.get(i));
		}
		ip++;
		return null;
	    }
	    jump((ErlLabel) op.args.get(0));
	    return null;
        case 91: // bs_put_float
            ErlTerm bspf_float = getValue(op.args.get(4));
            if (bspf_float instanceof ErlFloat) {
                String floatstr = ((ErlFloat) bspf_float).toString();
                for (int i = 0; i < floatstr.length(); i++)
                    binary.add((int) floatstr.charAt(i));
            }
            jump((ErlLabel) op.args.get(0));
            return null;
	case 92: // bs_put_string
	    int bs_put_index = ((ErlInt) op.args.get(1)).getValue();
	    int bs_put_length = ((ErlInt) op.args.get(0)).getValue();
	    for (int i = bs_put_index; i < bs_put_index + bs_put_length; i++)
		binary.add(file.getStrByte(i));
	    ip++;
	    return null;
            // 93 deprecated
        case 94: // fclearerror
            ferror = false;
            ip++;
            return null;
        case 95: // fcheckerror
            if (ferror) {
                jump((ErlLabel) op.args.get(0));
                return null;
            }
            ip++;
            return null;
        case 96: // fmove
            set_reg((ErlRegister) op.args.get(1), getValue(op.args.get(0)));
            ip++;
            return null;
        case 97: // fconv
            set_reg((ErlRegister) op.args.get(1), new ErlFloat(getValue(op.args.get(0))));
            ip++;
            return null;
        case 98: // fadd
            ErlFloat faddresult = ErlBif.fadd(getValue(op.args.get(1)), getValue(op.args.get(2)));
            System.out.println("fadd result: " + faddresult); // TODO: remove after testing
            if (faddresult == null) {
                ferror = true;
                ip++;
                return null;
            }
            set_reg(op.args.get(3), faddresult);
            ip++;
            return null;
        case 99: // fsub
            ErlFloat fsubresult = ErlBif.fsub(getValue(op.args.get(1)), getValue(op.args.get(2)));
            System.out.println("fsub result: " + fsubresult); // TODO: remove after testing
            if (fsubresult == null) {
                ferror = true;
                ip++;
                return null;
            }
            set_reg(op.args.get(3), fsubresult);
            ip++;
            return null;
        case 100: // fmul
            ErlFloat fmulresult = ErlBif.fmul(getValue(op.args.get(1)), getValue(op.args.get(2)));
            System.out.println("fmul result: " + fmulresult); // TODO: remove after testing
            if (fmulresult == null) {
                ferror = true;
                ip++;
                return null;
            }
            set_reg(op.args.get(3), fmulresult);
            ip++;
            return null;
        case 101: // fdiv
            ErlFloat fdivresult = ErlBif.fdiv(getValue(op.args.get(1)), getValue(op.args.get(2)));
            if (fdivresult == null) {
                ferror = true;
                ip++;
                return null;
            }
            set_reg(op.args.get(3), fdivresult);
            ip++;
            return null;
        case 102: // fnegate
            System.out.println("fnegate: " + op.args.get(0) + " " + op.args.get(1) + " " + op.args.get(2)); // TODO: remove after testing
            ErlFloat fnegateresult = ErlBif.fnegate(getValue(op.args.get(1)));
            if (fnegateresult == null) {
                ferror = true;
                ip++;
                return null;
            }
            set_reg(op.args.get(2), fnegateresult);
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
        case 107: // try_case_end
            System.out.println("try_case_end " + getValue(op.args.get(0))); // TODO: remove after testing
            return new ErlException(new ErlAtom("try_case_clause"));
        case 108: // raise
            System.out.println("raise " + getValue(op.args.get(0)) + " " + getValue(op.args.get(1))); // TODO: remove after testing
            ErlTuple raise = new ErlTuple();
            raise.add(getValue(op.args.get(1)));
            raise.add(getValue(op.args.get(0)));
            return new ErlException(raise);
        case 112: // apply
            return apply(((ErlInt) op.args.get(0)).getValue(), false);
        case 113: // apply_last
            stack.dealloc(((ErlInt) op.args.get(1)).getValue());
            return apply(((ErlInt) op.args.get(0)).getValue(), true);
	case 109: // bs_init2
	    binary = new ErlBinary();
	    set_reg((ErlRegister) op.args.get(5), binary); // target register
	    ip++;
	    return null;
            // 110 deprecated
        case 114: // is_boolean
            ErlTerm boolterm = getValue(op.args.get(1));
            if (boolterm instanceof ErlAtom) {
                if (((ErlAtom) boolterm).getValue().equals("true") || ((ErlAtom) boolterm).getValue().equals("false")) {
                    ip++;
                    return null;
                }
            }
            jump(op.args.get(0));
            return null;
        case 115: // is_function2
            System.out.println("is_function2 " + op.args.get(0) + " " + op.args.get(1) + " " + op.args.get(2)); // TODO: remove after testing
            ErlTerm isf2_fun = getValue(op.args.get(1));
            if (isf2_fun instanceof ErlFun) {
                if (((ErlFun) isf2_fun).getArity() == ((ErlInt) op.args.get(2)).getValue()) {
                    ip++;
                    return null;
                }
            }
            jump(op.args.get(0));
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
        case 122: // bs_save2
            System.out.println("bs_save2 " + op.args.get(0) + " " + op.args.get(1)); // TODO: remove after testing
            binary_stack.push(binary);
            ip++;
            return null;
        case 123: // bs_restore2
            System.out.println("bs_restore2 " + op.args.get(0) + " " + op.args.get(1)); // TODO: remove after testing
            binary = binary_stack.pop();
            ip++;
            return null;
	case 124: // gc_bif1
            Import gc_bif1_mfa = file.getImport(((ErlInt) op.args.get(2)).getValue());
            ErlTerm gc_bif1_result = bif1(gc_bif1_mfa, getValue(op.args.get(3)));
            if (gc_bif1_result instanceof ErlException) {
                return gc_bif1_result;
            }
            set_reg(op.args.get(4), gc_bif1_result);
            ip++;
            return null;
        case 125: // gc_bif2
            Import gc_bif2_mfa = file.getImport(((ErlInt) op.args.get(2)).getValue());
            ErlTerm gc_bif2_result = bif2(gc_bif2_mfa, getValue(op.args.get(3)), getValue(op.args.get(4)));
            if (gc_bif2_result instanceof ErlException) {
                return gc_bif2_result;
            }
            set_reg(op.args.get(5), gc_bif2_result);
            ip++;
            return null;
            // 126..128 deprecated
        case 129: // is_bitstr
	    if (getValue(op.args.get(1)) instanceof ErlBinary) {
		ip++;
		return null;
	    }
            jump(op.args.get(0));
            return null;
	case 131: // bs_test_unit
	    if (((ErlBinary) getValue(op.args.get(1))).first != 0) {
		jump((ErlLabel) op.args.get(0));
		return null;
	    }
	    ip++;
	    return null;
	case 134: // bs_append
	    binary = (ErlBinary) getValue(op.args.get(5));
	    set_reg((ErlRegister) op.args.get(7), binary);
	    // TODO: append different registers
	    ip++;
	    return null;
        case 136: // trim
            stack.trim(((ErlInt) op.args.get(0)).getValue());
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
        case 162: // get_hd
            ErlTerm get_hd = ((ErlList) getValue(op.args.get(0))).head;
            set_reg(op.args.get(1), get_hd);
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
	    ((ErlBinary) getValue(op.args.get(0))).first = ((ErlInt) getValue(op.args.get(1))).getValue();
	    ip++;
	    return null;
        default: System.out.println("UNKNOWN op: " + op.opcode + " (" + OpCode.name(op.opcode) + ")");
        }
        ip++; return null;
    }

    public void timeout() {
        timeout = true;
    }

    private ErlTerm bif1(Import mfa, ErlTerm arg) {
        String mod = file.getAtomName(mfa.getModule());
        String function = file.getAtomName(mfa.getFunction());
        if (mod.equals("erlang")) {
	    // if ... special functions
	    return ErlBif.op(function, arg);
        }
	System.out.println(function + " " + arg);
        return new ErlException(new ErlAtom("badarg"));
    }

    private ErlTerm bif2(Import mfa, ErlTerm arg1, ErlTerm arg2) {
        String mod = file.getAtomName(mfa.getModule());
        String function = file.getAtomName(mfa.getFunction());
        if (mod.equals("erlang")) {
	    // if ... special functions
	    return ErlBif.op(function, arg1, arg2);
        }
	System.out.println(function + " " + arg1 + " " + arg2);
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
            stack.set(register.getIndex(), value);
        } else if (register.getType().equals("FP")) {
            fp_reg.set(register.getIndex(), value);
        }
    }

    public ErlTerm setCallExt(Import mfa) {
        String mod = file.getAtomName(mfa.getModule());
        String function = file.getAtomName(mfa.getFunction());
        int arity = mfa.getArity();
        System.out.println("CALL_EXT: " + mod + " " + function + " " + arity);
        if (mod.equals("erlang")) { // replace operators with external calls
            if (function.equals("++")) {
                mod = "lists";
                function = "append";
            }
        }
        if (mod.equals("erlang")) {
            restore_ip(); // BIF, remove CP as not real external call
            if (function.equals("get_module_info")) {
                return new ErlString("module_info(" + x_reg.get(0).toString() + ")");
            } else if (function.equals("spawn")) {
		ErlProcess p = vm.newProcess(null);
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
                return new ErlException(x_reg.get(0));
            }
            x_reg.set(0, new ErlAtom("error"));
            return new ErlException(new ErlAtom("undef"));
        } else if (mod.equals("beamclient")) {
            restore_ip();
            client.handleCall(function, x_reg.get(0));
            return new ErlAtom("ok");
        } else {
            file = vm.getModule(mod).file;
            int label = file.getLabel(function, arity);
            ip = file.getLabelRef(label);
        }
        return null;
    }

    private ErlTerm apply(int arity, boolean last) {
        String mod = ((ErlAtom) x_reg.get(arity)).getValue();
        String function = ((ErlAtom) x_reg.get(arity + 1)).getValue();
        if (!last) save_ip(ip + 1);
        file = vm.getModule(mod).file;
        int label = file.getLabel(function, arity);
        ip = file.getLabelRef(label);
        return null; // TODO: check BIFs
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
                value = stack.get(reg.getIndex());
            } else if (reg.getType().equals("FP")) {
                value = fp_reg.get(reg.getIndex());
            }
        } else {
            value = source;
        }
        if (value instanceof ErlLiteral) {
            value = ((ErlLiteral) value).getValue();
        }
        return value;
    }

    private void save_ip(int cp) {
        stack.push(new CP(cp, file));
        System.out.println("push " + cp + " size " + stack.size());
    }

    private void restore_ip() {
        if (stack.isEmpty()) {
            ip = -1;
        } else {
            ErlTerm top = stack.get(0);
            if (top instanceof CP) {
                CP cp = (CP) stack.pop();
                ip = cp.value;
                file = cp.file;
                System.out.println("pop " + ip + " size " + stack.size());
            } else { // try block, reserved slot for error
                ip = -1;
            }
        }
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
    public BeamClient getClient() { return client; }
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
        BeamDebug.print("    reg(" + slots.size() + "):");
        for (int i = 0; i < slots.size(); i++) {
            BeamDebug.print("\t" + slots.get(i));
        }
        BeamDebug.println();
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
        items.add(0, item);
    }

    public T pop() {
        T item = items.get(0);
        items.remove(0);
        return item;
    }

    public void set(int index, T value) {
        items.set(index, value);
    }

    public T get() {
        return items.get(items.size() - 1);
    }

    public T get(int index) {
        return items.get(index);
    }

    public boolean isEmpty() {
        return items.size() == 0;
    }

    public int size() {
        return items.size();
    }

    public void alloc(int size) {
        for (int i = 0; i < size; i++)
            push(null);
    }

    public void dealloc(int size) {
        for (int i = 0; i < size; i++)
            pop();
    }

    public void trim(int n) {
        for (int i = 0; i < n; i++) {
            items.remove(0);
        }
    }

    public void dump() {
        BeamDebug.print("    stack(" + items.size() + "):");
        for (int i = 0; i < items.size(); i++) {
            BeamDebug.print("\t" + items.get(i));
        }
        BeamDebug.println();
    }
}

class MessageQueue {
    ArrayList<ErlTerm> messages;
    int current = 0;

    public MessageQueue() {
        messages = new ArrayList<ErlTerm>();
    }

    public void put(ErlTerm message) {
        messages.add(message);
    }

    public ErlTerm getNext() {
        if (size() > 0) {
            ErlTerm message = messages.get(current++);
            if (current >= size()) current = 0;
            return message;
        }
        return null;
    }

    public void setNext() {
        current++;
        if (current >= size()) current = 0;
    }

    public void remove() {
        messages.remove(current);
        current = 0;
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

class CP extends ErlTerm {
    int value;
    BeamFile file;
    public CP(int v, BeamFile f) {
        super("CP", 0);
        value = v;
        file = f;
    }
    public String toString() { return "CP(" + Integer.toString(value) + ")"; }
    public String toId() { return toString(); }
}
