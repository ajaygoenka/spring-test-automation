package com.experian.test.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Random;

public class RandomUtils {
    protected static Random random = new Random(System.currentTimeMillis());
    public static String alphaCharacters = "abcdefghijklmnopqrstuvwxyz";
    public static String numericCharacters = "0123456789";
    public static String alphaNumCharacters = "abcdefghijklmnopqrstuvwxyz0123456789";

    private static final Logger log = (Logger) LoggerFactory.getLogger(RandomUtils.class);

    public static synchronized int randomInt(final int min, final int max) {
        return random.nextInt((max - min) + 1) + min;
    }

    public static synchronized String randomAlphaString(final int length) {
        final char[] text = new char[length];
        for (int i = 0; i < length; i++) {
            text[i] = alphaCharacters.charAt(random.nextInt(alphaCharacters.length() - 1));
        }
        return new String(text);
    }

    public static synchronized String randomAlphaNumString(final int length) {
        final char[] text = new char[length];
        for (int i = 0; i < length; i++) {
            text[i] = alphaNumCharacters.charAt(random.nextInt(alphaNumCharacters.length() - 1));
        }
        return new String(text);
    }

}
