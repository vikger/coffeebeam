import java.io.IOException;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.Arrays;
import java.util.zip.InflaterInputStream;
import java.util.ArrayList;

public class BeamFile {
    private String filename;
    private ArrayList<String> atoms;
    private ArrayList<ErlTerm> literals;
    private ArrayList<Import> imports;
    private ArrayList<Export> exports;
    private ArrayList<LocalFunction> localFunctions;
    private ArrayList<ErlOp> codeTable;
    private ArrayList<Integer> labelRefs;
    private ErlTerm attributes;

    private BeamFile() {}
    public BeamFile(String fn) {
        filename = fn;
        atoms = new ArrayList<String>();
        literals = new ArrayList<ErlTerm>();
        imports = new ArrayList<Import>();
        exports = new ArrayList<Export>();
        localFunctions = new ArrayList<LocalFunction>();
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
        System.out.println(uncompressedSize);

        InflaterInputStream iis = new InflaterInputStream(br.getStream());
        byte[] uncompressed = new byte[uncompressedSize];
        iis.read(uncompressed);
        br = new ByteReader(new ByteArrayInputStream(uncompressed));
        int count = (int) br.read32BitUnsigned();
        System.out.println("Count: " + count);
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
            localFunctions.add(new LocalFunction(function - 1, arity, label));
        }
    }

    public void readAttributes(ByteReader br) throws IOException {
        attributes = ExternalTerm.read(br);
    }

    public void dump() {
        printAtoms();
        printLiterals();
        printImports();
        printExports();
        printLocalFunctions();
        printCodeTable();
        //printLabelRefs();
        //printAttributes();
    }

    private void printAtoms() {
        for (int i = 0; i < atoms.size(); i++) {
            System.out.println("Atom(" + i + "): " + atoms.get(i));
        }
    }

    private void printLiterals() {
        for (int i = 0; i < literals.size(); i++) {
            System.out.println("Literal(" + i + "): " + literals.get(i).toString());
        }
    }

    private void printImports() {
        for (int i = 0; i < imports.size(); i++) {
            Import imp = imports.get(i);
            System.out.println("Import(" + i + "): [atom " + imp.getModule() + "]:[atom " + imp.getFunction() + "] / " + imp.getArity());
        }
    }

    private void printExports() {
        for (int i = 0; i < exports.size(); i++) {
            Export exp = exports.get(i);
            System.out.println("Export(" + i + "): [atom " + exp.getFunction() + "] / " + exp.getArity() + " - label " + exp.getLabel());
        }
    }

    private void printLocalFunctions() {
        for (int i = 0; i < localFunctions.size(); i++) {
            LocalFunction loc = localFunctions.get(i);
            System.out.println("LocalFunction(" + i + "): [atom " + loc.getFunction() + "] / " + loc.getArity() + " - label " + loc.getLabel());
        }
    }

    private void printCodeTable() {
        for (int i = 0; i < codeTable.size(); i++) {
            ErlOp erlop = codeTable.get(i);
            System.out.println("-- " + OpCode.name(erlop.opcode) + " / " + OpCode.arity(erlop.opcode));
            for (int j = 0; j < erlop.args.size(); j++) {
                ErlTerm arg = erlop.args.get(j);
                System.out.println("---- " + arg.toString());
            }
        }
    }

    public void printLabelRefs() {
        for (int i = 0; i < labelRefs.size(); i++) {
            System.out.println("labelRefs " + i + " -> " + labelRefs.get(i));
        }
    }

    public void printAttributes() {
        System.out.println("Attributes: " + attributes.toString());
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

class LocalFunction {
    int function, arity, label;
    public LocalFunction(int f, int a, int l) {
        function = f;
        arity = a;
        label = l;
    }

    public int getFunction() { return function; }
    public int getArity() { return arity; }
    public int getLabel() { return label; }
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
    private ErlTerm() {}
    public ErlTerm(String t) { tag = t; }
    public abstract String toString();
    public abstract String toId();
    public String getTag() { return tag; }
    public boolean isReference() { return reference; }
}

class GenericErlTerm extends ErlTerm {
    int value;
    public GenericErlTerm(int v) {
        super("generic");
        value = v;
    }

    public boolean isReference() { return false; }

    public String toString() { return "term(" + getTag() + "): " + value; }
    public String toId() { return tag + "(" + value + ")"; }
}

abstract class ErlNumber extends ErlTerm {
    public ErlNumber(String tag) {
        super(tag);
    }
}

class ErlInt extends ErlNumber {
    int value;

    public ErlInt(int v) {
        super("integer");
        value = v;
    }
    public String toString() { return "i(" + value + ")"; }

    public String toId() { return tag + "(" + value + ")"; }

    public int getValue() { return value; }
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

    public long getValue() {
        long value = 0;
        for (int i = 0; i < segments.size(); i++) {
            value += segments.get(i) * (1 << (8 * i));
        }
        if (!positive) value = -value;
        return value;
    }

    public String toString() {
        return Long.toString(getValue()); // TODO: fix
    }

    public String toId() {
        return tag + "(" + Long.toString(getValue()) + ")"; // TODO: fix
    }
}

class ErlAtom extends ErlTerm {
    private int index;
    private String value;
    private BeamFile beamfile;

    public ErlAtom(String v) {
        super("atom");
        value = v;
    }
    public ErlAtom(BeamFile bf, int i) {
        super("atom");
        index = i;
        reference = true;
        beamfile = bf;
    }
    public String toString() {
        if (reference) return getValue();
        else return value;
    }
    public String toId() { return tag + "(" + value + ")"; }
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
        super("list");
    }
    public ErlList(ErlTerm hd, ErlTerm tl) {
        super("list");
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
        else return "[" + toStringValues();
    }
    public String toStringValues() {
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
    public String toId() {
        if (isNil()) return "nil";
        else return tag + "(" + head.toId() + "," + tail.toId() + ")";
    }
}

class ErlTuple extends ErlTerm {
    ArrayList<ErlTerm> elements;

    public ErlTuple() {
        super("tuple");
        elements = new ArrayList<ErlTerm>();
    }
    public ErlTerm get(int i) {
        return elements.get(i);
    }
    public void add(ErlTerm element) {
        elements.add(element);
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
}

class ErlLiteral extends ErlTerm {
    private BeamFile beamfile;
    private int value;
    public ErlLiteral(BeamFile bf, int v) {
        super("literal");
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
        super("label");
        value = v;
        reference = true;
    }
    public int getValue() { return value; }
    public String toString() { return "label(" + value + ")"; }
    public String toId() { return tag + "(" + value + ")"; }
}

class ErlString extends ErlTerm {
    private String value;
    public ErlString(String v) { super("string"); value = v; }
    public String toString() { return "\"" + value + "\""; }
    public String toId() { return tag + "(" + value + ")"; }
}

class ErlException extends ErlTerm {
    private String value;
    public ErlException(String v) { super("exception"); value = v; }
    public String toString() { return "** exception: " + value; }
    public String toId() { return tag + "(" + value + ")"; }
}

class Xregister extends ErlTerm {
    private int index;
    public Xregister(int i) {
        super("Xregister");
        index = i;
    }
    public String toString() { return "X(" + index + ")"; }
    public String toId() { return tag + "(" + index + ")"; }
    public int getIndex() { return index; }
}

class Yregister extends ErlTerm {
    private int index;
    public Yregister(int i) {
        super("Yregister");
        index = i;
    }
    public String toString() { return "Y(" + index + ")"; }
    public String toId() { return tag + "(" + index + ")"; }
    public int getIndex() { return index; }
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
            return new ErlString(new String(br.readBytes(length)));
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
            System.out.println("BINARY_EXT(" + binary_length + "): ");
            for (long j = 0; j < binary_length; j++) {
                System.out.println(br.readByte() + " ");
            }
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
            if ((b & 0x10) != 0) { // 2..8 continuation bytes
                int following_bytes = (b & 0xE0) >> 5;
                for (int i = 0; 9 < following_bytes; i++)
                    br.readByte();
                System.out.print("skipped(" + following_bytes + ") ");
            } else { // 1 continuation byte
                int cont1 = br.readByte();
                // System.out.print("[" + BeamDebug.dec_to_bin(cont1) + "] ");
                value = ((b & 0xE0) << 3) + cont1;
                switch (tag) {
                case 0: return new ErlInt(value);
                case 1: return new ErlInt(value);
                case 2: if (value == 0) return new ErlList(); else return new ErlAtom(bf, value - 1);
                case 3: return new Xregister(value);
                case 4: return new Yregister(value);
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
                    tagname += "floating point register";
                    break;
                case 3: // allocation list
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
                case 3: return new Xregister(value);
                case 4: return new Yregister(value);
                case 5: return new ErlLabel(value);
                case 6: return new ErlInt(value); // TODO: character type?
                }
            }
        }
        System.out.println("Generic " + tagname + " " + value);
        return new GenericErlTerm(value);
    }
}
