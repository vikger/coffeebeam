package coffeebeam.erts;

import coffeebeam.types.*;

public class ErlBif {
    public static ErlTerm op(String op, ErlTerm arg) {
	if (op.equals("bnot"))
	    return bnot(arg);
        else if (op.equals("not"))
            return not(arg);
	else if (op.equals("bit_size"))
	    return bit_size(arg);
	else if (op.equals("byte_size"))
	    return byte_size(arg);
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
        else if (op.equals("=<"))
            return new ErlAtom(compare(arg1, arg2) <= 0);
        else if (op.equals("<"))
            return new ErlAtom(compare(arg1, arg2) < 0);
        else if (op.equals(">="))
            return new ErlAtom(compare(arg1, arg2) >= 0);
        else if (op.equals(">"))
            return new ErlAtom(compare(arg1, arg2) > 0);
        else if (op.equals("and"))
            return and(arg1, arg2);
        else if (op.equals("or"))
            return or(arg1, arg2);
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

    public static ErlFloat fadd(ErlTerm a, ErlTerm b) {
        if (a instanceof ErlFloat && b instanceof ErlFloat)
            return new ErlFloat(((ErlFloat) a).getValue() + ((ErlFloat) b).getValue());
        return null;
    }

    public static ErlFloat fsub(ErlTerm a, ErlTerm b) {
        if (a instanceof ErlFloat && b instanceof ErlFloat)
            return new ErlFloat(((ErlFloat) a).getValue() - ((ErlFloat) b).getValue());
        return null;
    }

    public static ErlFloat fmul(ErlTerm a, ErlTerm b) {
        if (a instanceof ErlFloat && b instanceof ErlFloat)
            return new ErlFloat(((ErlFloat) a).getValue() * ((ErlFloat) b).getValue());
        return null;
    }

    public static ErlFloat fdiv(ErlTerm a, ErlTerm b) {
        if (a instanceof ErlFloat && b instanceof ErlFloat)
            return fdiv((ErlFloat) a, (ErlFloat) b);
        return null;
    }

    private static ErlFloat fdiv(ErlFloat a, ErlFloat b) {
        float result = a.getValue() / b.getValue();
        if (Float.isInfinite(result))
            return null;
        return new ErlFloat(result);
    }

    public static ErlFloat fnegate(ErlTerm a) {
        if (a instanceof ErlFloat)
            return new ErlFloat(-(((ErlFloat) a).getValue()));
        return null;
    }

    public static int compare(ErlTerm a, ErlTerm b) {
        if (a.getOrder() != b.getOrder()) return compare_order(a, b);
        if (a instanceof ErlNumber) return compare((ErlNumber) a, (ErlNumber) b);
        if (a instanceof ErlAtom) return compare((ErlAtom) a, (ErlAtom) b);
        if (a instanceof ErlFun) return compare((ErlFun) a, (ErlFun) b);
        if (a instanceof ErlPid) return compare((ErlPid) a, (ErlPid) b);
        if (a instanceof ErlTuple) return compare((ErlTuple) a, (ErlTuple) b);
        if (a instanceof ErlMap) return compare((ErlMap) a, (ErlMap) b);
        return 0;
    }

    private static int compare(ErlNumber a, ErlNumber b) {
        if (a instanceof ErlInt) {
            if (b instanceof ErlInt) {
                return compare(((ErlInt) a).getValue(), ((ErlInt) b).getValue());
            } else if (b instanceof ErlFloat) {
                return compare((float) ((ErlInt) a).getValue(), ((ErlFloat) b).getValue());
            }
        } else if (a instanceof ErlFloat) {
            if (b instanceof ErlInt) {
                return compare(((ErlFloat) a).getValue(), (float) ((ErlInt) b).getValue());
            } else if (b instanceof ErlFloat) {
                return compare(((ErlFloat) a).getValue(), ((ErlFloat) b).getValue());
            }
        }
        return 0;
    }

    private static int compare_order(ErlTerm a, ErlTerm b) {
        if (a.getOrder() < b.getOrder()) return -1;
        if (a.getOrder() == b.getOrder()) return 0;
        return 1;
    }

    private static int compare(ErlAtom a, ErlAtom b) {
        return a.getValue().compareTo(b.getValue());
    }

    private static int compare(int a, int b) {
        if (a < b) return -1;
        if (a == b) return 0;
        return 1;
    }

    private static int compare(float a, float b) {
        if (a < b) return -1;
        if (a == b) return 0;
        return 1;
    }

    private static int compare(long a, long b) {
        if (a < b) return -1;
        if (a == b) return 0;
        return 1;
    }

    private static int compare(ErlFun a, ErlFun b) {
        if (compare(a.getName(), b.getName()) != 0) return compare(a.getName(), b.getName());
        return compare(a.getArity(), b.getArity());
    }

    private static int compare(ErlPid a, ErlPid b) {
        return compare(a.getValue(), b.getValue());
    }

    private static int compare(ErlTuple a, ErlTuple b) {
        if (compare(a.size(), b.size()) != 0) return compare(a.size(), b.size());
        for (int i = 0; i < a.size(); i++) {
            if (compare(a.get(i), b.get(i)) != 0)
                return compare(a.get(i), b.get(i));
        }
        return 0;
    }

    private static int compare(ErlMap a, ErlMap b) {
        if (compare(a.size(), b.size()) != 0) return compare(a.size(), b.size());
        for (int i = 0; i < a.size(); i++) {
            ErlTerm akey = a.getKey(i);
            ErlTerm bkey = b.getKey(i);
            if (compare(akey, bkey) != 0) return compare(akey, bkey);
            if (compare(a.get(akey), b.get(bkey)) != 0) return compare(a.get(akey), b.get(bkey));
        }
        return 0;
    }

    private static int compare(ErlList a, ErlList b) {
        if (a.isNil()) {
            if (b.isNil()) return 0;
            return -1;
        }
        if (b.isNil()) return 1;
        if (compare(a.head, b.head) != 0) return compare(a.head, b.head);
        return compare(a.tail, b.tail);
    }

    private static int compare(ErlBinary a, ErlBinary b) {
        for (int i = 0; i < a.size(); i++) {
            if (i >= b.size()) return 1;
            if (compare(a.get(i), b.get(i)) != 0) return compare(a.get(i), b.get(i));
        }
        if (a.size() < b.size()) return -1;
        return 0;
    }

    private static ErlTerm and(ErlTerm a, ErlTerm b) {
        if (a instanceof ErlAtom && b instanceof ErlAtom) {
            ErlAtom atoma = (ErlAtom) a;
            ErlAtom atomb = (ErlAtom) b;
            if (atoma.getValue().equals("true")) {
                if (atomb.getValue().equals("true"))
                    return new ErlAtom("true");
                else if (atomb.getValue().equals("false"))
                    return new ErlAtom("false");
            } else if (atoma.getValue().equals("false")) {
                if (atomb.getValue().equals("true") || atomb.getValue().equals("false"))
                    return new ErlAtom("false");
            }
        }
        return new ErlException(new ErlAtom("badarg"));
    }

    private static ErlTerm or(ErlTerm a, ErlTerm b) {
        if (a instanceof ErlAtom && b instanceof ErlAtom) {
            ErlAtom atoma = (ErlAtom) a;
            ErlAtom atomb = (ErlAtom) b;
            if (atoma.getValue().equals("true")) {
                if (atomb.getValue().equals("true") || atomb.getValue().equals("false"))
                    return new ErlAtom("true");
            } else if (atoma.getValue().equals("false")) {
                if (atomb.getValue().equals("true"))
                    return new ErlAtom("true");
                else if (atomb.getValue().equals("false"))
                    return new ErlAtom("false");
            }
        }
        return new ErlException(new ErlAtom("badarg"));
    }

    private static ErlTerm not(ErlTerm a) {
        if (a instanceof ErlAtom) {
            if (((ErlAtom) a).getValue().equals("true"))
                return new ErlAtom("false");
            else if (((ErlAtom) a).getValue().equals("false"))
                return new ErlAtom("true");
        }
        return new ErlException(new ErlAtom("badarg"));
    }

    private static ErlInt bit_size(ErlTerm bin) {
	if (bin instanceof ErlBinary) {
	    return new ErlInt(((ErlBinary) bin).bitSize());
	}
	return null;
    }

    private static ErlInt byte_size(ErlTerm bin) {
	if (bin instanceof ErlBinary){
	    return new ErlInt(((ErlBinary) bin).size());
	}
	return null;
    }
}
