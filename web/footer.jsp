<%-- 
    Document   : footer
    Created on : May 12, 2025, 3:41:19 PM
    Author     : MSI PC
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>VN Tours</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
            .footer {
                background: var(--bg-dark);
                color: var(--pearl-white);
                padding: 50px 0 20px;
                margin-top: 3rem;
                position: relative;
            }
            .footer::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: var(--gradient-primary);
            }
            .footer-column h4 {
                font-size: 1.4rem;
                margin-bottom: 1.5rem;
                color: var(--sky-blue);
                font-weight: 600;
                position: relative;
                padding-bottom: 10px;
            }
            .footer-column h4::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                width: 50px;
                height: 3px;
                background: var(--gradient-primary);
                border-radius: 2px;
            }
            .footer-column p {
                font-size: 0.95rem;
                color: var(--text-light);
                line-height: 1.7;
                margin-bottom: 1rem;
            }
            .footer-column a {
                font-size: 0.95rem;
                color: var(--text-light);
                line-height: 1.7;
                text-decoration: none;
                transition: color 0.2s ease;
                display: inline-block;
            }
            .footer-column a:hover {
                color: var(--sky-blue);
            }
            .contact-item {
                display: flex;
                align-items: center;
                gap: 12px;
                margin-bottom: 12px;
                padding: 8px 0;
            }
            .contact-item i {
                background: var(--gradient-primary);
                color: var(--pearl-white);
                width: 35px;
                height: 35px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 0.9rem;
                flex-shrink: 0;
            }
            .social-links {
                display: flex;
                gap: 15px;
                margin-top: 25px;
            }
            .social-links a {
                background: var(--gradient-secondary);
                color: var(--pearl-white);
                width: 45px;
                height: 45px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.2rem;
                transition: opacity 0.2s ease;
                text-decoration: none;
            }
            .social-links a:hover {
                opacity: 0.8;
            }
            .footer-bottom {
                text-align: center;
                padding-top: 30px;
                margin-top: 40px;
                border-top: 1px solid #374151;
                color: var(--text-light);
                font-size: 0.9rem;
            }
            .footer-bottom p {
                margin: 0;
            }
            .footer-brand {
                font-size: 1.8rem;
                font-weight: 700;
                color: var(--sky-blue);
                margin-bottom: 15px;
                display: flex;
                align-items: center;
                gap: 10px;
            }
            .footer-brand i {
                font-size: 2rem;
                color: var(--emerald-green);
            }
            .footer-description {
                color: var(--text-light);
                font-size: 0.9rem;
                line-height: 1.6;
                margin-bottom: 20px;
            }
            .quick-links {
                list-style: none;
                padding: 0;
                margin: 0;
            }
            .quick-links li {
                margin-bottom: 10px;
            }
            .quick-links a {
                color: var(--text-light);
                text-decoration: none;
                transition: color 0.2s ease;
                display: flex;
                align-items: center;
                gap: 8px;
            }
            .quick-links a:hover {
                color: var(--sky-blue);
            }
            .quick-links a::before {
                content: '→';
                color: var(--emerald-green);
                font-weight: bold;
                flex-shrink: 0;
            }
            /* Responsive adjustments */
            @media (max-width: 768px) {
                .footer {
                    padding: 30px 0 20px;
                }
                
                .footer-brand {
                    justify-content: center;
                    text-align: center;
                }
                .footer-column h4 {
                    text-align: center;
                }
                .footer-column h4::after {
                    left: 50%;
                    transform: translateX(-50%);
                }
                .social-links {
                    justify-content: center;
                }
                
                .contact-item {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 8px;
                }
                
                .contact-item i {
                    align-self: flex-start;
                }
            }
        </style>
    </head>
    <body>
        <c:set var="isAdmin" value="${sessionScope.isAdmin}" />
        <c:if test="${!isAdmin}">
            <footer class="footer">
                <div class="container">
                    <div class="row g-4">
                        <!-- Cột thương hiệu và thông tin -->
                        <div class="col-lg-3 col-md-6 footer-column">
                            <div class="footer-brand">
                                <i class="fas fa-plane"></i> VN Tours
                            </div>
                            <p class="footer-description">
                                Khám phá vẻ đẹp Việt Nam cùng chúng tôi. Chúng tôi cam kết mang đến những trải nghiệm du lịch tuyệt vời và đáng nhớ nhất cho quý khách.
                            </p>
                            <div class="social-links">
                                <a href="#" target="_blank" title="Facebook" aria-label="Facebook">
                                    <i class="fab fa-facebook-f"></i>
                                </a>
                                <a href="#" target="_blank" title="Instagram" aria-label="Instagram">
                                    <i class="fab fa-instagram"></i>
                                </a>
                                <a href="#" target="_blank" title="YouTube" aria-label="YouTube">
                                    <i class="fab fa-youtube"></i>
                                </a>
                                <a href="#" target="_blank" title="Twitter" aria-label="Twitter">
                                    <i class="fab fa-twitter"></i>
                                </a>
                            </div>
                        </div>
                        <!-- Cột liên kết nhanh -->
                        <div class="col-lg-3 col-md-6 footer-column">
                            <h4>Liên kết nhanh</h4>
                            <ul class="quick-links">
                                <li><a href="MainController?action=destination&page=indexjsp">Trang chủ</a></li>
                                <li><a href="placeController?action=destination&page=destinationjsp" >Tour du lịch</a></li>
                                <li><a href="about.jsp">Về chúng tôi</a></li>
                                <li><a href="contact.jsp">Liên hệ</a></li>
                                <li><a href="placeController?action=destination&page=destinationjsp" >Đặt tour</a></li>
                                <li><a href="#">Tin tức</a></li>
                            </ul>
                        </div>
                        <!-- Cột dịch vụ -->
                        <div class="col-lg-3 col-md-6 footer-column">
                            <h4>Dịch vụ</h4>
                            <ul class="quick-links">
                                <li><a href="#">Tour trong nước</a></li>
                                <li><a href="#">Tour nước ngoài</a></li>
                                <li><a href="#">Đặt khách sạn</a></li>
                                <li><a href="#">Thuê xe</a></li>
                                <li><a href="#">Visa & Hộ chiếu</a></li>
                                <li><a href="#">Bảo hiểm du lịch</a></li>
                            </ul>
                        </div>
                        <!-- Cột liên hệ -->
                        <div class="col-lg-3 col-md-6 footer-column">
                            <h4>Liên hệ</h4>
                            <div class="contact-item">
                                <i class="fas fa-map-marker-alt"></i>
                                <span>Lô E2a-7, Đường D1, Khu CNC, P. Long Thạnh Mỹ, TP. Thủ Đức, TP. HCM</span>
                            </div>
                            <div class="contact-item">
                                <i class="fas fa-phone"></i>
                                <span>0123 456 789</span>
                            </div>
                            <div class="contact-item">
                                <i class="fas fa-envelope"></i>
                                <span>support@vntours.com</span>
                            </div>
                            <div class="contact-item">
                                <i class="fas fa-clock"></i>
                                <span>24/7 - Hỗ trợ khách hàng</span>
                            </div>
                        </div>
                    </div>
                    <div class="footer-bottom">
                        <div class="row">
                            <div class="col-12">
                                <p>&copy; 2025 VN Tours. Tất cả quyền được bảo lưu. | Thiết kế bởi VN Tours Team</p>
                            </div>
                        </div>
                    </div>
                </div>
            </footer>
        </c:if>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>