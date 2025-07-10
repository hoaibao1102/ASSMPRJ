<%-- 
    Document   : contact
    Created on : May 28, 2025, 10:32:05 PM
    Author     : MSI PC
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Liên hệ - VN Tours</title> 
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
                padding-top: 100px;
                background: linear-gradient(135deg, #f8f9fa 0%, #e8f4f8 100%);
                color: var(--text-color);
                line-height: 1.6;
            }
            
            .hero-section {
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                color: white;
                padding: 60px 0 40px;
            }
            
            .hero-title {
                font-size: 2.5rem;
                font-weight: 700;
                margin-bottom: 1rem;
            }
            
            .hero-subtitle {
                font-size: 1.1rem;
                opacity: 0.9;
                margin-bottom: 1.5rem;
            }
            
            .contact-section {
                padding: 60px 0;
            }
            
            .contact-card {
                background: var(--white);
                border-radius: var(--border-radius);
                padding: 2rem;
                border: 1px solid #e9ecef;
            }
            
            .contact-info h3 {
                color: var(--text-color);
                font-weight: 600;
                margin-bottom: 1.5rem;
                font-size: 1.6rem;
            }
            
            .info-item {
                display: flex;
                align-items: flex-start;
                margin-bottom: 1.5rem;
                padding: 1rem;
                background: #f8f9fa;
                border-radius: var(--border-radius);
                border-left: 4px solid var(--accent-color);
            }
            
            .info-icon {
                font-size: 1.5rem;
                color: var(--accent-color);
                margin-right: 1rem;
                min-width: 40px;
                text-align: center;
            }
            
            .info-content strong {
                color: var(--text-color);
                font-weight: 600;
            }
            
            .form-card {
                background: var(--white);
                border-radius: var(--border-radius);
                padding: 2rem;
                border: 1px solid #e9ecef;
            }
            
            .form-card h3 {
                color: var(--text-color);
                font-weight: 600;
                margin-bottom: 1.5rem;
                font-size: 1.6rem;
            }
            
            .form-group {
                margin-bottom: 1.5rem;
            }
            
            .form-label {
                font-weight: 500;
                color: var(--text-color);
                margin-bottom: 0.5rem;
            }
            
            .form-control {
                border: 1px solid #e9ecef;
                border-radius: var(--border-radius);
                padding: 0.75rem 1rem;
                font-size: 1rem;
            }
            
            .form-control:focus {
                border-color: var(--accent-color);
                box-shadow: none;
            }
            
            .form-select {
                border: 1px solid #e9ecef;
                border-radius: var(--border-radius);
                padding: 0.75rem 1rem;
                font-size: 1rem;
            }
            
            .form-select:focus {
                border-color: var(--accent-color);
                box-shadow: none;
            }
            
            .btn-primary {
                background: linear-gradient(135deg, var(--accent-color), var(--secondary-accent));
                border: none;
                border-radius: var(--border-radius);
                padding: 0.75rem 2rem;
                font-weight: 600;
                font-size: 1.1rem;
            }
            
            .map-section {
                background: var(--white);
                padding: 40px 0;
                margin-top: 40px;
            }
            
            .map-container {
                border-radius: var(--border-radius);
                overflow: hidden;
                height: 400px;
            }
            
            .map-container iframe {
                width: 100%;
                height: 100%;
                border: none;
            }
            
            .section-title {
                text-align: center;
                font-size: 2.2rem;
                font-weight: 700;
                color: var(--text-color);
                margin-bottom: 2rem;
            }
            
            @media (max-width: 768px) {
                .hero-title {
                    font-size: 1.8rem;
                }
                
                .hero-subtitle {
                    font-size: 1rem;
                }
                
                .contact-card,
                .form-card {
                    padding: 1.5rem;
                }
            }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>
        
        <div class="content">
            <!-- Hero Section -->
            <section class="hero-section">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-lg-8 text-center">
                            <h1 class="hero-title">Chúng tôi luôn sẵn sàng đồng hành cùng bạn</h1>
                            <p class="hero-subtitle">
                                Bạn có câu hỏi về tour? Muốn được tư vấn hành trình phù hợp? Hoặc cần hỗ trợ nhanh?<br>
                                Đừng ngần ngại – chúng tôi ở đây để giúp bạn có chuyến đi trọn vẹn nhất!
                            </p>
                        </div>
                    </div>
                </div>
            </section>
            <!-- Contact Section -->
            <section class="contact-section">
                <div class="container">
                    <div class="row g-4">
                        <!-- Contact Information -->
                        <div class="col-lg-6">
                            <div class="contact-card">
                                <div class="contact-info">
                                    <h3><i class="fas fa-headset me-2"></i>Liên hệ trực tiếp</h3>
                                    <div class="info-item">
                                        <div class="info-icon">
                                            <i class="fas fa-phone-alt"></i>
                                        </div>
                                        <div class="info-content">
                                            <p><strong>Hotline đặt tour:</strong> 028 1234 5678 (24/7)</p>
                                            <p><strong>Zalo / Messenger:</strong> @vntours</p>
                                        </div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-icon">
                                            <i class="fas fa-map-marker-alt"></i>
                                        </div>
                                        <div class="info-content">
                                            <p><strong>Trụ sở:</strong> Lô E2a-7, Đường D1, Khu CNC, Thủ Đức, HCM</p>
                                            <p><strong>Giờ làm việc:</strong> Thứ 2 – Thứ 6: 8h – 17h30 | Thứ 7: 8h – 12h</p>
                                        </div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-icon">
                                            <i class="fas fa-envelope"></i>
                                        </div>
                                        <div class="info-content">
                                            <p><strong>Email:</strong> support@vntours.com</p>
                                            <p><strong>Hợp tác kinh doanh:</strong> partner@vntours.com</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Contact Form -->
                        <div class="col-lg-6">
                            <div class="form-card">
                                <h3><i class="fas fa-paper-plane me-2"></i>Gửi yêu cầu hỗ trợ</h3>
                                <form action="#" method="post">
                                    <div class="form-group">
                                        <label for="name" class="form-label">Họ tên của bạn</label>
                                        <input type="text" class="form-control" id="name" name="name" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="type" class="form-label">Loại hỗ trợ</label>
                                        <select class="form-select" id="type" name="type" required>
                                            <option value="">-- Chọn mục cần hỗ trợ --</option>
                                            <option value="tour">Tư vấn chọn tour</option>
                                            <option value="booking">Vấn đề đặt tour</option>
                                            <option value="tech">Kỹ thuật / Giao diện</option>
                                            <option value="partner">Hợp tác kinh doanh</option>
                                            <option value="review">Đánh Giá Khách Hàng</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="email" class="form-label">Email liên hệ</label>
                                        <input type="email" class="form-control" id="email" name="email" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="message" class="form-label">Nội dung</label>
                                        <textarea class="form-control" id="message" name="message" rows="4" required></textarea>
                                    </div>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-paper-plane me-2"></i>Gửi yêu cầu
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- Map Section -->
            <section class="map-section">
                <div class="container">
                    <h2 class="section-title">Vị trí của chúng tôi</h2>
                    <div class="map-container">
                        <iframe
                            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3918.312079786337!2d106.80934507480582!3d10.865684257597673!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x317527ee4f1bcf59%3A0x6e9bdfcc5cd72de!2zVHLGsOG7nW5nIMSQ4bqhaSBI4buNYyBGUFQgSOG7kyBDaMOtIE5naOG7hyBIQ00!5e0!3m2!1svi!2s!4v1716886527822!5m2!1svi!2s"
                            allowfullscreen="" loading="lazy"
                            referrerpolicy="no-referrer-when-downgrade">
                        </iframe>
                    </div>
                </div>
            </section>
        </div>
        
        <%@ include file="footer.jsp" %>
        
        <!-- Bootstrap 5 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>