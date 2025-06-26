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
                margin: 0;
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
                height: 200px;
                object-fit: cover;
                transition: transform 0.3s ease;
            }

            .order-card:hover .card-image img {
                transform: scale(1.1);
            }

            .card-content {
                padding: 25px;
                display: flex;
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
                top: 0;
                left: 0;
                width: 100vw;
                height: 100vh;
                background: rgba(0, 0, 0, 0.5);
                align-items: center;
                justify-content: center;
                backdrop-filter: blur(5px);
            }

            .modal-content {
                background: white;
                padding: 40px 30px;
                border-radius: 20px;
                width: 400px;
                max-width: 90vw;
                position: relative;
                box-shadow: 0 25px 50px rgba(0, 0, 0, 0.2);
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
        </style>
    </head>
    <body>
        <div class="container">
            <a href="javascript:history.back()" class="back-btn">← Quay lại</a>
            <c:choose>
                <c:when test="${sessionScope.nameUser.role eq 'AD'}">
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
                                    <td>${order.totalPrice}</td>
                                    <td>${order.note}</td>
                                    <td>${order.status == 0 ? "Chưa thanh toán" : "Đã thanh toán"}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
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
                                            <img src="assets/images/places/<c:out value='${order.idTour}'/>.jpg" alt="Tour image">
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
                                                        <form class="pay-order-form" method="get" >
                                                            <input type="hidden" name="action" value="openPayModal"/>
                                                            <input type="hidden" name="idBooking" value="${order.idBooking}"/>
                                                            <input type="hidden" name="totalPrice" value="${order.totalPrice}"/>
                                                            <input type="hidden" name="numberTicket" value="${order.numberTicket}"/>
                                                            <button class="btn-pay" type="submit" >Thanh toán</button>
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
                    <div id="paymentModal" style="display:none;position:fixed;z-index:9999;top:0;left:0;width:100vw;height:100vh;
                         background:rgba(0,0,0,0.3);align-items:center;justify-content:center;">
                        <div style="background:#fff;padding:32px 24px;border-radius:16px;width:350px;max-width:90vw;position:relative;">
                            <h3 style="margin-bottom:22px;">Chọn phương thức thanh toán</h3>
                            <form id="paymentForm" method="get" action="orderController">
                                <input type="hidden" name="action" value="updatePayOrder"/>
                                <input type="hidden" name="idBooking" value="${idBooking}"/>
                                <input type="hidden" name="totalBill2" value="${totalPrice}">
                                <input type="hidden" name="numberTicket2" value="${numberTicket}">
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
                        // Nếu có showModal thì mở modal khi load trang
                        window.onload = function () {
                        <% if ("true".equals(String.valueOf(request.getAttribute("showModal")))) { %>
                            document.getElementById('paymentModal').style.display = 'flex';
                        <% } %>
                        }
                        function closePaymentModal() {
                            document.getElementById('paymentModal').style.display = 'none';
                        }
                    </script>
                </c:otherwise>
            </c:choose>
        </div>
    </body>
</html>
