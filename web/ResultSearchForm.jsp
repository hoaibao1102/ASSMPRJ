<%-- 
    Document   : ResultSearchForm
    Created on : May 27, 2025, 11:40:01 PM
    Author     : MSI PC
--%>

<%@page import="DTO.PlacesDTO"%>
<%@page import="java.util.List"%>
<%@page import="DTO.TourTicketDTO"%>
<%@page import="DTO.StartDateDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>VN Tours</title>
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/search.css"/>
        
    </head>
    <body>
        <%@include file="header.jsp" %>
        
        <%
            List<TourTicketDTO> tourList = (List<TourTicketDTO>) request.getAttribute("tourList2");
            String searchTourInfor = (String) request.getAttribute("searchTourInfor");
            if (searchTourInfor == null) searchTourInfor = "";
        %>

        <!-- Page Header -->
        <div class="page-header">
            <div class="container">
                <div class="row">
                    <div class="col-12 text-center">
                        <h1><i class="fas fa-map-marked-alt me-3"></i>Khám Phá Tour Du Lịch</h1>
                        <p class="description">Trải nghiệm những chuyến đi tuyệt vời với các tour du lịch chất lượng cao, dịch vụ tận tâm và giá cả hợp lý</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Search Results Section -->
        <div class="search-results-section">
            <div class="container">
                <%
                    if (tourList != null && !tourList.isEmpty()) {
                %>
                <h2 class="search-title">
                    <i class="fas fa-search me-2"></i>
                    Kết quả tìm kiếm cho "<%=searchTourInfor%>"
                </h2>
                
                <div class="row">
                    <%
                    for (int i = 0; i < tourList.size(); i++) {
                        TourTicketDTO t = tourList.get(i);
                        int index = i + 1;
                        List<StartDateDTO> startDates = (List<StartDateDTO>) request.getAttribute("startDateTour" + index);
                    %>
                    <div class="col-12 mb-4">
                        <div class="tour-card">
                            <div class="row g-0">
                                <div class="col-md-5">
                                    <div style="height: 100%; overflow: hidden;">
                                        <img class="tour-img" src="<%=t.getImg_Tour()%>" alt="<%=t.getNametour()%>">
                                    </div>
                                </div>
                                <div class="col-md-7">
                                    <div class="tour-content">
                                        <h3 class="tour-title"><%=t.getNametour()%></h3>
                                        
                                        <div class="tour-meta">
                                            <i class="fas fa-tag"></i>
                                            <span>Mã tour: <strong><%=t.getIdTourTicket()%></strong></span>
                                        </div>
                                        
                                        <div class="tour-meta">
                                            <i class="fas fa-map-marker-alt"></i>
                                            <span>Khởi hành: <strong><%=t.getPlacestart()%></strong></span>
                                        </div>
                                        
                                        <div class="tour-meta">
                                            <i class="fas fa-clock"></i>
                                            <span>Thời gian: <strong><%=t.getDuration()%></strong></span>
                                        </div>
                                        
                                        <div class="tour-meta">
                                            <i class="fas fa-plane"></i>
                                            <span>Phương tiện: <strong><%=t.getTransport_name()%></strong></span>
                                        </div>
                                        
                                        <div class="tour-dates">
                                            <div class="tour-meta mb-2">
                                                <i class="fas fa-calendar-alt"></i>
                                                <span>Ngày khởi hành:</span>
                                            </div>
                                            <div>
                                                <% if (startDates != null && !startDates.isEmpty()) {
                                                    for (StartDateDTO sd : startDates) {
                                                %>
                                                <span class="date-badge"><%=sd.getStartDate()%></span>
                                                <%  }
                                                } else { %>
                                                <span class="date-badge">Chưa có lịch</span>
                                                <% } %>
                                            </div>
                                        </div>
                                        
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div class="price">
                                                <i class="fas fa-money-bill-wave me-2"></i>
                                                <%=String.format("%,.0f", t.getPrice())%> đ
                                            </div>
                                            
                                            <form action="MainController" method="post">
                                                <input type="hidden" name="action" value="ticketDetail" />
                                                <input type="hidden" name="idTourTicket" value="<%=t.getIdTourTicket()%>" />
                                                <button class="btn-detail" type="submit">
                                                    <i class="fas fa-eye me-2"></i>Xem chi tiết
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    } else { %>
                    <div class="col-12">
                        <div class="no-results">
                            <i class="fas fa-search-minus"></i>
                            <h2>Không tìm thấy kết quả</h2>
                            <p class="lead">Không có tour nào phù hợp với từ khóa: "<strong><%=searchTourInfor%></strong>"</p>
                            <p class="text-muted">Hãy thử tìm kiếm với từ khóa khác hoặc khám phá các điểm đến nổi bật bên dưới</p>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>
        </div>

        <!-- Featured Destinations Section -->
        <div class="featured-section">
            <div class="container">
                <h2 class="section-title">
                    <i class="fas fa-star me-3"></i>
                    Điểm Đến Nổi Bật
                </h2>
                
                <div class="row">
                    <%
                        List<PlacesDTO> placeList = (List<PlacesDTO>) request.getAttribute("placeList");
                        if (placeList != null && !placeList.isEmpty()) {
                            for (PlacesDTO p : placeList) {
                                if (p.getFeatured()) {
                    %>
                    <div class="col-lg-4 col-md-6 mb-4">
                        <form class="destination-card" action="MainController" method="post">
                            <div class="image-wrapper">
                                <img src="<%=p.getImg()%>" alt="<%=p.getPlaceName()%>" />
                                <div class="card-overlay"></div>
                                <button type="submit" class="btn-overlay">
                                    <i class="fas fa-arrow-right me-2"></i>Khám phá
                                </button>
                            </div>
                            <h4>
                                <i class="fas fa-map-pin me-2" style="color: var(--coral-orange);"></i>
                                <%=p.getPlaceName()%>
                            </h4>
                            <input type="hidden" name="action" value="takeListTicket" />
                            <input type="hidden" name="location" value="<%=p.getPlaceName()%>" />
                        </form>
                    </div>
                    <%
                                }
                            }
                        }
                    %>
                </div>
            </div>
        </div>

        <!-- Bootstrap 5 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        
        <%@include file="footer.jsp" %>
        <script src="assets/js/chatbase-loader.js"></script>

    </body>
</html>