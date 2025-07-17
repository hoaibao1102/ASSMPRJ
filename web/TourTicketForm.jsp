<%@page import="java.util.List"%>
<%@page import="DTO.TourTicketDTO"%>
<%@page import="DTO.StartDateDTO"%>
<%@page import="UTILS.AuthUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách Tour</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/bodyCss.css"/>
        <style>
            :root {
                /* Tông màu chính Việt Nam */
                --vietnam-blue: #0EA5E9;
                --vietnam-coral: #FF6B35;
                --vietnam-emerald: #10B981;

                /* Tông màu phụ */
                --vietnam-gold: #F59E0B;
                --vietnam-purple: #8B5CF6;
                --vietnam-pearl: #FEFEFE;

                /* Gradient chính */
                --gradient-primary: linear-gradient(135deg, #0EA5E9, #10B981);
                --gradient-secondary: linear-gradient(135deg, #FF6B35, #F59E0B);
                --gradient-accent: linear-gradient(135deg, #8B5CF6, #0EA5E9);

                /* Text colors */
                --text-primary: #1F2937;
                --text-secondary: #6B7280;
                --text-light: #9CA3AF;

                /* Background */
                --bg-light: #F8FAFC;
                --bg-card: #FFFFFF;
            }

            body {
                padding-top: 100px;
                background-color: var(--bg-light);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                color: var(--text-primary);
            }

            .admin-layout .content {
                margin-left: 250px; /* hoặc 200px, tùy chiều rộng sidebar admin */
                padding-top: 1rem;
            }

            /* Header Styles */
            .vietnam-header {
                background: var(--gradient-primary);
                color: var(--vietnam-pearl);
                padding: 3rem 0;
                margin-bottom: 2rem;
                position: relative;
                overflow: hidden;
            }

            .vietnam-header::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="20" cy="20" r="2" fill="rgba(254,254,254,0.1)"/><circle cx="80" cy="40" r="1.5" fill="rgba(254,254,254,0.1)"/><circle cx="40" cy="80" r="1" fill="rgba(254,254,254,0.1)"/><path d="M10,50 Q50,30 90,50 Q50,70 10,50" stroke="rgba(254,254,254,0.05)" stroke-width="2" fill="none"/></svg>');
                animation: float 20s infinite linear;
            }

            @keyframes float {
                0% {
                    transform: translateY(0px) rotate(0deg);
                }
                50% {
                    transform: translateY(-20px) rotate(180deg);
                }
                100% {
                    transform: translateY(0px) rotate(360deg);
                }
            }

            .vietnam-header h1 {
                font-weight: 900;
                font-size: 3rem;
                margin-bottom: 1rem;
                letter-spacing: 2px;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
                position: relative;
                z-index: 2;
            }

            .vietnam-header .description {
                font-size: 1.2rem;
                opacity: 0.95;
                max-width: 800px;
                margin: 0 auto;
                position: relative;
                z-index: 2;
                line-height: 1.6;
            }

            /* Breadcrumb Styles */
            .custom-breadcrumb {
                background: linear-gradient(90deg, rgba(14,165,233,0.1) 0%, rgba(16,185,129,0.1) 100%);
                border-radius: 50px;
                padding: 1rem 2rem;
                margin: 2rem 0;
                border: 1px solid rgba(14,165,233,0.2);
                box-shadow: 0 2px 10px rgba(14,165,233,0.1);
            }

            .custom-breadcrumb a {
                color: var(--vietnam-blue);
                text-decoration: none;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .custom-breadcrumb a:hover {
                color: var(--vietnam-emerald);
                text-decoration: underline;
            }

            .custom-breadcrumb .current {
                color: var(--text-primary);
                font-weight: 700;
            }

            .custom-breadcrumb i {
                color: var(--vietnam-coral);
            }

            /* Tour Card Styles */
            .tour-card {
                background: var(--bg-card);
                border-radius: 20px;
                overflow: hidden;
                box-shadow: 0 8px 30px rgba(14,165,233,0.1);
                margin-bottom: 2rem;
                transition: all 0.4s ease;
                border: 1px solid rgba(14,165,233,0.1);
                position: relative;
            }

            .tour-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: var(--gradient-primary);
                opacity: 0;
                transition: opacity 0.3s ease;
                z-index: 1;
            }

            .tour-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 20px 50px rgba(14,165,233,0.15);
                border-color: var(--vietnam-blue);
            }

            .tour-card:hover::before {
                opacity: 0.02;
            }

            .tour-img {
                width: 100%;
                height: 280px;
                object-fit: cover;
                transition: transform 0.4s ease;
                position: relative;
                z-index: 2;
            }

            .tour-card:hover .tour-img {
                transform: scale(1.05);
            }

            .tour-content {
                padding: 1.5rem;
                position: relative;
                z-index: 2;
            }

            .tour-title {
                height: 90px;
                font-size: 1.5rem;
                font-weight: 700;
                color: var(--text-primary);
                margin-bottom: 1rem;
                line-height: 1.4;
            }

            .tour-meta {
                font-size: 0.95rem;
                margin: 0.5rem 0;
                color: var(--text-secondary);
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .tour-meta i {
                color: var(--vietnam-coral);
                width: 20px;
                font-size: 1.1rem;
            }

            .tour-meta strong {
                color: var(--text-primary);
            }

            .tour-dates {
                flex-wrap: wrap;
                gap: 0.5rem;
                margin: 1rem 0;
            }

            .date-badge {
                background: var(--gradient-secondary);
                color: var(--vietnam-pearl);
                padding: 0.4rem 0.8rem;
                border-radius: 20px;
                font-size: 0.85rem;
                font-weight: 600;
                text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
                box-shadow: 0 2px 8px rgba(255,107,53,0.3);
                transition: transform 0.2s ease;
            }

            .date-badge:hover {
                transform: translateY(-2px);
            }

            .price {
                font-size: 1.5rem;
                font-weight: 800;
                background: var(--gradient-secondary);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin: 1rem 0;
            }

            /* Button Styles */
            .btn-vietnam-primary {
                background: var(--gradient-primary);
                border: none;
                border-radius: 25px;
                color: var(--vietnam-pearl);
                font-weight: 600;
                padding: 0.7rem 1.5rem;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 1px;
                box-shadow: 0 4px 15px rgba(14,165,233,0.3);
            }

            .btn-vietnam-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(14,165,233,0.4);
                color: var(--vietnam-pearl);
            }

            .btn-vietnam-secondary {
                background: var(--gradient-secondary);
                border: none;
                border-radius: 25px;
                color: var(--vietnam-pearl);
                font-weight: 600;
                padding: 0.7rem 1.5rem;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 1px;
                box-shadow: 0 4px 15px rgba(255,107,53,0.3);
            }

            .btn-vietnam-secondary:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(255,107,53,0.4);
                color: var(--vietnam-pearl);
            }

            .btn-vietnam-accent {
                background: var(--gradient-accent);
                border: none;
                border-radius: 25px;
                color: var(--vietnam-pearl);
                font-weight: 600;
                padding: 0.7rem 1.5rem;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 1px;
                box-shadow: 0 4px 15px rgba(139,92,246,0.3);
            }

            .btn-vietnam-accent:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(139,92,246,0.4);
                color: var(--vietnam-pearl);
            }

            .btn-vietnam-danger {
                background: linear-gradient(135deg, #EF4444, #DC2626);
                border: none;
                border-radius: 25px;
                color: var(--vietnam-pearl);
                font-weight: 600;
                padding: 0.7rem 1.5rem;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 1px;
                box-shadow: 0 4px 15px rgba(239,68,68,0.3);
            }

            .btn-vietnam-danger:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(239,68,68,0.4);
                color: var(--vietnam-pearl);
            }

            .btn-add-ticket {
                background: var(--gradient-primary);
                border: none;
                border-radius: 50px;
                color: var(--vietnam-pearl);
                font-weight: 700;
                padding: 1rem 2rem;
                font-size: 1.1rem;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 1px;
                box-shadow: 0 6px 20px rgba(14,165,233,0.3);
                position: fixed;
                bottom: 30px;
                right: 30px;
                z-index: 1000;
            }

            .btn-add-ticket:hover {
                transform: translateY(-3px);
                box-shadow: 0 10px 30px rgba(14,165,233,0.4);
                color: var(--vietnam-pearl);
            }

            /* Section Headers */
            .section-header {
                background: var(--gradient-accent);
                color: var(--vietnam-pearl);
                padding: 1.5rem 2rem;
                border-radius: 15px;
                margin: 2rem 0 1rem 0;
                font-size: 1.3rem;
                font-weight: 700;
                text-align: center;
                position: relative;
                overflow: hidden;
            }

            .section-header::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(254,254,254,0.1), transparent);
                animation: shine 3s infinite;
            }

            @keyframes shine {
                0% {
                    left: -100%;
                }
                100% {
                    left: 100%;
                }
            }

            /* No Tours Message */
            .no-tours {
                text-align: center;
                padding: 4rem 2rem;
                color: var(--text-primary);
                font-size: 1.2rem;
            }

            .no-tours i {
                font-size: 4rem;
                color: var(--vietnam-coral);
                margin-bottom: 1rem;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                body {
                    padding-top: 80px;
                }

                .vietnam-header {
                    padding: 2rem 0;
                }

                .vietnam-header h1 {
                    font-size: 2rem;
                }

                .tour-card {
                    margin-bottom: 1.5rem;
                }

                .tour-img {
                    height: 200px;
                }

                .btn-add-ticket {
                    bottom: 20px;
                    right: 20px;
                    padding: 0.8rem 1.5rem;
                    font-size: 1rem;
                }

                .custom-breadcrumb {
                    padding: 0.8rem 1.5rem;
                    font-size: 0.9rem;
                }
            }

            /* Animation for cards */
            .tour-card {
                animation: fadeInUp 0.6s ease-out;
            }

            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Status indicators */
            .status-indicator {
                position: absolute;
                top: 15px;
                right: 15px;
                padding: 0.3rem 0.8rem;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 600;
                z-index: 3;
            }

            .status-active {
                background: var(--vietnam-emerald);
                color: var(--vietnam-pearl);
            }

            .status-inactive {
                background: var(--text-light);
                color: var(--vietnam-pearl);
            }

            /* Improved hover effects */
            .tour-content .btn {
                transition: all 0.3s ease;
            }

            .tour-content .btn:hover {
                transform: translateY(-1px);
            }

            /* Loading state for images */
            .tour-img {
                opacity: 0;
                transition: opacity 0.3s ease, transform 0.4s ease;
            }

            .tour-img.loaded {
                opacity: 1;
            }

            /*            nút yêu thích*/
            .btn-favorite {
                background: none;
                border: none;
                color: #ccc;
                font-size: 1.3rem;
                transition: all 0.3s ease;
                padding: 0.2rem 0.5rem;
            }

            .btn-favorite:hover i {
                color: var(--vietnam-emerald);
                transform: scale(1.2);
            }

            .btn-favorite.active i {
                color: var(--vietnam-emerald);
            }

        </style>
    </head>
    <body class="<%= AuthUtils.isAdmin(session) ? "admin-layout" : "" %>">
        <%@include file="header.jsp" %>

        <c:if test="${not empty sessionScope.message}">
            <script>
                alert("${fn:escapeXml(sessionScope.message)}");
            </script>
            <c:remove var="message" scope="session"/>
        </c:if>


        <%
            List<TourTicketDTO> tourList = (List<TourTicketDTO>) request.getAttribute("tourList");
            String discriptionPlaces = (String) request.getAttribute("discriptionPlaces");
            String location = (String) request.getAttribute("location");
        %>

        <div class="content">
            <!-- Breadcrumb -->
            <div class="container">
                <div class="custom-breadcrumb">
                    <i class="fas fa-home me-2"></i>
                    <a href="placeController?action=destination&page=indexjsp">Trang chủ</a>
                    <i class="fas fa-chevron-right mx-2"></i>
                    <a href="placeController?action=destination&page=destinationjsp">Điểm đến</a>
                    <i class="fas fa-chevron-right mx-2"></i>
                    <span class="current">Du lịch <%=location%></span>
                </div>
            </div>

            <%
            if (tourList != null && !tourList.isEmpty()) {
            %>

            <!-- Header Section -->
            <div class="vietnam-header">
                <div class="container text-center">
                    <h1><i class="fas fa-umbrella-beach me-3"></i>Danh sách Tour <%=tourList.get(0).getDestination()%></h1>
                    <c:if test="${sessionScope.nameUser.role != 'AD'}">
                        <p class="description">
                            <i class="fas fa-map-marker-alt me-2"></i>
                            <%=discriptionPlaces%>
                        </p>
                    </c:if>
                </div>
            </div>

            <div class="container">
                <%-- Cờ đánh dấu xem liệu trong danh sách có tồn tại ticket isStatus() là true không --%>
                <%! boolean flag = false; %>

                <c:if test="${sessionScope.nameUser.role == 'AD'}">
                    <div class="section-header">
                        <i class="fas fa-pause-circle me-2"></i>
                        Danh sách vé đang ngưng hoạt động
                    </div>

                    <div class="row">
                        <%
                        for (TourTicketDTO t : tourList) {
                            int index = tourList.indexOf(t) + 1;
                            List<StartDateDTO> startDates = (List<StartDateDTO>) request.getAttribute("startDateTour" + index);
                            if (!t.isStatus()) {
                        %>    
                        <div class="col-lg-6 col-xl-4 mb-4">
                            <div class="tour-card">
                                <div class="status-indicator status-inactive">
                                    <i class="fas fa-pause"></i> Ngưng hoạt động
                                </div>
                                <img class="tour-img" src="<%=t.getImg_Tour()%>" alt="<%= t.getNametour() %>">
                                <div class="tour-content">
                                    <h3 class="tour-title"><%= t.getNametour() %></h3>

                                    <div class="tour-meta">
                                        <i class="fas fa-tag"></i>
                                        <span>Mã tour: <strong><%= t.getIdTourTicket() %></strong></span>
                                    </div>

                                    <div class="tour-meta">
                                        <i class="fas fa-map-marker-alt"></i>
                                        <span>Khởi hành: <strong><%= t.getPlacestart() %></strong></span>
                                    </div>

                                    <div class="tour-meta">
                                        <i class="fas fa-clock"></i>
                                        <span>Thời gian: <strong><%= t.getDuration() %></strong></span>
                                    </div>

                                    <div class="tour-meta">
                                        <i class="fas fa-plane"></i>
                                        <span>Phương tiện: <strong><%= t.getTransport_name() %></strong></span>
                                    </div>

                                    <div class="tour-meta tour-dates">
                                        <i class="fas fa-calendar-alt"></i>
                                        <span>Ngày khởi hành:</span>
                                        <div class="w-100 mt-2">
                                            <% if (startDates != null && !startDates.isEmpty()) {
                                                for (StartDateDTO sd : startDates) {
                                            %>
                                            <span class="date-badge me-2 mb-2 d-inline-block"><%= sd.getStartDate() %></span>
                                            <%  }
                                            } else { %>
                                            <span class="date-badge">Chưa có lịch</span>
                                            <% } %>
                                        </div>
                                    </div>

                                    <div class="price">
                                        <i class="fas fa-money-bill-wave me-2"></i>
                                        Giá từ: <%= String.format("%,.0f", t.getPrice()) %> đ
                                    </div>

                                    <form action="MainController" method="post">
                                        <input type="hidden" name="idTourTicket" value="<%=t.getIdTourTicket()%>"/>
                                        <input type="hidden" name="nameOfDestination" value="<%=tourList.get(0).getDestination()%>"/>
                                        <div class="d-flex gap-2 flex-wrap">
                                            <button type="submit" name="action" value="ticketDetail" class="btn btn-vietnam-primary btn-sm">
                                                <i class="fas fa-eye me-1"></i>Xem chi tiết
                                            </button>
                                            <button type="submit" name="action" value="updateTicket" class="btn btn-vietnam-secondary btn-sm">
                                                <i class="fas fa-edit me-1"></i>Cập nhật
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <%    
                            } 
                        }  
                        %>
                    </div>

                    <div class="section-header">
                        <i class="fas fa-play-circle me-2"></i>
                        Danh sách vé đang hoạt động
                    </div>
                </c:if>

                <div class="row">
                    <%
                    for (TourTicketDTO t : tourList) {
                        int index = tourList.indexOf(t) + 1;
                        List<StartDateDTO> startDates = (List<StartDateDTO>) request.getAttribute("startDateTour" + index);
                        if (t.isStatus()) {
                            flag = true;
                    %>    
                    <div class="col-lg-6 col-xl-4 mb-4">
                        <div class="tour-card">
                            <c:if test="${sessionScope.nameUser.role eq 'AD'}">
                                <div class="status-indicator status-active">
                                    <i class="fas fa-check"></i> Hoạt động
                                </div>
                            </c:if>
                            <img class="tour-img" src="<%=t.getImg_Tour()%>" alt="<%= t.getNametour() %>">
                            <div class="tour-content">
                                <h3 class="tour-title"><%= t.getNametour() %></h3>

                                <div class="tour-meta">
                                    <i class="fas fa-tag"></i>
                                    <span>Mã tour: <strong><%= t.getIdTourTicket() %></strong></span>
                                </div>

                                <div class="tour-meta">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <span>Khởi hành: <strong><%= t.getPlacestart() %></strong></span>
                                </div>

                                <div class="tour-meta">
                                    <i class="fas fa-clock"></i>
                                    <span>Thời gian: <strong><%= t.getDuration() %></strong></span>
                                </div>

                                <div class="tour-meta">
                                    <i class="fas fa-plane"></i>
                                    <span>Phương tiện: <strong><%= t.getTransport_name() %></strong></span>
                                </div>

                                <div class="tour-meta tour-dates">
                                    <i class="fas fa-calendar-alt"></i>
                                    <span>Ngày khởi hành:</span>
                                    <div class="w-100 mt-2">
                                        <% if (startDates != null && !startDates.isEmpty()) {
                                            for (StartDateDTO sd : startDates) {
                                        %>
                                        <span class="date-badge me-2 mb-2 d-inline-block"><%= sd.getStartDate() %></span>
                                        <%  }
                                        } else { %>
                                        <span class="date-badge">Chưa có lịch</span>
                                        <% } %>
                                    </div>
                                </div>

                                <div class="price">
                                    <i class="fas fa-money-bill-wave me-2"></i>
                                    Giá từ: <%= String.format("%,.0f", t.getPrice()) %> đ
                                </div>

                                <div class="d-flex gap-2 flex-wrap align-items-center">
                                    <form action="MainController" method="get">
                                        <input type="hidden" name="idTourTicket" value="<%=t.getIdTourTicket()%>"/>
                                        <input type="hidden" name="nameOfDestination" value="<%=tourList.get(0).getDestination()%>"/>
                                        <div class="d-flex gap-2 flex-wrap">
                                            <button type="submit" name="action" value="ticketDetail" class="btn btn-vietnam-primary btn-sm">
                                                <i class="fas fa-eye me-1"></i>Xem chi tiết
                                            </button>

                                            <c:if test="${sessionScope.nameUser.role eq 'AD'}">
                                                <button type="submit" name="action" value="updateTicket" class="btn btn-vietnam-secondary btn-sm">
                                                    <i class="fas fa-edit me-1"></i>Cập nhật
                                                </button>
                                                <button type="submit" name="action" value="deleteTicket" class="btn btn-vietnam-danger btn-sm"
                                                        onclick="return confirm('Bạn có chắc chắn muốn xóa không?');">
                                                    <i class="fas fa-trash me-1"></i>Xóa
                                                </button>
                                            </c:if>
                                        </div>
                                    </form>
                                    <c:if test="${sessionScope.nameUser.role ne 'AD'}">
                                        <form action="MainController" method="post"> <!-- POST là hợp lý hơn cho thêm dữ liệu -->
                                            <input type="hidden" name="action" value="addFavoriteTour">
                                            <input type="hidden" name="idTourTicket" value="<%=t.getIdTourTicket()%>">
                                            <input type="hidden" name="location" value="<%=location%>">
                                            <input type="hidden" name="idUser" value="<%= session.getAttribute("nameUser") != null ? ((DTO.UserDTO)session.getAttribute("nameUser")).getIdUser() : "" %>">
                                            <input type="hidden" name="referer" value="<%= request.getRequestURI() + (request.getQueryString() != null ? "?" + request.getQueryString() : "") %>">
                                            <button type="submit" class="btn btn-favorite" data-bs-toggle="tooltip" title="Thêm vào yêu thích">
                                                <i class="fas fa-heart"></i>
                                            </button>
                                        </form>

                                    </c:if>
                                </div>

                            </div>
                        </div>
                    </div>
                    <%    
                        }   
                    } // end for
                    %>
                </div>

                <%
                if (!flag) {
                %>
                <div class="no-tours">
                    <i class="fas fa-search"></i>
                    <h3>Không có tour nào được tìm thấy</h3>
                    <p>Vui lòng thử lại sau hoặc liên hệ với chúng tôi để được hỗ trợ.</p>
                </div>
                <%
                }
            } else {
                %>
                <div class="no-tours">
                    <i class="fas fa-search"></i>
                    <h3>Không có tour nào được tìm thấy</h3>
                    <p>Vui lòng thử lại sau hoặc liên hệ với chúng tôi để được hỗ trợ.</p>
                </div>
                <%
            } // end if
                %>
            </div>

            <c:if test="${sessionScope.nameUser.role == 'AD'}">
                <!-- Nút thêm vé luôn hiện với Admin -->
                <form action="MainController" method="get">
                    <input type="hidden" name="action" value="addTicket">
                    <input type="hidden" name="destination" value="<%=location%>">
                    <button type="submit" class="btn-add-ticket">
                        <i class="fas fa-plus me-2"></i>Thêm vé
                    </button>
                </form>
            </c:if>
        </div>
        <c:if test="${sessionScope.nameUser.role != 'AD'}">
            <%@include file="footer.jsp" %>
        </c:if>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                            // Smooth scrolling effect
                                                            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                                                                anchor.addEventListener('click', function (e) {
                                                                    e.preventDefault();
                                                                    const target = document.querySelector(this.getAttribute('href'));
                                                                    if (target) {
                                                                        target.scrollIntoView({behavior: 'smooth'});
                                                                    }
                                                                });
                                                            });

                                                            // Image loading animation
                                                            document.addEventListener('DOMContentLoaded', function () {
                                                                const images = document.querySelectorAll('.tour-img');
                                                                images.forEach(img => {
                                                                    if (img.complete) {
                                                                        img.classList.add('loaded');
                                                                    } else {
                                                                        img.addEventListener('load', function () {
                                                                            this.classList.add('loaded');
                                                                        });
                                                                    }
                                                                });
                                                            });

                                                            // Card animation on scroll
                                                            const observer = new IntersectionObserver(entries => {
                                                                entries.forEach(entry => {
                                                                    if (entry.isIntersecting) {
                                                                        entry.target.classList.add('animate-in');
                                                                    }
                                                                });
                                                            }, {
                                                                threshold: 0.1,
                                                                rootMargin: '0px 0px -50px 0px'
                                                            });

                                                            // Observe all cards
                                                            document.querySelectorAll('.card, .tour-card, .service-card').forEach(card => {
                                                                observer.observe(card);
                                                            });

                                                            // Simple fade-in effect for elements
                                                            document.querySelectorAll('.fade-in').forEach(element => {
                                                                observer.observe(element);
                                                            });

                                                            // Kích hoạt tooltip bootstrap
                                                            const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
                                                            const tooltipList = [...tooltipTriggerList].map(el => new bootstrap.Tooltip(el))
        </script>
    </body>
</html>