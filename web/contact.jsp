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
        <link rel="stylesheet" href="assets/css/bodyCss.css">
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
                font-size: 1.1rem;
                margin-bottom: 0.25rem;
                font-weight: bold;
            }
            .grid {
                display: grid;
                gap: 3rem;
            }
            .md-grid-2 {
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            }
            .rounded {
                border-radius: 0.75rem;
            }
            .shadow {
                box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            }
            .form-group {
                margin-bottom: 1rem;
            }
            .form-group label {
                display: block;
                font-weight: bold;
                margin-bottom: 0.25rem;
            }

            .form-group > input[type=text],
            input[type=email],
            input[type=tel],
            textarea {
                width: 100%;
                padding: 0.5rem 1rem;
                border: 1px solid #d1d5db;
                border-radius: 0.5rem;
                font-size: 1rem;
            }
            textarea {
                resize: vertical;
            }

            .btn {
                background-color: #2563eb;
                color: white;
                padding: 0.5rem 1.5rem;
                font-weight: bold;
                border: none;
                border-radius: 9999px;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .btn:hover {
                background-color: #1d4ed8;
            }
            .info-item {
                display: flex;
                gap: 1rem;
                font-size: 1rem;
                margin-bottom: 1.25rem;
            }
            .info-icon {
                font-size: 1.75rem;
            }
            .map {
                margin-top: 4rem;
                height: 16rem;
                width: 100%;
                border-radius: 0.5rem;
                box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            }
            .social-icons a {
                font-size: 1.5rem;
                margin-right: 0.75rem;
                color: #2563eb;
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>
        <div class="content">
            <section>
                <h2>Chúng tôi luôn sẵn sàng đồng hành cùng bạn</h2>

                <p style="text-align: center; margin-bottom: 2rem;">
                    Bạn có câu hỏi về tour? Muốn được tư vấn hành trình phù hợp? Hoặc cần hỗ trợ nhanh? <br>
                    Đừng ngần ngại – chúng tôi ở đây để giúp bạn có chuyến đi trọn vẹn nhất!
                </p>

                <div class="grid md-grid-2">
                    <!-- Hỗ trợ trực tiếp -->
                    <div>
                        <h3 style="margin-bottom: 1rem;">Liên hệ trực tiếp</h3>

                        <div class="info-item">
                            <span class="info-icon">📞</span>
                            <div>
                                <p><strong>Hotline đặt tour:</strong>  028 1234 5678 (24/7)</p>
                                <p><strong>Zalo / Messenger:</strong> @vntours</p>
                            </div>
                        </div>

                        <div class="info-item">
                            <span class="info-icon">📍</span>
                            <div>
                                <p><strong>Trụ sở:</strong> Lô E2a-7, Đường D1, Khu CNC, Thủ Đức, HCM</p>
                                <p><strong>Giờ làm việc:</strong> Thứ 2 – Thứ 6: 8h – 17h30 | Thứ 7: 8h – 12h</p>
                            </div>
                        </div>

                        <div class="info-item">
                            <span class="info-icon">📬</span>
                            <div>
                                <p><strong>Email:</strong> support@vntours.com</p>
                                <p><strong>Hợp tác kinh doanh:</strong> partner@vntours.com</p>
                            </div>
                        </div>
                    </div>

                    <!-- Gửi yêu cầu hỗ trợ -->
                    <div>
                        <form action="#" method="post" class="bg-[#f9fafb] p-6 rounded shadow">
                            <div class="form-group">
                                <label>Họ tên của bạn</label>
                                <input type="text" name="name" required>
                            </div>

                            <div class="form-group">
                                <label>Loại hỗ trợ</label>
                                <select name="type" required style="width: 100%; padding: 0.5rem; border-radius: 0.5rem; border: 1px solid #d1d5db;">
                                    <option value="">-- Chọn mục cần hỗ trợ --</option>
                                    <option value="tour">Tư vấn chọn tour</option>
                                    <option value="booking">Vấn đề đặt tour</option>
                                    <option value="tech">Kỹ thuật / Giao diện</option>
                                    <option value="partner">Hợp tác kinh doanh</option>
                                    <option value="partner">Đánh Giá Khách Hàng</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Email liên hệ</label>
                                <input type="email" name="email" required>
                            </div>

                            <div class="form-group">
                                <label>Nội dung</label>
                                <textarea name="message" rows="4" required></textarea>
                            </div>

                            <button type="submit" class="btn">Gửi yêu cầu</button>
                        </form>
                    </div>
                </div>
            </section>


            <!-- Bản đồ Google -->
            <div class="map">
                <iframe
                    src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3918.312079786337!2d106.80934507480582!3d10.865684257597673!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x317527ee4f1bcf59%3A0x6e9bdfcc5cd72de!2zVHLGsOG7nW5nIMSQ4bqhaSBI4buNYyBGUFQgSOG7kyBDaMOtIE5naOG7hyBIQ00!5e0!3m2!1svi!2s!4v1716886527822!5m2!1svi!2s"
                    width="100%" height="100%" allowfullscreen="" loading="lazy"
                    referrerpolicy="no-referrer-when-downgrade">
                </iframe>
            </div>
        </section>
    </div>
    <%@ include file="footer.jsp" %>
</body>
</html>



