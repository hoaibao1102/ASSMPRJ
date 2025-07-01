
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
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collection;
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
        List<PlacesDTO> places = null;
        places = pdao.readAll();
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
    protected String getTomorrow() {
        return LocalDate.now().plusDays(1).toString();
    }

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

        System.out.println(action);
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

                    for (int i = 0; i < tour.size(); i++) {
                        // lấy ra các ngày đi 
                        List<StartDateDTO> startDateTour = stdDAO.search(tour.get(i).getIdTourTicket());
                        request.setAttribute("startDateTour" + (i + 1), startDateTour);
                    }

                    request.setAttribute("discriptionPlaces", discriptionPlaces);
                    request.setAttribute("tourList", tour);
                    url = "TourTicketForm.jsp";
                } else {
                    System.out.println("không qua duoc ba ");
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
                        request.setAttribute("startDateTour" + (i + 1), startDateTour);
                    }
                    request.setAttribute("tourList2", tour2);
                    request.setAttribute("searchTourInfor", searchItem);
                    url = "ResultSearchForm.jsp";

                }

            } else if (action.equals("updatePlace")) {
                String location = request.getParameter("location");
                String img = request.getParameter("img");
                String description = request.getParameter("description");

                PlacesDTO place = new PlacesDTO(location, description, img, true, true);
                request.setAttribute("place", place);
                url = "createPlace.jsp";
            } else if (action.equals("deletePlace")) {
                String placeName = request.getParameter("location");
                PlacesDTO place = pdao.readByName(placeName);
                place.setStatus(false);
                pdao.update(place);
                url = "placeController?action=destination&page=destinationjsp";
            } else if (action.equals("addPlace")) {
                url = "createPlace.jsp";
            } // THÊM ĐIỂM ĐẾN
            else if (action.equals("addNewPlace")) {
                //lay ra thông tin newPlace
                String placename = request.getParameter("placename");
                String description = request.getParameter("description");
                String txtImage = request.getParameter("txtImage");
                boolean Featured = request.getParameter("Featured").equals("1");
                boolean status = request.getParameter("status").equals("1");

                PlacesDTO newP = new PlacesDTO(placename, description, txtImage, Featured, status);
                pdao.create(newP);
                url = "placeController?action=destination&page=destinationjsp";
            } // CẬP NHẬT ĐIỂM ĐẾN
            else if (action.equals("updateNewPlace")) {
                //lay ra thông tin newPlace
                String placename = request.getParameter("placename");
                String description = request.getParameter("description");
                String txtImage = request.getParameter("txtImage");
                boolean Featured = request.getParameter("Featured").equals("1");
                boolean status = request.getParameter("status").equals("1");

                PlacesDTO newP = new PlacesDTO(placename, description, txtImage, Featured, status);
                pdao.update(newP);
                url = "placeController?action=destination&page=destinationjsp";

            } // CẬP NHẬT VÉ
            else if (action.equals("updateTicket")) {
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
                    request.setAttribute("tomorrowDate", getTomorrow());
                    url = "createTicketForm.jsp";
                }

            } // Thêm VÉ
            else if (action.equals("addTicket")) {
                request.setAttribute("tomorrowDate", getTomorrow());
                url = "createTicketForm.jsp";
            } else if (action.equals("deleteTicket")) {
                String nameOfDestination = request.getParameter("nameOfDestination");
                String idTour = request.getParameter("idTourTicket");
                TourTicketDTO tourTicket = tdao.readbyID(idTour);
                tourTicket.setStatus(false);
                if (!tdao.update(tourTicket)) {
                    System.out.println("khong update ticket dc ne");
                }
                url = "placeController?action=takeListTicket&location=" + nameOfDestination;
            } //            lấy dữ liệu từ form createTicketForm để sử lý và update dữ liệu xuống database
            else if (action.equals("submitUpdateTour")) {

                TourTicketDAO ttdao = new TourTicketDAO();
                TicketImgDAO tidao = new TicketImgDAO();
                TicketDayDetailDAO tdddao = new TicketDayDetailDAO();
                StartDateDAO sddao = new StartDateDAO();

                try {
                    // Lấy thông tin cơ bản
                    String tourId = request.getParameter("tourId");
                    String placeStart = request.getParameter("placestart");
                    int duration = Integer.parseInt(request.getParameter("duration"));
                    String transport = request.getParameter("transport_name");
                    double price = Double.parseDouble(request.getParameter("price"));
                    List<StartDateDTO> startDateTour = stdDAO.search(tourId);

                    // ===== LẤY DỮ LIỆU DAY DETAILS =====
                    List<String> descriptions = new ArrayList<>();
                    List<String> morningDescriptions = new ArrayList<>();
                    List<String> afternoonDescriptions = new ArrayList<>();
                    List<String> eveningDescriptions = new ArrayList<>();

                    for (int i = 1; i <= duration; i++) {
                        String desc = request.getParameter("Description_" + i);
                        String morning = request.getParameter("morningDescription_" + i);
                        String afternoon = request.getParameter("afternoonDescription_" + i);
                        String evening = request.getParameter("eveningDescription_" + i);

                        descriptions.add(desc != null ? desc : "");
                        morningDescriptions.add(morning != null ? morning : "");
                        afternoonDescriptions.add(afternoon != null ? afternoon : "");
                        eveningDescriptions.add(evening != null ? evening : "");

                    }

                    // ===== LẤY DỮ LIỆU DEPARTURE DATES =====
                    List<String> departureDates = new ArrayList<>();
                    for (int i = 1; i <= 3; i++) { // Tối đa 3 ngày
                        String date = request.getParameter("departureDate" + i);
                        if (date != null && !date.trim().isEmpty()) {
                            departureDates.add(date);
                        }
                    }

                    // ===== LẤY DỮ LIỆU IMAGES =====
                    String imgCoverPart = request.getParameter("imgCover");
                    if (imgCoverPart == null) {
                        System.out.println("khong có");
                    } else {
                        System.out.println("co");
                    }

                    // Lấy gallery images 
                    String[] oldUrls = request.getParameterValues("oldImgUrl");
                    String[] updatedBase64s = request.getParameterValues("updatedImgGallery");

                    // ===== CẬP NHẬT DATABASE =====
                    // 1. Cập nhật bảng TourTicket
                    TourTicketDTO ttdto = ttdao.readbyID(tourId);
                    ttdto.setPlacestart(placeStart);
                    ttdto.setPrice(price);
                    ttdto.setTransport_name(transport);
                    ttdto.setImg_Tour(imgCoverPart);
                    boolean isUpdateTicket = ttdao.update(ttdto);

                    // 2. Cập nhật bảng TicketImgs
                    // Xóa ảnh cũ trước khi thêm mới
                    tidao.deleteByTourId(tourId);

                    if (oldUrls != null && updatedBase64s != null) {
                        for (int i = 0; i < oldUrls.length; i++) {
                            String oldUrl = oldUrls[i];
                            String base64 = updatedBase64s[i];

                            if (base64 != null && !base64.isEmpty()) {
                                // Người dùng đã thay ảnh cũ -> xử lý base64 mới
                            } else {
                                // Ảnh cũ giữ nguyên
                            }
                        }
                    }

                    // 3. Cập nhật bảng TicketDayDetails
                    for (int i = 0; i < duration; i++) {
                        TicketDayDetailDTO tdddto = new TicketDayDetailDTO(
                                tourId,
                                i + 1,
                                descriptions.get(i),
                                morningDescriptions.get(i),
                                afternoonDescriptions.get(i),
                                eveningDescriptions.get(i)
                        );
                        boolean isUpdateDay = tdddao.update(tdddto);
                    }

                    // 4. Cập nhật bảng TourStartDates
                    // Xóa ngày cũ trước khi thêm mới (đang bị cấn và chưa thống nhất xử lý)
                    for (int i = 0; i < departureDates.size(); i++) {
                        if (!departureDates.get(i).equals(startDateTour.get(i).getStartDate())) {
                            sddao.deleteByTourId(tourId, startDateTour.get(i).getStartDate());
                            StartDateDTO addto = new StartDateDTO(tourId, departureDates.get(i), i);
                            sddao.create(addto);
                        }
                    }

                    sddao.deleteByTourId(tourId); //đang chưa hoạt động

                    for (int i = 0; i < departureDates.size(); i++) {
                        StartDateDTO sddto = new StartDateDTO(tourId, departureDates.get(i), i + 1);
                        boolean isCreateDate = sddao.create(sddto);
                    }

                    // Chuyển hướng về trang danh sách
                    String nameOfDestination = ttdto.getDestination();
                    url = "placeController?action=takeListTicket&location=" + nameOfDestination;

                } catch (Exception e) {
                    e.printStackTrace();
                    System.out.println("Error in submitUpdateTour: " + e.getMessage());
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
