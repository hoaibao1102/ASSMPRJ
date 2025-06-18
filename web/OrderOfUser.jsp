<%-- 
    Document   : OrderOfUser
    Created on : Jun 18, 2025, 11:24:40 PM
    Author     : MSI PC
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, DTO.OrderDTO , UTILS.AuthUtils"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Đơn hàng của bạn</title>
        <style>
            table {
                width: 100%;
                border-collapse: collapse;
            }

            th, td {
                border: 1px solid #ccc;
                padding: 8px;
                text-align: left;
            }

            th {
                background-color: #f2f2f2;
            }

            h2 {
                color: #333;
            }
        </style>
    </head>
    <body>
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
                    <th>Ngày khởi hành </th>
                </tr>
            </thead>
            <tbody>
                <% for (OrderDTO order : list) { %>
                <tr>
                    <td><%= order.getIdTour() %></td>
                    <td><%= order.getBookingDate() %></td>
                    <td><%= order.getNumberTicket() %></td>
                    <td><%= order.getTotalPrice() %></td>
                    <td><%= order.isStatus() == 1? "Đã thanh toán ":"Chưa thanh toán" %></td>
                    <td><%= order.getIdBooking() %></td>
                    <td><%= order.getNote() %></td>
                    <td><%=startDateMap.get(order.getIdBooking())%></td>
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

