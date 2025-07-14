/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.VoucherDAO;
import DTO.VoucherDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet(name = "voucherController", urlPatterns = {"/voucherController"})
public class voucherController extends HttpServlet {

    private static String URL = "index.jsp";
    private static String CREATE_VOUCHER_FORM = "createVoucherForm.jsp";
    private static String VOUCHERS_MANAGER_PAGE = "vouchersManagement.jsp";
    VoucherDAO vcdao = new VoucherDAO();
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
            if (UTILS.AuthUtils.isAdmin(session)) {
                if (action.equals("goVoucherPage")) {
                    URL = handleGoVouchersManagement(request, response);
                }else if (action.equals("goCreateNewVoucherForm")) {
                    URL = handleGoCreateNewVoucherForm(request, response);
                }else if (action.equals("createNewVoucher")) {
                    URL = handleCreateNewVoucher(request, response);
                }else if (action.equals("deleteVoucher")) {
                    URL = handleDeleteVoucher(request, response);
                }else if (action.equals("reuseVoucher")) {
                    URL = handleReuseVoucher(request, response);
                }
                else if (action.equals("goReuseVoucherForm")) {
                    URL = handleGoReuseVoucherForm(request, response);
                }
            }

        } catch (Exception e) {
        } finally {
            request.getRequestDispatcher(URL).forward(request, response);
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

    private String handleGoVouchersManagement(HttpServletRequest request, HttpServletResponse response) {
        List<VoucherDTO> listVoucher = vcdao.getAllVoucher();
        request.setAttribute("listVoucher", listVoucher);
        return VOUCHERS_MANAGER_PAGE;
    }

    private String handleGoCreateNewVoucherForm(HttpServletRequest request, HttpServletResponse response) {
        return CREATE_VOUCHER_FORM;
    }

    private String handleCreateNewVoucher(HttpServletRequest request, HttpServletResponse response) {
        VoucherDTO vcdto = getInforFromForm(request, response);
        vcdao.createNewVoucher(vcdto);
        return "MainController?action=goVoucherPage";
    }

    private String handleDeleteVoucher(HttpServletRequest request, HttpServletResponse response) {
        int voucherID = Integer.parseInt(request.getParameter("voucherID"));
        vcdao.deleteVoucher(voucherID);
        return "MainController?action=goVoucherPage";
    }
    
    private VoucherDTO getInforFromForm(HttpServletRequest request, HttpServletResponse response){
        String title = request.getParameter("title");
        String startDate = request.getParameter("startDate");
        Double discount = Double.parseDouble(request.getParameter("discount"));
        Double minimumOrderValue = Double.parseDouble(request.getParameter("minimumOrderValue"));
        int numbers = Integer.parseInt(request.getParameter("numbers"));
        int duration = Integer.parseInt(request.getParameter("duration"));
        
        VoucherDTO vcdto = new VoucherDTO(title, startDate, discount, numbers, duration, minimumOrderValue);
        return vcdto;
    }

    private String handleReuseVoucher(HttpServletRequest request, HttpServletResponse response) {
        int voucherID = Integer.parseInt(request.getParameter("voucherID"));
        VoucherDTO vcdto = getInforFromForm(request, response);
        vcdao.updateVoucher(voucherID, vcdto);
        return "MainController?action=goVoucherPage";
    }

    private String handleGoReuseVoucherForm(HttpServletRequest request, HttpServletResponse response) {
        int voucherID = Integer.parseInt(request.getParameter("voucherID"));
        System.out.println(voucherID);
        VoucherDTO vcdto = vcdao.getVoucherByID(voucherID);
        request.setAttribute("voucher", vcdto);
        return CREATE_VOUCHER_FORM;
    }

}
