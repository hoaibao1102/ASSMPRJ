<%-- 
    Document   : UserManager
    Created on : Jun 14, 2025, 2:46:24 PM
    Author     : ddhuy
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="UTILS.AuthUtils"%>
<%@page import="DTO.UserDTO"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User manager</title>
        <%@include file="header.jsp" %>
        <style>
            /* Reset hiệu ứng không cần thiết */
            * {
                box-shadow: none !important;
                animation: none !important;
                transition: none !important;
            }
            
            body {
                background-color: #FEFEFE; /* Trắng ngọc trai */
                color: #1F2937; /* Text chính */
                font-family: sans-serif;
                margin: 0;
                padding: 20px;
            }
            
            .user-manager-center {
                max-width: 1200px;
                margin: 0 auto;
            }
            
            .user-manager-title {
                color: #1F2937;
                text-align: center;
                margin-bottom: 20px;
                padding: 15px;
                background: linear-gradient(135deg, #0EA5E9, #10B981); /* Gradient chính */
                border-radius: 4px;
            }
            
            .user-manager-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            
            .user-manager-table th {
                background-color: #0EA5E9; /* Xanh biển Việt Nam */
                color: white;
                padding: 12px 15px;
                text-align: left;
            }
            
            .user-manager-table td {
                padding: 12px 15px;
                border-bottom: 1px solid #ddd;
            }
            
            .user-manager-table tr:nth-child(even) {
                background-color: #FEFEFE;
            }
            
            .user-manager-table tr:hover {
                background-color: #f9f9f9;
            }
            
            button {
                background: linear-gradient(135deg, #FF6B35, #F59E0B); /* Gradient phụ */
                color: white;
                border: none;
                padding: 8px 15px;
                cursor: pointer;
                border-radius: 4px;
            }
            
            button:hover {
                background: linear-gradient(135deg, #F59E0B, #FF6B35);
            }
            
            .header {
                text-align: center;
                margin: 50px 0;
            }
            
            .access-denied {
                text-align: center;
                color: #6B7280; /* Text phụ */
                font-size: 18px;
                padding: 30px;
            }
        </style>
    </head>
    <body>
        <div class="user-manager-center">
            <%
                if (AuthUtils.isAdmin(session)) {
                    List<UserDTO> list = (List<UserDTO>)request.getAttribute("list");
            %>
            <h2 class="user-manager-title">Quản lý người dùng</h2>
            <table class="user-manager-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Role</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if(list != null && !list.isEmpty()) {
                            for(UserDTO u : list) {
                                if(u.isStatus() && "CUS".equals(u.getRole())) {
                    %>
                                    <tr>
                                        <td><%=u.getIdUser()%></td>
                                        <td><%=u.getFullName()%></td>
                                        <td><%=u.getEmail()%></td>
                                        <td><%=u.getPhone()%></td>
                                        <td><%=u.getRole()%></td>
                                        <td>
                                            <form action="MainController" method="get">
                                                <input type="hidden" name="action" value="orderOfUser" />
                                                <input type="hidden" name="userId" value="<%= u.getIdUser() %>" />
                                                <button type="submit">Xem đơn hàng</button>
                                            </form>
                                        </td>
                                    </tr>
                    <%
                                }
                            }
                        } else {
                    %>
                            <tr>
                                <td colspan="6" style="text-align: center;">Không có dữ liệu</td>
                            </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <%
                } else {
            %>
            <div class="header">
                <h1>ACCESS DENIED</h1>
            </div>
            <div class="access-denied">
                <%=AuthUtils.getAccessDeniedMessage("UserManager.jsp")%> 
            </div>
            <%
                }
            %>
        </div>
    </body>
</html>