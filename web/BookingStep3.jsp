<%-- 
    Document   : BookingStep3
    Created on : May 30, 2025, 3:57:52 PM
    Author     : Admin
--%>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="DTO.TourTicketDTO"%>
<%@ page import="DTO.StartDateDTO"%>
<%@ page import="DTO.UserDTO"%>
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
        
        <link rel="stylesheet" href="assets/css/bodyCss.css"/>
        
        <style>
            :root {
                --primary-orange: #ff6b35;
                --primary-blue: #2c3e50;
                --accent-yellow: #f39c12;
                --bg-light: #f8f9fa;
                --success-green: #27ae60;
                --gradient-tropical: linear-gradient(135deg, #ff6b35 0%, #f39c12 100%);
                --gradient-ocean: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
                --shadow-soft: 0 8px 25px rgba(0, 0, 0, 0.1);
                --shadow-hover: 0 12px 35px rgba(0, 0, 0, 0.15);
            }
            
            * {
                font-family: 'Poppins', sans-serif;
            }
            
            body {
                background: var(--bg-light);
                color: #333;
                line-height: 1.6;
            }

            /* Step Progress Tracker */
            .step-container {
                background: linear-gradient(135deg, #ff6b35 0%, #f39c12 50%, #2c3e50 100%);
                padding: 60px 0;
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
                color: white;
                font-size: 2.5rem;
                font-weight: 700;
                text-align: center;
                margin-bottom: 40px;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
                position: relative;
                z-index: 2;
            }
            
            .step-tracker {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 80px;
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
            
            .step .icon {
                width: 70px;
                height: 70px;
                border-radius: 50%;
                display: flex;
                justify-content: center;
                align-items: center;
                margin-bottom: 15px;
                background: rgba(255, 255, 255, 0.2);
                border: 3px solid rgba(255, 255, 255, 0.3);
                backdrop-filter: blur(10px);
                transition: all 0.3s ease;
            }
            
            .step .icon i {
                font-size: 28px;
                color: rgba(255, 255, 255, 0.7);
            }
            
            .step .label {
                font-size: 14px;
                color: rgba(255, 255, 255, 0.8);
                font-weight: 600;
                letter-spacing: 0.5px;
            }
            
            .step.active .icon {
                background: var(--success-green);
                border-color: var(--success-green);
                transform: scale(1.1);
                box-shadow: 0 5px 20px rgba(39, 174, 96, 0.4);
            }
            
            .step.active .icon i {
                color: white;
            }
            
            .step.active .label {
                color: white;
                font-weight: 700;
            }
            
            .step.current .icon {
                background: var(--accent-yellow);
                border-color: var(--accent-yellow);
                transform: scale(1.2);
                box-shadow: 0 8px 25px rgba(243, 156, 18, 0.5);
                animation: pulse 2s infinite;
            }
            
            .step.current .icon i {
                color: white;
            }
            
            .step.current .label {
                color: white;
                font-weight: 700;
            }
            
            @keyframes pulse {
                0% { box-shadow: 0 8px 25px rgba(243, 156, 18, 0.5); }
                50% { box-shadow: 0 8px 35px rgba(243, 156, 18, 0.8); }
                100% { box-shadow: 0 8px 25px rgba(243, 156, 18, 0.5); }
            }
            
            .arrow {
                font-size: 24px;
                color: rgba(255, 255, 255, 0.6);
                font-weight: bold;
            }

            /* Main Content */
            .content {
                padding: 60px 0;
            }
            
            .containerdetail {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 20px;
            }
            
            .success-card {
                background: white;
                border-radius: 20px;
                padding: 40px;
                box-shadow: var(--shadow-soft);
                border: 1px solid rgba(255, 107, 53, 0.1);
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
                background: var(--gradient-tropical);
            }
            
            .success-header {
                text-align: center;
                margin-bottom: 40px;
            }
            
            .success-icon {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                background: var(--success-green);
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
                color: var(--success-green);
                margin-bottom: 15px;
            }
            
            .success-subtitle {
                color: #666;
                font-size: 1.1rem;
                line-height: 1.8;
            }
            
            .info-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 25px;
                margin-top: 40px;
            }
            
            .info-item {
                background: var(--bg-light);
                padding: 20px;
                border-radius: 12px;
                border-left: 4px solid var(--primary-orange);
                transition: all 0.3s ease;
            }
            
            .info-item:hover {
                transform: translateY(-2px);
                box-shadow: var(--shadow-hover);
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
                color: var(--primary-blue);
            }
            
            .info-value.highlight {
                color: var(--primary-orange);
                font-size: 1.3rem;
            }
            
            .info-value.status {
                color: var(--success-green);
                font-weight: 700;
            }
            
            .tour-card {
                background: white;
                border-radius: 20px;
                padding: 30px;
                box-shadow: var(--shadow-soft);
                border: 1px solid rgba(243, 156, 18, 0.1);
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
                background: var(--gradient-ocean);
            }
            
            .tour-card h3 {
                color: var(--primary-blue);
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
                color: var(--primary-blue);
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
                background: linear-gradient(135deg, #ff6b35, #f39c12);
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
                background: var(--gradient-tropical);
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
                background: var(--gradient-ocean);
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
                box-shadow: 0 5px 20px rgba(44, 62, 80, 0.3);
                letter-spacing: 0.5px;
                text-transform: uppercase;
            }
            
            .btn-secondary-custom:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(44, 62, 80, 0.4);
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
                UserDTO account = (UserDTO)session.getAttribute("nameUser");
                TourTicketDTO tour = (TourTicketDTO)session.getAttribute("tourTicket");
                double total = Double.parseDouble(request.getAttribute("total")+"");
                int numberTicket = Integer.parseInt(request.getAttribute("numberTicket")+"");
                DecimalFormat vnd = new DecimalFormat("#,###");
                String idBooking = request.getAttribute("idBooking")+"";
                LocalDate today = LocalDate.now();
                String todayStr = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                
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
                            <i class="fas fa-edit"></i>
                        </div>
                        <div class="label">NHẬP THÔNG TIN</div>
                    </div>
                    
                    <div class="arrow">➜</div>
                    
                    <div class="step active">
                        <div class="icon">
                            <i class="fas fa-credit-card"></i>
                        </div>
                        <div class="label">THANH TOÁN</div>
                    </div>
                    
                    <div class="arrow">➜</div>
                    
                    <div class="step current">
                        <div class="icon">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div class="label">HOÀN TẤT</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="content">
            <div class="containerdetail">
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
                                    Chúng tôi đã gửi email xác nhận đến: <span style="color: var(--primary-orange); font-weight: 600;"><%=account.getEmail()%></span>
                                </div>
                            </div>
                            
                            <div class="info-grid">
                                <div class="info-item">
                                    <div class="info-label">
                                        <i class="fas fa-ticket-alt me-2"></i>
                                        Mã đặt chỗ
                                    </div>
                                    <div class="info-value highlight"><%=idBooking%></div>
                                </div>
                                
                                <div class="info-item">
                                    <div class="info-label">
                                        <i class="fas fa-calendar-alt me-2"></i>
                                        Ngày tạo
                                    </div>
                                    <div class="info-value"><%=todayStr%></div>
                                </div>
                                
                                <div class="info-item">
                                    <div class="info-label">
                                        <i class="fas fa-user me-2"></i>
                                        Khách hàng
                                    </div>
                                    <div class="info-value"><%=account.getFullName()%></div>
                                </div>
                                
                                <div class="info-item">
                                    <div class="info-label">
                                        <i class="fas fa-phone me-2"></i>
                                        Điện thoại
                                    </div>
                                    <div class="info-value"><%=account.getPhone()%></div>
                                </div>
                                
                                <div class="info-item">
                                    <div class="info-label">
                                        <i class="fas fa-money-bill-wave me-2"></i>
                                        Trị giá booking
                                    </div>
                                    <div class="info-value highlight"><%= vnd.format(total)%> đ</div>
                                </div>
                                
                                <div class="info-item">
                                    <div class="info-label">
                                        <i class="fas fa-check-circle me-2"></i>
                                        Tình trạng
                                    </div>
                                    <div class="info-value status">ĐÃ THANH TOÁN ĐẦY ĐỦ</div>
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
                            StartDateDTO stDate = (StartDateDTO)session.getAttribute("stDate");
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
                        %>
                        
                        <div class="tour-card">
                            <h3>
                                <i class="fas fa-file-invoice me-2"></i>
                                PHIẾU XÁC NHẬN BOOKING
                            </h3>
                            
                            <img src="assets/images/places/<%=tour.getImg_Tour()%>" alt="Tour" class="tour-image">
                            
                            <div class="tour-info">
                                <p><strong><i class="fas fa-map-marker-alt me-2"></i><%=tour.getDestination()%>:</strong> <%=tour.getNametour()%></p>
                                <p><strong><i class="fas fa-code me-2"></i>Mã tour:</strong> <%=tour.getIdTourTicket()%></p>
                            </div>
                            
                            <div class="tour-details">
                                <h4>
                                    <i class="fas fa-suitcase-rolling me-2"></i>
                                    THÔNG TIN CHUYẾN ĐI
                                </h4>
                                <p>
                                    <i class="fas fa-plane-departure me-2"></i>
                                    <strong>Ngày đi:</strong> <%=startDateStr%>
                                </p>
                                <p>
                                    <i class="fas fa-plane-arrival me-2"></i>
                                    <strong>Ngày về:</strong> <%=endDateStr%>
                                </p>
                            </div>
                            
                            <div class="divider"></div>
                            
                            <div class="total-price">
                                <div class="total-label">
                                    <i class="fas fa-receipt me-2"></i>
                                    TỔNG TIỀN ĐÃ THANH TOÁN
                                </div>
                                <div class="total-amount"><%= vnd.format(total)%> đ</div>
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