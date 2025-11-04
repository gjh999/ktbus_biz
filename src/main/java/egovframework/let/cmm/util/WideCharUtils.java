package egovframework.let.cmm.util;

import org.springframework.util.StringUtils;

public final class WideCharUtils {

    private WideCharUtils() {
    	
    }

    public static String toWideCharText(final String text) {
        String converted = text;
        if (StringUtils.hasText(text)) {
            converted = text.replaceAll(" ", "\u3000");
            for (int n = 0xFF00; n < 0xFF60; n++) {
                converted = converted.replaceAll(String.format("[\\u%04x]", n - 0xFEE0), String.valueOf((char) n));
            }
        }
        return converted;
    }

    public static String toNormalText(final String text) {
        String converted = text;
        if (StringUtils.hasText(text)) {
            converted = text.replaceAll("\u3000", " ");
            for (int n = 0xFF00; n < 0xFF60; n++) {
                converted = converted.replaceAll(String.format("[\\u%04x]", n), String.valueOf((char) (n - 0xFEE0)));
            }
        }
        return converted;
    }
}
