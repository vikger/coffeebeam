package coffeebeam.types;

public abstract class ErlTerm {
    String tag;
    boolean reference = false;
    int order = 0;
    private ErlTerm() {}
    public ErlTerm(String t, int o) { tag = t; order = o; }
    public abstract String toString();
    public abstract String toId();
    public String getTag() { return tag; }
    public boolean isReference() { return reference; }
    public int getOrder() { return order; }
    public static ErlTerm parse(String s) {
        try {
            ParseResult pr = parseTerm(s);
            return pr.term;
        } catch (ErlSyntaxException e) {
            return null;
        }
    }
    public static ParseResult parseTerm(String s) throws ErlSyntaxException {
        s = skipWs(s);
        if (s.charAt(0) >= 'a' && s.charAt(0) <= 'z')
            return parseAtom(s);
        if (s.charAt(0) == '\'')
            return parseQuotedAtom(s);
        if (isDigit(s.charAt(0)) || s.charAt(0) == '-')
            return parseNumber(s);
        if (s.charAt(0) == '"')
            return parseString(s);
        if (s.charAt(0) == '[')
            return parseList(s);
        if (s.charAt(0) == '{')
            return parseTuple(s);
	if (s.charAt(0) == '<') {
	    if (s.charAt(1) == '<')
		return parseBinary(s);
	    // else parse pid, port, ...
	}
        if (s.charAt(0) == '%')
            return parseMap(s);
        return new ParseResult(null, s);
    }
    private static String skipWs(String s) {
        while (s.charAt(0) == ' ' || s.charAt(0) == '\t')
            s = s.substring(1);
        return s;
    }
    private static ParseResult parseAtom(String s) {
        String name = String.valueOf(s.charAt(0));
        s = s.substring(1);
        while (!s.isEmpty() && isAtomSubChar(s.charAt(0))) {
            name += s.charAt(0);
            s = s.substring(1);
        }
        return new ParseResult(new ErlAtom(name), s);
    }
    private static ParseResult parseQuotedAtom(String s) {
        String name = "";
        s = s.substring(1);
        while (!s.isEmpty() && s.charAt(0) != '\'') {
            if (s.charAt(0) == '\\') s = s.substring(1);
            name += s.charAt(0);
            s = s.substring(1);
        }
        if (s.charAt(0) == '\'') s = s.substring(1);
        return new ParseResult(new ErlAtom(name), s);
    }
    private static ParseResult parseNumber(String s) {
        int sign;
        if (s.charAt(0) == '-') {
            sign = -1;
            s = s.substring(1);
        } else
            sign = 1;
        int intvalue = 0;
        while (!s.isEmpty() && isDigit(s.charAt(0))) {
            intvalue = 10 * intvalue + s.charAt(0) - '0';
            s = s.substring(1);
        }
        if (!s.isEmpty() && s.charAt(0) == '.') {
            s = s.substring(1);
            float result = (float) intvalue;
            int divider = 10;
            while (!s.isEmpty() && isDigit(s.charAt(0))) {
                result += (s.charAt(0) - '0') / (float) divider;
                divider *= 10;
                s = s.substring(1);
            }
            return new ParseResult(new ErlFloat(sign * result), s);
        }
        return new ParseResult(new ErlInt(sign * intvalue), s);
    }
    private static ParseResult parseList(String s) throws ErlSyntaxException {
        s = s.substring(1);
        s = skipWs(s);
        ErlList list = new ErlList();
        s = parseFromHead(s, list);
        return new ParseResult(list, s);
    }
    private static String parseFromHead(String s, ErlList list)  throws ErlSyntaxException {
        while (s.charAt(0) != ']') {
            ParseResult prhead = parseTerm(s);
            list.add(prhead.term);
            s = prhead.remaining;
            s = skipWs(s);
            if (s.charAt(0) == ',') {
                s = s.substring(1);
                s = skipWs(s);
            } else if (s.charAt(0) == '|') {
                s = s.substring(1);
                ParseResult prtail = parseTerm(s);
                list.setTail(prtail.term);
                s = prtail.remaining;
                s = skipWs(s);
            }
        }
        s = s.substring(1);
        return s;
    }
    private static ParseResult parseString(String s) {
        s = s.substring(1);
        ErlList list = new ErlList();
        while (s.charAt(0) != '"') {
            list.add(new ErlInt(s.charAt(0)));
            s = s.substring(1);
        }
        s = s.substring(1);
        return new ParseResult(list, s);
    }
    private static ParseResult parseTuple(String s) throws ErlSyntaxException {
        s = s.substring(1);
        s = skipWs(s);
        ErlTuple tuple = new ErlTuple();
        while (s.charAt(0) != '}') {
            ParseResult pritem = parseTerm(s);
            tuple.add(pritem.term);
            s = pritem.remaining;
            s = skipWs(s);
            if (s.charAt(0) == ',') {
                s = s.substring(1);
                s = skipWs(s);
            }
        }
        s = s.substring(1);
        return new ParseResult(tuple, s);
    }
    private static ParseResult parseBinary(String s) {
	s = s.substring(2);
	s = skipWs(s);
	ErlBinary bin = new ErlBinary();
	while (s.charAt(0) != '>') {
	    int binbyte = 0;
	    while (isDigit(s.charAt(0))) {
		binbyte = 10 * binbyte + s.charAt(0) - '0';
		s = s.substring(1);
	    }
	    bin.add(binbyte);
	    s = skipWs(s);
	    if (s.charAt(0) == ',')
		s = s.substring(1);
	}
	s = s.substring(2);
	return new ParseResult(bin, s);
    }
    private static ParseResult parseMap(String s) throws ErlSyntaxException {
        s = s.substring(1);
        if (s.charAt(0) != '{') throw new ErlSyntaxException();
        s = s.substring(1);
        s = skipWs(s);
        ErlMap map = new ErlMap();
        while (s.charAt(0) != '}') {
            ParseResult keypr = parseTerm(s);
            s = keypr.remaining;
            s = skipWs(s);
            if (s.charAt(0) != '=') throw new ErlSyntaxException();
            s = s.substring(1);
            if (s.charAt(0) != '>') throw new ErlSyntaxException();
            ParseResult valuepr = parseTerm(s);
            map.add(keypr.term, valuepr.term);
            s = valuepr.remaining;
            s = skipWs(s);
            if (s.charAt(0) == ',') s = s.substring(1);
        }
        s = s.substring(1);
        return new ParseResult(map, s);
    }
    public static boolean isAtomSubChar(char c) {
        return (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') || isDigit(c) || c == '_';
    }
    private static boolean isDigit(char c) {
        return c >= '0' && c <= '9';
    }
}

class ParseResult {
    ErlTerm term;
    String remaining;
    public ParseResult(ErlTerm t, String r) {
        term = t;
        remaining = r;
    }
}
