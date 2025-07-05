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
    <title>Xác minh email</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .verify-container {
            background-color: #fff;
            padding: 2.5rem;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        h2 {
            margin-bottom: 0.8rem;
            color: #2c3e50;
        }

        p {
            font-size: 0.95rem;
            color: #555;
            margin-bottom: 1.5rem;
        }

        .code-inputs {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1.5rem;
        }

        .code-inputs input {
            width: 45px;
            height: 45px;
            text-align: center;
            font-size: 1.2rem;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .verify-btn {
            width: 100%;
            padding: 0.7rem;
            font-size: 1rem;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            background-color: #ccc;
            color: #fff;
            cursor: not-allowed;
            transition: background-color 0.3s;
        }

        .verify-btn.active {
            background-color: #6c5ce7;
            cursor: pointer;
        }

        .links {
            margin-top: 1rem;
            font-size: 0.9rem;
        }

        .links a {
            color: #6c5ce7;
            text-decoration: none;
        }

        .links a:hover {
            text-decoration: underline;
        }

        .footer {
            margin-top: 2rem;
            font-size: 0.8rem;
            color: #999;
        }
    </style>
</head>
<body>
    <div class="verify-container">
        <h2>Verify your email address</h2>
        <p>We’ve sent a verification code to <strong>${email}</strong>.<br>
            Please enter this code to continue.</p>
        <form 
            action="${mode eq 'forgot' ? 'ForgotPasswordController' : 'regisController'}"
            method="post">
            <input type="hidden" name="action" value="verifyCode"/>
            <input type="hidden" name="mode" value="${mode}"/>
            <input type="hidden" name="email" value="${email}"/>
            <input type="hidden" name="codeInput" id="codeInput"/>
            <div class="code-inputs">
                <input type="text" maxlength="1" name="code1" required>
                <input type="text" maxlength="1" name="code2" required>
                <input type="text" maxlength="1" name="code3" required>
                <input type="text" maxlength="1" name="code4" required>
                <input type="text" maxlength="1" name="code5" required>
                <input type="text" maxlength="1" name="code6" required>
            </div>
            <input type="submit" class="verify-btn" value="Xác nhận" disabled id="verifyBtn">
        </form>
        <c:if test="${not empty error}">
            <div style="color: red">${error}</div>
        </c:if>
        <div class="links">
                <p>Didn’t receive an email? Please check your spam folder or request another code in 15 seconds</p>
                <p><a href="loginForm.jsp">Back to sign in</a></p>
            </div>

            <div class="footer">
                © 2025 VN Tours. All rights reserved.
            </div>
    </div>
    <script>
        const inputs = document.querySelectorAll('.code-inputs input');
        const verifyBtn = document.getElementById('verifyBtn');

        inputs.forEach((input, index) => {
            input.addEventListener('input', () => {
                if (input.value.length === 1 && index < inputs.length - 1) {
                    inputs[index + 1].focus();
                }
                checkAllFilled();
            });
        });

        function checkAllFilled() {
            const filled = [...inputs].every(input => input.value.length === 1);
            if (filled) {
                verifyBtn.disabled = false;
                verifyBtn.classList.add('active');
            } else {
                verifyBtn.disabled = true;
                verifyBtn.classList.remove('active');
            }
        }

        document.querySelector("form").addEventListener("submit", function (e) {
            const code = [...inputs].map(input => input.value).join('');
            document.getElementById("codeInput").value = code;
        });
    </script>
</body>
</html>