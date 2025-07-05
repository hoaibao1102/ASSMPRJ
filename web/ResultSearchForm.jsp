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

            .container1      {
                max-width: 1100px;
                margin: 50px auto 0 auto;

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

            /*            CSS PHAN THONG TIN NOI BAT*/

            .section {
                padding: 20px;
                max-width: 1200px;
                margin: 0 auto;
            }

            .title {
                font-size: 28px;
                font-weight: 700;
                margin-bottom: 30px;
                text-align: center;
                color: #222;
            }

            .grid {
                display: grid;
                grid-template-columns: repeat(3, 1fr); /* 3 cột đều nhau */
                gap: 24px;
            }

            form.card {
                display: flex;
                flex-direction: column;
                background: white;
                border-radius: 14px;
                box-shadow: 0 4px 14px rgba(0,0,0,0.1);
                overflow: hidden;
                cursor: pointer;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                height: 350px; /* chiều cao card cố định */
            }

            form.card:hover {
                transform: scale(1.05);
                box-shadow: 0 12px 30px rgba(0,0,0,0.2);
            }

            form.card .image-wrapper {
                flex: 1;
                overflow: hidden;
                border-radius: 14px 14px 0 0;
                position: relative;
            }

            form.card img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                display: block;
                transition: transform 0.3s ease;
            }

            form.card:hover img {
                transform: scale(1.1);
            }

            form.card h4 {
                padding: 12px 0;
                margin: 0;
                font-weight: 700;
                font-size: 18px;
                color: #222;
                text-align: center;
                user-select: none;
            }

            /* Nút overlay (nếu dùng) */
            .btn-overlay {
                position: absolute;
                bottom: 16px;
                left: 50%;
                transform: translateX(-50%);
                background-color: rgba(52, 152, 219, 0.8);
                color: white;
                border-radius: 24px;
                padding: 10px 28px;
                font-weight: 600;
                font-size: 14px;
                opacity: 0;
                pointer-events: none;
                transition: opacity 0.3s ease;
            }

            form.card:hover .btn-overlay {
                opacity: 1;
                pointer-events: auto;
            }

        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%
            List<TourTicketDTO> tourList = (List<TourTicketDTO>) request.getAttribute("tourList2");
            String searchTourInfor = request.getAttribute("searchTourInfor")+"";
        %>

        <div class="content">
            <div class="container1">
                <%
                    if (tourList != null && !tourList.isEmpty()) {
                %>
                <h2 style="margin-bottom: 15px">Dưới đây là các tour liên quan tới "<%=searchTourInfor%>"</h2>
                <%
                for (TourTicketDTO t : tourList) {
                    int index = tourList.indexOf(t) + 1;
                    List<StartDateDTO> startDates = (List<StartDateDTO>) request.getAttribute("startDateTour" + index);
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
                                }   else { %>
                                <span>Chưa có lịch</span>
                                <% } %>
                            </div>
                            <div class="price">Giá từ: <%= String.format("%,.0f", t.getPrice()) %> đ</div>
                        </div>

                        <!-- Form sử dụng input submit cho nút Xem chi tiết -->
                        <form action="MainController" method="get">
                            <input type="hidden" name="action" value="ticketDetail" />
                            <input type="hidden" name="idTourTicket" value="<%=t.getIdTourTicket()%>" />
                            <input class="btn-detail" type="submit" value="Xem chi tiết" />
                        </form>
                    </div>
                </div>
                <%
                        }
                    } else { %>
                <h2>Không tìm thấy thông tin liên quan đến: "<%=searchTourInfor%>"</h2>

                <% } %>
            </div>

            <div class="section">
                <div class="title">Điểm đến nổi bật</div>
                <div class="grid">
                    <%
                        List<PlacesDTO> placeList = (List<PlacesDTO>)request.getAttribute("placeList");
                        if (placeList != null && !placeList.isEmpty()) {
                            for (PlacesDTO p : placeList) {
                                if (p.getFeatured()) {
                            %>
                            <form class="card" action="MainController" method="post">
                                <div class="image-wrapper">
                                    <img src="assets/images/<%=p.getImg()%>" alt="<%=p.getPlaceName()%>" />
                                    <button type="submit" class="btn-overlay">Xem thêm</button>
                                </div>
                                <h4><%=p.getPlaceName()%></h4>
                                <input type="hidden" name="action" value="takeListTicket" />
                                <input type="hidden" name="location" value="<%=p.getPlaceName()%>" />
                            </form>
                            <%
                                }
                            }
                        }
                    %>
                </div>
            </div>
        </div>
    </div>

    <%@include file="footer.jsp" %>
</body>
</html>

