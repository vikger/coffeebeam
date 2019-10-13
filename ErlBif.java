public class ErlBif {
    public static ErlTerm op(String op, ErlTerm arg) {
	if (op.equals("bnot"))
	    return bnot(arg);
	ErlTuple funtuple = new ErlTuple();
	funtuple.add(new ErlAtom("erlang"));
	funtuple.add(new ErlAtom(op));
	ErlList funarglist = new ErlList();
	funarglist.add(arg);
	funtuple.add(funarglist);
	ErlTuple extuple = new ErlTuple();
	extuple.add(new ErlAtom("undef"));
	extuple.add(funtuple);
	return new ErlException(extuple);
    }

    public static ErlTerm op(String op, ErlTerm arg1, ErlTerm arg2) {
	if (op.equals("+"))
	    return add(arg1, arg2);
	else if (op.equals("-"))
	    return subtract(arg1, arg2);
	else if (op.equals("*"))
	    return mul(arg1, arg2);
	else if (op.equals("div"))
	    return div(arg1, arg2);
	else if (op.equals("rem"))
	    return rem(arg1, arg2);
	else if (op.equals("bsl"))
	    return bsl(arg1, arg2);
	else if (op.equals("bsr"))
	    return bsr(arg1, arg2);
	else if (op.equals("band"))
	    return band(arg1, arg2);
	else if (op.equals("bor"))
	    return bor(arg1, arg2);
	else if (op.equals("bxor"))
	    return bxor(arg1, arg2);
	ErlTuple funtuple = new ErlTuple();
	funtuple.add(new ErlAtom("erlang"));
	funtuple.add(new ErlAtom(op));
	ErlList funarglist = new ErlList();
	funarglist.add(arg1);
	funarglist.add(arg2);
	funtuple.add(funarglist);
	ErlTuple extuple = new ErlTuple();
	extuple.add(new ErlAtom("undef"));
	extuple.add(funtuple);
	return new ErlException(extuple);
    }

    public static ErlTerm add(ErlTerm a, ErlTerm b) {
	if (a instanceof ErlInt) {
	    if (b instanceof ErlInt) {
		return add((ErlInt) a, (ErlInt) b);
	    }
	}
	return new ErlException(new ErlAtom("badarith"));
    }

    private static ErlInt add(ErlInt a, ErlInt b) {
	return new ErlInt(a.getValue() + b.getValue());
    }

    public static ErlTerm subtract(ErlTerm a, ErlTerm b) {
	if (a instanceof ErlInt) {
	    if (b instanceof ErlInt) {
		return subtract((ErlInt) a, (ErlInt) b);
	    }
	}
	return new ErlException(new ErlAtom("badarith"));
    }

    private static ErlInt subtract(ErlInt a, ErlInt b) {
	return new ErlInt(a.getValue() - b.getValue());
    }

    public static ErlTerm mul(ErlTerm a, ErlTerm b) {
	if (a instanceof ErlInt) {
	    if (b instanceof ErlInt) {
		return mul((ErlInt) a, (ErlInt) b);
	    }
	}
	return new ErlException(new ErlAtom("badarith"));
    }

    public static ErlInt mul(ErlInt a, ErlInt b) {
	return new ErlInt(a.getValue() * b.getValue());
    }

    public static ErlTerm div(ErlTerm a, ErlTerm b) {
	if (a instanceof ErlInt) {
	    if (b instanceof ErlInt) {
		return div((ErlInt) a, (ErlInt) b);
	    }
	}
	return new ErlException(new ErlAtom("badarith"));
    }

    public static ErlInt div(ErlInt a, ErlInt b) {
	return new ErlInt(a.getValue() / b.getValue());
    }

    public static ErlTerm rem(ErlTerm a, ErlTerm b) {
	if (a instanceof ErlInt) {
	    if (b instanceof ErlInt) {
		return rem((ErlInt) a, (ErlInt) b);
	    }
	}
	return new ErlException(new ErlAtom("badarith"));
    }

    public static ErlInt rem(ErlInt a, ErlInt b) {
	return new ErlInt(a.getValue() % b.getValue());
    }

    public static ErlTerm bsl(ErlTerm a, ErlTerm b) {
	if (a instanceof ErlInt) {
	    if (b instanceof ErlInt) {
		return bsl((ErlInt) a, (ErlInt) b);
	    }
	}
	return new ErlException(new ErlAtom("badarith"));
    }

    private static ErlInt bsl(ErlInt a, ErlInt b) {
	return new ErlInt(a.getValue() << b.getValue());
    }

    public static ErlTerm bsr(ErlTerm a, ErlTerm b) {
	if (a instanceof ErlInt) {
	    if (b instanceof ErlInt) {
		return bsr((ErlInt) a, (ErlInt) b);
	    }
	}
	return new ErlException(new ErlAtom("badarith"));
    }

    private static ErlInt bsr(ErlInt a, ErlInt b) {
	return new ErlInt(a.getValue() >> b.getValue());
    }

    public static ErlTerm band(ErlTerm a, ErlTerm b) {
	if (a instanceof ErlInt) {
	    if (b instanceof ErlInt) {
		return band((ErlInt) a, (ErlInt) b);
	    }
	}
	return new ErlException(new ErlAtom("badarith"));
    }

    private static ErlInt band(ErlInt a, ErlInt b) {
	return new ErlInt(a.getValue() & b.getValue());
    }

    public static ErlTerm bor(ErlTerm a, ErlTerm b) {
	if (a instanceof ErlInt) {
	    if (b instanceof ErlInt) {
		return bor((ErlInt) a, (ErlInt) b);
	    }
	}
	return new ErlException(new ErlAtom("badarith"));
    }

    private static ErlInt bor(ErlInt a, ErlInt b) {
	return new ErlInt(a.getValue() | b.getValue());
    }

    public static ErlTerm bxor(ErlTerm a, ErlTerm b) {
	if (a instanceof ErlInt) {
	    if (b instanceof ErlInt) {
		return bxor((ErlInt) a, (ErlInt) b);
	    }
	}
	return new ErlException(new ErlAtom("badarith"));
    }

    private static ErlInt bxor(ErlInt a, ErlInt b) {
	return new ErlInt(a.getValue() ^ b.getValue());
    }

    public static ErlTerm bnot(ErlTerm a) {
	if (a instanceof ErlInt) {
	    return bnot((ErlInt) a);
	}
	return new ErlException(new ErlAtom("badarith"));
    }

    private static ErlInt bnot(ErlInt a) {
	return new ErlInt(~(a.getValue()));
    }
}
