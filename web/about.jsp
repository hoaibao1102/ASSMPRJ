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
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Giới thiệu - VN Tours</title>
        <link rel="stylesheet" href="assets/css/bodyCss.css">
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
        
        <style>
            /* Bảng màu Vietnam Travel */
            :root {
                --primary-blue: #0EA5E9;
                --primary-orange: #FF6B35;
                --primary-green: #10B981;
                --accent-yellow: #F59E0B;
                --accent-purple: #8B5CF6;
                --pearl-white: #FEFEFE;
                --text-dark: #1F2937;
                --text-medium: #6B7280;
                --bg-light: #F8FAFC;
                --gradient-primary: linear-gradient(135deg, #0EA5E9, #10B981);
                --gradient-secondary: linear-gradient(135deg, #FF6B35, #F59E0B);
            }
            
            body {
                padding-top: 100px;
                font-family: 'Nunito', sans-serif;
                background-color: var(--bg-light);
                color: var(--text-dark);
                line-height: 1.6;
            }
            
            .section-padding {
                padding: 4rem 0;
            }
            
            .section-title {
                font-size: 2.5rem;
                font-weight: 700;
                text-align: center;
                margin-bottom: 3rem;
                background: var(--gradient-primary);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                position: relative;
            }
            
            .section-title::after {
                content: '';
                position: absolute;
                bottom: -10px;
                left: 50%;
                transform: translateX(-50%);
                width: 60px;
                height: 3px;
                background: var(--primary-orange);
                border-radius: 2px;
            }
            
            .card-simple {
                background: var(--pearl-white);
                border-radius: 12px;
                border: 1px solid #E5E7EB;
                overflow: hidden;
                height: 100%;
            }
            
            .card-simple .card-body {
                padding: 2rem;
            }
            
            .feature-icon {
                width: 60px;
                height: 60px;
                border-radius: 50%;
                background: var(--gradient-primary);
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.8rem;
                color: white;
                margin: 0 auto 1rem;
            }
            
            .stats-badge {
                background: var(--primary-blue);
                color: white;
                padding: 0.4rem 1rem;
                border-radius: 20px;
                font-weight: 600;
                font-size: 0.9rem;
                display: inline-block;
                margin: 0.2rem;
            }
            
            .btn-primary-custom {
                background: var(--gradient-secondary);
                border: none;
                padding: 1rem 2rem;
                font-weight: 600;
                border-radius: 8px;
                color: white;
                text-decoration: none;
                display: inline-block;
                font-size: 1rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }
            
            .btn-primary-custom:hover {
                opacity: 0.9;
                color: white;
            }
            
            .testimonial-card {
                background: var(--pearl-white);
                border-radius: 12px;
                padding: 1.5rem;
                border: 1px solid #E5E7EB;
                border-left: 4px solid var(--primary-orange);
                height: 100%;
            }
            
            .testimonial-quote {
                font-style: italic;
                font-size: 1rem;
                color: var(--text-medium);
                margin-bottom: 1rem;
                line-height: 1.6;
            }
            
            .testimonial-author {
                color: var(--primary-orange);
                font-weight: 600;
                font-size: 0.95rem;
            }
            
            .bg-accent {
                background: linear-gradient(135deg, rgba(14, 165, 233, 0.05), rgba(16, 185, 129, 0.05));
            }
            
            .section-intro {
                font-size: 1.1rem;
                color: var(--text-medium);
                text-align: center;
                max-width: 700px;
                margin: 0 auto 3rem;
                line-height: 1.7;
            }
            
            .feature-list {
                list-style: none;
                padding: 0;
                margin: 0;
            }
            
            .feature-list li {
                padding: 0.6rem 0;
                font-size: 1rem;
                color: var(--text-dark);
                position: relative;
                padding-left: 1.8rem;
            }
            
            .feature-list li::before {
                content: '✓';
                position: absolute;
                left: 0;
                color: var(--primary-green);
                font-weight: bold;
                font-size: 1.1rem;
            }
            
            .rounded-image {
                border-radius: 12px;
                border: 1px solid #E5E7EB;
            }
            
            .cta-section {
                background: var(--gradient-primary);
                color: white;
                padding: 3rem 0;
                text-align: center;
            }
            
            .cta-section h2 {
                color: white;
                margin-bottom: 1.5rem;
                font-weight: 700;
            }
            
            .value-card {
                text-align: center;
                padding: 1.5rem;
                height: 100%;
            }
            
            .value-card h3 {
                color: var(--primary-orange);
                font-weight: 600;
                margin-bottom: 1rem;
                font-size: 1.3rem;
            }
            
            .value-card p {
                color: var(--text-medium);
                font-size: 1rem;
                line-height: 1.6;
                margin-bottom: 0;
            }
            
            .avatar-placeholder {
                width: 45px;
                height: 45px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 1.2rem;
            }
            
            .bg-yellow { background-color: var(--accent-yellow); }
            .bg-blue { background-color: var(--primary-blue); }
            .bg-green { background-color: var(--primary-green); }
            
            /* Responsive */
            @media (max-width: 768px) {
                .section-title {
                    font-size: 2rem;
                }
                
                .section-padding {
                    padding: 3rem 0;
                }
                
                .feature-icon {
                    width: 50px;
                    height: 50px;
                    font-size: 1.5rem;
                }
                
                .card-simple .card-body {
                    padding: 1.5rem;
                }
                
                .value-card {
                    padding: 1.2rem;
                }
            }
            
            @media (max-width: 576px) {
                .section-title {
                    font-size: 1.8rem;
                }
                
                .btn-primary-custom {
                    padding: 0.8rem 1.5rem;
                    font-size: 0.95rem;
                }
                
                .stats-badge {
                    font-size: 0.8rem;
                    padding: 0.3rem 0.8rem;

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

                <div class="row align-items-center g-4">
                    <div class="col-lg-6">
                        <img src="assets/images/3ae.png" alt="Giới thiệu VN Tours" class="img-fluid rounded-image">
                    </div>
                    <div class="col-lg-6">
                        <div class="card-simple">
                            <div class="card-body">
                                <h3 class="h3 mb-3" style="color: var(--primary-orange); font-weight: 600;">
                                    🌴 Khơi dậy cảm hứng du lịch Việt
                                </h3>
                                <p class="mb-3" style="font-size: 1rem; line-height: 1.6; color: var(--text-medium);">
                                    VN Tours là nền tảng du lịch kết nối hàng ngàn du khách đến những địa điểm tuyệt vời nhất tại Việt Nam. Chúng tôi mong muốn mọi chuyến đi không chỉ là hành trình, mà là trải nghiệm ghi dấu cảm xúc.
                                </p>
                                <div class="row g-2">

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

        <section class="section-padding bg-accent">

            <div class="container">
                <h2 class="section-title">Sứ mệnh – Tầm nhìn – Giá trị</h2>
                <div class="row g-4">
                    <div class="col-lg-4 col-md-6">

                        <div class="card-simple value-card">

                            <div class="feature-icon">
                                🎯
                            </div>
                            <h3>Sứ mệnh</h3>
                            <p>Giúp du khách khám phá Việt Nam an toàn, dễ dàng và trọn vẹn với những trải nghiệm không thể quên.</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">

                        <div class="card-simple value-card">

                            <div class="feature-icon">
                                🌍
                            </div>
                            <h3>Tầm nhìn</h3>
                            <p>Trở thành nền tảng du lịch hàng đầu Việt Nam và Đông Nam Á, kết nối thế giới với vẻ đẹp Việt.</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-12">

                        <div class="card-simple value-card">

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

                <div class="row align-items-center g-4">
                    <div class="col-lg-6 order-lg-1 order-2">
                        <div class="card-simple">
                            <div class="card-body">
                                <h3 class="h4 mb-3" style="color: var(--primary-orange); font-weight: 600;">
                                    🏆 Trải nghiệm đẳng cấp
                                </h3>
                                <p class="mb-3" style="font-size: 1rem; color: var(--text-medium);">

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
        <section class="section-padding bg-accent">

            <div class="container">
                <h2 class="section-title">Khách hàng nói gì về chúng tôi?</h2>
                <div class="row g-4">
                    <div class="col-lg-4 col-md-6">
                        <div class="testimonial-card">
                            <div class="testimonial-quote">
                                "Tour Đà Nẵng rất tuyệt vời! Hướng dẫn viên vui vẻ, nhiệt tình và tổ chức cực kỳ chuyên nghiệp. Sẽ quay lại với VN Tours!"
                            </div>
                            <div class="d-flex align-items-center">

                                <div class="avatar-placeholder bg-yellow me-3">
                                    <i class="bi bi-person-fill"></i>

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

                                <div class="avatar-placeholder bg-blue me-3">
                                    <i class="bi bi-person-fill"></i>

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
                                <div class="avatar-placeholder bg-green me-3">
                                    <i class="bi bi-person-fill"></i>
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
                        <h2 class="mb-3">Sẵn sàng khám phá Việt Nam?</h2>
                        <p class="mb-4" style="font-size: 1.1rem; opacity: 0.9;">
                            Hãy bắt đầu hành trình khám phá những điều kỳ diệu của đất nước chúng ta ngay hôm nay!
                        </p>
                        <a href="placeController?action=destination&page=indexjsp" class="btn-primary-custom">

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