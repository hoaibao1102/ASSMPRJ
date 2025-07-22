<%-- 
    Document   : BookingStep2 
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
        <title>VN Tours</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
        <link href="assets/css/booking_step_2.css" rel="stylesheet">
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
            
                // Lấy ra ngày đặt

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

                    <hr class="my-4" style="border: 2px solid var(--secondary-yellow); opacity: 0.3;">

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
                    <img src="<%=tour.getImg_Tour()%>" alt="Tour" class="tour-image">

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

                        <form action="MainController" method="post">
                            <input type="hidden" name="action" value="call_oder_step3">
                            <input type="hidden" name="totalBill2" value="<%=newBooking.getTotalPrice()%>">
                            <input type="hidden" name="numberTicket2" value="<%=newBooking.getNumberTicket()%>">

                            <button type="button" onclick="openPaymentModal('<%=newBooking.getIdBooking()%>','<%=newBooking.getTotalPrice()%>', '<%=newBooking.getNumberTicket()%>')" class="payment-btn">
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
        <div class="modal fade" id="paymentModal" tabindex="-1" aria-labelledby="paymentModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="paymentModalLabel">
                            <i class="bi bi-credit-card"></i>
                            Chọn phương thức thanh toán
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                    </div>
                    <div class="modal-body">
                        <form id="paymentForm" method="post" action="MainController">
                            <input type="hidden" name="action" value="call_oder_step3"/>
                            <input type="hidden" id="idBooking" name="idBooking" value="">
                            <input type="hidden" id="totalPrice" name="totalBill2" value="">
                            <input type="hidden" id="numberTicket" name="numberTicket2" value="">

                            <div class="payment-option" onclick="selectPayment(event, 'momo')">
                                <div class="payment-icon">
                                    <i class="bi bi-phone"></i>
                                </div>
                                <div class="payment-label">
                                    <strong>Momo</strong>
                                    <br><small>Thanh toán qua ví điện tử Momo</small>
                                </div>
                                <input type="radio" name="paymentMethod" value="momo" class="form-check-input">
                            </div>

                            <div class="payment-option" onclick="selectPayment(event, 'bank')">
                                <div class="payment-icon">
                                    <i class="bi bi-bank"></i>
                                </div>
                                <div class="payment-label">
                                    <strong>Chuyển khoản ngân hàng</strong>
                                    <br><small>Thanh toán qua tài khoản ngân hàng</small>
                                </div>
                                <input type="radio" name="paymentMethod" value="bank" class="form-check-input">
                            </div>

                            <div class="payment-option" onclick="selectPayment(event, 'cash')">
                                <div class="payment-icon">
                                    <i class="bi bi-cash"></i>
                                </div>
                                <div class="payment-label">
                                    <strong>Tiền mặt</strong>
                                    <br><small>Thanh toán bằng tiền mặt khi nhận dịch vụ</small>
                                </div>
                                <input type="radio" name="paymentMethod" value="cash" class="form-check-input">
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-cancel" data-bs-dismiss="modal">Hủy</button>
                        <button type="button" class="btn btn-confirm" onclick="confirmPayment()">Xác nhận thanh toán</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
//                            function openPaymentModal() {
//                                document.getElementById('paymentModal').style.display = 'flex';
//                            }
//
//                            function closePaymentModal() {
//                                document.getElementById('paymentModal').style.display = 'none';
//                            }
//
//
//                            // Add hover effects to payment options
//                            document.querySelectorAll('.payment-option').forEach(option => {
//                                option.addEventListener('click', function () {
//                                    this.querySelector('input[type="radio"]').checked = true;
//                                });
//                            });

                            function openPaymentModal(idBooking, totalPrice, numberTicket) {
                                document.getElementById('idBooking').value = idBooking;
                                document.getElementById('totalPrice').value = totalPrice;
                                document.getElementById('numberTicket').value = numberTicket;

                                // Clear previous selections
                                document.querySelectorAll('.payment-option').forEach(option => {
                                    option.classList.remove('selected');
                                });
                                document.querySelectorAll('input[name="paymentMethod"]').forEach(radio => {
                                    radio.checked = false;
                                });

                                const modal = new bootstrap.Modal(document.getElementById('paymentModal'));
                                modal.show();
                            }

                            function selectPayment(event, method) {
                                // Remove selected class from all options
                                document.querySelectorAll('.payment-option').forEach(option => {
                                    option.classList.remove('selected');
                                });

                                // Add selected class to clicked option
                                event.currentTarget.classList.add('selected');

                                // Check the corresponding radio button
                                const radio = event.currentTarget.querySelector('input[type="radio"]');
                                if (radio) {
                                    radio.checked = true;
                                }
                            }

                            function confirmPayment() {
                                const selectedPayment = document.querySelector('input[name="paymentMethod"]:checked');
                                if (!selectedPayment) {
                                    alert('Vui lòng chọn phương thức thanh toán!');
                                    return;
                                }

                                // Submit the form
                                document.getElementById('paymentForm').submit();
                            }



                            // Close modal when clicking outside
                            document.getElementById('paymentModal').addEventListener('click', function (e) {
                                if (e.target === this) {
                                    closePaymentModal();
                                }
                            });
        </script>
    </body>
</html>