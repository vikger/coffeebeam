package coffeebeam.types;

import coffeebeam.erts.ErlBif;
import java.util.ArrayList;

public class ErlMap extends ErlTerm {
    private ArrayList<ErlTerm> keys;
    private ArrayList<ErlTerm> values;

    public ErlMap() {
        super("map", 8);
        keys = new ArrayList<ErlTerm>();
        values = new ArrayList<ErlTerm>();
    }
    public int size() { return keys.size(); }
    public void add(ErlTerm key, ErlTerm value) {
        keys.add(key);
        values.add(value);
    }
    public ErlTerm get(ErlTerm key) {
        for (int i = 0; i < keys.size(); i++) {
            if (keys.get(i).toId().equals(key.toId())) {
                return values.get(i);
            }
        }
        return null;
    }
    public ErlTerm getKey(int n) {
        for (int i = 0; i < keys.size(); i++) {
            if (getKeyOrder(keys.get(i)) == n)
                return keys.get(i);
        }
        return null;
    }

    private int getKeyOrder(ErlTerm key) {
        int order = 0;
        for (int i = 0; i < keys.size(); i++) {
            if (ErlBif.compare(keys.get(i), key) == -1) order++;
        }
        return order;
    }

    public String toString() {
        String str = "#{";
        for (int i = 0; i < keys.size(); i++) {
            if (i == 0) str += keys.get(i).toString() + " => " + values.get(i).toString();
            else str += ", " + keys.get(i).toString() + " => " + values.get(i).toString();
        }
        str += "}";
        return str;
    }
    public String toId() {
        String str = tag + "(";
        for (int i = 0; i < keys.size(); i++) {
            if (i == 0) str += "(" + keys.get(i).toString() + "," + values.get(i).toString() + ")";
            else str += ",(" + keys.get(i).toString() + "," + values.get(i).toString() + ")";
        }
        str += ")";
        return str;
    }
}
