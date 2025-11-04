package egovframework.com.cmm.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;

import org.springframework.security.crypto.password.PasswordEncoder;

public class PasswordEncoderForMigration
        implements PasswordEncoder {

    private final Collection<PasswordEncoder> encoders;
    private final PasswordEncoder primary;

    public PasswordEncoderForMigration(PasswordEncoder primary, PasswordEncoder... alternates) {
        this.primary = primary;
        encoders = new ArrayList<>(alternates.length + 1);
        encoders.add(primary);
        encoders.addAll(Arrays.asList(alternates));
    }

    public PasswordEncoder getPrimaryEncoder() {
        return primary;
    }

    @Override
    public String encode(CharSequence rawPassword) {
        return primary.encode(rawPassword);
    }

    @Override
    public boolean matches(CharSequence rawPassword, String encodedPassword) {
        for (PasswordEncoder encoder : encoders) {
            if (encoder.matches(rawPassword, encodedPassword)) {
                return true;
            }
        }
        return false;
    }

}
