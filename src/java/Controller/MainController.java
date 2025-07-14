/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author MSI PC
 */
@WebServlet(name = "MainController", urlPatterns = {"/MainController"})
public class MainController extends HttpServlet {

    private static final String INDEX_PAGE = "index.jsp";

    private static final String PLACE_CONTROLLER = "placeController";
    private static final String USER_CONTROLLER = "userController";
    private static final String ORDER_CONTROLLER = "orderController";
    private static final String VOUCHER_CONTROLLER = "voucherController";

    private boolean isUserAction(String action) {
        return "login".equals(action)
                || "logout".equals(action)
                || "orderOfUser".equals(action)
                || "listUser".equals(action)
                || "editProfile".equals(action)
                || "updateProfile".equals(action)
                || "addReview".equals(action)
                || "updateReview".equals(action)
                || "deleteReview".equals(action)
                || "addFavoriteTour".equals(action)
                || "showFavoriteList".equals(action)
                || "removeFavorite".equals(action);
    }

    private boolean isVoucherAction(String action) {
        return "goVoucherPage".equals(action)
                || "goCreateNewVoucherForm".equals(action)
                || "createNewVoucher".equals(action)
                || "reuseVoucher".equals(action)
                || "goReuseVoucherForm".equals(action)
                || "deleteVoucher".equals(action);

    }

    private boolean isPlaceAction(String action) {
        return "destination".equals(action)
                || "takeListTicket".equals(action)
                || "ticketDetail".equals(action)
                || "search".equals(action)
                || "updatePlace".equals(action)
                || "deletePlace".equals(action)
                || "addNewPlace".equals(action)
                || "updateNewPlace".equals(action)
                || "addPlace".equals(action)
                || "updateTicket".equals(action)
                || "addTicket".equals(action)
                || "deleteTicket".equals(action)
                || "submitAddTour".equals(action)
                || "submitUpdateTour".equals(action);

    }

    private boolean isOrderAction(String action) {
        return "call_oder_step2".equals(action)
                || "call_oder_step3".equals(action)
                || "openPayModal".equals(action)
                || "updatePayOrder".equals(action)
                || "order".equals(action);
    }

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
        String action = request.getParameter("action");
        String url = INDEX_PAGE; // Default

        try {

            if (action == null) {
                url = INDEX_PAGE;
            } else if (isOrderAction(action)) {
                url = ORDER_CONTROLLER;
            } else if (isUserAction(action)) {
                url = USER_CONTROLLER;
            } else if (isPlaceAction(action)) {
                url = PLACE_CONTROLLER;
            } else if (isVoucherAction(action)) {
                url = VOUCHER_CONTROLLER;
            }

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

}
