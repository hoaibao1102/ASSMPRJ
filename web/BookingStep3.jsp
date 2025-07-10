<%-- 
    Document   : BookingStep3
    Created on : May 30, 2025, 3:57:52 PM
    Author     : Admin
--%>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="DTO.TourTicketDTO" %>
<%@ page import="DTO.StartDateDTO" %>
<%@ page import="DTO.UserDTO" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hoàn tất thanh toán</title>
        
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        
        <style>
            :root {
                --primary-blue: #0EA5E9;      /* Xanh biển Việt Nam */
                --primary-orange: #FF6B35;    /* Cam nhiệt đới */
                --primary-green: #10B981;     /* Xanh lá nhiệt đới */
                --secondary-yellow: #F59E0B; /* Vàng ánh dương */
                --secondary-purple: #8B5CF6; /* Tím lavender */
                --pearl-white: #FEFEFE;       /* Trắng ngọc trai */
                --text-main: #1F2937;        /* Text chính */
                --text-secondary: #6B7280;   /* Text phụ */
                
                --gradient-main: linear-gradient(135deg, var(--primary-blue), var(--primary-green));
                --gradient-secondary: linear-gradient(135deg, var(--primary-orange), var(--secondary-yellow));
            }
            
            * {
                font-family: 'Poppins', sans-serif;
            }
            
            body {
                padding-top: 100px;
                background: #f8f9fa;
                color: #333;
                line-height: 1.6;
            }
            
            /* Step Progress Section */
            .step-container {
                background: white;
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.1);
                padding: 2rem;
                margin: 0;
                position: relative;
                overflow: hidden;
            }
            
            .step-container::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 100" fill="white" opacity="0.1"><polygon points="0,0 1000,0 1000,100 0,80"/></svg>');
                background-size: cover;
            }
            
            .step-title {
                color: var(--text-main);
                font-weight: bold;
                text-align: center;
                margin-bottom: 40px;
                position: relative;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
            }
            
            .step-tracker {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 40px;
                position: relative;
                z-index: 2;
            }
            
            .step {
                display: flex;
                flex-direction: column;
                align-items: center;
                text-align: center;
                transition: all 0.3s ease;
            }
            
            .step.active .icon {
                background: linear-gradient(45deg, #10B981, #34D399);
                transform: scale(1.1);
                box-shadow: 0 8px 25px rgba(46, 204, 113, 0.4);
            }
            
            .step.current .icon {
                background: var(--gradient-secondary);
                transform: scale(1.15);
                box-shadow: 0 10px 30px rgba(255, 107, 53, 0.5);
                animation: pulse 2s infinite;
            }
            
            .step .icon {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                background: #6c757d;
                transition: all 0.3s ease;
                margin-bottom: 15px;
            }
            
            .step .icon img {
                width: 40px;
                height: 40px;
                filter: brightness(0) invert(1);
            }
            
            @keyframes pulse {
                0%, 100% { transform: scale(1.15); }
                50% { transform: scale(1.25); }
            }
            
            .arrow {
                font-size: 24px;
                color: var(--primary-orange);
                font-weight: bold;
            }
            
            /* Main Content */
            .content {
                padding: 60px 0;
            }
            
            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 20px;
            }
            
            .success-card {
                background: white;
                border-radius: 20px;
                padding: 40px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                border: 1px solid rgba(14, 165, 233, 0.1);
                position: relative;
                overflow: hidden;
            }
            
            .success-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 5px;
                background: var(--gradient-main);
            }
            
            .success-header {
                text-align: center;
                margin-bottom: 40px;
            }
            
            .success-icon {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                background: var(--primary-green);
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 20px;
                color: white;
                font-size: 40px;
                box-shadow: 0 10px 30px rgba(39, 174, 96, 0.3);
                animation: successPulse 2s ease-in-out infinite;
            }
            
            @keyframes successPulse {
                0%, 100% { transform: scale(1); }
                50% { transform: scale(1.05); }
            }
            
            .success-title {
                font-size: 2rem;
                font-weight: 700;
                color: var(--primary-green);
                margin-bottom: 15px;
            }
            
            .success-subtitle {
                color: #666;
                font-size: 1.1rem;
                line-height: 1.8;
            }
            
            .info-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 25px;
                margin-top: 40px;
            }
            
            .info-item {
                background: #f8f9fa;
                padding: 20px;
                border-radius: 12px;
                border-left: 4px solid var(--primary-orange);
                transition: all 0.3s ease;
            }
            
            .info-item:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            }
            
            .info-label {
                font-size: 0.9rem;
                color: #666;
                font-weight: 500;
                margin-bottom: 8px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }
            
            .info-value {
                font-size: 1.1rem;
                font-weight: 600;
                color: var(--text-primary);
            }
            
            .info-value.highlight {
                color: var(--primary-orange);
                font-size: 1.3rem;
            }
            
            .tour-card {
                background: white;
                border-radius: 20px;
                padding: 30px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                border: 1px solid rgba(255, 107, 53, 0.1);
                position: relative;
                overflow: hidden;
            }
            
            .tour-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 5px;
                background: var(--gradient-secondary);
            }
            
            .tour-card h3 {
                color: var(--text-primary);
                font-weight: 700;
                margin-bottom: 25px;
                font-size: 1.4rem;
            }
            
            .tour-image {
                width: 100%;
                height: 200px;
                object-fit: cover;
                border-radius: 15px;
                margin-bottom: 20px;
                transition: transform 0.3s ease;
            }
            
            .tour-image:hover {
                transform: scale(1.05);
            }
            
            .tour-info {
                margin-bottom: 20px;
            }
            
            .tour-info p {
                margin-bottom: 12px;
                color: #555;
            }
            
            .tour-info strong {
                color: var(--text-primary);
                font-weight: 600;
            }
            
            .tour-details {
                background: #fff8f0;
                padding: 20px;
                border-radius: 12px;
                margin: 20px 0;
            }
            
            .tour-details h4 {
                color: var(--primary-orange);
                font-weight: 600;
                margin-bottom: 15px;
                font-size: 1.1rem;
            }
            
            .divider {
                height: 1px;
                background: linear-gradient(to right, transparent, #ddd, transparent);
                margin: 25px 0;
            }
            
            .total-price {
                text-align: center;
                padding: 20px;
                background: var(--gradient-secondary);
                border-radius: 15px;
                margin-bottom: 25px;
            }
            
            .total-label {
                color: white;
                font-size: 0.9rem;
                font-weight: 500;
                margin-bottom: 8px;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            
            .total-amount {
                color: white;
                font-size: 1.8rem;
                font-weight: 700;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
            }
            
            .btn-primary-custom {
                background: var(--gradient-secondary);
                border: none;
                padding: 15px 30px;
                border-radius: 50px;
                font-size: 1rem;
                font-weight: 600;
                color: white;
                text-decoration: none;
                display: inline-block;
                text-align: center;
                transition: all 0.3s ease;
                box-shadow: 0 5px 20px rgba(255, 107, 53, 0.3);
                letter-spacing: 0.5px;
                text-transform: uppercase;
            }
            
            .btn-primary-custom:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(255, 107, 53, 0.4);
                color: white;
            }
            
            .btn-secondary-custom {
                background: var(--gradient-main);
                border: none;
                padding: 15px 30px;
                border-radius: 50px;
                font-size: 1rem;
                font-weight: 600;
                color: white;
                text-decoration: none;
                display: inline-block;
                text-align: center;
                transition: all 0.3s ease;
                box-shadow: 0 5px 20px rgba(14, 165, 233, 0.3);
                letter-spacing: 0.5px;
                text-transform: uppercase;
            }
            
            .btn-secondary-custom:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(14, 165, 233, 0.4);
                color: white;
            }
            
            /* Responsive Design */
            @media (max-width: 768px) {
                .step-tracker {
                    gap: 40px;
                }
                
                .step .icon {
                    width: 60px;
                    height: 60px;
                }
                
                .step .icon i {
                    font-size: 24px;
                }
                
                .step-title {
                    font-size: 2rem;
                }
                
                .arrow {
                    font-size: 20px;
                }
                
                .info-grid {
                    grid-template-columns: 1fr;
                    gap: 20px;
                }
                
                .success-card,
                .tour-card {
                    padding: 25px;
                }
            }
        </style>
    </head>
    <body>
        <%
            UserDTO account = (UserDTO) session.getAttribute("nameUser");
            TourTicketDTO tour = (TourTicketDTO) session.getAttribute("tourTicket");
            
            // Xử lý dữ liệu null
            double total = 0;
            if (request.getAttribute("total") != null) {
                total = Double.parseDouble(request.getAttribute("total").toString());
            }
            
            int numberTicket = 0;
            if (request.getAttribute("numberTicket") != null) {
                numberTicket = Integer.parseInt(request.getAttribute("numberTicket").toString());
            }
            
            String idBooking = "BK" + System.currentTimeMillis(); // Tạo mã booking nếu không có
            if (request.getAttribute("idBooking") != null) {
                idBooking = request.getAttribute("idBooking").toString();
            }
            
            LocalDate today = LocalDate.now();
            String todayStr = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            
            // Xử lý ngày bắt đầu
            StartDateDTO stDate = (StartDateDTO) session.getAttribute("stDate");
            LocalDate startDate = null;
            LocalDate endDate = null;
            String startDateStr = "";
            String endDateStr = "";
            
            if (stDate != null && stDate.getStartDate() != null) {
                startDateStr = stDate.getStartDate();
                startDate = LocalDate.parse(startDateStr, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                
                // Tính ngày kết thúc dựa trên duration
                if ("2 ngày 1 đêm".equals(tour.getDuration())) {
                    endDate = startDate.plusDays(2);
                } else {
                    endDate = startDate.plusDays(3);
                }
                endDateStr = endDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            }
        %>
        
        <%@include file="header.jsp" %>
        
        <!-- Step Progress Section -->
        <div class="step-container">
            <div class="container">
                <h2 class="step-title">
                    <i class="fas fa-map-marked-alt me-3"></i>
                    ĐẶT TOUR
                </h2>
                <div class="step-tracker">
                    <div class="step active">
                        <div class="icon">
                            <img src="assets/images/icon/icon_fillfile.jpg" alt="info" />
                        </div>
                        <div class="label">NHẬP THÔNG TIN</div>
                    </div>
                    
                    <div class="arrow">➜</div>
                    
                    <div class="step active">
                        <div class="icon">
                            <img src="assets/images/icon/icon_thanhtoan.jpg" alt="pay" />
                        </div>
                        <div class="label">THANH TOÁN</div>
                    </div>
                    
                    <div class="arrow">➜</div>
                    
                    <div class="step current">
                        <div class="icon">
                            <img src="assets/images/icon/icon_done.jpg" alt="done" />
                        </div>
                        <div class="label">HOÀN TẤT</div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Main Content -->
        <div class="content">
            <div class="container">
                <div class="row g-4">
                    <!-- Left Column - Success Information -->
                    <div class="col-lg-7">
                        <div class="success-card">
                            <div class="success-header">
                                <div class="success-icon">
                                    <i class="fas fa-check"></i>
                                </div>
                                <h2 class="success-title">Thanh toán thành công!</h2>
                                <div class="success-subtitle">
                                    <strong>Cảm ơn bạn đã đặt tour tại VN Tours.</strong><br>
                                    Thông tin booking của bạn đã được xác nhận.<br>
                                    Chúng tôi đã gửi email xác nhận đến: <span style="color: var(--primary-orange); font-weight: 600;"><%= account != null ? account.getEmail() : "email@example.com" %></span>
                                </div>
                            </div>
                            
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <div class="info-label">
                                            <i class="fas fa-ticket-alt me-2"></i>
                                            Mã đặt chỗ
                                        </div>
                                        <div class="info-value highlight"><%= idBooking %></div>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <div class="info-label">
                                            <i class="fas fa-calendar-alt me-2"></i>
                                            Ngày tạo
                                        </div>
                                        <div class="info-value"><%= todayStr %></div>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <div class="info-label">
                                            <i class="fas fa-user me-2"></i>
                                            Khách hàng
                                        </div>
                                        <div class="info-value"><%= account != null ? account.getFullName() : "Khách hàng" %></div>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <div class="info-label">
                                            <i class="fas fa-phone me-2"></i>
                                            Điện thoại
                                        </div>
                                        <div class="info-value"><%= account != null ? account.getPhone() : "Số điện thoại" %></div>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <div class="info-label">
                                            <i class="fas fa-money-bill-wave me-2"></i>
                                            Trị giá booking
                                        </div>
                                        <div class="info-value highlight"><%= new DecimalFormat("#,###").format(total) %> đ</div>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <div class="info-label">
                                            <i class="fas fa-check-circle me-2"></i>
                                            Tình trạng
                                        </div>
                                        <div class="info-value status">ĐÃ THANH TOÁN ĐẦY ĐỦ</div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mt-4 text-center">
                                <a href="placeController?action=destination&page=indexjsp" class="btn-primary-custom w-100">
                                    <i class="fas fa-home me-2"></i>
                                    Về trang chủ
                                </a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Right Column - Tour Confirmation -->
                    <div class="col-lg-5">
                        <%
                            String tourImage = tour != null ? tour.getImg_Tour() : "default.jpg";
                        %>
                        
                        <div class="tour-card">
                            <h3>
                                <i class="fas fa-file-invoice me-2"></i>
                                PHIẾU XÁC NHẬN BOOKING
                            </h3>
                            
                            <img src="assets/images/places/<%= tourImage %>" alt="Tour" class="tour-image">
                            
                            <div class="tour-info">
                                <p><strong><i class="fas fa-map-marker-alt me-2"></i><%= tour != null ? tour.getDestination() : "" %>:</strong> <%= tour != null ? tour.getNametour() : "" %></p>
                                <p><strong><i class="fas fa-code me-2"></i>Mã tour:</strong> <%= tour != null ? tour.getIdTourTicket() : "" %></p>
                            </div>
                            
                            <div class="tour-details">
                                <h4>
                                    <i class="fas fa-suitcase-rolling me-2"></i>
                                    THÔNG TIN CHUYẾN ĐI
                                </h4>
                                <p>
                                    <i class="fas fa-plane-departure me-2"></i>
                                    <strong>Ngày đi:</strong> <%= startDateStr %>
                                </p>
                                <p>
                                    <i class="fas fa-plane-arrival me-2"></i>
                                    <strong>Ngày về:</strong> <%= endDateStr %>
                                </p>
                            </div>
                            
                            <div class="divider"></div>
                            
                            <div class="total-price">
                                <div class="total-label">
                                    <i class="fas fa-receipt me-2"></i>
                                    TỔNG TIỀN ĐÃ THANH TOÁN
                                </div>
                                <div class="total-amount"><%= new DecimalFormat("#,###").format(total) %> đ</div>
                            </div>
                            
                            <a href="placeController?action=destination&page=destinationjsp" class="btn-secondary-custom w-100">
                                <i class="fas fa-search me-2"></i>
                                Tiếp tục khám phá tour khác
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <%@include file="footer.jsp" %>
        
        <!-- Bootstrap 5 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>