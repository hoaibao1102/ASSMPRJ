<%-- 
    Document   : OrderForm
    Created on : May 29, 2025, 11:08:57 PM
    Author     : MSI PC
--%>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<%@ page import="DTO.TourDTO"%>
<%@ page import="DTO.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.text.DecimalFormat" %>
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
            table {
                width: 100%;
                border-collapse: collapse;
                font-size: 15px;
            }

            table td {
                padding: 8px 5px;
                vertical-align: top;
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
                    </a>

                    <div class="arrow">➜</div>


                    <div class="step current">
                        <div class="icon blue">
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

            <%
                UserDTO account = (UserDTO)session.getAttribute("nameUser");
                TourDTO tour = (TourDTO)session.getAttribute("tourTicket");
                int total = Integer.parseInt((String)request.getAttribute("total"));
                int numberTicket = Integer.parseInt((String)request.getAttribute("numberTicket"));
                DecimalFormat vnd = new DecimalFormat("#,###");
                
                //láy ra ngày dat
                LocalDate today = LocalDate.now();
                LocalDate tomorrow = today.plusDays(1);
                String todayStr = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                String tomorrowStr = tomorrow.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            %>



            <div class="containerdetail">
                <div class="left-content">
                    <h3>THÔNG TIN LIÊN LẠC</h3>
                    <table>
                        <tr><td><strong>Họ tên:</strong></td><td> <%=account.getFullName()%></td></tr>
                        <tr><td><strong>Email:</strong></td><td> <%=account.getEmail()%></td></tr>
                        <tr><td><strong>Điện thoại:</strong></td><td> <%=account.getPhone()%></td></tr>
                    </table>
                    <hr style="margin: 30px 0;">
                    <h3>CHI TIẾT BOOKING</h3>
                    <table>
                        <tr><td><strong>Mã đặt chỗ:</strong></td><td style="color:red;">CHUA XU LÝ CAN LAY DB</td></tr>
                        <tr><td><strong>Ngày tạo:</strong></td><td><%=todayStr%></td></tr>
                        <tr><td><strong>Số lượng:</strong></td><td> <%=numberTicket%></td></tr>
                        <tr><td><strong>Trị giá booking:</strong></td><td><%= vnd.format(total)%> đ</td></tr>

                        <tr>
                            <td><strong>Tình trạng:</strong></td>
                            <td style="color: blue;">Booking của quý khách đã được chúng tôi xác nhận thành công</td>
                        </tr>
                        <tr><td><strong>Thời hạn thanh toán:</strong></td><td style="color: red;"><%=tomorrowStr%></td></tr>
                    </table>
                </div>

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

                <!-- RIGHT: PHIẾU XÁC NHẬN -->
                <div class="right-content">
                    <h3>PHIẾU XÁC NHẬN BOOKING</h3>
                    <img src="assets/images/places/<%=tour.getImg()%>" alt="Tour" style="width:100%; border-radius: 8px; margin-bottom: 15px;">
                    <p><strong><%=tour.getDestination()%>:   </strong> <%=tour.getNameTour()%></p>
                    <p><strong>Số booking:</strong> <span style="color:red;">CHUA XU LY</span></p>
                    <p><strong>Mã tour:</strong> <%=tour.getIdTour()%></p>
                    <h4>THÔNG TIN CHUYẾN ÐI</h4>
                    <p>
                        Ngày đi: <%=tour.getStartDate()%> &nbsp;&nbsp;  <br>

                    </p>
                    <p>
                        Ngày về: <%=endDateStr%>&nbsp;&nbsp; <br>

                    </p>
                    <form action="orderController" method="get">
                        <input type="hidden" name="action" value="call_oder_step3">

                        <input type="hidden" name="totalBill2" value="<%=total%>">
                        <input type="hidden" name="numberTicket2" value="<%=numberTicket%>">
                        
                        <!-- Thay thế nút submit hiện tại -->
                        <button type="button" onclick="openPaymentModal()" style="width: 100%; padding: 15px; background-color: red; color: white; font-size: 16px; border: none; border-radius: 8px; margin-top: 20px;">
                            Thanh toán ngay
                        </button>
                    </form>
                </div>
            </div>
        </div>
        <%@include file="footer.jsp" %>
        <!-- Popup/modal chọn phương thức thanh toán -->
        <div id="paymentModal" style="display:none;position:fixed;z-index:9999;top:0;left:0;width:100vw;height:100vh;
             background:rgba(0,0,0,0.3);align-items:center;justify-content:center;">
            <div style="background:#fff;padding:32px 24px;border-radius:16px;width:350px;max-width:90vw;position:relative;">
                <h3 style="margin-bottom:22px;">Chọn phương thức thanh toán</h3>
                <form id="paymentForm" method="get" action="orderController">
                    <input type="hidden" name="action" value="call_oder_step3"/>
                    <label style="display:block;margin-bottom:10px;">
                        <input type="radio" name="paymentMethod" value="momo" checked> Momo
                    </label>
                    <label style="display:block;margin-bottom:10px;">
                        <input type="radio" name="paymentMethod" value="vnpay"> VNPay
                    </label>
                    <label style="display:block;margin-bottom:10px;">
                        <input type="radio" name="paymentMethod" value="cod"> Thanh toán tại quầy
                    </label>
                    <div style="margin-top:18px;text-align:right;">
                        <button type="button" onclick="closePaymentModal()" style="margin-right:10px;">Hủy</button>
                        <button type="submit" style="background:red;color:#fff;padding:8px 20px;border-radius:6px;border:none;">Xác nhận</button>
                    </div>
                </form>
                <span style="position:absolute;top:8px;right:16px;cursor:pointer;font-size:20px;" onclick="closePaymentModal()">×</span>
            </div>
        </div>
        <script>
            function openPaymentModal() {
                document.getElementById('paymentModal').style.display = 'flex';
            }
            function closePaymentModal() {
                document.getElementById('paymentModal').style.display = 'none';
            }
        </script>

    </body>
</html>
