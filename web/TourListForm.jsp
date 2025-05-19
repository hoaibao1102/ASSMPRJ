<%-- 
    Document   : TourListForm
    Created on : May 20, 2025, 12:04:53 AM
    Author     : MSI PC
--%>
<%@page import="java.util.List"%>
<%@ page import="DTO.TourDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <title>Tour tại ${location}</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                padding: 20px;
                background: #fafafa;
            }
            .container {
                max-width: 900px;
                margin: 0 auto;
            }
            .tour-card {
                background: white;
                border-radius: 8px;
                box-shadow: 0 0 10px #ccc;
                margin-bottom: 20px;
                display: flex;
                overflow: hidden;
                cursor: pointer;
                transition: box-shadow 0.3s ease;
            }
            .tour-card:hover {
                box-shadow: 0 0 20px #999;
            }
            .tour-image {
                width: 300px;
                height: 200px;
                object-fit: cover;
                flex-shrink: 0;
            }
            .tour-info {
                padding: 15px;
                flex: 1;
            }
            .tour-name {
                font-size: 1.4rem;
                font-weight: 700;
                margin-bottom: 10px;
                color: #2c3e50;
            }
            .tour-desc {
                font-size: 1rem;
                color: #555;
                margin-bottom: 10px;
            }
            .tour-details {
                font-size: 0.9rem;
                color: #777;
            }
        </style>
    </head>
    <body>
        <%
            List<TourDTO> tourList = (TourDTO)session.getAttribute("tourList");
        %>
        <h1>Tour tại <%= tourList.getDestination()%></h1>
        <%                        for (TourDTO t : tours) {
        %>
        <div class="container">
            <div class="tour-card" onclick="location.href = 'TourDetailController?idTour=<%= t.getDestination()%>'">
                <img class="tour-image" src="assets/images/<%= t.getDestination()%>" alt="<%= t.getDestination()%>" />
                <div class="tour-info">
                    <div class="tour-name"><%= t.getNameTour()%></div>
                    <div class="tour-desc"><%= t.getDuration()%>- Khởi hành từ: <%= t.getPlacestart%></div>
                    <div class="tour-details">
                        Giá: <%= t.getPrice()%> VND
                    </div>
                </div>
            </div>
        </div>
        <%
            }
        %>


    </body>
</html>

