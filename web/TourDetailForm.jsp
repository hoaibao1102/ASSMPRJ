<%-- 
    Document   : TourDetailForm
    Created on : May 21, 2025, 11:14:40 PM
    Author     : MSI PC
--%>
<%@page import="java.util.List"%>
<%@page import="DTO.TourDTO"%>
<%@page import="DTO.TourDetailDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết Tour</title>
        <style>


            .container1 {
                display: flex;
                max-width: 1200px;
                margin: 30px auto;
                gap: 30px;
            }

            .left-content {
                flex: 7;
                background-color: #f5f5f5;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
            }

            .right-content {
                flex: 3;
                background-color: #fff8f0;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
            }

            .left-content h1 {
                font-size: 2rem;
                color: #2c3e50;
                text-align: center;
                margin-bottom: 30px;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .left-content h2 {
                font-size: 1.3rem;
                color: #2980b9;
                margin-top: 25px;
                margin-bottom: 10px;
            }

            .left-content p {
                font-size: 1rem;
                color: #444;
                line-height: 1.6;
                margin-bottom: 15px;
            }

            .left-content img {
                width: 100%;
                max-width: 700px;
                height: auto;
                display: block;
                margin-top: 10px;
                margin-bottom: 25px;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            }

            /*            BÊN PHAIR */
            .right-content {
                background: #fff;
                border-radius: 12px;
                padding: 24px;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
                font-family: Arial, sans-serif;
                width: 100%;
                max-width: 360px;
            }

            .label {
                font-weight: bold;
                margin-bottom: 8px;
            }

            .price {
                font-size: 24px;
                color: red;
                margin-bottom: 16px;
            }

            .original-price {
                font-size: 18px;
                text-decoration: line-through;
                color: #999;
                margin-right: 8px;
            }

            .current-price {
                font-weight: bold;
                font-size: 28px;
                color: #e74c3c;
            }

            .discount-note {
                background-color: #ffe6e6;
                color: #d63031;
                padding: 10px;
                border-radius: 8px;
                font-size: 14px;
                margin-bottom: 20px;
            }

            .tour-details {
                list-style: none;
                padding: 0;
                margin: 0 0 20px 0;
                font-size: 14px;
            }

            .tour-details li {
                margin-bottom: 10px;
                display: flex;
                align-items: center;
            }

            .icon {
                margin-right: 6px;
                font-size: 16px;
            }

            .blue {
                color: #007bff;
                font-weight: bold;
            }

            .tour-actions {
                display: flex;
                gap: 10px;
                margin-bottom: 20px;
            }

            .btn-outline,
            .btn-primary,
            .btn-call {
                padding: 10px 14px;
                font-size: 14px;
                border-radius: 6px;
                cursor: pointer;
                border: 1px solid #e0e0e0;
                flex: 1;
            }

            .btn-outline {
                background-color: white;
                color: #d63031;
                border: 1px solid #d63031;
            }

            .btn-outline:hover {
                background-color: #fceeee;
            }

            .btn-primary {
                background-color: #e74c3c;
                color: white;
                border: none;
            }

            .btn-call {
                background-color: #0052cc;
                color: white;
                border: none;
                margin-bottom: 8px;
            }

            .tour-support {
                display: flex;
                flex-direction: column;
                gap: 8px;
            }

        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>

        <div class="container1">
            <div class="left-content">
                <%
                    TourDetailDTO tourDetail = (TourDetailDTO) request.getAttribute("tourDetail");
                    TourDTO tourTicket = (TourDTO) request.getAttribute("tourTicket");
                    DecimalFormat vnd = new DecimalFormat("#,###");
                    if (tourDetail != null && tourTicket != null) {
                %>

                <h1><%= tourTicket.getDestination() %>: <%= tourDetail.getNameTour() %></h1>

                <!-- Ngày 1 -->
                <div>
                    <h2>Ngày 1</h2>
                    <p><%= tourDetail.getDescriptD1() %></p>
                   
                </div>

                <!-- Ngày 2 -->
                <div>
                    <h2>Ngày 2</h2>
                    <p><%= tourDetail.getDescriptD2() %></p>
                   
                </div>

                <% if (tourDetail.getDescriptD3() != null) { %>
                <!-- Ngày 3 -->
                <div>
                    <h2>Ngày 3</h2>
                    <p><%= tourDetail.getDescriptD3() %></p>
                   
                </div>
                <% } %>
                <!-- Khách sạn -->
                <div>
                    <h2>hinh anh</h2>
                    <p><%= tourDetail.getImg() %></p>
                </div>

                
                <% } else { %>
                <p>Không tìm thấy thông tin chi tiết cho tour này.</p>
                <% } %>
            </div>
            <!--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////-->
            <div class="right-content">

                <div class="price">
                    <span class="label">Giá:</span>
                    <span class="original-price"><%= vnd.format(tourTicket.getPrice()+1000000) %> ₫</span> 
                </div>
                <span class="current-price"><%= vnd.format(tourTicket.getPrice())%> <span class="currency">₫</span></span> / Khách

                <div class="discount-note">
                    🎁 Đặt ngay để nhận được Ưu đãi online tiết kiệm thêm <strong>1,000K</strong>
                </div>

                <ul class="tour-details">
                    <li><span class="icon">🧾</span> Mã tour: <a href="#" class="blue"><%=tourTicket.getIdTour() %></a></li>
                    <li><span class="icon">📍</span> Khởi hành: <span class="blue"><%=tourTicket.getPlacestart() %></span></li>
                    <li><span class="icon">📅</span> Ngày khởi hành: <span class="blue"><%=tourTicket.getStartDate() %></span></li>
                    <li><span class="icon">⏳</span> Thời gian: <span class="blue"><%=tourTicket.getDuration() %></span></li>
                    <li><span class="icon">🪑</span> Số chỗ còn: <span class="blue">CHUA RO PHAI SU LY SAO</span></li>
                </ul>

                <div class="tour-actions">
                    <button class="btn-outline">Ngày khác</button>
                    <button class="btn-primary">Đặt ngay</button>
                </div>

                <div class="tour-support">
                    <button class="btn-call">📞 Gọi miễn phí qua internet</button>
                    <button class="btn-outline">💬 Liên hệ tư vấn</button>
                </div>
            </div>
        </div>

        <%@include file="footer.jsp" %>
    </body>
</html>
