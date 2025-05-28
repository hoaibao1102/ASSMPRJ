
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.TourDAO;
import DAO.TourDetailDAO;
import DTO.TourDTO;
import DTO.TourDetailDTO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 *
 * @author MSI PC
 */
@WebServlet(name = "placeController", urlPatterns = {"/placeController"})
public class placeController extends HttpServlet {

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
        TourDAO tdao = new TourDAO();
        String location = request.getParameter("location");

        //lay ra list tour
        if (location != null && !location.trim().isEmpty()) {
            location = location.trim(); // loại bỏ khoảng trắng đầu/cuối
            List<TourDTO> tour = tdao.search(location);
            request.setAttribute("tourList", tour);
            request.getRequestDispatcher("TourListForm.jsp").forward(request, response);
        }

        //di vao chi tiet tour    
        TourDetailDAO tdDao = new TourDetailDAO();
        String idTour = request.getParameter("idTour");
        if (idTour != null && !idTour.trim().isEmpty()) {
            TourDetailDTO tourDetail = tdDao.readbyID(idTour);

            TourDTO tourTicket = tdao.readbyID(idTour); 
            
            request.setAttribute("tourDetail", tourDetail);
            request.setAttribute("tourTicket", tourTicket);
            request.getRequestDispatcher("TourDetailForm.jsp").forward(request, response);
        }
        
        
        //lay ra thông tin search
        String searchTour = request.getParameter("searchTour");
        //lay ra list tour
        if (searchTour != null && !searchTour.trim().isEmpty()) {
            searchTour = searchTour.trim(); // loại bỏ khoảng trắng đầu/cuối
            List<TourDTO> tour2 = tdao.searchAnyInfor(searchTour);
            request.setAttribute("tourList2", tour2);
            request.setAttribute("searchTourInfor", searchTour);
            request.getRequestDispatcher("ResultSearchForm.jsp").forward(request, response);
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
