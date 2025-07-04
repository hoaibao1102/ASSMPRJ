/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package UTILS;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

/**
 *
 * @author MSI PC
 */
public class EmailUtils {
    
    // Thông tin tài khoản email dùng để gửi (thay đổi thông tin này)
    private static final String EMAIL_USERNAME = "prjassmabh@gmail.com";
    private static final String EMAIL_PASSWORD = "pleluyebhheiaxkg";
    
    // Cấu hình SMTP server
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    
     /**
     * Gửi email xác thực đăng ký với token xác thực
     * 
     * @param toEmail Địa chỉ email người nhận
     * @param fullName Tên đầy đủ của người dùng
     * @param token Token xác thực
     * @return true nếu gửi email thành công, false nếu có lỗi
     */
    public static boolean sendVerificationEmail(String toEmail, String fullName, String token) {
        try {
            // Thiết lập các thuộc tính
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);
            props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

            
            // Tạo phiên xác thực
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
                }
            });
            
            // Tạo message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_USERNAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Account Verification Required");
            
            // Xây dựng nội dung HTML email
            String verificationLink = "http://yourwebsite.com/verify?token=" + token;
            String htmlContent = createVerificationEmailContent(fullName, verificationLink,token);
            message.setContent(htmlContent, "text/html; charset=utf-8");
            
            // Gửi email
            Transport.send(message);
            
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Xây dựng nội dung HTML cho email xác thực tài khoản
     * 
     * @param fullName Tên đầy đủ người dùng
     * @param verificationLink Đường dẫn xác thực
     * @return Chuỗi HTML hoàn chỉnh cho nội dung email
     */
    private static String createVerificationEmailContent(String fullName, String verificationLink,String code) {
        return "<html><body>"
         + "<h2>Hello, " + fullName + "!</h2>"
         + "<p>Your verification code is:</p>"
         + "<h1 style='letter-spacing:10px; color:#4CAF50'>" + code + "</h1>"
         + "<p>This code will expire in 3 minutes.</p>"
         + "</body></html>";
    }
    
    public static void main(String[] args) {
        boolean sent = sendVerificationEmail("baolphse181860@fpt.edu.vn", "Test User", "123456");
        System.out.println(sent ? "✅ Email sent!" : "❌ Failed.");
    }
}
