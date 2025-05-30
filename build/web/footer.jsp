<%-- 
    Document   : footer
    Created on : May 12, 2025, 3:41:19 PM
    Author     : MSI PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Trang Web Mẫu</title>
    <link rel="stylesheet" href="style.css">
    <style>
        .footer {
            background-color: #2c3e50;
            color: #fff;
            padding: 2rem 1rem;
            margin-top: 3rem;
        }

        .footer-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 2rem;
        }

        .footer-column {
            flex: 1;
            min-width: 250px;
            margin-left: 13%;
        }

        .footer-column h4 {
            font-size: 1.2rem;
            margin-bottom: 1rem;
            color: #f1c40f;
        }

        .footer-column p,
        .footer-column a {
            font-size: 0.95rem;
            color: #ccc;
            line-height: 1.6;
            text-decoration: none;
        }

        .footer-column a:hover {
            color: #fff;
        }

        .social-links a {
            margin-right: 1rem;
            font-size: 1.2rem;
            color: #ccc;
            transition: color 0.3s;
        }

        .social-links a:hover {
            color: #f1c40f;
        }

        .footer-bottom {
            text-align: center;
            padding-top: 1rem;
            color: #aaa;
            font-size: 0.85rem;
        }
    </style>
    
</head>

<body>
    <footer class="footer">
        <div class="footer-container">
            <!-- Cột liên hệ -->
            <div class="footer-column">
                <h4>Liên hệ</h4>
                <p>Địa chỉ: Lô E2a-7, Đường D1, Khu CNC, P. Long Thạnh Mỹ, TP. Thủ Đức, TP. HCM</p>
                <p>Email: support@vntours.com</p>
                <p>Hotline: 0123 456 789</p>
            </div>

            <!-- Cột mạng xã hội -->
            <div class="footer-column">
                <h4>Kết nối với chúng tôi</h4>
                <div class="social-links">
                    <a href="#" target="_blank">Facebook</a>
                    <a href="#" target="_blank">Instagram</a>
                    <a href="#" target="_blank">YouTube</a>
                </div>
            </div>
        </div>

        <div class="footer-bottom">
            © 2025 VN Tours. All rights reserved.
        </div>
    </footer>
</body>

</html>