<%-- 
    Document   : reset_password
    Created on : Jul 4, 2025, 2:14:01 PM
    Author     : ddhuy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Đặt lại mật khẩu</title>
    <style>
        .container { max-width: 400px; margin: 60px auto; padding: 2rem; background: #fff; border-radius: 10px; box-shadow: 0 4px 12px #001;}
        h2 { text-align: center; color: #2980b9; margin-bottom: 1.5rem;}
        input[type="password"] { width: 100%; padding: 10px; margin-bottom: 1rem; border: 1px solid #ccc; border-radius: 6px;}
        button { width: 100%; padding: 12px; background: #3498db; color: #fff; border: none; border-radius: 6px; font-size: 1rem;}
        .error { color: red; margin: 8px 0;}
        .success { color: green; margin: 8px 0;}
        .back-link { text-align: center; margin-top: 1.5rem;}
    </style>
</head>
<body>
    <div class="container">
        <h2>Đặt lại mật khẩu mới</h2>
        <form action="ForgotPasswordController" method="get">
            <input type="hidden" name="action" value="resetPassword"/>
            <input type="password" name="password" placeholder="Mật khẩu mới (≥6 ký tự)" minlength="6" required/>
            <input type="password" name="confirmPassword" placeholder="Xác nhận mật khẩu mới" minlength="6" required/>
            <button type="submit">Đổi mật khẩu</button>
        </form>
        <% String error = (String)request.getAttribute("error"); %>
        <% if (error != null) { %><div class="error"><%= error %></div><% } %>
        <div class="back-link">
            <a href="LoginForm.jsp">← Quay lại đăng nhập</a>
        </div>
    </div>
</body>
</html>
