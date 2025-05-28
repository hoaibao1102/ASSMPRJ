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
        <link rel="stylesheet" href="assets/css/bodyCss.css"> <!-- nếu bạn muốn tách css -->
        <style>
            
            section {
                padding: 4rem 1.5rem;
                max-width: 1200px;
                margin: auto;
            }
            h2 {
                font-size: 2.5rem;
                text-align: center;
                margin-bottom: 3rem;
            }
            h3 {
                font-size: 1.5rem;
                margin-bottom: 1rem;
                font-weight: bold;
            }
            .grid {
                display: grid;
                gap: 2rem;
            }
            .md-grid-2 {
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                align-items: center;
            }
            .md-grid-3 {
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            }
            .rounded {
                border-radius: 0.75rem;
            }
            .shadow {
                box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            }
            .text-center {
                text-align: center;
            }
            .list-disc {
                list-style-type: disc;
                padding-left: 1.25rem;
            }
            .bg-light {
                background-color: #f9fafb;
            }
            .bg-gray {
                background-color: #f3f4f6;
            }
            .text-blue {
                color: #2563eb;
            }
            .btn {
                background-color: #2563eb;
                color: white;
                padding: 0.75rem 1.5rem;
                font-weight: bold;
                border: none;
                border-radius: 9999px;
                cursor: pointer;
                text-decoration: none;
            }
            .btn:hover {
                background-color: #1d4ed8;
            }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>

        <!-- VỀ VN TOURS -->
        <section>
            <h2>Về VN Tours</h2>
            <div class="grid md-grid-2">
                <img src="assets/images/3ae.png" alt="Giới thiệu" class="rounded shadow" style="width:100%;">
                <div>
                    <h3>Khơi dậy cảm hứng du lịch Việt</h3>
                    <p style="margin-bottom:1.5rem;">
                        VN Tours là nền tảng du lịch kết nối hàng ngàn du khách đến những địa điểm tuyệt vời nhất tại Việt Nam. Chúng tôi mong muốn mọi chuyến đi không chỉ là hành trình, mà là trải nghiệm ghi dấu cảm xúc.
                    </p>
                    <ul class="list-disc">
                        <li>✅ Hơn 1000 tour mỗi năm</li>
                        <li>✅ Hợp tác với 100+ đối tác du lịch</li>
                        <li>✅ Chăm sóc khách hàng 24/7</li>
                    </ul>
                </div>
            </div>
        </section>

        <!-- SỨ MỆNH – TẦM NHÌN – GIÁ TRỊ -->
        <section class="bg-light">
            <h2>Sứ mệnh – Tầm nhìn – Giá trị</h2>
            <div class="grid md-grid-3 text-center">
                <div class="bg-white shadow rounded" style="padding: 1.5rem;">
                    <h3 class="text-blue">🎯 Sứ mệnh</h3>
                    <p>Giúp du khách khám phá Việt Nam an toàn, dễ dàng và trọn vẹn.</p>
                </div>
                <div class="bg-white shadow rounded" style="padding: 1.5rem;">
                    <h3 class="text-blue">🌍 Tầm nhìn</h3>
                    <p>Trở thành nền tảng du lịch hàng đầu Việt Nam và Đông Nam Á.</p>
                </div>
                <div class="bg-white shadow rounded" style="padding: 1.5rem;">
                    <h3 class="text-blue">💡 Giá trị</h3>
                    <p>Chất lượng – Minh bạch – Tận tâm – Bản sắc Việt.</p>
                </div>
            </div>
        </section>

        <!-- VÌ SAO CHỌN CHÚNG TÔI -->
        <section>
            <h2>Vì sao chọn VN Tours?</h2>
            <div class="grid md-grid-2">
                <div>
                    <p style="margin-bottom: 1rem;">Chúng tôi hiểu rằng du lịch không chỉ là điểm đến, mà là trải nghiệm. Đó là lý do bạn nên chọn chúng tôi:</p>
                    <ul class="list-disc">
                        <li>Giao diện dễ dùng, thân thiện</li>
                        <li>Nhiều ưu đãi hấp dẫn</li>
                        <li>Thông tin tour rõ ràng, minh bạch</li>
                        <li>Hướng dẫn viên được đào tạo bài bản</li>
                    </ul>
                </div>
                <img src="assets/images/visaochontour.png" alt="Vì sao chọn" class="rounded shadow" style="width:100%;">
            </div>
        </section>

        <!-- ĐÁNH GIÁ KHÁCH HÀNG -->
        <section class="bg-gray">
            <h2>Khách hàng nói gì?</h2>
            <div class="grid md-grid-3">
                <div class="bg-white rounded shadow" style="padding: 1.5rem;">
                    <p><em>“Tour Đà Nẵng rất tuyệt, HDV vui vẻ, tổ chức chuyên nghiệp.”</em></p>
                    <p class="text-blue" style="margin-top:1rem;">– Minh Tú, Hà Nội</p>
                </div>
                <div class="bg-white rounded shadow" style="padding: 1.5rem;">
                    <p><em>“Trang web dễ dùng, đặt tour nhanh chóng và hỗ trợ tốt.”</em></p>
                    <p class="text-blue" style="margin-top:1rem;">– Phương Anh, TP.HCM</p>
                </div>
                <div class="bg-white rounded shadow" style="padding: 1.5rem;">
                    <p><em>“Mình đã đi 3 tour qua VN Tours, rất hài lòng.”</em></p>
                    <p class="text-blue" style="margin-top:1rem;">– Đức Huy, Đà Nẵng</p>
                </div>
            </div>
        </section>

        <!-- CTA -->
        <section class="text-center">
            <a href="index.jsp" class="btn">Quay về Trang chủ</a>
        </section>

        <%@ include file="footer.jsp" %>
    </body>
</html>


