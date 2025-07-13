/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.FavoritesDAO;
import DAO.OrderDAO;
import DAO.PlacesDAO;
import DAO.StartDateDAO;
import DAO.TourTicketDAO;
import DAO.UserDAO;
import DTO.FavoritesDTO;
import DTO.OrderDTO;
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
    FavoritesDAO fDAO = new FavoritesDAO();
    TourTicketDAO tdao = new TourTicketDAO();
    StartDateDAO stdDAO = new StartDateDAO();
    private static final String LOGIN_PAGE = "LoginForm.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(false);
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
                url = handleUserUpdating(request);
            } else if ("addFavoriteTour".equals(action)) {
                url = handleAddFavoriteTour(request, response);
            } else if ("showFavoriteList".equals(action)) {
                url = handleShowFavoriteList(request, response);
            } else if ("removeFavorite".equals(action)) {
                url = handleRemoveFavorite(request, response);;
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
