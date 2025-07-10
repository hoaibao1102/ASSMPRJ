<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="DTO.PlacesDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách địa điểm</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                /* Tông màu chính */
                --sky-blue: #0EA5E9;
                --coral-orange: #FF6B35;
                --emerald-green: #10B981;
                
                /* Tông màu phụ */
                --golden-yellow: #F59E0B;
                --purple: #8B5CF6;
                --pearl-white: #FEFEFE;
                
                /* Màu nền và text */
                --text-dark: #1F2937;
                --text-medium: #6B7280;
                --bg-light: #F8FAFC;
                --shadow-light: rgba(0, 0, 0, 0.08);
                --shadow-medium: rgba(0, 0, 0, 0.12);
                
                /* Gradient */
                --gradient-primary: linear-gradient(135deg, #0EA5E9, #10B981);
                --gradient-secondary: linear-gradient(135deg, #FF6B35, #F59E0B);
            }

            * {
                box-sizing: border-box;
            }

            body {
                padding-top: 100px;
                background-color: var(--bg-light);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                color: var(--text-dark);
                line-height: 1.6;
            }

            .places-container {
                max-width: 1200px;
                margin: 40px auto;
                padding: 0 20px;
                margin-left: 20%;
            }

            .section-header {
                background: var(--gradient-primary);
                color: var(--pearl-white);
                padding: 24px 32px;
                border-radius: 12px;
                margin-bottom: 32px;
                box-shadow: 0 4px 12px var(--shadow-light);
            }

            .section-header h2 {
                margin: 0;
                font-size: 2rem;
                font-weight: 700;
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .section-header .subtitle {
                margin: 8px 0 0 0;
                font-size: 1rem;
                opacity: 0.95;
            }

            .place-card {
                background: var(--pearl-white);
                border-radius: 12px;
                box-shadow: 0 2px 8px var(--shadow-light);
                overflow: hidden;
                transition: all 0.2s ease;
                border: none;
                margin-bottom: 24px;
                height: 100%;
                display: flex;
                flex-direction: column;
            }

            .place-card:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 16px var(--shadow-medium);
            }

            .place-image {
                width: 100%;
                height: 200px;
                object-fit: cover;
                object-position: center;
                flex-shrink: 0;
            }

            .place-content {
                padding: 24px;
                flex: 1;
                display: flex;
                flex-direction: column;
            }

            .place-content h4 {
                color: var(--text-dark);
                font-size: 1.25rem;
                font-weight: 600;
                margin-bottom: 12px;
                line-height: 1.4;
            }

            .place-content p {
                color: var(--text-medium);
                font-size: 0.9rem;
                margin-bottom: 20px;
                flex: 1;
            }

            .btn-group {
                display: flex;
                gap: 8px;
                flex-wrap: wrap;
                margin-top: auto;
            }

            .btn-overlay {
                border: none;
                border-radius: 6px;
                padding: 8px 16px;
                font-weight: 500;
                font-size: 0.875rem;
                transition: all 0.2s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 4px;
                cursor: pointer;
            }

            .btn-overlay.blue {
                background-color: var(--sky-blue);
                color: var(--pearl-white);
            }

            .btn-overlay.blue:hover {
                background-color: #0284C7;
                color: var(--pearl-white);
            }

            .btn-overlay.orange {
                background-color: var(--coral-orange);
                color: var(--pearl-white);
            }

            .btn-overlay.orange:hover {
                background-color: #EA580C;
                color: var(--pearl-white);
            }

            .btn-overlay.red {
                background-color: #DC2626;
                color: var(--pearl-white);
            }

            .btn-overlay.red:hover {
                background-color: #B91C1C;
                color: var(--pearl-white);
            }

            .btn-add-place {
                background: var(--gradient-secondary);
                color: var(--pearl-white);
                border: none;
                border-radius: 8px;
                padding: 12px 24px;
                font-weight: 600;
                font-size: 1rem;
                transition: all 0.2s ease;
                box-shadow: 0 2px 8px var(--shadow-light);
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .btn-add-place:hover {
                transform: translateY(-1px);
                box-shadow: 0 4px 12px var(--shadow-medium);
                color: var(--pearl-white);
            }

            .featured-label {
                position: absolute;
                top: 12px;
                right: 12px;
                background-color: var(--golden-yellow);
                color: var(--pearl-white);
                padding: 4px 12px;
                font-size: 0.75rem;
                font-weight: 600;
                border-radius: 16px;
                z-index: 2;
                display: flex;
                align-items: center;
                gap: 4px;
            }

            .inactive-section {
                background: linear-gradient(135deg, #64748B, #475569);
                color: var(--pearl-white);
                padding: 20px 32px;
                border-radius: 12px;
                margin-bottom: 32px;
            }

            .inactive-section h3 {
                margin: 0;
                font-size: 1.25rem;
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .inactive-place-card {
                opacity: 0.7;
                filter: grayscale(30%);
            }

            .no-places {
                text-align: center;
                padding: 48px 24px;
                background: var(--pearl-white);
                border-radius: 12px;
                box-shadow: 0 2px 8px var(--shadow-light);
            }

            .no-places h3 {
                color: var(--text-dark);
                font-size: 1.5rem;
                margin-bottom: 16px;
                font-weight: 600;
            }

            .no-places p {
                color: var(--text-medium);
                font-size: 1rem;
            }

            .tropical-icon {
                color: var(--golden-yellow);
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .places-container {
                    margin-left: 0;
                    padding: 0 16px;
                }

                .place-image {
                    height: 180px;
                }

                .place-content {
                    padding: 20px;
                }

                .btn-group {
                    flex-direction: column;
                }

                .btn-overlay {
                    width: 100%;
                    justify-content: center;
                }

                .section-header {
                    padding: 20px 24px;
                }

                .section-header h2 {
                    font-size: 1.75rem;
                }
            }

            @media (max-width: 576px) {
                .section-header {
                    padding: 16px 20px;
                }

                .section-header h2 {
                    font-size: 1.5rem;
                }

                .place-content h4 {
                    font-size: 1.125rem;
                }

                .place-content {
                    padding: 16px;
                }
            }

            /* Accessibility improvements */
            .btn-overlay:focus,
            .btn-add-place:focus {
                outline: 2px solid var(--sky-blue);
                outline-offset: 2px;
            }

            /* Print styles */
            @media print {
                .btn-group,
                .btn-add-place {
                    display: none;
                }
                
                .place-card {
                    break-inside: avoid;
                }
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>

        <div class="container-fluid">
            <div class="places-container">
                <div class="section-header">
                    <h2>
                        <i class="fas fa-map-marked-alt tropical-icon" aria-hidden="true"></i>
                        Danh sách địa điểm
                    </h2>
                    <p class="subtitle">Khám phá những điểm đến tuyệt vời cho chuyến du lịch của bạn</p>
                </div>

                <c:if test="${sessionScope.nameUser.role eq 'AD'}">
                    <div class="inactive-section">
                        <h3>
                            <i class="fas fa-pause-circle" aria-hidden="true"></i>
                            Danh sách điểm đến đang ngưng hoạt động
                        </h3>
                    </div>
                    
                    <div class="row">
                        <c:forEach var="place" items="${placeList}">
                            <c:if test="${!place.status}">
                                <div class="col-lg-6 col-xl-4 mb-4">
                                    <form class="place-card inactive-place-card h-100" action="MainController" method="post">
                                        <img class="place-image" src="${place.img}" alt="${place.placeName}" loading="lazy" />

                                        <div class="place-content">
                                            <h4>${place.placeName}</h4>
                                            <p>${place.description}</p>

                                            <input type="hidden" name="location" value="${place.placeName}" />
                                            <input type="hidden" name="img" value="${place.img}" />
                                            <input type="hidden" name="description" value="${place.description}" />

                                            <div class="btn-group">
                                                <button type="submit" name="action" value="takeListTicket" class="btn-overlay blue">
                                                    <i class="fas fa-eye" aria-hidden="true"></i>
                                                    Xem thêm
                                                </button>
                                                <button type="submit" name="action" value="updatePlace" class="btn-overlay orange">
                                                    <i class="fas fa-edit" aria-hidden="true"></i>
                                                    Cập nhật
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                    
                    <div class="text-center mb-5">
                        <form action="MainController" method="get">
                            <input type="hidden" name="action" value="addPlace">
                            <button type="submit" class="btn-add-place">
                                <i class="fas fa-plus" aria-hidden="true"></i>
                                Thêm địa điểm
                            </button>
                        </form>
                    </div>
                </c:if>

                <c:choose>
                    <c:when test="${not empty placeList}">
                        <c:if test="${sessionScope.nameUser.role eq 'AD'}">
                            <div class="section-header">
                                <h2>
                                    <i class="fas fa-play-circle tropical-icon" aria-hidden="true"></i>
                                    Danh sách điểm đến đang hoạt động
                                </h2>
                            </div>
                        </c:if>
                        
                        <div class="row">
                            <c:forEach var="place" items="${placeList}">
                                <c:if test="${place.status}">
                                    <div class="col-lg-6 col-xl-4 mb-4">
                                        <form class="place-card h-100" action="MainController" method="post">
                                            <div style="position: relative;">
                                                <c:if test="${place.featured and sessionScope.nameUser.role eq 'AD'}">
                                                    <div class="featured-label">
                                                        <span>⭐</span>
                                                        Nổi bật
                                                    </div>
                                                </c:if>
                                                <img class="place-image" src="${place.img}" alt="${place.placeName}" loading="lazy" />
                                            </div>

                                            <div class="place-content">
                                                <h4>${place.placeName}</h4>
                                                <p>${place.description}</p>

                                                <input type="hidden" name="location" value="${place.placeName}" />
                                                <input type="hidden" name="img" value="${place.img}" />
                                                <input type="hidden" name="description" value="${place.description}" />

                                                <div class="btn-group">
                                                    <button type="submit" name="action" value="takeListTicket" class="btn-overlay blue">
                                                        <i class="fas fa-eye" aria-hidden="true"></i>
                                                        Xem thêm
                                                    </button>

                                                    <c:if test="${sessionScope.nameUser.role eq 'AD'}">
                                                        <button type="submit" name="action" value="updatePlace" class="btn-overlay orange">
                                                            <i class="fas fa-edit" aria-hidden="true"></i>
                                                            Cập nhật
                                                        </button>
                                                        <button type="submit" name="action" value="deletePlace" class="btn-overlay red"
                                                                onclick="return confirm('Bạn có chắc chắn muốn xóa không?');">
                                                            <i class="fas fa-trash" aria-hidden="true"></i>
                                                            Xóa
                                                        </button>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="no-places">
                            <i class="fas fa-map-marked-alt" style="font-size: 4rem; color: var(--coral-orange); margin-bottom: 20px;" aria-hidden="true"></i>
                            <h3>Không có thông tin địa điểm</h3>
                            <p>Hiện tại chưa có địa điểm nào được thêm vào hệ thống.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <%@include file="footer.jsp" %>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>