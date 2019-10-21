package coffeebeam.types;

import coffeebeam.beam.BeamFile;

public class ErlAtom extends ErlTerm {
    private int index;
    private String value;
    private BeamFile beamfile;

    public ErlAtom(String v) {
        super("atom", 2);
        value = v;
    }
    public ErlAtom(BeamFile bf, int i) {
        super("atom", 2);
        index = i;
        reference = true;
        beamfile = bf;
    }
    public ErlAtom(boolean b) {
        super("atom", 2);
        if (b) value = "true";
        else value = "false";
    }
    public String toString() {
        String s = getValue();
        if (s.equals(""))
            return "''";
        char c = s.charAt(0);
        if (c >= 'a' && c <= 'z')
            return toSimple(s.substring(1), String.valueOf(c));
        return toQuoted(s.substring(1), String.valueOf(c));
    }
    private String toSimple(String s, String output) {
        if (s.equals("")) return output;
        char c = s.charAt(0);
        if (ErlTerm.isAtomSubChar(c))
            return toSimple(s.substring(1), output + String.valueOf(c));
        return toQuoted(s.substring(1), output + String.valueOf(c));
    }
    private String toQuoted(String s, String output) {
        if (s.equals("")) return "'" + output + "'";
        char c = s.charAt(0);
        return toQuoted(s.substring(1), output + String.valueOf(c));
    }
    public String toId() { return tag + "(" + getValue() + ")"; }
    public int getIndex() { return index; }
    public String getValue() {
        if (reference) return beamfile.getAtomName(index);
        return value;
    }
}
