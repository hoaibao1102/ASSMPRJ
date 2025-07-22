<%-- 
    Document   : forgot_password
    Created on : Jul 4, 2025, 2:13:14 PM
    Author     : ddhuy
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>VN Tours</title>
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href="assets/css/forgot_password.css" rel="stylesheet">
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="main-content">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5 col-md-6 col-sm-8">
                        <div class="forgot-card">
                            <div class="card-header">
                                <div class="icon">
                                    <i class="bi bi-key"></i>
                                </div>
                                <h2>Quên mật khẩu?</h2>
                                <p class="mb-0 opacity-75">Đừng lo lắng, chúng tôi sẽ giúp bạn!</p>
                            </div>
                            <div class="card-body">
                                <form action="ForgotPasswordController" method="post">
                                    <input type="hidden" name="action" value="sendCode"/>
                                    <div class="form-floating">
                                        <input type="email" class="form-control" id="email" name="email" 
                                               placeholder="name@example.com" required>
                                        <label for="email">
                                            <i class="bi bi-envelope me-2"></i>Email đã đăng ký
                                        </label>
                                    </div>
                                    <button type="submit" class="btn btn-send">
                                        <i class="bi bi-send me-2"></i>
                                        Gửi mã xác nhận
                                    </button>
                                </form>
                                <% String error = (String)request.getAttribute("error"); %>
                                <% String success = (String)request.getAttribute("success"); %>
                                <% if (error != null) { %>
                                <div class="alert alert-custom alert-error">
                                    <i class="bi bi-exclamation-triangle me-2"></i>
                                    <%= error %>
                                </div>
                                <% } %>
                                <% if (success != null) { %>
                                <div class="alert alert-custom alert-success">
                                    <i class="bi bi-check-circle me-2"></i>
                                    <%= success %>
                                </div>
                                <% } %>
                                <div class="back-link">
                                    <a href="LoginForm.jsp">
                                        <i class="bi bi-arrow-left"></i>
                                        Quay lại đăng nhập
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="footer.jsp"%>
        <!-- Bootstrap 5 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>