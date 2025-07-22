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
        <link href="assets/css/footer.css" rel="stylesheet">
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