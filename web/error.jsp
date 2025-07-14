<%-- 
    Document   : error
    Created on : Jul 13, 2025, 8:44:24 PM
    Author     : ddhuy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Lỗi hệ thống</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="alert alert-danger">
            <h4 class="alert-heading">⚠️ Đã xảy ra lỗi!</h4>
            <p>
                <strong>Thông báo:</strong>
                <%= request.getAttribute("error") != null 
                    ? request.getAttribute("error") 
                    : request.getAttribute("message") != null 
                        ? request.getAttribute("message") 
                        : "Không rõ nguyên nhân." %>
            </p>

            <%-- Gợi ý Debug nếu có Exception --%>
            <%
                Throwable throwable = (Throwable) request.getAttribute("javax.servlet.error.exception");
                if (throwable != null) {
            %>
                <hr>
                <h5>Chi tiết lỗi (Debug):</h5>
                <pre><%= throwable.getMessage() %></pre>
            <%
                }
            %>

            <a href="MainController?action=destination&page=indexjsp" class="btn btn-primary mt-3">Quay về trang chủ</a>
        </div>
    </div>
</body>
</html>
