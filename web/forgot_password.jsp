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
        <style>
            :root {
                --primary-color: #0EA5E9; /* Xanh biển Việt Nam */
                --secondary-color: #10B981; /* Xanh lá nhiệt đới */
                --accent-color: #FF6B35; /* Cam nhiệt đới */
                --secondary-accent: #F59E0B; /* Vàng ánh dương */
                --text-color: #1F2937; /* Text chính */
                --text-secondary: #6B7280; /* Text phụ */
                --white: #FEFEFE; /* Trắng ngọc trai */
                --border-radius: 8px;
            }
            * {
                font-family: 'Poppins', sans-serif;
            }
            body {
                background: var(--white);
                min-height: 100vh;
                display: flex;
                flex-direction: column;
                padding-top: 10%; 
            }
            .main-content {
                flex: 1;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 20px 0;
            }
            .forgot-card {
                background: white;
                border-radius: var(--border-radius);
                padding: 2rem;
                border: 1px solid #e9ecef;
            }
            .card-header {
                background: linear-gradient(135deg, var(--accent-color), var(--secondary-accent));
                color: white;
                text-align: center;
                padding: 1.5rem;
                margin: -2rem -2rem 1.5rem -2rem;
                border-radius: var(--border-radius) var(--border-radius) 0 0;
            }
            .card-header h2 {
                font-size: 1.8rem;
                font-weight: 600;
                margin: 0;
            }
            .card-header .icon {
                font-size: 2.5rem;
                margin-bottom: 1rem;
            }
            .form-floating {
                margin-bottom: 1.5rem;
            }
            .form-control {
                border: 1px solid #e9ecef;
                border-radius: var(--border-radius);
                padding: 0.75rem;
                font-size: 1rem;
            }
            .form-control:focus {
                border-color: var(--accent-color);
                box-shadow: none;
            }
            .form-floating > label {
                color: var(--text-secondary);
                font-weight: 500;
            }
            .btn-send {
                background: linear-gradient(135deg, var(--accent-color), var(--secondary-accent));
                border: none;
                border-radius: var(--border-radius);
                padding: 0.75rem 1.5rem;
                font-size: 1.1rem;
                font-weight: 600;
                color: white;
                width: 100%;
            }
            .alert-custom {
                border: none;
                border-radius: var(--border-radius);
                padding: 1rem;
                margin: 1.5rem 0;
                font-weight: 500;
            }
            .alert-error {
                background: #fee2e2;
                color: #b91c1c;
            }
            .alert-success {
                background: #dcfce7;
                color: #166534;
            }
            .back-link {
                text-align: center;
                margin-top: 1.5rem;
                padding-top: 1.5rem;
                border-top: 1px solid #e9ecef;
            }
            .back-link a {
                color: var(--text-color);
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
            }
            .back-link a:hover {
                color: var(--accent-color);
            }
            @media (max-width: 576px) {
                .card-body {
                    padding: 1.5rem 1rem;
                }
                .card-header {
                    padding: 1.5rem 1rem;
                }
                .card-header h2 {
                    font-size: 1.5rem;
                }
            }
        </style>
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