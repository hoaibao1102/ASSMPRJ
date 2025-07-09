<%-- 
    Document   : OrderForm
    Created on : May 29, 2025, 11:08:57 PM
    Author     : MSI PC
--%>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<%@ page import="DTO.OrderDTO"%>
<%@ page import="DTO.StartDateDTO"%>
<%@ page import="DTO.TourTicketDTO"%>
<%@ page import="DTO.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Tour - Thanh Toán</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-orange: #ff6b35;
            --primary-dark: #2c3e50;
            --primary-yellow: #f39c12;
            --bg-light: #f8f9fa;
            --gradient-tropical: linear-gradient(135deg, #ff6b35 0%, #f39c12 100%);
            --gradient-ocean: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
        }

        body {
            background: var(--bg-light);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
        }

        .tropical-gradient {
            background: var(--gradient-tropical);
        }

        .ocean-gradient {
            background: var(--gradient-ocean);
        }

        /* Step Tracker Styles */
        .step-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            padding: 2rem;
            margin-bottom: 2rem;
            border: 3px solid var(--primary-orange);
        }

        .step-title {
            color: var(--primary-dark);
            font-weight: bold;
            text-align: center;
            margin-bottom: 2rem;
            font-size: 2rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        }

        .step-tracker {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .step {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            transition: all 0.3s ease;
        }

        .step.active .icon {
            background: linear-gradient(45deg, #27ae60, #2ecc71);
            transform: scale(1.1);
            box-shadow: 0 8px 25px rgba(46, 204, 113, 0.4);
        }

        .step.current .icon {
            background: var(--gradient-tropical);
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
            margin-bottom: 0.5rem;
        }

        .step .icon img {
            width: 40px;
            height: 40px;
            filter: brightness(0) invert(1);
        }

        .step .label {
            font-weight: bold;
            color: var(--primary-dark);
            font-size: 0.9rem;
            margin-top: 0.5rem;
        }

        .arrow {
            font-size: 2rem;
            color: var(--primary-orange);
            margin: 0 1rem;
            animation: bounce 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1.15); }
            50% { transform: scale(1.25); }
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% { transform: translateX(0); }
            40% { transform: translateX(-5px); }
            60% { transform: translateX(5px); }
        }

        /* Content Container */
        .containerdetail {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            margin-top: 2rem;
        }

        @media (max-width: 768px) {
            .containerdetail {
                grid-template-columns: 1fr;
                gap: 1rem;
            }
        }

        /* Left Content */
        .left-content {
            background: white;
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            border-left: 5px solid var(--primary-orange);
            transition: all 0.3s ease;
        }

        .left-content:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }

        .left-content h3 {
            color: var(--primary-dark);
            font-weight: bold;
            margin-bottom: 1.5rem;
            font-size: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 3px solid var(--primary-yellow);
            display: inline-block;
        }

        .info-table {
            width: 100%;
            margin-bottom: 2rem;
        }

        .info-table td {
            padding: 0.75rem 0;
            border-bottom: 1px solid #eee;
        }

        .info-table td:first-child {
            font-weight: bold;
            color: var(--primary-dark);
            width: 40%;
        }

        .info-table td:last-child {
            color: #555;
        }

        .booking-id {
            color: var(--primary-orange) !important;
            font-weight: bold;
            font-size: 1.1rem;
        }

        .status-confirmed {
            color: #27ae60 !important;
            font-weight: bold;
        }

        .payment-deadline {
            color: #e74c3c !important;
            font-weight: bold;
        }

        /* Right Content */
        .right-content {
            background: white;
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            border-right: 5px solid var(--primary-yellow);
            transition: all 0.3s ease;
        }

        .right-content:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }

        .right-content h3 {
            color: var(--primary-dark);
            font-weight: bold;
            margin-bottom: 1.5rem;
            font-size: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 3px solid var(--primary-orange);
            display: inline-block;
        }

        .tour-image {
            width: 100%;
            border-radius: 15px;
            margin-bottom: 1.5rem;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            transition: all 0.3s ease;
        }

        .tour-image:hover {
            transform: scale(1.05);
        }

        .tour-info p {
            margin-bottom: 1rem;
            color: #555;
        }

        .tour-info strong {
            color: var(--primary-dark);
        }

        .tour-info h4 {
            color: var(--primary-orange);
            font-weight: bold;
            margin: 1.5rem 0 1rem 0;
            font-size: 1.2rem;
        }

        /* Payment Button */
        .payment-btn {
            background: var(--gradient-tropical);
            color: white;
            border: none;
            padding: 1rem 2rem;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: bold;
            width: 100%;
            margin-top: 2rem;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(255, 107, 53, 0.4);
        }

        .payment-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(255, 107, 53, 0.6);
            background: linear-gradient(135deg, #e55a2b 0%, #d68910 100%);
        }

        /* Payment Modal */
        .payment-modal {
            display: none;
            position: fixed;
            z-index: 9999;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            background: rgba(0,0,0,0.5);
            align-items: center;
            justify-content: center;
            backdrop-filter: blur(5px);
        }

        .modal-content {
            background: white;
            padding: 2rem;
            border-radius: 20px;
            width: 400px;
            max-width: 90vw;
            position: relative;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            animation: modalSlideIn 0.3s ease;
        }

        @keyframes modalSlideIn {
            from {
                transform: translateY(-50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .modal-content h3 {
            color: var(--primary-dark);
            margin-bottom: 1.5rem;
            font-weight: bold;
            text-align: center;
        }

        .payment-option {
            display: flex;
            align-items: center;
            padding: 1rem;
            border: 2px solid #eee;
            border-radius: 10px;
            margin-bottom: 1rem;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .payment-option:hover {
            border-color: var(--primary-orange);
            background: rgba(255, 107, 53, 0.1);
        }

        .payment-option input[type="radio"] {
            margin-right: 0.75rem;
            transform: scale(1.2);
        }

        .payment-option label {
            cursor: pointer;
            font-weight: 500;
            color: var(--primary-dark);
            display: flex;
            align-items: center;
            width: 100%;
        }

        .payment-option i {
            margin-left: auto;
            color: var(--primary-orange);
            font-size: 1.2rem;
        }

        .modal-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 2rem;
        }

        .btn-cancel {
            background: #6c757d;
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 25px;
            font-weight: bold;
            transition: all 0.3s ease;
        }

        .btn-cancel:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }

        .btn-confirm {
            background: var(--gradient-tropical);
            color: white;
            border: none;
            padding: 0.75rem 2rem;
            border-radius: 25px;
            font-weight: bold;
            transition: all 0.3s ease;
        }

        .btn-confirm:hover {
            background: linear-gradient(135deg, #e55a2b 0%, #d68910 100%);
            transform: translateY(-2px);
        }

        .close-btn {
            position: absolute;
            top: 1rem;
            right: 1.5rem;
            cursor: pointer;
            font-size: 1.5rem;
            color: #6c757d;
            transition: color 0.3s ease;
        }

        .close-btn:hover {
            color: var(--primary-orange);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .step-tracker {
                flex-direction: column;
                gap: 1rem;
            }
            
            .arrow {
                transform: rotate(90deg);
                margin: 0.5rem 0;
            }
            
            .step-title {
                font-size: 1.5rem;
            }
            
            .step .icon {
                width: 60px;
                height: 60px;
            }
            
            .step .icon img {
                width: 30px;
                height: 30px;
            }
        }

        /* Tropical decorative elements */
        .tropical-decoration {
            position: absolute;
            top: -10px;
            right: -10px;
            width: 50px;
            height: 50px;
            background: var(--gradient-tropical);
            border-radius: 50%;
            opacity: 0.1;
            animation: float 6s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }
    </style>
</head>
<body>
    <%@include file="header.jsp" %>
    
    <div class="container-fluid px-4 py-5">
        <div class="step-container">
            <h2 class="step-title">
                <i class="fas fa-map-marked-alt me-2"></i>
                ĐẶT TOUR
            </h2>
            <div class="step-tracker">
                <div class="step active">
                    <div class="icon">
                        <img src="assets/images/icon/icon_fillfile.jpg" alt="info" />
                    </div>
                    <div class="label">NHẬP THÔNG TIN</div>
                </div>
                
                <div class="arrow">
                    <i class="fas fa-arrow-right"></i>
                </div>

                <div class="step current">
                    <div class="icon">
                        <img src="assets/images/icon/icon_thanhtoan.jpg" alt="pay" />
                    </div>
                    <div class="label">THANH TOÁN</div>
                </div>

                <div class="arrow">
                    <i class="fas fa-arrow-right"></i>
                </div>

                <div class="step">
                    <div class="icon">
                        <img src="assets/images/icon/icon_done.jpg" alt="done" />
                    </div>
                    <div class="label">HOÀN TẤT</div>
                </div>
            </div>
        </div>

        <%
            UserDTO account = (UserDTO)session.getAttribute("nameUser");
            OrderDTO newBooking = (OrderDTO)request.getAttribute("newBooking");
            DecimalFormat vnd = new DecimalFormat("#,###");
            
            //láy ra ngày dat
            LocalDate today = LocalDate.parse(newBooking.getBookingDate(), DateTimeFormatter.ofPattern("yyyy-MM-dd")); ;
            LocalDate tomorrow = today.plusDays(1);
            String tomorrowStr = tomorrow.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        %>

        <div class="containerdetail">
            <div class="left-content">
                <div class="tropical-decoration"></div>
                <h3>
                    <i class="fas fa-address-card me-2"></i>
                    THÔNG TIN LIÊN LẠC
                </h3>
                <table class="info-table">
                    <tr>
                        <td><i class="fas fa-user me-2"></i>Họ tên:</td>
                        <td><%=account.getFullName()%></td>
                    </tr>
                    <tr>
                        <td><i class="fas fa-envelope me-2"></i>Email:</td>
                        <td><%=account.getEmail()%></td>
                    </tr>
                    <tr>
                        <td><i class="fas fa-phone me-2"></i>Điện thoại:</td>
                        <td><%=account.getPhone()%></td>
                    </tr>
                </table>
                
                <hr class="my-4" style="border: 2px solid var(--primary-yellow); opacity: 0.3;">
                
                <h3>
                    <i class="fas fa-clipboard-list me-2"></i>
                    CHI TIẾT BOOKING
                </h3>
                <table class="info-table">
                    <tr>
                        <td><i class="fas fa-qrcode me-2"></i>Mã đặt chỗ:</td>
                        <td class="booking-id"><%=newBooking.getIdBooking()%></td>
                    </tr>
                    <tr>
                        <td><i class="fas fa-calendar-plus me-2"></i>Ngày tạo:</td>
                        <td><%=newBooking.getBookingDate()%></td>
                    </tr>
                    <tr>
                        <td><i class="fas fa-users me-2"></i>Số lượng:</td>
                        <td><%=newBooking.getNumberTicket()%></td>
                    </tr>
                    <tr>
                        <td><i class="fas fa-money-bill-wave me-2"></i>Trị giá booking:</td>
                        <td><%= vnd.format(newBooking.getTotalPrice())%> đ</td>
                    </tr>
                    <tr>
                        <td><i class="fas fa-check-circle me-2"></i>Tình trạng:</td>
                        <td class="status-confirmed">
                            <i class="fas fa-check-double me-1"></i>
                            Booking của quý khách đã được chúng tôi xác nhận thành công
                        </td>
                    </tr>
                    <tr>
                        <td><i class="fas fa-clock me-2"></i>Thời hạn thanh toán:</td>
                        <td class="payment-deadline">
                            <i class="fas fa-exclamation-triangle me-1"></i>
                            <%=tomorrow%>
                        </td>
                    </tr>
                </table>
            </div>

            <% 
                TourTicketDTO tour = (TourTicketDTO)session.getAttribute("tourTicket");
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

            <div class="right-content">
                <div class="tropical-decoration"></div>
                <h3>
                    <i class="fas fa-ticket-alt me-2"></i>
                    PHIẾU XÁC NHẬN BOOKING
                </h3>
                <img src="assets/images/places/<%=tour.getImg_Tour()%>" alt="Tour" class="tour-image">
                
                <div class="tour-info">
                    <p>
                        <strong>
                            <i class="fas fa-map-marker-alt me-2"></i>
                            <%=tour.getDestination()%>:
                        </strong> 
                        <%=tour.getNametour()%>
                    </p>
                    <p>
                        <strong>
                            <i class="fas fa-hashtag me-2"></i>
                            Mã tour:
                        </strong> 
                        <%=tour.getIdTourTicket()%>
                    </p>
                    
                    <h4>
                        <i class="fas fa-route me-2"></i>
                        THÔNG TIN CHUYẾN ÐI
                    </h4>
                    <p>
                        <i class="fas fa-plane-departure me-2"></i>
                        <strong>Ngày đi:</strong> <%=startDateStr%>
                    </p>
                    <p>
                        <i class="fas fa-plane-arrival me-2"></i>
                        <strong>Ngày về:</strong> <%=endDateStr%>
                    </p>
                    
                    <form action="MainController" method="get">
                        <input type="hidden" name="action" value="call_oder_step3">
                        <input type="hidden" name="totalBill2" value="<%=newBooking.getTotalPrice()%>">
                        <input type="hidden" name="numberTicket2" value="<%=newBooking.getNumberTicket()%>">
                        
                        <button type="button" onclick="openPaymentModal()" class="payment-btn">
                            <i class="fas fa-credit-card me-2"></i>
                            Thanh toán ngay
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <%@include file="footer.jsp" %>

    <!-- Payment Modal -->
    <div id="paymentModal" class="payment-modal">
        <div class="modal-content">
            <span class="close-btn" onclick="closePaymentModal()">&times;</span>
            <h3>
                <i class="fas fa-wallet me-2"></i>
                Chọn phương thức thanh toán
            </h3>
            <form id="paymentForm" method="get" action="MainController">
                <input type="hidden" name="action" value="call_oder_step3"/>
                <input type="hidden" name="totalBill2" value="<%=newBooking.getTotalPrice()%>">
                <input type="hidden" name="numberTicket2" value="<%=newBooking.getNumberTicket()%>">
                <input type="hidden" name="idBooking" value="<%=newBooking.getIdBooking()%>"/>
                
                <div class="payment-option">
                    <input type="radio" name="paymentMethod" value="momo" checked id="momo">
                    <label for="momo">
                        Momo
                        <i class="fab fa-cc-mastercard"></i>
                    </label>
                </div>
                
                <div class="payment-option">
                    <input type="radio" name="paymentMethod" value="vnpay" id="vnpay">
                    <label for="vnpay">
                        VNPay
                        <i class="fas fa-credit-card"></i>
                    </label>
                </div>
                
                <div class="payment-option">
                    <input type="radio" name="paymentMethod" value="cod" id="cod">
                    <label for="cod">
                        Thanh toán tại quầy
                        <i class="fas fa-store"></i>
                    </label>
                </div>
                
                <div class="modal-buttons">
                    <button type="button" onclick="closePaymentModal()" class="btn-cancel">
                        <i class="fas fa-times me-2"></i>
                        Hủy
                    </button>
                    <button type="submit" class="btn-confirm">
                        <i class="fas fa-check me-2"></i>
                        Xác nhận
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function openPaymentModal() {
            document.getElementById('paymentModal').style.display = 'flex';
        }
        
        function closePaymentModal() {
            document.getElementById('paymentModal').style.display = 'none';
        }

        // Add hover effects to payment options
        document.querySelectorAll('.payment-option').forEach(option => {
            option.addEventListener('click', function() {
                this.querySelector('input[type="radio"]').checked = true;
            });
        });

        // Close modal when clicking outside
        document.getElementById('paymentModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closePaymentModal();
            }
        });
    </script>
</body>
</html>