<%-- 
    Document   : DestinationForm
    Created on : May 19, 2025, 10:20:57 PM
    Author     : MSI PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .places-container {
                max-width: 1200px;
                margin: 40px auto;
                display: flex;
                flex-direction: column;
                gap: 24px;
                padding: 0 20px;
            }

            .place-card {
                display: flex;
                background-color: white;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                overflow: hidden;
                cursor: pointer;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                height: 130px;
                position: relative;
                text-decoration: none;
            }

            .place-card:hover {
                transform: scale(1.02);
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            }

            .place-image {
                width: 180px;
                height: 100%;
                object-fit: cover;
                flex-shrink: 0;
            }

            .place-content {
                padding: 16px 24px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                flex: 1;
                position: relative;
            }

            .place-content h4 {
                margin: 0 0 8px 0;
                font-size: 22px;
                font-weight: 700;
                color: #222;
            }

            .place-content p {
                margin: 0;
                font-size: 15px;
                color: #555;
                line-height: 1.3;
            }

            .btn-overlay {
                position: absolute;
                bottom: 16px;
                right: 24px;
                background-color: rgba(52, 152, 219, 0.85);
                color: white;
                border-radius: 24px;
                padding: 8px 20px;
                font-weight: 600;
                font-size: 14px;
                opacity: 0;
                pointer-events: none;
                transition: opacity 0.3s ease;
                border: none;
                cursor: pointer;
            }

            .place-card:hover .btn-overlay {
                opacity: 1;
                pointer-events: auto;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .place-card {
                    flex-direction: column;
                    height: auto;
                }
                .place-image {
                    width: 100%;
                    height: 220px;
                }
                .place-content {
                    padding: 12px 16px;
                }
                .btn-overlay {
                    position: relative;
                    bottom: auto;
                    right: auto;
                    margin-top: 12px;
                    opacity: 1;
                    pointer-events: auto;
                    width: 100%;
                    text-align: center;
                }
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="places-container">

            <form class="place-card" action="placeController" method="post">
                <img class="place-image" src="assets/images/danang2img.jpg" alt="Đà Nẵng" />
                <div class="place-content">
                    <h4>Đà Nẵng</h4>
                    <p>Đà Nẵng – thành phố biển xinh đẹp nổi tiếng với bãi biển Mỹ Khê dài và nhiều danh thắng hấp dẫn. Bạn sẽ được khám phá cầu Rồng, Bà Nà Hills, và thưởng thức ẩm thực đặc sắc.</p>
                    <input type="hidden" name="location" value="Đà Nẵng" />
                    <input type="hidden" name="action" value="tourList" />
                    <button type="submit" class="btn-overlay">Xem thêm</button>
                </div>
            </form>

            <form class="place-card" action="placeController" method="post">
                <img class="place-image" src="assets/images/dalatimg.webp" alt="Đà Lạt" />
                <div class="place-content">
                    <h4>Đà Lạt</h4>
                    <p>Đà Lạt được biết đến với khí hậu mát mẻ quanh năm, các vườn hoa và cảnh quan lãng mạn. Địa điểm lý tưởng cho các cặp đôi và những ai yêu thiên nhiên.</p>
                    <input type="hidden" name="location" value="Đà Lạt" />
                    <input type="hidden" name="action" value="tourList" />
                    <button type="submit" class="btn-overlay">Xem thêm</button>
                </div>
            </form>

            <form class="place-card" action="placeController" method="post">
                <img class="place-image" src="assets/images/vungtauimg.jpg" alt="Vũng Tàu" />
                <div class="place-content">
                    <h4>Vũng Tàu</h4>
                    <p>Vũng Tàu nổi tiếng với những bãi biển xanh mát và nhiều món hải sản thơm ngon. Đây là địa điểm nghỉ dưỡng được nhiều gia đình và nhóm bạn yêu thích.</p>
                    <input type="hidden" name="location" value="Vũng Tàu" />
                    <input type="hidden" name="action" value="tourList" />
                    <button type="submit" class="btn-overlay">Xem thêm</button>
                </div>
            </form>

            <form class="place-card" action="placeController" method="post">
                <img class="place-image" src="assets/images/hanoiimg.jpg" alt="Hà Nội" />
                <div class="place-content">
                    <h4>Hà Nội</h4>
                    <p>Thủ đô Hà Nội giữ nét cổ kính với nhiều di tích lịch sử, phố cổ sầm uất và văn hóa ẩm thực đặc trưng miền Bắc, là điểm đến không thể bỏ qua.</p>
                    <input type="hidden" name="location" value="Hà Nội" />
                    <input type="hidden" name="action" value="tourList" />
                    <button type="submit" class="btn-overlay">Xem thêm</button>
                </div>
            </form>

            <form class="place-card" action="placeController" method="post">
                <img class="place-image" src="assets/images/hueimg.jpg" alt="Huế" />
                <div class="place-content">
                    <h4>Huế</h4>
                    <p>Huế là cố đô với nhiều di tích cung điện, lăng tẩm cổ kính, và nét đẹp thanh bình bên dòng sông Hương mơ mộng.</p>
                    <input type="hidden" name="location" value="Huế" />
                    <input type="hidden" name="action" value="tourList"/>
                    <button type="submit" class="btn-overlay">Xem thêm</button>
                </div>
            </form>

            <form class="place-card" action="placeController" method="post">
                <img class="place-image" src="assets/images/nhatrangimg.jpg" alt="Nha Trang" />
                <div class="place-content">
                    <h4>Nha Trang</h4>
                    <p>Nha Trang nổi tiếng với biển xanh cát trắng, khu vui chơi giải trí và nhiều món hải sản tươi ngon hấp dẫn.</p>
                    <input type="hidden" name="location" value="Nha Trang" />
                    <input type="hidden" name="action" value="tourList" />
                    <button type="submit" class="btn-overlay">Xem thêm</button>
                </div>
            </form>

        </div>
        <%@include file="footer.jsp" %>
    </body>
</html>
