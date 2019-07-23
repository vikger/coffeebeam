import java.io.IOException;
import java.io.ByteArrayInputStream;

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

class AtU8 extends BeamObject {
    public AtU8(byte[] bytes) throws IOException {
	super(bytes);
	long count = read32BitUnsigned();
	for (int i = 0; i < count; i++) {
	    int length = readByte();
	    System.out.println(new String(readBytes(length)));
	}
    }
}
