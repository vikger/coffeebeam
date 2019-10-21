package coffeebeam.types;

class ErlString extends ErlTerm {
    private String value;
    public ErlString(String v) { super("string", 10); value = v; }
    public String toString() { return "\"" + value + "\""; }
    public String toId() { return tag + "(" + value + ")"; }
    public ErlList toList() {
        ErlList list = new ErlList();
        for (char c : value.toCharArray()) {
            list.add(new ErlInt((int) c));
        }
        return list;
    }
}
