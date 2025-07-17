
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.FavoritesDAO;
import DAO.OrderDAO;
import DAO.PlacesDAO;
import DAO.ReviewDAO;
import DAO.StartDateDAO;
import DAO.TicketDayDetailDAO;
import DAO.TourTicketDAO;
import DAO.TicketImgDAO;
import DAO.UserDAO;
import DAO.VoucherDAO;
import DTO.FavoritesDTO;
import DTO.PlacesDTO;
import DTO.ReviewDTO;
import DTO.StartDateDTO;
import DTO.TicketDayDetailDTO;
import DTO.TourTicketDTO;
import DTO.TicketImgDTO;
import DTO.UserDTO;
import DTO.VoucherDTO;
import UTILS.AuthUtils;
import UTILS.PasswordUtils;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

/**
 *
 * @author MSI PC
 */
@WebServlet(name = "loginController", urlPatterns = {"/loginController"})
public class loginController extends HttpServlet {

    private static final String INDEX_PAGE = "index.jsp";
    private static final String LOGIN_PAGE = "LoginForm.jsp";
    placeController pcl = new placeController();

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
        String url = LOGIN_PAGE;
        String action = request.getParameter("action");

        try {
            if (action == null) {
                url = LOGIN_PAGE;
            } else if ("login".equals(action)) {

                url = handleLogin(request, response);
            } else if ("logout".equals(action)) {
                url = handleLogout(request, response);
            } else {
                // Các action khác, về trang đăng nhập mặc định
                url = LOGIN_PAGE;
            }
        } catch (Exception e) {
            log("Error in loginController: " + e.toString());
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

    private String handleLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin đăng nhập từ form
        String url = "";
        FavoritesDAO fDAO = new FavoritesDAO();
        HttpSession session = request.getSession(false);
        TourTicketDAO tdao = new TourTicketDAO();

        StartDateDAO stDao = new StartDateDAO();
        String txtEmailOrPhone = request.getParameter("txtEmailOrPhone");
        String txtPassword = request.getParameter("txtPassword");

        if (AuthUtils.isValidLogin(txtEmailOrPhone, txtPassword)) {
            // Lấy user và lưu vào session
            UserDTO user = AuthUtils.getUser(txtEmailOrPhone);
            session = request.getSession(true);
            session.setAttribute("nameUser", user);
            List<FavoritesDTO> favoritesList = fDAO.getByUserId(user.getIdUser());
            session.setAttribute("favoriteCount", favoritesList.size());
            //=========Review===========
            String pendingReviewTourId = (String) session.getAttribute("pendingReviewTourId");
            String nameOfDestination = (String) session.getAttribute("nameOfDestination");
            System.out.println("pendingReviewTourId:" + pendingReviewTourId);
            //===========END=========
            // Kiểm tra session có lưu URL redirect không
            String redirectUrl = (String) session.getAttribute("redirectAfterLogin");
            String actionCheck = (String) session.getAttribute("action");

            if (redirectUrl != null && actionCheck != null) {
                switch (actionCheck) {
                    case "order": {
                        if (AuthUtils.isCustomer(session)) {
                            String idTour = (String) session.getAttribute("idTour");
                            Date startDate = (Date) session.getAttribute("startDate");

                            if (idTour != null && startDate != null) {
                                TourTicketDTO tourTicket = tdao.readbyID(idTour);
                                StartDateDTO stDate = stDao.searchDetailDate(idTour, startDate);
                                session.setAttribute("stDate", stDate);
                                session.setAttribute("tourTicket", tourTicket);
                                session.removeAttribute("idTour");
                                session.removeAttribute("startDate");
                            }
                            url = redirectUrl;
                        } else {
                            url = INDEX_PAGE;
                        }
                        break;
                    }
                    case "addFavoriteTour": {
                        String pendingFavoriteTourId = (String) session.getAttribute("pendingFavoriteTourId");
                        if (pendingFavoriteTourId != null) {
                            FavoritesDTO favo = new FavoritesDTO(user.getIdUser(), pendingFavoriteTourId);
                            if (fDAO.create(favo)) {
                                session.setAttribute("message", "Đã thêm vào yêu thích sau khi đăng nhập!");
                            } else {
                                session.setAttribute("message", "Tour đã nằm trong danh sách yêu thích.");
                            }
                            session.removeAttribute("pendingFavoriteTourId");
                        }
                        String location1 = (String) session.getAttribute("location1");
                        PlacesDAO pdao = new PlacesDAO();
                        StartDateDAO stdDAO = new StartDateDAO();
                        location1 = location1.trim();
                        List<TourTicketDTO> tourList = tdao.searchByDestination(location1);
                        String discriptionPlaces = pdao.readByName(location1).getDescription();
                        for (int i = 0; i < tourList.size(); i++) {
                            List<StartDateDTO> startDateTour = stdDAO.search(tourList.get(i).getIdTourTicket());
                            request.setAttribute("startDateTour" + (i + 1), startDateTour);
                        }
                        List<FavoritesDTO> favoritesList2 = fDAO.getByUserId(user.getIdUser());
                        request.setAttribute("tourList", tourList);
                        request.setAttribute("discriptionPlaces", discriptionPlaces);
                        request.setAttribute("location", location1);
                        session.setAttribute("favoriteCount", favoritesList2.size());
                        url = "TourTicketForm.jsp";
                        session.removeAttribute("location1");

                        break;
                    }
                    case "addReview": {
                        if (pendingReviewTourId != null && nameOfDestination != null) {
                            // Sau khi đăng nhập thành công, chuyển về trang chi tiết tour để có thể review
                            // Cần gọi lại controller để load đầy đủ thông tin tour

                            // Gọi các DAO cần thiết để load lại thông tin tour
                            TicketImgDAO imgDAO = new TicketImgDAO();
                            TicketDayDetailDAO dayDetailDAO = new TicketDayDetailDAO();
                            ReviewDAO reviewDAO = new ReviewDAO();
                            OrderDAO oDao = new OrderDAO();

                            // Load thông tin tour
                            TourTicketDTO tourTicket = tdao.readbyID(pendingReviewTourId);
                            List ticketImgDetail = imgDAO.readbyIdTourTicket(pendingReviewTourId);
                            List ticketDayDetail = dayDetailDAO.readbyIdTourTicket(pendingReviewTourId);
                            List startDateTour = stDao.search(pendingReviewTourId);

                            // Load thông tin review
                            List reviews = reviewDAO.getReviewsByTourId(pendingReviewTourId);
                            Double averageRating = tdao.getAvgRating(pendingReviewTourId);
                            Integer totalReviews = tdao.getTotalReviews(pendingReviewTourId);

                            // Kiểm tra user đã review chưa và đã thanh toán chưa
                            boolean hasUserReviewed = reviewDAO.hasUserReviewed(user.getIdUser(), pendingReviewTourId);
                            boolean hasUserPaid = oDao.hasUserPaidForTour(user.getIdUser(), pendingReviewTourId);

                            ReviewDTO userReview = null;
                            if (hasUserReviewed) {
                                userReview = reviewDAO.getUserReview(user.getIdUser(), pendingReviewTourId);
                            }

                            // Set attributes cho JSP
                            request.setAttribute("tourTicket", tourTicket);
                            request.setAttribute("ticketImgDetail", ticketImgDetail);
                            request.setAttribute("ticketDayDetail", ticketDayDetail);
                            request.setAttribute("startDateTour", startDateTour);
                            request.setAttribute("reviews", reviews);
                            request.setAttribute("averageRating", averageRating);
                            request.setAttribute("totalReviews", totalReviews);
                            request.setAttribute("hasUserReviewed", hasUserReviewed);
                            request.setAttribute("hasUserPaid", hasUserPaid);
                            request.setAttribute("userReview", userReview);

                            // Thông báo cho user biết đã đăng nhập thành công
                            request.setAttribute("message", "Đăng nhập thành công! Bạn có thể đánh giá tour ngay bây giờ.");

                            // Xóa thông tin tạm thời khỏi session
                            session.removeAttribute("pendingReviewTourId");
                            session.removeAttribute("nameOfDestination");

                            // Chuyển về trang chi tiết tour
                            url = "TicketDetailForm.jsp";
                        } else {
                            // Nếu không có thông tin tour, về trang chủ
                            pcl.getAllDestination(request, response);
                            url = INDEX_PAGE;
                        }
                        break;
                    }
                    default:
                        url = INDEX_PAGE;
                        break;
                }
                session.removeAttribute("action");
                session.removeAttribute("redirectAfterLogin");
            } else {
                // Gọi hàm getFeaturedPlaces để lấy danh sách địa điểm và gán vào request
                pcl.getAllDestination(request, response);
                url = INDEX_PAGE;
            }
        } else {
            request.setAttribute("message", "Invalid login account");
            url = LOGIN_PAGE;
        }
        return url;
    }

    private String handleLogout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Xử lý logout: invalidate session nếu có
        String url = "";
        HttpSession session = request.getSession();
        if (session != null) {
            session.invalidate();
        }
        // Gọi hàm getFeaturedPlaces để lấy danh sách địa điểm và gán vào request
        pcl.getAllDestination(request, response);
        url = "index.jsp";
        return url;
    }

}
