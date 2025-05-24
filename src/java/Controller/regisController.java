/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.UserDAO;
import DTO.UserDTO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import static java.rmi.server.LogStream.log;

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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = REGIS_PAGE;
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

                    UserDTO newUser = new UserDTO(fullName, email, phone, password, "customer");
                    // Regex cho tên: chỉ cho phép chữ cái, dấu cách, độ dài 2-20 ký tự
                    String regexFullName = "^[\\p{L} ]{2,20}$";
                    // Regex cho email cơ bản
                    String regexEmail = "^[\\w\\.-]+@[\\w\\.-]+\\.\\w{2,}$";
                    // Regex cho số điện thoại 10 số, bắt đầu số 0
                    String regexPhone = "^0\\d{9}$";
                    // Regex mật khẩu tối thiểu 6 ký tự (ví dụ), ít nhất 1 ký tự
                    String regexPassword = "^.{6,}$";
                    
                    
                    
                    if (fullName == null || !fullName.matches(regexFullName) ) {
                        checkedError = true;
                        request.setAttribute("txtFullname_error", "Tên không hợp lệ");
                    }

                    if (email == null || !email.matches(regexEmail) ) {
                        checkedError = true;
                        request.setAttribute("txtEmail_error", "Email không hợp lệ");
                    }
                    
                    if(checkExist(email) != null){
                        checkedError = true;
                        request.setAttribute("txtEmail_error", "Email existed");
                    }

                    if (phone == null || !phone.matches(regexPhone)) {
                        checkedError = true;
                        request.setAttribute("txtPhone_error", "Sđt phải 10 số, bắt đầu 0");
                    }
                    
                    if(checkExist(phone) != null){
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
                        uDAO.create(newUser);
                        url = LOGIN_PAGE;
                    } else {
                        request.setAttribute("newUser", newUser);
                        url = REGIS_PAGE;
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

    private Object checkExist(String checkString) {
        UserDAO udao = new UserDAO();
        return udao.readbyID(checkString);
    }

}