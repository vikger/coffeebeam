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
            new Term(stream, size);
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

class Term extends BeamObject {
    public Term(InputStream stream, int len) throws IOException {
        super(stream);
        switch (readByte()) {
        case 131: // external term format
            int tag = readByte();
            System.out.println("Tag: " + tag);
            switch (tag) {
            case 107: // STRING_EXT
                int length = read16BitUnsigned();
                String string = new String(readBytes(length));
                System.out.println("STRING_EXT: " + string);
                break;
            default:
                System.out.print("Term bytes");
                for (int i = 0; i < len; i++) {
                    System.out.print(" " + Integer.toString(readByte()));
                }
                System.out.println();
                break;
            }
            break;
        }
    }
}

class InternalTerm extends BeamObject {
    public InternalTerm(InputStream stream) throws IOException {
        super(stream);
        int b = readByte();
        System.out.print("---- [" + dec_to_bin(b) + "] ");
        if ((b & 0x08) == 0) { // no continuation
            switch (b & 0x07) {
            case 0: // literal
                System.out.print("literal " + ((b & 0xF0) >> 4));
                break;
            case 1: // integer
                System.out.print("integer " + ((b & 0xF0) >> 4));
                break;
            case 2: // atom
                System.out.print("atom " + ((b & 0xF0) >> 4));
                break;
            case 3: // X register
                System.out.print("X register " + ((b & 0xF0) >> 4));
                break;
            case 4: // Y register
                System.out.print("Y register " + ((b & 0xF0) >> 4));
                break;
            case 5: // label
                System.out.print("label " + ((b & 0xF0) >> 4));
                break;
            case 6: // character
                System.out.print("character " + ((b & 0xF0) >> 4));
                break;
            case 7: // extended
                System.out.print("extended - ");
                int b2 = readByte();
                switch ((b & 0xF0) >> 4) {
                case 1: // list
                    System.out.print("list " + b2);
                case 2: // floating point register
                    System.out.print("floating point register " + b2);
                case 3: // allocation list
                    System.out.print("allocation list " + b2);
                case 4: // literal
                    System.out.print("literal " + b2);
                }
            }
        } else {
        }
        System.out.println();
    }
    private String dec_to_bin(int b) {
        String result = "";
        for (int i = 0; i < 8; i++) {
            result = Integer.toString((b & (1 << i)) >> i) + result;
        }
        return result;
    }
}
