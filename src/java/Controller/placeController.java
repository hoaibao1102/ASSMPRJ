
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
import UTILS.AuthUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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

    private final TourTicketDAO tdao = new TourTicketDAO();
    private final PlacesDAO pdao = new PlacesDAO();
    private final TicketDayDetailDAO tddDao = new TicketDayDetailDAO();
    private final TicketImgDAO tiDAO = new TicketImgDAO();
    private final StartDateDAO stdDAO = new StartDateDAO();

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
                url = handleDestination(request, response);

            } else if (action.equals("takeListTicket")) {
                url = handleTakeListTicket(request, response);
            } else if (action.equals("ticketDetail")) {
                url = handleTicketDetail(request, response);
            } else if (action.equals("search")) {
                url = handleSearch(request, response);
            } else if (action.equals("updatePlace")) {
                HttpSession session = request.getSession(false);
                if (AuthUtils.isAdmin(session)) {
                    url = handleUpdatePlace(request, response);
                }
            } else if (action.equals("deletePlace")) {
                HttpSession session = request.getSession(false);
                if (AuthUtils.isAdmin(session)) {
                    url = handleDeletePlace(request, response);
                }
            } else if (action.equals("addPlace")) {
                HttpSession session = request.getSession(false);
                if (AuthUtils.isAdmin(session)) {
                    url = "createPlace.jsp";
                }
            } // THÊM ĐIỂM ĐẾN
            else if (action.equals("addNewPlace")) {
                HttpSession session = request.getSession(false);
                if (AuthUtils.isAdmin(session)) {
                    url = handleAddNewPlace(request, response);
                }
            } // CẬP NHẬT ĐIỂM ĐẾN
            else if (action.equals("updateNewPlace")) {
                HttpSession session = request.getSession(false);
                if (AuthUtils.isAdmin(session)) {
                    url = handleUpdateNewPlace(request, response);
                }
            } // CẬP NHẬT VÉ
            else if (action.equals("updateTicket")) {
                HttpSession session = request.getSession(false);
                if (AuthUtils.isAdmin(session)) {
                    url = handleUpdateTicket(request, response);
                }

            } // Thêm VÉ
            else if (action.equals("addTicket")) {
                HttpSession session = request.getSession(false);
                if (AuthUtils.isAdmin(session)) {
                    url = handleAddTicket(request, response);
                }

            } // XÓA VÉ
            else if (action.equals("deleteTicket")) {
                HttpSession session = request.getSession(false);
                if (AuthUtils.isAdmin(session)) {
                    url = handleDeleteTicket(request, response);
                }
            } //tao tour moi
            else if (action.equals("submitAddTour")) {
                url = handleTourSubmission(request,  "submitAddTour");
            } else if (action.equals("submitUpdateTour")) {
                url = handleTourSubmission(request, "submitUpdateTour");
            }
//            else if (action.equals("submitAddTour")) {
//
//                TourTicketDAO ttdao = new TourTicketDAO();
//                TicketImgDAO tidao = new TicketImgDAO();
//                TicketDayDetailDAO tdddao = new TicketDayDetailDAO();
//                StartDateDAO sddao = new StartDateDAO();
//
//                try {
//                    // Lấy thông tin cơ bản
//                    String tourId = request.getParameter("tourId");
//                    int idPlace = Integer.parseInt(request.getParameter("idPlace"));
//                    String destination = request.getParameter("destination");
//                    String placeStart = request.getParameter("placestart");
//                    int duration = Integer.parseInt(request.getParameter("duration"));
//                    String transport = request.getParameter("transport_name");
//                    String nametour = request.getParameter("nametour");
//                    double price = Double.parseDouble(request.getParameter("price"));
//
//                    String durationStr = "";
//                    if (duration == 2) {
//                        durationStr = "2 ngày 1 đêm";
//                    } else if (duration == 3) {
//                        durationStr = "3 ngày 2 đêm";
//                    } else if (duration == 4) {
//                        durationStr = "4 ngày 3 đêm";
//                    }
//
//                    // ===== LẤY DỮ LIỆU DAY DETAILS =====
//                    List<String> descriptions = new ArrayList<>();
//                    List<String> morningDescriptions = new ArrayList<>();
//                    List<String> afternoonDescriptions = new ArrayList<>();
//                    List<String> eveningDescriptions = new ArrayList<>();
//
//                    for (int i = 1; i <= duration; i++) {
//                        String desc = request.getParameter("Description_" + i);
//                        String morning = request.getParameter("morningDescription_" + i);
//                        String afternoon = request.getParameter("afternoonDescription_" + i);
//                        String evening = request.getParameter("eveningDescription_" + i);
//
//                        descriptions.add(desc != null ? desc : "");
//                        morningDescriptions.add(morning != null ? morning : "");
//                        afternoonDescriptions.add(afternoon != null ? afternoon : "");
//                        eveningDescriptions.add(evening != null ? evening : "");
//                    }
//
//                    // ===== LẤY DỮ LIỆU DEPARTURE DATES =====
//                    List<String> departureDates = new ArrayList<>();
//                    for (int i = 1; i <= 3; i++) { // Tối đa 3 ngày
//                        String date = request.getParameter("departureDate" + i);
//                        if (date != null && !date.trim().isEmpty()) {
//                            departureDates.add(date);
//                        }
//                    }
//
//                    // ===== LẤY DỮ LIỆU IMAGES =====
//                    String imgCoverPart = request.getParameter("imgCover");
//
//                    // Lấy các ảnh cũ và đã cập nhật (giữ nguyên hoặc base64 mới)
//                    String[] updatedImages = request.getParameter("imgGalleryData").split("---");
//
//                    // ===== INSERT DATABASE =====
//                    // 1. insert  bảng TourTicket
//                    TourTicketDTO tourTicket = new TourTicketDTO(tourId, idPlace, destination, placeStart, durationStr, price, transport, nametour, imgCoverPart, true);
//                    boolean isUpdateTicket = ttdao.create(tourTicket);
//
//                    // 2. INSERT bảng TicketImgs
//                    // Xóa ảnh cũ trước khi thêm mới
//                    tidao.deleteByTourId(tourId);
//
//                    // Lưu ảnh vào DB theo thứ tự
//                    for (int i = 0; i < updatedImages.length; i++) {
//                        String imageUrl = updatedImages[i];
//                        if (imageUrl != null && !imageUrl.trim().isEmpty()) {
//                            TicketImgDTO tidto = new TicketImgDTO(tourId, i + 1, imageUrl);
//                            boolean isCreateImg = tidao.create(tidto);
//                        }
//                    }
//
//                    // 3. INSERT bảng TicketDayDetails
//                    for (int i = 0; i < duration; i++) {
//                        TicketDayDetailDTO tdddto = new TicketDayDetailDTO(
//                                tourId,
//                                i + 1,
//                                descriptions.get(i),
//                                morningDescriptions.get(i),
//                                afternoonDescriptions.get(i),
//                                eveningDescriptions.get(i)
//                        );
//                        boolean isUpdateDay = tdddao.create(tdddto);
//                    }
//
//                    for (int i = 0; i < departureDates.size(); i++) {
//                        StartDateDTO sddto = new StartDateDTO(tourId, departureDates.get(i), i + 1);
//                        boolean isCreateDate = sddao.create(sddto);
//                    }
//
//                    // Chuyển hướng về trang danh sách
//                    String nameOfDestination = tourTicket.getDestination();
//                    url = "placeController?action=takeListTicket&location=" + nameOfDestination;
//
//                } catch (Exception e) {
//                    e.printStackTrace();
//                    System.out.println("Error in submitUpdateTour: " + e.getMessage());
//                }
//            } else if (action.equals("submitUpdateTour")) {
//                TourTicketDAO ttdao = new TourTicketDAO();
//                TicketImgDAO tidao = new TicketImgDAO();
//                TicketDayDetailDAO tdddao = new TicketDayDetailDAO();
//                StartDateDAO sddao = new StartDateDAO();
//
//                try {
//                    // Lấy thông tin cơ bản
//                    String tourId = request.getParameter("tourId");
//                    System.out.println("====");
//                    System.out.println(tourId);
//                    System.out.println("====");
//                    String placeStart = request.getParameter("placestart");
//                    int duration = Integer.parseInt(request.getParameter("duration"));
//                    String transport = request.getParameter("transport_name");
//                    double price = Double.parseDouble(request.getParameter("price"));
//                    List<StartDateDTO> startDateTour = stdDAO.search(tourId);
//
//                    // ===== LẤY DỮ LIỆU DAY DETAILS =====
//                    List<String> descriptions = new ArrayList<>();
//                    List<String> morningDescriptions = new ArrayList<>();
//                    List<String> afternoonDescriptions = new ArrayList<>();
//                    List<String> eveningDescriptions = new ArrayList<>();
//
//                    for (int i = 1; i <= duration; i++) {
//                        String desc = request.getParameter("Description_" + i);
//                        String morning = request.getParameter("morningDescription_" + i);
//                        String afternoon = request.getParameter("afternoonDescription_" + i);
//                        String evening = request.getParameter("eveningDescription_" + i);
//
//                        descriptions.add(desc != null ? desc : "");
//                        morningDescriptions.add(morning != null ? morning : "");
//                        afternoonDescriptions.add(afternoon != null ? afternoon : "");
//                        eveningDescriptions.add(evening != null ? evening : "");
//
//                    }
//
//                    // ===== LẤY DỮ LIỆU DEPARTURE DATES =====
//                    List<String> departureDates = new ArrayList<>();
//                    for (int i = 1; i <= 3; i++) { // Tối đa 3 ngày
//                        String date = request.getParameter("departureDate" + i);
//                        System.out.println(date);
//                        if (date != null && !date.trim().isEmpty()) {
//                            departureDates.add(date);
//                        }
//                    }
//
//                    // ===== LẤY DỮ LIỆU IMAGES =====
//                    String imgCoverPart = request.getParameter("imgCover");
//
//                    // Lấy các ảnh cũ và đã cập nhật (giữ nguyên hoặc base64 mới)
//                    String[] updatedImages = request.getParameter("imgGalleryData").split("---");
//
//                    // ===== CẬP NHẬT DATABASE =====
//                    // 1. Cập nhật bảng TourTicket
//                    TourTicketDTO ttdto = ttdao.readbyID(tourId);
//                    ttdto.setPlacestart(placeStart);
//                    ttdto.setPrice(price);
//                    ttdto.setTransport_name(transport);
//                    ttdto.setImg_Tour(imgCoverPart);
//                    boolean isUpdateTicket = ttdao.update(ttdto);
//                    if (isUpdateTicket) {
//                        System.out.println("tticket");
//                    }
//                    // 2. Cập nhật bảng TicketImgs
//                    // Xóa ảnh cũ trước khi thêm mới
//                    tidao.deleteByTourId(tourId);
//
//                    // Lưu ảnh vào DB theo thứ tự
//                    for (int i = 0; i < updatedImages.length; i++) {
//                        String imageUrl = updatedImages[i];
//                        if (imageUrl != null && !imageUrl.trim().isEmpty()) {
//                            TicketImgDTO tidto = new TicketImgDTO(tourId, i + 1, imageUrl);
//                            boolean isCreateImg = tidao.create(tidto);
//                        }
//                    }
//
//                    // 3. Cập nhật bảng TicketDayDetails
//                    for (int i = 0; i < duration; i++) {
//                        TicketDayDetailDTO tdddto = new TicketDayDetailDTO(
//                                tourId,
//                                i + 1,
//                                descriptions.get(i),
//                                morningDescriptions.get(i),
//                                afternoonDescriptions.get(i),
//                                eveningDescriptions.get(i)
//                        );
//                        boolean isUpdateDay = tdddao.update(tdddto);
//                        if (isUpdateDay) {
//                            System.out.println("tkddetail thành công");
//                        }
//                    }
//                    System.out.println("===================");
//                    // 4. Cập nhật bảng TourStartDates
//                    // Xóa ngày cũ trước khi thêm mới (đang bị cấn và chưa thống nhất xử lý)
//                    for (int i = 0; i < departureDates.size(); i++) {
//                        System.out.println("ngày " + i);
//                        System.out.println("departureDates " + departureDates.get(i));
//                        System.out.println("startDateTour.get(i)" + startDateTour.get(i).getStartDate());
//                        if (!departureDates.get(i).equals(startDateTour.get(i).getStartDate())) {
//                            sddao.deleteByTourId(tourId, startDateTour.get(i).getStartDate());
//                            StartDateDTO addto = new StartDateDTO(tourId, departureDates.get(i), i + 1);
//                            sddao.create(addto);
//                        }
//
//                    }
//
//                    // Chuyển hướng về trang danh sách
//                    String nameOfDestination = ttdto.getDestination();
//                    url = "placeController?action=takeListTicket&location=" + nameOfDestination;
//
//                } catch (Exception e) {
//                    e.printStackTrace();
//                    System.out.println("Error in submitUpdateTour: " + e.getMessage());
//                }
//            }

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

    public String generateTourTicketIdByDestination(String destination) {
        // Rút gọn tên tỉnh (VD: "Quảng Ngãi" => "QN")
        String[] words = destination.trim().split("\\s+");
        StringBuilder prefixBuilder = new StringBuilder();

        for (String word : words) {
            if (!word.isEmpty()) {
                prefixBuilder.append(Character.toUpperCase(word.charAt(0)));
            }
        }

        String prefix = prefixBuilder.toString();
        TourTicketDAO tdao = new TourTicketDAO();
        String idTourTicket = tdao.createIdTourTicket(prefix);

        return idTourTicket;
    }

    private String handleDestination(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Gọi hàm getFeaturedPlaces để lấy danh sách địa điểm và gán vào request
        getAllDestination(request, response);
        String page = request.getParameter("page");
        if (page.equals("indexjsp")) {
            return "index.jsp";
        } else {
            return "DestinationForm.jsp";
        }

    }

    private String handleTakeListTicket(HttpServletRequest request, HttpServletResponse response) {

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
            request.setAttribute("location", location);
            request.setAttribute("tourList", tour);
            return "TourTicketForm.jsp";
        } else {
            System.out.println("không qua duoc ba ");
        }
        return null;

    }

    private String handleTicketDetail(HttpServletRequest request, HttpServletResponse response) {

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
            return "TicketDetailForm.jsp";
        }
        return null;

    }

    private String handleSearch(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
            return "ResultSearchForm.jsp";

        }
        return null;

    }

    private String handleUpdatePlace(HttpServletRequest request, HttpServletResponse response) {
        String location = request.getParameter("location");
        String img = request.getParameter("img");
        String description = request.getParameter("description");

        PlacesDTO place = new PlacesDTO(location, description, img, true, true);
        request.setAttribute("place", place);
        return "createPlace.jsp";

    }

    private String handleDeletePlace(HttpServletRequest request, HttpServletResponse response) {
        String placeName = request.getParameter("location");
        PlacesDTO place = pdao.readByName(placeName);
        place.setStatus(false);
        pdao.update(place);
        return "placeController?action=destination&page=destinationjsp";

    }

    private String handleAddNewPlace(HttpServletRequest request, HttpServletResponse response) {
        //lay ra thông tin newPlace
        String placename = request.getParameter("placename");
        String description = request.getParameter("description");
        String txtImage = request.getParameter("txtImage");
        boolean Featured = request.getParameter("Featured").equals("1");
        boolean status = request.getParameter("status").equals("1");

        PlacesDTO newP = new PlacesDTO(placename, description, txtImage, Featured, status);
        pdao.create(newP);
        return "placeController?action=destination&page=destinationjsp";

    }

    private String handleUpdateNewPlace(HttpServletRequest request, HttpServletResponse response) {
        //lay ra thông tin newPlace
        String placename = request.getParameter("placename");
        String description = request.getParameter("description");
        String txtImage = request.getParameter("txtImage");
        boolean Featured = request.getParameter("Featured").equals("1");
        boolean status = request.getParameter("status").equals("1");

        PlacesDTO newP = new PlacesDTO(placename, description, txtImage, Featured, status);
        pdao.update(newP);
        return "placeController?action=destination&page=destinationjsp";

    }

    private String handleUpdateTicket(HttpServletRequest request, HttpServletResponse response) {
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
            return "createTicketForm.jsp";
        }
        return null;

    }

    private String handleAddTicket(HttpServletRequest request, HttpServletResponse response) {
        String destination = request.getParameter("destination");
        request.setAttribute("tomorrowDate", getTomorrow());
        String idTour = generateTourTicketIdByDestination(destination);
        int idPlace = pdao.readByName(destination).getIdPlace();

        request.setAttribute("idPlace", idPlace);
        request.setAttribute("idTour", idTour);
        request.setAttribute("destination", destination);
        System.out.println(idPlace + " " + idTour + " " + destination);

        return "createTicketForm.jsp";

    }

    private String handleDeleteTicket(HttpServletRequest request, HttpServletResponse response) {
        String nameOfDestination = request.getParameter("nameOfDestination");
        String idTour = request.getParameter("idTourTicket");
        TourTicketDTO tourTicket = tdao.readbyID(idTour);
        tourTicket.setStatus(false);
        if (!tdao.update(tourTicket)) {
            System.out.println("khong update ticket dc ne");
        }
        return "placeController?action=takeListTicket&location=" + nameOfDestination;

    }

    public String handleTourSubmission(HttpServletRequest request, String action) {
        TourTicketDAO ttdao = new TourTicketDAO();
        TicketImgDAO tidao = new TicketImgDAO();
        TicketDayDetailDAO tdddao = new TicketDayDetailDAO();
        StartDateDAO sddao = new StartDateDAO();
        StartDateDAO stdDAO = new StartDateDAO(); // cho update

        try {
            String tourId = request.getParameter("tourId");
            int duration = Integer.parseInt(request.getParameter("duration"));
            String placeStart = request.getParameter("placestart");
            String transport = request.getParameter("transport_name");
            double price = Double.parseDouble(request.getParameter("price"));
            String imgCoverPart = request.getParameter("imgCover");
            String[] updatedImages = request.getParameter("imgGalleryData").split("---");

            // ===== Parse mô tả ngày =====
            List<String> descriptions = getListFromRequest(request, "Description_", duration);
            List<String> morning = getListFromRequest(request, "morningDescription_", duration);
            List<String> afternoon = getListFromRequest(request, "afternoonDescription_", duration);
            List<String> evening = getListFromRequest(request, "eveningDescription_", duration);

            // ===== Parse ngày khởi hành =====
            List<String> departureDates = getDepartureDates(request);

            if (action.equals("submitAddTour")) {
                String destination = request.getParameter("destination");
                int idPlace = Integer.parseInt(request.getParameter("idPlace"));
                String nametour = request.getParameter("nametour");
                String durationStr = getDurationString(duration);

                // Insert Tour
                TourTicketDTO tour = new TourTicketDTO(tourId, idPlace, destination, placeStart, durationStr, price, transport, nametour, imgCoverPart, true);
                ttdao.create(tour);

                // Save ảnh, ngày, mô tả
                saveImages(tourId, updatedImages, tidao);
                saveDayDetails(tourId, duration, descriptions, morning, afternoon, evening, tdddao);
                saveStartDates(tourId, departureDates, sddao);

                return "placeController?action=takeListTicket&location=" + destination;

            } else if (action.equals("submitUpdateTour")) {
                TourTicketDTO tour = ttdao.readbyID(tourId);
                tour.setPlacestart(placeStart);
                tour.setPrice(price);
                tour.setTransport_name(transport);
                tour.setImg_Tour(imgCoverPart);
                ttdao.update(tour);

                // Cập nhật ảnh, ngày, mô tả
                saveImages(tourId, updatedImages, tidao);
                updateDayDetails(tourId, duration, descriptions, morning, afternoon, evening, tdddao);

                List<StartDateDTO> oldDates = stdDAO.search(tourId);
                updateStartDates(tourId, departureDates, oldDates, sddao);

                return "placeController?action=takeListTicket&location=" + tour.getDestination();
            }

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error in handleTourSubmission: " + e.getMessage());
        }

        return "error.jsp";
    }

    private List<String> getListFromRequest(HttpServletRequest request, String prefix, int count) {
        List<String> result = new ArrayList<>();
        for (int i = 1; i <= count; i++) {
            String value = request.getParameter(prefix + i);
            result.add(value != null ? value : "");
        }
        return result;
    }

    private List<String> getDepartureDates(HttpServletRequest request) {
        List<String> dates = new ArrayList<>();
        for (int i = 1; i <= 3; i++) {
            String date = request.getParameter("departureDate" + i);
            if (date != null && !date.trim().isEmpty()) {
                dates.add(date);
            }
        }
        return dates;
    }

    private String getDurationString(int duration) {
        switch (duration) {
            case 2:
                return "2 ngày 1 đêm";
            case 3:
                return "3 ngày 2 đêm";
            case 4:
                return "4 ngày 3 đêm";
            default:
                return duration + " ngày";
        }
    }

    private void saveImages(String tourId, String[] images, TicketImgDAO dao) throws Exception {
        dao.deleteByTourId(tourId);
        for (int i = 0; i < images.length; i++) {
            if (!images[i].trim().isEmpty()) {
                dao.create(new TicketImgDTO(tourId, i + 1, images[i]));
            }
        }
    }

    private void saveDayDetails(String tourId, int duration, List<String> desc, List<String> morn,
            List<String> aft, List<String> eve, TicketDayDetailDAO dao) throws Exception {
        for (int i = 0; i < duration; i++) {
            TicketDayDetailDTO dto = new TicketDayDetailDTO(
                    tourId, i + 1, desc.get(i), morn.get(i), aft.get(i), eve.get(i));
            dao.create(dto);
        }
    }

    private void updateDayDetails(String tourId, int duration, List<String> desc, List<String> morn,
            List<String> aft, List<String> eve, TicketDayDetailDAO dao) throws Exception {
        for (int i = 0; i < duration; i++) {
            TicketDayDetailDTO dto = new TicketDayDetailDTO(
                    tourId, i + 1, desc.get(i), morn.get(i), aft.get(i), eve.get(i));
            dao.update(dto);
        }
    }

    private void saveStartDates(String tourId, List<String> dates, StartDateDAO dao) throws Exception {
        for (int i = 0; i < dates.size(); i++) {
            dao.create(new StartDateDTO(tourId, dates.get(i), i + 1));
        }
    }

    private void updateStartDates(String tourId, List<String> newDates, List<StartDateDTO> oldDates, StartDateDAO dao) throws Exception {
        for (int i = 0; i < newDates.size(); i++) {
            String newDate = newDates.get(i);
            if (i < oldDates.size()) {
                String oldDate = oldDates.get(i).getStartDate();
                if (!newDate.equals(oldDate)) {
                    dao.deleteByTourId(tourId, oldDate);
                    dao.create(new StartDateDTO(tourId, newDate, i + 1));
                }
            } else {
                dao.create(new StartDateDTO(tourId, newDate, i + 1));
            }
        }
    }

}
