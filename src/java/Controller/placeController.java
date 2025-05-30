
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.PlacesDAO;
import DAO.TourDAO;
import DAO.TourDetailDAO;
import DTO.PlacesDTO;
import DTO.TourDTO;
import DTO.TourDetailDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

/**
 *
 * @author MSI PC
 */
@WebServlet(name = "placeController", urlPatterns = {"/placeController"})
public class placeController extends HttpServlet {

    private static String URL = "index.jsp";
    private static final Logger LOGGER = Logger.getLogger(placeController.class.getName());

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
        PlacesDAO pdao = new PlacesDAO();
        String action = request.getParameter("action");
        String url = URL;
        
        try {
            if (action.equals("destination")) {
                List<PlacesDTO> places = pdao.readAll();
                request.setAttribute("placeList", places);
                url = "DestinationForm.jsp";

            } else if (action.equals("takeListTour")) {
                String location = request.getParameter("location");
                //lay ra list tour
                if (location != null && !location.trim().isEmpty()) {
                    location = location.trim(); // loại bỏ khoảng trắng đầu/cuối
                    List<TourDTO> tour = tdao.search(location);
                    request.setAttribute("tourList", tour);
                    url = "TourListForm.jsp";
                }

            } else if (action.equals("tourDetail")) {
                //di vao chi tiet tour    
                TourDetailDAO tdDao = new TourDetailDAO();
                String idTour = request.getParameter("idTour");
                if (idTour != null && !idTour.trim().isEmpty()) {
                    TourDetailDTO tourDetail = tdDao.readbyID(idTour);

                    TourDTO tourTicket = tdao.readbyID(idTour);

                    request.setAttribute("tourDetail", tourDetail);
                    request.setAttribute("tourTicket", tourTicket);
                    url = "TourDetailForm.jsp";
                }
            } else if (action.equals("search ")) {
                //lay ra thông tin search
                String searchTour = request.getParameter("searchTour");
                //lay ra list tour
                if (searchTour != null && !searchTour.trim().isEmpty()) {
                    searchTour = searchTour.trim(); // loại bỏ khoảng trắng đầu/cuối
                    List<TourDTO> tour2 = tdao.searchAnyInfor(searchTour);
                    request.setAttribute("tourList2", tour2);
                    request.setAttribute("searchTourInfor", searchTour);
                    url ="ResultSearchForm.jsp";
                   
                }
            }

        } catch (Exception e) {
            LOGGER.severe("Error in placeController: " + e.toString());
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
