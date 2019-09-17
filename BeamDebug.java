public class BeamDebug {
    public static String dec_to_bin(int b) {
        String result = "";
        for (int i = 0; i < 8; i++) {
            result = Integer.toString((b & (1 << i)) >> i) + result;
        }
        return result;
    }
}
