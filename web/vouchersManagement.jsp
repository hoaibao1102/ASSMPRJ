<%-- 
    Document   : vouchersManager
    Created on : Jul 11, 2025, 11:11:45 PM
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

        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">
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
                --danger-light: #ffebee;
                --danger-color: #e74c3c;
                --success-light: #f0fff4;
                --success-color: #27ae60;
                /* Thêm màu cho nút sửa */
                --edit-light: #e0f7fa; /* Màu nền nhẹ nhàng cho nút sửa */
                --edit-color: #007bff; /* Màu chữ và viền cho nút sửa */
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
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 1rem;
                margin-left: 20%;
            }

            .header-section {
                background: var(--primary-white);
                border-radius: 20px;
                padding: 2rem;
                margin-bottom: 2rem;
                box-shadow: 0 8px 32px var(--shadow-light);
                text-align: center;
                position: relative;
                overflow: hidden;
            }

            .header-section::before {
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
            }

            .header-section .subtitle {
                font-size: 1.1rem;
                color: var(--text-secondary);
                font-weight: 400;
            }

            .btn-create {
                background: linear-gradient(135deg, var(--soft-blue) 0%, var(--soft-green) 100%);
                border: none;
                border-radius: 16px;
                padding: 1rem 2rem;
                color: var(--text-primary);
                font-weight: 600;
                font-size: 1.1rem;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                box-shadow: 0 8px 24px rgba(193, 233, 245, 0.3);
                margin-top: 1rem;
            }

            .btn-create:hover {
                background: linear-gradient(135deg, var(--soft-green) 0%, var(--soft-blue) 100%);
                transform: translateY(-3px);
                box-shadow: 0 12px 32px rgba(193, 233, 245, 0.4);
                color: var(--text-primary);
            }

            .section-card {
                background: var(--primary-white);
                border-radius: 20px;
                padding: 2rem;
                margin-bottom: 2rem;
                box-shadow: 0 8px 32px var(--shadow-light);
                border: 1px solid var(--border-light);
            }

            .section-title {
                font-size: 1.5rem;
                font-weight: 600;
                color: var(--text-primary);
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }

            .section-title.inactive {
                color: var(--danger-color);
            }

            .section-title.active {
                color: var(--success-color);
            }

            .section-title i {
                font-size: 1.2rem;
            }

            /* Cải thiện CSS cho table */
            .table-container {
                background: var(--primary-white);
                border-radius: 16px;
                overflow: hidden;
                box-shadow: 0 4px 20px var(--shadow-light);
                border: 1px solid var(--border-light);
            }

            .table {
                margin-bottom: 0;
                background: var(--primary-white);
                border-collapse: separate;
                border-spacing: 0;
            }

            .table thead {
                background: linear-gradient(135deg, var(--soft-yellow) 0%, var(--soft-beige) 100%);
            }

            .table thead th {
                border: 1px solid var(--border-light);
                border-bottom: 2px solid #dee2e6;
                padding: 1.25rem 1rem;
                font-weight: 600;
                color: var(--text-primary);
                font-size: 0.9rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                position: relative;
            }

            .table thead th:first-child {
                border-left: none;
            }

            .table thead th:last-child {
                border-right: none;
            }

            .table tbody tr {
                border-bottom: 1px solid var(--border-light);
                transition: all 0.3s ease;
            }

            .table tbody tr:hover {
                background: #f8f9fa;
                transform: translateX(2px);
            }

            .table tbody tr:last-child {
                border-bottom: none;
            }

            .table tbody td {
                padding: 1.25rem 1rem;
                vertical-align: middle;
                color: var(--text-primary);
                font-weight: 400;
                border-left: 1px solid var(--border-light);
                border-right: 1px solid var(--border-light);
            }

            .table tbody td:first-child {
                border-left: none;
            }

            .table tbody td:last-child {
                border-right: none;
            }

            /* Thêm border cho mỗi cell để tách biệt rõ ràng */
            .table th,
            .table td {
                border-right: 1px solid var(--border-light);
            }

            .table th:last-child,
            .table td:last-child {
                border-right: none;
            }

            /* Cải thiện zebra stripes cho table */
            .table tbody tr:nth-child(even) {
                background-color: #f8f9fa;
            }

            .table tbody tr:nth-child(odd) {
                background-color: var(--primary-white);
            }

            .table tbody tr:hover {
                background-color: #e3f2fd !important;
                transform: translateX(2px);
            }

            /* Cải thiện responsive cho table */
            @media (max-width: 768px) {
                .table-container {
                    overflow-x: auto;
                    border-radius: 12px;
                }

                .table {
                    min-width: 700px;
                }

                .table thead th,
                .table tbody td {
                    padding: 1rem 0.75rem;
                    font-size: 0.85rem;
                }

                .table thead th {
                    font-size: 0.8rem;
                }
            }

            .table tbody tr {
                border-bottom: 1px solid var(--border-light);
                transition: all 0.3s ease;
            }

            .table tbody tr:hover {
                background: #fafafa;
                transform: translateX(2px);
            }

            .table tbody tr:last-child {
                border-bottom: none;
            }

            .table tbody td {
                padding: 1.25rem 1rem;
                vertical-align: middle;
                color: var(--text-primary);
                font-weight: 400;
            }

            .btn-action {
                border: none;
                border-radius: 10px;
                padding: 0.6rem 1.2rem;
                font-weight: 500;
                font-size: 0.9rem;
                transition: all 0.3s ease;
                cursor: pointer;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                margin: 0 0.25rem; /* Thêm khoảng cách giữa các nút */
            }

            .btn-reuse {
                background: var(--soft-green);
                color: var(--text-primary);
                box-shadow: 0 4px 12px rgba(222, 245, 223, 0.4);
            }

            .btn-reuse:hover {
                background: var(--soft-blue);
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(193, 233, 245, 0.4);
            }

            .btn-delete {
                background: var(--danger-light);
                color: var(--danger-color);
                box-shadow: 0 4px 12px rgba(255, 235, 238, 0.4);
            }

            .btn-delete:hover {
                background: var(--danger-color);
                color: var(--primary-white);
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(231, 76, 60, 0.3);
            }
            
            /* CSS mới cho nút Sửa */
            .btn-edit {
                background: var(--edit-light);
                color: var(--edit-color);
                box-shadow: 0 4px 12px rgba(0, 123, 255, 0.2);
            }

            .btn-edit:hover {
                background: var(--edit-color);
                color: var(--primary-white);
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(0, 123, 255, 0.4);
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

            .empty-state {
                text-align: center;
                padding: 3rem 2rem;
                color: var(--text-secondary);
                background: var(--primary-white);
                border-radius: 16px;
                box-shadow: 0 4px 20px var(--shadow-light);
            }

            .empty-state i {
                font-size: 3rem;
                margin-bottom: 1rem;
                color: var(--soft-pink);
            }

            .empty-state h3 {
                font-size: 1.5rem;
                font-weight: 600;
                margin-bottom: 0.5rem;
                color: var(--text-primary);
            }

            .empty-state p {
                font-size: 1rem;
                color: var(--text-secondary);
            }

            .status-badge {
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                padding: 0.5rem 1rem;
                border-radius: 20px;
                font-size: 0.85rem;
                font-weight: 500;
            }

            .status-active {
                background: var(--success-light);
                color: var(--success-color);
            }

            .status-inactive {
                background: var(--danger-light);
                color: var(--danger-color);
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                body {
                    padding: 1rem 0;
                }

                .header-section,
                .section-card {
                    padding: 1.5rem;
                }

                .header-section h1 {
                    font-size: 2rem;
                    flex-direction: column;
                    gap: 0.5rem;
                }

                .table-container {
                    overflow-x: auto;
                }

                .table {
                    min-width: 700px;
                }

                .table thead th,
                .table tbody td {
                    padding: 1rem 0.75rem;
                    font-size: 0.85rem;
                }

                .btn-action {
                    padding: 0.5rem 1rem;
                    font-size: 0.8rem;
                }
            }

            @media (max-width: 576px) {
                .main-container {
                    padding: 0 0.5rem;
                }

                .header-section h1 {
                    font-size: 1.8rem;
                }

                .section-title {
                    font-size: 1.3rem;
                }

                .table {
                    min-width: 600px;
                }
            }

            /* Animation */
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

            .section-card {
                animation: slideIn 0.6s ease-out;
            }

            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: translateX(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateX(0);
                }
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        
        <div class="main-container">
            <div class="header-section">
                <h1><i class="bi bi-ticket-detailed"></i> Quản lý Vouchers</h1>
                <p class="subtitle">Quản lý và theo dõi các voucher của bạn</p>

                <form action="MainController" method="post" style="display: inline;">
                    <input type="hidden" name="action" value="goCreateNewVoucherForm">
                    <button type="submit" class="btn-create">
                        <i class="bi bi-plus-circle"></i> Tạo Voucher Mới
                    </button>
                </form>
            </div>

            <c:choose>
                <c:when test="${not empty listVoucher}">
                    <div class="section-card">
                        <h2 class="section-title inactive">
                            <i class="bi bi-pause-circle"></i> Vouchers Đang Ngưng Hoạt Động
                        </h2>

                        <c:set var="hasInactiveVouchers" value="false" />
                        <c:forEach var="vc" items="${listVoucher}">
                            <c:if test="${not vc.status}">
                                <c:set var="hasInactiveVouchers" value="true" />
                            </c:if>
                        </c:forEach>

                        <c:choose>
                            <c:when test="${hasInactiveVouchers}">
                                <div class="table-container">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th><i class="bi bi-tag me-2"></i>Tên Voucher</th>
                                                <th><i class="bi bi-calendar-event me-2"></i>Ngày Bắt Đầu</th>
                                                <th><i class="bi bi-clock me-2"></i>Thời Lượng</th>
                                                <th><i class="bi bi-percent me-2"></i>Giảm Giá</th>
                                                <th><i class="bi bi-box me-2"></i>Số Lượng</th>
                                                <th><i class="bi bi-cash-coin me-2"></i>Giá Trị Tối Thiểu</th>
                                                <th><i class="bi bi-gear me-2"></i>Thao Tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="vc" items="${listVoucher}">
                                                <c:if test="${not vc.status}">
                                                    <tr>
                                                        <td>
                                                            <div class="d-flex align-items-center gap-2">
                                                                <i class="bi bi-ticket-perforated text-muted"></i>
                                                                <span class="fw-medium">${vc.title}</span>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <span class="text-muted">${vc.startDate}</span>
                                                        </td>
                                                        <td>
                                                            <span class="badge bg-light text-dark">${vc.duration} ngày</span>
                                                        </td>
                                                        <td>
                                                            <span class="fw-semibold text-success">${vc.discount}%</span>
                                                        </td>
                                                        <td>
                                                            <span class="badge bg-secondary">${vc.numbers}</span>
                                                        </td>
                                                        <td>
                                                            <span class="fw-medium">${vc.minimumOrderValue} VNĐ</span>
                                                        </td>
                                                        <td>
                                                            <form action="MainController" method="post" style="display: inline-block;">
                                                                <input type="hidden" name="action" value="goReuseVoucherForm">
                                                                <input type="hidden" name="voucherID" value="${vc.voucherID}">
                                                                <button type="submit" class="btn-action btn-reuse">
                                                                    <i class="bi bi-arrow-clockwise me-1"></i> Dùng Lại
                                                                </button>
                                                            </form>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state">
                                    <i class="bi bi-inbox"></i>
                                    <h3>Không có voucher nào đang ngưng hoạt động</h3>
                                    <p>Tất cả voucher đều đang hoạt động bình thường</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="section-card">
                        <h2 class="section-title active">
                            <i class="bi bi-check-circle"></i> Vouchers Đang Hoạt Động
                        </h2>

                        <c:set var="hasActiveVouchers" value="false" />
                        <c:forEach var="vc" items="${listVoucher}">
                            <c:if test="${vc.status}">
                                <c:set var="hasActiveVouchers" value="true" />
                            </c:if>
                        </c:forEach>

                        <c:choose>
                            <c:when test="${hasActiveVouchers}">
                                <div class="table-container">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th><i class="bi bi-tag me-2"></i>Tên Voucher</th>
                                                <th><i class="bi bi-calendar-event me-2"></i>Ngày Bắt Đầu</th>
                                                <th><i class="bi bi-clock me-2"></i>Thời Lượng</th>
                                                <th><i class="bi bi-percent me-2"></i>Giảm Giá</th>
                                                <th><i class="bi bi-box me-2"></i>Số Lượng</th>
                                                <th><i class="bi bi-cash-coin me-2"></i>Giá Trị Tối Thiểu</th>
                                                <th><i class="bi bi-gear me-2"></i>Thao Tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="vc" items="${listVoucher}">
                                                <c:if test="${vc.status}">
                                                    <tr>
                                                        <td>
                                                            <div class="d-flex align-items-center gap-2">
                                                                <i class="bi bi-ticket-perforated text-success"></i>
                                                                <span class="fw-medium">${vc.title}</span>
                                                                <span class="status-badge status-active">
                                                                    <i class="bi bi-check-circle-fill"></i> Hoạt động
                                                                </span>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <span class="text-muted">${vc.startDate}</span>
                                                        </td>
                                                        <td>
                                                            <span class="badge bg-light text-dark">${vc.duration} ngày</span>
                                                        </td>
                                                        <td>
                                                            <span class="fw-semibold text-success">${vc.discount}%</span>
                                                        </td>
                                                        <td>
                                                            <span class="badge bg-secondary">${vc.numbers}</span>
                                                        </td>
                                                        <td>
                                                            <span class="fw-medium">${vc.minimumOrderValue} VNĐ</span>
                                                        </td>
                                                        <td>
                                                            <form action="MainController" method="post" style="display: inline-block;">
                                                                <input type="hidden" name="action" value="deleteVoucher">
                                                                <input type="hidden" name="voucherID" value="${vc.voucherID}">
                                                                <button type="submit" class="btn-action btn-delete" onclick="return confirm('Bạn có chắc chắn muốn xóa voucher này?')">
                                                                    <i class="bi bi-trash me-1"></i> Xóa
                                                                </button>
                                                            </form>
                                                            <form action="MainController" method="post" style="display: inline-block;">
                                                                <input type="hidden" name="action" value="goReuseVoucherForm"> 
                                                                <input type="hidden" name="voucherID" value="${vc.voucherID}">
                                                                <button type="submit" class="btn-action btn-edit" onclick="return confirm('Bạn có chắc chắn muốn sửa voucher này?')">
                                                                    <i class="bi bi-pencil-square me-1"></i> Sửa <%-- Đổi icon --%>
                                                                </button>
                                                            </form>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state">
                                    <i class="bi bi-inbox"></i>
                                    <h3>Không có voucher nào đang hoạt động</h3>
                                    <p>Hãy tạo voucher mới để bắt đầu</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="bi bi-ticket-detailed"></i>
                        <h3>Danh sách voucher hiện tại đang trống!</h3>
                        <p>Hãy tạo voucher đầu tiên của bạn để bắt đầu quản lý</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    </body>
</html>