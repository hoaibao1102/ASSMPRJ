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
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
    StartDateDAO stdao= new StartDateDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String url = "";
        try {
            String action = request.getParameter("action");
            if ("orderOfUser".equals(action)) {
                url = handleUserOrder(request, response);
            } else if ("listUser".equals(action) || action == null) {
                url = handleUserListing(request, response);
            }
        } catch (Exception e) {
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
        Map<String,String> startDateMap = new HashMap<>();
        for (OrderDTO order : list) {
            int stNum =order.getStartNum();
            String idTour = order.getIdTour();
            String idBooking = order.getIdBooking();
            
            StartDateDTO st = stdao.searchDetailDate(idTour, stNum);
            String date = st.getStartDate();
            
            startDateMap.put(idBooking,date);
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

}
