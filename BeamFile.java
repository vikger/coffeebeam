import java.io.IOException;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.Arrays;
import java.util.zip.InflaterInputStream;
import java.util.ArrayList;
import java.util.Random;

public class BeamFile {
    private String filename;
    private ArrayList<String> atoms;
    private ArrayList<ErlTerm> literals;
    private ArrayList<Import> imports;
    private ArrayList<Export> exports;
    private ArrayList<ErlFun> localFunctions;
    private ArrayList<ErlOp> codeTable;
    private ArrayList<Integer> labelRefs;
    private ErlTerm attributes;
    private ErlBinary strTable;

    private BeamFile() {}
    public BeamFile(String fn) {
        filename = fn;
        atoms = new ArrayList<String>();
        literals = new ArrayList<ErlTerm>();
        imports = new ArrayList<Import>();
        exports = new ArrayList<Export>();
        localFunctions = new ArrayList<ErlFun>();
        codeTable = new ArrayList<ErlOp>();
        labelRefs = new ArrayList<Integer>(); labelRefs.add(-1); // for errors
    }

    public void readAtom(ByteReader br) throws IOException {
	long count = br.read32BitUnsigned();
	for (int i = 0; i < count; i++) {
	    int length = br.readByte();
	    atoms.add(new String(br.readBytes(length)));
	}
    }

    public void readCode(ByteReader br) throws IOException {
        long subsize = br.read32BitUnsigned();
        long codeversion = br.read32BitUnsigned();
        long maxopcode = br.read32BitUnsigned();
        long labelcount = br.read32BitUnsigned();
        long funcount = br.read32BitUnsigned();
        System.out.println("version: " + codeversion +
                           ", maxopcode: " + maxopcode +
                           ", labels: " + labelcount +
                           ", functions: " + funcount);
        int opcode;
        while ((opcode = br.readByte()) != -1) {
            int arity = OpCode.arity(opcode);
            //System.out.println("-- " + OpCode.name(opcode) + " / " + arity);
            ArrayList<ErlTerm> terms = new ArrayList<ErlTerm>();
            for (int j = 0; j < arity; j++) {
                terms.add(InternalTerm.read(br, this));
            }
            codeTable.add(new ErlOp(opcode, terms));
            if (opcode == 1)
                labelRefs.add(codeTable.size() - 1);
        }
    }

    public void readLiterals(ByteReader br) throws IOException {
        int uncompressedSize = (int) br.read32BitUnsigned();
        //System.out.println(uncompressedSize);

        InflaterInputStream iis = new InflaterInputStream(br.getStream());
        byte[] uncompressed = new byte[uncompressedSize];
        iis.read(uncompressed);
        br = new ByteReader(new ByteArrayInputStream(uncompressed));
        int count = (int) br.read32BitUnsigned();
        //System.out.println("Count: " + count);
        for (int i = 0; i < count; i++) {
            int size = (int) br.read32BitUnsigned();
            literals.add(ExternalTerm.read(br));
        }
    }

    public void readImports(ByteReader br) throws IOException {
        int count = (int) br.read32BitUnsigned();
        for (int i = 0; i < count; i++) {
            int module = (int) br.read32BitUnsigned();
            int function = (int) br.read32BitUnsigned();
            int arity = (int) br.read32BitUnsigned();
            imports.add(new Import(module - 1, function - 1, arity));
        }
    }

    public void readExports(ByteReader br) throws IOException {
        int count = (int) br.read32BitUnsigned();
        for (int i = 0; i < count; i++) {
            int name = (int) br.read32BitUnsigned();
            int arity = (int) br.read32BitUnsigned();
            int label = (int) br.read32BitUnsigned();
            exports.add(new Export(name - 1, arity, label));
        }
    }

    public void readLocalFunctions(ByteReader br) throws IOException {
        int count = (int) br.read32BitUnsigned();
        for (int i = 0; i < count; i++) {
            int function = (int) br.read32BitUnsigned();
            int arity = (int) br.read32BitUnsigned();
            int label = (int) br.read32BitUnsigned();
            localFunctions.add(new ErlFun(this, function - 1, arity, label));
        }
    }

    public void readAttributes(ByteReader br) throws IOException {
        attributes = ExternalTerm.read(br);
    }

    public void readStr(ByteReader br) throws IOException {
	strTable = new ErlBinary();
	int newbyte;
	while ((newbyte = br.readByte()) != -1)
	    strTable.add(newbyte);
    }

    public void dump() {
        printAtoms();
        printLiterals();
        printImports();
        printExports();
        printLocalFunctions();
        printCodeTable();
        printLabelRefs();
        printAttributes();
	printStrTable();
    }

    private void printAtoms() {
        for (int i = 0; i < atoms.size(); i++) {
            BeamDebug.println("Atom(" + i + "): " + atoms.get(i));
        }
    }

    private void printLiterals() {
        for (int i = 0; i < literals.size(); i++) {
            BeamDebug.println("Literal(" + i + "): " + literals.get(i).toString());
        }
    }

    private void printImports() {
        for (int i = 0; i < imports.size(); i++) {
            Import imp = imports.get(i);
            BeamDebug.println("Import(" + i + "): [atom " + imp.getModule() + "]:[atom " + imp.getFunction() + "] / " + imp.getArity());
        }
    }

    private void printExports() {
        for (int i = 0; i < exports.size(); i++) {
            Export exp = exports.get(i);
            BeamDebug.println("Export(" + i + "): [atom " + exp.getFunction() + "] / " + exp.getArity() + " - label " + exp.getLabel());
        }
    }

    private void printLocalFunctions() {
        for (int i = 0; i < localFunctions.size(); i++) {
            ErlFun loc = localFunctions.get(i);
            BeamDebug.println("LocalFunction(" + i + "): " + loc.toString());
        }
    }

    private void printCodeTable() {
        for (int i = 0; i < codeTable.size(); i++) {
            ErlOp erlop = codeTable.get(i);
            BeamDebug.println("-- " + OpCode.name(erlop.opcode) + " / " + OpCode.arity(erlop.opcode));
            for (int j = 0; j < erlop.args.size(); j++) {
                ErlTerm arg = erlop.args.get(j);
                BeamDebug.println("---- " + arg.toString());
            }
        }
    }

    public void printLabelRefs() {
        for (int i = 0; i < labelRefs.size(); i++) {
            BeamDebug.println("labelRefs " + i + " -> " + labelRefs.get(i));
        }
    }

    public void printAttributes() {
        BeamDebug.println("Attributes: " + attributes.toString());
    }

    public void printStrTable() {
	BeamDebug.println("StrTable: " + strTable.toString());
    }

    public String getModuleName() {
        return atoms.get(0);
    }

    public String getAtomName(int index) { return atoms.get(index); }

    public ErlTerm getLiteral(int index) { return literals.get(index); }

    public Import getImport(int index) { return imports.get(index); }

    public int getLabel(String function, int argc) {
        for (int i = 0; i < exports.size(); i++) {
            Export exp = exports.get(i);
            if (atoms.get(exp.getFunction()).equals(function) && exp.getArity() == argc)
                return exp.getLabel();
        }
        return -1;
    }

    public int getLabelRef(int label) {
        return labelRefs.get(label);
    }

    public ErlOp getOp(int index) {
        return codeTable.get(index);
    }

    public ErlFun getLocalFunction(int index) {
        return localFunctions.get(index);
    }

    public int getStrByte(int index) {
	return strTable.get(index);
    }
}

class ByteReader {
    InputStream stream;

    public ByteReader(InputStream s) {
	stream = s;
    }

    public InputStream getStream() {
        return stream;
    }

    public int read16BitUnsigned() throws IOException {
	byte[] b = new byte[2];
	stream.read(b, 0, 2);
	return (b[0] & 0xFF) << 8 |
	    (b[1] & 0xFF);
    }

    public long read32BitUnsigned() throws IOException {
	byte[] b = new byte[4];
	stream.read(b, 0, 4);
	return (b[0] & 0xFF) << 24 |
	    (b[1] & 0xFF) << 16 |
	    (b[2] & 0xFF) << 8 |
	    (b[3] & 0xFF);
    }

    public int readByte() throws IOException {
	return stream.read();
    }

    public byte[] readBytes(int length) throws IOException {
	byte[] bytes = new byte[length];
	stream.read(bytes, 0, length);
	return bytes;
    }
}

class Import {
    int module, function, arity;
    public Import(int m, int f, int a) {
        module = m;
        function = f;
        arity = a;
    }

    public int getModule() { return module; }
    public int getFunction() { return function; }
    public int getArity() { return arity; }
}

class Export {
    int function, arity, label;
    public Export(int f, int a, int l) {
        function = f;
        arity = a;
        label = l;
    }

    public int getFunction() { return function; }
    public int getArity() { return arity; }
    public int getLabel() { return label; }
}

class ErlFun extends ErlTerm {
    ErlAtom name;
    int arity;
    ErlLabel label;
    private BeamFile beamfile;
    public ErlFun(BeamFile bf, int f, int a, int l) {
        super("fun", 4);
        name = new ErlAtom(bf, f);
        arity = a;
        label = new ErlLabel(l);
        beamfile = bf;
    }

    public ErlAtom getName() { return name; }
    public int getArity() { return arity; }
    public ErlLabel getLabel() { return label; }
    public String toString() { return name.toString() + " / " + arity + " -> label(" + label.getValue() + ")"; }
    public String toId() { return tag + "(" + name + "," + arity + "," + label + ")"; }
    public BeamFile getModule() { return beamfile; }
}

class ErlOp {
    int opcode;
    ArrayList <ErlTerm> args;
    public ErlOp(int oc, ArrayList<ErlTerm> a) {
        opcode = oc;
        args = a;
    }
}

abstract class ErlTerm {
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
    public static ErlTerm parse(String s) throws ErlSyntaxException {
        ParseResult pr = parseTerm(s);
        return pr.term;
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

class ErlSyntaxException extends Exception {
}

class ParseResult {
    ErlTerm term;
    String remaining;
    public ParseResult(ErlTerm t, String r) {
        term = t;
        remaining = r;
    }
}

class GenericErlTerm extends ErlTerm {
    int value;
    public GenericErlTerm(int v) {
        super("generic", 0);
        value = v;
    }

    public boolean isReference() { return false; }

    public String toString() { return "term(" + getTag() + "): " + value; }
    public String toId() { return tag + "(" + value + ")"; }
}

abstract class ErlNumber extends ErlTerm {
    public ErlNumber(String tag) {
        super(tag, 1);
    }
}

class ErlInt extends ErlNumber {
    int value;

    public ErlInt(int v) {
        super("integer");
        value = v;
    }
    public String toString() { return Integer.toString(value); }

    public String toId() { return tag + "(" + value + ")"; }

    public int getValue() { return value; }
}

class ErlFloat extends ErlNumber {
    float value;

    public ErlFloat(float v) {
        super("float");
        value = v;
    }
    public ErlFloat(ErlTerm t) {
        super("float");
        if (t instanceof ErlInt) {
            value = (float) ((ErlInt) t).getValue();
        }
    }
    public String toString() { return Float.toString(value); }
    public String toId() { return tag + "(" + value + ")"; }
    public float getValue() { return value; }
}

class ErlBigNum extends ErlNumber {
    boolean positive = false;
    ArrayList<Integer> segments;

    public ErlBigNum(int s) {
        super("bignum");
        if (s == 0) positive = true;
        segments = new ArrayList<Integer>();
    }

    public void addSegment(int seg) {
        segments.add(seg);
    }

    public void addSegmentFirst(int seg) {
        segments.add(0, seg);
    }

    public long getValue() {
        long value = 0;
        for (int i = 0; i < segments.size(); i++) {
            value += segments.get(i) * (1 << (8 * i));
        }
        if (!positive) value = -value;
        return value;
    }

    public ErlBigNum clone() {
        ErlBigNum res = new ErlBigNum(positive ? 0 : 1);
        for (int i = 0; i < segments.size(); i++)
            res.addSegment(segments.get(i));
        return res;
    }

    public String toString() {
        String str = "";
        boolean trim = true;
        ErlBigNum temp = clone();
        do {
            str = temp.mod10() + str;
            temp = temp.div10();
        } while (temp.segments.size() > 0);
        if (!positive) str = "-" + str;
        return str;
    }

    public String toId() {
        return tag + "(" + toString() + ")";
    }

    public ErlBigNum div10() {
        int rem = 0;
        boolean trim = true;
        ErlBigNum result = new ErlBigNum(0);
        for (int i = segments.size() - 1; i >= 0; i--) {
            int n = segments.get(i);
            int newseg = (n + rem) / 10;
            if (!(trim && newseg == 0)) {
                trim = false;
                result.segments.add(0, newseg);
            }
            rem = ((n + rem) % 10) << 8;
        }
        return result;
    }

    public int mod10() {
        int mul = 1;
        int result = 0;
        for (int i = 0; i < segments.size(); i++) {
            result = (result + segments.get(i) * mul) % 10;
            mul = (mul * 256) % 10;
        }
        return result;
    }
}

class ErlAtom extends ErlTerm {
    private int index;
    private String value;
    private BeamFile beamfile;

    public ErlAtom(String v) {
        super("atom", 2);
        value = v;
    }
    public ErlAtom(BeamFile bf, int i) {
        super("atom", 2);
        index = i;
        reference = true;
        beamfile = bf;
    }
    public ErlAtom(boolean b) {
        super("atom", 2);
        if (b) value = "true";
        else value = "false";
    }
    public String toString() {
        String s = getValue();
        if (s.equals(""))
            return "''";
        char c = s.charAt(0);
        if (c >= 'a' && c <= 'z')
            return toSimple(s.substring(1), String.valueOf(c));
        return toQuoted(s.substring(1), String.valueOf(c));
    }
    private String toSimple(String s, String output) {
        if (s.equals("")) return output;
        char c = s.charAt(0);
        if (ErlTerm.isAtomSubChar(c))
            return toSimple(s.substring(1), output + String.valueOf(c));
        return toQuoted(s.substring(1), output + String.valueOf(c));
    }
    private String toQuoted(String s, String output) {
        if (s.equals("")) return "'" + output + "'";
        char c = s.charAt(0);
        return toQuoted(s.substring(1), output + String.valueOf(c));
    }
    public String toId() { return tag + "(" + getValue() + ")"; }
    public int getIndex() { return index; }
    public String getValue() {
        if (reference) return beamfile.getAtomName(index);
        return value;
    }
}

class ErlList extends ErlTerm {
    ErlTerm head = null;
    ErlTerm tail = null;
    boolean nil = true;

    public ErlList() {
        super("list", 9);
    }
    public ErlList(ErlTerm hd, ErlTerm tl) {
        super("list", 9);
        nil = false;
        head = hd;
        tail = tl;
    }
    public void add(ErlTerm item) {
        if (isNil()) {
            nil = false;
            head = item;
            tail = new ErlList();
        } else {
            if (tail instanceof ErlList) {
                ((ErlList) tail).add(item);
            }
        }
    }
    public void setTail(ErlTerm t) {
        if (tail instanceof ErlList) {
            if (((ErlList) tail).isNil()) {
                tail = t;
            } else {
                ((ErlList) tail).setTail(t);
            }
        } else {
            tail = t;
        }
    }
    public boolean isNil() {
        return nil;
    }
    public String toString() {
        if (isNil()) return "[]";
        return toPrintable("\"", "[");
    }
    private String toPrintable(String p, String nonp) {
        if (tail instanceof ErlList) {
            ErlList t = (ErlList) tail;
            if (t.isNil()) {
                if (isPrintable(head))
                    return p + String.valueOf((char) ((ErlInt) head).getValue()) + "\"";
                else
                    return nonp + head.toString() + "]";
            } else {
                if (isPrintable(head))
                    return t.toPrintable(p + String.valueOf((char) ((ErlInt) head).getValue()), nonp + head.toString() + ", ");
                else
                    return t.toNonPrintable(nonp + head.toString() + ", ");
            }
        }
        return nonp + head.toString() + " | " + tail.toString() + "]";
    }
    private String toNonPrintable(String nonp) {
        if (tail instanceof ErlList) {
            ErlList t = (ErlList) tail;
            if (t.isNil()) {
                return nonp + head.toString() + "]";
            } else {
                return t.toNonPrintable(nonp + head.toString() + ", ");
            }
        } else {
            return nonp + head.toString() + " | " + tail.toString() + "]";
        }
    }
    private String toStringValues() {
        if (tail instanceof ErlList) {
            if (((ErlList)tail).isNil()) {
                return head.toString() + "]";
            } else {
                return head.toString() + ", " + ((ErlList) tail).toStringValues();
            }
        } else {
            return head.toString() + " | " + tail.toString() + "]";
        }
    }
    private boolean isPrintable(ErlTerm item) {
        if (item instanceof ErlInt) {
            int c = ((ErlInt) item).getValue();
            return (/*(c >= 8 && c <= 13) || (c == 27) || */(c >= 32 && c <= 126)/* || (c >= 160 && c <= 255)*/);
        }
        return false;
    }
    public String toId() {
        if (isNil()) return "nil";
        else return tag + "(" + head.toId() + "," + tail.toId() + ")";
    }
    public int size() {
        if (isNil()) return 0;
        else if (tail instanceof ErlList) return 1 + ((ErlList) tail).size();
        else return -1;
    }
}

class ErlTuple extends ErlTerm {
    ArrayList<ErlTerm> elements;
    int maxindex = -1;

    public ErlTuple() {
        super("tuple", 7);
        elements = new ArrayList<ErlTerm>();
    }
    public ErlTerm get(int i) {
        return elements.get(i);
    }
    public void add(ErlTerm element) {
        elements.add(element);
        maxindex++;
    }
    public String toString() {
        String str = "{";
        for (int i = 0; i < elements.size(); i++) {
            if (i == 0)
                str += elements.get(i).toString();
            else
                str += ", " + elements.get(i).toString();
        }
        str += "}";
        return str;
    }
    public String toId() {
        String id = tag + "(";
        for (int i = 0; i < elements.size(); i++) {
            if (i == 0)
                id += elements.get(i).toId();
            else
                id += "," + elements.get(i).toId();
        }
        id += ")";
        return id;
    }

    public int size() { return elements.size(); }
    public ErlTerm getElement(int index) { return elements.get(index); }
    public void setElement(int index, ErlTerm value) {
        while (index > maxindex) {
            elements.add(new ErlList()); // can be any ErlTerm instance
            maxindex++;
        }
        elements.set(index, value);
    }
}

class ErlMap extends ErlTerm {
    private ArrayList<ErlTerm> keys;
    private ArrayList<ErlTerm> values;

    public ErlMap() {
        super("map", 8);
        keys = new ArrayList<ErlTerm>();
        values = new ArrayList<ErlTerm>();
    }
    public int size() { return keys.size(); }
    public void add(ErlTerm key, ErlTerm value) {
        keys.add(key);
        values.add(value);
    }
    public ErlTerm get(ErlTerm key) {
        for (int i = 0; i < keys.size(); i++) {
            if (keys.get(i).toId().equals(key.toId())) {
                return values.get(i);
            }
        }
        return null;
    }
    public ErlTerm getKey(int n) {
        for (int i = 0; i < keys.size(); i++) {
            if (getKeyOrder(keys.get(i)) == n)
                return keys.get(i);
        }
        return null;
    }

    private int getKeyOrder(ErlTerm key) {
        int order = 0;
        for (int i = 0; i < keys.size(); i++) {
            if (ErlBif.compare(keys.get(i), key) == -1) order++;
        }
        return order;
    }

    public String toString() {
        String str = "#{";
        for (int i = 0; i < keys.size(); i++) {
            if (i == 0) str += keys.get(i).toString() + " => " + values.get(i).toString();
            else str += ", " + keys.get(i).toString() + " => " + values.get(i).toString();
        }
        str += "}";
        return str;
    }
    public String toId() {
        String str = tag + "(";
        for (int i = 0; i < keys.size(); i++) {
            if (i == 0) str += "(" + keys.get(i).toString() + "," + values.get(i).toString() + ")";
            else str += ",(" + keys.get(i).toString() + "," + values.get(i).toString() + ")";
        }
        str += ")";
        return str;
    }
}

class ErlBinary extends ErlTerm {
    ArrayList<Integer> bytes;
    int position = 0;

    public ErlBinary() {
	super("binary", 10);
	bytes = new ArrayList<Integer>();
    }

    public void add(int segment) {
	bytes.add(segment);
    }

    public int get(int index) {
	return bytes.get(index);
    }

    public ErlBinary get(int index, int length) {
	ErlBinary result = new ErlBinary();
	for (int i = index; i < index + length; i++)
	    result.add(bytes.get(i));
	return result;
    }

    public int getBit() {
	int b = bytes.get(0);
	int bit = (b & (1 << (7 - position))) >> (7 - position);
	position++;
	if (position == 8) {
	    bytes.remove(0);
	    position = 0;
	}
	return bit;
    }

    public int getInteger(int length) {
	int result = 0;
	while (length > 0) {
	    result = (result << 1) + getBit();
	    length--;
	}
	return result;
    }

    public int startMatch() {
	return position;
    }

    public int getPosition() {
	return position;
    }

    public int bitSize() {
	return 8 * bytes.size() - position;
    }

    public int size() {
        return bytes.size();
    }

    public String toString() {
	String str = "<<";
	for (int i = 0; i < bytes.size(); i++) {
	    if (i == 0)
		str += bytes.get(i);
	    else
		str += "," + bytes.get(i);
	}
	return str + ">>";
    }

    public String toId() {
	return toString();
    }
}

class ErlLiteral extends ErlTerm {
    private BeamFile beamfile;
    private int value;
    public ErlLiteral(BeamFile bf, int v) {
        super("literal", 0);
        value = v;
        beamfile = bf;
        reference = true;
    }
    public ErlTerm getValue() { return beamfile.getLiteral(value); }
    public String toString() { return getValue().toString(); }
    public String toId() { return tag + "(" + getValue().toId() + ")"; }
}

class ErlLabel extends ErlTerm {
    private int value;
    public ErlLabel(int v) {
        super("label", 0);
        value = v;
        reference = true;
    }
    public int getValue() { return value; }
    public String toString() { return "label(" + value + ")"; }
    public String toId() { return tag + "(" + value + ")"; }
}

class ErlString extends ErlTerm {
    private String value;
    public ErlString(String v) { super("string", 10); value = v; }
    public String toString() { return "\"" + value + "\""; }
    public String toId() { return tag + "(" + value + ")"; }
    public ErlList toList() {
        ErlList list = new ErlList();
        for (char c : value.toCharArray()) {
            list.add(new ErlInt((int) c));
        }
        return list;
    }
}

class ErlException extends ErlTerm {
    private ErlTerm value;
    public ErlException(ErlTerm v) { super("exception", 0); value = v; }
    public String toString() { return "** exception: " + value.toString(); }
    public String toId() { return tag + "(" + value.toId() + ")"; }
    public ErlTerm getValue() { return value; }
}

class ErlRegister extends ErlTerm {
    private int index;
    private String type;
    public ErlRegister(String t, int i) {
        super(t + "register", 0);
        type = t;
        index = i;
    }
    public String toString() { return type + "(" + index + ")"; }
    public String toId() { return tag + "(" + index + ")"; }
    public int getIndex() { return index; }
    public String getType() { return type; }
}

class ExternalTerm {
    static ByteReader br;

    public static ErlTerm read(ByteReader _br) throws IOException {
        int b;
        br = _br;
        switch (b = br.readByte()) {
        case 131: // external term format
            return read_term();
        default:
            System.out.println("UNKNOWN term code " + b);
            return null;
        }
    }

    private static ErlTerm read_term() throws IOException {
        int tag = br.readByte();
        switch (tag) {
        case 82: // atom_cache_ref
            int index = br.readByte();
            System.out.println("ATOM_CACHE_REF: " + index);
            break;
        case 97: // small integer
            int smallint = br.readByte();
            return new ErlInt(smallint);
        case 98: // integer
            long biginteger = br.read32BitUnsigned();
            System.out.println("INTEGER_EXT: " + biginteger);
            break;
        case 99: // FLOAT_EXT
            byte[] floatstr = br.readBytes(31);
            System.out.println("FLOAT_EXT: " + new String(floatstr));
            break;
        case 100: // ATOM_EXT
            int atom_length = br.read16BitUnsigned();
            byte[] atom_name = br.readBytes(atom_length);
            return new ErlAtom(new String(atom_name));
        case 104: // SMALL_TUPLE_EXT
            ErlTuple tuple = new ErlTuple();
            int small_tuple_arity = br.readByte();
            for (int i = 0; i < small_tuple_arity; i++) {
                tuple.add(read_term());
            }
            return tuple;
        case 106: // NIL_EXT
            return new ErlList();
        case 107: // STRING_EXT
            int length = br.read16BitUnsigned();
            return (new ErlString(new String(br.readBytes(length)))).toList();
        case 108: // LIST_EXT
            ErlList list = new ErlList();
            long list_length = br.read32BitUnsigned();
            for (long i = 0; i < list_length; i++) {
                list.add(read_term());
            }
            list.setTail(read_term()); // tail
            return list;
        case 109: // BINARY_EXT
            long binary_length = br.read32BitUnsigned();
	    ErlBinary bin = new ErlBinary();
            for (long j = 0; j < binary_length; j++) {
		bin.add(br.readByte());
            }
	    return bin;
        case 110: // SMALL_BIG_EXT
            int sb_length = br.readByte();
            int sign = br.readByte();
            ErlBigNum num = new ErlBigNum(sign);
            for (int i = 0; i < sb_length; i++) {
                num.addSegment(br.readByte());
            }
            return num;
        case 111: // LARGE_BIG_EXT
            long lb_length = br.read32BitUnsigned();
            int signl = br.readByte();
            ErlBigNum numl = new ErlBigNum(signl);
            for (int i = 0; i < lb_length; i++) {
                numl.addSegment(br.readByte());
            }
            return numl;
        case 116: // MAP_EXT
            long map_arity = br.read32BitUnsigned();
            ErlMap map = new ErlMap();
            for (int i = 0; i < map_arity; i++) {
                map.add(read_term(), read_term());
            }
            return map;
        default:
            System.out.println("other " + tag);
            System.out.println(" " + br.readByte());
            break;
        }
        System.out.println("UNKNOWN ext_term " + tag);
        return new GenericErlTerm(tag);
    }
}

class InternalTerm {
    public static ErlTerm read(ByteReader br, BeamFile bf) throws IOException {
        String[] tags = {"literal", "integer", "atom", "X register", "Y register", "label", "character", "extended - "};
        int b = br.readByte();
        //System.out.print("---- [" + BeamDebug.dec_to_bin(b) + "] ");
        // read tag
        String tagname = null;
        int value = -1234;
        boolean extended = false;

        // read tag
        int tag = b & 0x07;
        tagname = tags[tag];
        extended = (b & 0x07) == 7;

        // read value
        if ((b & 0x08) != 0) { // bit 3 is 1, continuation
            if ((b & 0x10) != 0) { // 2+ continuation bytes
                int following_bytes = (b & 0xE0) >> 5;
                if (following_bytes == 0x07) { // 9+ continuation bytes
                    following_bytes = (br.readByte() >> 4) + 9; // tag_u, at least 9 bytes
                } else { // 2..8 continuation bytes
                    following_bytes += 2;
                }
                switch (tag) {
                case 1: // big integer
                    ErlBigNum bigint = new ErlBigNum(0);
                    for (int i = 0; i < following_bytes; i++)
                        bigint.addSegmentFirst(br.readByte());
                    return bigint;
                }
                for (int i = 0; i < following_bytes; i++)
                    System.out.print("skipped [" + BeamDebug.dec_to_bin(br.readByte()) + "] ");
                System.out.print("skipped(" + following_bytes + ") ");
            } else { // 1 continuation byte
                int cont1 = br.readByte();
                // System.out.print("[" + BeamDebug.dec_to_bin(cont1) + "] ");
                value = ((b & 0xE0) << 3) + cont1;
                switch (tag) {
                case 0: return new ErlInt(value);
                case 1: return new ErlInt(value);
                case 2: if (value == 0) return new ErlList(); else return new ErlAtom(bf, value - 1);
                case 3: return new ErlRegister("X", value);
                case 4: return new ErlRegister("Y", value);
                case 5: return new ErlLabel(value);
                case 6: return new ErlInt(value); // TODO: character type?
                }
            }
        } else { // bit 3 is 0, no continuation
            if (extended) {
                value = br.readByte();
                //System.out.print("[" + BeamDebug.dec_to_bin(value) + "] ");
                switch ((b & 0xF0) >> 4) {
                case 1: // list
                    tagname += "list";
                    int list_size = value >> 4;
                    tagname += "(" + list_size + ")";
                    ErlList list = new ErlList();
                    for (int i = 0; i < list_size; i++) {
                        list.add(read(br, bf)); // item
                    }
                    return list;
                case 2: // floating point register
                    return new ErlRegister("FP", value >> 4);
                case 3: // allocation list
                    int alloc_list_size = value >> 4; // tag_u
                    for (int i = 0; i < alloc_list_size; i++) {
                        read(br, bf); // type
                        read(br, bf); // number allocated
                    }
                    tagname += "allocation list";
                    break;
                case 4: // literal
                    return new ErlLiteral(bf, value >> 4); // TODO: check spec / beam_asm
                }
            } else {
                value = (b & 0xF0) >> 4;
                switch (tag) {
                case 0: return new ErlInt(value);
                case 1: return new ErlInt(value);
                case 2: if (value == 0) return new ErlList(); else return new ErlAtom(bf, value - 1);
                case 3: return new ErlRegister("X", value);
                case 4: return new ErlRegister("Y", value);
                case 5: return new ErlLabel(value);
                case 6: return new ErlInt(value); // TODO: character type?
                }
            }
        }
        System.out.println("Generic " + tagname + " " + BeamDebug.dec_to_bin(value));
        return new GenericErlTerm(value);
    }
}

class ErlPid extends ErlTerm {
    private long pid;

    public ErlPid(long p) {
	super("pid", 6);
	pid = p;
    }
    public String toString() { return "PID<" + pid + ">"; }
    public String toId() { return tag + "(" + pid + ")"; }
    public long getValue() { return pid; }
}

class ErlReference extends ErlTerm {
    private long ref;

    public ErlReference() {
        super("reference", 3);
        ref = (new Random()).nextLong();
    }
    public String toString() { return "#Ref<" + ref + ">"; }
    public String toId() { return tag + "(" + ref + ")"; }
    public long getValue() { return ref; }
}

class ErlPort extends ErlTerm {
    private long id;

    public ErlPort() {
        super("port", 5);
    }
    public String toString() { return "#Port<" + id + ">"; }
    public String toId() { return tag + "(" + id + ")"; }
    public long getValue() { return id; }
}
