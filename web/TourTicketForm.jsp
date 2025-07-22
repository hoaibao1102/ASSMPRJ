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
        <title>VN Tours</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/tour_ticket.css"/>
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