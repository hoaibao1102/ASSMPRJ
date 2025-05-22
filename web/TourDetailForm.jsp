<%-- 
    Document   : TourDetailForm
    Created on : May 21, 2025, 11:14:40 PM
    Author     : MSI PC
--%>
<%@page import="java.util.List"%>
<%@page import="DTO.TourDTO"%>
<%@page import="DTO.TourDetailDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết Tour</title>
        <style>
            .container {
                max-width: 1000px;
                margin: 20px auto;
                background: #ffffff;
                padding: 40px;
                border-radius: 12px;
                box-shadow: 0 8px 20px rgba(0,0,0,0.08);
            }

            .container h1 {
                font-size: 2.2rem;
                color: #2c3e50;
                text-align: center;
                margin-bottom: 30px;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .container h2 {
                font-size: 1.4rem;
                color: #2980b9;
                margin-top: 30px;
                margin-bottom: 10px;
            }

            .container p {
                font-size: 1.05rem;
                color: #444;
                line-height: 1.7;
                margin-bottom: 15px;
            }

            .container img {
                width: 100%;
                max-width: 720px;
                height: auto;
                display: block;
                margin-top: 10px;
                margin-bottom: 25px;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            }
        </style>

    </head>
    <body>
        <%@include file="header.jsp" %>
        <%
            
            TourDetailDTO tourDetail = (TourDetailDTO)request.getAttribute("tourDetail");
            TourDTO tourTicket = (TourDTO)request.getAttribute("tourTicket");
            
            if (tourDetail != null && tourTicket!= null) {
        %>

        <!-- Hiển thị thông tin của tourDetail -->
        <h1><%=tourTicket.getDestination()%>: <%= tourDetail.getNameTour() %></h1>

        <!-- Mô tả ngày 1 -->
        <div>
            <h2>Ngày 1</h2>
            <p><%= tourDetail.getDescriptD1() %></p>
            <img src="assets/images/<%= tourDetail.getImgD1() %>" alt="Ngày 1" width="500px"/>
        </div>

        <!-- Mô tả ngày 2 -->
        <div>
            <h2>Ngày 2</h2>
            <p><%= tourDetail.getDescriptD2() %></p>
            <img src="assets/images/<%= tourDetail.getImgD2() %>" alt="Ngày 2" width="500px"/>
        </div>

        <!-- Mô tả ngày 3 -->
        <%if(tourDetail.getDescriptD3() != null){
        %>
        <div>
            <h2>Ngày 3</h2>
            <p><%= tourDetail.getDescriptD3() %></p>
            <img src="assets/images/<%= tourDetail.getImgD3() %>" alt="Ngày 3" width="500px"/>
        </div>

        <!-- Hình ảnh khách sạn -->
        <div>
            <h2>Khách sạn</h2>
            <img src="assets/images/<%= tourDetail.getImgHotel() %>" alt="Khách sạn" width="500px"/>
        </div>

        <!-- Hình ảnh khác (nếu có) -->
        <div>
            <h2>Hình ảnh khác</h2>
            <img src="assets/images/<%= tourDetail.getImgOther() %>" alt="Hình ảnh khác" width="500px"/>
        </div>
        <%
            
            }%>

        <%
            } else {
        %>
        <p>Không tìm thấy thông tin chi tiết cho tour này.</p>
        <%
            }
        %>
        <%@include file="footer.jsp" %>
    </body>
</html>
