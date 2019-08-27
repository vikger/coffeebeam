import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.charset.Charset;

public class BeamReader {
    private final Charset UTF8_CHARSET = Charset.forName("UTF-8");
    private final Charset ASCII_CHARSET = Charset.forName("US-ASCII");
    private final Charset LATIN1_CHARSET = Charset.forName("ISO-8859-1");

    private BeamFile beamfile = null;
    private FileInputStream file = null;

    public BeamReader(String filename) {
	try {
	    file = new FileInputStream(filename);
	} catch (Exception e) {}
	beamfile = new BeamFile();
    }

    public static int unsignedToBytes(byte b) {
	return b & 0xFF;
    }

    public String read4ByteString() throws IOException {
	byte[] bytes = new byte[4];
	file.read(bytes);
	return new String(bytes, ASCII_CHARSET);
    }

    public boolean readFOR1() throws IOException {
	String for1string = read4ByteString();
	return for1string.equals("FOR1");
    }

    public long read32BitUnsigned() throws IOException {
	byte[] b = new byte[4];
	file.read(b);
	return (b[0] & 0xFF) << 24 |
	    (b[1] & 0xFF) << 16 |
	    (b[2] & 0xFF) << 8 |
	    (b[3] & 0xFF);
    }

    public long readFileLength() throws IOException {
	return read32BitUnsigned();
    }

    public byte[] readBytes(int length) throws IOException {
	byte[] bytes = new byte[length];
	file.read(bytes);
	return bytes;
    }
    public boolean readBEAM() throws IOException {
	String beamstring = read4ByteString();
	return beamstring.equals("BEAM");
    }

    public void readChunk() throws IOException {
	String chunkname = read4ByteString();
	System.out.println(chunkname);
	long chunklength = read32BitUnsigned();
	System.out.println(Long.toString(chunklength));
	switch (chunkname) {
	case "Atom":
	case "AtU8":
	    new Atom(readBytes((int) chunklength));
	    break;
        case "Code":
            System.out.println("----Code");
            new Code(readBytes((int) chunklength));
            break;
        case "LitT":
            System.out.println("----LitT");
            new LitT(readBytes((int) chunklength));
            break;
	default:
	    readBytes((int) chunklength);
	    break;
	}
	readPadding(chunklength);
    }

    public void readPadding(long length) throws IOException {
	int padding = 0;

	switch ((int) length % 4) {
	case 0: padding = 0; break;
	case 1: padding = 3; break;
	case 2: padding = 2; break;
	case 3: padding = 1; break;
	}
	readBytes(padding);
    }

    public int available() throws IOException {
	return file.available();
    }

    public BeamFile read() throws IOException, BeamFormatException {
	if (!readFOR1())
	    throw new BeamFormatException();
	readFileLength();
	if (!readBEAM())
	    throw new BeamFormatException();
	while (available() != 0)
	    readChunk();
	return beamfile;
    }

    public static void main(String[] args) {
	try {
	    BeamReader br = new BeamReader("example.beam");
	    BeamFile bf = br.read();
	} catch (Exception e) {}
    }
}
