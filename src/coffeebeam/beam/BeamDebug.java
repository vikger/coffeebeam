package coffeebeam.beam;

import coffeebeam.erts.Logger;

public class BeamDebug implements Logger {
    public static int loglevel = 2; // 0: nothing, 1: error, 2: warning, 3: info, 4: debug

    public static String dec_to_bin(int b, int length) {
        String result = "";
        for (int i = 0; i < length; i++) {
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

    public void e(String s) {
        BeamDebug.error(s);
    }
    public void w(String s) {
        BeamDebug.warning(s);
    }
    public void i(String s) {
        BeamDebug.info(s);
    }
    public void d(String s) {
        BeamDebug.debug(s);
    }
}
