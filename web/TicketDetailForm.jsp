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
        <title>VN Tours</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <link href="assets/css/ticket_detail.css" rel="stylesheet">
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
                                                            <form action="MainController" method="post">
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
                                                                <form action="MainController" method="post" id="editReviewForm" style="display: none;" class="mt-3">
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
                                                        <form action="MainController" method="post" class="booking-form">
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
                                        <form action="MainController" method="post" id="deleteReviewForm" style="display: none;">
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
                                    <form action="MainController" method="post" class="booking-form">
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