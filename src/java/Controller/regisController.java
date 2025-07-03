/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.UserDAO;
import DAO.UserVerificationDAO;
import DTO.UserDTO;
import DTO.UserVerificationDTO;
import static UTILS.EmailUtils.sendVerificationEmail;
import UTILS.PasswordUtils;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author MSI PC
 */
@WebServlet(name = "regisController", urlPatterns = {"/regisController"})
public class regisController extends HttpServlet {

    private static final String REGIS_PAGE = "RegisForm.jsp";
    private static final String LOGIN_PAGE = "LoginForm.jsp";

    public UserDAO uDAO = new UserDAO();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        String url = REGIS_PAGE;
        HttpSession session = request.getSession();
        try {
            String action = request.getParameter("action");
            if (action == null) {
                url = REGIS_PAGE;
            } else {
                if (action.equals("regis")) {
                    boolean checkedError = false;
                    // Lấy dữ liệu từ form đăng ký
                    String fullName = request.getParameter("txtFullname");
                    String email = request.getParameter("txtEmail");
                    String phone = request.getParameter("txtPhone");
                    String password = request.getParameter("txtPassword");
                    String confirmPassword = request.getParameter("txtConfirmPassword");

                    // Regex cho tên: chỉ cho phép chữ cái, dấu cách, độ dài 2-20 ký tự
                    String regexFullName = "^[\\p{L} ]{2,20}$";
                    // Regex cho email cơ bản
                    String regexEmail = "^[\\w\\.-]+@[\\w\\.-]+\\.\\w{2,}$";
                    // Regex cho số điện thoại 10 số, bắt đầu số 0
                    String regexPhone = "^0\\d{9}$";
                    // Regex mật khẩu tối thiểu 6 ký tự (ví dụ), ít nhất 1 ký tự
                    String regexPassword = "^.{6,}$";

                    if (fullName == null || !fullName.matches(regexFullName)) {
                        checkedError = true;
                        request.setAttribute("txtFullname_error", "Tên không hợp lệ");
                    }

                    if (email == null || !email.matches(regexEmail)) {
                        checkedError = true;
                        request.setAttribute("txtEmail_error", "Email không hợp lệ");
                    }

                    if (checkExist(email) != null) {
                        checkedError = true;
                        request.setAttribute("txtEmail_error", "Email existed");
                    }

                    if (phone.trim() == null || !phone.trim().matches(regexPhone)) {
                        checkedError = true;
                        request.setAttribute("txtPhone_error", "Sđt phải 10 số, bắt đầu 0");
                    }

                    if (checkExist(phone) != null) {
                        checkedError = true;
                        request.setAttribute("txtPhone_error", "Phone existed");
                    }

                    if (password == null || !password.matches(regexPassword)) {
                        checkedError = true;
                        request.setAttribute("txtPassword_error", "Mật khẩu ít nhất 6 ký tự");
                    }

                    if (confirmPassword == null || !confirmPassword.equals(password)) {
                        checkedError = true;
                        request.setAttribute("txtConfirmPassword_error", "Xác nhận mật khẩu sai");
                    }

                    if (!checkedError) {
                        String verificationCode = generateVerificationCode(); // sinh mã 6 số
                        Timestamp expiredTime = Timestamp.valueOf(LocalDateTime.now().plusMinutes(3));
                        String newPassWord = PasswordUtils.hashPassword(password);
                        UserDTO userSuccess = new UserDTO(fullName, email, phone, newPassWord, "CUS");
                        UserVerificationDAO verDAO = new UserVerificationDAO();
                        boolean saved = verDAO.saveVerificationCode(email, verificationCode, expiredTime);

                        if (saved) {
                            sendVerificationEmail(email, fullName, verificationCode); // bạn sẽ thêm nội dung hàm này sau

                            session.setAttribute("userWaitAccess", userSuccess);
                            request.setAttribute("email", email);
                            url = "verify.jsp"; // chuyển đến trang xác minh


//                        uDAO.create(userSuccess);
//                        url = LOGIN_PAGE;
                        } else {

//                        UserDTO userFail = new UserDTO(fullName, email, phone, password, "CUS");
//                        request.setAttribute("newUser", userFail);
//                        url = REGIS_PAGE;
                        }

                    }
                } else if (action.equals("verifyCode")) {
                    UserDTO userWaitAccess = (UserDTO) session.getAttribute("userWaitAccess");
                    String inputCode = request.getParameter("codeInput");
                    String email = userWaitAccess.getEmail();
                    UserVerificationDAO verDAO = new UserVerificationDAO();
                    UserVerificationDTO ver = verDAO.findByEmail(email);

                    if (ver == null) {
                        request.setAttribute("error", "Verification session expired. Please register again.");
                        url = "RegisForm.jsp";
                    }

                    Timestamp now = new Timestamp(System.currentTimeMillis());

                    if (ver.getAttemptCount() >= 5 || now.after(ver.getExpiredTime())) {
                        verDAO.deleteByEmail(email);
                        session.invalidate(); // Xoá toàn bộ session tạm
                        request.setAttribute("error", "Verification expired or too many attempts.");
                        url = "LoginForm.jsp";
                    }

                    if (ver.getCode().equals(inputCode)) {
                        // Lấy lại các dữ liệu từ sessioN
                        UserDAO userDAO = new UserDAO();
                        userDAO.create(userWaitAccess);

                        verDAO.deleteByEmail(email);
                        session.invalidate(); // Xoá dữ liệu tạm
                        request.setAttribute("success", "Account verified! You can now login.");
                        url = "LoginForm.jsp";
                    } else {
                        verDAO.incrementAttempt(email);
                        request.setAttribute("error", "Incorrect verification code.");
                        url = "verify.jsp";
                    }
                }
            }

        } catch (Exception e) {
            log("Error in MainController: " + e.toString());
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(regisController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(regisController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(regisController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(regisController.class.getName()).log(Level.SEVERE, null, ex);
        }
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

    private Object checkExist(String checkString) {
        UserDAO udao = new UserDAO();
        return udao.readbyID(checkString);
    }

    private boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        return email.matches(emailRegex);
    }

    public static String generateVerificationCode() {
        Random rand = new Random();
        int code = 100000 + rand.nextInt(900000); // 6 chữ số
        return String.valueOf(code);
    }
}
