<%-- 
    Document   : OrderOfUser
    Created on : Jun 18, 2025, 11:24:40 PM
    Author     : MSI PC
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, DTO.OrderDTO , UTILS.AuthUtils"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>VN Tours</title>

        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

        <link href="assets/css/order_of_user.css" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <div class="main-container">
                <c:choose>
                    <c:when test="${sessionScope.nameUser.role eq 'AD'}">
                        <!-- Admin View -->
                        <div class="header-section">
                            <div class="container">
                                <div class="row align-items-center">
                                    <div class="col-auto">
                                        <a href="javascript:history.back()" class="back-btn">
                                            <i class="bi bi-arrow-left"></i> Quay lại
                                        </a>
                                    </div>
                                    <div class="col">
                                        <h1 class="page-title">
                                            <i class="bi bi-person-gear me-3"></i>
                                            Danh sách đơn hàng của ${requestScope.userName}
                                        </h1>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="admin-table-container">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <td><strong><i class="bi bi-hash me-2"></i>Mã đơn</strong></td>
                                            <td><strong><i class="bi bi-geo-alt me-2"></i>Mã tour</strong></td>
                                            <td><strong><i class="bi bi-calendar-event me-2"></i>Ngày đặt</strong></td>
                                            <td><strong><i class="bi bi-calendar-check me-2"></i>Ngày khởi hành</strong></td>
                                            <td><strong><i class="bi bi-ticket-perforated me-2"></i>Số vé</strong></td>
                                            <td><strong><i class="bi bi-currency-dollar me-2"></i>Tổng tiền</strong></td>
                                            <td><strong><i class="bi bi-chat-dots me-2"></i>Ghi chú</strong></td>
                                            <td><strong><i class="bi bi-check-circle me-2"></i>Trạng thái</strong></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="order" items="${list}">
                                            <tr>
                                                <td><strong>${order.idTour}</strong></td>
                                                <td><span class="badge bg-primary">${order.idBooking}</span></td>
                                                <td>${order.bookingDate}</td>
                                                <td>${order.startDate}</td>
                                                <td><span class="badge bg-secondary">${order.numberTicket}</span></td>
                                                <td class="price-value">
                                                    <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                                </td>
                                                <td>${order.note}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${order.status == 0}">
                                                            <span class="badge bg-warning">
                                                                <i class="bi bi-clock me-1"></i>Chưa thanh toán
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-success">
                                                                <i class="bi bi-check-circle me-1"></i>Đã thanh toán
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- User View -->
                        <div class="header-section">
                            <div class="container">
                                <div class="row align-items-center">
                                    <div class="col-auto">
                                        <a href="placeController?action=destination&page=indexjsp" class="back-btn">
                                            <i class="bi bi-arrow-left"></i> Quay lại
                                        </a>
                                    </div>
                                    <div class="col">
                                        <h1 class="page-title">
                                            <i class="bi bi-bag-check me-3"></i>
                                            Danh sách đơn hàng của bạn
                                        </h1>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="orders-container">
                            <c:set var="startDateMap" value="${requestScope.startDateMap}"/>
                            <c:choose>
                                <c:when test="${not empty startDateMap}">
                                    <c:if test="${not empty message}">
                                        <div class="success-message">
                                            <i class="bi bi-check-circle-fill"></i>
                                            <strong>${message}</strong>
                                        </div>
                                    </c:if>

                                    <div class="row">
                                        <c:forEach var="order" items="${list}">
                                            <div class="col-12 col-lg-6 col-xl-4">
                                                <div class="order-card">
                                                    <div class="order-card-header">
                                                        <h5>
                                                            <i class="bi bi-receipt"></i>
                                                            Đơn hàng: ${order.idBooking}
                                                        </h5>
                                                    </div>

                                                    <div class="order-image">
                                                        <img src="${tourImgMap[order.idTour]}" alt="Tour image" class="img-fluid">
                                                    </div>

                                                    <div class="order-details">
                                                        <div class="detail-item">
                                                            <div class="detail-label">
                                                                <i class="bi bi-geo-alt"></i>
                                                                Mã tour:
                                                            </div>
                                                            <div class="detail-value">
                                                                <span class="badge bg-primary">${order.idTour}</span>
                                                            </div>
                                                        </div>

                                                        <div class="detail-item">
                                                            <div class="detail-label">
                                                                <i class="bi bi-calendar-event"></i>
                                                                Ngày đặt:
                                                            </div>
                                                            <div class="detail-value">${order.bookingDate}</div>
                                                        </div>

                                                        <div class="detail-item">
                                                            <div class="detail-label">
                                                                <i class="bi bi-calendar-check"></i>
                                                                Ngày khởi hành:
                                                            </div>
                                                            <div class="detail-value">${startDateMap[order.idBooking]}</div>
                                                        </div>

                                                        <div class="detail-item">
                                                            <div class="detail-label">
                                                                <i class="bi bi-ticket-perforated"></i>
                                                                Số vé:
                                                            </div>
                                                            <div class="detail-value">
                                                                <span class="badge bg-secondary">${order.numberTicket}</span>
                                                            </div>
                                                        </div>

                                                        <div class="detail-item">
                                                            <div class="detail-label">
                                                                <i class="bi bi-currency-dollar"></i>
                                                                Tổng tiền:
                                                            </div>
                                                            <div class="detail-value price-value">
                                                                <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                                            </div>
                                                        </div>

                                                        <div class="detail-item">
                                                            <div class="detail-label">
                                                                <i class="bi bi-chat-dots"></i>
                                                                Ghi chú:
                                                            </div>
                                                            <div class="detail-value">${order.note}</div>
                                                        </div>
                                                    </div>

                                                    <div class="payment-actions">
                                                        <c:choose>
                                                            <c:when test="${order.status == 0}">
                                                                <form class="pay-order-form" action="MainController" method="post">
                                                                    <input type="hidden" name="action" value="openPayModal"/>
                                                                    <input type="hidden" name="idBooking" value="${order.idBooking}"/>
                                                                    <input type="hidden" name="totalPrice" value="${order.totalPrice}"/>
                                                                    <input type="hidden" name="numberTicket" value="${order.numberTicket}"/>
                                                                    <button class="btn btn-pay w-100" type="button"
                                                                            onclick="openPaymentModal('${order.idBooking}', '${order.totalPrice}', '${order.numberTicket}')"
                                                                            aria-label="Thanh toán đơn hàng ${order.idBooking}">
                                                                        <i class="bi bi-credit-card me-2"></i>
                                                                        Thanh toán ngay
                                                                    </button>
                                                                </form>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="status-paid">
                                                                    <i class="bi bi-check-circle"></i>
                                                                    Đã thanh toán
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="no-orders">
                                        <div class="no-orders-icon">
                                            <i class="bi bi-bag-x"></i>
                                        </div>
                                        <h3>Chưa có đơn hàng nào</h3>
                                        <p class="text-muted">Bạn chưa có đơn hàng nào được tìm thấy.</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

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
                                            <input type="hidden" name="action" value="updatePayOrder"/>
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
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Bootstrap 5 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
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
        </script>
    </body>
</html>