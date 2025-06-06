/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package UTILS;

import DAO.UserDAO;
import DTO.UserDTO;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.List;

/**
 *
 * @author MSI PC
 */
public class PasswordUtils {
    
    public static String hashPassword(String plainPassword){
        String hashedPassword = plainPassword;
        try {
            //tao MessageDigest vao thuat toan SHA-256
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            
            //MA HOA MK
            byte[] messageDigest = md.digest(plainPassword.getBytes());
            
            
            //CHUYEN BYTE [] THÀNH CHUOI HEX
            StringBuilder hexString = new StringBuilder();
            for(byte b : messageDigest){
                String hex = Integer.toHexString(0xff & b);
                if(hex.length() == 1){
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (Exception e) {
            return null;
        }
        
    }
    
    public static boolean checkPassword(String plainPassword, String hashPassword){
        String newHashedPassword = hashPassword(plainPassword);
        
        return newHashedPassword != null && newHashedPassword.equals(hashPassword);
    }
    
     public static void migratePasswords() {
        UserDAO dao = new UserDAO();
        List<UserDTO> users = dao.readAll(); // Giả sử có phương thức để đọc tất cả người dùng

        for (UserDTO user : users) {
            // Lấy mật khẩu hiện tại (không mã hóa)
            String plainPassword = user.getPassword();

            // Mã hóa mật khẩu với MD5
            String hashedPassword = PasswordUtils.hashPassword(plainPassword);

            // Cập nhật mật khẩu mới
            user.setPassword(hashedPassword);

            // Lưu vào cơ sở dữ liệu
            dao.update(user); // Giả sử có phương thức update
        }

        System.out.println("Di chuyển mật khẩu sang MD5 hoàn tất");
    }
    
    public static void main(String[] args) {
        /*
        ALTER TABLE [dbo].[tblUsers]
        ALTER COLUMN [password] [varchar](250) NOT NULL;
        */
        migratePasswords();
    }
}
