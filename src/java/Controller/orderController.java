/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.OrderDAO;
import DTO.OrderDTO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.jsp.PageContext;

/**
 *
 * @author Admin
 */
@WebServlet(name = "orderController", urlPatterns = {"/orderController"})
public class orderController extends HttpServlet {

    private static String url = "BookingStep1.jsp";

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
        HttpSession session = request.getSession(false);

        try {

            if ("call_oder_step2".equals(action)) {
                OrderDAO odao = new OrderDAO();
                //lay thong tin de tao dtb booking
                double total = Double.parseDouble(request.getParameter("totalBill"));
                int numberTicket = Integer.parseInt(request.getParameter("numberTicket"));
                String idTour = request.getParameter("idTour");
                int idUser = Integer.parseInt(request.getParameter("idUser")) ;
                String bookingDate = String.valueOf(request.getParameter("bookingDate"));
                int status = Integer.parseInt(request.getParameter("status"));
                String note = request.getParameter("noteValueInput");
                String idBooking = odao.generateBookingId(idTour);

                OrderDTO newBooking = new OrderDTO(idUser, idTour, bookingDate, numberTicket, total, status, idBooking, note);
                if (odao.create(newBooking)) {
                    url = "BookingStep2.jsp";
                    request.setAttribute("total", total);
                    request.setAttribute("numberTicket", numberTicket);
                }else {
                    System.out.println("tao loi roi ma");
                }

            } else if ("call_oder_step3".equals(action)) {

                String total = request.getParameter("totalBill2");
                String numberTicket = request.getParameter("numberTicket2");
                url = "Payment.jsp";
                request.setAttribute("total", total);
                request.setAttribute("numberTicket", numberTicket);

            }
            String paymentMethod = request.getParameter("paymentMethod");
            if ("momo".equals(paymentMethod)) {
                // redirect sang cổng Momo
            } else if ("vnpay".equals(paymentMethod)) {
                // redirect sang cổng VNPay
            } else {
                // xử lý thanh toán tại quầy, v.v.
            }
        } catch (Exception e) {
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
