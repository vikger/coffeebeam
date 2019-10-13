public class ErlBif {
    public static ErlTerm op(String op, ErlTerm arg1, ErlTerm arg2) {
	if (op.equals("+"))
	    return add(arg1, arg2);
	else if (op.equals("-"))
	    return subtract(arg1, arg2);
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
		return new ErlInt(((ErlInt) a).getValue() + ((ErlInt) b).getValue());
	    }
	}
	return new ErlException(new ErlAtom("badarith"));
    }

    public static ErlTerm subtract(ErlTerm a, ErlTerm b) {
	if (a instanceof ErlInt) {
	    if (b instanceof ErlInt) {
		return new ErlInt(((ErlInt) a).getValue() - ((ErlInt) b).getValue());
	    }
	}
	return new ErlException(new ErlAtom("badarith"));
    }
}
