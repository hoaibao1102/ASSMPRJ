/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.OrderDAO;
import DAO.StartDateDAO;
import DAO.TourTicketDAO;
import DTO.OrderDTO;
import DTO.StartDateDTO;
import DTO.TourTicketDTO;
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
        OrderDAO odao = new OrderDAO();
        TourTicketDAO tourTicketdao = new TourTicketDAO();
        StartDateDAO stDao = new StartDateDAO();
        
        try {

            if ("call_oder_step2".equals(action)) {
                
                //lay thong tin de tao dtb booking
                double total = Double.parseDouble(request.getParameter("totalBill"));
                int numberTicket = Integer.parseInt(request.getParameter("numberTicket"));
                String idTour = request.getParameter("idTour");
                int idUser = Integer.parseInt(request.getParameter("idUser")) ;
                String bookingDate = String.valueOf(request.getParameter("bookingDate"));
                int status = Integer.parseInt(request.getParameter("status"));
                String note = request.getParameter("noteValueInput");
                String idBooking = odao.generateBookingId(idTour);
                int startNum = Integer.parseInt(request.getParameter("startNum"));

                OrderDTO newBooking = new OrderDTO(idUser, idTour, bookingDate, numberTicket, total, status, idBooking, note,startNum);
                if (odao.create(newBooking)) {
                    url = "BookingStep2.jsp";
                    request.setAttribute("newBooking", newBooking);
                   
                }else {
                    System.out.println("tao loi roi ma");
                    
                }

            } else if ("call_oder_step3".equals(action)) {
                String idBooking = request.getParameter("idBooking");
                Double total =Double.parseDouble(request.getParameter("totalBill2")) ;
                int numberTicket = Integer.parseInt(request.getParameter("numberTicket2"));
                
                // lấy ra quantities để trừ đặt vé
                OrderDTO orderdto = odao.readbyID(idBooking);
                String idTour = orderdto.getIdTour();
                int startNum = orderdto.getStartNum();
                StartDateDTO startDate = stDao.searchDetailDate(idTour, startNum);
                int newQuan = startDate.getQuantity()- numberTicket;
                startDate.setQuantity(newQuan);
                
                boolean isUpdate = stDao.update(startDate);
                System.out.println(isUpdate);
                //update trang thai
                if(odao.updateStatus(idBooking) && isUpdate ){
                    url = "BookingStep3.jsp";
                    
                    request.setAttribute("startDate", startDate);
                    request.setAttribute("total", total);
                    request.setAttribute("idBooking", idBooking);
                    request.setAttribute("numberTicket", numberTicket);
                }else{
                    System.out.println("khong update duoc tu tim lai");
                }
              
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