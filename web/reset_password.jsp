<%-- 
    Document   : reset_password
    Created on : Jul 4, 2025, 2:14:01 PM
    Author     : ddhuy
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>VN Tours</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href="assets/css/rest_password.css" rel="stylesheet">
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="container-fluid main-container">
            <div class="row justify-content-center align-items-center min-vh-100 py-5">
                <div class="col-12 col-md-8 col-lg-6 col-xl-5">
                    <div class="card reset-card">
                        <div class="card-header">
                            <div class="card-icon">
                                <i class="fas fa-key"></i>
                            </div>
                            <h2 class="card-title">Đặt lại mật khẩu mới</h2>
                        </div>
                        <div class="card-body">
                            <form action="ForgotPasswordController" method="post" id="resetForm">
                                <input type="hidden" name="action" value="resetPassword"/>
                                <div class="form-floating mb-3">
                                    <input type="password" 
                                           class="form-control" 
                                           id="password" 
                                           name="password" 
                                           placeholder="Mật khẩu mới (≥6 ký tự)" 
                                           minlength="6" 
                                           required>
                                    <label for="password">
                                        <i class="fas fa-lock me-2"></i>Mật khẩu mới (≥6 ký tự)
                                    </label>
                                </div>
                                <div class="form-floating mb-4">
                                    <input type="password" 
                                           class="form-control" 
                                           id="confirmPassword" 
                                           name="confirmPassword" 
                                           placeholder="Xác nhận mật khẩu mới" 
                                           minlength="6" 
                                           required>
                                    <label for="confirmPassword">
                                        <i class="fas fa-lock me-2"></i>Xác nhận mật khẩu mới
                                    </label>
                                </div>
                                <div class="d-grid">
                                    <button type="submit" class="btn btn-tropical btn-lg">
                                        <i class="fas fa-shield-alt me-2"></i>
                                        Đổi mật khẩu
                                    </button>
                                </div>
                            </form>
                            <% String error = (String)request.getAttribute("error"); %>
                            <% if (error != null) { %>
                            <div class="alert alert-danger" role="alert">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                <%= error %>
                            </div>
                            <% } %>
                            <div class="back-link">
                                <a href="LoginForm.jsp" class="text-decoration-none">
                                    <i class="fas fa-arrow-left"></i>
                                    Quay lại đăng nhập
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"/>
        <!-- Bootstrap 5 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Form validation
            document.getElementById('resetForm').addEventListener('submit', function (e) {
                const password = document.getElementById('password').value;
                const confirmPassword = document.getElementById('confirmPassword').value;
                
                // Password matching validation
                if (password !== confirmPassword) {
                    e.preventDefault();
                    // Create and show error alert
                    const existingAlert = document.querySelector('.alert-danger');
                    if (existingAlert) {
                        existingAlert.remove();
                    }
                    const errorAlert = document.createElement('div');
                    errorAlert.className = 'alert alert-danger';
                    errorAlert.innerHTML = '<i class="fas fa-exclamation-triangle me-2"></i>Mật khẩu xác nhận không khớp!';
                    const form = document.getElementById('resetForm');
                    form.appendChild(errorAlert);
                    // Focus on confirm password field
                    document.getElementById('confirmPassword').focus();
                    return;
                }
            });
            
            // Password strength indicator
            document.getElementById('password').addEventListener('input', function() {
                const password = this.value;
                let strength = 0;
                if (password.length >= 6)
                    strength++;
                if (password.match(/[a-z]/))
                    strength++;
                if (password.match(/[A-Z]/))
                    strength++;
                if (password.match(/[0-9]/))
                    strength++;
                if (password.match(/[^a-zA-Z0-9]/))
                    strength++;
                // Visual feedback
                this.style.borderColor = strength >= 3 ? 'var(--golden-yellow)' : 'var(--coral-orange)';
            });
            
            // Confirm password matching indicator
            document.getElementById('confirmPassword').addEventListener('input', function() {
                const password = document.getElementById('password').value;
                const confirmPassword = this.value;
                if (confirmPassword && password !== confirmPassword) {
                    this.style.borderColor = '#dc3545';
                } else if (confirmPassword && password === confirmPassword) {
                    this.style.borderColor = '#28a745';
                } else {
                    this.style.borderColor = '#e9ecef';
                }
            });
        </script>
    </body>
</html>