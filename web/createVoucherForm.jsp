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
        
        <style>
            :root {
                --primary-white: #ffffff;
                --soft-pink: #F5D0DF;
                --soft-yellow: #F5F3DC;
                --soft-blue: #C1E9F5;
                --soft-green: #DEF5DF;
                --soft-beige: #F5E5D5;
                --text-primary: #2c3e50;
                --text-secondary: #6c757d;
                --border-light: #e9ecef;
                --shadow-light: rgba(0, 0, 0, 0.05);
                --shadow-medium: rgba(0, 0, 0, 0.1);
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
                background: linear-gradient(135deg, #fafafa 0%, #f5f5f5 100%);
                color: var(--text-primary);
                line-height: 1.6;
                min-height: 100vh;
                padding: 2rem 0;
            }

            .main-container {
                max-width: 900px;
                margin: 0 auto;
                background: var(--primary-white);
                border-radius: 24px;
                box-shadow: 0 20px 60px var(--shadow-medium);
                overflow: hidden;
                position: relative;
            }

            .main-container::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 6px;
                background: linear-gradient(90deg, 
                    var(--soft-pink) 0%, 
                    var(--soft-yellow) 25%, 
                    var(--soft-blue) 50%, 
                    var(--soft-green) 75%, 
                    var(--soft-beige) 100%);
                border-radius: 24px 24px 0 0;
            }

            .back-section {
                padding: 2rem 2rem 0;
            }

            .btn-back {
                background: var(--primary-white);
                border: 2px solid var(--soft-blue);
                color: var(--text-primary);
                border-radius: 16px;
                padding: 0.75rem 1.5rem;
                font-weight: 500;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                box-shadow: 0 4px 12px var(--shadow-light);
            }

            .btn-back:hover {
                background: var(--soft-blue);
                border-color: var(--soft-blue);
                color: var(--text-primary);
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(193, 233, 245, 0.3);
            }

            .header-section {
                padding: 2rem 2rem 3rem;
                text-align: center;
                background: linear-gradient(135deg, var(--primary-white) 0%, #fafafa 100%);
            }

            .header-section h1 {
                font-size: 2.5rem;
                font-weight: 700;
                color: var(--text-primary);
                margin-bottom: 0.5rem;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 1rem;
            }

            .header-section h1 i {
                color: var(--soft-pink);
                font-size: 2.2rem;
            }

            .header-section .subtitle {
                font-size: 1.1rem;
                color: var(--text-secondary);
                font-weight: 400;
            }

            .form-container {
                padding: 0 2rem 3rem;
            }

            .form-group {
                margin-bottom: 2rem;
            }

            .form-label {
                font-weight: 600;
                color: var(--text-primary);
                margin-bottom: 0.8rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
                font-size: 0.95rem;
            }

            .form-label i {
                width: 18px;
                height: 18px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: var(--text-secondary);
            }

            .form-control {
                border: 2px solid var(--border-light);
                border-radius: 16px;
                padding: 1rem 1.25rem;
                font-size: 1rem;
                font-weight: 400;
                transition: all 0.3s ease;
                background: var(--primary-white);
                color: var(--text-primary);
                box-shadow: 0 2px 8px var(--shadow-light);
            }

            .form-control:focus {
                border-color: var(--soft-blue);
                box-shadow: 0 0 0 0.2rem rgba(193, 233, 245, 0.25);
                background: var(--primary-white);
                outline: none;
            }

            .form-control:hover {
                border-color: var(--soft-green);
                box-shadow: 0 4px 12px var(--shadow-light);
            }

            .form-control::placeholder {
                color: var(--text-secondary);
                opacity: 0.7;
            }

            .input-group {
                position: relative;
            }

            .input-group .form-control {
                padding-right: 4rem;
            }

            .input-group .input-group-text {
                position: absolute;
                right: 1rem;
                top: 50%;
                transform: translateY(-50%);
                background: var(--soft-yellow);
                border: none;
                color: var(--text-primary);
                font-weight: 500;
                z-index: 3;
                padding: 0.5rem 0.75rem;
                border-radius: 8px;
                font-size: 0.9rem;
            }

            .btn-submit {
                background: linear-gradient(135deg, var(--soft-pink) 0%, var(--soft-beige) 100%);
                border: none;
                border-radius: 16px;
                padding: 1.2rem 3rem;
                color: var(--text-primary);
                font-weight: 600;
                font-size: 1.1rem;
                transition: all 0.3s ease;
                width: 100%;
                margin-top: 1rem;
                box-shadow: 0 8px 24px rgba(245, 208, 223, 0.3);
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
            }

            .btn-submit:hover {
                background: linear-gradient(135deg, var(--soft-beige) 0%, var(--soft-pink) 100%);
                transform: translateY(-3px);
                box-shadow: 0 12px 32px rgba(245, 208, 223, 0.4);
                color: var(--text-primary);
            }

            .form-text {
                color: var(--text-secondary);
                font-size: 0.875rem;
                margin-top: 0.5rem;
                font-weight: 400;
            }

            .row {
                margin-left: -0.75rem;
                margin-right: -0.75rem;
            }

            .col-md-6 {
                padding-left: 0.75rem;
                padding-right: 0.75rem;
            }
            

            /* Responsive Design */
            @media (max-width: 768px) {
                body {
                    padding: 1rem 0;
                }

                .main-container {
                    margin: 0 1rem;
                    border-radius: 20px;
                }
                
                .back-section {
                    padding: 1.5rem 1.5rem 0;
                }
                
                .header-section {
                    padding: 1.5rem 1.5rem 2rem;
                }
                
                .header-section h1 {
                    font-size: 2rem;
                    flex-direction: column;
                    gap: 0.5rem;
                }
                
                .form-container {
                    padding: 0 1.5rem 2rem;
                }

                .form-control {
                    padding: 0.9rem 1rem;
                }

                .btn-submit {
                    padding: 1rem 2rem;
                    font-size: 1rem;
                }
            }

            @media (max-width: 576px) {
                .header-section h1 {
                    font-size: 1.8rem;
                }

                .form-control {
                    font-size: 0.95rem;
                }
            }

            /* Focus styles for accessibility */
            .form-control:focus,
            .btn-back:focus,
            .btn-submit:focus {
                outline: 2px solid var(--soft-blue);
                outline-offset: 2px;
            }

            /* Animation for smooth transitions */
            .main-container {
                animation: fadeInUp 0.6s ease-out;
            }

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
        </style>
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
                                        <input type="number" name="duration" class="form-control" min="0" max="30" required 
                                               value="${not empty voucher ? voucher.duration : ''}" 
                                               placeholder="1-30">
                                        <span class="input-group-text">ngày</span>
                                    </div>
                                    <div class="form-text">Tối đa 30 ngày</div>
                                </div>
                            </div>

                            <!-- Discount -->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">
                                        <i class="bi bi-percent"></i> Giá trị giảm
                                    </label>
                                    <div class="input-group">
                                        <input type="number" name="discount" class="form-control" step="0.01" required 
                                               min="0.0" max="100.0" value="${not empty voucher ? voucher.discount : ''}" 
                                               placeholder="0.0 - 100.0">
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
                                        <input type="number" name="minimumOrderValue" class="form-control" step="0.01" 
                                               required min="1" value="${not empty voucher ? voucher.minimumOrderValue : ''}" 
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