import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

...

//회원가입 시 비밀번호 sha-256암호화(솔트 이용)
public String[] encryptWithSalt(String userpwd) throws NoSuchAlgorithmException {
        // 랜덤한 솔트를 생성합니다.
        SecureRandom random = new SecureRandom();
        byte[] salt = new byte[16];
        random.nextBytes(salt);

        // 솔트를 추가한 비밀번호를 해시 함수에 넣어 암호화합니다.
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        md.update(salt);
        md.update(userpwd.getBytes());

        byte byteData[] = md.digest();

        // 바이트를 헥사 값으로 변환합니다.
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < byteData.length; i++) {
        sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
        }

        String encryptedPwd = sb.toString();

        // 솔트를 Base64로 인코딩합니다.
        String saltString = Base64.getEncoder().encodeToString(salt);

        // 암호화된 비밀번호와 솔트를 반환합니다.
        return new String[]{encryptedPwd, saltString};
        }
