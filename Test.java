public class Test {
    private TestCase[] tests = {
        new TestCase("a", "test", new ErlTerm[]{new ErlAtom("a")}, ErlTerm.parse("ok")),
        new TestCase("a", "test", new ErlTerm[]{new ErlAtom("b")},
                     new ErlException(ErlTerm.parse("{function_clause, {a, test, [b]}}"))),
        new TestCase("a", "list", new ErlTerm[]{}, ErlTerm.parse("[a, 1]")),
        new TestCase("lists", "append", new ErlTerm[]{new ErlList()}, ErlTerm.parse("[]")),
        new TestCase("lists", "append", new ErlTerm[]{ErlTerm.parse("[[1, 2], [3]]")}, ErlTerm.parse("[1, 2, 3]")),
        new TestCase("lists", "append", new ErlTerm[]{ErlTerm.parse("[[a] | b]")},
                     new ErlException(ErlTerm.parse("{function_clause, {lists, append11, [b, [a]]}}"))),
        new TestCase("lists", "append", new ErlTerm[]{ErlTerm.parse("[a, b]"), ErlTerm.parse("[c, d]")},
                     ErlTerm.parse("[a, b, c, d]")),
        new TestCase("lists", "append", new ErlTerm[]{ErlTerm.parse("\"hello\""), ErlTerm.parse("\" world\"")},
                     ErlTerm.parse("\"hello world\"")),
        new TestCase("lists", "zip", new ErlTerm[]{ErlTerm.parse("[1,2,3,4]"), ErlTerm.parse("[a,b,c,d]")},
                     ErlTerm.parse("[{1,a},{2,b},{3,c},{4,d}]")),
        new TestCase("a", "sending", new ErlTerm[]{}, new ErlAtom("message")),
        new TestCase("b", "try_catch", new ErlTerm[]{}, ErlTerm.parse("{error, undef}")),
        new TestCase("b", "old_catch", new ErlTerm[]{new ErlInt(1)}, new ErlInt(2)),
        new TestCase("b", "old_catch", new ErlTerm[]{new ErlAtom("a")}, new ErlAtom("badarith")),
	new TestCase("b", "bin", new ErlTerm[]{new ErlInt(99)}, ErlTerm.parse("<<99,100,101,102>>")),
	new TestCase("b", "bin", new ErlTerm[]{new ErlAtom("a")}, new ErlException(new ErlAtom("badarg"))),
	new TestCase("b", "bin2", new ErlTerm[]{ErlTerm.parse("<<161,194>>")}, ErlTerm.parse("[{1, 1, 1}, {1, 2, 2}]")),
        new TestCase("b", "bin4", new ErlTerm[]{ErlTerm.parse("1"), ErlTerm.parse("2"), ErlTerm.parse("<<2>>")},
                     ErlTerm.parse("<<66,2>>")),
        new TestCase("numop", "int", new ErlTerm[]{new ErlInt(1), new ErlInt(2)}, ErlTerm.parse("{3, -1, 2, 0.5, 0, 1}")),
        new TestCase("numop", "int", new ErlTerm[]{new ErlInt(1), new ErlInt(0)}, new ErlException(new ErlAtom("badarg"))),
        new TestCase("numop", "int2", new ErlTerm[]{new ErlInt(10), new ErlInt(1)}, ErlTerm.parse("{20, 5, 0, 11, 11, -11}")),
        new TestCase("numop", "and_or_not", new ErlTerm[]{new ErlAtom("false"), new ErlAtom("true"), new ErlAtom("false")},
                     new ErlAtom("true")),
        new TestCase("numop", "and_or_not", new ErlTerm[]{new ErlAtom("true"), new ErlAtom("true"), new ErlAtom("true")},
                     new ErlAtom("true")),
        new TestCase("numop", "and_or_not", new ErlTerm[]{new ErlAtom("true"), new ErlAtom("false"), new ErlAtom("true")},
                     new ErlAtom("false")),
        new TestCase("numop", "bool", new ErlTerm[]{new ErlInt(1)}, new ErlAtom("no")),
        new TestCase("numop", "bool", new ErlTerm[]{new ErlAtom("a")}, new ErlAtom("no")),
        new TestCase("numop", "bool", new ErlTerm[]{new ErlAtom("true")}, new ErlAtom("yes")),
        new TestCase("a", "tuple", new ErlTerm[]{new ErlAtom("a")},
                     ErlTerm.parse("{a, {a, b, c, a}, {x, b, c, a}, {x, b, b, a}}")),
        new TestCase("b", "atomnames", new ErlTerm[]{ErlTerm.parse("alma"), ErlTerm.parse("'quoted atom'"), ErlTerm.parse("aToM_1")},
                     ErlTerm.parse("{alma, 'quoted atom', aToM_1}"))
    };

    public Test() throws Exception {
        int passed = 0, failed = 0;
        BeamClient client = new BeamClient();
        client.loadModules("load.txt");
        for (int i = 0; i < tests.length; i++) {
            TestCase test = tests[i];
            if (assertEqual(test.expected, client.test(test.module, test.function, test.args)))
                passed++;
            else
                failed++;
        }
        System.out.println(passed + " passed, " + failed + " failed");
        client.stopVM();
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
	if (args.length > 0 && args[0].equals("debug"))
	    BeamDebug.debug = true;
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
