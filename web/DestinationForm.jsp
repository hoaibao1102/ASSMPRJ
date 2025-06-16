<%-- 
    Document   : DestinationForm
    Created on : May 19, 2025, 10:20:57 PM
    Author     : MSI PC
--%>
<%@page import="java.util.List"%>
<%@page import="DTO.PlacesDTO"%>
<%@ page import="UTILS.AuthUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="assets/css/bodyCss.css"/>
        <style>
            .places-container {
                max-width: 1200px;
                margin: 40px auto;
                display: flex;
                flex-direction: column;
                gap: 24px;
                padding: 0 20px;
            }

            .place-card {
                display: flex;
                background-color: white;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                overflow: hidden;
                cursor: pointer;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                height: 130px;
                position: relative;
                text-decoration: none;
            }

            .place-card:hover {
                transform: scale(1.02);
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            }

            .place-image {
                width: 180px;
                height: 100%;
                object-fit: cover;
                flex-shrink: 0;
            }

            .place-content {
                padding: 16px 24px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                flex: 1;
                position: relative;
            }

            .place-content h4 {
                margin: 0 0 8px 0;
                font-size: 22px;
                font-weight: 700;
                color: #222;
            }

            .place-content p {
                margin: 0;
                font-size: 15px;
                color: #555;
                line-height: 1.3;
            }

            .btn-overlay {
                position: absolute;
                bottom: 16px;
                right: 24px;
                background-color: rgba(52, 152, 219, 0.85);
                color: white;
                border-radius: 24px;
                padding: 8px 20px;
                font-weight: 600;
                font-size: 14px;
                opacity: 0;
                pointer-events: none;
                transition: opacity 0.3s ease;
                border: none;
                cursor: pointer;
            }

            .place-card:hover .btn-overlay {
                opacity: 1;
                pointer-events: auto;
            }

            h2{
                text-align: center;
            }
            .btn-group {
                display: flex;
                gap: 10px;
                margin-top: 12px;
            }

            .btn-overlay {
                background-color: #3498db;
                color: white;
                border-radius: 24px;
                padding: 8px 20px;
                font-weight: 600;
                font-size: 14px;
                border: none;
                cursor: pointer;
                transition: background-color 0.3s ease;
                position: relative;
                opacity: 1;
                pointer-events: auto;
            }

            .btn-overlay.orange {
                background-color: #f39c12;
            }

            .btn-overlay.red {
                background-color: #e74c3c;
            }

            .places-header {
                display: flex;
                flex-direction: column;
                align-items: center;
                margin: 20px 0;
                padding: 0 20px;
            }

            .btn-add-place {
                background-color: #2ecc71;
                color: white;
                border: none;
                border-radius: 24px;
                padding: 10px 20px;
                font-weight: 600;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .btn-add-place:hover {
                background-color: #27ae60;
            }


            /* Responsive */
            @media (max-width: 768px) {
                .place-card {
                    flex-direction: column;
                    height: auto;
                }
                .place-image {
                    width: 100%;
                    height: 220px;
                }
                .place-content {
                    padding: 12px 16px;
                }
                .btn-overlay {
                    position: relative;
                    bottom: auto;
                    right: auto;
                    margin-top: 12px;
                    opacity: 1;
                    pointer-events: auto;
                    width: 100%;
                    text-align: center;
                }
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <h2>Danh sách địa điểm</h2>
        <div class="places-header">
            
            <% if (AuthUtils.isAdmin(session)) { %>
            <form action="placeController" method="get" style="display: inline;">
                <input type="hidden" name="action" value="inactiveList">
                <button type="submit"
                        style="background-color: #28d17c; padding: 10px 20px; border: none; border-radius: 25px; color: white; font-weight: bold; cursor: pointer;">
                    📍 Danh sách điểm đến đang ngưng hoạt động
                </button>
            </form>
            <br>
            <form action="placeController" method="get">
                <input type="hidden" name="action" value="addPlace">
                <button type="submit" class="btn-add-place">+ Thêm địa điểm</button>
            </form>
            
            

            <% } %>
        </div>
        <div class="content places-container">
            <%
             List<PlacesDTO> placeList = (List<PlacesDTO>)request.getAttribute("placeList");
            %>

            <%
                            if (placeList != null && !placeList.isEmpty()) {
                                for (PlacesDTO p : placeList) {
            %>
            <form class="place-card" action="placeController" method="get">
                <img class="place-image" src="assets/images/<%=p.getImg()%>" alt="<%=p.getPlaceName()%>" />
                <div class="place-content">
                    <h4><%=p.getPlaceName()%></h4>
                    <p><%=p.getDescription() %></p>

                    <input type="hidden" name="location" value="<%=p.getPlaceName()%>" />

                    <div class="btn-group">
                        <!-- Nút Xem thêm -->
                        <button type="submit" name="action" value="takeListTicket" class="btn-overlay blue">Xem thêm</button>

                        <% if (AuthUtils.isAdmin(session)) { %>
                        <!-- Nút cập nhật -->
                        <button type="submit" name="action" value="updatePlace" class="btn-overlay orange">Cập nhật</button>

                        <!-- Nút xóa -->
                        <button type="submit" name="action" value="deletePlace" class="btn-overlay red"
                                onclick="return confirm('Bạn có chắc chắn muốn xóa không?');">Xóa</button>
                        <% } %>
                    </div>
                </div>
            </form>


            <%
                }
            }else{
            %>
            <h1>khong co thong tin</h1>
            <%
        }
            %>
        </div>
        <%@include file="footer.jsp" %>
    </body>
</html>
