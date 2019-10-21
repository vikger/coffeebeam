package coffeebeam.types;

import coffeebeam.beam.BeamFile;

public class ErlFun extends ErlTerm {
    ErlAtom name;
    int arity;
    ErlLabel label;
    private BeamFile beamfile;
    public ErlFun(BeamFile bf, int f, int a, int l) {
        super("fun", 4);
        name = new ErlAtom(bf, f);
        arity = a;
        label = new ErlLabel(l);
        beamfile = bf;
    }

    public ErlAtom getName() { return name; }
    public int getArity() { return arity; }
    public ErlLabel getLabel() { return label; }
    public String toString() { return name.toString() + " / " + arity + " -> label(" + label.getValue() + ")"; }
    public String toId() { return tag + "(" + name + "," + arity + "," + label + ")"; }
    public BeamFile getModule() { return beamfile; }
}
