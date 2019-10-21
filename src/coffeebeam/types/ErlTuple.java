package coffeebeam.types;

import java.util.ArrayList;

public class ErlTuple extends ErlTerm {
    ArrayList<ErlTerm> elements;
    int maxindex = -1;

    public ErlTuple() {
        super("tuple", 7);
        elements = new ArrayList<ErlTerm>();
    }
    public ErlTerm get(int i) {
        return elements.get(i);
    }
    public void add(ErlTerm element) {
        elements.add(element);
        maxindex++;
    }
    public String toString() {
        String str = "{";
        for (int i = 0; i < elements.size(); i++) {
            if (i == 0)
                str += elements.get(i).toString();
            else
                str += ", " + elements.get(i).toString();
        }
        str += "}";
        return str;
    }
    public String toId() {
        String id = tag + "(";
        for (int i = 0; i < elements.size(); i++) {
            if (i == 0)
                id += elements.get(i).toId();
            else
                id += "," + elements.get(i).toId();
        }
        id += ")";
        return id;
    }

    public int size() { return elements.size(); }
    public ErlTerm getElement(int index) { return elements.get(index); }
    public void setElement(int index, ErlTerm value) {
        while (index > maxindex) {
            elements.add(new ErlList()); // can be any ErlTerm instance
            maxindex++;
        }
        elements.set(index, value);
    }
}
