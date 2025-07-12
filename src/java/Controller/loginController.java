
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
import java.util.List;

/**
 *
 * @author MSI PC
 */
@WebServlet(name = "loginController", urlPatterns = {"/loginController"})
public class loginController extends HttpServlet {

    private static final String INDEX_PAGE = "index.jsp";
    private static final String LOGIN_PAGE = "LoginForm.jsp";

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
        HttpSession session = request.getSession(false);
        TicketImgDAO tdDao = new TicketImgDAO();
        TourTicketDAO tdao = new TourTicketDAO();
        placeController pcl = new placeController();
        StartDateDAO stDao = new StartDateDAO();
        FavoritesDAO fDAO = new FavoritesDAO();

        try {
            if (action == null) {
                url = LOGIN_PAGE;
            } else if ("login".equals(action)) {
                // Lấy thông tin đăng nhập từ form
                String txtEmailOrPhone = request.getParameter("txtEmailOrPhone");
                String txtPassword = request.getParameter("txtPassword");

                if (AuthUtils.isValidLogin(txtEmailOrPhone, txtPassword)) {
                    // Lấy user và lưu vào session
                    UserDTO user = AuthUtils.getUser(txtEmailOrPhone);
                    session = request.getSession(true);
                    session.setAttribute("nameUser", user);

                    // Kiểm tra session có lưu URL redirect không
                    String redirectUrl = (String) session.getAttribute("redirectAfterLogin");
                    String actionCheck = (String) session.getAttribute("action");

                    if (redirectUrl != null && actionCheck != null) {
                        switch (actionCheck) {
                            case "order": {
                                if (AuthUtils.isCustomer(session)) {
                                    String idTour = (String) session.getAttribute("idTour");
                                    Integer startNum = (Integer) session.getAttribute("startNum");

                                    if (idTour != null && startNum != null) {
                                        TourTicketDTO tourTicket = tdao.readbyID(idTour);
                                        StartDateDTO stDate = stDao.searchDetailDate(idTour, startNum);
                                        session.setAttribute("stDate", stDate);
                                        session.setAttribute("tourTicket", tourTicket);
                                        session.removeAttribute("idTour");
                                        session.removeAttribute("startNum");
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
                                // ✅ Load lại danh sách tour dựa vào location
                                if (location1 != null && !location1.trim().isEmpty()) {
                                    location1 = location1.trim();
                                    List<TourTicketDTO> tourList = tdao.searchByDestination(location1);
                                    String discriptionPlaces = pdao.readByName(location1).getDescription();

                                    for (int i = 0; i < tourList.size(); i++) {
                                        List<StartDateDTO> startDateTour = stdDAO.search(tourList.get(i).getIdTourTicket());
                                        request.setAttribute("startDateTour" + (i + 1), startDateTour);
                                    }

                                    request.setAttribute("tourList", tourList);
                                    request.setAttribute("discriptionPlaces", discriptionPlaces);
                                    request.setAttribute("location", location1);
                                    session.setAttribute("message", "Đã thêm vào yêu thích!");
                                    url = "TourTicketForm.jsp";
                                    session.removeAttribute("location1");
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

            } else if ("logout".equals(action)) {
                // Xử lý logout: invalidate session nếu có
                if (session != null) {
                    session.invalidate();
                }
                // Gọi hàm getFeaturedPlaces để lấy danh sách địa điểm và gán vào request
                pcl.getAllDestination(request, response);
                url = "index.jsp";
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

}
