package coffeebeam.beam;

import java.io.IOException;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.Arrays;
import java.util.zip.InflaterInputStream;
import java.util.ArrayList;
import coffeebeam.types.*;

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
        BeamDebug.debug("version: " + codeversion +
                       ", maxopcode: " + maxopcode +
                       ", labels: " + labelcount +
                       ", functions: " + funcount);
        int opcode;
        while ((opcode = br.readByte()) != -1) {
            int arity = OpCode.arity(opcode);
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

        InflaterInputStream iis = new InflaterInputStream(br.getStream());
        byte[] uncompressed = new byte[uncompressedSize];
        iis.read(uncompressed);
        br = new ByteReader(new ByteArrayInputStream(uncompressed));
        int count = (int) br.read32BitUnsigned();
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
            BeamDebug.debug("Atom(" + i + "): " + atoms.get(i));
        }
    }

    private void printLiterals() {
        for (int i = 0; i < literals.size(); i++) {
            BeamDebug.debug("Literal(" + i + "): " + literals.get(i).toString());
        }
    }

    private void printImports() {
        for (int i = 0; i < imports.size(); i++) {
            Import imp = imports.get(i);
            BeamDebug.debug("Import(" + i + "): [atom " + imp.getModule() + "]:[atom " + imp.getFunction() + "] / " + imp.getArity());
        }
    }

    private void printExports() {
        for (int i = 0; i < exports.size(); i++) {
            Export exp = exports.get(i);
            BeamDebug.debug("Export(" + i + "): [atom " + exp.getFunction() + "] / " + exp.getArity() + " - label " + exp.getLabel());
        }
    }

    private void printLocalFunctions() {
        for (int i = 0; i < localFunctions.size(); i++) {
            ErlFun loc = localFunctions.get(i);
            BeamDebug.debug("LocalFunction(" + i + "): " + loc.toString());
        }
    }

    private void printCodeTable() {
        for (int i = 0; i < codeTable.size(); i++) {
            ErlOp erlop = codeTable.get(i);
            BeamDebug.debug("-- " + OpCode.name(erlop.opcode) + " / " + OpCode.arity(erlop.opcode));
            for (int j = 0; j < erlop.args.size(); j++) {
                ErlTerm arg = erlop.args.get(j);
                BeamDebug.debug("---- " + arg.toString());
            }
        }
    }

    public void printLabelRefs() {
        for (int i = 0; i < labelRefs.size(); i++) {
            BeamDebug.debug("labelRefs " + i + " -> " + labelRefs.get(i));
        }
    }

    public void printAttributes() {
        BeamDebug.debug("Attributes: " + attributes.toString());
    }

    public void printStrTable() {
	BeamDebug.debug("StrTable: " + strTable.toString());
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

class ExternalTerm {
    static ByteReader br;

    public static ErlTerm read(ByteReader _br) throws IOException {
        int b;
        br = _br;
        switch (b = br.readByte()) {
        case 131: // external term format
            return read_term();
        default:
            BeamDebug.error("UNKNOWN term code " + b);
            return null;
        }
    }

    private static ErlTerm read_term() throws IOException {
        int tag = br.readByte();
        switch (tag) {
        case 82: // atom_cache_ref
            int index = br.readByte();
            BeamDebug.warning("ATOM_CACHE_REF: " + index);
            break;
        case 97: // small integer
            int smallint = br.readByte();
            return new ErlInt(smallint);
        case 98: // integer
            long biginteger = br.read32BitUnsigned();
            BeamDebug.warning("INTEGER_EXT: " + biginteger);
            break;
        case 99: // FLOAT_EXT
            byte[] floatstr = br.readBytes(31);
            BeamDebug.warning("FLOAT_EXT: " + new String(floatstr));
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
            return new ErlList(new String(br.readBytes(length)));
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
            BeamDebug.debug("other " + tag);
            BeamDebug.debug(" " + br.readByte());
            break;
        }
        BeamDebug.warning("UNKNOWN ext_term " + tag);
        return new GenericErlTerm(tag);
    }
}

class InternalTerm {
    public static ErlTerm read(ByteReader br, BeamFile bf) throws IOException {
        String[] tags = {"literal", "integer", "atom", "X register", "Y register", "label", "character", "extended - "};
        int b = br.readByte();
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
                    BeamDebug.warning("skipped [" + BeamDebug.dec_to_bin(br.readByte()) + "] ");
                BeamDebug.warning("skipped(" + following_bytes + ") ");
            } else { // 1 continuation byte
                int cont1 = br.readByte();
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
        BeamDebug.warning("Generic " + tagname + " " + BeamDebug.dec_to_bin(value));
        return new GenericErlTerm(value);
    }
}

