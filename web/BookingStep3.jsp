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
        <title>VN Tours</title>
        
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        
        <link href="assets/css/booking_step_3.css" rel="stylesheet">

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

                            <img src="<%= tourImage %>" alt="Tour" class="tour-image">
                            
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