package com.experian.test.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Base64;
import java.util.UUID;

public class Base64Util {

    private static final Logger log = (Logger) LoggerFactory.getLogger(Base64Util.class);

    public static String encodeCustomerId(String customerId) {
        StringBuffer customerIdUUID = new StringBuffer(customerId);
        customerIdUUID.insert(8, '-');
        customerIdUUID.insert(13, '-');
        customerIdUUID.insert(18, '-');
        customerIdUUID.insert(23, '-');
        return encode(customerIdUUID.toString());

    }

    public static String encode(String string) {
        try {
            UUID u = UUID.fromString(string.toString());
            byte[] uuidArr = encodeByteArray(u);
            return Base64.getEncoder().encodeToString(uuidArr);
        } catch (Exception e) {
            log.error("enrollment_encode_failed_" + string, e);
        }
        return null;
    }

    public static final byte[] encodeByteArray(UUID uuid) {
        long msb = uuid.getMostSignificantBits();
        long lsb = uuid.getLeastSignificantBits();
        byte[] buffer = new byte[16];
        for (int i = 0; i < 8; i++) {
            buffer[i] = (byte) (msb >>> 8 * (7 - i));
        }
        for (int i = 8; i < 16; i++) {
            buffer[i] = (byte) (lsb >>> 8 * (7 - i));
        }
        return buffer;
    }


}
