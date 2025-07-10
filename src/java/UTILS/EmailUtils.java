/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package UTILS;

import DTO.StartDateDTO;
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

    
    public static boolean sendVerificationEmail(String email, String fullName, String token) {
        String emailContent = createVerificationEmailContent(fullName, token);
        if(handleSendMail(email, "Account Verification Required", emailContent)){
            return true;
        }
        return false;
    }

    
    private static String createVerificationEmailContent(String fullName, String code) {
        return "<html><body>"
                + "<h2>Hello, " + fullName + "!</h2>"
                + "<p>Your verification code is:</p>"
                + "<h1 style='letter-spacing:10px; color:#4CAF50'>" + code + "</h1>"
                + "<p>This code will expire in 3 minutes.</p>"
                + "</body></html>";
    }

    private static boolean handleSendMail(String email,String title, String emailContent) {
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
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject(title);

            // Xây dựng nội dung HTML email
            message.setContent(emailContent, "text/html; charset=utf-8");

            // Gửi email
            Transport.send(message);

            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }


    public static boolean sendBillThroughEmail(String email, String fullName, String nametour, String startDate,  int numberTicket, Double total) {
       String emailContent = buildOrderEmailContent(fullName, nametour, startDate, numberTicket, total);
        if(handleSendMail(email, "Tour booking confirmation", emailContent)){
            return true;
        }
        return false;
    }

    public static String buildOrderEmailContent(String fullName, String nametour, String startDate, int numberTicket, Double total) {
      

        // Xây dựng nội dung email HTML với CSS
        StringBuilder content = new StringBuilder();

        content.append("<html>")
                .append("<head>")
                .append("<style>")
                .append("body { font-family: Arial, sans-serif; background-color: #f4f4f9; color: #333; margin: 0; padding: 0; }")
                .append("h2 { color: #0056b3; }")
                .append("p { font-size: 14px; line-height: 1.6; }")
                .append("table { width: 100%; border-collapse: collapse; margin: 20px 0; }")
                .append("td, th { padding: 10px; text-align: left; border: 1px solid #ddd; }")
                .append("th { background-color: #0056b3; color: white; }")
                .append("td { background-color: #f9f9f9; }")
                .append("strong { color: #333; }")
                .append(".footer { margin-top: 20px; font-size: 12px; color: #777; text-align: center; }")
                .append("</style>")
                .append("</head>")
                .append("<body>")
                .append("<div style='max-width: 600px; margin: 0 auto; padding: 20px; background-color: white; border-radius: 8px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);'>")
                .append("<h2>Thông tin xác nhận đặt tour</h2>")
                .append("<p>Xin chào <strong>").append(fullName).append("</strong>,</p>")
                .append("<p>Cảm ơn bạn đã đặt tour tại công ty chúng tôi. Dưới đây là thông tin đặt tour của bạn:</p>")
                .append("<table>")
                .append("<tr><th>Tên tour:</th><td>").append(nametour).append("</td></tr>")
                .append("<tr><th>Ngày khởi hành:</th><td>").append(startDate).append("</td></tr>")
                .append("<tr><th>Số lượng vé:</th><td>").append(numberTicket).append("</td></tr>")
                .append("<tr><th>Tổng tiền:</th><td>").append(String.format("%,.2f", total)).append(" VND</td></tr>")
                .append("</table>")
                .append("<p>Chúng tôi rất mong được phục vụ bạn trong tour sắp tới!</p>")
                .append("<p>Trân trọng,</p>")
                .append("<p><strong>Đội ngũ hỗ trợ khách hàng</strong><br/>Công ty du lịch ba thành viên</p>")
                .append("<div class='footer'>Nếu bạn có bất kỳ câu hỏi nào, vui lòng liên hệ với chúng tôi qua email này.</div>")
                .append("</div>")
                .append("</body>")
                .append("</html>");

        // Trả về nội dung email dưới dạng String
        return content.toString();
    }
    
        public static void main(String[] args) {
        boolean sent = sendBillThroughEmail("anhptse182446@fpt.edu.vn", "Pham Thi Anh", "Ha Noi", "2025-13-13", 20 , 2000000.0);
        System.out.println(sent ? "✅ Email sent!" : "❌ Failed.");
    }

}
