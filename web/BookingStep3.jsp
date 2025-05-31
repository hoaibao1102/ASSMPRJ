<%-- 
    Document   : BookingStep3
    Created on : May 30, 2025, 3:57:52 PM
    Author     : Admin
--%>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="DTO.TourDTO"%>
<%@ page import="DTO.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hoàn tất thanh toán</title>
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
            .success-check {
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 15px;
            }
            .success-circle {
                width: 60px; height: 60px;
                border-radius: 50%;
                background: #4cd964;
                display: flex;
                align-items: center;
                justify-content: center;
                color: #fff;
                font-size: 36px;
                margin-right: 16px;
            }
            .success-message {
                font-size: 22px;
                font-weight: bold;
                color: #4cd964;
            }
            .info-row { margin-bottom: 18px;}
            .info-label { font-weight: bold; color: #333;}
            .info-value { color: #222;}
            .right-content h3 { margin-bottom: 12px;}
            .summary-done { color: #007bff; margin-bottom: 15px; }
            .btn-main {
                background: #d32f2f;
                color: #fff;
                border: none;
                padding: 13px 0;
                border-radius: 7px;
                font-size: 17px;
                font-weight: bold;
                width: 100%;
                margin-top: 18px;
                cursor: pointer;
                transition: background 0.2s;
            }
            .btn-main:hover { background: #b71c1c; }
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
            .step.current .icon {
                background-color: #007bff;
            }
            .step.current .label {
                color: #007bff;
            }
            .arrow {
                font-size: 18px;
                color: #ccc;
            }
        </style>
    </head>
    <body>
         <%
                UserDTO account = (UserDTO)session.getAttribute("nameUser");
                TourDTO tour = (TourDTO)session.getAttribute("tourTicket");
                int total = Integer.parseInt((String)request.getAttribute("total"));
                int numberTicket = Integer.parseInt((String)request.getAttribute("numberTicket"));
                DecimalFormat vnd = new DecimalFormat("#,###");
                
                LocalDate today = LocalDate.now();
                String todayStr = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                
             %>
        
        <%@include file="header.jsp" %>
        <div class="content">
            <div class="step-container">
                <h2 class="step-title">ĐẶT TOUR</h2>
                <div class="step-tracker">
                    
                        <div class="step active">
                            <div class="icon green">
                                <img src="assets/images/icon/icon_fillfile.jpg" alt="info" />
                            </div>
                            <div class="label">NHẬP THÔNG TIN</div>
                        </div>
                    
                    <div class="arrow">➜</div>
                   
                        <div class="step active">
                            <div class="icon green">
                                <img src="assets/images/icon/icon_thanhtoan.jpg" alt="pay" />
                            </div>
                            <div class="label">THANH TOÁN</div>
                        </div>
                    
                    <div class="arrow">➜</div>
                    <div class="step current">
                        <div class="icon blue">
                            <img src="assets/images/icon/icon_done.jpg" alt="done" />
                        </div>
                        <div class="label">HOÀN TẤT</div>
                    </div>
                </div>
            </div>
            <div class="containerdetail">
                <!-- LEFT: Xác nhận thành công -->
                <div class="left-content">
                    <div class="success-check">
                        <div class="success-circle">&#10004;</div>
                        <div class="success-message">Thanh toán thành công!</div>
                    </div>
                    <div class="summary-done">
                        Cảm ơn bạn đã đặt tour tại VN Tours.<br>
                        Thông tin booking của bạn đã được xác nhận.<br>
                        Chúng tôi đã gửi email xác nhận đến: <b><%=account.getEmail()%></b>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Mã đặt chỗ:</span> 
                        <span class="info-value" style="color:red">ABC123456</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Ngày tạo:</span>
                        <span class="info-value"><%=todayStr%></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Khách hàng:</span> 
                        <span class="info-value"><%=account.getFullName()%></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Điện thoại:</span>
                        <span class="info-value"><%=account.getPhone()%></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Trị giá booking:</span> 
                        <span class="info-value" style="color:#d32f2f;"><%= vnd.format(total)%> đ</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Tình trạng:</span>
                        <span class="info-value" style="color: #4cd964;">ĐÃ THANH TOÁN ĐẦY ĐỦ</span>
                    </div>
                    <div class="info-row" style="margin-top:28px;">
                        <a href="index.jsp" class="btn-main" style="text-align:center;display:block;">Về trang chủ</a>
                    </div>
                </div>
                <!-- RIGHT: Phiếu xác nhận tour -->
                
                <%
                        String startDateStr = tour.getStartDate();
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
                    <h3>PHIẾU XÁC NHẬN BOOKING</h3>
                    <img src="assets/images/places/<%=tour.getImg()%>" alt="Tour" style="width:100%; border-radius: 8px; margin-bottom: 15px;">
                    <p><strong><%=tour.getDestination()%>:  </strong><%=tour.getNameTour()%></p>
                    <p><strong>Mã tour:</strong> <%=tour.getIdTour()%></p>
                    <h4>THÔNG TIN CHUYẾN ĐI</h4>
                    <p>
                        Ngày đi: <%=tour.getStartDate()%> &nbsp;&nbsp; <br>
                    </p>
                    <p>
                        Ngày về: <%=endDateStr%>&nbsp;&nbsp; <br>
                    </p>
                    <div style="border-top:1px dashed #ccc;margin:20px 0;"></div>
                    <div class="info-label" style="margin-bottom:6px;">TỔNG TIỀN ĐÃ THANH TOÁN:</div>
                    <div style="font-size:19px; color:#d32f2f; font-weight:bold;margin-bottom:20px;"><%= vnd.format(total)%></div>
                    <a href="index.jsp" class="btn-main" style="text-align:center;display:block;">Tiếp tục khám phá tour khác</a>
                </div>
                 
            </div>
        </div>
        <%@include file="footer.jsp" %>
    </body>
</html>