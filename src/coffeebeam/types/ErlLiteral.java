package coffeebeam.types;

import coffeebeam.beam.BeamFile;

public class ErlLiteral extends ErlTerm {
    private BeamFile beamfile;
    private int value;
    public ErlLiteral(BeamFile bf, int v) {
        super("literal", 0);
        value = v;
        beamfile = bf;
        reference = true;
    }
    public ErlTerm getValue() { return beamfile.getLiteral(value); }
    public String toString() { return getValue().toString(); }
    public String toId() { return tag + "(" + getValue().toId() + ")"; }
}
