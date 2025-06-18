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
        <link rel="stylesheet" href="assets/css/bodyCss.css"/>
    </head>
    <body>

        <div class="user-manager-center">
            <%
                if (AuthUtils.isAdmin(session)){
                List<UserDTO> list = (List<UserDTO>)request.getAttribute("list");
            %>
    <!--        <p>Số user: <%= list != null ? list.size() : 0 %></p>-->
            <h2 class="user-manager-title">Quản lý người dùng</h2>
            <table class="user-manager-table">
                <thead>
                    <tr style="background: #14d548;">
                        <th>ID</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Role</th>
                        <!--                    <th>Status</th>-->
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if(list != null){
                            for(UserDTO u : list){
                                if(u.isStatus()){
                                    %>
                                    <tr>

                                        <td><%=u.getIdUser()%></td>
                                        <td><%=u.getFullName()%></td>
                                        <td><%=u.getEmail()%></td>
                                        <td><%=u.getPhone()%></td>
                                        <td><%=u.getRole()%></td>
                                        <td>
                                            <form action="userController" method="get" >
                                                <input type="hidden" name="action" value="orderOfUser" />
                                                <input type="hidden" name="userId" value="<%= u.getIdUser() %>" />
                                                <button type="submit" >Xem đơn hàng</button>
                                            </form>
                                        </td>
                                    </tr> 
                                    <%
                            }
                    %>

                    <%}   
                }%>
                </tbody>
            </table>
            <%
        }else {
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
