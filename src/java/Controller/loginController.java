
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.FavoritesDAO;
import DAO.PlacesDAO;
import DAO.StartDateDAO;
import DAO.TourTicketDAO;
import DAO.TicketImgDAO;
import DAO.UserDAO;
import DAO.VoucherDAO;
import DTO.FavoritesDTO;
import DTO.PlacesDTO;
import DTO.StartDateDTO;
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
            // Kiểm tra session có lưu URL redirect không
            String redirectUrl = (String) session.getAttribute("redirectAfterLogin");
            String actionCheck = (String) session.getAttribute("action");

            if (redirectUrl != null && actionCheck != null) {
                switch (actionCheck) {
                    case "order": {
                        if (AuthUtils.isCustomer(session)) {
                            String idTour = (String) session.getAttribute("idTour");
                            Date startDate = (Date) session.getAttribute("startDate");

                            VoucherDAO vcdao = new VoucherDAO();
                            List<VoucherDTO> listVouchers = vcdao.getAllVoucherActive();
                            //tao bien phu de xoa 2 voucher co dinh                
                            VoucherDTO xoa1 = null;
                            VoucherDTO xoa2 = null;

                            for (VoucherDTO i : listVouchers) {
                                if (i.getTitle().equals("Mã giảm giá cố định cho bé từ 2-6 tuổi")) {
                                    request.setAttribute("child", i);
                                    xoa1 = i;
                                }
                                System.out.println("=======");
                                System.out.println(i.getTitle());
                                if (i.getTitle().contains("Mã giảm giá cố định cho em bé dưới 2 tuổi")) {
                                    request.setAttribute("baby", i);
                                    xoa2 = i;
                                }

                            }

                            listVouchers.remove(xoa1);
                            listVouchers.remove(xoa2);

                            request.setAttribute("listVouchers", listVouchers);
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
