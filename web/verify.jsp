<%-- 
    Document   : verify.jsp
    Created on : 03-07-2025, 23:28:13
    Author     : MSI PC
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>VN Tours</title>
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            :root {
                /* Bảng màu chính - Tropical Vietnam */
                --primary-blue: #0EA5E9;
                --primary-orange: #FF6B35;
                --primary-green: #10B981;
                /* Bảng màu phụ */
                --golden-yellow: #F59E0B;
                --purple: #8B5CF6;
                --pearl-white: #FEFEFE;
                /* Gradient */
                --gradient-main: linear-gradient(135deg, #0EA5E9, #10B981);
                --gradient-secondary: linear-gradient(135deg, #FF6B35, #F59E0B);
                --gradient-accent: linear-gradient(135deg, #8B5CF6, #0EA5E9);
                /* Màu text */
                --text-dark: #1F2937;
                --text-medium: #6B7280;
                --text-light: #9CA3AF;
                /* Màu nền */
                --bg-light: #f8f9fa;
                --bg-white: #ffffff;
            }
            
            * {
                font-family: 'Poppins', sans-serif;
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            body {
                background: var(--gradient-main);
                min-height: 100vh;
                position: relative;
            }
            
            .verify-container {
                background: var(--bg-white);
                border-radius: 15px;
                border: 1px solid #dee2e6;
                position: relative;
                overflow: hidden;
            }
            
            .verify-container::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 5px;
                background: var(--gradient-secondary);
                z-index: 1;
            }
            
            .verify-header {
                text-align: center;
                padding: 2rem 1rem;
            }
            
            .verify-icon {
                width: 80px;
                height: 80px;
                background: var(--gradient-secondary);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 1.5rem;
            }
            
            .verify-icon i {
                color: white;
                font-size: 2rem;
            }
            
            h2 {
                color: var(--text-dark);
                font-weight: 600;
                margin-bottom: 1rem;
                font-size: 1.8rem;
            }
            
            .email-info {
                background: var(--bg-light);
                border-radius: 15px;
                padding: 1rem;
                margin-bottom: 2rem;
                border-left: 4px solid var(--primary-orange);
            }
            
            .email-info p {
                margin: 0;
                color: var(--text-dark);
                font-size: 0.95rem;
                line-height: 1.5;
            }
            
            .email-info strong {
                color: var(--primary-orange);
                font-weight: 600;
            }
            
            .code-inputs {
                display: flex;
                justify-content: center;
                gap: 0.5rem;
                margin-bottom: 2rem;
            }
            
            .code-inputs input {
                width: 50px;
                height: 50px;
                text-align: center;
                font-size: 1.4rem;
                font-weight: 600;
                border: 2px solid #e9ecef;
                border-radius: 12px;
                background: white;
                color: var(--text-dark);
            }
            
            .code-inputs input:focus {
                outline: none;
                border-color: var(--primary-orange);
            }
            
            .verify-btn {
                background: var(--gradient-secondary);
                border: none;
                border-radius: 15px;
                padding: 0.8rem 2rem;
                font-size: 1.1rem;
                font-weight: 600;
                color: white;
                transition: all 0.3s ease;
                width: 100%;
                cursor: pointer;
            }
            
            .verify-btn:disabled {
                background: #6c757d;
                cursor: not-allowed;
                opacity: 0.7;
            }
            
            .error-message {
                background: #f8d7da;
                border: 1px solid #f1aeb5;
                border-radius: 12px;
                padding: 1rem;
                margin-top: 1rem;
                color: #721c24;
                display: flex;
                align-items: center;
                gap: 0.5rem;
                font-weight: 500;
            }
            
            .info-section {
                background: #d1ecf1;
                border-radius: 15px;
                padding: 1.5rem;
                margin-top: 2rem;
                border-left: 4px solid var(--golden-yellow);
            }
            
            .info-section p {
                margin: 0 0 1rem 0;
                color: var(--text-dark);
                font-size: 0.9rem;
                line-height: 1.5;
            }
            
            .info-section p:last-child {
                margin-bottom: 0;
            }
            
            .back-link {
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                color: var(--primary-orange);
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s ease;
                padding: 0.5rem 1rem;
                border-radius: 8px;
                border: 2px solid transparent;
            }
            
            .back-link:hover {
                color: var(--primary-orange);
                background: rgba(255, 107, 53, 0.1);
                border-color: var(--primary-orange);
            }
            
            .footer {
                background: var(--text-dark);
                color: white;
                text-align: center;
                padding: 1.5rem;
                margin-top: 2rem;
                border-radius: 15px;
                font-size: 0.9rem;
            }
            
            .footer i {
                color: var(--golden-yellow);
                margin-right: 0.5rem;
            }
            
            /* Responsive Design */
            @media (max-width: 576) {
                .verify-container {
                    margin: 1rem;
                    border-radius: 20px;
                }
                
                .code-inputs {
                    gap: 0.3rem;
                }
                
                .code-inputs input {
                    width: 40px;
                    height: 40px;
                    font-size: 1.2rem;
                }
                
                h2 {
                    font-size: 1.5rem;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="container-fluid d-flex align-items-center justify-content-center min-vh-100 py-4">
            <div class="verify-container col-12 col-sm-10 col-md-8 col-lg-6 col-xl-5">
                <div class="p-4 p-md-5">
                    <div class="verify-header text-center">
                        <div class="verify-icon">
                            <i class="fas fa-envelope-open-text"></i>
                        </div>
                        <h2>Xác minh email</h2>
                    </div>
                    <div class="email-info text-center">
                        <p><i class="fas fa-paper-plane text-warning me-2"></i>Chúng tôi đã gửi mã xác minh đến<br>
                            <strong>${email}</strong><br>
                            Vui lòng nhập mã để tiếp tục.</p>
                    </div>
                    <form action="${mode eq 'forgot' ? 'ForgotPasswordController' : 'regisController'}" method="post">
                        <input type="hidden" name="action" value="verifyCode"/>
                        <input type="hidden" name="mode" value="${mode}"/>
                        <input type="hidden" name="email" value="${email}"/>
                        <input type="hidden" name="codeInput" id="codeInput"/>
                        <div class="code-inputs">
                            <input type="text" maxlength="1" required>
                            <input type="text" maxlength="1" required>
                            <input type="text" maxlength="1" required>
                            <input type="text" maxlength="1" required>
                            <input type="text" maxlength="1" required>
                            <input type="text" maxlength="1" required>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="verify-btn" disabled id="verifyBtn">
                                <i class="fas fa-shield-alt me-2"></i>Xác nhận
                            </button>
                        </div>
                    </form>
                    <c:if test="${not empty error}">
                        <div class="error-message">
                            <i class="fas fa-exclamation-triangle"></i>
                            ${error}
                        </div>
                    </c:if>
                    <div class="info-section">
                        <p><i class="fas fa-info-circle text-primary me-2"></i>Không nhận được email? Vui lòng kiểm tra thư mục spam hoặc yêu cầu mã mới sau 15 giây</p>
                        <p class="text-center">
                            <a href="LoginForm.jsp" class="back-link">
                                <i class="fas fa-arrow-left"></i>Quay lại đăng nhập
                            </a>
                        </p>
                    </div>
                    <div class="footer">
                        <i class="fas fa-palm-tree"></i>© 2025 VN Tours. All rights reserved.
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"/>
        <!-- Bootstrap 5 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
        const inputs = document.querySelectorAll('.code-inputs input');
        const verifyBtn = document.getElementById('verifyBtn');
        
        inputs.forEach((input, index) => {
            input.addEventListener('input', () => {
                // Chỉ cho phép nhập số
                input.value = input.value.replace(/[^0-9]/g, '');
                
                if (input.value.length === 1 && index < inputs.length - 1) {
                    inputs[index + 1].focus();
                }
                checkAllFilled();
            });
            
            // Xử lý phím Backspace
            input.addEventListener('keydown', (e) => {
                if (e.key === 'Backspace' && input.value === '' && index > 0) {
                    inputs[index - 1].focus();
                }
            });
            
            // Xử lý paste
            input.addEventListener('paste', (e) => {
                e.preventDefault();
                const pastedData = e.clipboardData.getData('text').replace(/[^0-9]/g, '');
                
                for (let i = 0; i < pastedData.length && index + i < inputs.length; i++) {
                    inputs[index + i].value = pastedData[i];
                }
                
                checkAllFilled();
                
                // Focus vào ô cuối cùng được điền
                const lastFilledIndex = Math.min(index + pastedData.length - 1, inputs.length - 1);
                inputs[lastFilledIndex].focus();
            });
        });
        
        function checkAllFilled() {
            const filled = [...inputs].every(input => input.value.length === 1);
            if (filled) {
                verifyBtn.disabled = false;
                
                // Gán giá trị ngay khi đã nhập đủ
                const code = [...inputs].map(input => input.value).join('');
                document.getElementById("codeInput").value = code;
                console.log("Code updated:", code); // Debug
            } else {
                verifyBtn.disabled = true;
                document.getElementById("codeInput").value = ''; // Clear khi chưa đủ
            }
        }
        
        document.querySelector("form").addEventListener("submit", function (e) {
            // Kiểm tra lại giá trị trước khi submit
            const code = document.getElementById("codeInput").value;
            console.log("Final code being sent:", code);
        });
        
        // Auto focus vào ô đầu tiên khi tải trang
        window.addEventListener('load', () => {
            inputs[0].focus();
        });
    </script>
</body>
</html>