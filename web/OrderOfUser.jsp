<%-- 
    Document   : OrderOfUser
    Created on : Jun 18, 2025, 11:24:40 PM
    Author     : MSI PC
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, DTO.OrderDTO , UTILS.AuthUtils"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Đơn hàng của bạn</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f9f9f9;
                padding: 20px;
            }

            h2 {
                color: #2c3e50;
                margin-bottom: 20px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 30px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                background-color: #fff;
            }

            th, td {
                border: 1px solid #ddd;
                padding: 12px;
                text-align: left;
            }

            th {
                background-color: #3498db;
                color: white;
            }

            tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            .back-btn {
                display: inline-block;
                padding: 10px 20px;
                background-color: #3498db;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                transition: background-color 0.3s;
            }

            .back-btn:hover {
                background-color: #2980b9;
            }

            p {
                font-size: 16px;
                color: #555;
            }
        </style>
    </head>
    <body>
        <a href="javascript:history.back()" class="back-btn">← Quay lại</a>
        <c:choose>
            <c:when test="${sessionScope.nameUser.role eq 'AD'}">
                <h2>Danh sách đơn hàng của ${requestScope.userName}</h2>
            </c:when>
            <c:otherwise>
                <h2>Danh sách đơn hàng của bạn</h2>
            </c:otherwise>
        </c:choose>

        <%
            List<OrderDTO> list = (List<OrderDTO>) request.getAttribute("list");
            Map<String,String> startDateMap = (Map<String,String>) request.getAttribute("startDateMap");
            if (list != null && !list.isEmpty()) {
        %>

        <table>
            <thead>
                <tr>
                    <th>Mã tour</th>
                    <th>Ngày đặt</th>
                    <th>Số vé</th>
                    <th>Tổng tiền</th>
                    <th>Trạng thái</th>
                    <th>Mã booking</th>
                    <th>Ghi chú</th>
                    <th>Ngày khởi hành</th>
                </tr>
            </thead>
            <tbody>
                <% for (OrderDTO order : list) { %>
                <tr>
                    <td><%= order.getIdTour() %></td>
                    <td><%= order.getBookingDate() %></td>
                    <td><%= order.getNumberTicket() %></td>
                    <td>
                        <fmt:formatNumber value="<%= order.getTotalPrice() %>" type="currency" currencySymbol="₫" groupingUsed="true" />
                    </td>
                    <td><%= order.isStatus() == 1 ? "Đã thanh toán" : "Chưa thanh toán" %></td>
                    <td><%= order.getIdBooking() %></td>
                    <td><%= order.getNote() %></td>
                    <td><%= startDateMap.get(order.getIdBooking()) %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <%
            } else {
        %>
        <p>Không có đơn hàng nào được tìm thấy.</p>
        <%
            }
        %>

        
    </body>
</html>
