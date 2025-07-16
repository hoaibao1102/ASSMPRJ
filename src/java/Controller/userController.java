/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.FavoritesDAO;
import DAO.OrderDAO;
import DAO.ReviewDAO;
import DAO.PlacesDAO;
import DAO.StartDateDAO;
import DAO.TourTicketDAO;
import DAO.UserDAO;
import DTO.FavoritesDTO;
import DTO.OrderDTO;
import DTO.ReviewDTO;
import DTO.StartDateDTO;
import DTO.TourTicketDTO;
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
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
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

// ====== KHAI BÁO THÊM CÁC DAO KHÁC CHO REVIEW ======
    TourTicketDAO tourTicketDAO = new TourTicketDAO(); // Dùng để lấy ảnh tour
    ReviewDAO reviewDAO = new ReviewDAO(); // Dùng để xử lý đánh giá
    FavoritesDAO fDAO = new FavoritesDAO();
    TourTicketDAO tdao = new TourTicketDAO();
    StartDateDAO stdDAO = new StartDateDAO();
    private static final String LOGIN_PAGE = "LoginForm.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String url = "about.jsp"; // Trang mặc định

        try {
            String action = request.getParameter("action");
            if (action == null) {
                action = "";
            }

            switch (action) {
                case "orderOfUser":
                    url = handleUserOrder(request, response);
                    break;
                case "listUser":
                    url = handleUserListing(request, response);
                    break;
                case "editProfile":
                    url = handleUserEditing(request, response);
                    break;
                case "updateProfile":
                    url = handleUserUpdating(request);
                    break;
                // ====== THÊM CÁC ACTION MỚI CHO REVIEW ======
                case "addReview":
                    url = handleAddReview(request, response);
                    break;
                case "updateReview":
                    url = handleUpdateReview(request, response);
                    break;
                case "deleteReview":
                    url = handleDeleteReview(request, response);
                    break;
                // ======================================
                 case "addFavoriteTour":
                    url = handleAddFavoriteTour(request, response);
                    break;
                case "showFavoriteList":
                    url = handleShowFavoriteList(request, response);
                    break;
                case "removeFavorite":
                    url = handleRemoveFavorite(request, response);
                    break;
                default:
                    // Có thể để trống hoặc chuyển về trang chính
                    url = "index.jsp";
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace(); // ✅ In lỗi để debug
        } finally {
            if (url != null) {
                if (url.startsWith("redirect:")) {
                    response.sendRedirect(url.substring(9)); // cắt "redirect:" ra
                } else {
                    request.getRequestDispatcher(url).forward(request, response);
                }
            }
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
            Date startDate = order.getStartDate();
            String idTour = order.getIdTour();
            String idBooking = order.getIdBooking();

            StartDateDTO st = stdao.searchDetailDate(idTour, startDate);
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

    private String handleUserUpdating(HttpServletRequest request) {

        try {
            /* ------------------- 0. Input & sanitize ------------------- */
            String idUserRaw = request.getParameter("userId");
            if (isBlank(idUserRaw) || !idUserRaw.matches("\\d+")) {
                request.setAttribute("updateError", "Thiếu ID người dùng");
                return "RegisForm.jsp";
            }
            int idUser = Integer.parseInt(idUserRaw);

            String fullName = safeTrim(request.getParameter("txtFullname"));
            String phone = safeTrim(request.getParameter("txtPhone"));
            String email = safeTrim(request.getParameter("txtEmail"));

            String currentPwd = request.getParameter("txtCurrentPassword");
            String newPwd = request.getParameter("txtNewPassword");
            String confirmPwd = request.getParameter("txtConfirmNewPassword");

            String REGEX_FULLNAME = "^(?=.{2,20}$)[\\p{L}]+(?:[ ]+[\\p{L}]+)*$";

            /* ------------------- 1. Validate cơ bản ------------------- */
            Map<String, String> err = new HashMap<>();

            if (isBlank(fullName) || !fullName.matches(REGEX_FULLNAME)) {
                err.put("txtFullname_error", "Tên 2‑20 ký tự, chỉ gồm chữ & khoảng trắng");
            }

            if (isBlank(phone) || !phone.matches("^0\\d{9}$")) {
                err.put("txtPhone_error", "Số điện thoại phải 10 số, bắt đầu 0");
            } else if (udao.phoneExists(phone, idUser)) {
                err.put("txtPhone_error", "Số điện thoại đã tồn tại");
            }

            if (isBlank(email) || !isValidEmail(email)) {
                err.put("txtEmail_error", "Email không hợp lệ");
            }

            /* ------------------- 2. Đổi mật khẩu (tùy chọn) ------------ */
            boolean wantsPwdChange
                    = !(isBlank(currentPwd) && isBlank(newPwd) && isBlank(confirmPwd));

            UserDTO currentUser = udao.readbyID(String.valueOf(idUser)); // đọc 1 lần

            if (wantsPwdChange) {
                if (isBlank(currentPwd)) {
                    err.put("txtCurrentPassword_error", "Vui lòng nhập mật khẩu hiện tại");
                } else if (!PasswordUtils.checkPassword(currentPwd, currentUser.getPassword())) {
                    err.put("txtCurrentPassword_error", "Mật khẩu hiện tại không đúng");
                }

                if (isBlank(newPwd) || newPwd.length() < 6) {
                    err.put("txtNewPassword_error", "Mật khẩu mới phải ≥ 6 ký tự");
                }

                if (isBlank(confirmPwd)) {
                    err.put("txtConfirmNewPassword_error", "Vui lòng xác nhận mật khẩu mới");
                } else if (!newPwd.equals(confirmPwd)) {
                    err.put("txtConfirmNewPassword_error", "Xác nhận mật khẩu không khớp");
                }
            }

            /* ------------------- 3. Nếu lỗi → quay lại form ------------- */
            if (!err.isEmpty()) {
                err.forEach(request::setAttribute);
                request.setAttribute("mode", "edit");

                UserDTO formUser = new UserDTO(idUser, fullName, email, phone, null, null, true);
                request.setAttribute("newUser", formUser);
                return "RegisForm.jsp";
            }

            /* ------------------- 4. Update DB -------------------------- */
            UserDTO updateObj = new UserDTO(idUser, fullName, email, phone, null, "CUS", true);
            if (wantsPwdChange) {
                updateObj.setPassword(PasswordUtils.hashPassword(newPwd));
            } else {
                updateObj.setPassword(currentUser.getPassword());
            }

            boolean ok = udao.update(updateObj);

            /* ------------------- 5. Phản hồi --------------------------- */
            if (ok) {
                request.getSession().setAttribute("nameUser", udao.readbyID(String.valueOf(idUser)));
                request.setAttribute("successMsg", "Cập nhật thành công!");
            } else {
                request.setAttribute("updateError", "Có lỗi xảy ra, thử lại sau");
            }
            request.setAttribute("mode", "edit");
            return "RegisForm.jsp";

        } catch (Exception ex) {
            request.setAttribute("updateError", "Lỗi hệ thống: " + ex.getMessage());
            request.setAttribute("mode", "edit");
            return "RegisForm.jsp";
        }
    }

    private static String safeTrim(String s) {
        return s == null ? "" : s.trim();
    }

    private boolean isBlank(String str) {
        return str == null || str.trim().isEmpty();
    }

    private boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        return email.matches(emailRegex);
    }


    // Method xử lý thêm review
    private String handleAddReview(HttpServletRequest request, HttpServletResponse response) {
        try {
            HttpSession session = request.getSession(false); // dùng false để không tạo session mới
            if (session == null) {
                return "redirect:loginController?action=login";
            }

            UserDTO user = (UserDTO) session.getAttribute("nameUser");
            System.out.println("🧪 nameUser = " + user);

            if (user == null) {
                return "redirect:loginController?action=login";
            }

            int userId = user.getIdUser();
            String idTourTicket = request.getParameter("idTourTicket");
            String ratingStr = request.getParameter("rating");
            String comment = request.getParameter("comment");
            String nameOfDestination = request.getParameter("nameOfDestination");

            String redirectUrl = "redirect:MainController?idTourTicket=" + idTourTicket
                    + "&nameOfDestination=" + (nameOfDestination != null ? nameOfDestination : "")
                    + "&action=ticketDetail";

            // Validation input
            if (idTourTicket == null || idTourTicket.trim().isEmpty()) {
                request.setAttribute("error", "Thông tin tour không hợp lệ");
                return "error.jsp";
            }

            if (ratingStr == null || ratingStr.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng chọn điểm đánh giá");
                return "error.jsp";
            }

            int rating;
            try {
                rating = Integer.parseInt(ratingStr);
                if (rating < 1 || rating > 5) {
                    request.setAttribute("error", "Điểm đánh giá phải từ 1 đến 5");
                    return "error.jsp";
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Điểm đánh giá không hợp lệ");
                return "error.jsp";
            }

            // Kiểm tra đã đánh giá chưa
            if (reviewDAO.hasUserReviewed(userId, idTourTicket)) {
                request.setAttribute("message", "Bạn đã đánh giá tour này rồi!");
                return redirectUrl;
            }

            // Tạo và lưu đánh giá
            ReviewDTO review = new ReviewDTO(userId, idTourTicket, rating, comment != null ? comment.trim() : "");

            if (reviewDAO.create(review)) {
                request.setAttribute("message", "Cảm ơn bạn đã đánh giá! Đánh giá của bạn đã được gửi thành công.");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi gửi đánh giá. Vui lòng thử lại.");
            }

            return redirectUrl;

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            return "error.jsp";
        }
    }

// Method xử lý cập nhật review
    private String handleUpdateReview(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(false);
        UserDTO user = null;
        if (session != null) {
            user = (UserDTO) session.getAttribute("nameUser");
        }

        if (user == null) {
            request.setAttribute("error", "Bạn cần đăng nhập để thực hiện thao tác này.");
            return "loginController?action=login";
        }

        String idTour = request.getParameter("idTourTicket");
        String destination = request.getParameter("nameOfDestination");
        String ratingStr = request.getParameter("rating");
        String comment = request.getParameter("comment");
        
        String redirectUrl = "redirect:MainController?idTourTicket=" + idTour
                    + "&nameOfDestination=" + (destination != null ? destination : "")
                    + "&action=ticketDetail";

        try {
            int rating = Integer.parseInt(ratingStr);

            // Kiểm tra user có review này không
            if (!reviewDAO.hasUserReviewed(user.getIdUser(), idTour)) {
                request.setAttribute("error", "Bạn chưa có đánh giá nào cho tour này.");
            } else {
                // Cập nhật review
                boolean success = reviewDAO.updateUserReview(user.getIdUser(), idTour, rating, comment);
                if (success) {
                    request.setAttribute("message", "Đánh giá của bạn đã được cập nhật thành công!");
                } else {
                    request.setAttribute("error", "Có lỗi xảy ra khi cập nhật đánh giá. Vui lòng thử lại.");
                }
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ.");
        }

        // Redirect về trang chi tiết tour
        return redirectUrl;
    }

//  Method xử lý xóa review
    private String handleDeleteReview(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(false);
        UserDTO user = null;
        if (session != null) {
            user = (UserDTO) session.getAttribute("nameUser");
        }

        if (user == null) {
            request.setAttribute("error", "Bạn cần đăng nhập để thực hiện thao tác này.");
            return "loginController?action=login";
        }

        String idTour = request.getParameter("idTourTicket");
        String destination = request.getParameter("nameOfDestination");
        
        String redirectUrl = "redirect:MainController?idTourTicket=" + idTour
                    + "&nameOfDestination=" + (destination != null ? destination : "")
                    + "&action=ticketDetail";
        
        // Kiểm tra user có review này không
        if (!reviewDAO.hasUserReviewed(user.getIdUser(), idTour)) {
            request.setAttribute("error", "Bạn chưa có đánh giá nào cho tour này.");
        } else {
            // Xóa review
            boolean success = reviewDAO.deleteUserReview(user.getIdUser(), idTour);
            if (success) {
                request.setAttribute("message", "Đánh giá của bạn đã được xóa thành công!");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi xóa đánh giá. Vui lòng thử lại.");
            }
        }

        // Redirect về trang chi tiết tour
        return redirectUrl;
    }

    private String handleRemoveFavorite(HttpServletRequest request, HttpServletResponse response) {
        String idUserStr = request.getParameter("idUser");
        String idTourTicket = request.getParameter("idTourTicket");
        int idUser = Integer.parseInt(idUserStr);
        if (idUserStr != null && idTourTicket != null) {
            FavoritesDTO favo = new FavoritesDTO(idUser, idTourTicket);
            boolean success = fDAO.deleteFavorite(favo);
            if (success) {
                List<FavoritesDTO> favoritesList = fDAO.getByUserId(idUser);
                List<TourTicketDTO> tourList = new ArrayList<>();
                for (FavoritesDTO f : favoritesList) {
                    TourTicketDTO tour = tdao.readbyID(f.getIdTourTicket());;
                    tourList.add(tour);
                }
                for (int i = 0; i < tourList.size(); i++) {
                    // lấy ra các ngày đi 
                    List<StartDateDTO> startDateTour = stdDAO.search(tourList.get(i).getIdTourTicket());
                    request.setAttribute("startDateTour" + (i + 1), startDateTour);
                }
                request.setAttribute("tourFavoriteList", tourList);
                return "favoriteList.jsp";
            }
        }
        return null;
    }

    private String handleAddFavoriteTour(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        String idTourTicket = request.getParameter("idTourTicket");
        String referer = request.getParameter("referer");
        String idUserStr = request.getParameter("idUser");
        String location1 = request.getParameter("location");

        TourTicketDAO tdao = new TourTicketDAO();
        PlacesDAO pdao = new PlacesDAO();
        StartDateDAO stdDAO = new StartDateDAO();

        String url = "favoriteList.jsp"; // fallback mặc định

        if (!AuthUtils.isLoggedIn(session) || idUserStr == null || idUserStr.isEmpty()) {
            session.setAttribute("redirectAfterLogin", referer != null ? referer : "index.jsp");
            session.setAttribute("pendingFavoriteTourId", idTourTicket);
            session.setAttribute("location1", location1);
            session.setAttribute("action", "addFavoriteTour");
            request.setAttribute("message", "Vui lòng đăng nhập để thêm tour vào yêu thích.");
            return "LoginForm.jsp";
        }

        try {
            int idUser = Integer.parseInt(idUserStr);
            FavoritesDTO favo = new FavoritesDTO(idUser, idTourTicket);
            boolean isAdded = fDAO.create(favo);

            if (isAdded) {
                session.setAttribute("message", "Đã thêm vào yêu thích!");
            } else {
                session.setAttribute("message", "Tour đã có trong danh sách yêu thích.");
            }

            if (location1 != null && !location1.trim().isEmpty()) {
                location1 = location1.trim();
                List<TourTicketDTO> tourList = tdao.searchByDestination(location1);
                String descriptionPlaces = pdao.readByName(location1).getDescription();

                for (int i = 0; i < tourList.size(); i++) {
                    List<StartDateDTO> startDateTour = stdDAO.search(tourList.get(i).getIdTourTicket());
                    request.setAttribute("startDateTour" + (i + 1), startDateTour);
                }

                List<FavoritesDTO> favoritesList = fDAO.getByUserId(idUser);
                session.setAttribute("favoriteCount", favoritesList.size());

                request.setAttribute("tourList", tourList);
                request.setAttribute("discriptionPlaces", descriptionPlaces);
                request.setAttribute("location", location1);
                url = "TourTicketForm.jsp";
            }

        } catch (NumberFormatException e) {
            session.setAttribute("message", "Lỗi: ID người dùng không hợp lệ.");
            url = "error.jsp";
        }
        return url;
    }

    private String handleShowFavoriteList(HttpServletRequest request, HttpServletResponse response) {
        String url;
        String idUserStr = request.getParameter("idUser");
        int idUser = Integer.parseInt(idUserStr);
        List<FavoritesDTO> favoritesList = fDAO.getByUserId(idUser);
        List<TourTicketDTO> tourList = new ArrayList<>();
        for (FavoritesDTO f : favoritesList) {
            TourTicketDTO tour = tdao.readbyID(f.getIdTourTicket());;
            tourList.add(tour);
        }
        for (int i = 0; i < tourList.size(); i++) {
            // lấy ra các ngày đi 
            List<StartDateDTO> startDateTour = stdDAO.search(tourList.get(i).getIdTourTicket());
            request.setAttribute("startDateTour" + (i + 1), startDateTour);
        }
        request.setAttribute("tourFavoriteList", tourList);
        url = "favoriteList.jsp";
        
        return url;
    }

}
