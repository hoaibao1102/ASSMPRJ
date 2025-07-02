<%@page import="java.util.List"%>
<%@page import="DTO.TourTicketDTO"%>
<%@page import="DTO.StartDateDTO"%>
<%@page import="DAO.PlacesDAO"%>
<%@page import="UTILS.AuthUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Danh sách Tour</title>
        <link rel="stylesheet" href="assets/css/bodyCss.css"/>
        <style>
            h1 {
                font-weight: 900;
                font-size: 3rem;
                margin-bottom: 12px;
                letter-spacing: 2px;
                color: #2c3e50;
                text-transform: uppercase;
                font-family: 'Segoe UI Black', 'Arial Black', Arial, sans-serif;
                text-shadow: 1px 1px 2px rgba(0,0,0,0.15);
            }

            p.description {
                font-size: 1.2rem;
                color: #6c7a89;
                max-width: 800px;
                margin: 0 auto 30px auto;
                line-height: 1.6;
                font-style: italic;
                border-left: 5px solid #2980b9;
                padding-left: 15px;
                font-family: 'Georgia', serif;
                letter-spacing: 0.5px;
            }

            .container {
                max-width: 1100px;
                margin: 85px auto 0 auto;
            }

            .tour-card {
                display: flex;
                background: #fff;
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 4px 10px rgba(0,0,0,0.1);
                margin-bottom: 24px;
            }

            .tour-img {
                width:  435px;
                height: 100%;
                object-fit: cover;
                flex-shrink: 0;
            }

            .tour-content {
                flex: 1;
                padding: 16px 20px;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }

            .tour-title {
                font-size: 1.4rem;
                font-weight: bold;
                color: #2c3e50;
                margin-bottom: 8px;
            }

            .tour-meta {
                font-size: 0.95rem;
                margin: 4px 0;
                color: #555;
            }

            .tour-meta strong {
                color: #222;
            }

            .tour-dates span {
                background: #fff3f3;
                color: #d32f2f;
                padding: 6px 10px;
                border: 1px solid #ffcdd2;
                border-radius: 6px;
                margin-right: 6px;
                font-size: 0.9rem;
            }

            .price {
                font-size: 1.3rem;
                font-weight: bold;
                color: #e53935;
                margin: 8px 0;
            }

            /* CSS cho nút Xem chi tiết */
            .btn-detail {
                align-self: flex-end;
                padding: 12px 25px;
                background: #0d6efd;
                color: white;
                border: none;
                border-radius: 6px;
                font-weight: 600;
                cursor: pointer;
                text-decoration: none;
                font-size: 1rem;
                margin-top: 10px;
                margin-left: 77%;
            }

            .btn-detail:hover {
                background: #084298;
            }

            .btn-detail:focus {
                outline: none;
            }

            .btn-group {
                display: flex;
                gap: 10px;
                margin-top: 16px;
            }

            .btn-overlay {
                background-color: #3498db;
                color: white;
                border-radius: 20px;
                padding: 8px 16px;
                font-weight: 600;
                font-size: 14px;
                border: none;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .btn-overlay.orange {
                background-color: #e67e22;
            }

            .btn-overlay.red {
                background-color: #e74c3c;
            }

            .btn-overlay:hover {
                filter: brightness(1.1);
            }

            .btn-add-ticket {
                background-color: #2ecc71;
                color: white;
                border: none;
                border-radius: 24px;
                padding: 10px 20px;
                font-weight: 600;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease;
                margin-top: 20px;
            }

            .btn-add-ticket:hover {
                background-color: #27ae60;
            }
            /*====================================================================  css anh dau trang*/
            .breadcrumb {
                margin: 1rem 2rem; /* cách đều trái phải giống header padding */
                font-size: 1rem;
                color: #555;
                font-family: Arial, sans-serif;
            }

            .breadcrumb a {
                color: #2980b9; /* màu xanh link */
                text-decoration: none;
                font-weight: 600;
            }

            .breadcrumb a:hover {
                text-decoration: underline;
            }

            .breadcrumb .current {
                color: #2c3e50; /* màu đậm hơn, font bold */
                font-weight: 700;
            }


        </style>
    </head>
    <body class="<%= AuthUtils.isAdmin(session)? "admin-layout" : "" %>">
        <%@include file="header.jsp" %>

        <%
            List<TourTicketDTO> tourList = (List<TourTicketDTO>) request.getAttribute("tourList");
            String discriptionPlaces = (String) request.getAttribute("discriptionPlaces");
            String location = (String) request.getAttribute("location");
        %>

        <div class="content">
            <div class="breadcrumb">
                <a href="placeController?action=destination&page=indexjsp">Trang chủ</a> /
                <a href="placeController?action=destination&page=destinationjsp">Điểm đến</a> /
                <span class="current">Du lịch <%=location%></span>
            </div>

            <div class="container">
                
                <%
                if (tourList != null && !tourList.isEmpty()) {
                %>

                <!--              cờ đánh dấu xem liệu trong danh sách có tồn tại ticket isStatus() là true không -->
                <%! boolean flag = false;  %>

                <h1 style="margin-bottom: 20px;">Danh sách Tour <%=tourList.get(0).getDestination()%> </h1>
                <c:if test="${sessionScope.nameUser.role != 'AD'}">
                    <p style="margin-bottom: 20px;"><%=discriptionPlaces%></p>
                </c:if>

                <c:if test="${sessionScope.nameUser.role == 'AD'}">
                    <h2>📍 Danh sách vé đang ngưng hoạt động</h2>
                    <%
                   for (TourTicketDTO t : tourList) {
                        int index = tourList.indexOf(t) + 1;
                        List<StartDateDTO> startDates = (List<StartDateDTO>) request.getAttribute("startDateTour" + index);
                        if(!t.isStatus()) {
                          
                    %>    

                    <div class="tour-card">
                        <img class="tour-img" src="assets/images/places/<%=t.getImg_Tour()%>" alt="<%= t.getNametour() %>">
                        <div class="tour-content">
                            <div>
                                <div class="tour-title"><%= t.getNametour() %></div>
                                <div class="tour-meta">🆔 Mã tour: <strong><%= t.getIdTourTicket() %></strong></div>
                                <div class="tour-meta">📍 Khởi hành: <strong><%= t.getPlacestart() %></strong></div>
                                <div class="tour-meta">🕒 Thời gian: <strong><%= t.getDuration() %></strong></div>
                                <div class="tour-meta">✈️ Phương tiện: <strong><%= t.getTransport_name() %></strong></div>

                                <div class="tour-meta tour-dates">
                                    📅 Ngày khởi hành:
                                    <% if (startDates != null && !startDates.isEmpty()) {
                                        for (StartDateDTO sd : startDates) {
                                    %>
                                    <span><%= sd.getStartDate() %></span>
                                    <%  }
                        } else { %>
                                    <span>Chưa có lịch</span>
                                    <% } %>
                                </div>

                                <div class="price">Giá từ: <%= String.format("%,.0f", t.getPrice()) %> đ</div>
                            </div>

                            <form action="placeController" method="get">
                                <input type="hidden" name="idTourTicket" value="<%=t.getIdTourTicket()%>"/>
                                <input type="hidden" name="nameOfDestination" value="<%=tourList.get(0).getDestination()%>"/>
                                <div class="btn-group">
                                    <button type="submit" name="action" value="ticketDetail" class="btn-overlay blue">Xem chi tiết</button>

                                    <c:if test="${sessionScope.nameUser.role eq 'AD'}">
                                        <button type="submit" name="action" value="updateTicket" class="btn-overlay orange">Cập nhật</button>

                                    </c:if>
                                </div>
                            </form>
                        </div>
                    </div>

                    <%    
                        } 
                    }  
                    %>

                    <h2>📍 Danh sách vé đang hoạt động</h2>
                </c:if>



                <%
                for (TourTicketDTO t : tourList) {
                    int index = tourList.indexOf(t) + 1;
                    List<StartDateDTO> startDates = (List<StartDateDTO>) request.getAttribute("startDateTour" + index);
                    if(t.isStatus()) {
                        flag = true;
                %>    

                <div class="tour-card">
                    <img class="tour-img" src="<%=t.getImg_Tour()%>" alt="<%= t.getNametour() %>">
                    <div class="tour-content">
                        <div>
                            <div class="tour-title"><%= t.getNametour() %></div>
                            <div class="tour-meta">🆔 Mã tour: <strong><%= t.getIdTourTicket() %></strong></div>
                            <div class="tour-meta">📍 Khởi hành: <strong><%= t.getPlacestart() %></strong></div>
                            <div class="tour-meta">🕒 Thời gian: <strong><%= t.getDuration() %></strong></div>
                            <div class="tour-meta">✈️ Phương tiện: <strong><%= t.getTransport_name() %></strong></div>

                            <div class="tour-meta tour-dates">
                                📅 Ngày khởi hành:
                                <% if (startDates != null && !startDates.isEmpty()) {
                                    for (StartDateDTO sd : startDates) {
                                %>
                                <span><%= sd.getStartDate() %></span>
                                <%  }
                        } else { %>
                                <span>Chưa có lịch</span>
                                <% } %>
                            </div>

                            <div class="price">Giá từ: <%= String.format("%,.0f", t.getPrice()) %> đ</div>
                        </div>

                        <form action="placeController" method="get">
                            <input type="hidden" name="idTourTicket" value="<%=t.getIdTourTicket()%>"/>
                            <input type="hidden" name="nameOfDestination" value="<%=tourList.get(0).getDestination()%>"/>
                            <div class="btn-group">
                                <button type="submit" name="action" value="ticketDetail" class="btn-overlay blue">Xem chi tiết</button>

                                <c:if test="${sessionScope.nameUser.role eq 'AD'}">
                                    <button type="submit" name="action" value="updateTicket" class="btn-overlay orange">Cập nhật</button>
                                    <button type="submit" name="action" value="deleteTicket" class="btn-overlay red"
                                            onclick="return confirm('Bạn có chắc chắn muốn xóa không?');">Xóa</button>
                                </c:if>
                            </div>
                        </form>
                    </div>
                </div>


                <%    
                    }   
                %>


                <%
                    } // end for
                   if(!flag){
                %>
                <p>Không có tour nào được tìm thấy.</p>
                <%
            }
            } else {
                %>
                <p>Không có tour nào được tìm thấy.</p>
                <%
                } // end if
                %>
            </div>
            <c:if test="${sessionScope.nameUser.role == 'AD'}">
                    <!-- Nút thêm vé luôn hiện với Admin -->
                    <form action="placeController" method="get">
                        <input type="hidden" name="action" value="addTicket">
                        <input type="hidden" name="destination" value="<%=location%>">
                        
                        <button type="submit" class="btn-add-ticket">+ Thêm vé</button>
                    </form>
                </c:if>
        </div>

        <%@include file="footer.jsp" %>
    </body>
</html>
