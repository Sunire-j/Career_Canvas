package com.team1.careercanvas.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

public class securePassword {
    static public String[] encryptWithSalt(String userpwd) throws NoSuchAlgorithmException {
        SecureRandom random = new SecureRandom();
        byte[] salt = new byte[16];
        random.nextBytes(salt);

        MessageDigest md = MessageDigest.getInstance("SHA-256");
        md.update(salt);
        md.update(userpwd.getBytes());

        byte[] byteData = md.digest();

        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < byteData.length; i++) {
            sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
        }

        String encryptedPwd = sb.toString();

        String saltString = Base64.getEncoder().encodeToString(salt);
        System.out.println("saltString = "+saltString);

        return new String[]{encryptedPwd, saltString};
    }

    static public String[] encryptWithSalt(String userpwd, String saltString) throws NoSuchAlgorithmException {
        byte[] salt = Base64.getDecoder().decode(saltString);

        MessageDigest md = MessageDigest.getInstance("SHA-256");
        md.update(salt);
        md.update(userpwd.getBytes());

        byte[] byteData = md.digest();

        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < byteData.length; i++) {
            sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
        }

        String encryptedPwd = sb.toString();

        return new String[]{encryptedPwd, saltString};
    }
}
