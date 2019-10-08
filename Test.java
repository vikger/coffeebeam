public class Test {
    private TestCase[] tests = {
        new TestCase("a", "test", new ErlTerm[]{new ErlAtom("a")}, new ErlAtom("ok")),
        new TestCase("a", "test", new ErlTerm[]{new ErlAtom("b")}, new ErlException("function_clause a:test(b)")),
        new TestCase("a", "list", new ErlTerm[]{}, new ErlList(new ErlAtom("a"), new ErlList(new ErlInt(1), new ErlList()))),
        new TestCase("lists", "append", new ErlTerm[]{new ErlList()}, new ErlList()),
        new TestCase("lists", "append", new ErlTerm[]{new ErlList(new ErlList(new ErlInt(1),
                                                                              new ErlList(new ErlInt(2),
                                                                                          new ErlList())),
                                                                  new ErlList(new ErlList(new ErlInt(3),
                                                                                          new ErlList()),
                                                                              new ErlList()))},
            new ErlList(new ErlInt(1),
                        new ErlList(new ErlInt(2),
                                    new ErlList(new ErlInt(3), new ErlList())))),
        new TestCase("lists", "append", new ErlTerm[]{new ErlList(new ErlList(new ErlAtom("a"), new ErlList()),
                                                                  new ErlAtom("b"))}, new ErlException("function_clause lists:append(b)")),
        new TestCase("a", "sending", new ErlTerm[]{}, new ErlAtom("message"))
    };

    public Test() throws Exception {
        int passed = 0, failed = 0;
        BeamVM vm = new BeamVM();
        vm.loadModules("load.txt");
        for (int i = 0; i < tests.length; i++) {
            TestCase test = tests[i];
            if (assertEqual(test.expected, vm.test(test.module, test.function, test.args)))
                passed++;
            else
                failed++;
        }
        System.out.println(passed + " passed, " + failed + " failed");
    }

    public boolean assertEqual(ErlTerm expected, ErlTerm result) {
        if (expected.toId().equals(result.toId())) {
            System.out.println("OK");
            return true;
        } else {
            System.out.println("ERROR - expected: " + expected.toString() + ", result: " + result.toString());
            return false;
        }
    }

    public static void main(String[] args) throws Exception {
        new Test();
    }
}

class TestCase {
    String module;
    String function;
    ErlTerm[] args;
    ErlTerm expected;

    public TestCase(String m, String f, ErlTerm[] a, ErlTerm e) {
        module = m;
        function = f;
        args = a;
        expected = e;
    }
}
