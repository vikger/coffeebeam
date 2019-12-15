package coffeebeam.erts;

import coffeebeam.types.*;
import java.util.HashMap;

public class ErlBif {
    private static HashMap<String, Bif1> bif1;
    private static HashMap<String, Bif2> bif2;

    public static void init() {
	bif1 = new HashMap<String, Bif1>();
	bif1.put("bnot", new Bif1() { public ErlTerm execute(ErlTerm arg) { return ErlBif.bnot(arg); }});
	bif1.put("not", new Bif1() { public ErlTerm execute(ErlTerm arg) { return ErlBif.not(arg); }});
	bif1.put("bit_size", new Bif1() { public ErlTerm execute(ErlTerm arg) { return ErlBif.bit_size(arg); }});
	bif1.put("byte_size", new Bif1() { public ErlTerm execute(ErlTerm arg) { return ErlBif.byte_size(arg); }});

	bif2 = new HashMap<String, Bif2>();
	bif2.put("+", new Bif2() { public ErlTerm execute(ErlTerm arg1, ErlTerm arg2) { return ErlBif.add(arg1, arg2); }});
 	bif2.put("-", new Bif2() { public ErlTerm execute(ErlTerm arg1, ErlTerm arg2) { return ErlBif.subtract(arg1, arg2); }});
	bif2.put("*", new Bif2() { public ErlTerm execute(ErlTerm arg1, ErlTerm arg2) { return ErlBif.mul(arg1, arg2); }});
	bif2.put("div", new Bif2() { public ErlTerm execute(ErlTerm arg1, ErlTerm arg2) { return ErlBif.div(arg1, arg2); }});
	bif2.put("rem", new Bif2() { public ErlTerm execute(ErlTerm arg1, ErlTerm arg2) { return ErlBif.rem(arg1, arg2); }});
	bif2.put("bsl", new Bif2() { public ErlTerm execute(ErlTerm arg1, ErlTerm arg2) { return ErlBif.bsl(arg1, arg2); }});
	bif2.put("bsr", new Bif2() { public ErlTerm execute(ErlTerm arg1, ErlTerm arg2) { return ErlBif.bsr(arg1, arg2); }});
	bif2.put("band", new Bif2() { public ErlTerm execute(ErlTerm arg1, ErlTerm arg2) { return ErlBif.band(arg1, arg2); }});
	bif2.put("bor", new Bif2() { public ErlTerm execute(ErlTerm arg1, ErlTerm arg2) { return ErlBif.bor(arg1, arg2); }});
	bif2.put("bxor", new Bif2() { public ErlTerm execute(ErlTerm arg1, ErlTerm arg2) { return ErlBif.bxor(arg1, arg2); }});
	bif2.put("=<", new Bif2() { public ErlTerm execute(ErlTerm arg1, ErlTerm arg2) { return new ErlAtom(ErlBif.compare(arg1, arg2) <= 0); }});
	bif2.put("<", new Bif2() { public ErlTerm execute(ErlTerm arg1, ErlTerm arg2) { return new ErlAtom(ErlBif.compare(arg1, arg2) < 0); }});
	bif2.put(">=", new Bif2() { public ErlTerm execute(ErlTerm arg1, ErlTerm arg2) { return new ErlAtom(ErlBif.compare(arg1, arg2) >= 0); }});
	bif2.put(">", new Bif2() { public ErlTerm execute(ErlTerm arg1, ErlTerm arg2) { return new ErlAtom(ErlBif.compare(arg1, arg2) > 0); }});
	bif2.put("and", new Bif2() { public ErlTerm execute(ErlTerm arg1, ErlTerm arg2) { return ErlBif.and(arg1, arg2); }});
	bif2.put("or", new Bif2() { public ErlTerm execute(ErlTerm arg1, ErlTerm arg2) { return ErlBif.or(arg1, arg2); }});
   }

    public static ErlTerm op(String op, ErlTerm arg) {
	Bif1 b = bif1.get(op);
	if (b != null)
	    return b.execute(arg);
	return new ErlException(ErlTerm.parse("{undef,{erlang," + op + ",1}}"));
    }

    public static ErlTerm op(String op, ErlTerm arg1, ErlTerm arg2) {
	Bif2 b = bif2.get(op);
	if (b != null)
	    return b.execute(arg1, arg2);
	return new ErlException(ErlTerm.parse("{undef,{erlang, "+ op + ",2}}"));
    }

    public static ErlTerm add(ErlTerm a, ErlTerm b) {
	if (a instanceof ErlInt) {
	    if (b instanceof ErlInt) {
		return add((ErlInt) a, (ErlInt) b);
	    }
	} else if (a instanceof ErlFloat) {
	    if (b instanceof ErlFloat) {
		return add((ErlFloat) a, (ErlFloat) b);
	    }
	}
	return new ErlException(new ErlAtom("badarith"));
    }

    private static ErlInt add(ErlInt a, ErlInt b) {
	return new ErlInt(a.getValue() + b.getValue());
    }

    private static ErlFloat add(ErlFloat a, ErlFloat b) {
	return new ErlFloat(a.getValue() + b.getValue());
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

    private static ErlInt mul(ErlInt a, ErlInt b) {
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

    private static ErlInt div(ErlInt a, ErlInt b) {
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

    private static ErlInt rem(ErlInt a, ErlInt b) {
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
        double result = a.getValue() / b.getValue();
        if (Double.isInfinite(result))
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
	    ErlInt aint = (ErlInt) a;
            if (b instanceof ErlInt) {
                return compare(aint.getValue(), ((ErlInt) b).getValue());
            } else if (b instanceof ErlFloat) {
                return compare((double) aint.getValue(), ((ErlFloat) b).getValue());
            } else if (b instanceof ErlBigNum) {
		return compare((long) aint.getValue(), ((ErlBigNum) b).getValue());
	    }
        } else if (a instanceof ErlFloat) {
	    ErlFloat afloat = (ErlFloat) a;
            if (b instanceof ErlInt) {
                return compare(afloat.getValue(), (double) ((ErlInt) b).getValue());
            } else if (b instanceof ErlFloat) {
                return compare(afloat.getValue(), ((ErlFloat) b).getValue());
            } else if (b instanceof ErlBigNum) {
		return compare(afloat.getValue(), (double) ((ErlBigNum) b).getValue());
	    }
        } else if (a instanceof ErlBigNum) {
	    ErlBigNum abig = (ErlBigNum) a;
	    if (b instanceof ErlInt) {
		return compare(abig.getValue(), (long) ((ErlInt) b).getValue());
	    } else if (b instanceof ErlFloat) {
		return compare((double) abig.getValue(), ((ErlFloat) b).getValue());
	    } else if (b instanceof ErlBigNum) {
		return compare(abig.getValue(), ((ErlBigNum) b).getValue());
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
	return Integer.compare(a, b);
    }

    private static int compare(double a, double b) {
	return Double.compare(a, b);
    }

    private static int compare(long a, long b) {
	return Long.compare(a, b);
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

    public static ErlTerm and(ErlTerm a, ErlTerm b) {
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

    public static ErlTerm or(ErlTerm a, ErlTerm b) {
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

    public static ErlTerm not(ErlTerm a) {
        if (a instanceof ErlAtom) {
            if (((ErlAtom) a).getValue().equals("true"))
                return new ErlAtom("false");
            else if (((ErlAtom) a).getValue().equals("false"))
                return new ErlAtom("true");
        }
        return new ErlException(new ErlAtom("badarg"));
    }

    public static ErlInt bit_size(ErlTerm bin) {
	if (bin instanceof ErlBinary) {
	    return new ErlInt(((ErlBinary) bin).bitSize());
	}
	return null;
    }

    public static ErlInt byte_size(ErlTerm bin) {
	if (bin instanceof ErlBinary){
	    return new ErlInt(((ErlBinary) bin).size());
	}
	return null;
    }
}

interface Bif1 {
    public ErlTerm execute(ErlTerm arg);
}

interface Bif2 {
    public ErlTerm execute(ErlTerm arg1, ErlTerm arg2);
}
