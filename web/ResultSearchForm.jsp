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
        <link rel="stylesheet" href="assets/css/bodyCss.css"/>
        
        <style>
            :root {
                /* Bảng màu chính */
                --sky-blue: #0EA5E9;
                --coral-orange: #FF6B35;
                --emerald-green: #10B981;
                --golden-yellow: #F59E0B;
                --purple: #8B5CF6;
                --pearl-white: #FEFEFE;
                
                /* Màu nền và text */
                --text-dark: #1F2937;
                --text-medium: #6B7280;
                --light-bg: #F8FAFC;
                --card-bg: #FFFFFF;
                --border-color: #E5E7EB;
                
                /* Gradients */
                --gradient-primary: linear-gradient(135deg, #0EA5E9, #10B981);
                --gradient-secondary: linear-gradient(135deg, #FF6B35, #F59E0B);
                --gradient-soft: linear-gradient(135deg, #F8FAFC, #E5E7EB);
            }

            * {
                font-family: 'Poppins', sans-serif;
            }

            body {
                padding-top: 100px;
                background: var(--gradient-soft);
                min-height: 100vh;
                color: var(--text-dark);
            }

            /* Header Styles */
            .page-header {
                background: var(--gradient-primary);
                color: white;
                padding: 60px 0;
                position: relative;
            }

            .page-header h1 {
                font-weight: 700;
                font-size: 3rem;
                margin-bottom: 20px;
                text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
            }

            .page-header .description {
                font-size: 1.2rem;
                opacity: 0.95;
                max-width: 600px;
                margin: 0 auto;
            }

            /* Search Results Section */
            .search-results-section {
                padding: 40px 0;
                background: var(--light-bg);
            }

            .search-title {
                color: var(--text-dark);
                font-weight: 600;
                font-size: 1.8rem;
                margin-bottom: 30px;
                padding-left: 20px;
                position: relative;
            }

            .search-title::before {
                content: '';
                position: absolute;
                left: 0;
                top: 50%;
                transform: translateY(-50%);
                width: 4px;
                height: 30px;
                background: var(--coral-orange);
                border-radius: 2px;
            }

            .no-results {
                text-align: center;
                padding: 60px 0;
                color: var(--text-dark);
            }

            .no-results i {
                font-size: 3rem;
                color: var(--coral-orange);
                margin-bottom: 20px;
            }

            /* Tour Cards */
            .tour-card {
                background: var(--card-bg);
                border-radius: 12px;
                border: 1px solid var(--border-color);
                margin-bottom: 25px;
                transition: transform 0.2s ease;
                overflow: hidden;
            }

            .tour-card:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            }

            .tour-img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .tour-content {
                padding: 25px;
            }

            .tour-title {
                font-size: 1.4rem;
                font-weight: 600;
                color: var(--text-dark);
                margin-bottom: 15px;
                line-height: 1.4;
            }

            .tour-meta {
                display: flex;
                align-items: center;
                margin-bottom: 10px;
                color: var(--text-medium);
                font-size: 0.95rem;
            }

            .tour-meta i {
                color: var(--sky-blue);
                margin-right: 8px;
                width: 16px;
                text-align: center;
            }

            .tour-meta strong {
                color: var(--text-dark);
                font-weight: 500;
            }

            .tour-dates {
                margin: 15px 0;
            }

            .date-badge {
                display: inline-block;
                background: var(--emerald-green);
                color: white;
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 0.85rem;
                font-weight: 500;
                margin: 2px 4px 2px 0;
            }

            .price {
                font-size: 1.6rem;
                font-weight: 700;
                color: var(--coral-orange);
                margin: 20px 0;
            }

            .btn-detail {
                background: var(--gradient-secondary);
                color: white;
                border: none;
                padding: 12px 24px;
                border-radius: 8px;
                font-weight: 500;
                font-size: 0.95rem;
                cursor: pointer;
                transition: opacity 0.2s ease;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .btn-detail:hover {
                opacity: 0.9;
            }

            /* Featured Destinations Section */
            .featured-section {
                padding: 60px 0;
                background: var(--card-bg);
            }

            .section-title {
                text-align: center;
                font-size: 2.2rem;
                font-weight: 700;
                color: var(--text-dark);
                margin-bottom: 40px;
                position: relative;
            }

            .section-title::after {
                content: '';
                position: absolute;
                bottom: -10px;
                left: 50%;
                transform: translateX(-50%);
                width: 60px;
                height: 3px;
                background: var(--coral-orange);
                border-radius: 2px;
            }

            .destination-card {
                background: var(--card-bg);
                border-radius: 12px;
                border: 1px solid var(--border-color);
                transition: transform 0.2s ease;
                cursor: pointer;
                height: 320px;
                overflow: hidden;
                text-decoration: none;
                color: inherit;
            }

            .destination-card:hover {
                transform: translateY(-3px);
                box-shadow: 0 6px 20px rgba(0,0,0,0.1);
                text-decoration: none;
                color: inherit;
            }

            .destination-card .image-wrapper {
                position: relative;
                height: 220px;
                overflow: hidden;
            }

            .destination-card img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: transform 0.3s ease;
            }

            .destination-card:hover img {
                transform: scale(1.05);
            }

            .destination-card .card-overlay {
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: linear-gradient(180deg, transparent 0%, rgba(31, 41, 55, 0.6) 100%);
                opacity: 0;
                transition: opacity 0.3s ease;
            }

            .destination-card:hover .card-overlay {
                opacity: 1;
            }

            .destination-card h4 {
                padding: 20px;
                margin: 0;
                font-weight: 600;
                font-size: 1.1rem;
                color: var(--text-dark);
                text-align: center;
                background: var(--card-bg);
                border-top: 1px solid var(--border-color);
            }

            .btn-overlay {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background: var(--gradient-secondary);
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 6px;
                font-weight: 500;
                font-size: 0.9rem;
                opacity: 0;
                transition: opacity 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .destination-card:hover .btn-overlay {
                opacity: 1;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                body {
                    padding-top: 80px;
                }
                
                .page-header {
                    padding: 40px 0;
                }
                
                .page-header h1 {
                    font-size: 2.2rem;
                }
                
                .page-header .description {
                    font-size: 1rem;
                }
                
                .search-results-section {
                    padding: 30px 0;
                }
                
                .tour-card {
                    margin-bottom: 20px;
                }
                
                .tour-img {
                    height: 200px;
                }
                
                .tour-content {
                    padding: 20px;
                }
                
                .section-title {
                    font-size: 1.8rem;
                }
                
                .destination-card {
                    height: 280px;
                }
                
                .destination-card .image-wrapper {
                    height: 180px;
                }
                
                .featured-section {
                    padding: 40px 0;
                }
            }

            @media (max-width: 576px) {
                .page-header h1 {
                    font-size: 1.8rem;
                }
                
                .tour-title {
                    font-size: 1.2rem;
                }
                
                .price {
                    font-size: 1.4rem;
                }
                
                .btn-detail {
                    padding: 10px 20px;
                    font-size: 0.9rem;
                }
            }

            /* Utility Classes */
            .text-gradient {
                background: var(--gradient-primary);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .btn-gradient {
                background: var(--gradient-secondary);
                border: none;
                color: white;
            }

            .btn-gradient:hover {
                opacity: 0.9;
                color: white;
            }
        </style>
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