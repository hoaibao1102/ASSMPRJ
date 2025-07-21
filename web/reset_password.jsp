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
        <style>
            :root {
                /* Tông màu chính */
                --sky-blue: #0EA5E9;
                --coral-orange: #FF6B35;
                --emerald-green: #10B981;
                
                /* Tông màu phụ */
                --golden-yellow: #F59E0B;
                --purple: #8B5CF6;
                --pearl-white: #FEFEFE;
                
                /* Gradient */
                --gradient-primary: linear-gradient(135deg, #0EA5E9, #10B981);
                --gradient-secondary: linear-gradient(135deg, #FF6B35, #F59E0B);
                
                /* Text colors */
                --text-dark: #1F2937;
                --text-medium: #6B7280;
                --text-light: #9CA3AF;
                
                /* Background */
                --bg-light: #F8FAFC;
                --bg-dark: #1F2937;
            }
            
            * {
                font-family: 'Poppins', sans-serif;
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            body {
                background: var(--gradient-primary);
                min-height: 100vh;
                position: relative;
            }
            
            .main-container {
                position: relative;
                z-index: 10;
            }
            
            .reset-card {
                background: var(--pearl-white);
                border-radius: 20px;
                border: 1px solid #dee2e6;
                overflow: hidden;
                max-width: 450px;
                margin: 0 auto;
            }
            
            .card-header {
                background: var(--gradient-secondary);
                padding: 2rem;
                text-align: center;
                border: none;
            }
            
            .card-title {
                color: white;
                font-weight: 600;
                font-size: 1.5rem;
                margin: 0;
            }
            
            .card-icon {
                font-size: 3rem;
                color: white;
                margin-bottom: 1rem;
            }
            
            .card-body {
                padding: 2.5rem;
            }
            
            .form-floating {
                margin-bottom: 1.5rem;
            }
            
            .form-control {
                border: 2px solid #e9ecef;
                border-radius: 12px;
                padding: 0.75rem 1rem;
                font-size: 1rem;
                transition: all 0.3s ease;
                background: white;
            }
            
            .form-control:focus {
                border-color: var(--coral-orange);
                box-shadow: 0 0 0 0.2rem rgba(255, 107, 53, 0.25);
            }
            
            .form-floating > label {
                color: var(--text-medium);
                font-weight: 500;
            }
            
            .btn-tropical {
                background: var(--gradient-secondary);
                border: none;
                border-radius: 12px;
                padding: 0.75rem 1.5rem;
                font-weight: 600;
                font-size: 1.1rem;
                color: white;
                transition: all 0.3s ease;
                width: 100%;
            }
            
            .btn-tropical:hover {
                opacity: 0.9;
            }
            
            .alert {
                border: none;
                border-radius: 12px;
                padding: 1rem 1.5rem;
                margin-bottom: 1.5rem;
                font-weight: 500;
            }
            
            .alert-danger {
                background: rgba(220, 53, 69, 0.1);
                color: #dc3545;
                border-left: 4px solid #dc3545;
            }
            
            .alert-success {
                background: rgba(40, 167, 69, 0.1);
                color: #28a745;
                border-left: 4px solid #28a745;
            }
            
            .back-link {
                text-align: center;
                margin-top: 1.5rem;
            }
            
            .back-link a {
                color: var(--text-dark);
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
            }
            
            .back-link a:hover {
                color: var(--coral-orange);
            }
            
            /* Responsive Design */
            @media (max-width: 768px) {
                .card-body {
                    padding: 1.5rem;
                }
                .card-header {
                    padding: 1.5rem;
                }
            }
        </style>
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