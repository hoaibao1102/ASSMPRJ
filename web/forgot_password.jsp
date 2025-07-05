<%-- 
    Document   : forgot_password
    Created on : Jul 4, 2025, 2:13:14 PM
    Author     : ddhuy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Quên mật khẩu</title>
    <style>
        .container { max-width: 400px; margin: 60px auto; padding: 2rem; background: #fff; border-radius: 10px; box-shadow: 0 4px 12px #0001;}
        h2 { text-align: center; color: #2980b9; margin-bottom: 1.5rem;}
        input[type="email"] { width: 100%; padding: 10px; margin-bottom: 1rem; border: 1px solid #ccc; border-radius: 6px;}
        button { width: 100%; padding: 12px; background: #3498db; color: #fff; border: none; border-radius: 6px; font-size: 1rem;}
        .error { color: red; margin: 8px 0;}
        .success { color: green; margin: 8px 0;}
        .back-link { text-align: center; margin-top: 1.5rem;}
    </style>
</head>
<body>
    <div class="container">
        <h2>Quên mật khẩu?</h2>
        <form action="ForgotPasswordController" method="get">
            <input type="hidden" name="action" value="sendCode"/>
            <input type="email" name="email" placeholder="Nhập email đã đăng ký" required/>
            <button type="submit">Gửi mã xác nhận</button>
        </form>
        <% String error = (String)request.getAttribute("error"); %>
        <% String success = (String)request.getAttribute("success"); %>
        <% if (error != null) { %><div class="error"><%= error %></div><% } %>
        <% if (success != null) { %><div class="success"><%= success %></div><% } %>
        <div class="back-link">
            <a href="LoginForm.jsp">← Quay lại đăng nhập</a>
        </div>
    </div>
</body>
</html>
