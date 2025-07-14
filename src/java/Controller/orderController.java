/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.OrderDAO;
import DAO.StartDateDAO;
import DAO.TicketImgDAO;
import DAO.TourTicketDAO;
import DAO.VoucherDAO;
import DTO.OrderDTO;
import DTO.StartDateDTO;
import DTO.TourTicketDTO;
import DTO.UserDTO;
import DTO.VoucherDTO;
import UTILS.AuthUtils;
import UTILS.EmailUtils;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Admin
 */
@WebServlet(name = "orderController", urlPatterns = {"/orderController"})
public class orderController extends HttpServlet {

    private static String url = "BookingStep1.jsp";
    private static final String LOGIN_PAGE = "LoginForm.jsp";
    TicketImgDAO tdDao = new TicketImgDAO();
    StartDateDAO stDao = new StartDateDAO();
    TourTicketDAO tdao = new TourTicketDAO();

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

        try {

            if ("call_oder_step2".equals(action)) {
                url = handleCallStep2(request, response);
            } else if ("call_oder_step3".equals(action)) {
                url = handleCallStep3(request, response);
                //HuyCODE
            } else if ("openPayModal".equals(action)) {
                url = handleUserOrder(request, response);
            } else if ("updatePayOrder".equals(action)) {
                url = handleUpdateOrder(request, response);
            } else if ("order".equals(action)) {
                url = handleOder(request, response);

            }
            // thao tac phuong thuc thanh toan
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

    private String handleUserOrder(HttpServletRequest request, HttpServletResponse response) {
        String idBooking = request.getParameter("idBooking");
        String totalPrice = request.getParameter("totalPrice");
        String numberTicket = request.getParameter("numberTicket");
        request.setAttribute("showModal", true);
        request.setAttribute("idBooking", idBooking);
        request.setAttribute("totalPrice", totalPrice);
        request.setAttribute("numberTicket", numberTicket);

        // LẤY LẠI DANH SÁCH ĐƠN HÀNG VÀ MAP NGÀY KHỞI HÀNH
        UserDTO user = (UserDTO) request.getSession().getAttribute("nameUser");
        int userId = user.getIdUser();
        OrderDAO odao = new OrderDAO();
        StartDateDAO stDao = new StartDateDAO();
        List<OrderDTO> list = odao.getAllOrdersByUser(userId);
        Map<String, String> startDateMap = new HashMap<>();
        for (OrderDTO order : list) {
            StartDateDTO startDate = stDao.searchDetailDate(order.getIdTour(), order.getStartNum());
            startDateMap.put(order.getIdBooking(), startDate.getStartDate());
        }
        request.setAttribute("list", list);
        request.setAttribute("startDateMap", startDateMap);
        // ===HuyCODE add===
        TourTicketDAO tourTicketdao = new TourTicketDAO();
        Map<String, String> tourImgMap = new HashMap<>();
        for (OrderDTO order : list) {
            String imgUrl = tourTicketdao.getAvatarByIdTour(order.getIdTour());
            tourImgMap.put(order.getIdTour(), imgUrl);
        }
        request.setAttribute("tourImgMap", tourImgMap);
        //=====
        return "OrderOfUser.jsp";

    }

    private String handleUpdateOrder(HttpServletRequest request, HttpServletResponse response) {
        String idBooking = request.getParameter("idBooking");
        int numberTicket = Integer.parseInt(request.getParameter("numberTicket2"));
        String paymentMethod = request.getParameter("paymentMethod");
        OrderDAO odao = new OrderDAO();
        StartDateDAO stDao = new StartDateDAO();

        // Cập nhật số lượng vé và trạng thái đơn
        OrderDTO orderdto = odao.readbyID(idBooking);
        String idTour = orderdto.getIdTour();
        int startNum = orderdto.getStartNum();
        StartDateDTO startDate = stDao.searchDetailDate(idTour, startNum);
        int newQuan = startDate.getQuantity() - numberTicket;
        startDate.setQuantity(newQuan);

        boolean isUpdate = stDao.update(startDate);
        boolean isOrderUpdated = odao.updateStatus(idBooking);

        // LẤY LẠI DANH SÁCH ĐƠN HÀNG VÀ MAP NGÀY KHỞI HÀNH
        UserDTO user = (UserDTO) request.getSession().getAttribute("nameUser");
        int idUser = user.getIdUser();
        List<OrderDTO> list = odao.getAllOrdersByUser(idUser);
        Map<String, String> startDateMap = new HashMap<>();
        for (OrderDTO order : list) {
            StartDateDTO startDate1 = stDao.searchDetailDate(order.getIdTour(), order.getStartNum());
            startDateMap.put(order.getIdBooking(), startDate1.getStartDate());
        }
        request.setAttribute("list", list);
        request.setAttribute("startDateMap", startDateMap);
        // ===HuyCODE add===
        TourTicketDAO tourTicketdao = new TourTicketDAO();
        Map<String, String> tourImgMap = new HashMap<>();
        for (OrderDTO order : list) {
            String imgUrl = tourTicketdao.getAvatarByIdTour(order.getIdTour());
            tourImgMap.put(order.getIdTour(), imgUrl);
        }
        request.setAttribute("tourImgMap", tourImgMap);
        //=====
        if (isUpdate && isOrderUpdated) {
            request.setAttribute("message", "Thanh toán thành công bằng "
                    + ("momo".equals(paymentMethod) ? "Momo"
                    : "vnpay".equals(paymentMethod) ? "VNPay" : "tại quầy") + "!");
            url = "OrderOfUser.jsp";
        } else {
            request.setAttribute("message", "Có lỗi xảy ra khi cập nhật đơn hàng.");
            url = "OrderOfUser.jsp";
        }
        return url;
    }

    private String handleCallStep2(HttpServletRequest request, HttpServletResponse response) {         
        try {
            int voucherID = Integer.parseInt(request.getParameter("voucherID"));
            VoucherDAO vcdao = new VoucherDAO();
            vcdao.subQuantity(voucherID);
        } catch (Exception e) {           
        }
        
    //lay thong tin de tao dtb booking
        OrderDAO odao = new OrderDAO();
        double total = Double.parseDouble(request.getParameter("totalBill"));
        int numberTicket = Integer.parseInt(request.getParameter("numberTicket"));
        String idTour = request.getParameter("idTour");
        int idUser = Integer.parseInt(request.getParameter("idUser"));
        String bookingDate = String.valueOf(request.getParameter("bookingDate"));
        int status = Integer.parseInt(request.getParameter("status"));
        String note = request.getParameter("noteValueInput");
        String idBooking = odao.generateBookingId(idTour);
        int startNum = Integer.parseInt(request.getParameter("startNum"));

        OrderDTO newBooking = new OrderDTO(idUser, idTour, bookingDate, numberTicket, total, status, idBooking, note, startNum);
        if (odao.create(newBooking)) {
            request.setAttribute("newBooking", newBooking);
            return "BookingStep2.jsp";
        } else {
            System.out.println("tao loi roi ma");

        }
        return null;
    }

    private String handleCallStep3(HttpServletRequest request, HttpServletResponse response) {
        OrderDAO odao = new OrderDAO();
        StartDateDAO stDao = new StartDateDAO();
        HttpSession session = request.getSession(false);
        TourTicketDAO tourTicketdao = new TourTicketDAO();
        String idBooking = request.getParameter("idBooking");
        Double total = Double.parseDouble(request.getParameter("totalBill2"));
        int numberTicket = Integer.parseInt(request.getParameter("numberTicket2"));

        // lấy ra quantities để trừ đặt vé
        OrderDTO orderdto = odao.readbyID(idBooking);
        String idTour = orderdto.getIdTour();
        TourTicketDTO tour = tourTicketdao.readbyID(idTour);
        int startNum = orderdto.getStartNum();
        StartDateDTO startDate = stDao.searchDetailDate(idTour, startNum);
        int newQuan = startDate.getQuantity() - numberTicket;
        startDate.setQuantity(newQuan);

        boolean emailSent = EmailUtils.sendBillThroughEmail(
                UTILS.AuthUtils.getCurrentUser(session).getEmail(),
                UTILS.AuthUtils.getCurrentUser(session).getFullName(),
                tour.getNametour(),
                startDate.getStartDate(),
                numberTicket,
                total
        );

        if (emailSent) {
            request.setAttribute("message", "Đặt tour thành công! Email xác nhận đã được gửi.");
            request.setAttribute("messageType", "success");
        } else {
            request.setAttribute("message", "Đặt tour thành công nhưng không thể gửi email xác nhận.");
            request.setAttribute("messageType", "warning");
        }
        System.out.println("==============");
        System.out.println(total);
        boolean isUpdate = stDao.update(startDate);
        System.out.println(isUpdate);
        //update trang thai
        if (odao.updateStatus(idBooking) && isUpdate) {
            request.setAttribute("startDate", startDate);
            request.setAttribute("total", total);
            request.setAttribute("idBooking", idBooking);
            request.setAttribute("numberTicket", numberTicket);
            return "BookingStep3.jsp";
        } else {
            System.out.println("khong update duoc tu tim lai");
        }
        return null;
    }

    private String handleOder(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(false);
        String idTour = (String) request.getParameter("idTour");
        int startNum = Integer.parseInt(request.getParameter("startNum"));
        // Truy cập trang đặt hàng
        // kiểm tra login chưa 
        if (AuthUtils.isLoggedIn(session)) {
            if (idTour != null && !idTour.trim().isEmpty()) {
                TourTicketDTO tour = tdao.readbyID(idTour);
                StartDateDTO stDate = stDao.searchDetailDate(idTour, startNum);
                VoucherDAO vcdao = new VoucherDAO();
                List<VoucherDTO> listVouchers = vcdao.getAllVoucherActive();
                //tao bien phu de xoa 2 voucher co dinh                
                VoucherDTO xoa1 = null;
                VoucherDTO xoa2 = null;
                
                for(VoucherDTO i : listVouchers){
                    if(i.getTitle().equals("Mã giảm giá cố định cho bé từ 2-6 tuổi")){
                        request.setAttribute("child", i);
                        xoa1 = i;
                    }
                    System.out.println("=======");
                        System.out.println(i.getTitle());
                    if(i.getTitle().contains("Mã giảm giá cố định cho em bé dưới 2 tuổi")){
                        request.setAttribute("baby", i);
                        xoa2 = i;
                    }
                    
                }
                
                listVouchers.remove(xoa1);
                listVouchers.remove(xoa2);
                
                request.setAttribute("listVouchers", listVouchers);
                session.setAttribute("stDate", stDate);
                session.setAttribute("tourTicket", tour);

                url = "BookingStep1.jsp";
            }

        } else {
            // Chưa login => lưu trang cần redirect sau login, rồi chuyển tới login page
            session = request.getSession(false);
            if (idTour != null) {
                session.setAttribute("idTour", idTour);
                session.setAttribute("startNum", startNum);
                session.setAttribute("action", "order");
            }
            session.setAttribute("redirectAfterLogin", "BookingStep1.jsp");
            url = LOGIN_PAGE;
            request.setAttribute("message", "Login to place order");
        }
        return url;
    }

}
