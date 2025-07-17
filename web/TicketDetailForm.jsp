<%--
    Document   : TourDetailForm
    Created on : May 21, 2025, 11:14:40 PM
    Author     : MSI PC
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết Tour</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-blue: #0EA5E9;
                --primary-orange: #FF6B35;
                --primary-green: #10B981;
                --secondary-yellow: #F59E0B;
                --secondary-purple: #8B5CF6;
                --text-dark: #1F2937;
                --text-medium: #6B7280;
                --gradient-primary: linear-gradient(135deg, #0EA5E9, #10B981);
                --gradient-secondary: linear-gradient(135deg, #FF6B35, #F59E0B);

                --vietnam-blue: #0EA5E9;
            }

            body {
                padding-top: 100px;
                background: #FEFEFE;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                line-height: 1.6;
            }

            .content {
                min-height: 100vh;
                padding: 2rem 0;
            }
            
            .other-content{
                margin-left: 20%;
            }

            /* Breadcrumb */
            .breadcrumb-modern {
                background: var(--gradient-primary);
                padding: 1rem 0;
                margin-bottom: 2rem;
                border-radius: 10px;
            }

            .custom-breadcrumb {
                background: linear-gradient(90deg, rgba(14,165,233,0.1) 0%, rgba(16,185,129,0.1) 100%);
                border-radius: 50px;
                padding: 1rem 2rem;
                margin: 2rem 0;
                border: 1px solid rgba(14,165,233,0.2);
                box-shadow: 0 2px 10px rgba(14,165,233,0.1);
            }

            .custom-breadcrumb a {
                color: var(--vietnam-blue);
                text-decoration: none;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .custom-breadcrumb a:hover {
                color: var(--vietnam-emerald);
                text-decoration: underline;
            }

            .custom-breadcrumb .current {
                color: var(--text-primary);
                font-weight: 700;
            }

            .custom-breadcrumb i {
                color: var(--vietnam-coral);
            }

            /* Main Container */
            .tour-container {
                background: white;
                border-radius: 10px;
                overflow: hidden;
                margin-bottom: 2rem;
                border: 1px solid #e5e7eb;
            }

            /* Left Content */
            .tour-content {
                padding: 2rem;
            }

            .tour-title {
                font-size: 2.5rem;
                font-weight: 700;
                background: var(--gradient-secondary);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                text-align: center;
                margin-bottom: 2rem;
                text-transform: uppercase;
                letter-spacing: 2px;
            }

            /* Gallery */
            .gallery-container {
                background: #f8f9fa;
                border-radius: 10px;
                padding: 1.5rem;
                margin-bottom: 2rem;
            }

            .thumbnail-wrapper {
                max-height: 450px;
                overflow-y: auto;
                padding-right: 10px;
            }

            .thumbnail-wrapper::-webkit-scrollbar {
                width: 6px;
            }

            .thumbnail-wrapper::-webkit-scrollbar-track {
                background: #f1f1f1;
            }

            .thumbnail-wrapper::-webkit-scrollbar-thumb {
                background: var(--primary-orange);
                border-radius: 10px;
            }

            .thumbnail-img {
                width: 100%;
                height: 80px;
                object-fit: cover;
                border-radius: 10px;
                cursor: pointer;
                margin-bottom: 10px;
                border: 2px solid transparent;
                transition: border-color 0.3s;
            }

            .thumbnail-img:hover {
                border-color: var(--primary-orange);
            }

            .main-image-container {
                position: relative;
                border-radius: 10px;
                overflow: hidden;
            }

            .main-img {
                width: 100%;
                height: 400px;
                object-fit: cover;
                cursor: pointer;
                border-radius: 10px;
            }

            .image-overlay {
                position: absolute;
                bottom: 0;
                left: 0;
                right: 0;
                background: linear-gradient(transparent, rgba(0,0,0,0.7));
                color: white;
                padding: 1rem;
                text-align: center;
            }

            /* Accordion */
            .tour-accordion {
                margin-top: 2rem;
            }

            .accordion-button {
                background: var(--gradient-secondary);
                color: white;
                border: none;
                font-weight: 600;
                font-size: 1.1rem;
                padding: 1rem 1.5rem;
                border-radius: 10px !important;
            }

            .accordion-button:not(.collapsed) {
                background: var(--gradient-primary);
                color: white;
            }

            .accordion-button::after {
                background-image: none;
                content: "\f107";
                font-family: "Font Awesome 6 Free";
                font-weight: 900;
                font-size: 1.2rem;
            }

            .accordion-button:not(.collapsed)::after {
                transform: rotate(180deg);
            }

            .accordion-body {
                background: white;
                border-radius: 0 0 10px 10px;
                padding: 1.5rem;
                border: none;
            }

            .day-section {
                background: white;
                border-radius: 8px;
                padding: 1rem;
                margin-bottom: 1rem;
                border-left: 4px solid var(--primary-orange);
            }

            .day-section h5 {
                color: var(--text-dark);
                font-weight: 700;
                margin-bottom: 0.5rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }
            /* Review Section Styles */
            .review-section {
                background: white;
                border-radius: 15px;
                padding: 2rem;
                margin-top: 2rem;
                border: 1px solid #e5e7eb;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            }
            .review-header {
                background: var(--gradient-primary);
                color: white;
                padding: 1.5rem;
                border-radius: 10px;
                margin-bottom: 2rem;
                text-align: center;
            }
            .review-stats {
                display: flex;
                justify-content: space-around;
                background: #f8f9fa;
                border-radius: 10px;
                padding: 1.5rem;
                margin-bottom: 2rem;
            }
            .stat-item {
                text-align: center;
            }
            .stat-number {
                font-size: 2rem;
                font-weight: 700;
                color: var(--primary-orange);
            }
            .stat-label {
                font-size: 0.9rem;
                color: var(--text-medium);
                margin-top: 0.5rem;
            }
            .review-actions {
                text-align: center;
                margin: 2rem 0;
            }
            .review-item {
                background: #f8f9fa;
                border-radius: 10px;
                padding: 1.5rem;
                margin-bottom: 1.5rem;
                border-left: 4px solid var(--primary-blue);
                transition: all 0.3s ease;
            }
            .review-item:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
            }
            .review-header-info {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1rem;
            }
            .reviewer-info {
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }
            .reviewer-avatar {
                width: 45px;
                height: 45px;
                border-radius: 50%;
                background: var(--gradient-secondary);
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-weight: 600;
                font-size: 1.2rem;
            }
            .reviewer-name {
                font-weight: 600;
                color: var(--text-dark);
            }
            .review-date {
                font-size: 0.9rem;
                color: var(--text-medium);
            }
            .rating {
                display: flex;
                gap: 0.25rem;
            }
            .star {
                color: #fbbf24;
                font-size: 1.1rem;
            }
            .star.empty {
                color: #e5e7eb;
            }
            .review-content {
                color: var(--text-dark);
                line-height: 1.6;
                margin-bottom: 1rem;
            }
            .no-reviews {
                text-align: center;
                padding: 3rem;
                color: var(--text-medium);
            }
            .no-reviews i {
                font-size: 3rem;
                color: var(--text-medium);
                margin-bottom: 1rem;
            }
            /* Right Sidebar */
            .booking-sidebar {
                background: white;
                border-radius: 10px;
                padding: 2rem;
                margin-top: 2rem;
                border: 1px solid #e5e7eb;
            }

            .price-section {
                text-align: center;
                margin-bottom: 2rem;
                padding: 1.5rem;
                background: var(--gradient-secondary);
                border-radius: 10px;
                color: white;
            }

            .original-price {
                font-size: 1.1rem;
                text-decoration: line-through;
                opacity: 0.8;
                margin-bottom: 0.5rem;
            }

            .current-price {
                font-size: 2.5rem;
                font-weight: 700;
            }

            .discount-badge {
                background: var(--secondary-yellow);
                color: var(--text-dark);
                padding: 0.75rem 1rem;
                border-radius: 10px;
                font-weight: 600;
                margin: 1rem 0;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .tour-details {
                background: #f8f9fa;
                border-radius: 10px;
                padding: 1.5rem;
                margin-bottom: 2rem;
            }

            .detail-item {
                display: flex;
                align-items: center;
                gap: 1rem;
                padding: 0.75rem 0;
                border-bottom: 1px solid #e5e7eb;
            }

            .detail-item:last-child {
                border-bottom: none;
            }

            .detail-icon {
                width: 35px;
                height: 35px;
                background: var(--gradient-secondary);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 1.1rem;
            }

            .detail-label {
                font-weight: 600;
                color: var(--text-dark);
            }

            .detail-value {
                color: var(--primary-orange);
                font-weight: 600;
            }

            .booking-form {
                background: #f8f9fa;
                border-radius: 10px;
                padding: 1.5rem;
                margin-bottom: 2rem;
                border: 1px solid #e5e7eb;
            }

            .form-label {
                font-weight: 600;
                color: var(--text-dark);
                margin-bottom: 0.5rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .form-select {
                border: 1px solid #d1d5db;
                border-radius: 10px;
                padding: 0.75rem;
                font-weight: 500;
            }
            .btn-booking {
                background: var(--gradient-secondary);
                border: none;
                border-radius: 10px;
                padding: 0.75rem 1.5rem;
                font-weight: 600;
                color: white;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            .btn-booking:hover {
                background: linear-gradient(135deg, #e55a2b 0%, #d88906 100%);
            }
            .support-buttons .btn {
                border-radius: 10px;
                padding: 0.75rem 1rem;
                font-weight: 600;
                margin-bottom: 0.5rem;
                border: 1px solid;
            }
            .btn-call {
                background: var(--gradient-primary);
                border-color: var(--primary-blue);
                color: white;
            }
            .btn-contact {
                background: transparent;
                border-color: var(--primary-orange);
                color: var(--primary-orange);
            }
            .btn-contact:hover {
                background: var(--primary-orange);
                color: white;
            }
            /* Modal */
            .modal-content {
                border-radius: 10px;
                border: none;
            }
            .modal-header {
                background: var(--gradient-secondary);
                color: white;
                border: none;
                padding: 1.5rem;
            }
            .modal-body {
                padding: 0;
            }
            .modal-thumbnails {
                display: flex;
                gap: 0.5rem;
                overflow-x: auto;
                padding: 1rem;
                background: #f8f9fa;
            }
            .modal-thumbnails img {
                width: 60px;
                height: 60px;
                object-fit: cover;
                border-radius: 8px;
                cursor: pointer;
                border: 2px solid transparent;
                flex-shrink: 0;
                transition: border-color 0.3s;
            }
            .modal-thumbnails img:hover,
            .modal-thumbnails img.selected {
                border-color: var(--primary-orange);
            }
            img{
                width: 95%;
            }
            /* Responsive */
            @media (max-width: 768px) {
                .tour-title {
                    font-size: 2rem;
                }
                .tour-content {
                    padding: 1.5rem;
                }
                .main-img {
                    height: 250px;
                }
                .thumbnail-wrapper {
                    max-height: 200px;
                }
                .review-stats {
                    flex-direction: column;
                    gap: 1rem;
                }
                .review-header-info {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 0.5rem;
                }
            }
        </style>
    </head>
    <body class="${sessionScope.nameUser.role eq 'AD' ? 'admin-layout' : ''}">
        <jsp:include page="header.jsp"/>

        <div class="${sessionScope.nameUser.role ne 'AD' ? 'content' : 'other-content'}">
            <div class="container">
                <!-- Breadcrumb -->
                <div class="custom-breadcrumb">
                    <i class="fas fa-home me-2"></i>
                    <a href="placeController?action=destination&page=indexjsp">Trang chủ</a>
                    <i class="fas fa-chevron-right mx-2"></i>
                    <a href="placeController?action=destination&page=destinationjsp">Điểm đến</a>
                    <i class="fas fa-chevron-right mx-2"></i>
                    <a href="placeController?action=takeListTicket&location=${tourTicket.destination}">Du lịch ${tourTicket.destination}</a>
                    <i class="fas fa-chevron-right mx-2"></i>
                    <span class="current">Chi tiết tour</span>
                </div>

                <c:if test="${not empty ticketImgDetail and not empty ticketDayDetail and not empty tourTicket}">
                    <div class="row">
                        <!-- Left Content -->
                        <div class="col-lg-8">
                            <div class="tour-container">
                                <div class="tour-content">
                                    <h1 class="tour-title">
                                        ${tourTicket.destination}: ${tourTicket.nametour}
                                    </h1>

                                    <!-- Gallery -->
                                    <div class="gallery-container">
                                        <div class="row">
                                            <div class="col-md-2">
                                                <div class="thumbnail-wrapper">
                                                    <c:forEach var="img" items="${ticketImgDetail}" varStatus="status">
                                                        <img src="${img.imgUrl}"
                                                             onclick="showMainImage('${img.imgUrl}')"
                                                             class="thumbnail-img">
                                                    </c:forEach>
                                                </div>
                                            </div>
                                            <div class="col-md-10">
                                                <div class="main-image-container">
                                                    <img id="mainImg" 
                                                         src="${not empty ticketImgDetail ? ticketImgDetail[0].imgUrl : ''}"
                                                         onclick="openModal()" 
                                                         class="main-img">
                                                    <div class="image-overlay">
                                                        <i class="fas fa-search-plus fa-2x"></i>
                                                        <p class="mb-0 mt-2">Nhấp để xem ảnh lớn</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Tour Details Accordion -->
                                    <div class="tour-accordion">
                                        <div class="accordion" id="tourAccordion">
                                            <c:forEach var="dayDetail" items="${ticketDayDetail}" varStatus="status">
                                                <div class="accordion-item">
                                                    <h2 class="accordion-header" id="heading${status.index}">
                                                        <button class="accordion-button ${status.index == 0 ? '' : 'collapsed'}" 
                                                                type="button" 
                                                                data-bs-toggle="collapse" 
                                                                data-bs-target="#collapse${status.index}" 
                                                                aria-expanded="${status.index == 0 ? 'true' : 'false'}" 
                                                                aria-controls="collapse${status.index}">
                                                            <i class="fas fa-calendar-day me-2"></i>
                                                            ${dayDetail.description}
                                                        </button>
                                                    </h2>
                                                    <div id="collapse${status.index}" 
                                                         class="accordion-collapse collapse ${status.index == 0 ? 'show' : ''}" 
                                                         aria-labelledby="heading${status.index}" 
                                                         data-bs-parent="#tourAccordion">
                                                        <div class="accordion-body">
                                                            <div class="day-section">
                                                                <h5><i class="fas fa-sun text-warning me-2"></i>Buổi sáng</h5>
                                                                <p>${dayDetail.morning}</p>
                                                            </div>
                                                            <div class="day-section">
                                                                <h5><i class="fas fa-cloud-sun text-info me-2"></i>Buổi chiều</h5>
                                                                <p>${dayDetail.afternoon}</p>
                                                            </div>
                                                            <div class="day-section">
                                                                <h5><i class="fas fa-moon text-primary me-2"></i>Buổi tối</h5>
                                                                <p>${dayDetail.evening}</p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>

                                    <!-- ============= PHẦN ĐÁNH GIÁ TỪ KHÁCH HÀNG ============= -->
                                    <div class="review-section mt-4">
                                        <c:if test="${not empty message}">
                                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                                ${message}
                                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty error}">
                                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                                ${error}
                                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                            </div>
                                        </c:if>

                                        <!-- Thống kê đánh giá -->
                                        <div class="review-stats">
                                            <div class="stat-item">
                                                <div class="stat-number">
                                                    <fmt:formatNumber value="${averageRating}" pattern="0.0" />
                                                </div>
                                                <div class="stat-label">Điểm trung bình</div>
                                            </div>
                                            <div class="stat-item">
                                                <div class="stat-number">
                                                    ${totalReviews != null ? totalReviews : 0}
                                                </div>
                                                <div class="stat-label">Lượt đánh giá</div>
                                            </div>
                                        </div>

                                        <!-- Logic nút "Viết đánh giá" với Edit/Delete -->
                                        <div class="review-actions">
                                            <c:choose>
                                                <c:when test="${not empty sessionScope.nameUser and sessionScope.nameUser.role ne 'AD'}">

                                                    <c:choose>
                                                        <c:when test="${hasUserReviewed ne true and hasUserPaid eq true}">
                                                            <!-- FORM THÊM REVIEW MỚI -->
                                                            <form action="MainController" method="get">
                                                                <input type="hidden" name="action" value="addReview" />
                                                                <input type="hidden" name="idTourTicket" value="${tourTicket.idTourTicket}" />
                                                                <input type="hidden" name="nameOfDestination" value="${tourTicket.destination}" />

                                                                <div class="mb-3">
                                                                    <label for="rating">Đánh giá sao:</label>
                                                                    <select name="rating" id="rating" class="form-select" required>
                                                                        <option value="5">★★★★★</option>
                                                                        <option value="4">★★★★☆</option>
                                                                        <option value="3">★★★☆☆</option>
                                                                        <option value="2">★★☆☆☆</option>
                                                                        <option value="1">★☆☆☆☆</option>
                                                                    </select>
                                                                </div>

                                                                <div class="mb-3">
                                                                    <label for="comment">Bình luận:</label>
                                                                    <textarea name="comment" id="comment" class="form-control" rows="3" placeholder="Cảm nhận của bạn..."></textarea>
                                                                </div>

                                                                <button type="submit" class="btn btn-success">
                                                                    <i class="fas fa-paper-plane me-2"></i>Gửi đánh giá
                                                                </button>
                                                            </form>
                                                        </c:when>

                                                        <c:when test="${hasUserReviewed eq true and not empty userReview}">
                                                            <!-- HIỂN THỊ REVIEW CỦA USER + NÚT EDIT/DELETE -->
                                                            <div class="user-review-section">
                                                                <div class="alert alert-info">
                                                                    <h6><i class="fas fa-user-check me-2"></i>Đánh giá của bạn:</h6>
                                                                    <div class="user-review-display" id="userReviewDisplay">
                                                                        <div class="rating mb-2">
                                                                            <c:forEach var="star" begin="1" end="5">
                                                                                <c:choose>
                                                                                    <c:when test="${star <= userReview.rating}">
                                                                                        <i class="fas fa-star star"></i>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <i class="far fa-star star empty"></i>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </c:forEach>
                                                                        </div>
                                                                        <p class="mb-2">${not empty userReview.comment ? userReview.comment : 'Không có bình luận'}</p>
                                                                        <small class="text-muted">Đăng lúc: <fmt:formatDate value="${userReview.reviewDate}" pattern="dd/MM/yyyy" /></small>
                                                                    </div>
                                                                </div>

                                                                <!-- NÚT EDIT/DELETE -->
                                                                <div class="review-buttons mt-3">
                                                                    <button type="button" class="btn btn-outline-warning btn-sm" onclick="showEditForm()">
                                                                        <i class="fas fa-edit me-1"></i>Sửa đánh giá
                                                                    </button>
                                                                    <button type="button" class="btn btn-outline-danger btn-sm" onclick="confirmDelete()">
                                                                        <i class="fas fa-trash me-1"></i>Xóa đánh giá
                                                                    </button>
                                                                </div>

                                                                <!-- FORM EDIT (ẨN BAN ĐẦU) -->
                                                                <form action="MainController" method="get" id="editReviewForm" style="display: none;" class="mt-3">
                                                                    <input type="hidden" name="action" value="updateReview" />
                                                                    <input type="hidden" name="idTourTicket" value="${tourTicket.idTourTicket}" />
                                                                    <input type="hidden" name="nameOfDestination" value="${tourTicket.destination}" />

                                                                    <div class="mb-3">
                                                                        <label for="editRating">Đánh giá sao:</label>
                                                                        <select name="rating" id="editRating" class="form-select" required>
                                                                            <option value="5" ${userReview.rating == 5 ? 'selected' : ''}>★★★★★</option>
                                                                            <option value="4" ${userReview.rating == 4 ? 'selected' : ''}>★★★★☆</option>
                                                                            <option value="3" ${userReview.rating == 3 ? 'selected' : ''}>★★★☆☆</option>
                                                                            <option value="2" ${userReview.rating == 2 ? 'selected' : ''}>★★☆☆☆</option>
                                                                            <option value="1" ${userReview.rating == 1 ? 'selected' : ''}>★☆☆☆☆</option>
                                                                        </select>
                                                                    </div>

                                                                    <div class="mb-3">
                                                                        <label for="editComment">Bình luận:</label>
                                                                        <textarea name="comment" id="editComment" class="form-control" rows="3" placeholder="Cảm nhận của bạn...">${userReview.comment}</textarea>
                                                                    </div>

                                                                    <div class="d-flex gap-2">
                                                                        <button type="submit" class="btn btn-success btn-sm">
                                                                            <i class="fas fa-save me-1"></i>Cập nhật
                                                                        </button>
                                                                        <button type="button" class="btn btn-secondary btn-sm" onclick="hideEditForm()">
                                                                            <i class="fas fa-times me-1"></i>Hủy
                                                                        </button>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </c:when>

                                                        <c:when test="${hasUserPaid ne true}">
                                                            <div class="alert alert-warning">
                                                                <i class="fas fa-exclamation-triangle me-2"></i>
                                                                Bạn cần trải nghiệm tour này trước khi đánh giá.
                                                            </div>
                                                        </c:when>

                                                        <c:otherwise>
                                                            <span class="text-muted">Trạng thái đánh giá không xác định</span>
                                                        </c:otherwise>
                                                    </c:choose>

                                                </c:when>
                                                <c:otherwise>
                                                    <c:if test="${empty sessionScope.nameUser or sessionScope.nameUser.role ne 'AD'}">
                                                        <form action="MainController" method="get" class="booking-form">
                                                            <input type="hidden" name="action" value="addReview">
                                                            <input type="hidden" name="idTourTicket" value="${tourTicket.idTourTicket}">
                                                            <input type="hidden" name="nameOfDestination" value="${tourTicket.destination}" />

                                                            <button type="submit" class="btn btn-outline-primary">
                                                                <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập để đánh giá
                                                            </button>
                                                        </form>
                                                    </c:if>
                                                </c:otherwise>         
                                            </c:choose>
                                        </div>

                                        <!-- FORM DELETE (ẨN) -->
                                        <form action="MainController" method="get" id="deleteReviewForm" style="display: none;">
                                            <input type="hidden" name="action" value="deleteReview" />
                                            <input type="hidden" name="idTourTicket" value="${tourTicket.idTourTicket}" />
                                            <input type="hidden" name="nameOfDestination" value="${tourTicket.destination}" />
                                        </form>

                                        <!-- Danh sách đánh giá -->
                                        <div class="reviews-list">
                                            <c:choose>
                                                <c:when test="${not empty reviews}">
                                                    <c:forEach var="review" items="${reviews}">
                                                        <div class="review-item">
                                                            <div class="review-header-info">
                                                                <div class="reviewer-info">
                                                                    <div class="reviewer-avatar">
                                                                        ${fn:toUpperCase(fn:substring(review.userName, 0, 1))}
                                                                    </div>
                                                                    <div>
                                                                        <div class="reviewer-name">
                                                                            ${review.userName}
                                                                        </div>
                                                                        <div class="review-date">
                                                                            <fmt:formatDate value="${review.reviewDate}" pattern="dd/MM/yyyy" />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="rating">
                                                                    <c:forEach var="star" begin="1" end="5">
                                                                        <c:choose>
                                                                            <c:when test="${star <= review.rating}">
                                                                                <i class="fas fa-star star"></i>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <i class="far fa-star star empty"></i>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </c:forEach>
                                                                </div>
                                                            </div>
                                                            <div class="review-content">
                                                                ${not empty review.comment ? review.comment : 'Khách hàng chưa để lại bình luận.'}
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="no-reviews">
                                                        <i class="fas fa-comments"></i>
                                                        <h5>Chưa có đánh giá nào</h5>
                                                        <p>Hãy trở thành người đầu tiên đánh giá tour này!</p>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                <!-- ====================================================== -->
                                </div>
                            </div>
                            <!-- Image Modal -->
                            <div class="modal fade" id="imageModal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-lg modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="imageModalLabel">
                                                <i class="fas fa-images me-2"></i>
                                                Thư viện ảnh tour
                                            </h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body text-center">
                                            <img id="modalImg" src="" class="modal-img" alt="Tour Image">
                                            <div class="modal-thumbnails" id="modalThumbnails"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Right Sidebar -->
                        <c:if test="${sessionScope.nameUser.role ne 'AD'}">
                            <div class="col-lg-4">
                                <div class="booking-sidebar">
                                    <!-- Price Section -->
                                    <div class="price-section">
                                        <div class="original-price">
                                            <i class="fas fa-tag me-1"></i>
                                            <fmt:formatNumber value="${tourTicket.price + 1000000}" pattern="#,###" /> ₫
                                        </div>
                                        <div class="current-price">
                                            <fmt:formatNumber value="${tourTicket.price}" pattern="#,###" /> ₫
                                        </div>
                                        <small>/ Khách</small>
                                    </div>

                                    <!-- Discount Badge -->
                                    <div class="discount-badge">
                                        <i class="fas fa-gift fa-lg"></i>
                                        <div>
                                            <strong>Ưu đãi đặc biệt!</strong><br>
                                            <small>Tiết kiệm ngay 1,000,000 ₫</small>
                                        </div>
                                    </div>

                                    <!-- Tour Details -->
                                    <div class="tour-details">
                                        <div class="detail-item">
                                            <div class="detail-icon">
                                                <i class="fas fa-barcode"></i>
                                            </div>
                                            <div>
                                                <div class="detail-label">Mã tour:</div>
                                                <div class="detail-value">${tourTicket.idTourTicket}</div>
                                            </div>
                                        </div>
                                        <div class="detail-item">
                                            <div class="detail-icon">
                                                <i class="fas fa-map-marker-alt"></i>
                                            </div>
                                            <div>
                                                <div class="detail-label">Khởi hành:</div>
                                                <div class="detail-value">${tourTicket.placestart}</div>
                                            </div>
                                        </div>
                                        <div class="detail-item">
                                            <div class="detail-icon">
                                                <i class="fas fa-clock"></i>
                                            </div>
                                            <div>
                                                <div class="detail-label">Thời gian:</div>
                                                <div class="detail-value">${tourTicket.duration}</div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Booking Form -->
                                    <form action="MainController" method="get" class="booking-form">
                                        <input type="hidden" name="idTour" value="${tourTicket.idTourTicket}">
                                        <input type="hidden" name="action" value="order">
                                        <div class="mb-3">
                                            <label for="startNum" class="form-label">
                                                <i class="fas fa-calendar-alt"></i>
                                                Chọn ngày khởi hành
                                            </label>
                                            <div class="row">
                                                <div class="col-12 mb-2">
                                                    <select name="startDate" id="startNum" class="form-select">
                                                        <c:forEach var="sd" items="${startDateTour}">
                                                            <c:if test="${sd.quantity != 0}">
                                                                <option value="${sd.startDate}">
                                                                    ${sd.startDate} (còn ${sd.quantity} vé)
                                                                </option>
                                                            </c:if>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <div class="col-12">
                                                    <button type="submit" class="btn btn-booking w-100">
                                                        <i class="fas fa-shopping-cart me-2"></i>
                                                        Đặt Tour Ngay
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>

                                    <!-- Support Buttons -->
                                    <div class="support-buttons">
                                        <button class="btn btn-call w-100">
                                            <i class="fas fa-phone me-2"></i>
                                            Gọi miễn phí qua internet
                                        </button>
                                        <button class="btn btn-contact w-100">
                                            <i class="fas fa-comments me-2"></i>
                                            Liên hệ tư vấn
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </c:if>

                <c:if test="${empty ticketImgDetail or empty ticketDayDetail or empty tourTicket}">
                    <div class="alert alert-warning" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        Không tìm thấy thông tin chi tiết cho tour này.
                    </div>
                </c:if>
            </div>
        </div>

        <!-- Image Modal -->
        <div class="modal fade" id="imageModal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="imageModalLabel">
                            <i class="fas fa-images me-2"></i>
                            Thư viện ảnh tour
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body text-center">
                        <img id="modalImg" src="" class="modal-img" alt="Tour Image">
                        <div class="modal-thumbnails" id="modalThumbnails"></div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script>
                                                            function showMainImage(url) {
                                                                document.getElementById('mainImg').src = url;
                                                            }

                                                            function openModal() {
                                                                const modal = new bootstrap.Modal(document.getElementById('imageModal'));
                                                                modal.show();

                                                                // Reset modal content
                                                                document.getElementById('modalImg').src = document.getElementById('mainImg').src;
                                                                initModalThumbnails();
                                                            }

                                                            function initModalThumbnails() {
                                                                const container = document.getElementById('modalThumbnails');
                                                                container.innerHTML = '';

                                                                const images = document.querySelectorAll('.thumbnail-img');
                                                                images.forEach((img, index) => {
                                                                    const thumbnail = document.createElement('img');
                                                                    thumbnail.src = img.src;
                                                                    thumbnail.onclick = () => {
                                                                        document.getElementById('modalImg').src = img.src;
                                                                        highlightThumbnail(index);
                                                                    };
                                                                    container.appendChild(thumbnail);
                                                                });
                                                                highlightThumbnail(Array.from(images).findIndex(img => img.src === document.getElementById('mainImg').src));
                                                            }

                                                            function highlightThumbnail(index) {
                                                                const thumbnails = document.querySelectorAll('#modalThumbnails img');
                                                                thumbnails.forEach((thumb, i) => {
                                                                    thumb.classList.toggle('selected', i === index);
                                                                });
                                                            }

                                                            function showEditForm() {
                                                                document.getElementById('userReviewDisplay').style.display = 'none';
                                                                document.querySelector('.review-buttons').style.display = 'none';
                                                                document.getElementById('editReviewForm').style.display = 'block';
                                                            }

                                                            function hideEditForm() {
                                                                document.getElementById('userReviewDisplay').style.display = 'block';
                                                                document.querySelector('.review-buttons').style.display = 'block';
                                                                document.getElementById('editReviewForm').style.display = 'none';
                                                            }

                                                            function confirmDelete() {
                                                                if (confirm('Bạn có chắc chắn muốn xóa đánh giá này không?')) {
                                                                    document.getElementById('deleteReviewForm').submit();
                                                                }
                                                            }
        </script>
    </body>
</html>