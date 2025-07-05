/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.UserDAO;
import DAO.UserVerificationDAO;
import DTO.UserDTO;
import DTO.UserVerificationDTO;
import UTILS.EmailUtils;
import UTILS.PasswordUtils;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Random;

/**
 *
 * @author ddhuy
 */
@WebServlet(name = "ForgotPasswordController", urlPatterns = {"/ForgotPasswordController"})
public class ForgotPasswordController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String url = "forgot_password.jsp";
        try {
            String action = request.getParameter("action");
            if ("sendCode".equals(action)) {
                url = handleSendCode(request, response);
            } else if ("verifyCode".equals(action)) {
                url = handleVerifyCode(request, response);
            } else if ("resetPassword".equals(action)) {
                url = handleResetPassword(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private String handleSendCode(HttpServletRequest request, HttpServletResponse response) {
        String email = request.getParameter("email");
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập email.");
            return "forgot_password.jsp";
        }
        try {
            UserDAO userDao = new UserDAO();
            UserDTO user = userDao.readbyEmail(email);
            if (user == null) {
                request.setAttribute("error", "Email không tồn tại trong hệ thống.");
                return "forgot_password.jsp";
            }
            // Generate code
            String code = String.format("%06d", new Random().nextInt(1000000));
            Timestamp expired = new Timestamp(System.currentTimeMillis() + 3 * 60 * 1000); // 3 phút

            UserVerificationDAO verifDao = new UserVerificationDAO();
            verifDao.saveVerificationCode(email, code, expired);

            EmailUtils.sendVerificationEmail(email, user.getFullName(), code);

            // Lưu thông tin email vào session
            HttpSession session = request.getSession();
            session.setAttribute("reset_email", email);

            request.setAttribute("mode", "forgot");
            request.setAttribute("email", email);     // để hiển thị email trong jsp
            return "verify.jsp";
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi gửi mã xác nhận.");
            return "forgot_password.jsp";
        }
    }

    private String handleVerifyCode(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("reset_email");
        String codeInput = request.getParameter("codeInput");
        if (email == null || codeInput == null || codeInput.trim().isEmpty()) {
            request.setAttribute("error", "Thiếu thông tin xác thực.");
            request.setAttribute("email", email);
            request.setAttribute("mode", "forgot");
            return "verify.jsp";
        }
        try {
            UserVerificationDAO verifDao = new UserVerificationDAO();
            UserVerificationDTO verif = verifDao.findByEmail(email);
            if (verif == null) {
                request.setAttribute("error", "Mã xác thực không tồn tại, vui lòng thử lại.");
                request.setAttribute("email", email);
                request.setAttribute("mode", "forgot");
                return "verify.jsp";
            }
            if (!verif.getCode().equals(codeInput)) {
                verifDao.incrementAttempt(email);
                request.setAttribute("error", "Mã xác thực không đúng.");
                request.setAttribute("email", email);
                request.setAttribute("mode", "forgot");
                return "verify.jsp";
            }
            if (verif.getExpiredTime().before(new Timestamp(System.currentTimeMillis()))) {
                request.setAttribute("error", "Mã xác thực đã hết hạn.");
                request.setAttribute("email", email);
                request.setAttribute("mode", "forgot");
                return "verify.jsp";
            }
            // Verified, cho phép đặt lại mật khẩu
            session.setAttribute("verified_for_reset", true);
            return "reset_password.jsp";
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi xác thực code.");
            request.setAttribute("email", email);
            request.setAttribute("mode", "forgot");
            return "verify.jsp";
        }
    }

    private String handleResetPassword(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("reset_email");
        Boolean verified = (Boolean) session.getAttribute("verified_for_reset");
        String pwd1 = request.getParameter("password");
        String pwd2 = request.getParameter("confirmPassword");

        if (email == null || verified == null || !verified) {
            request.setAttribute("error", "Vui lòng xác thực email trước.");
            return "forgot_password.jsp";
        }
        if (pwd1 == null || pwd2 == null || pwd1.length() < 6 || !pwd1.equals(pwd2)) {
            request.setAttribute("error", "Mật khẩu phải ≥6 ký tự và xác nhận phải trùng khớp.");
            return "reset_password.jsp";
        }
        try {
            UserDAO userDao = new UserDAO();
            UserVerificationDAO verifDao = new UserVerificationDAO();

            userDao.updatePasswordByEmail(email, pwd1);
            //hủy sestion verified & reset_mail
            verifDao.deleteByEmail(email);
            session.removeAttribute("reset_email");
            session.removeAttribute("verified_for_reset");
            request.setAttribute("successMsg", "Đổi mật khẩu thành công! Hãy đăng nhập lại.");
            return "LoginForm.jsp";
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi đổi mật khẩu.");
            return "reset_password.jsp";
        }
    }

}
