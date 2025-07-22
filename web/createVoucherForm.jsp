<%-- 
    Document   : voucherForm
    Created on : Jul 11, 2025, 10:52:44 PM
    Author     : Admin
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>VN Tours</title>
        
        <!-- Bootstrap CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href="assets/css/create_voucher.css" rel="stylesheet">
        
    </head>
    <body>
        <div class="container-fluid">
            <div class="main-container">
                <!-- Back Button -->
                <div class="back-section">
                    <a href="javascript:void(0)" class="btn btn-back" onclick="window.history.back()">
                        <i class="bi bi-arrow-left"></i> Quay lại
                    </a>
                </div>

                <!-- Header -->
                <div class="header-section">
                    <c:choose>
                        <c:when test="${not empty voucher}">
                            <h1><i class="bi bi-ticket-perforated"></i>Sửa lại voucher giảm giá</h1>
                        </c:when>
                        <c:otherwise>
                            <h1><i class="bi bi-ticket-perforated"></i> Tạo voucher giảm giá</h1>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Form Container -->
                <div class="form-container">
                    <!-- Main Form -->
                    <form action="MainController" method="post">
                        <input type="hidden" name="action" value="${not empty voucher ? 'reuseVoucher' : 'createNewVoucher'}">
                        <c:if test="${not empty voucher}">
                            <input type="hidden" name="voucherID" value="${voucher.voucherID}">
                        </c:if>

                        <div class="row">
                            <!-- Voucher Title -->
                            <div class="col-12">
                                <div class="form-group">
                                    <label class="form-label">
                                        <i class="bi bi-tag"></i> Tên voucher
                                    </label>
                                    <input type="text" name="title" class="form-control" required minlength="10" 
                                           value="${not empty voucher ? voucher.title : ''}" 
                                           placeholder="Nhập tên voucher (tối thiểu 10 ký tự)">
                                    <div class="form-text">Tên voucher phải có ít nhất 10 ký tự</div>
                                </div>
                            </div>

                            <!-- Start Date -->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">
                                        <i class="bi bi-calendar-event"></i> Ngày bắt đầu
                                    </label>
                                    <input type="date" id="startDate" name="startDate" class="form-control" required 
                                           value="${not empty voucher ? voucher.startDate : ''}">
                                </div>
                            </div>

                            <!-- Duration -->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">
                                        <i class="bi bi-clock"></i> Thời lượng
                                    </label>
                                    <div class="input-group">
                                        <input type="number" name="duration" class="form-control" min="1" max="30" required 
                                               value="${not empty voucher ? voucher.duration : ''}" 
                                               placeholder="1-30">
                                        <span class="input-group-text">ngày</span>
                                    </div>
                                    <div class="form-text">Tối đa 30 ngày(1-30)</div>
                                </div>
                            </div>

                            <!-- Discount -->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">
                                        <i class="bi bi-percent"></i> Giá trị giảm
                                    </label>
                                    <div class="input-group">
                                        <input type="number" name="discount" class="form-control" step="0.1" required 
                                               min="0.1" max="100.0" value="${not empty voucher ? voucher.discount : ''}" 
                                               placeholder="0.1 - 100.0">
                                        <span class="input-group-text">%</span>
                                    </div>
                                </div>
                            </div>

                            <!-- Quantity -->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">
                                        <i class="bi bi-box"></i> Số lượng
                                    </label>
                                    <input type="number" name="numbers" class="form-control"  min="1" required 
                                           value="${not empty voucher ? voucher.numbers : ''}" 
                                           placeholder="Nhập số lượng voucher">
                                </div>
                            </div>

                            <!-- Minimum Order Value -->
                            <div class="col-12">
                                <div class="form-group">
                                    <label class="form-label">
                                        <i class="bi bi-cash-coin"></i> Giá trị đơn hàng tối thiểu
                                    </label>
                                    <div class="input-group">
                                        <input type="number" name="minimumOrderValue" class="form-control" step="0.1" 
                                               required min="0" value="${not empty voucher ? voucher.minimumOrderValue : ''}" 
                                               placeholder="Nhập giá trị tối thiểu">
                                        <span class="input-group-text">VNĐ</span>
                                    </div>
                                    <div class="form-text">Đơn hàng phải có giá trị tối thiểu để áp dụng voucher</div>
                                </div>
                            </div>
                        </div>

                        <!-- Submit Button -->
                        <button type="submit" class="btn btn-submit">
                            <i class="bi bi-check-circle"></i> Tạo Voucher
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        
        <script>
            // Lấy ngày hiện tại
            var today = new Date().toISOString().split('T')[0];
            document.getElementById('startDate').setAttribute('min', today);
        </script>
    </body>
</html>