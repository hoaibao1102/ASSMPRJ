
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.PlacesDAO;
import DAO.StartDateDAO;
import DAO.TicketDayDetailDAO;
import DAO.TicketImgDAO;
import DAO.TourTicketDAO;
import DTO.PlacesDTO;
import DTO.StartDateDTO;
import DTO.TicketDayDetailDTO;
import DTO.TourTicketDTO;
import DTO.TicketImgDTO;
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

    private static String URL = "index.jsp";

    public void getAllDestination(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = URL;
        PlacesDAO pdao = new PlacesDAO();
        List<PlacesDTO> places = pdao.readAll();
        request.setAttribute("placeList", places);
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
        //cac DAO
        TourTicketDAO tdao = new TourTicketDAO();
        PlacesDAO pdao = new PlacesDAO();
        TicketDayDetailDAO tddDao = new TicketDayDetailDAO();
        TicketImgDAO tiDAO = new TicketImgDAO();
        StartDateDAO stdDAO = new StartDateDAO();

        String action = request.getParameter("action");
        String url = URL;

        try {
            if (action.equals("destination")) {
                // Gọi hàm getFeaturedPlaces để lấy danh sách địa điểm và gán vào request
                getAllDestination(request, response);

                String page = request.getParameter("page");
                if (page.equals("indexjsp")) {
                    url = "index.jsp";
                } else {
                    url = "DestinationForm.jsp";
                }

            } else if (action.equals("takeListTicket")) {
                String location = request.getParameter("location");
                //lay ra list tour
                if (location != null && !location.trim().isEmpty()) {
                    location = location.trim(); // loại bỏ khoảng trắng đầu/cuối
                    //lấy ra các cái vé từ tên location
                    List<TourTicketDTO> tour = tdao.searchByDestination(location);

                    //Lay ra mo ta cua tung noi 
                    String discriptionPlaces = pdao.readByName(location).getDescription();
                    System.out.println("vào thành công");
                    for (int i = 0; i < tour.size(); i++) {
                        // lấy ra các ngày đi 
                        List<StartDateDTO> startDateTour = stdDAO.search(tour.get(i).getIdTourTicket());
                        request.setAttribute("startDateTour"+(i+1), startDateTour);
                    }
                    System.out.println("vào thành công");
                    request.setAttribute("discriptionPlaces", discriptionPlaces);
                    request.setAttribute("tourList", tour);
                    url = "TourTicketForm.jsp";
                } else {
                    System.out.println("không qua du?c ba ");
                }

            } else if (action.equals("ticketDetail")) {
                //di vao chi tiet tour    
                String idTour = request.getParameter("idTourTicket");
                if (idTour != null && !idTour.trim().isEmpty()) {
                    List<TicketImgDTO> ticketImgDetail = tiDAO.readbyIdTourTicket(idTour);
                    List<TicketDayDetailDTO> ticketDayDetail = tddDao.readbyIdTourTicket(idTour);
                    TourTicketDTO tourTicket = tdao.readbyID(idTour);
                    
                    // lấy ra các ngày đi 
                    List<StartDateDTO> startDateTour = stdDAO.search(tourTicket.getIdTourTicket());
                    
                    request.setAttribute("startDateTour", startDateTour);
                    request.setAttribute("ticketImgDetail", ticketImgDetail);
                    request.setAttribute("ticketDayDetail", ticketDayDetail);
                    request.setAttribute("tourTicket", tourTicket);
                    url = "TicketDetailForm.jsp";
                }
            } else if (action.equals("search")) {
                //lay ra thông tin search
                String searchItem = request.getParameter("searchItem");
                //lay ra list tour
                if (searchItem != null && !searchItem.trim().isEmpty()) {
                    // Gọi hàm getFeaturedPlaces để lấy danh sách địa điểm và gán vào request
                    getAllDestination(request, response);

                    searchItem = searchItem.trim(); // loại bỏ khoảng trắng đầu/cuối
                    List<TourTicketDTO> tour2 = tdao.searchAnyInfor(searchItem);
        
                    for (int i = 0; i < tour2.size(); i++) {
                        // lấy ra các ngày đi 
                        List<StartDateDTO> startDateTour = stdDAO.search(tour2.get(i).getIdTourTicket());
                        request.setAttribute("startDateTour"+(i+1), startDateTour);
                    }
                    request.setAttribute("tourList2", tour2);
                    request.setAttribute("searchTourInfor", searchItem);
                    url = "ResultSearchForm.jsp";

                }
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

}
