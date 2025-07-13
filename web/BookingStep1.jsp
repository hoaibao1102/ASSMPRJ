<%-- 
    Document   : BookingStep1
    Created on : May 29, 2025, 11:08:57 PM
    Author     : MSI PC
--%>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<%@ page import="DTO.UserDTO"%>
<%@ page import="UTILS.AuthUtils"%>
<%@ page import="DTO.StartDateDTO"%>
<%@ page import="DTO.TourTicketDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đặt Tour - Nhập Thông Tin</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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
                --shadow-primary: 0 10px 30px rgba(14, 165, 233, 0.2);
                --shadow-secondary: 0 10px 30px rgba(255, 107, 53, 0.2);
            }

            body {
                padding-top: 100px;
                background: var(--pearl-white);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                line-height: 1.6;
            }

            /* Step Progress Bar */
            .step-container {
                background: white;
                border-radius: 20px;
                padding: 2rem;
                margin-bottom: 2rem;
                box-shadow: var(--shadow-primary);
                border: 3px solid var(--primary-blue);
            }

            .step-title {
                font-size: 2.2rem;
                font-weight: 700;
                color: var(--text-main);
                text-align: center;
                margin-bottom: 1.5rem;
                position: relative;
            }

            .step-title::after {
                content: '';
                position: absolute;
                bottom: -10px;
                left: 50%;
                transform: translateX(-50%);
                width: 80px;
                height: 4px;
                background: var(--gradient-main);
                border-radius: 2px;
            }

            .step-tracker {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 2rem;
                flex-wrap: wrap;
            }

            .step {
                display: flex;
                flex-direction: column;
                align-items: center;
                text-align: center;
                transition: all 0.3s ease;
                text-decoration: none;
                color: inherit;
            }

            .step:hover {
                transform: translateY(-5px);
                text-decoration: none;
            }

            .step .icon {
                width: 70px;
                height: 70px;
                border-radius: 50%;
                display: flex;
                justify-content: center;
                align-items: center;
                margin-bottom: 0.8rem;
                background: #e9ecef;
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
            }

            .step .icon::before {
                content: '';
                position: absolute;
                top: 50%;
                left: 50%;
                width: 0;
                height: 0;
                background: var(--gradient-main);
                border-radius: 50%;
                transition: all 0.3s ease;
                transform: translate(-50%, -50%);
            }

            .step.active .icon {
                background: var(--gradient-main);
                box-shadow: var(--shadow-primary);
                transform: scale(1.1);
            }

            .step.active .icon::before {
                width: 100%;
                height: 100%;
            }

            .step .icon i {
                font-size: 1.5rem;
                z-index: 2;
                position: relative;
                color: var(--text-main);
            }

            .step .icon img {
                width: 32px;
                height: 32px;
                z-index: 2;
                position: relative;
            }

            .step .label {
                font-size: 0.9rem;
                font-weight: 600;
                color: var(--text-secondary);
                transition: all 0.3s ease;
            }

            .step.active .label {
                color: var(--primary-orange);
                font-weight: 700;
            }

            .arrow {
                font-size: 1.5rem;
                color: var(--secondary-yellow);
                animation: pulse 2s infinite;
            }

            @keyframes pulse {
                0%, 100% {
                    transform: scale(1);
                }
                50% {
                    transform: scale(1.1);
                }
            }

            /* Main Content */
            .main-container {
                max-width: 1400px;
                margin: 0 auto;
                padding: 0 1rem;
            }

            .content-grid {
                display: grid;
                grid-template-columns: 1fr 400px;
                gap: 2rem;
            }

            @media (max-width: 992px) {
                .content-grid {
                    grid-template-columns: 1fr;

                }
            }

            /* Left Content */
            .left-content {
                background: white;
                border-radius: 20px;
                padding: 2rem;
                box-shadow: var(--shadow-primary);
                position: relative;
                overflow: hidden;
            }

            .left-content::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: var(--gradient-main);
            }

            .section-title {
                font-size: 1.4rem;
                font-weight: 700;
                color: var(--text-main);
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .section-title::before {
                content: '';
                width: 4px;
                height: 24px;
                background: var(--gradient-main);
                border-radius: 2px;
            }


            #discountModal{
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0,0,0,0.4);
                align-items: center;
                justify-content: center;
            }

            .modal-content{
                background-color: #fefefe;
                margin: auto;
                padding: 20px;
                border: 1px solid #888;
                width: 80%;
                max-width: 600px;
                border-radius: 8px;
                position: relative;
            }

            .close-button{
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
                cursor: pointer;
            }

            #discountCodeList{
                max-height: 300px;
                overflow-y: auto;
                margin-top: 15px;
                border-top: 1px solid #eee;
                padding-top: 10px;
            }

            #noVouchersMessage{
                text-align: center;
                color: #666;
                display: none;
            }

            .classbtClose{
                margin-top: 20px;
                text-align: right;
            }

            #btClose{
                padding: 10px 20px;
                background-color: #f44336;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            .form-control {
                border: 2px solid #e9ecef;
                border-radius: 12px;
                padding: 0.75rem 1rem;
                font-size: 0.95rem;
                transition: all 0.3s ease;
            }

            .form-control:focus {
                border-color: var(--primary-blue);
                box-shadow: 0 0 0 0.2rem rgba(14, 165, 233, 0.25);
            }

            .form-label {
                font-weight: 600;
                color: var(--text-main);
                margin-bottom: 0.5rem;
            }

            .required {
                color: var(--primary-orange);
            }

            /* Passenger Section */
            .passenger-section {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 1rem;
                margin-top: 1.5rem;
            }

            .passenger-box {
                background: linear-gradient(135deg, #fff 0%, #f8f9fa 100%);
                border: 2px solid #e9ecef;
                border-radius: 16px;
                padding: 1.5rem;
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
            }

            .passenger-box::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 3px;
                background: var(--gradient-secondary);
                transform: scaleX(0);
                transition: transform 0.3s ease;
            }

            .passenger-box:hover {
                transform: translateY(-5px);
                box-shadow: var(--shadow-secondary);
                border-color: var(--primary-orange);
            }

            .passenger-box:hover::before {
                transform: scaleX(1);
            }

            .box-header {
                font-weight: 700;
                color: var(--text-main);
                margin-bottom: 0.5rem;
            }

            .subtext {
                font-size: 0.85rem;
                color: var(--text-secondary);
                margin-bottom: 1rem;
            }

            .counter {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background: #f8f9fa;
                border-radius: 12px;
                padding: 0.5rem;
            }

            .counter button {
                width: 40px;
                height: 40px;
                border: none;
                border-radius: 50%;
                background: var(--gradient-secondary);
                color: white;
                font-size: 1.2rem;
                font-weight: 700;
                cursor: pointer;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .counter button:hover {
                transform: scale(1.1);
                box-shadow: var(--shadow-secondary);
            }

            .counter span {
                font-size: 1.2rem;
                font-weight: 700;
                color: var(--text-main);
                min-width: 30px;
                text-align: center;
            }

            /* Note Section */
            .note-section {
                margin-top: 2rem;
                padding: 1.5rem;
                background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
                border-radius: 16px;
                border: 2px solid #dee2e6;
            }

            .note-textarea {
                width: 100%;
                border: 2px solid #e9ecef;
                border-radius: 12px;
                padding: 1rem;
                resize: vertical;
                min-height: 120px;
                transition: all 0.3s ease;
                font-family: inherit;
            }

            .note-textarea:focus {
                border-color: var(--primary-blue);
                box-shadow: 0 0 0 0.2rem rgba(14, 165, 233, 0.25);
                outline: none;
            }

            /* Right Content */
            .right-content {
                background: white;
                border-radius: 20px;
                padding: 2rem;
                box-shadow: var(--shadow-primary);
                height: fit-content;
                position: sticky;
                top: 2rem;
                border: 2px solid var(--secondary-yellow);
            }

            .summary-title {
                font-size: 1.3rem;
                font-weight: 700;
                color: var(--text-main);
                margin-bottom: 1.5rem;
                text-align: center;
                position: relative;
            }

            .summary-title::after {
                content: '';
                position: absolute;
                bottom: -8px;
                left: 50%;
                transform: translateX(-50%);
                width: 60px;
                height: 3px;
                background: var(--gradient-secondary);
                border-radius: 2px;
            }

            .tour-info {
                display: flex;
                gap: 1rem;
                margin-bottom: 1.5rem;
                padding: 1rem;
                background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
                border-radius: 12px;
                border-left: 4px solid var(--primary-orange);
            }

            .tour-info img {
                width: 80px;
                height: 60px;
                object-fit: cover;
                border-radius: 8px;
                border: 2px solid var(--secondary-yellow);
            }

            .tour-details {
                flex: 1;
            }

            .tour-details p {
                margin: 0.2rem 0;
                font-size: 0.9rem;
            }

            .tour-details strong {
                color: var(--text-main);
            }

            .tour-details h4 {
                color: var(--primary-orange);
                font-weight: bold;
                margin: 1.5rem 0 1rem 0;
                font-size: 1.2rem;
            }

            .flight-info {
                display: flex;
                justify-content: space-between;
                margin-bottom: 1.5rem;
                padding: 1rem;
                background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
                border-radius: 12px;
                font-size: 0.9rem;
            }

            .flight-info div {
                text-align: center;
            }

            .flight-info strong {
                color: var(--text-main);
            }

            .price-breakdown {
                margin-bottom: 1.5rem;
            }

            .price-section-title {
                font-weight: 700;
                color: var(--text-main);
                margin-bottom: 1rem;
                padding-bottom: 0.5rem;
                border-bottom: 2px solid var(--secondary-yellow);
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .line-item {
                display: flex;
                justify-content: space-between;
                padding: 0.5rem 0;
                font-size: 0.9rem;
                border-bottom: 1px solid #f1f3f4;
            }

            .line-item:last-child {
                border-bottom: none;
            }

            .discount-section {
                margin-top: 1.5rem;
                padding: 1rem;
                background: linear-gradient(135deg, #fff3e0 0%, #ffe0b2 100%);
                border-radius: 12px;
                border: 2px solid var(--secondary-yellow);
            }

            .btn-add-discount {
                background: none;
                border: 2px dashed var(--primary-orange);
                color: var(--primary-orange);
                font-weight: 700;
                padding: 0.5rem 1rem;
                border-radius: 8px;
                cursor: pointer;
                transition: all 0.3s ease;
                width: 100%;
            }

            .btn-add-discount:hover {
                background: var(--primary-orange);
                color: white;
                transform: translateY(-2px);
            }

            .total {
                border-top: 3px solid var(--secondary-yellow);
                margin-top: 1.5rem;
                padding-top: 1rem;
                display: flex;
                justify-content: space-between;
                font-weight: 700;
                font-size: 1.2rem;
                color: var(--text-main);
            }

            .total-amount {
                color: var(--primary-orange);
                font-size: 1.4rem;
            }

            .btn-submit {
                background: var(--gradient-secondary);
                color: white;
                width: 100%;
                padding: 1rem;
                margin-top: 1.5rem;
                font-size: 1.1rem;
                font-weight: 700;
                border: none;
                border-radius: 12px;
                cursor: pointer;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .btn-submit:hover {
                transform: translateY(-3px);
                box-shadow: var(--shadow-secondary);
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .step-tracker {
                    gap: 1rem;
                }

                .step .icon {
                    width: 60px;
                    height: 60px;
                }

                .step .label {
                    font-size: 0.8rem;
                }

                .passenger-section {
                    grid-template-columns: 1fr;
                }

                .right-content {
                    position: static;
                    margin-top: 2rem;
                }
            }

            /* Animation */
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .left-content, .right-content {
                animation: fadeInUp 0.6s ease-out;
            }

            .right-content {
                animation-delay: 0.2s;
            }
        </style>
    </head>
    <body>
        <%
            UserDTO account = (UserDTO)session.getAttribute("nameUser");
            TourTicketDTO tour = (TourTicketDTO)session.getAttribute("tourTicket");
            StartDateDTO stDate = (StartDateDTO)session.getAttribute("stDate");
        %>
        <%@include file="header.jsp" %>

        <div class="content">
            <!-- Step Progress Bar -->
            <div class="container">
                <div class="step-container">
                    <h2 class="step-title">
                        <i class="fas fa-map-marked-alt me-2"></i>
                        ĐẶT TOUR
                    </h2>
                    <div class="step-tracker">
                        <a href="BookingStep1.jsp" class="step active">
                            <div class="icon">
                                <i class="fas fa-edit"></i>
                            </div>
                            <div class="label">NHẬP THÔNG TIN</div>
                        </a>
                        <div class="arrow">
                            <i class="fas fa-chevron-right"></i>
                        </div>
                        <div class="step">
                            <div class="icon">
                                <i class="fas fa-credit-card"></i>
                            </div>
                            <div class="label">THANH TOÁN</div>
                        </div>
                        <div class="arrow">
                            <i class="fas fa-chevron-right"></i>
                        </div>
                        <div class="step">
                            <div class="icon">
                                <i class="fas fa-check-circle"></i>
                            </div>
                            <div class="label">HOÀN TẤT</div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Main Content -->
            <div class="main-container">
                <div class="content-grid">
                    <!-- Left Content -->
                    <div class="left-content">
                        <div class="section-title">
                            <i class="fas fa-address-book"></i>
                            THÔNG TIN LIÊN LẠC
                        </div>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Họ tên <span class="required">*</span></label>
                                <input type="text" class="form-control" value="<%=account.getFullName()%>">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Điện thoại <span class="required">*</span></label>
                                <input type="text" class="form-control" value="<%=account.getPhone()%>">
                            </div>
                            <div class="col-12">
                                <label class="form-label">Email <span class="required">*</span></label>
                                <input type="email" class="form-control" value="<%=account.getEmail()%>">
                            </div>
                        </div>
                        <div class="section-title mt-4">
                            <i class="fas fa-users"></i>
                            HÀNH KHÁCH
                        </div>

                        <div class="passenger-section">
                            <div class="passenger-box">
                                <div class="box-header">
                                    <i class="fas fa-user me-2"></i>Người lớn
                                </div>
                                <div class="subtext">Từ 12 tuổi trở lên</div>
                                <div class="counter">
                                    <button type="button" onclick="changeCount('adult', -1)">−</button>
                                    <span id="adult-count">1</span>
                                    <button type="button" onclick="changeCount('adult', 1)">+</button>
                                </div>
                            </div>

                            <div class="passenger-box">
                                <div class="box-header">
                                    <i class="fas fa-child me-2"></i>Trẻ em
                                </div>
                                <div id="child" data-value="${not empty child ? child.discount : 0}"></div>
                                <div class="subtext">Từ 2 – 6 tuổi (ưu đãi giảm giá ${not empty child ? child.discount : 0}%)</div>
                                <div class="counter">
                                    <button type="button" onclick="changeCount('child', -1)">−</button>
                                    <span id="child-count">0</span>
                                    <button type="button" onclick="changeCount('child', 1)">+</button>
                                </div>
                            </div>

                            <div class="passenger-box">
                                <div class="box-header">
                                    <i class="fas fa-baby me-2"></i>Em bé 
                                </div>
                                <div id="baby" data-value="${not empty baby ? baby.discount : 0}"></div>
                                <div class="subtext">Dưới 2 tuổi (ưu đãi giảm giá ${not empty baby ? baby.discount : 0}%)</div>
                                <div class="counter">
                                    <button type="button" onclick="changeCount('baby', -1)">−</button>
                                    <span id="baby-count">0</span>
                                    <button type="button" onclick="changeCount('baby', 1)">+</button>

                                </div>
                            </div>
                        </div>
                        <div class="note-section">
                            <label class="form-label">
                                <i class="fas fa-sticky-note me-2"></i>
                                <strong>GHI CHÚ</strong>
                            </label>
                            <p class="subtext">Quý khách có ghi chú lưu ý gì, hãy nói với chúng tôi</p>
                            <textarea
                                name="note"
                                class="note-textarea"
                                placeholder="Vui lòng nhập nội dung lời nhắn..."></textarea>
                        </div>
                    </div>

                    <!-- Right Content -->
                    <div class="right-content">
                        <div class="summary-title">
                            <i class="fas fa-clipboard-list me-2"></i>
                            TÓM TẮT CHUYẾN ĐI
                        </div>
                        <div class="tour-info">
                            <img src="<%=tour.getImg_Tour()%>" alt="<%=tour.getDestination()%>">
                            <div class="tour-details">
                                <p class="tour-code">Mã tour <strong><%=tour.getIdTourTicket()%></strong></p>
                                <p><strong><%=tour.getDestination()%>:</strong> <%=tour.getNametour()%></p>
                            </div>
                        </div>
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
                            LocalDate today = LocalDate.now();
                            String todayStr = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                        %>
                        <div class="flight-info">
                            <div>
                                <i class="fas fa-plane-departure mb-2 d-block text-primary"></i>
                                <strong>Ngày đi: <%=stDate.getStartDate()%></strong>
                            </div>
                            <div>
                                <i class="fas fa-plane-arrival mb-2 d-block text-success"></i>
                                <strong>Ngày về: <%=endDateStr%></strong>
                            </div>
                        </div>
                        <div class="price-breakdown">
                            <div class="price-section-title">
                                <i class="fas fa-users"></i>
                                KHÁCH HÀNG + PHỤ THU
                            </div>
                            <div class="line-item" id="adult-line">
                                <span><i class="fas fa-user me-1"></i>Người lớn</span>
                                <span id="adult-line-value">1 x ... đ</span>
                            </div>
                            <div class="line-item" id="child-line" style="display: none;">
                                <span><i class="fas fa-child me-1"></i>Trẻ em</span>
                                <span id="child-line-value">...</span>
                            </div>
                            <div class="line-item" id="baby-line" style="display: none;">
                                <span><i class="fas fa-baby me-1"></i>Em bé</span>
                                <span id="baby-line-value">...</span>
                            </div>
                            <div class="line-item">
                                <span><i class="fas fa-bed me-1"></i>Phụ thu phòng đơn</span>
                                <span>0 đ</span>
                            </div>
                            <div class="line-item">
                                <h5><i class="fas fa-percentage me-1"></i>Tổng giá trị ưu đãi</h5>
                                <h5 id="price_down">...</h5>
                            </div>
                        </div>


                        <!-- them voucher -->
                        <div class="discount-section">
                            <div class="price-section-title">
                                <i class="fas fa-tags"></i>
                                MÃ GIẢM GIÁ
                            </div>

                            <button type="button" class="btn-add-discount" onclick="openDiscountModal()">
                                <i class="fas fa-plus me-2"></i>Thêm mã giảm giá
                            </button>

                            <!-- Voucher Modal -->
                            <div id="voucherModal" class="voucher-modal" style="display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgba(0,0,0,0.4); align-items: center; justify-content: center;">
                                <div class="modal-content" style="background-color: #fefefe; margin: auto; padding: 20px; border: 1px solid #888; width: 80%; max-width: 600px; border-radius: 8px; position: relative;">
                                    <span class="close-btn" onclick="closeDiscountModal()" style="color: #aaa; float: right; font-size: 28px; font-weight: bold; cursor: pointer;">&times;</span>
                                    <h3>
                                        <i class="fas fa-wallet me-2"></i>
                                        Chọn mã giảm giá
                                    </h3>
                                    <p style="font-size: 0.9em; color: #666; margin-bottom: 15px;">Chọn một mã giảm giá phù hợp với đơn hàng của bạn:</p>

                                    <div id="voucherListContainer" style="max-height: 400px; overflow-y: auto; margin-top: 15px; border-top: 1px solid #eee; padding-top: 10px;">
                                        <!-- Voucher options will be populated here -->
                                    </div>

                                    <div class="modal-buttons" style="margin-top: 20px; text-align: right;">
                                        <button type="button" onclick="closeDiscountModal()" class="btn-cancel" style="padding: 10px 20px; background-color: #6c757d; color: white; border: none; border-radius: 5px; cursor: pointer; margin-right: 10px;">
                                            <i class="fas fa-times me-2"></i>
                                            Ðóng
                                        </button>
                                        <button type="button" onclick="applySelectedVoucher()" class="btn-confirm" style="padding: 10px 20px; background-color: #28a745; color: white; border: none; border-radius: 5px; cursor: pointer;">
                                            <i class="fas fa-check me-2"></i>
                                            Áp dụng
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <!-- Hiển thị voucher đã chọn -->
                            <div id="selectedVoucherDisplay" style="margin-top: 15px; padding: 10px; background-color: #d4edda; border: 1px solid #c3e6cb; border-radius: 5px; display: none;">
                                <div style="display: flex; justify-content: space-between; align-items: center;">
                                    <div>
                                        <strong id="selectedVoucherTitle"></strong>
                                        <br>
                                        <small>Giảm <span id="selectedVoucherDiscount"></span>% - Tiết kiệm: <span id="selectedVoucherAmount"></span></small>
                                    </div>
                                    <button type="button" onclick="clearVoucher()" style="background: #dc3545; color: white; border: none; border-radius: 3px; padding: 5px 10px; cursor: pointer;">
                                        <i class="fas fa-times"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <!-- het phân xu ly them voucher -->

                        <div class="total">
                            <p><i class="fas fa-calculator me-2"></i>Tổng tiền</p>
                            <p class="total-amount">0 đ</p>
                        </div>
                        <form action="MainController" method="get" onsubmit="return prepareSubmit()">
                            <input type="hidden" name="action" value="call_oder_step2">
                            <input type="hidden" name="startNum" value="<%=stDate.getStartNum()%>">
                            <input type="hidden" name="idUser" value="<%=account.getIdUser()%>">
                            <input type="hidden" name="idTour" value="<%=tour.getIdTourTicket()%>">
                            <input type="hidden" name="bookingDate" value="<%=today%>">
                            <input type="hidden" id="totalBill" name="totalBill" value="">
                            <input type="hidden" id="numberTicket" name="numberTicket" value="">
                            <input type="hidden" id="noteValueInput" name="noteValueInput" value="">
                            <input type="hidden" name="status" value="0">
                            <input type="hidden" id="voucherID" name="voucherID" value="">
                            <button type="submit" class="btn-submit">
                                <i class="fas fa-paper-plane me-2"></i>
                                Đặt Tour
                            </button>
                        </form>

                    </div>
                </div>
            </div>

            <%@include file="footer.jsp" %>

            <script>
                var vouchersDataFromJSP = [
                <c:forEach var="vc" items="${requestScope.listVouchers}" varStatus="loop">
                {
                voucherID: ${vc.voucherID},
                        title: "${vc.title}",
                        startDate: "${vc.startDate}",
                        discount: ${vc.discount},
                        numbers: ${vc.numbers},
                        duration: ${vc.duration},
                        minimumOrderValue: ${vc.minimumOrderValue}
                }${!loop.last ? ',' : ''}
                </c:forEach>
                ];
            
                let selectedVoucher = null; // Lưu trữ đối tượng voucher đang được áp dụng
                let tempSelectedVoucher = null; // Voucher tạm thời được chọn trong modal

                // Lấy giá tour từ server (giá một vé người lớn)
                const pricePerAdult = <%= tour.getPrice() %>;
                // Các mức giảm giá cho trẻ em và em bé
                var discountBaby = document.getElementById("baby").getAttribute("data-value");
                var discountChild = document.getElementById("child").getAttribute("data-value");

                /**
                 * Hàm mở modal chọn voucher
                 */
                function openDiscountModal() {
                    const modal = document.getElementById('voucherModal');
                    const container = document.getElementById('voucherListContainer');

                    // Xóa nội dung cũ
                    container.innerHTML = '';

                    // Tính tổng tiền hiện tại để kiểm tra điều kiện voucher
                    const currentTotal = calculateCurrentTotal();

                    if (vouchersDataFromJSP.length === 0) {
                        container.innerHTML = '<p style="text-align: center; color: #666;">Không có mã giảm giá nào hiện có.</p>';
                    } else {
                        // Tạo danh sách voucher
                        vouchersDataFromJSP.forEach(function (voucher) {
                            const isEligible = currentTotal >= voucher.minimumOrderValue;
                            const voucherDiv = document.createElement('div');
                            voucherDiv.style.cssText = `
                                margin-bottom: 10px; 
                                padding: 15px; 
                                border: 2px solid \${isEligible ? '#28a745' : '#dc3545'}; 
                                border-radius: 8px; 
                                cursor: \${isEligible ? 'pointer' : 'not-allowed'};
                                background-color: \${isEligible ? '#f8f9fa' : '#f5f5f5'};
                                opacity: \${isEligible ? '1' : '0.6'};
                                transition: all 0.3s ease;
                            `;

                            if (isEligible) {
                                voucherDiv.addEventListener('mouseenter', function () {
                                    this.style.backgroundColor = '#e9ecef';
                                    this.style.transform = 'translateY(-2px)';
                                });
                                voucherDiv.addEventListener('mouseleave', function () {
                                    this.style.backgroundColor = '#f8f9fa';
                                    this.style.transform = 'translateY(0)';
                                });
                            }

                            voucherDiv.innerHTML = `
                                <div style="display: flex; align-items: center; margin-bottom: 10px;">
                                    <input type="radio" name="voucherOption" value="\${voucher.voucherID}" 
                                           id="voucher_\${voucher.voucherID}" 
                \${isEligible ? '' : 'disabled'}
                \${selectedVoucher && selectedVoucher.voucherID == voucher.voucherID ? 'checked' : ''}
                                           style="margin-right: 10px;">
                                    <label for="voucher_\${voucher.voucherID}" style="font-weight: bold; color: \${isEligible ? '#28a745' : '#dc3545'};">
                \${voucher.title}
                                    </label>
                                </div>
                                <div style="margin-left: 25px;">
                                    <p style="margin: 5px 0; font-size: 0.9em;">
                                        <i class="fas fa-percentage" style="color: #007bff; margin-right: 5px;"></i>
                                        Giảm \${voucher.discount}%
                                    </p>
                                    <p style="margin: 5px 0; font-size: 0.9em;">
                                        <i class="fas fa-coins" style="color: #ffc107; margin-right: 5px;"></i>
                                        Đơn hàng tối thiểu: \${formatCurrency(voucher.minimumOrderValue)}
                                    </p>
                                    <p style="margin: 5px 0; font-size: 0.9em;">
                                        <i class="fas fa-ticket-alt" style="color: #6c757d; margin-right: 5px;"></i>
                                        Còn lại: \${voucher.numbers} voucher
                                    </p>
                \${!isEligible ? '<p style="margin: 5px 0; font-size: 0.85em; color: #dc3545; font-style: italic;"><i class="fas fa-exclamation-triangle" style="margin-right: 5px;"></i>Không đủ điều kiện áp dụng</p>' : ''}
                                </div>
                            `;

                            if (isEligible) {
                                voucherDiv.addEventListener('click', function () {
                                    const radio = this.querySelector('input[type="radio"]');
                                    radio.checked = true;
                                    tempSelectedVoucher = voucher;
                                });
                            }

                            container.appendChild(voucherDiv);
                        });
                    }

                    modal.style.display = 'flex';
                }

                /**
                 * Hàm đóng modal
                 */
                function closeDiscountModal() {
                    document.getElementById('voucherModal').style.display = 'none';
                    tempSelectedVoucher = null;
                }

                /**
                 * Hàm áp dụng voucher đã chọn
                 */
                function applySelectedVoucher() {
                    const checkedRadio = document.querySelector('input[name="voucherOption"]:checked');
                    if (checkedRadio) {
                        const voucherId = parseInt(checkedRadio.value);
                        selectedVoucher = vouchersDataFromJSP.find(v => v.voucherID === voucherId);

                        if (selectedVoucher) {
                            updateVoucherDisplay();
                            updateTotal();
                        }
                    }
                    closeDiscountModal();
                }

                /**
                 * Hàm cập nhật hiển thị voucher đã chọn
                 */
                function updateVoucherDisplay() {
                    const displayDiv = document.getElementById('selectedVoucherDisplay');
                    const titleSpan = document.getElementById('selectedVoucherTitle');
                    const discountSpan = document.getElementById('selectedVoucherDiscount');
                    const amountSpan = document.getElementById('selectedVoucherAmount');

                    if (selectedVoucher) {
                        const currentTotal = calculateCurrentTotal();
                        const voucherAmount = currentTotal * (selectedVoucher.discount / 100);

                        titleSpan.textContent = selectedVoucher.title;
                        discountSpan.textContent = selectedVoucher.discount;
                        amountSpan.textContent = formatCurrency(voucherAmount);
                        displayDiv.style.display = 'block';
                    } else {
                        displayDiv.style.display = 'none';
                    }
                }

                /**
                 * Hàm xóa voucher đã chọn
                 */
                function clearVoucher() {
                    selectedVoucher = null;
                    updateVoucherDisplay();
                    updateTotal();
                }

                /**
                 * Hàm tính tổng tiền hiện tại (trước khi áp dụng voucher)
                 */
                function calculateCurrentTotal() {
                    const adultCount = parseInt(document.getElementById("adult-count").innerText);
                    const childCount = parseInt(document.getElementById("child-count").innerText);
                    const babyCount = parseInt(document.getElementById("baby-count").innerText);

                    const totalAdult = adultCount * pricePerAdult;
                    const totalChild = childCount * pricePerAdult * (1 - discountChild / 100);
                    const totalBaby = babyCount * pricePerAdult * (1 - discountBaby / 100);

                    return totalAdult + totalChild + totalBaby;
                }

                /**
                 * Hàm thay đổi số lượng hành khách theo loại (adult, child, baby)
                 * delta: +1 hoặc -1
                 */
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
                    const noteValue = noteTextarea ? noteTextarea.value : '';

                    // Tính tổng tiền từng nhóm sau khi áp dụng giảm giá theo loại hành khách
                    const totalAdult = adultCount * pricePerAdult;
                    const totalChild = childCount * pricePerAdult * (1 - discountChild / 100);
                    const totalBaby = babyCount * pricePerAdult * (1 - discountBaby / 100);
                    const subtotalBeforeVoucher = totalAdult + totalChild + totalBaby;

                    // Áp dụng voucher giảm giá (nếu có)
                    let voucherDiscountAmount = 0;
                    let finalTotal = subtotalBeforeVoucher;

                    if (selectedVoucher) {
                        // Kiểm tra điều kiện tối thiểu
                        if (subtotalBeforeVoucher >= selectedVoucher.minimumOrderValue) {
                            voucherDiscountAmount = subtotalBeforeVoucher * (selectedVoucher.discount / 100);
                            finalTotal = subtotalBeforeVoucher - voucherDiscountAmount;
                        } else {
                            // Nếu không đủ điều kiện, tự động hủy voucher
                            selectedVoucher = null;
                            updateVoucherDisplay();
                        }
                    }

                    // Gán giá trị ẩn cho form gửi server
                    document.getElementById("totalBill").value = Math.floor(finalTotal);
                    document.getElementById("numberTicket").value = totalCount;
                    document.getElementById("noteValueInput").value = noteValue;
                    document.getElementById("voucherID").value = selectedVoucher ? selectedVoucher.voucherID : '';

                    // Tính tổng tiền được giảm theo loại hành khách (để hiển thị)
                    const totalChild_down = childCount * pricePerAdult * (1.0)*discountChild / 100.0;
                    const totalBaby_down = babyCount * pricePerAdult * (1.0)*discountBaby / 100.0;
                    const total_down = totalChild_down + totalBaby_down;

                    // Cập nhật giao diện hiển thị
                    document.querySelector(".total-amount").innerText = formatCurrency(finalTotal);

                    // Cập nhật các element nếu tồn tại
                    const priceDownElement = document.getElementById("price_down");
                    if (priceDownElement) {
                        priceDownElement.innerText = formatCurrency(total_down);
                    }

                    const adultLineElement = document.getElementById("adult-line-value");
                    if (adultLineElement) {
                        adultLineElement.innerText = adultCount + " x " + formatCurrency(pricePerAdult);
                    }

                    const childLineElement = document.getElementById("child-line-value");
                    if (childLineElement) {
                        childLineElement.innerText = childCount + " x " + formatCurrency(pricePerAdult * (1 - discountChild / 100));
                    }

                    const babyLineElement = document.getElementById("baby-line-value");
                    if (babyLineElement) {
                        babyLineElement.innerText = babyCount + " x " + formatCurrency(pricePerAdult * (1 - discountBaby / 100));
                    }

                    // Hiển thị hoặc ẩn dòng trẻ em và em bé tùy số lượng
                    const childLine = document.getElementById("child-line");
                    if (childLine) {
                        childLine.style.display = childCount > 0 ? "flex" : "none";
                    }

                    const babyLine = document.getElementById("baby-line");
                    if (babyLine) {
                        babyLine.style.display = babyCount > 0 ? "flex" : "none";
                    }

                    // Cập nhật hiển thị voucher nếu có
                    if (selectedVoucher) {
                        updateVoucherDisplay();
                    }
                    
                    
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
                    if (noteTextarea) {
                        noteTextarea.addEventListener('input', function () {
                            document.getElementById("noteValueInput").value = noteTextarea.value;
                        });
                    }
                });

                // Hàm chuẩn bị gửi form
                function prepareSubmit() {
                    // Kiểm tra số lượng vé có hợp lệ không
                    const adultCount = parseInt(document.getElementById("adult-count").innerText);
                    const childCount = parseInt(document.getElementById("child-count").innerText);
                    const babyCount = parseInt(document.getElementById("baby-count").innerText);
                    const totalCount = adultCount + childCount + babyCount;

                    if (totalCount <= 0) {
                        alert("Vui lòng chọn ít nhất 1 vé!");
                        return false;
                    }

                    // Cập nhật lại lần cuối cùng trước khi gửi
                    updateTotal();

                    // Nếu có voucher được chọn, cập nhật số lượng voucher
                    if (selectedVoucher) {
                        // Tìm voucher trong danh sách và giảm số lượng
                        const voucherIndex = vouchersDataFromJSP.findIndex(v => v.voucherID === selectedVoucher.voucherID);
                        if (voucherIndex !== -1) {
                            vouchersDataFromJSP[voucherIndex].numbers -= 1;
                        }
                    }

                    return true;
                }

                // Đóng modal khi click bên ngoài
                window.onclick = function (event) {
                    const modal = document.getElementById('voucherModal');
                    if (event.target === modal) {
                        closeDiscountModal();
                    }
                }
            </script>
    </body>
</html>