<%-- 
    Document   : index
--%>
<%@page import="java.util.List"%>
<%@page import="DTO.PlacesDTO"%>
<%@page import="UTILS.AuthUtils"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>VN Travel Helper - Trang chủ</title>
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            /* VN Travel Theme - Optimized Colors */
            :root {
                /* Main Colors */
                --primary-blue: #0EA5E9;
                --coral-orange: #FF6B35;
                --emerald-green: #10B981;

                /* Secondary Colors */
                --golden-yellow: #F59E0B;
                --purple-lavender: #8B5CF6;
                --pearl-white: #FEFEFE;

                /* Text Colors */
                --text-primary: #1F2937;
                --text-secondary: #6B7280;
                --text-light: #9CA3AF;

                /* Gradients */
                --gradient-main: linear-gradient(135deg, #0EA5E9, #10B981);
                --gradient-secondary: linear-gradient(135deg, #FF6B35, #F59E0B);

                /* Layout */
                --border-radius: 8px;
                --transition: all 0.3s ease;
                --light-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                --header-height: 70px;
            }

            * {
                box-sizing: border-box;
            }

            body {
                margin: 0;
                padding-top: var(--header-height);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: var(--pearl-white);
                color: var(--text-primary);
                line-height: 1.6;
            }

            /* Make sure header content doesn't interfere with dropdown */
            .content {
                position: relative;
                z-index: 1;
                flex-grow: 1;
            }

            /* Admin layout adjustments */
            .admin-layout {
                padding-top: 0;
                margin-left: 260px;
            }

            .admin-layout > .content {
                margin-left: 0;
                padding: 2rem;
            }

            /* Hero Slider - Optimized */
            .hero-slider {
                position: relative;
                height: 60vh;
                min-height: 400px;
                overflow: hidden;
                margin-top: 0;
            }

            .hero-image {
                height: 60vh;
                min-height: 400px;
                object-fit: cover;
                object-position: center;
            }

            .hero-caption {
                position: absolute;
                bottom: 0;
                left: 0;
                right: 0;
                background: linear-gradient(transparent, rgba(0, 0, 0, 0.7));
                padding: 60px 20px 30px;
                text-align: center;
            }

            .hero-title {
                font-size: 2.5rem;
                font-weight: 700;
                margin-bottom: 1rem;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);
                color: white;
            }

            .hero-subtitle {
                font-size: 1.2rem;
                margin-bottom: 0;
                opacity: 0.9;
                color: white;
            }

            /* Carousel Controls */
            .carousel-control-prev,
            .carousel-control-next {
                width: 50px;
                height: 50px;
                top: 50%;
                transform: translateY(-50%);
                background: rgba(255, 255, 255, 0.2);
                border-radius: 50%;
                border: 1px solid rgba(255, 255, 255, 0.3);
                transition: var(--transition);
            }

            .carousel-control-prev:hover,
            .carousel-control-next:hover {
                background: rgba(255, 255, 255, 0.4);
            }

            .carousel-control-prev {
                left: 20px;
            }

            .carousel-control-next {
                right: 20px;
            }

            .carousel-indicators {
                bottom: 15px;
            }

            .carousel-indicators button {
                width: 10px;
                height: 10px;
                border-radius: 50%;
                margin: 0 4px;
                background: rgba(255, 255, 255, 0.6);
                border: none;
                transition: var(--transition);
            }

            .carousel-indicators button.active {
                background: white;
            }

            /* Section Styles */
            .section-title {
                font-size: 2.2rem;
                font-weight: 700;
                color: var(--text-primary);
                margin-bottom: 1rem;
            }

            .section-subtitle {
                font-size: 1.1rem;
                color: var(--text-secondary);
                max-width: 600px;
                margin: 0 auto;
            }

            /* Featured Destinations Section */
            .featured-destinations {
                background: white;
                position: relative;
                z-index: 1;
            }

            /* Tour Card Styles */
            .destination-card {
                height: 100%;
            }

            .tour-card {
                border: 1px solid #e5e7eb;
                border-radius: var(--border-radius);
                overflow: hidden;
                box-shadow: var(--light-shadow);
                transition: var(--transition);
                height: 100%;
                background: white;
            }

            .tour-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
            }

            .card-img-wrapper {
                position: relative;
                overflow: hidden;
                height: 300px;
            }

            .card-img-top {
                height: 100%;
                width: 100%;
                object-fit: cover;
                transition: var(--transition);
            }

            .tour-card:hover .card-img-top {
                transform: scale(1.05);
            }

            .card-overlay {
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: linear-gradient(135deg, rgba(14, 165, 233, 0.8), rgba(16, 185, 129, 0.8));
                display: flex;
                align-items: center;
                justify-content: center;
                opacity: 0;
                transition: var(--transition);
            }

            .tour-card:hover .card-overlay {
                opacity: 1;
            }

            .overlay-content {
                text-align: center;
                color: white;
            }

            .overlay-content i {
                font-size: 2.5rem;
                margin-bottom: 0.5rem;
                display: block;
            }

            .overlay-content span {
                font-size: 1.1rem;
                font-weight: 600;
                text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
            }

            .card-body {
                padding: 1.5rem;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                height: 40%;
            }

            .card-title {
                font-size: 1.3rem;
                font-weight: 600;
                color: var(--text-primary);
                margin-bottom: 1rem;
                display: flex;
                align-items: center;
            }

            .card-title i {
                margin-right: 0.5rem;
                color: var(--coral-orange);
            }

            .btn-book {
                background: var(--gradient-main);
                border: none;
                padding: 12px 24px;
                font-weight: 600;
                border-radius: var(--border-radius);
                transition: var(--transition);
                color: white;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
            }

            .btn-book:hover {
                background: var(--gradient-secondary);
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(255, 107, 53, 0.3);
            }

            /* Features Section */
            .features-section {
                background: linear-gradient(135deg, #f8fafc, #e2e8f0);
                position: relative;
                z-index: 1;
            }

            .feature-card {
                background: white;
                padding: 2.5rem 2rem;
                border-radius: var(--border-radius);
                box-shadow: var(--light-shadow);
                transition: var(--transition);
                height: 100%;
                border: 1px solid #e5e7eb;
                text-align: center;
            }

            .feature-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
            }

            .feature-icon {
                width: 80px;
                height: 80px;
                margin: 0 auto 1.5rem;
                background: var(--gradient-main);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 2rem;
                color: white;
                transition: var(--transition);
            }

            .feature-card:hover .feature-icon {
                background: var(--gradient-secondary);
                transform: scale(1.1);
            }

            .feature-card h5 {
                color: var(--text-primary);
                font-weight: 600;
                margin-bottom: 1rem;
                font-size: 1.2rem;
            }

            .feature-card p {
                color: var(--text-secondary);
                margin-bottom: 0;
                line-height: 1.6;
            }

            /* User Manager Styles */
            .user-manager-center {
                max-width: 1200px;
                margin: 40px auto 0 auto;
                background: white;
                border-radius: var(--border-radius);
                box-shadow: var(--light-shadow);
                padding: 2rem;
            }

            .user-manager-table {
                width: 100%;
                border-collapse: collapse;
                background: white;
                border-radius: var(--border-radius);
                overflow: hidden;
                box-shadow: var(--light-shadow);
                margin-bottom: 2rem;
            }

            .user-manager-table thead tr {
                background: var(--gradient-main);
                color: white;
            }

            .user-manager-table th,
            .user-manager-table td {
                padding: 1rem;
                text-align: left;
                border-bottom: 1px solid #e5e7eb;
            }

            .user-manager-table tbody tr:hover {
                background: #f8fafc;
            }

            .user-manager-table button[type="submit"] {
                background: var(--coral-orange);
                color: white;
                border: none;
                border-radius: var(--border-radius);
                padding: 8px 16px;
                font-size: 0.9rem;
                cursor: pointer;
                transition: var(--transition);
            }

            .user-manager-table button[type="submit"]:hover {
                background: #e55a2b;
                transform: translateY(-1px);
            }

            .user-manager-title {
                text-align: center;
                margin-bottom: 2rem;
                color: var(--text-primary);
                font-size: 2.2rem;
                font-weight: 700;
            }

            .access-denied {
                margin: 4rem auto;
                padding: 2rem;
                background: #fef2f2;
                color: var(--coral-orange);
                border: 1px solid var(--coral-orange);
                border-radius: var(--border-radius);
                max-width: 500px;
                text-align: center;
                font-size: 1.2rem;
                box-shadow: var(--light-shadow);
            }

            /* Auto-submit form - hidden */
            #autoSubmitForm {
                display: none;
                visibility: hidden;
            }

            /* Responsive Design */
            @media (max-width: 991.98px) {
                .admin-layout {
                    margin-left: 0;
                    padding-top: var(--header-height);
                }
            }

            @media (max-width: 768px) {
                body {
                    padding-top: var(--header-height);
                }

                .admin-layout {
                    margin-left: 0;
                }

                .hero-slider {
                    height: 50vh;
                    min-height: 300px;
                }

                .hero-image {
                    height: 50vh;
                    min-height: 300px;
                }

                .hero-title {
                    font-size: 2rem;
                }

                .hero-subtitle {
                    font-size: 1rem;
                }

                .section-title {
                    font-size: 1.8rem;
                }

                .carousel-control-prev,
                .carousel-control-next {
                    width: 40px;
                    height: 40px;
                }

                .carousel-control-prev {
                    left: 10px;
                }

                .carousel-control-next {
                    right: 10px;
                }

                .card-img-wrapper {
                    height: 200px;
                }

                .feature-icon {
                    width: 70px;
                    height: 70px;
                    font-size: 1.7rem;
                }

                .feature-card {
                    padding: 2rem 1.5rem;
                }

                .user-manager-table th,
                .user-manager-table td {
                    padding: 0.75rem 0.5rem;
                    font-size: 0.9rem;
                }
            }

            @media (max-width: 576px) {
                .hero-caption {
                    padding: 40px 15px 20px;
                }

                .hero-title {
                    font-size: 1.6rem;
                }

                .hero-subtitle {
                    font-size: 0.95rem;
                }

                .section-title {
                    font-size: 1.6rem;
                }

                .card-img-wrapper {
                    height: 180px;
                }

                .feature-card {
                    padding: 1.5rem 1rem;
                }

                .feature-icon {
                    width: 60px;
                    height: 60px;
                    font-size: 1.5rem;
                }

                .card-body {
                    padding: 1.25rem;
                }

                .card-title {
                    font-size: 1.1rem;
                }
            }

            /* Animation classes */
            .fade-in {
                opacity: 0;
                transform: translateY(30px);
                transition: all 0.6s ease;
            }

            .fade-in.visible {
                opacity: 1;
                transform: translateY(0);
            }

            /* Smooth scrolling */
            html {
                scroll-behavior: smooth;
            }
        </style>
    </head>
    <body class="<%= AuthUtils.isAdmin(session)? "admin-layout" : "" %>">

        <jsp:include page="header.jsp"/>

        <c:if test="${not empty requestScope.errorMessage}">
            <script>
                window.alert("${errorMessage}");
            </script>
        </c:if>

        <div class="content">
            <!-- Hero Slider Section -->
            <section class="hero-slider">
                <div id="heroCarousel" class="carousel slide carousel-fade" data-bs-ride="carousel" data-bs-interval="6000">
                    <div class="carousel-indicators">
                        <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                        <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
                        <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
                        <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="3" aria-label="Slide 4"></button>
                        <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="4" aria-label="Slide 5"></button>
                        <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="5" aria-label="Slide 6"></button>
                    </div>
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img src="assets/images/danangimg.jpg" class="d-block w-100 hero-image" alt="Đà Nẵng">
                            <div class="carousel-caption hero-caption">
                                <h1 class="hero-title">Việt Nam – Nơi mỗi bước chân là một câu chuyện</h1>
                                <p class="hero-subtitle">Khám phá vẻ đẹp thiên nhiên tuyệt vời và văn hóa độc đáo</p>
                            </div>
                        </div>
                        <div class="carousel-item">
                            <img src="assets/images/slider/dalatsl.webp" class="d-block w-100 hero-image" alt="Đà Lạt">
                            <div class="carousel-caption hero-caption">
                                <h1 class="hero-title">Đà Lạt - Thành phố ngàn hoa</h1>
                                <p class="hero-subtitle">Khí hậu mát mẻ, phong cảnh thơ mộng</p>
                            </div>
                        </div>
                        <div class="carousel-item">
                            <img src="assets/images/slider/vungtausl.jpg" class="d-block w-100 hero-image" alt="Vũng Tàu">
                            <div class="carousel-caption hero-caption">
                                <h1 class="hero-title">Vũng Tàu - Biển xanh cát trắng</h1>
                                <p class="hero-subtitle">Nghỉ dưỡng lý tưởng gần Sài Gòn</p>
                            </div>
                        </div>
                        <div class="carousel-item">
                            <img src="assets/images/hanoiimg.jpg" class="d-block w-100 hero-image" alt="Hà Nội">
                            <div class="carousel-caption hero-caption">
                                <h1 class="hero-title">Hà Nội - Thủ đô ngàn năm văn hiến</h1>
                                <p class="hero-subtitle">Nơi lưu giữ tinh hoa văn hóa dân tộc</p>
                            </div>
                        </div>
                        <div class="carousel-item">
                            <img src="assets/images/hueimg.jpg" class="d-block w-100 hero-image" alt="Huế">
                            <div class="carousel-caption hero-caption">
                                <h1 class="hero-title">Huế - Cố đô hoàng gia</h1>
                                <p class="hero-subtitle">Di sản văn hóa thế giới</p>
                            </div>
                        </div>
                        <div class="carousel-item">
                            <img src="assets/images/slider/nhatrangslider.jpg" class="d-block w-100 hero-image" alt="Nha Trang">
                            <div class="carousel-caption hero-caption">
                                <h1 class="hero-title">Nha Trang - Thiên đường biển đảo</h1>
                                <p class="hero-subtitle">Bãi biển đẹp nhất Việt Nam</p>
                            </div>
                        </div>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
            </section>

            <!-- Auto-submit form -->
            <form id="autoSubmitForm" action="MainController" method="post" style="display: none;">
                <input type="hidden" name="action" value="destination">
                <input type="hidden" name="page" value="indexjsp">
            </form>

            <!-- Featured Destinations Section -->
            <section class="featured-destinations py-5">
                <div class="container">
                    <div class="row">
                        <div class="col-12 text-center mb-5">
                            <h2 class="section-title fade-in">
                                <i class="fas fa-map-marked-alt me-2" style="color: var(--primary-blue);"></i>
                                Điểm đến nổi bật
                            </h2>
                            <p class="section-subtitle fade-in">Khám phá những địa điểm du lịch tuyệt vời nhất</p>
                        </div>
                    </div>
                    <div class="row g-4">
                        <c:forEach var="place" items="${placeList}">
                            <c:if test="${place.featured and place.status}">
                                <div class="col-lg-4 col-md-6 fade-in">
                                    <div class="destination-card">
                                        <form action="MainController" method="post" class="h-100">
                                            <div class="card tour-card h-100">
                                                <div class="card-img-wrapper">
                                                    <img src="${place.img}" class="card-img-top" alt="${place.placeName}">
                                                    <div class="card-overlay">
                                                        <div class="overlay-content">
                                                            <i class="fas fa-eye"></i>
                                                            <span>Xem chi tiết</span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="card-body">
                                                    <h5 class="card-title">
                                                        <i class="fas fa-map-marker-alt"></i>
                                                        ${place.placeName}
                                                    </h5>
                                                    <div class="mt-auto">
                                                        <button type="submit" class="btn btn-book w-100">
                                                            <i class="fas fa-ticket-alt"></i>
                                                            Xem thêm
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                            <input type="hidden" name="action" value="takeListTicket" />
                                            <input type="hidden" name="location" value="${place.placeName}" />
                                        </form>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </section>

            <!-- Features Section -->
            <section class="features-section py-5">
                <div class="container">
                    <div class="row">
                        <div class="col-12 text-center mb-5">
                            <h2 class="section-title fade-in">
                                <i class="fas fa-star me-2" style="color: var(--golden-yellow);"></i>
                                Tại sao chọn chúng tôi?
                            </h2>
                        </div>
                    </div>
                    <div class="row g-4">
                        <div class="col-lg-3 col-md-6 fade-in">
                            <div class="feature-card">
                                <div class="feature-icon">
                                    <i class="fas fa-shield-alt"></i>
                                </div>
                                <h5>Đảm bảo an toàn</h5>
                                <p>Chúng tôi cam kết mang đến cho bạn những chuyến đi an toàn nhất với các biện pháp bảo vệ toàn diện</p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6 fade-in">
                            <div class="feature-card">
                                <div class="feature-icon">
                                    <i class="fas fa-dollar-sign"></i>
                                </div>
                                <h5>Giá cả hợp lý</h5>
                                <p>Giá tour tốt nhất thị trường với chất lượng dịch vụ tuyệt vời, không phát sinh chi phí</p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6 fade-in">
                            <div class="feature-card">
                                <div class="feature-icon">
                                    <i class="fas fa-headset"></i>
                                </div>
                                <h5>Hỗ trợ 24/7</h5>
                                <p>Đội ngũ tư vấn chuyên nghiệp sẵn sàng hỗ trợ bạn mọi lúc, mọi nơi</p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6 fade-in">
                            <div class="feature-card">
                                <div class="feature-icon">
                                    <i class="fas fa-users"></i>
                                </div>
                                <h5>Hướng dẫn viên chuyên nghiệp</h5>
                                <p>Đội ngũ HDV giàu kinh nghiệm, am hiểu văn hóa địa phương và thành thạo ngoại ngữ</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>

        <jsp:include page="footer.jsp"/>

       <script src="assets/js/chatbase-loader.js"></script>




        <!-- Bootstrap 5 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            // Auto-submit form with better reliability
            (function () {
                // Check if form submission is needed
                var hasSubmitted = false;

                // Use sessionStorage for better compatibility
                try {
                    hasSubmitted = sessionStorage.getItem('autoFormSubmitted') === 'true';
                } catch (e) {
                    // Fallback to cookie if sessionStorage is not available
                    hasSubmitted = document.cookie.indexOf('autoFormSubmitted=true') !== -1;
                }

                if (!hasSubmitted) {
                    try {
                        sessionStorage.setItem('autoFormSubmitted', 'true');
                    } catch (e) {
                        // Fallback to cookie
                        document.cookie = 'autoFormSubmitted=true; path=/';
                    }

                    // Submit the form
                    var form = document.getElementById('autoSubmitForm');
                    if (form) {
                        form.submit();
                    }
                }
            })();

            // Fade in animation on scroll
            document.addEventListener('DOMContentLoaded', function () {
                const observerOptions = {
                    threshold: 0.1,
                    rootMargin: '0px 0px -50px 0px'
                };

                const observer = new IntersectionObserver(function (entries) {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            entry.target.classList.add('visible');
                        }
                    });
                }, observerOptions);

                // Observe all fade-in elements
                document.querySelectorAll('.fade-in').forEach(el => {
                    observer.observe(el);
                });

                // Enhanced hover effects
                const tourCards = document.querySelectorAll('.tour-card');
                const featureCards = document.querySelectorAll('.feature-card');

                [...tourCards, ...featureCards].forEach(card => {
                    card.addEventListener('mouseenter', function () {
                        this.style.transform = 'translateY(-5px)';
                    });

                    card.addEventListener('mouseleave', function () {
                        this.style.transform = 'translateY(0)';
                    });
                });

                // Smooth scrolling for navigation links
                document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                    anchor.addEventListener('click', function (e) {
                        e.preventDefault();
                        const targetId = this.getAttribute('href').substring(1);
                        const targetElement = document.getElementById(targetId);

                        if (targetElement) {
                            targetElement.scrollIntoView({
                                behavior: 'smooth',
                                block: 'start'
                            });
                        }
                    });
                });

                // Navbar scroll effect
                window.addEventListener('scroll', function () {
                    const navbar = document.querySelector('.navbar');
                    if (navbar) {
                        if (window.scrollY > 50) {
                            navbar.classList.add('scrolled');
                        } else {
                            navbar.classList.remove('scrolled');
                        }
                    }
                });

                // Image lazy loading
                const images = document.querySelectorAll('img[data-src]');
                const imageObserver = new IntersectionObserver((entries, observer) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            const img = entry.target;
                            img.src = img.dataset.src;
                            img.classList.remove('lazy');
                            imageObserver.unobserve(img);
                        }
                    });
                });

                images.forEach(img => imageObserver.observe(img));

                // Form validation enhancement
                const forms = document.querySelectorAll('.needs-validation');
                forms.forEach(form => {
                    form.addEventListener('submit', function (event) {
                        if (!form.checkValidity()) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    });
                });

                // Back to top button
                const backToTopBtn = document.querySelector('.back-to-top');
                if (backToTopBtn) {
                    window.addEventListener('scroll', function () {
                        if (window.scrollY > 300) {
                            backToTopBtn.style.display = 'block';
                        } else {
                            backToTopBtn.style.display = 'none';
                        }
                    });

                    backToTopBtn.addEventListener('click', function () {
                        window.scrollTo({
                            top: 0,
                            behavior: 'smooth'
                        });
                    });
                }

                // Carousel auto-play control
                const carousels = document.querySelectorAll('.carousel');
                carousels.forEach(carousel => {
                    carousel.addEventListener('mouseenter', function () {
                        const bsCarousel = bootstrap.Carousel.getInstance(this);
                        if (bsCarousel) {
                            bsCarousel.pause();
                        }
                    });

                    carousel.addEventListener('mouseleave', function () {
                        const bsCarousel = bootstrap.Carousel.getInstance(this);
                        if (bsCarousel) {
                            bsCarousel.cycle();
                        }
                    });
                });

                // Mobile menu toggle enhancement
                const navToggler = document.querySelector('.navbar-toggler');
                const navCollapse = document.querySelector('.navbar-collapse');

                if (navToggler && navCollapse) {
                    navToggler.addEventListener('click', function () {
                        setTimeout(() => {
                            if (navCollapse.classList.contains('show')) {
                                document.body.style.overflow = 'hidden';
                            } else {
                                document.body.style.overflow = 'auto';
                            }
                        }, 300);
                    });
                }

                // Close mobile menu when clicking outside
                document.addEventListener('click', function (e) {
                    const navbar = document.querySelector('.navbar');
                    const navCollapse = document.querySelector('.navbar-collapse');

                    if (navbar && navCollapse && !navbar.contains(e.target) && navCollapse.classList.contains('show')) {
                        const navToggler = document.querySelector('.navbar-toggler');
                        if (navToggler) {
                            navToggler.click();
                        }
                    }
                });

                // Tooltip initialization
                const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
                tooltipTriggerList.map(function (tooltipTriggerEl) {
                    return new bootstrap.Tooltip(tooltipTriggerEl);
                });

                // Popover initialization
                const popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
                popoverTriggerList.map(function (popoverTriggerEl) {
                    return new bootstrap.Popover(popoverTriggerEl);
                });

                // Loading animation
                window.addEventListener('load', function () {
                    const loader = document.querySelector('.loader-wrapper');
                    if (loader) {
                        loader.style.opacity = '0';
                        setTimeout(() => {
                            loader.style.display = 'none';
                        }, 500);
                    }
                });

                // Performance optimization: Debounce scroll events
                function debounce(func, wait) {
                    let timeout;
                    return function executedFunction(...args) {
                        const later = () => {
                            clearTimeout(timeout);
                            func(...args);
                        };
                        clearTimeout(timeout);
                        timeout = setTimeout(later, wait);
                    };
                }

                // Apply debounce to scroll events
                const debouncedScrollHandler = debounce(function () {
                    // Any scroll-heavy operations can be placed here
                    console.log('Scroll event processed');
                }, 100);

                window.addEventListener('scroll', debouncedScrollHandler);
            });
        </script>
    </body>
</html>