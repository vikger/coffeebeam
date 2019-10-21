package coffeebeam.types;

import java.util.ArrayList;

public class ErlBigNum extends ErlNumber {
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
