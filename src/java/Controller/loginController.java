
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;


import DAO.PlacesDAO;
import DAO.TourTicketDAO;
import DAO.TicketImgDAO;
import DAO.UserDAO;
import DTO.PlacesDTO;
import DTO.TourTicketDTO;
import DTO.TicketImgDTO;
import DTO.UserDTO;
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
                    if (redirectUrl != null) {
                        //di vao chi tiet tour    
                        String idTour = (String) session.getAttribute("idTour");

                        if (idTour != null && !idTour.trim().isEmpty()) {
                            TicketImgDTO tourDetail = tdDao.readbyID(idTour);
                            TourTicketDTO tourTicket = tdao.readbyID(idTour);
                            request.setAttribute("tourDetail", tourDetail);
                            request.getSession().setAttribute("tourTicket", tourTicket);
                            session.removeAttribute("idTour"); // Xóa sau khi dùng
                        }
                        url = redirectUrl;
                        session.removeAttribute("redirectAfterLogin");

                    } else {
                       // Gọi hàm getFeaturedPlaces để lấy danh sách địa điểm và gán vào request
                        pcl.getFeaturedPlaces(request, response);
                        url = "index.jsp";
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
                pcl.getFeaturedPlaces(request, response);
                url = "index.jsp";

            } else if ("order".equals(action)) {
                String idTour = (String) request.getParameter("idTour");
                // Truy cập trang đặt hàng
                // kiểm tra login chưa 
                if (AuthUtils.isLoggedIn(session)) {
                    if (idTour != null && !idTour.trim().isEmpty()) {
                        TourTicketDTO tour = tdao.readbyID(idTour);
                        session.setAttribute("tourTicket", tour);
                        url = "BookingStep1.jsp";
                    }
                    
                } else {
                    // Chưa login => lưu trang cần redirect sau login, rồi chuyển tới login page
                    session = request.getSession(true);
                    if (idTour != null) {
                        session.setAttribute("idTour", idTour);
                    }
                    session.setAttribute("redirectAfterLogin", "BookingStep1.jsp");
                    url = LOGIN_PAGE;
                    request.setAttribute("message", "Login to place order");
                }

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
