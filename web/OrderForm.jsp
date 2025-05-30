<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Đặt Tour</title>
    <meta charset="UTF-8">
    <style>
        body { font-family: Arial, sans-serif; background: #fff; }
        .container-main { 
            display: flex; 
            justify-content: center;
            align-items: flex-start; 
            gap: 30px; 
            max-width: 1200px; 
            margin: 30px auto;
        }
        .container-form { 
            background: #fff; 
            padding: 40px 30px; 
            border-radius: 10px; 
            box-shadow: 0 4px 20px rgba(0,0,0,0.06);
            max-width: 520px;
            flex: 1 1 520px;
        }
        .step-bar { display: flex; justify-content: center; margin-bottom: 40px; }
        .step { text-align: center; width: 180px; color: #bbb; }
        .step.active { color: #1976d2; }
        .step .circle { width: 40px; height: 40px; margin: 0 auto 8px; border-radius: 50%; background: #eee; display: flex; align-items: center; justify-content: center; font-size: 22px;}
        .step.active .circle { background: #1976d2; color: #fff; }
        .arrow { font-size: 22px; margin: 0 14px; color: #bbb; align-self: center; }
        h2 { text-align: center; color: #1765b2; margin-bottom: 30px; }
        .form-row { display: flex; justify-content: space-between; margin-bottom: 30px; }
        .form-group { flex: 1; margin-right: 30px; }
        .form-group:last-child { margin-right: 0; }
        label { font-weight: 600; margin-bottom: 8px; display: block; }
        input, textarea { width: 100%; padding: 9px 10px; border: 1px solid #ccc; border-radius: 5px; }
        .required { color: #d32f2f; }
        .guest-box { display: flex; gap: 20px; margin-bottom: 30px; }
        .guest-type { border: 1px solid #ccc; padding: 15px 20px; border-radius: 8px; flex: 1; display: flex; align-items: center; justify-content: space-between; }
        .guest-label { font-weight: 600; }
        .guest-controls { display: flex; align-items: center; }
        .guest-btn { width: 30px; height: 30px; border: none; background: #e3e9f6; color: #1976d2; font-size: 22px; border-radius: 50%; cursor: pointer; }
        .summary { background: #f9fbfd; border: 1px solid #e3e9f6; border-radius: 8px; padding: 25px; margin-bottom: 20px; }
        .summary-title { font-weight: bold; color: #1976d2; margin-bottom: 10px; }
        .total { font-size: 20px; margin-top: 10px; }
        .btn-main { background: #d32f2f; color: #fff; border: none; padding: 12px 30px; border-radius: 5px; font-size: 16px; cursor: pointer; }
        .btn-main:hover { background: #b71c1c; }
        /* --- Tóm tắt chuyến đi --- */
        .box-summary-tour {
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 2px 12px #0002;
            padding: 22px 18px 18px 18px;
            min-width: 370px;
            max-width: 400px;
        }
        .summary-tour-title { font-size: 20px; font-weight: bold; margin-bottom: 13px; }
        .summary-tour-img { width: 100%; border-radius: 7px; margin-bottom: 10px; }
        .summary-tourname { margin-bottom: 10px; }
        .summary-tourcode { font-size:13px; color: #444; margin-bottom: 10px; }
        .summary-flight { margin: 10px 0; font-size: 15px; }
        .flight-row { display: flex; justify-content: space-between; gap: 14px; }
        .flight-col { width: 49%; }
        .summary-section { font-size: 15px; margin-bottom: 9px; }
        .summary-money { color: #d32f2f; float: right; }
        .summary-total-row { display: flex; justify-content: space-between; align-items: center; font-size: 18px; margin: 12px 0 8px 0;}
        .summary-total { color: #d32f2f; font-size: 23px; font-weight: bold;}
        .summary-btn { width: 100%; margin-top: 10px; background: #d32f2f; color: #fff; border: none; padding: 14px 0; border-radius: 7px; font-size: 18px; font-weight: bold; cursor: pointer;}
        .summary-support { display: flex; gap: 10px; margin-top: 12px;}
        .support-btn { flex: 1; background: #2176c1; color: #fff; border: none; border-radius: 5px; padding: 8px 0; font-size: 15px;}
        hr { border: none; border-top: 1px solid #efefef; margin: 9px 0; }
        .discount-badge {color: #d32f2f; font-size: 15px; cursor: pointer;}
        @media (max-width: 1000px) {
            .container-main { flex-direction: column; gap: 0;}
            .container-form { max-width:100%; margin-bottom: 30px;}
            .box-summary-tour {margin: 0 auto;}
        }
    </style>
    <script>
        function updateGuest(type, delta) {
            var input = document.getElementById(type);
            var value = parseInt(input.value) + delta;
            if (value < 0) value = 0;
            input.value = value;
            calcTotal();
            updateSummaryGuest();
        }
        function calcTotal() {
            var adults = parseInt(document.getElementById('adults').value) || 0;
            var children = parseInt(document.getElementById('children').value) || 0;
            var price = 24990000; // Giá người lớn
            var childPrice = 0; // Cập nhật đúng nếu có giá trẻ nhỏ
            var mainTotal = adults * price + children * childPrice;
            var discount = adults * 800000; // Ưu đãi
            var total = mainTotal - discount;
            document.getElementById('total').innerText = total.toLocaleString('vi-VN') + " đ";
            document.getElementById('summary-total').innerText = total.toLocaleString('vi-VN') + " đ";
            document.getElementById('summary-adults').innerText = adults + " x 24.990.000 đ";
            document.getElementById('summary-discount-adults').innerText = adults + " x 800.000 đ";
            document.getElementById('summary-money-main').innerText = (adults * price).toLocaleString('vi-VN') + " đ";
            document.getElementById('summary-money-discount').innerText = (adults * 800000).toLocaleString('vi-VN') + " đ";
        }
        function updateSummaryGuest() {
            // Nếu có thêm các loại khách khác, cập nhật tại đây
        }
        window.onload = calcTotal;
    </script>
</head>
<body>
<div class="container-main">
    <div class="container-form">
        <h2>ĐẶT TOUR</h2>
        <div class="step-bar">
            <div class="step active"><div class="circle">1</div>NHẬP THÔNG TIN</div>
            <div class="arrow">&#8594;</div>
            <div class="step"><div class="circle">2</div>THANH TOÁN</div>
            <div class="arrow">&#8594;</div>
            <div class="step"><div class="circle">3</div>HOÀN TẤT</div>
        </div>
        <form>
            <div class="form-row">
                <div class="form-group">
                    <label>Họ tên <span class="required">*</span></label>
                    <input type="text" value="Doan Dinh Huy (K18 HCM)" required>
                </div>
                <div class="form-group">
                    <label>Điện thoại <span class="required">*</span></label>
                    <input type="tel" placeholder="Nhập số điện thoại" required>
                    <div style="color:#d32f2f;font-size:13px;margin-top:4px;">Thông tin bắt buộc</div>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>Email <span class="required">*</span></label>
                    <input type="email" value="huyddse180414@fpt.edu.vn" required>
                </div>
                <div class="form-group">
                    <label>Địa chỉ</label>
                    <input type="text" placeholder="Nhập địa chỉ">
                </div>
            </div>
            <div style="font-weight:bold;margin-bottom:15px;">HÀNH KHÁCH</div>
            <div class="guest-box">
                <div class="guest-type">
                    <div>
                        <div class="guest-label">Người lớn</div>
                        <div style="font-size:12px;">Từ 12 tuổi</div>
                    </div>
                    <div class="guest-controls">
                        <button type="button" class="guest-btn" onclick="updateGuest('adults', -1)">-</button>
                        <input id="adults" type="text" value="1" style="width:35px;text-align:center;margin: 0 7px;" readonly>
                        <button type="button" class="guest-btn" onclick="updateGuest('adults', 1)">+</button>
                    </div>
                </div>
                <div class="guest-type">
                    <div>
                        <div class="guest-label">Trẻ nhỏ</div>
                        <div style="font-size:12px;">Từ 2 - 4 tuổi</div>
                    </div>
                    <div class="guest-controls">
                        <button type="button" class="guest-btn" onclick="updateGuest('children', -1)">-</button>
                        <input id="children" type="text" value="0" style="width:35px;text-align:center;margin: 0 7px;" readonly>
                        <button type="button" class="guest-btn" onclick="updateGuest('children', 1)">+</button>
                    </div>
                </div>
            </div>
            <div class="summary">
                <div class="summary-title">MÃ GIẢM GIÁ</div>
                <input type="text" placeholder="Nhập mã nếu có" style="width:200px;">
                <div class="total">Tổng tiền: <span id="total">0 đ</span></div>
            </div>
            <button type="submit" class="btn-main">Nhập thông tin để đặt tour</button>
        </form>
    </div>
    <!-- Tóm tắt chuyến đi -->
    <div class="box-summary-tour">
        <div class="summary-tour-title">TÓM TẮT CHUYẾN ĐI</div>
        <img class="summary-tour-img" src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=600" alt="tour">
        <div class="summary-tourname">
            <b>Trung Quốc: Thượng Hải - Chu Gia Giác - Bắc Kinh - Chinh phục Vạn Lý Trường Thành</b>
        </div>
        <div class="summary-tourcode">Mã tour <b>NNSGN320-018-160625VN-D</b></div>
        <hr>
        <div class="summary-flight">
            <b>&#9992; THÔNG TIN CHUYẾN BAY</b>
            <div class="flight-row">
                <div class="flight-col">
                    <div><b>Ngày đi - 16/06/2025</b></div>
                    <div>07:20 <img src="https://upload.wikimedia.org/wikipedia/commons/0/09/Vietnam_Airlines_logo.svg" height="14" style="vertical-align:middle;"> SGN &rarr; PVG 12:40</div>
                </div>
                <div class="flight-col">
                    <div><b>Ngày về - 21/06/2025</b></div>
                    <div>15:45 <img src="https://upload.wikimedia.org/wikipedia/commons/0/09/Vietnam_Airlines_logo.svg" height="14" style="vertical-align:middle;"> PEK &rarr; SGN 23:10</div>
                </div>
            </div>
        </div>
        <hr>
        <div class="summary-section">
            <b>&#128101; KHÁCH HÀNG + PHỤ THU <span class="summary-money" id="summary-money-main">24.990.000 đ</span></b>
            <div>Người lớn <span style="float:right" id="summary-adults">1 x 24.990.000 đ</span></div>
            <div>Phụ thu phòng đơn <span style="float:right">0 đ</span></div>
        </div>
        <div class="summary-section">
            <b>&#127873; ƯU ĐÃI ĐẶT ONLINE <span class="summary-money" id="summary-money-discount">800.000 đ</span></b>
            <div>Người lớn <span style="float:right" id="summary-discount-adults">1 x 800.000 đ</span></div>
        </div>
        <div class="summary-section">
            <b>&#128273; MÃ GIẢM GIÁ</b> <span class="discount-badge">+ Thêm mã giảm giá</span>
        </div>
        <div class="summary-total-row">
            <div><b>Tổng tiền</b></div>
            <div class="summary-total" id="summary-total">24.190.000 đ</div>
        </div>
        <button class="summary-btn" type="button">Nhập thông tin để đặt tour</button>
        <div class="summary-support">
            <button type="button" class="support-btn">&#128222; Gọi miễn phí qua internet</button>
            <button type="button" class="support-btn">&#128172; Liên hệ tư vấn</button>
        </div>
    </div>
</div>
</body>
</html>