package egovframework.com.cmm.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.springframework.security.crypto.codec.Hex;
import org.springframework.security.crypto.codec.Utf8;
import org.springframework.security.crypto.password.PasswordEncoder;

public class SimpleSHA1PasswordEncoder
        implements PasswordEncoder {

    private final MessageDigest digester;

    public SimpleSHA1PasswordEncoder() {
        try {
            this.digester = MessageDigest.getInstance("SHA1");
        } catch (NoSuchAlgorithmException e) {
            throw new IllegalStateException("No such hashing algorithm", e);
        }
    }

    @Override
    public String encode(CharSequence rawPassword) {
        return new String(Hex.encode(digester.digest(Utf8.encode(rawPassword))));
    }

    @Override
    public boolean matches(CharSequence rawPassword, String encodedPassword) {
        return !(encodedPassword == null || rawPassword == null) && encodedPassword.equals(encode(rawPassword));
    }

}
