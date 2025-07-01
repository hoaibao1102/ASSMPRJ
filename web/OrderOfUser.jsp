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
<html>
    <head>
        <meta charset="UTF-8">
        <title>Đơn hàng của bạn</title>
        <style>
            * {
                
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                padding: 20px;
                color: #333;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                background: rgba(255, 255, 255, 0.95);
                border-radius: 20px;
                padding: 30px;
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
                backdrop-filter: blur(10px);
            }

            .back-btn {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                color: #667eea;
                text-decoration: none;
                font-weight: 500;
                margin-bottom: 25px;
                padding: 10px 16px;
                border-radius: 10px;
                transition: all 0.3s ease;
                background: rgba(102, 126, 234, 0.1);
            }

            .back-btn:hover {
                background: rgba(102, 126, 234, 0.2);
                transform: translateX(-5px);
            }

            h2 {
                color: #2d3748;
                margin-bottom: 30px;
                font-size: 2rem;
                font-weight: 700;
                text-align: center;
                background: linear-gradient(135deg, #667eea, #764ba2);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            /* Admin Table Styles */
            .order-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                background: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            }

            .order-table thead {
                background: linear-gradient(135deg, #667eea, #764ba2);
                color: white;
            }

            .order-table th,
            .order-table td {
                padding: 15px 12px;
                text-align: left;
                border-bottom: 1px solid #e2e8f0;
            }

            .order-table th {
                font-weight: 600;
                font-size: 0.9rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .order-table tbody tr {
                transition: all 0.3s ease;
            }

            .order-table tbody tr:hover {
                background: rgba(102, 126, 234, 0.05);
                transform: scale(1.01);
            }

            .order-table tbody tr:last-child td {
                border-bottom: none;
            }

            /* User Order Cards */
            .order-list {
                display: grid;
                gap: 25px;
                margin-top: 20px;
            }

            .order-card {
                display: grid;
                grid-template-columns: 200px 1fr;
                gap: 20px;
                background: white;
                border-radius: 20px;
                overflow: hidden;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
                border: 1px solid rgba(102, 126, 234, 0.1);
            }

            .order-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
            }

            .card-image {
                position: relative;
                overflow: hidden;
            }

            .card-image img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: transform 0.3s ease;
            }

            .order-card:hover .card-image img {
                transform: scale(1.1);
            }

            .card-content {
                padding: 25px;
                flex-direction: column;
                justify-content: space-between;
            }

            .card-content h3 {
                color: #2d3748;
                margin-bottom: 15px;
                font-size: 1.3rem;
                font-weight: 700;
            }

            .card-content p {
                margin-bottom: 8px;
                color: #4a5568;
                line-height: 1.5;
            }

            .card-content p strong {
                color: #2d3748;
                font-weight: 600;
            }

            .order-actions {
                margin-top: 20px;
                display: flex;
                align-items: center;
                gap: 15px;
            }

            .btn-pay {
                background: linear-gradient(135deg, #ff6b6b, #ee5a24);
                color: white;
                border: none;
                padding: 12px 24px;
                border-radius: 10px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                font-size: 0.9rem;
            }

            .btn-pay:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(255, 107, 107, 0.4);
                background: linear-gradient(135deg, #ee5a24, #ff6b6b);
            }

            .status-paid {
                background: linear-gradient(135deg, #00b894, #00cec9);
                color: white;
                padding: 8px 16px;
                border-radius: 20px;
                font-weight: 600;
                font-size: 0.85rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            /* Success Message */
            .success-message {
                background: linear-gradient(135deg, #00b894, #00cec9);
                color: white;
                padding: 15px 20px;
                border-radius: 10px;
                margin-bottom: 20px;
                text-align: center;
                font-weight: 600;
            }

            /* No Orders Message */
            .no-orders {
                text-align: center;
                padding: 60px 20px;
                color: #718096;
                font-size: 1.1rem;
            }

            .no-orders::before {
                content: "📋";
                display: block;
                font-size: 4rem;
                margin-bottom: 20px;
            }

            /* Payment Modal */
            #paymentModal {
                display: none;
                position: fixed;
                z-index: 9999;
                top: -23%;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                align-items: center;
                justify-content: center;
                backdrop-filter: blur(8px);
            }

            body.modal-open {
                overflow: hidden;
                position: fixed;
                width: 100%;
            }

            .modal-content {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                padding: 40px 30px;
                border-radius: 20px;
                width: 400px;
                max-width: 90vw;
                position: relative;
                box-shadow: 0 25px 50px rgba(0, 0, 0, 0.2);
                animation: modalSlideIn 0.3s ease;
                overflow: hidden;
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
                margin-bottom: 25px;
                color: #2d3748;
                font-size: 1.5rem;
                font-weight: 700;
                text-align: center;
            }

            .payment-option {
                display: flex;
                align-items: center;
                padding: 15px;
                margin-bottom: 10px;
                border: 2px solid #e2e8f0;
                border-radius: 10px;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .payment-option:hover {
                border-color: #667eea;
                background: rgba(102, 126, 234, 0.05);
            }

            .payment-option input[type="radio"] {
                margin-right: 12px;
                transform: scale(1.2);
            }

            .payment-option label {
                cursor: pointer;
                font-weight: 500;
                color: #2d3748;
            }

            .modal-buttons {
                display: flex;
                gap: 15px;
                justify-content: flex-end;
                margin-top: 25px;
            }

            .btn-cancel {
                padding: 10px 20px;
                border: 2px solid #e2e8f0;
                background: white;
                color: #4a5568;
                border-radius: 8px;
                cursor: pointer;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .btn-cancel:hover {
                border-color: #cbd5e0;
                background: #f7fafc;
            }

            .btn-confirm {
                background: linear-gradient(135deg, #ff6b6b, #ee5a24);
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 8px;
                cursor: pointer;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .btn-confirm:hover {
                transform: translateY(-1px);
                box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4);
            }

            .close-btn {
                position: absolute;
                top: 15px;
                right: 20px;
                cursor: pointer;
                font-size: 24px;
                color: #718096;
                transition: color 0.3s ease;
            }

            .close-btn:hover {
                color: #2d3748;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .container {
                    padding: 20px;
                    margin: 10px;
                }

                .order-card {
                    grid-template-columns: 1fr;
                }

                .card-image img {
                    height: 150px;
                }

                .order-table {
                    font-size: 0.85rem;
                }

                .order-table th,
                .order-table td {
                    padding: 10px 8px;
                }

                h2 {
                    font-size: 1.5rem;
                }
            }

            @media (max-width: 480px) {
                .modal-content {
                    padding: 25px 20px;
                }

                .modal-buttons {
                    flex-direction: column;
                }

                .btn-cancel,
                .btn-confirm {
                    width: 100%;
                }
            }

            body.modal-open {
                overflow: hidden;
                position: fixed;
                width: 100%;
            }
            /* Đã có trong file, nhưng nếu tách CSS ngoài thì giữ lại */
            .payment-option.selected {
                border-color: #667eea;
                background: rgba(102, 126, 234, 0.1);
                box-shadow: 0 4px 15px rgba(102, 126, 234, 0.2);
            }
            .payment-option .payment-icon {
                font-size: 1.2rem;
                margin-right: 6px;
            }
        </style>
    </head>
    <body>
        <div class="container">

            <c:choose>
                <c:when test="${sessionScope.nameUser.role eq 'AD'}">
                    <a href="javascript:history.back()" class="back-btn">← Quay lại</a>
                    <h2>Danh sách đơn hàng của ${requestScope.userName}</h2>

                    <table class="order-table">
                        <thead>
                            <tr>
                                <th>Mã đơn</th>
                                <th>Mã tour</th>
                                <th>Ngày đặt</th>
                                <th>Ngày khởi hành</th>
                                <th>Số vé</th>
                                <th>Tổng tiền</th>
                                <th>Ghi chú</th>
                                <th>Trạng thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${list}">
                                <tr>
                                    <td>${order.idTour}</td>
                                    <td>${order.idBooking}</td>
                                    <td>${order.bookingDate}</td>
                                    <td>${order.startNum}</td>
                                    <td>${order.numberTicket}</td>
                                    <td><fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="₫" groupingUsed="true"/></td>
                                    <td>${order.note}</td>
                                    <td>${order.status == 0 ? "Chưa thanh toán" : "Đã thanh toán"}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <a href="placeController?action=destination&page=indexjsp" class="back-btn">← Quay lại</a>
                    <h2>Danh sách đơn hàng của bạn</h2>
                    <c:set var="startDateMap" value="${requestScope.startDateMap}"/>
                    <c:choose>
                        <c:when test="${not empty startDateMap}">

                            <c:if test="${not empty message}">
                                <p style="color: green;"><b>${message}</b></p>
                                    </c:if>
                            <div class="order-list">
                                <c:forEach var="order" items="${list}">
                                    <div class="order-card">
                                        <div class="card-image">
                                            <img src="assets/images/places/${tourImgMap[order.idTour]}" alt="Tour image">
                                        </div>
                                        <div class="card-content">
                                            <h3>Đơn hàng: ${order.idBooking}</h3>
                                            <p><strong>Mã tour:</strong> ${order.idTour}</p>
                                            <p><strong>Ngày đặt:</strong> ${order.bookingDate}</p>
                                            <p><strong>Ngày khởi hành:</strong> ${startDateMap[order.idBooking]}</p>
                                            <p><strong>Số vé:</strong> ${order.numberTicket}</p>
                                            <p><strong>Tổng tiền:</strong> 
                                                <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                            </p>
                                            <p><strong>Ghi chú:</strong> ${order.note}</p>
                                            <div class="order-actions">
                                                <c:choose>
                                                    <c:when test="${order.status == 0}">
                                                        <form class="pay-order-form" action="orderController" method="get" >
                                                            <input type="hidden" name="action" value="openPayModal"/>
                                                            <input type="hidden" name="idBooking" value="${order.idBooking}"/>
                                                            <input type="hidden" name="totalPrice" value="${order.totalPrice}"/>
                                                            <input type="hidden" name="numberTicket" value="${order.numberTicket}"/>
                                                            <button class="btn-pay" type="button"
                                                                    onclick="openPaymentModal('${order.idBooking}', '${order.totalPrice}', '${order.numberTicket}')">Thanh toán</button>
                                                        </form>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-paid">Đã thanh toán</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p>Không có đơn hàng nào được tìm thấy.</p>
                        </c:otherwise>
                    </c:choose>
                    <!-- Popup/modal chọn phương thức thanh toán -->
                    <div id="paymentModal">
                        <div class="modal-content">
                            <span class="close-btn" onclick="closePaymentModal()">&times;</span>
                            <h3>Chọn phương thức thanh toán</h3>
                            <form id="paymentForm" method="get" action="orderController">
                                <input type="hidden" name="action" value="updatePayOrder"/>
                                <input type="hidden" id="idBooking" name="idBooking" value="">
                                <input type="hidden" id="totalPrice" name="totalBill2" value="">
                                <input type="hidden" id="numberTicket" name="numberTicket2" value="">

                                <div class="payment-option" onclick="selectPayment(event, 'momo')">
                                    <input type="radio" name="paymentMethod" value="momo" id="momo" checked>
                                    <label for="momo">
                                        <span class="payment-icon">📱</span>
                                        Momo
                                    </label>
                                </div>
                                <div class="payment-option" onclick="selectPayment(event, 'vnpay')">
                                    <input type="radio" name="paymentMethod" value="vnpay" id="vnpay">
                                    <label for="vnpay">
                                        <span class="payment-icon">💳</span>
                                        VNPay
                                    </label>
                                </div>
                                <div class="payment-option" onclick="selectPayment(event, 'cod')">
                                    <input type="radio" name="paymentMethod" value="cod" id="cod">
                                    <label for="cod">
                                        <span class="payment-icon">💰</span>
                                        Thanh toán tại quầy
                                    </label>
                                </div>
                                <div class="modal-buttons">
                                    <button type="button" class="btn-cancel" onclick="closePaymentModal()">Hủy</button>
                                    <button type="submit" class="btn-confirm">Xác nhận thanh toán</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <script>
                        // Lưu vị trí scroll
                        let scrollPosition = 0;

                        // Gọi khi user click "Thanh toán" (bạn cần sửa lại form button thành button thường gọi openPaymentModal)
                        function openPaymentModal(idBooking, totalPrice, numberTicket) {
                            scrollPosition = window.pageYOffset;
                            document.body.classList.add('modal-open');
                            document.body.style.top = -scrollPosition + 'px';

                            // Set giá trị cho form
                            document.getElementById('idBooking').value = idBooking;
                            document.getElementById('totalPrice').value = totalPrice;
                            document.getElementById('numberTicket').value = numberTicket;

                            // Reset các radio về mặc định, chọn momo
                            document.getElementById('momo').checked = true;
                            document.querySelectorAll('.payment-option').forEach((el, idx) => {
                                if (idx === 0)
                                    el.classList.add('selected');
                                else
                                    el.classList.remove('selected');
                            });

                            document.getElementById('paymentModal').style.display = 'flex';
                            document.getElementById('momo').focus();
                        }

                        function closePaymentModal() {
                            document.getElementById('paymentModal').style.display = 'none';
                            document.body.classList.remove('modal-open');
                            document.body.style.top = '';
                            window.scrollTo(0, scrollPosition);
                        }

                        // Chọn phương thức thanh toán, visual feedback
                        function selectPayment(event, method) {
                            document.querySelectorAll('.payment-option').forEach(option => option.classList.remove('selected'));
                            event.currentTarget.classList.add('selected');
                            document.getElementById(method).checked = true;
                        }

                        // Đóng modal bằng ESC
                        document.addEventListener('keydown', function (event) {
                            if (event.key === "Escape")
                                closePaymentModal();
                        });

                        // Đóng modal khi click ra ngoài
                        document.getElementById('paymentModal').addEventListener('click', function (event) {
                            if (event.target === this)
                                closePaymentModal();
                        });

                        // Ngăn scroll trên modal content
                        document.querySelector('.modal-content').addEventListener('wheel', function (event) {
                            event.stopPropagation();
                        });

                        // Nếu dùng nút submit mặc định của form thì không cần handle JS dưới đây.
                        // Nếu muốn xử lý AJAX, hãy dùng sự kiện submit của form:
                        /*
                         document.getElementById('paymentForm').addEventListener('submit', function(e){
                         e.preventDefault();
                         // Xử lý AJAX ở đây...
                         closePaymentModal();
                         // Optional: hiện success message
                         });
                         */
                    </script>
                </c:otherwise>
            </c:choose>
        </div>
    </body>
</html>
