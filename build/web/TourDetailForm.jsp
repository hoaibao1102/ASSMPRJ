<%-- 
    Document   : TourDetailForm
    Created on : May 21, 2025, 11:14:40 PM
    Author     : MSI PC
--%>
<%@page import="DTO.TourDetailDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết Tour</title>
    </head>
    <body>
        <%
            
            TourDetailDTO tourDetail = (TourDetailDTO)request.getAttribute("tourDetail");

            if (tourDetail != null) {
        %>
            <!-- Hiển thị thông tin của tourDetail -->
            <h1>Chi tiết Tour: <%= tourDetail.getIdTour() %></h1>
            
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
            } else {
        %>
            <p>Không tìm thấy thông tin chi tiết cho tour này.</p>
        <%
            }
        %>
    </body>
</html>
