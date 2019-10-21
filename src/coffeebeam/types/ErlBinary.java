package coffeebeam.types;

import java.util.ArrayList;

public class ErlBinary extends ErlTerm {
    ArrayList<Integer> bytes;
    public int first = 0;
    public int next = 0;

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

    public void set(int index, int value) {
        bytes.set(index, value);
    }

    public int getBit() {
	int b = bytes.get(0);
	int bit = (b & (1 << (7 - first))) >> (7 - first);
	first++;
	if (first == 8) {
	    bytes.remove(0);
	    first = 0;
	}
	return bit;
    }

    public void putBit(int bit) {
        int b;
        if (next == 0) {
            bytes.add(0);
            b = 0;
        } else
            b = bytes.get(bytes.size() - 1);
        b |= bit << (7 - next);
        bytes.set(bytes.size() - 1, b);
        next = (next + 1) % 8;
    }

    public int getInteger(int length) {
	int result = 0;
	while (length > 0) {
	    result = (result << 1) + getBit();
	    length--;
	}
	return result;
    }

    public void putInteger(int value, int length) {
        while (length > 0) {
            putBit((value >> (length - 1)) & 1);
            length--;
        }
    }

    public int startMatch() {
	return first;
    }

    public int getPosition() {
	return first;
    }

    public int bitSize() {
        int lastdiff = (8 - next) % 8;
	return 8 * bytes.size() - first - lastdiff;
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
