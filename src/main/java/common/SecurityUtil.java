package common;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class SecurityUtil {
	public String encryptSHA256(String str){
    String sha = "";
    try{
       MessageDigest sh = MessageDigest.getInstance("SHA-256");
       // 100 ~ 999 난수 발생으로 하면 무조건 솔트키가 3자리가 되니 솔트만 꺼내기 쉬워짐
       // int salt = (int)(Math.random()*100) + 1;
       // str += salt;
       
       sh.update(str.getBytes());
       byte byteData[] = sh.digest();
       StringBuffer sb = new StringBuffer();
       for(int i = 0 ; i < byteData.length ; i++){
           sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
       }
       sha = sb.toString();
   }catch(NoSuchAlgorithmException e){
       System.out.println("Encrypt Error - NoSuchAlgorithmException");
       sha = null;
   }
   return sha;
 } 
}
