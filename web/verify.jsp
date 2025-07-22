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
        <link href="assets/css/verify.css" rel="stylesheet">
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