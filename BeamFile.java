import java.io.IOException;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.Arrays;
import java.util.zip.InflaterInputStream;
import java.util.ArrayList;

public class BeamFile {
    private String filename;
    private ArrayList<String> atoms;
    private ArrayList<ExternalTerm> literals;
    private ArrayList<Import> imports;
    private ArrayList<Export> exports;
    private ArrayList<LocalFunction> localFunctions;

    private BeamFile() {}
    public BeamFile(String fn) {
        filename = fn;
        atoms = new ArrayList<String>();
        literals = new ArrayList<ExternalTerm>();
        imports = new ArrayList<Import>();
        exports = new ArrayList<Export>();
        localFunctions = new ArrayList<LocalFunction>();
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
            System.out.println("-- " + OpCode.name(opcode) + " / " + arity);
            for (int j = 0; j < arity; j++) {
                new InternalTerm(br.getStream());
            }
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
            // TODO: replace with final Term class
            literals.add(new ExternalTerm(br.getStream()));
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

    public void dump() {
        printAtoms();
        //printLiterals();
        printImports();
        printExports();
        printLocalFunctions();
    }

    private void printAtoms() {
        for (int i = 0; i < atoms.size(); i++) {
            System.out.println("Atom(" + i + "): " + atoms.get(i));
        }
    }

    private void printLiterals() {
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

class Attr {
    public Attr(ByteReader br) throws IOException {
        new ExternalTerm(br.getStream());
    }
}

class ExternalTerm {
    ByteReader br;
    public ExternalTerm(InputStream s) throws IOException {
        int b;
        br = new ByteReader(s);
        switch (b = br.readByte()) {
        case 131: // external term format
            read_term();
            break;
        default:
            System.out.println("UNKNOWN term code " + b);
            break;
        }
    }

    private void read_term() throws IOException {
        int tag = br.readByte();
        switch (tag) {
        case 82: // atom_cache_ref
            int index = br.readByte();
            System.out.println("ATOM_CACHE_REF: " + index);
            break;
        case 97: // small integer
            int smallint = br.readByte();
            System.out.println("SMALL_INTEGER_EXT: " + smallint);
            break;
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
            System.out.println("ATOM: " + new String(atom_name));
            break;
        case 104: // SMALL_TUPLE_EXT
            int small_tuple_arity = br.readByte();
            System.out.print("SMALL_TUPLE_EXT(" + small_tuple_arity + "): ");
            for (int i = 0; i < small_tuple_arity; i++) {
                read_term();
            }
            System.out.println("end SMALL_TUPLE_EXT");
            break;
        case 106: // NIL_EXT
            System.out.println("NIL_EXT");
            break;
        case 107: // STRING_EXT
            int length = br.read16BitUnsigned();
            System.out.println("STRING_EXT: " + new String(br.readBytes(length)));
            break;
        case 108: // LIST_EXT
            long list_length = br.read32BitUnsigned();
            System.out.print("LIST_EXT(" + list_length + "): ");
            for (long i = 0; i < list_length; i++) {
                read_term();
            }
            read_term(); // tail
            System.out.println("end LIST_EXT");
            break;
        case 109: // BINARY_EXT
            long binary_length = br.read32BitUnsigned();
            System.out.println("BINARY_EXT(" + binary_length + "): ");
            for (long j = 0; j < binary_length; j++) {
                System.out.println(br.readByte() + " ");
            }
        case 110: // SMALL_BIG_EXT
            int sb_length = br.readByte();
            int sign  = br.readByte();
            System.out.print("SMALL_BIG_EXT: ");
            for (int i = 0; i < sb_length; i++) {
                System.out.print(br.readByte() + " ");
                // TODO: calculate bignum
            }
            break;
        default:
            System.out.println("other " + tag);
            System.out.println(" " + br.readByte());
            break;
        }
    }
}

class InternalTerm {
    private String[] tags = {"literal", "integer", "atom", "X register", "Y register", "label", "character", "extended - "};
    public InternalTerm(InputStream stream) throws IOException {
        ByteReader br = new ByteReader(stream);
        int b = br.readByte();
        System.out.print("---- [" + BeamDebug.dec_to_bin(b) + "] ");
        // read tag
        String tag = null;
        int value = -1234;
        boolean extended = false;

        // read tag
        tag = tags[b & 0x07];
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
                System.out.print("[" + BeamDebug.dec_to_bin(cont1) + "] ");
                value = ((b & 0xE0) << 3) + cont1;
            }
        } else { // bit 3 is 0, no continuation
            if (extended) {
                value = br.readByte();
                System.out.print("[" + BeamDebug.dec_to_bin(value) + "] ");
                switch ((b & 0xF0) >> 4) {
                case 1: // list
                    tag += "list";
                    int list_size = value >> 4;
                    tag += "(" + list_size + ")";
                    for (int i = 0; i < list_size; i++) {
                        System.out.print("list[" + (i+1) + "]: ");
                        new InternalTerm(stream); // item
                    }
                    System.out.print("list end - ");
                    break;
                case 2: // floating point register
                    tag += "floating point register";
                    break;
                case 3: // allocation list
                    tag += "allocation list";
                    break;
                case 4: // literal
                    tag += "literal";
                    break;
                }
            } else {
                value = (b & 0xF0) >> 4;
            }
        }
        System.out.println(tag + " " + value);
    }
}
