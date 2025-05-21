<%@page import="java.util.List"%>
<%@page import="DTO.TourDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Danh sách Tour</title>
        <style>
            header {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                background-color: #2c3e50;
                color: white;
                padding: 1rem 2rem;
                z-index: 1000;
                box-shadow: 0 2px 8px rgba(0,0,0,0.2);
            }
            body {
                margin: 0;
                padding-top: 90px;
                font-family: Arial, sans-serif;
                background: #f5f5f5;
            }

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

        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%
            List<TourDTO> tourList = (List<TourDTO>) request.getAttribute("tourList");
        %>

        <div class="container">
            <h1 style="margin-bottom: 20px;">Danh sách Tour <%=tourList.get(0).getDestination()%> </h1>
            <p  style="margin-bottom: 20px;"><%=tourList.get(0).getPlaceDescription()%></p>
            <%
                if (tourList != null && !tourList.isEmpty()) {
                    for (TourDTO t : tourList) {
            %>
            <div class="tour-card">
                <img class="tour-img" src="assets/images/places/<%=t.getImg()%>" alt="<%= t.getNameTour() %>">
                <div class="tour-content">
                    <div>
                        <div class="tour-title"><%= t.getNameTour() %></div>
                        <div class="tour-meta">🆔 Mã tour: <strong><%= t.getIdTour() %></strong></div>
                        <div class="tour-meta">📍 Khởi hành: <strong><%= t.getPlacestart() %></strong></div>
                        <div class="tour-meta">🕒 Thời gian: <strong><%= t.getDuration() %></strong></div>
                        <div class="tour-meta">✈️ Phương tiện: <strong><%= t.getTransport() %></strong></div>
                        <div class="tour-meta tour-dates">
                            📅 Ngày khởi hành: <span><%= t.getStartDate() %></span>
                        </div>
                        <div class="price">Giá từ: <%= String.format("%,.0f", t.getPrice()) %> đ</div>
                    </div>
                    
                    <!-- Form sử dụng input submit cho nút Xem chi tiết -->
                    <form action="placeController" method="get">
                         <input type="hidden" name="idTour" value="<%=t.getIdTour()%>" />
                         <input class="btn-detail" type="submit" value="Xem chi tiết" />
                    </form>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <p>Không có tour nào được tìm thấy.</p>
            <%
                }
            %>
        </div>

        <%@include file="footer.jsp" %>
    </body>
</html>
