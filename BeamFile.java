import java.io.IOException;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.Arrays;
import java.util.zip.InflaterInputStream;

public class BeamFile {

}

class BeamObject extends ByteReader {
    public BeamObject(InputStream s) {
	super(s);
    }
    public void print() {}
}

class ByteReader {
    InputStream stream;

    public ByteReader(InputStream s) {
	stream = s;
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

class Atom extends BeamObject {
    public Atom(InputStream s) throws IOException {
	super(s);
	long count = read32BitUnsigned();
	for (int i = 0; i < count; i++) {
	    int length = readByte();
	    System.out.println("[atom " + (i+1) + "] " + new String(readBytes(length)));
	}
    }
}

class Code extends BeamObject {
    public Code(InputStream s) throws IOException {
	super(s);
        long subsize = read32BitUnsigned();
        long codeversion = read32BitUnsigned();
        long maxopcode = read32BitUnsigned();
        long labelcount = read32BitUnsigned();
        long funcount = read32BitUnsigned();
        System.out.println("version: " + codeversion +
                           ", maxopcode: " + maxopcode +
                           ", labels: " + labelcount +
                           ", functions: " + funcount);
        int opcode;
        while ((opcode = readByte()) != -1) {
            int arity = OpCode.arity(opcode);
            System.out.println("-- " + OpCode.name(opcode) + " / " + arity);
            for (int j = 0; j < arity; j++) {
                new InternalTerm(stream);
            }
        }
    }
}

class LitT extends BeamObject {
    public LitT(InputStream s) throws IOException {
	super(s);
	int uncompressedSize = (int) read32BitUnsigned();
        System.out.println(uncompressedSize);

        InflaterInputStream iis = new InflaterInputStream(stream);
        byte[] uncompressed = new byte[uncompressedSize];
        iis.read(uncompressed);
        stream = new ByteArrayInputStream(uncompressed);
        int count = (int) read32BitUnsigned();
        System.out.println("Count: " + Integer.toString(count));
        for (int i = 0; i < count; i++) {
            int size = (int) read32BitUnsigned();
            new Term(stream);
        }
    }
}

class ImpT extends BeamObject {
    public ImpT(InputStream s) throws IOException {
        super(s);
        int count = (int) read32BitUnsigned();
        for (int i = 0; i < count; i++) {
            int module = (int) read32BitUnsigned();
            int function = (int) read32BitUnsigned();
            int arity = (int) read32BitUnsigned();
            System.out.println("[atom " + module + "] [atom " + function + "] / " + arity);
        }
    }
}

class ExpT extends BeamObject {
    public ExpT(InputStream s) throws IOException {
        super(s);
        int count = (int) read32BitUnsigned();
        for (int i = 0; i < count; i++) {
            int name = (int) read32BitUnsigned();
            int arity = (int) read32BitUnsigned();
            int label = (int) read32BitUnsigned();
            System.out.println("[atom " + name + "] / " + arity + ", label: " + label);
        }
    }
}

class LocT extends BeamObject {
    public LocT(InputStream s) throws IOException {
        super(s);
        int count = (int) read32BitUnsigned();
        for (int i = 0; i < count; i++) {
            int function = (int) read32BitUnsigned();
            int arity = (int) read32BitUnsigned();
            int location = (int) read32BitUnsigned();
            System.out.println("[atom " + function + "] / " + arity + ", label: " + location);
        }
    }
}

class Attr extends BeamObject {
    public Attr(InputStream s) throws IOException {
        super(s);
        new Term(stream);
    }
}

class Term extends BeamObject {
    public Term(InputStream stream) throws IOException {
        super(stream);
        int b;
        switch (b = readByte()) {
        case 131: // external term format
            read_term();
            break;
        default:
            System.out.println("UNKNOWN term code " + b);
            break;
        }
    }

    private void read_term() throws IOException {
        int tag = readByte();
        switch (tag) {
        case 82: // atom_cache_ref
            int index = readByte();
            System.out.println("ATOM_CACHE_REF: " + index);
            break;
        case 97: // small integer
            int smallint = readByte();
            System.out.println("SMALL_INTEGER_EXT: " + smallint);
            break;
        case 98: // integer
            long biginteger = read32BitUnsigned();
            System.out.println("INTEGER_EXT: " + biginteger);
            break;
        case 99: // FLOAT_EXT
            byte[] floatstr = readBytes(31);
            System.out.println("FLOAT_EXT: " + new String(floatstr));
            break;
        case 100: // ATOM_EXT
            int atom_length = read16BitUnsigned();
            byte[] atom_name = readBytes(atom_length);
            System.out.println("ATOM: " + new String(atom_name));
            break;
        case 104: // SMALL_TUPLE_EXT
            int small_tuple_arity = readByte();
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
            int length = read16BitUnsigned();
            System.out.println("STRING_EXT: " + new String(readBytes(length)));
            break;
        case 108: // LIST_EXT
            long list_length = read32BitUnsigned();
            System.out.print("LIST_EXT(" + list_length + "): ");
            for (long i = 0; i < list_length; i++) {
                read_term();
            }
            read_term(); // tail
            System.out.println("end LIST_EXT");
            break;
        case 109: // BINARY_EXT
            long binary_length = read32BitUnsigned();
            System.out.println("BINARY_EXT(" + binary_length + "): ");
            for (long j = 0; j < binary_length; j++) {
                System.out.println(readByte() + " ");
            }
        case 110: // SMALL_BIG_EXT
            int sb_length = readByte();
            int sign  = readByte();
            System.out.print("SMALL_BIG_EXT: ");
            for (int i = 0; i < sb_length; i++) {
                System.out.print(readByte() + " ");
                // TODO: calculate bignum
            }
            break;
        default:
            System.out.println("other " + tag);
            System.out.println(" " + readByte());
            break;
        }
    }
}

class InternalTerm extends BeamObject {
    private String[] tags = {"literal", "integer", "atom", "X register", "Y register", "label", "character", "extended - "};
    public InternalTerm(InputStream stream) throws IOException {
        super(stream);
        int b = readByte();
        System.out.print("---- [" + dec_to_bin(b) + "] ");
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
                    readByte();
                System.out.print("skipped(" + following_bytes + ") ");
            } else { // 1 continuation byte
                int cont1 = readByte();
                System.out.print("[" + dec_to_bin(cont1) + "] ");
                value = ((b & 0xE0) << 3) + cont1;
            }
        } else { // bit 3 is 0, no continuation
            if (extended) {
                value = readByte();
                System.out.print("[" + dec_to_bin(value) + "] ");
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
    public static String dec_to_bin(int b) {
        String result = "";
        for (int i = 0; i < 8; i++) {
            result = Integer.toString((b & (1 << i)) >> i) + result;
        }
        return result;
    }
}
