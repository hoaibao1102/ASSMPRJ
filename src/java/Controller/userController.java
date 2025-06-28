/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.OrderDAO;
import DAO.StartDateDAO;
import DAO.TourTicketDAO;
import DAO.UserDAO;
import DTO.OrderDTO;
import DTO.StartDateDTO;
import DTO.UserDTO;
import UTILS.AuthUtils;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author ddhuy
 */
@WebServlet(name = "userController", urlPatterns = {"/userController"})
public class userController extends HttpServlet {

    UserDAO udao = new UserDAO();
    OrderDAO odao = new OrderDAO();
    StartDateDAO stdao = new StartDateDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String url = "about.jsp";
        try {
            String action = request.getParameter("action");
            if ("orderOfUser".equals(action)) {
                url = handleUserOrder(request, response);
            } else if ("listUser".equals(action) || action == null) {
                url = handleUserListing(request, response);
            } else if ("editProfile".equals(action)) {
                url = handleUserEditing(request, response);
            } else if ("updateProfile".equals(action)) {
                url = handleUserUpdating(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace(); // ✅ In lỗi để debug
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

    private String handleUserOrder(HttpServletRequest request, HttpServletResponse response) {
        String userId = request.getParameter("userId");
        String userName = udao.readbyID(userId).getFullName();
        List<OrderDTO> list = odao.search(userId); // Lấy toàn bộ user từ DAO
        Map<String, String> startDateMap = new HashMap<>();
        for (OrderDTO order : list) {
            int stNum = order.getStartNum();
            String idTour = order.getIdTour();
            String idBooking = order.getIdBooking();

            StartDateDTO st = stdao.searchDetailDate(idTour, stNum);
            String date = st.getStartDate();

            startDateMap.put(idBooking, date);
        }
        // ===HuyCODE add===
        TourTicketDAO tourTicketdao = new TourTicketDAO();
        Map<String, String> tourImgMap = new HashMap<>();
        for (OrderDTO order : list) {
            String imgUrl = tourTicketdao.getAvatarByIdTour(order.getIdTour());
            tourImgMap.put(order.getIdTour(), imgUrl);
        }
        request.setAttribute("tourImgMap", tourImgMap);
        //=====
        request.setAttribute("startDateMap", startDateMap);
        request.setAttribute("list", list);
        request.setAttribute("userName", userName);// Đưa list vào attribute để JSP lấy ra hiển thị
        return "OrderOfUser.jsp";                // Trả về tên file JSP để forward
    }

    private String handleUserListing(HttpServletRequest request, HttpServletResponse response) {
        List<UserDTO> list = udao.readAll(); // Lấy toàn bộ user từ DAO
        request.setAttribute("list", list);      // Đưa list vào attribute để JSP lấy ra hiển thị
        return "UserManager.jsp";                // Trả về tên file JSP để forward
    }

    private String handleUserEditing(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        if (!AuthUtils.isLoggedIn(session)) {
            return "LoginForm.jsp";
        }
        // Lấy user hiện tại từ session → gán lại attribute để form hiển thị
        UserDTO current = (UserDTO) session.getAttribute("nameUser");
        request.setAttribute("newUser", current);
        request.setAttribute("mode", "edit");
        return "RegisForm.jsp";
    }

    private String handleUserUpdating(HttpServletRequest request, HttpServletResponse response) {
    try {
        // 1. Lấy input
        String idUser = request.getParameter("userId");
        String fullName = request.getParameter("txtFullname").trim();
        String phone = request.getParameter("txtPhone").trim();
        String email = request.getParameter("txtEmail").trim();

        // 2. Xử lý phần đổi mật khẩu (tùy chọn)
        String currentPwd = request.getParameter("txtCurrentPassword");
        String newPwd = request.getParameter("txtNewPassword");
        String confirmPwd = request.getParameter("txtConfirmNewPassword");

        // ==================== DEBUG INPUT ====================
        System.out.println("=== DEBUG INPUT VALUES ===");
        System.out.println("idUser: '" + idUser + "'");
        System.out.println("fullName: '" + fullName + "'");
        System.out.println("phone: '" + phone + "'");
        System.out.println("email: '" + email + "'");
        System.out.println("currentPwd: '" + (currentPwd != null ? "***" + currentPwd.length() + " chars***" : "null") + "'");
        System.out.println("newPwd: '" + (newPwd != null ? "***" + newPwd.length() + " chars***" : "null") + "'");
        System.out.println("confirmPwd: '" + (confirmPwd != null ? "***" + confirmPwd.length() + " chars***" : "null") + "'");
        
        // ==================== DEBUG BLANK CHECK ====================
        System.out.println("\n=== DEBUG BLANK CHECK ===");
        System.out.println("isBlank(currentPwd): " + isBlank(currentPwd));
        System.out.println("isBlank(newPwd): " + isBlank(newPwd));
        System.out.println("isBlank(confirmPwd): " + isBlank(confirmPwd));
        
        boolean wantsToChangePassword = !isBlank(newPwd) || !isBlank(confirmPwd) || !isBlank(currentPwd);
        System.out.println("wantsToChangePassword: " + wantsToChangePassword);

        Map<String, String> err = new HashMap<>();

        // ==================== DEBUG VALIDATION FLOW ====================
        if (wantsToChangePassword) {
            System.out.println("\n=== USER WANTS TO CHANGE PASSWORD - START VALIDATION ===");
            
            // Step 1: Check current password first
            System.out.println("\n--- STEP 1: Validate Current Password ---");
            if (isBlank(currentPwd)) {
                System.out.println("❌ Current password is blank");
                err.put("txtCurrentPassword_error", "Vui lòng nhập mật khẩu hiện tại");
            } else {
                System.out.println("✅ Current password provided, checking correctness...");
                
                // Get current user from DB
                UserDTO currentUser = udao.readbyID(idUser);
                System.out.println("Current user from DB: " + (currentUser != null ? currentUser.getEmail() : "null"));
                
                if (currentUser == null) {
                    System.out.println("❌ User not found in database");
                    err.put("txtCurrentPassword_error", "Không tìm thấy user");
                } else {
                    // Check password - sử dụng method phù hợp
                    boolean passwordCorrect = false;
                    
                    // Option 1: Nếu password được hash
                    if (currentUser.getPassword().startsWith("$2a$") || currentUser.getPassword().startsWith("$2b$")) {
                        passwordCorrect = PasswordUtils.checkPassword(currentPwd, currentUser.getPassword());
                        System.out.println("Using PasswordUtils.checkPassword() for hashed password");
                    } else {
                        // Option 2: Nếu password plain text (không khuyến khích)
                        passwordCorrect = currentPwd.equals(currentUser.getPassword());
                        System.out.println("Using plain text comparison");
                    }
                    
                    System.out.println("Password check result: " + passwordCorrect);
                    
                    if (!passwordCorrect) {
                        System.out.println("❌ Current password is incorrect");
                        err.put("txtCurrentPassword_error", "Mật khẩu hiện tại không đúng");
                    } else {
                        System.out.println("✅ Current password is correct");
                    }
                }
            }
            
            // Step 2: Check new password
            System.out.println("\n--- STEP 2: Validate New Password ---");
            if (isBlank(newPwd)) {
                System.out.println("❌ New password is blank");
                err.put("txtNewPassword_error", "Vui lòng nhập mật khẩu mới");
            } else {
                System.out.println("✅ New password provided");
                
                // Optional: Check password strength
                if (newPwd.length() < 6) {
                    System.out.println("❌ New password too short");
                    err.put("txtNewPassword_error", "Mật khẩu mới phải có ít nhất 6 ký tự");
                }
            }
            
            // Step 3: Check confirm password
            System.out.println("\n--- STEP 3: Validate Confirm Password ---");
            if (isBlank(confirmPwd)) {
                System.out.println("❌ Confirm password is blank");
                err.put("txtConfirmNewPassword_error", "Vui lòng xác nhận mật khẩu mới");
            } else if (!isBlank(newPwd) && !newPwd.equals(confirmPwd)) {
                System.out.println("❌ Confirm password doesn't match new password");
                err.put("txtConfirmNewPassword_error", "Xác nhận mật khẩu không khớp");
            } else if (!isBlank(newPwd)) {
                System.out.println("✅ Confirm password matches new password");
            }
        } else {
            System.out.println("\n=== USER DOESN'T WANT TO CHANGE PASSWORD - SKIP VALIDATION ===");
        }

        // ==================== DEBUG VALIDATION RESULT ====================
        System.out.println("\n=== VALIDATION RESULT ===");
        System.out.println("Total errors: " + err.size());
        if (!err.isEmpty()) {
            System.out.println("Errors found:");
            err.forEach((key, value) -> {
                System.out.println("  " + key + " = " + value);
            });
        } else {
            System.out.println("✅ No validation errors");
        }

        // 3. Nếu có lỗi → return về form
        if (!err.isEmpty()) {
            System.out.println("\n=== RETURNING TO FORM WITH ERRORS ===");
            err.forEach((key, value) -> {
                request.setAttribute(key, value);
            });
            
            request.setAttribute("mode", "edit");
            // Tạo lại object để hiển thị trong form
            UserDTO formUser = new UserDTO();
            formUser.setIdUser(Integer.parseInt(idUser));
            formUser.setFullName(fullName);
            formUser.setEmail(email);
            formUser.setPhone(phone);
            request.setAttribute("newUser", formUser);
            return "RegisForm.jsp";
        }

        System.out.println("\n=== PROCEEDING TO UPDATE DATABASE ===");

        // 4. Update DB
        UserDTO updateObj = new UserDTO(Integer.parseInt(idUser), fullName, email, phone, null, "CUS", true);
        if (!isBlank(newPwd)) {
            System.out.println("Updating password...");
            updateObj.setPassword(PasswordUtils.hashPassword(newPwd));
        } else {
            System.out.println("Keeping old password...");
            UserDTO currentUser = udao.readbyID(idUser);
            updateObj.setPassword(currentUser.getPassword());
        }
        
        boolean ok = udao.update(updateObj);
        System.out.println("Database update result: " + ok);

        // 5. Cập nhật session & báo kết quả
        if (ok) {
            System.out.println("✅ Update successful, refreshing session...");
            HttpSession session = request.getSession();
            UserDTO fresh = udao.readbyID(idUser);
            session.setAttribute("nameUser", fresh);
            request.setAttribute("successMsg", "Cập nhật thành công!");
        } else {
            System.out.println("❌ Update failed");
            request.setAttribute("updateError", "Có lỗi xảy ra, thử lại sau");
        }
        
        request.setAttribute("mode", "edit");
        return "RegisForm.jsp";
        
    } catch (Exception e) {
        System.out.println("\n=== EXCEPTION OCCURRED ===");
        e.printStackTrace();
        request.setAttribute("updateError", "Có lỗi hệ thống: " + e.getMessage());
        request.setAttribute("mode", "edit");
        return "RegisForm.jsp";
    }
}
    
    private String handleUserUpdating1(HttpServletRequest request, HttpServletResponse response) {

        // 1. Lấy input
        String idUser = request.getParameter("userId");
        String fullName = request.getParameter("txtFullname").trim();
        String phone = request.getParameter("txtPhone").trim();
        String email = request.getParameter("txtEmail").trim();

        // 2. Xử lý phần đổi mật khẩu (tùy chọn)
        String currentPwd = request.getParameter("txtCurrentPassword");
        String newPwd = request.getParameter("txtNewPassword");
        String confirmPwd = request.getParameter("txtConfirmNewPassword");

        Map<String, String> err = new HashMap<>();

        // 2a. Validate mật khẩu nếu user muốn đổi
        boolean wantsToChangePassword = !isBlank(newPwd) || !isBlank(confirmPwd) || !isBlank(currentPwd);

        if (wantsToChangePassword) {
            // Step 1: Check current password first
            if (isBlank(currentPwd)) {
                err.put("txtCurrentPassword_error", "Vui lòng nhập mật khẩu hiện tại");
            } else {
                // Check if current password is correct
                UserDTO currentUser = udao.readbyID(idUser);
                if (currentUser == null || !PasswordUtils.checkPassword(currentPwd, currentUser.getPassword())) {
                    err.put("txtCurrentPassword_error", "Mật khẩu hiện tại không đúng");
                }
            }

            // Step 2: Check new password
            if (isBlank(newPwd)) {
                err.put("txtNewPassword_error", "Vui lòng nhập mật khẩu mới");
            }

            // Step 3: Check confirm password
            if (isBlank(confirmPwd)) {
                err.put("txtConfirmNewPassword_error", "Vui lòng xác nhận mật khẩu mới");
            } else if (!isBlank(newPwd) && !newPwd.equals(confirmPwd)) {
                err.put("txtConfirmNewPassword_error", "Xác nhận mật khẩu không khớp");
            }
        }

        // 3. Nếu có lỗi → forward về form
        if (!err.isEmpty()) {
            System.out.println("=== DEBUG ERRORS ===");
            err.forEach((key, value) -> {
                System.out.println(key + " = " + value);
                request.setAttribute(key, value);
            });

            request.setAttribute("mode", "edit");
            // Tạo lại object để hiển thị trong form
            UserDTO formUser = new UserDTO();
            formUser.setIdUser(Integer.parseInt(idUser));
            formUser.setFullName(fullName);
            formUser.setEmail(email);
            formUser.setPhone(phone);
            request.setAttribute("newUser", formUser);
            return "RegisForm.jsp"; // ✅ Return thay vì throw exception
        }

        // 4. Update DB
        // Không truyền newPwd vào constructor nếu chưa hash
        UserDTO updateObj = new UserDTO(Integer.parseInt(idUser), fullName, email, phone, null, "CUS", true);
        if (!isBlank(newPwd)) {
            updateObj.setPassword(PasswordUtils.hashPassword(newPwd));
        } else {
            // Giữ nguyên password cũ
            UserDTO currentUser = udao.readbyID(idUser);
            updateObj.setPassword(currentUser.getPassword());
        }
        boolean ok = udao.update(updateObj);   // trả về true/false

        // 5. Cập nhật session & báo kết quả
        if (ok) {
            HttpSession session = request.getSession();
            UserDTO fresh = udao.readbyID(idUser); // lấy lại bản ghi sau update
            session.setAttribute("nameUser", fresh);
            request.setAttribute("successMsg", "Cập nhật thành công!");
        } else {
            request.setAttribute("updateError", "Có lỗi xảy ra, thử lại sau");
        }
        request.setAttribute("mode", "edit");
        return "RegisForm.jsp";
    }

    private boolean isBlank(String str) {
        return str == null || str.trim().isEmpty();
    }

}
