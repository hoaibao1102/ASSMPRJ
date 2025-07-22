<%--
Document : LoginForm
Created on : May 13, 2025, 4:32:35 PM
Author : MSI PC
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>VN Tours</title>
        
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href="assets/css/login.css" rel="stylesheet">
        
    </head>
    <body>
        <%@include file="header.jsp"%>
        
        <div class="header-pattern"></div>
        
        <div class="content content_sub">
            <div class="login-container">
                <c:if test="${not empty requestScope.errorMessage}">
                    <script>
                        window.alert("${errorMessage}");
                    </script>
                </c:if>
                
                <div class="login-header">
                    <div class="icon-wrapper">
                        <i class="fas fa-plane"></i>
                    </div>
                    <h2>Đăng nhập</h2>
                    <p class="subtitle">Khám phá thế giới cùng chúng tôi</p>
                </div>
                <form action="loginController" method="post" novalidate> 
                    <input type="hidden" value="login" name="action"> 
                    
                    <div class="form-floating position-relative">
                        <input type="text" class="form-control" id="txtEmailOrPhone" 
                               name="txtEmailOrPhone" placeholder="Email hoặc Số điện thoại" 
                               required autocomplete="username">
                        <label for="txtEmailOrPhone">Email hoặc Số điện thoại</label>
                        <i class="bi bi-person-circle input-icon"></i>
                    </div>
                    
                    <div class="form-floating position-relative">
                        <input type="password" class="form-control" id="txtPassword" 
                               name="txtPassword" placeholder="Mật khẩu" 
                               required autocomplete="current-password">
                        <label for="txtPassword">Mật khẩu</label>
                        <i class="bi bi-lock input-icon"></i>
                    </div>
                    
                    <!-- Hiển thị thông báo lỗi từ server -->
                    <c:if test="${not empty requestScope.message}">
                        <div class="alert alert-danger">
                            <i class="fas fa-exclamation-circle me-2"></i>
                            <c:out value="${requestScope.message}"/>
                        </div>
                    </c:if>
                    
                    <a href="forgot_password.jsp" class="forgot-link">
                        <i class="bi bi-question-circle me-1"></i>
                        Quên mật khẩu?
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-box-arrow-in-right me-2"></i>
                        Đăng nhập
                    </button>
                </form>
                <div class="login-link">
                    <p>Bạn chưa có tài khoản?</p>
                    <a href="RegisForm.jsp">
                        <i class="bi bi-person-plus me-1"></i>
                        Đăng ký ngay
                    </a>
                </div>
            </div>
        </div>
        
        <%@include file="footer.jsp"%>
        
        <!-- Bootstrap 5 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>