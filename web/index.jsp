<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>VN Travel Helper - Trang chủ</title>
        <link rel="stylesheet" href="assets/css/bodyCss.css"/>
        <style>

            .slider-container {
                max-width: 1200px;
                margin: 20px auto 40px auto;
                overflow: hidden;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                position: relative;
            }

            .slider {
                position: relative;
                width: 100vw;
                height: 305px;
                text-align: center;
            }

            .slide {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                object-fit: cover;
                opacity: 0;
                transition: opacity 1s ease-in-out;
                z-index: 1;
            }

            .slide.active {
                opacity: 1;
                z-index: 2;
            }

            .slider-title {
                position: absolute;
                top: 15px;
                left: 17%;
                color: white;
                font-size: 1.8rem;
                font-weight: 700;
                text-shadow: 2px 2px 6px rgba(0,0,0,0.7);
                z-index: 10;
                user-select: none;
            }

            /* Hover phóng to nhẹ card */
            .card:hover {
                transform: translateY(-10px) scale(1.05);
                box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            }

            .section {
                padding: 20px;
                max-width: 1200px;
                margin: 0 auto;
            }

            .title {
                font-size: 28px;
                font-weight: 700;
                margin-bottom: 30px;
                text-align: center;
                color: #222;
            }

            .grid {
                display: grid;
                grid-template-columns: repeat(3, 1fr); /* 3 cột đều nhau */
                gap: 24px;
            }

            form.card {
                display: flex;
                flex-direction: column;
                background: white;
                border-radius: 14px;
                box-shadow: 0 4px 14px rgba(0,0,0,0.1);
                overflow: hidden;
                cursor: pointer;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                height: 350px; /* chiều cao card cố định */
            }

            form.card:hover {
                transform: scale(1.05);
                box-shadow: 0 12px 30px rgba(0,0,0,0.2);
            }

            form.card .image-wrapper {
                flex: 1;
                overflow: hidden;
                border-radius: 14px 14px 0 0;
                position: relative;
            }

            form.card img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                display: block;
                transition: transform 0.3s ease;
            }

            form.card:hover img {
                transform: scale(1.1);
            }

            form.card h4 {
                padding: 12px 0;
                margin: 0;
                font-weight: 700;
                font-size: 18px;
                color: #222;
                text-align: center;
                user-select: none;
            }

            /* Nút overlay (nếu dùng) */
            .btn-overlay {
                position: absolute;
                bottom: 16px;
                left: 50%;
                transform: translateX(-50%);
                background-color: rgba(52, 152, 219, 0.8);
                color: white;
                border-radius: 24px;
                padding: 10px 28px;
                font-weight: 600;
                font-size: 14px;
                opacity: 0;
                pointer-events: none;
                transition: opacity 0.3s ease;
            }

            form.card:hover .btn-overlay {
                opacity: 1;
                pointer-events: auto;
            }

            /* Responsive */
            @media (max-width: 960px) {
                .grid {
                    grid-template-columns: repeat(2, 1fr);
                }

                form.card {
                    height: 300px;
                }
            }

            @media (max-width: 600px) {
                .grid {
                    grid-template-columns: 1fr;
                }

                form.card {
                    height: 280px;
                }
            }

        </style>
    </head>
    <body>

        <jsp:include page="header.jsp"/>

        <div class="content">
            <!-- Slider -->
            <div class="slider-container">
                <div class="slider">
                    <div class="slider-title">Việt Nam – Nơi mỗi bước chân là một câu chuyện.</div>
                    <img src="assets/images/danangimg.jpg" alt="Đà Nẵng" class="slide active">
                    <img src="assets/images/slider/dalatsl.webp" alt="Đà Lạt" class="slide">
                    <img src="assets/images/slider/vungtausl.jpg" alt="Vũng Tàu" class="slide">
                    <img src="assets/images/hanoiimg.jpg" alt="Hà Nội" class="slide">
                    <img src="assets/images/hueimg.jpg" alt="Huế" class="slide">
                    <img src="assets/images/slider/nhatrangslider.jpg" alt="Nha Trang" class="slide">
                </div>
            </div>

            <div class="section">
                <div class="title">Điểm đến nổi bật</div>
                <div class="grid">
                    <div class="card1">
                        <form class="card " action="placeController" method="post">
                            <div class="image-wrapper">
                                <img src="assets/images/danang2img.jpg" alt="Đà Nẵng" />
                                <button type="submit" class="btn-overlay">Xem thêm</button>
                            </div>
                            <h4>Đà Nẵng</h4>
                            <input type="hidden" name="action" value="takeListTour" />
                            <input type="hidden" name="location" value="Đà Nẵng" />
                        </form>
                    </div>

                    <div class="card2">
                        <form class="card " action="placeController" method="post">
                            <div class="image-wrapper">
                                <img src="assets/images/vungtauimg.jpg" alt="Vũng Tàu" />
                                <button type="submit" class="btn-overlay">Xem thêm</button>
                            </div>
                            <h4>Vũng Tàu</h4>
                            <input type="hidden" name="action" value="takeListTour" />
                            <input type="hidden" name="location" value="Vũng Tàu" />
                        </form>
                    </div>

                    <div class="card3">
                        <form class="card " action="placeController" method="post">
                            <div class="image-wrapper">
                                <img src="assets/images/nhatrangimg.jpg" alt="Nha Trang" />
                                <button type="submit" class="btn-overlay">Xem thêm</button>
                            </div>
                            <h4>Nha Trang</h4>
                            <input type="hidden" name="action" value="takeListTour" />
                            <input type="hidden" name="location" value="Nha Trang" />
                        </form>
                    </div>


                </div>
            </div>
        </div>


        <jsp:include page="footer.jsp"/>

        <script>
            const slides = document.querySelectorAll('.slide');
            let currentIndex = 0;

            function showSlide(index) {
                slides.forEach((slide, i) => {
                    slide.classList.toggle('active', i === index);
                });
            }

            setInterval(() => {
                currentIndex = (currentIndex + 1) % slides.length;
                showSlide(currentIndex);
            }, 7000); // 7 giây
        </script>

    </body>
</html>
