<%-- 
    Document   : OrderForm
    Created on : May 29, 2025, 11:08:57 PM
    Author     : MSI PC
--%>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<%@ page import="DTO.UserDTO"%>
<%@ page import="DTO.StartDateDTO"%>
<%@ page import="DTO.TourTicketDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thanh toán</title>
        <link rel="stylesheet" href="assets/css/bodyCss.css"/>
        <style>
            .containerdetail {
                display: grid;
                grid-template-columns: 6fr 4fr;
                max-width: 1200px;
                margin: 30px auto;
                gap: 30px;
            }

            .left-content, .right-content {
                background-color: #f5f5f5;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
            }

            .right-content {
                background-color: #fff8f0;
            }


            /*            ============================CSS Thanh trang thai*/
            .step-container {
                position: relative;
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 80px;
                margin-bottom: 40px;
            }

            .step-title {
                position: absolute;
                top: -40px;
                left: 50%;
                transform: translateX(-50%);
                font-size: 24px;
                color: #004080;
                font-weight: bold;
            }

            .step-tracker {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 100px;
            }

            .step {
                display: flex;
                flex-direction: column;
                align-items: center;
                width: 120px; /* cố định chiều rộng */
                text-align: center;
                flex-shrink: 0; /* không co lại nếu thiếu không gian */
            }

            .step .icon {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                display: flex;
                justify-content: center;
                align-items: center;
                margin-bottom: 8px;
                background-color: #ccc;
            }

            .step .icon img {
                width: 24px;
                height: 24px;
            }

            .step .label {
                font-size: 14px;
                color: #888;
                font-weight: bold;
            }

            .step.active .icon {
                background-color: #4cd964;
            }
            .step.active .label {
                color: #4cd964;
            }


            .step.current .label {
                color: #007bff;
            }

            .arrow {
                font-size: 18px;
                color: #ccc;
            }

            /*            ===================================css thông tin ben trái*/

            .form-container {
                max-width: 900px;
                margin: 30px auto;
                font-family: Arial, sans-serif;
                font-size: 14px;
            }

            h3 {
                margin: 2vh 0vh;
                font-size: 18px;
                font-weight: bold;
                color: #d32f2f;
            }



            .contact-grid {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 16px;
            }

            .form-group {
                display: flex;
                flex-direction: column;
            }

            .form-group label {
                font-weight: bold;
                margin-bottom: 5px;
            }

            .required {
                color: red;
            }

            .form-group input[type="text"], input[type="email"] {
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 6px;
            }

            .passenger-section {
                display: flex;
                gap: 16px;
                flex-wrap: wrap;
                margin-top: 20px;
            }

            .passenger-box {
                flex: 1;
                min-width: 250px;
                border: 1px solid #ccc;
                border-radius: 8px;
                padding: 12px;
            }

            .box-header {
                font-weight: bold;
                margin-bottom: 5px;
            }

            .subtext {
                display: block;
                font-size: 12px;
                color: #777;
                margin-top: 2px;
            }

            .counter {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-top: 8px;
            }

            .counter button {
                width: 32px;
                height: 32px;
                font-size: 18px;
                font-weight: bold;
                background: none;
                border: 1px solid #ccc;
                border-radius: 50%;
                cursor: pointer;
            }

            .counter span {
                font-size: 16px;
                min-width: 20px;
                text-align: center;
            }

            .note-section {
                margin-top: 20px;
                font-family: Arial, sans-serif;
            }

            .note-label {
                font-size: 16px;
                display: block;
                margin-bottom: 4px;
            }

            .note-subtext {
                font-size: 14px;
                color: #333;
                margin-bottom: 10px;
            }

            .note-textarea {
                width: 100%;
                padding: 15px;
                border-radius: 8px;
                border: 1px solid #ccc;
                background-color: #f9f9f9;
                resize: vertical;
                font-size: 14px;
                color: #333;
                outline: none;
                transition: border-color 0.2s;
            }

            .note-textarea:focus {
                border-color: #007bff;
                background-color: #fff;
            }

            /*=============================================================css bên phai*/

            .summary-box {
                max-width: 400px;
                background: #fff;
                border-radius: 12px;
                padding: 20px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                font-family: Arial, sans-serif;
            }

            .summary-box h3 {
                font-size: 18px;
                margin-bottom: 15px;
            }

            .tour-info {
                display: flex;
                gap: 12px;
                margin-bottom: 15px;
            }

            .tour-info img {
                width: 60px;
                height: 40px;
                object-fit: cover;
                border-radius: 6px;
            }

            .tour-details p {
                margin: 3px 0;
                font-size: 14px;
            }

            .tour-code {
                font-size: 13px;
                color: #555;
            }

            .flight-info {
                display: flex;
                justify-content: space-between;
                margin-bottom: 15px;
                font-size: 13px;
            }

            .flight-info img {
                height: 20px;
                margin-top: 5px;
            }

            .section-title {
                font-weight: bold;
                margin: 10px 0 5px;
                display: flex;
                justify-content: space-between;
            }

            .line-item {
                display: flex;
                justify-content: space-between;
                font-size: 13px;
                padding: 4px 0;
            }

            .discount-section {
                margin-top: 15px;
            }

            .btn-add-discount {
                background: none;
                border: none;
                color: red;
                font-weight: bold;
                font-size: 14px;
                cursor: pointer;
                padding: 4px 0;
            }

            .total {
                border-top: 1px solid #ccc;
                margin-top: 20px;
                padding-top: 12px;
                display: flex;
                justify-content: space-between;
                font-weight: bold;
                font-size: 16px;
            }

            .total-amount {
                color: red;
            }

            .btn-submit {
                background-color: red;
                color: white;
                width: 100%;
                padding: 12px;
                margin-top: 20px;
                font-size: 15px;
                font-weight: bold;
                border: none;
                border-radius: 8px;
                cursor: pointer;
            }
        </style>


    </style>
</head>
<body class="<%= isAdmin ? "admin-layout" : "" %>">
    <%
            UserDTO account = (UserDTO)session.getAttribute("nameUser");
            TourTicketDTO tour = (TourTicketDTO)session.getAttribute("tourTicket");
            StartDateDTO stDate = (StartDateDTO)session.getAttribute("stDate");
    %>


    <%@include file="header.jsp" %>
    <div class="content">
        <div class="step-container">
            <h2 class="step-title">ĐẶT TOUR</h2>
            <div class="step-tracker">
                <a href="BookingStep1.jsp">
                    <div class="step active">
                        <div class="icon green">
                            <img src="assets/images/icon/icon_fillfile.jpg" alt="info" />
                        </div>
                        <div class="label">NHẬP THÔNG TIN</div>
                    </div>
                </a>

                <div class="arrow">➜</div>


                <div class="step">
                    <div class="icon gray">
                        <img src="assets/images/icon/icon_thanhtoan.jpg" alt="pay" />
                    </div>
                    <div class="label">THANH TOÁN</div>
                </div>


                <div class="arrow">➜</div>


                <div class="step">
                    <div class="icon gray">
                        <img src="assets/images/icon/icon_done.jpg" alt="done" />
                    </div>
                    <div class="label">HOÀN TẤT</div>
                </div>


            </div>
        </div>

        

        <!--    ===================================================thong tin ben trai        -->

        <div class="containerdetail">
            <div class="left-content">
                <div class="form-container">
                    <h3>THÔNG TIN LIÊN LẠC</h3>

                    <div class="contact-grid">
                        <div class="form-group">
                            <label>Họ tên <span class="required">*</span></label>
                            <input type="text" value="<%=account.getFullName()%>" >
                        </div>
                        <div class="form-group">
                            <label>Điện thoại <span class="required">*</span></label>
                            <input type="text" value="<%=account.getPhone()%>" />
                        </div>
                        <div class="form-group">
                            <label>Email <span class="required">*</span></label>
                            <input type="email" value="<%=account.getEmail()%>" />
                        </div>

                    </div>

                    <h3>HÀNH KHÁCH</h3>
                    <div class="passenger-section">
                        <div class="passenger-box">
                            <div class="box-header">Người lớn <span class="subtext">Từ 12 tuổi trở lên</span></div>
                            <div class="counter">
                                <button onclick="changeCount('adult', -1)">−</button>
                                <span id="adult-count">1</span>
                                <button onclick="changeCount('adult', 1)">+</button>
                            </div>
                        </div>
                        <div class="passenger-box">
                            <div class="box-header">Trẻ em <span class="subtext">Từ 2 – 11 tuổi (ưu đãi giảm giá 5%)</span></div>
                            <div class="counter">
                                <button onclick="changeCount('child', -1)">−</button>
                                <span id="child-count">0</span>
                                <button onclick="changeCount('child', 1)">+</button>
                            </div>
                        </div>
                        <div class="passenger-box">
                            <div class="box-header">Em bé <span class="subtext">Dưới 2 tuổi (ưu đãi giảm giá 20%)</span></div>
                            <div class="counter">
                                <button onclick="changeCount('baby', -1)">−</button>
                                <span id="baby-count">0</span>
                                <button onclick="changeCount('baby', 1)">+</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="note-section" >

                    <label class="note-label"><strong>GHI CHÚ</strong></label>
                    <p class="note-subtext">Quý khách có ghi chú lưu ý gì, hãy nói với chúng tôi</p>
                    <textarea
                        name="note"
                        rows="4"
                        class="note-textarea"
                        placeholder="Vui lòng nhập nội dung lời nhắn..."></textarea>

                </div>




            </div>

            <!--    =====================================================thong tin ben phai            -->
            <div class="right-content">
                <div class="summary-box">
                    <h3>TÓM TẮT CHUYẾN ĐI</h3>

                    <div class="tour-info">
                        <img src="assets/images/places/<%=tour.getImg_Tour()%>" alt="<%=tour.getDestination()%>" />
                        <div class="tour-details">
                            <p class="tour-code">Mã tour <strong><%=tour.getIdTourTicket()%></strong></p>

                            <p><strong><%=tour.getDestination()%>: </strong> <%=tour.getNametour()%></p>


                        </div>
                    </div>
                    <!--============================================================================= CAN DUOC XU LY
                    =============================================================================-->
                    <%
                        String startDateStr = stDate.getStartDate();
                        LocalDate startDate = LocalDate.parse(startDateStr, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                        LocalDate endDate;
                        String duration = tour.getDuration();
                        
                        if("2 ngày 1 đêm".equals(duration)){
                            endDate = startDate.plusDays(2);
                        } else {
                            endDate = startDate.plusDays(3);
                        }
                        String endDateStr = endDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                         //láy ra ngày dat
                        LocalDate today = LocalDate.now();
                        String todayStr = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
               
                    %>


                    <div class="flight-info">
                        <div>
                            <p><strong>Ngày đi: <%=stDate.getStartDate()%></strong></p>
                        </div>
                        <div>
                            <p><strong>Ngày về: <%=endDateStr%></strong></p>
                        </div>
                    </div>

                    <div class="price-breakdown">
                        <div class="section-title">👥 KHÁCH HÀNG + PHỤ THU <span class="price">...</span></div>

                        <div class="line-item" id="adult-line">
                            <span>Người lớn</span>
                            <span id="adult-line-value">1 x ... đ</span>
                        </div>

                        <div class="line-item" id="child-line" style="display: none;">
                            <span>Trẻ em</span>
                            <span id="child-line-value">...</span>
                        </div>

                        <div class="line-item" id="baby-line" style="display: none;">
                            <span>Em bé</span>
                            <span id="baby-line-value">...</span>
                        </div>

                        <div class="line-item">
                            <span>Phụ thu phòng đơn</span>
                            <span>0 đ</span>
                        </div>

                        <div class="line-item">
                            <span>Tổng giá trị ưu đãi</span>
                            <span id="price_down">...</span>
                        </div>
                    </div>


                    <div class="discount-section">
                        <div class="section-title">🏷️ MÃ GIẢM GIÁ</div>
                        <button class="btn-add-discount">+ Thêm mã giảm giá</button>
                    </div>

                    <div class="total">
                        <p>Tổng tiền</p>
                        <p class="total-amount">0 đ</p>
                    </div>

                    <form action="orderController" method="get" onsubmit="return prepareSubmit()">
                        <input type="hidden" name="action" value="call_oder_step2">

                        <!-- gửi thông tin để tạo dtb booking table -->
                        <input type="hidden" name="startNum" value="<%=stDate.getStartNum()%>">
                        <input type="hidden" name="idUser" value="<%=account.getIdUser()%>">
                        <input type="hidden" name="idTour" value="<%=tour.getIdTourTicket()%>">
                        <input type="hidden" name="bookingDate" value="<%=today%>">
                        <input type="hidden" id="totalBill" name="totalBill" value="">
                        <input type="hidden" id="numberTicket" name="numberTicket" value="">
                        <input type="hidden" id="noteValueInput" name="noteValueInput" value="">
                        <input type="hidden" name="status" value="0">


                        <button class="btn-submit" style="submit">Ðặt tour</button>
                    </form>



                    <!-- =============================================================================
                    =============================================================================                   -->

                </div>

            </div>
        </div>
    </div>
    <%@include file="footer.jsp" %>


    <script>
        // Lấy giá tour từ server (giá một vé người lớn)
        const pricePerAdult = <%= tour.getPrice() %>;

        // Các mức giảm giá cho trẻ em và em bé
        const discountChild = 0.05; // Giảm 5% cho trẻ em (2–11 tuổi)
        const discountBaby = 0.20;  // Giảm 20% cho em bé (< 2 tuổi)

        /**
         * Hàm thay đổi số lượng hành khách theo loại (adult, child, baby)
         * delta: +1 hoặc -1
         */
        
        /**
         * Hàm cập nhật tổng tiền, số lượng vé và ghi chú ẩn gửi server
         */
        function updateTotal() {
            // Đọc số lượng từng loại hành khách
            const adultCount = parseInt(document.getElementById("adult-count").innerText);
            const childCount = parseInt(document.getElementById("child-count").innerText);
            const babyCount = parseInt(document.getElementById("baby-count").innerText);
            const totalCount = adultCount + childCount + babyCount;

            // Lấy giá trị ghi chú từ textarea
            const noteTextarea = document.querySelector('textarea[name="note"]');
            const noteValue = noteTextarea.value;

            // Tính tổng tiền từng nhóm sau khi áp dụng giảm giá
            const totalAdult = adultCount * pricePerAdult;
            const totalChild = childCount * pricePerAdult * (1 - discountChild);
            const totalBaby = babyCount * pricePerAdult * (1 - discountBaby);

            const total = totalAdult + totalChild + totalBaby;

            // Gán giá trị ẩn cho form gửi server
            document.getElementById("totalBill").value = Math.floor(total);
            document.getElementById("numberTicket").value = totalCount;
            document.getElementById("noteValueInput").value = noteValue;

            // Tính tổng tiền được giảm (ví dụ cho hiển thị)
            const totalChild_down = childCount * pricePerAdult * discountChild;
            const totalBaby_down = babyCount * pricePerAdult * discountBaby;
            const total_down = totalChild_down + totalBaby_down + 1000000; // Giả định thêm mã giảm giá 1 triệu

            // Cập nhật giao diện hiển thị
            document.querySelector(".total-amount").innerText = formatCurrency(total);
            document.getElementById("price_down").innerText = formatCurrency(total_down);

            document.getElementById("adult-line-value").innerText = adultCount + " x " + formatCurrency(pricePerAdult);
            document.getElementById("child-line-value").innerText = childCount + " x " + formatCurrency(pricePerAdult * (1 - discountChild));
            document.getElementById("baby-line-value").innerText = babyCount + " x " + formatCurrency(pricePerAdult * (1 - discountBaby));

            // Hiển thị hoặc ẩn dòng trẻ em và em bé tùy số lượng
            document.getElementById("child-line").style.display = childCount > 0 ? "flex" : "none";
            document.getElementById("baby-line").style.display = babyCount > 0 ? "flex" : "none";
        }

        /**
         * Hàm định dạng số thành chuỗi tiền tệ Việt Nam
         */
        function formatCurrency(amount) {
            return amount.toLocaleString("vi-VN", {
                style: "currency",
                currency: "VND"
            });
        }

        // Khi trang tải xong:
        document.addEventListener("DOMContentLoaded", function () {
            updateTotal(); // Cập nhật tổng tiền lúc đầu

            // Lắng nghe sự kiện nhập liệu ở ô ghi chú để cập nhật input ẩn ngay lập tức
            const noteTextarea = document.querySelector('textarea[name="note"]');
            noteTextarea.addEventListener('input', function () {
                document.getElementById("noteValueInput").value = noteTextarea.value;
            });
        });
        
        
        //hàm check sao cho không vượt quá quantity
        function changeCount(type, delta) {
        const id = type + '-count';
        const countElem = document.getElementById(id);
        let count = parseInt(countElem.innerText);

        // Tổng số vé hiện tại
        const adultCount = parseInt(document.getElementById("adult-count").innerText);
        const childCount = parseInt(document.getElementById("child-count").innerText);
        const babyCount = parseInt(document.getElementById("baby-count").innerText);
        const totalCurrent = adultCount + childCount + babyCount;

        // Nếu tăng và đã đủ 20 vé, thì không cho tăng
        if (delta > 0 && totalCurrent >= <%=stDate.getQuantity()%>) {
            alert("Tổng số vé không được vượt quá <%=stDate.getQuantity()%>!");
            return;
        }

        // Giảm nhưng không được nhỏ hơn 0
        count = Math.max(0, count + delta);
        countElem.innerText = count;

        updateTotal();
        }

        
    </script>





</body>
</html>
