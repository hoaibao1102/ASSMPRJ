<%-- 
    Document   : about
    Created on : May 28, 2025, 10:14:19 PM
    Author     : MSI PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Giới thiệu - VN Tours</title>
        <link rel="stylesheet" href="assets/css/bodyCss.css">
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
        
        <style>
            :root {
                --primary-orange: #ff6b35;
                --primary-dark: #2c3e50;
                --primary-yellow: #f39c12;
                --bg-light: #f8f9fa;
                --gradient-sunset: linear-gradient(135deg, #ff6b35 0%, #f39c12 100%);
                --gradient-tropical: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
                --shadow-soft: 0 8px 25px rgba(0,0,0,0.1);
                --shadow-hover: 0 15px 35px rgba(0,0,0,0.15);
            }
            
            body {
                font-family: 'Nunito', sans-serif;
                background-color: var(--bg-light);
                color: var(--primary-dark);
                line-height: 1.6;
            }
            
            .section-padding {
                padding: 5rem 0;
            }
            
            .section-title {
                font-size: 2.8rem;
                font-weight: 800;
                text-align: center;
                margin-bottom: 3.5rem;
                background: var(--gradient-sunset);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                position: relative;
            }
            
            .section-title::after {
                content: '';
                position: absolute;
                bottom: -15px;
                left: 50%;
                transform: translateX(-50%);
                width: 80px;
                height: 4px;
                background: var(--gradient-sunset);
                border-radius: 2px;
            }
            
            .tropical-card {
                background: white;
                border-radius: 20px;
                box-shadow: var(--shadow-soft);
                transition: all 0.3s ease;
                overflow: hidden;
                border: 1px solid rgba(255, 107, 53, 0.1);
            }
            
            .tropical-card:hover {
                transform: translateY(-10px);
                box-shadow: var(--shadow-hover);
            }
            
            .tropical-card .card-body {
                padding: 2rem;
            }
            
            .feature-icon {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                background: var(--gradient-sunset);
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 2.5rem;
                color: white;
                margin: 0 auto 1.5rem;
                box-shadow: var(--shadow-soft);
            }
            
            .stats-badge {
                background: var(--gradient-sunset);
                color: white;
                padding: 0.5rem 1rem;
                border-radius: 25px;
                font-weight: 600;
                font-size: 0.9rem;
                display: inline-block;
                margin: 0.25rem;
                box-shadow: var(--shadow-soft);
            }
            
            .btn-tropical {
                background: var(--gradient-sunset);
                border: none;
                padding: 1rem 2.5rem;
                font-weight: 700;
                border-radius: 50px;
                color: white;
                text-decoration: none;
                transition: all 0.3s ease;
                box-shadow: var(--shadow-soft);
                font-size: 1.1rem;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            
            .btn-tropical:hover {
                transform: translateY(-3px);
                box-shadow: var(--shadow-hover);
                color: white;
            }
            
            .testimonial-card {
                background: white;
                border-radius: 20px;
                padding: 2rem;
                box-shadow: var(--shadow-soft);
                border-left: 5px solid var(--primary-orange);
                transition: all 0.3s ease;
                height: 100%;
            }
            
            .testimonial-card:hover {
                transform: translateY(-5px);
                box-shadow: var(--shadow-hover);
            }
            
            .testimonial-quote {
                font-style: italic;
                font-size: 1.1rem;
                color: #555;
                margin-bottom: 1.5rem;
                line-height: 1.7;
            }
            
            .testimonial-author {
                color: var(--primary-orange);
                font-weight: 600;
                font-size: 1rem;
            }
            
            .tropical-bg {
                background: linear-gradient(135deg, rgba(255, 107, 53, 0.05) 0%, rgba(243, 156, 18, 0.05) 100%);
            }
            
            .section-intro {
                font-size: 1.2rem;
                color: #6c757d;
                text-align: center;
                max-width: 800px;
                margin: 0 auto 4rem;
                line-height: 1.8;
            }
            
            .feature-list {
                list-style: none;
                padding: 0;
            }
            
            .feature-list li {
                padding: 0.75rem 0;
                font-size: 1.1rem;
                color: var(--primary-dark);
                position: relative;
                padding-left: 2rem;
            }
            
            .feature-list li::before {
                content: '✨';
                position: absolute;
                left: 0;
                color: var(--primary-orange);
                font-size: 1.2rem;
            }
            
            .rounded-image {
                border-radius: 20px;
                box-shadow: var(--shadow-soft);
                transition: all 0.3s ease;
            }
            
            .rounded-image:hover {
                transform: scale(1.02);
                box-shadow: var(--shadow-hover);
            }
            
            .cta-section {
                background: var(--gradient-tropical);
                color: white;
                padding: 4rem 0;
                text-align: center;
            }
            
            .cta-section h2 {
                color: white;
                margin-bottom: 2rem;
            }
            
            .value-card {
                text-align: center;
                padding: 2rem;
                height: 100%;
            }
            
            .value-card h3 {
                color: var(--primary-orange);
                font-weight: 700;
                margin-bottom: 1rem;
                font-size: 1.4rem;
            }
            
            .value-card p {
                color: #666;
                font-size: 1.1rem;
                line-height: 1.7;
            }
            
            @media (max-width: 768px) {
                .section-title {
                    font-size: 2.2rem;
                }
                
                .section-padding {
                    padding: 3rem 0;
                }
                
                .feature-icon {
                    width: 60px;
                    height: 60px;
                    font-size: 2rem;
                }
            }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>

        <!-- VỀ VN TOURS -->
        <section class="section-padding">
            <div class="container">
                <h2 class="section-title">Về VN Tours</h2>
                <p class="section-intro">
                    Khám phá vẻ đẹp Việt Nam cùng đối tác tin cậy của bạn
                </p>
                
                <div class="row align-items-center g-5">
                    <div class="col-lg-6">
                        <img src="assets/images/3ae.png" alt="Giới thiệu" class="img-fluid rounded-image">
                    </div>
                    <div class="col-lg-6">
                        <div class="tropical-card">
                            <div class="card-body">
                                <h3 class="h2 mb-4" style="color: var(--primary-orange); font-weight: 700;">
                                    🌴 Khơi dậy cảm hứng du lịch Việt
                                </h3>
                                <p class="mb-4" style="font-size: 1.1rem; line-height: 1.7;">
                                    VN Tours là nền tảng du lịch kết nối hàng ngàn du khách đến những địa điểm tuyệt vời nhất tại Việt Nam. Chúng tôi mong muốn mọi chuyến đi không chỉ là hành trình, mà là trải nghiệm ghi dấu cảm xúc.
                                </p>
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <span class="stats-badge">🎯 Hơn 1000 tour/năm</span>
                                    </div>
                                    <div class="col-md-6">
                                        <span class="stats-badge">🤝 100+ đối tác</span>
                                    </div>
                                    <div class="col-12">
                                        <span class="stats-badge">🌟 Hỗ trợ 24/7</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- SỨ MỆNH – TẦM NHÌN – GIÁ TRỊ -->
        <section class="section-padding tropical-bg">
            <div class="container">
                <h2 class="section-title">Sứ mệnh – Tầm nhìn – Giá trị</h2>
                <div class="row g-4">
                    <div class="col-lg-4 col-md-6">
                        <div class="tropical-card value-card">
                            <div class="feature-icon">
                                🎯
                            </div>
                            <h3>Sứ mệnh</h3>
                            <p>Giúp du khách khám phá Việt Nam an toàn, dễ dàng và trọn vẹn với những trải nghiệm không thể quên.</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="tropical-card value-card">
                            <div class="feature-icon">
                                🌍
                            </div>
                            <h3>Tầm nhìn</h3>
                            <p>Trở thành nền tảng du lịch hàng đầu Việt Nam và Đông Nam Á, kết nối thế giới với vẻ đẹp Việt.</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-12">
                        <div class="tropical-card value-card">
                            <div class="feature-icon">
                                💎
                            </div>
                            <h3>Giá trị</h3>
                            <p>Chất lượng – Minh bạch – Tận tâm – Bản sắc Việt là kim chỉ nam trong mọi hoạt động của chúng tôi.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- VÌ SAO CHỌN CHÚNG TÔI -->
        <section class="section-padding">
            <div class="container">
                <h2 class="section-title">Vì sao chọn VN Tours?</h2>
                <div class="row align-items-center g-5">
                    <div class="col-lg-6 order-lg-1 order-2">
                        <div class="tropical-card">
                            <div class="card-body">
                                <h3 class="h3 mb-4" style="color: var(--primary-orange); font-weight: 700;">
                                    🏆 Trải nghiệm đẳng cấp
                                </h3>
                                <p class="mb-4" style="font-size: 1.1rem;">
                                    Chúng tôi hiểu rằng du lịch không chỉ là điểm đến, mà là trải nghiệm. Đó là lý do bạn nên chọn chúng tôi:
                                </p>
                                <ul class="feature-list">
                                    <li>Giao diện dễ dùng, thân thiện với mọi lứa tuổi</li>
                                    <li>Nhiều ưu đãi hấp dẫn quanh năm</li>
                                    <li>Thông tin tour rõ ràng, minh bạch 100%</li>
                                    <li>Hướng dẫn viên được đào tạo chuyên nghiệp</li>
                                    <li>Dịch vụ chăm sóc khách hàng tận tình</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 order-lg-2 order-1">
                        <img src="assets/images/visaochontour.png" alt="Vì sao chọn VN Tours" class="img-fluid rounded-image">
                    </div>
                </div>
            </div>
        </section>

        <!-- ĐÁNH GIÁ KHÁCH HÀNG -->
        <section class="section-padding tropical-bg">
            <div class="container">
                <h2 class="section-title">Khách hàng nói gì về chúng tôi?</h2>
                <div class="row g-4">
                    <div class="col-lg-4 col-md-6">
                        <div class="testimonial-card">
                            <div class="testimonial-quote">
                                "Tour Đà Nẵng rất tuyệt vời! Hướng dẫn viên vui vẻ, nhiệt tình và tổ chức cực kỳ chuyên nghiệp. Sẽ quay lại với VN Tours!"
                            </div>
                            <div class="d-flex align-items-center">
                                <div class="bg-warning rounded-circle me-3" style="width: 50px; height: 50px; display: flex; align-items: center; justify-content: center;">
                                    <i class="bi bi-person-fill text-white"></i>
                                </div>
                                <div>
                                    <div class="testimonial-author">Minh Tú</div>
                                    <small class="text-muted">Hà Nội</small>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="testimonial-card">
                            <div class="testimonial-quote">
                                "Trang web thiết kế đẹp, dễ sử dụng. Đặt tour nhanh chóng và đội ngũ hỗ trợ rất tận tình. Trải nghiệm tuyệt vời!"
                            </div>
                            <div class="d-flex align-items-center">
                                <div class="bg-info rounded-circle me-3" style="width: 50px; height: 50px; display: flex; align-items: center; justify-content: center;">
                                    <i class="bi bi-person-fill text-white"></i>
                                </div>
                                <div>
                                    <div class="testimonial-author">Phương Anh</div>
                                    <small class="text-muted">TP.HCM</small>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-12">
                        <div class="testimonial-card">
                            <div class="testimonial-quote">
                                "Đã đi 3 tour qua VN Tours rồi và lần nào cũng hài lòng. Dịch vụ chất lượng, giá cả hợp lý. Highly recommended!"
                            </div>
                            <div class="d-flex align-items-center">
                                <div class="bg-success rounded-circle me-3" style="width: 50px; height: 50px; display: flex; align-items: center; justify-content: center;">
                                    <i class="bi bi-person-fill text-white"></i>
                                </div>
                                <div>
                                    <div class="testimonial-author">Đức Huy</div>
                                    <small class="text-muted">Đà Nẵng</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- CTA -->
        <section class="cta-section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-8 text-center">
                        <h2 class="mb-4">Sẵn sàng khám phá Việt Nam?</h2>
                        <p class="mb-4" style="font-size: 1.2rem; opacity: 0.9;">
                            Hãy bắt đầu hành trình khám phá những điều kỳ diệu của đất nước chúng ta ngay hôm nay!
                        </p>
                        <a href="placeController?action=destination&page=indexjsp" class="btn-tropical">
                            <i class="bi bi-house-door me-2"></i>
                            Quay về Trang chủ
                        </a>
                    </div>
                </div>
            </div>
        </section>

        <%@ include file="footer.jsp" %>
        
        <!-- Bootstrap 5 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>