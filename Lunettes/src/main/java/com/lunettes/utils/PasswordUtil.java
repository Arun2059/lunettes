package com.lunettes.utils;

import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import java.security.spec.KeySpec;
import java.util.Base64;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

public class PasswordUtil {
    private static final int SALT_LENGTH = 16;
    private static final int ITERATIONS = 65536;
    private static final int KEY_LENGTH = 256;

    // Generates a random salt
    public static byte[] generateSalt() {
        byte[] salt = new byte[SALT_LENGTH];
        new SecureRandom().nextBytes(salt);
        return salt;
    }

    // Hashes password with given salt
    public static String hashPassword(String password, byte[] salt) throws Exception {
        KeySpec spec = new PBEKeySpec(password.toCharArray(), salt, ITERATIONS, KEY_LENGTH);
        SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
        byte[] hash = factory.generateSecret(spec).getEncoded();
        return Base64.getEncoder().encodeToString(hash);
    }

    // Verifies password against stored hash and salt
    public static boolean verifyPassword(String password, String storedHash, byte[] storedSalt) throws Exception {
        String hashedInput = hashPassword(password, storedSalt);
        return hashedInput.equals(storedHash);
    }

    // Encodes byte[] salt to String (Base64) for DB storage
    public static String encodeSalt(byte[] salt) {
        return Base64.getEncoder().encodeToString(salt);
    }

    // Decodes Base64 string from DB back to byte[] salt
    public static byte[] decodeSalt(String encodedSalt) {
        return Base64.getDecoder().decode(encodedSalt);
    }
}
