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
        <title>VN Tours </title>
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <link href="assets/css/tour-booking.css" rel="stylesheet">
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

        <c:if test="${sessionScope.nameUser.role ne 'AD'}">
            <%@include file="footer.jsp" %>
        </c:if>

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