public class BeamDebug {
    public static int loglevel = 2; // 0: nothing, 1: error, 2: warning, 3: info, 4: debug

    public static String dec_to_bin(int b) {
        String result = "";
        for (int i = 0; i < 8; i++) {
            result = Integer.toString((b & (1 << i)) >> i) + result;
        }
        return result;
    }

    public static void error(String s) {
        if (loglevel >= 1) println("\u001B[31m" + s);
    }
    public static void warning(String s) {
        if (loglevel >= 2) println("\u001B[33m" + s);
    }
    public static void info(String s) {
        if (loglevel >= 3) println("\u001B[0m" + s);
    }
    public static void debug(String s) {
        if (loglevel >= 4) println("\u001B[35m" + s);
    }
    public static void print(String s) {
	    System.out.print(s + "\u001B[0m");
    }
    public static void println(String s) {
	    System.out.println(s + "\u001B[0m");
    }
    public static void println() {
	    System.out.println("\u001B[0m");
    }
}
