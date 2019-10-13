public class BeamDebug {
    public static boolean debug = false;

    public static String dec_to_bin(int b) {
        String result = "";
        for (int i = 0; i < 8; i++) {
            result = Integer.toString((b & (1 << i)) >> i) + result;
        }
        return result;
    }

    public static void print(String s) {
	if (debug)
	    System.out.print(s);
    }

    public static void println(String s) {
	if (debug)
	    System.out.println(s);
    }

    public static void println() {
	if (debug)
	    System.out.println();
    }
}
