import java.io.IOException;
import java.io.ByteArrayInputStream;
import java.util.Arrays;
import java.util.zip.InflaterInputStream;

public class BeamFile {

}

class BeamObject extends ByteReader {
    public BeamObject(byte[] bytes) {
	super(bytes);
    }
    public void print() {}
}

class ByteReader {
    ByteArrayInputStream stream;

    public ByteReader(byte[] bytes) {
	stream = new ByteArrayInputStream(bytes);
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
    public Atom(byte[] bytes) throws IOException {
	super(bytes);
	long count = read32BitUnsigned();
	for (int i = 0; i < count; i++) {
	    int length = readByte();
	    System.out.println(new String(readBytes(length)));
	}
    }
}

class Code extends BeamObject {
    public Code(byte[] bytes) throws IOException {
	super(bytes);
        long subsize = read32BitUnsigned();
        long codeversion = read32BitUnsigned();
        long maxopcode = read32BitUnsigned();
        long labelcount = read32BitUnsigned();
        long funcount = read32BitUnsigned();
        System.out.println(codeversion);
        System.out.println(maxopcode);
        System.out.println(labelcount);
        System.out.println(funcount);
        int opcode = readByte();
        System.out.print("opcode ");
        System.out.println(opcode);
        System.out.print("arity ");
        System.out.println(OpCode.arity(opcode));
    }
}

class LitT extends BeamObject {
    public LitT(byte[] bytes) throws IOException {
	super(bytes);
	int uncompressedSize = (int) read32BitUnsigned();
        System.out.println(uncompressedSize);

        InflaterInputStream iis = new InflaterInputStream(stream);
        byte[] uncompressed = new byte[uncompressedSize];
        iis.read(uncompressed);
        String result = new String(uncompressed);
        System.out.println("Decompress result: " + result);
    }
}
