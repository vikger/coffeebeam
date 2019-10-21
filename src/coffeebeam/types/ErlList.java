package coffeebeam.types;

public class ErlList extends ErlTerm {
    public ErlTerm head = null;
    public ErlTerm tail = null;
    boolean nil = true;

    public ErlList() {
        super("list", 9);
    }
    public ErlList(ErlTerm hd, ErlTerm tl) {
        super("list", 9);
        nil = false;
        head = hd;
        tail = tl;
    }
    public ErlList(String s) {
        super("list", 9);
        while (!s.isEmpty()) {
            add(new ErlInt((int) s.charAt(0)));
            s = s.substring(1);
        }
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
        return toPrintable("\"", "[");
    }
    private String toPrintable(String p, String nonp) {
        if (tail instanceof ErlList) {
            ErlList t = (ErlList) tail;
            if (t.isNil()) {
                if (isPrintable(head))
                    return p + String.valueOf((char) ((ErlInt) head).getValue()) + "\"";
                else
                    return nonp + head.toString() + "]";
            } else {
                if (isPrintable(head))
                    return t.toPrintable(p + String.valueOf((char) ((ErlInt) head).getValue()), nonp + head.toString() + ", ");
                else
                    return t.toNonPrintable(nonp + head.toString() + ", ");
            }
        }
        return nonp + head.toString() + " | " + tail.toString() + "]";
    }
    private String toNonPrintable(String nonp) {
        if (tail instanceof ErlList) {
            ErlList t = (ErlList) tail;
            if (t.isNil()) {
                return nonp + head.toString() + "]";
            } else {
                return t.toNonPrintable(nonp + head.toString() + ", ");
            }
        } else {
            return nonp + head.toString() + " | " + tail.toString() + "]";
        }
    }
    private String toStringValues() {
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
    private boolean isPrintable(ErlTerm item) {
        if (item instanceof ErlInt) {
            int c = ((ErlInt) item).getValue();
            return (/*(c >= 8 && c <= 13) || (c == 27) || */(c >= 32 && c <= 126)/* || (c >= 160 && c <= 255)*/);
        }
        return false;
    }
    public String toId() {
        if (isNil()) return "nil";
        else return tag + "(" + head.toId() + "," + tail.toId() + ")";
    }
    public int size() {
        if (isNil()) return 0;
        else if (tail instanceof ErlList) return 1 + ((ErlList) tail).size();
        else return -1;
    }
}
