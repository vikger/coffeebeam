import coffeebeam.types.*;
import coffeebeam.beam.BeamDebug;
import coffeebeam.client.BeamClient;
import java.io.*;

public class Test extends BeamClient {
    int passed = 0, failed = 0;

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
        new TestCase("b", "bin4", new ErlTerm[]{ErlTerm.parse("1"), ErlTerm.parse("513"), ErlTerm.parse("<<2,3>>")},
                     ErlTerm.parse("<<66,1,2,3>>")),
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

    public void run() {
        for (int i = 0; i < tests.length; i++) {
            TestCase test = tests[i];
            if (assertEqual(test.expected, test(test.module, test.function, test.args)))
                passed++;
            else
                failed++;
        }
        if (failed == 0) System.out.println("\u001B[32m" + passed + " passed, " + failed + " failed");
        else System.out.println("\u001B[31m" + passed + " passed, " + failed + " failed");
    }

    public void loadModules(String filename) throws Exception {
        BufferedReader reader = new BufferedReader(new FileReader(filename));
        String module;
        while ((module = reader.readLine()) != null) {
            vm.load(module);
        }
        reader.close();
    }

    public void runApplies(String filename) throws Exception {
        BufferedReader reader = new BufferedReader(new FileReader(filename));
        String line;
        String[] mfa;
        ErlTerm[] args;
        int arity;
        while ((line = reader.readLine()) != null) {
            if (!line.startsWith("%") && !line.equals("")) {
                mfa = line.split(" ", 3);
                arity = Integer.valueOf(mfa[2]);
                args = new ErlTerm[arity];
                for (int i = 0; i < arity; i++) {
                    line = reader.readLine();
                    args[i] = ErlTerm.parse(line);
                }
                apply(mfa[0], mfa[1], args);
                waitForResult();
            }
        }
        reader.close();
    }

    public boolean assertEqual(ErlTerm expected, ErlTerm result) {
        if (expected.toId().equals(result.toId())) {
            BeamDebug.info("OK");
            return true;
        } else {
            BeamDebug.error("ERROR - expected: " + expected.toString() + ", result: " + result.toString());
            return false;
        }
    }

    public static void main(String[] args) throws Exception {
	if (args.length > 0)
	    BeamDebug.loglevel = Integer.valueOf(args[0]);
        Test client = new Test();
        client.startVM();
        client.loadModules("load.txt");
        client.run();
        client.stopVM();
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
