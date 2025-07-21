<%-- 
    Document   : favoriteList
    Created on : 13-07-2025, 02:04:40
    Author     : MSI PC
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>VN Tours</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            body {
                background: linear-gradient(135deg, #0EA5E9, #10B981);
                font-family: 'Poppins', sans-serif;
                padding: 20px 0;
            }

            .main-container {
                background: #fff;
                border-radius: 20px;
                max-width: 1200px;
                margin: auto;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }

            .content{
                padding: 20px;
            }

            .header-section {
                background: linear-gradient(135deg, #FF6B35, #F59E0B);
                color: white;
                padding: 2rem;
                margin-bottom: 2rem;
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
            }

            .page-title {
                font-size: 2rem;
                font-weight: bold;
            }

            .back-btn {
                background: rgba(255, 255, 255, 0.2);
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 25px;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                transition: all 0.3s ease;
            }

            .back-btn:hover {
                background: rgba(255, 255, 255, 0.3);
                color: white;
                transform: translateY(-2px);
            }

            .tour-card {
                border: 1px solid #e2e8f0;
                border-radius: 20px;
                overflow: hidden;
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
                margin-bottom: 1.5rem;
                display: flex;
                flex-wrap: wrap;
                transition: all 0.3s ease;
                background: #fff;
            }

            .tour-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 40px rgba(0, 0, 0, 0.12);
            }

            .tour-img-box {
                flex: 0 0 400px; /* to hơn */
                max-width: 100%;
                height: auto;
                display: flex;
            }

            .tour-img {
                width: 100%;
                max-height: 100%;
                object-fit: cover;
                transition: transform 0.3s ease;
                object-fit: cover;
                height: auto;
                flex-grow: 1;
            }

            .tour-card:hover .tour-img {
                transform: scale(1.05);
            }

            .tour-info {
                flex: 1;
                padding: 1.5rem;
                color: #1e293b;
                background: #fff;
                border-radius: 0 20px 20px 0;
            }

            .tour-title {
                font-size: 1.25rem;
                font-weight: bold;
                margin-bottom: 1rem;
                color: #1e293b;
            }

            .tour-meta {
                font-size: 0.95rem;
                color: #4b5563;
                margin-bottom: 0.5rem;
                display: flex;
                align-items: center;
            }

            .date-badge {
                background: linear-gradient(135deg, #fee2e2, #fecaca);
                color: #b91c1c;
                padding: 6px 14px;
                border-radius: 25px;
                font-size: 0.85rem;
                margin: 4px 4px 0 0;
                display: inline-block;
                font-weight: 500;
                box-shadow: 0 2px 8px rgba(185, 28, 28, 0.2);
            }

            .price {
                font-size: 1.3rem;
                font-weight: bold;
                color: #FF6B35;
                background: linear-gradient(135deg, #FF6B35, #F59E0B);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                text-shadow: 0 2px 4px rgba(255, 107, 53, 0.3);
            }

            .btn-sm {
                border-radius: 25px;
                font-weight: 500;
                padding: 8px 16px;
                transition: all 0.3s ease;
            }

            .btn-primary {
                background: linear-gradient(135deg, #3B82F6, #1D4ED8);
                border: none;
                box-shadow: 0 4px 15px rgba(59, 130, 246, 0.3);
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(59, 130, 246, 0.4);
            }

            .btn-danger {
                background: linear-gradient(135deg, #EF4444, #DC2626);
                border: none;
                box-shadow: 0 4px 15px rgba(239, 68, 68, 0.3);
            }

            .btn-danger:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(239, 68, 68, 0.4);
            }

            .empty-state {
                text-align: center;
                padding: 3rem;
                background: #f8fafc;
                border-radius: 20px;
                margin: 2rem 0;
            }

            .empty-state h4 {
                color: #64748b;
                margin-bottom: 1rem;
            }

            .empty-state p {
                color: #94a3b8;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .tour-card {
                    flex-direction: column;
                }

                .tour-img-box {
                    flex: none;
                    max-width: 100%;
                }

                .tour-info {
                    border-radius: 0 0 20px 20px;
                }

                .header-section {
                    flex-direction: column;
                    text-align: center;
                    gap: 1rem;
                }

                .page-title {
                    font-size: 1.5rem;
                }
            }

            .unauthorized-container {
                background: #fef3c7;
                border: 2px dashed #f59e0b;
                border-radius: 20px;
                margin: 4rem auto;
                max-width: 700px;
                box-shadow: 0 6px 20px rgba(0,0,0,0.05);
            }

            .unauthorized-title {
                color: #b45309;
                font-size: 1.8rem;
                font-weight: 700;
                margin-bottom: 1rem;
            }

            .unauthorized-desc {
                color: #78350f;
                font-size: 1rem;
                margin-bottom: 1.5rem;
            }

        </style>
    </head>
    <body>
        <c:choose>
            <c:when test="${sessionScope.nameUser.role eq 'CUS'}">
                <div class="main-container">
                    <!-- Header -->
                    <div class="header-section d-flex align-items-center justify-content-between flex-wrap">
                        <a href="placeController?action=destination&page=indexjsp" class="back-btn">
                            <i class="bi bi-arrow-left me-2"></i> Quay lại
                        </a>
                        <div class="flex-grow-1 text-center">
                            <h1 class="page-title m-0">
                                <i class="bi bi-heart-fill me-2"></i> Danh sách tour yêu thích của bạn
                            </h1>
                        </div>
                    </div>
                    <div class="content">
                        <!-- Tour List -->
                        <c:choose>
                            <c:when test="${not empty tourFavoriteList}">
                                <c:forEach var="t" items="${tourFavoriteList}" varStatus="loop">
                                    <c:set var="index" value="${loop.index + 1}" />
                                    <c:set var="dateKey" value="startDateTour${index}" />
                                    <c:set var="startDates" value="${requestScope[dateKey]}" />


                                    <div class="tour-card">
                                        <div class="tour-img-box">
                                            <img src="${t.img_Tour}" alt="Tour image" class="tour-img"/>
                                        </div>
                                        <div class="tour-info d-flex flex-column justify-content-between">
                                            <div>
                                                <div class="tour-title">${t.nametour}</div>
                                                <div class="tour-meta"><i class="bi bi-tag-fill me-2 text-primary"></i> Mã tour: <strong>${t.idTourTicket}</strong></div>
                                                <div class="tour-meta"><i class="bi bi-geo-alt-fill me-2 text-danger"></i> Khởi hành: <strong>${t.placestart}</strong></div>
                                                <div class="tour-meta"><i class="bi bi-clock-fill me-2 text-warning"></i> Thời gian: <strong>${t.duration}</strong></div>
                                                <div class="tour-meta"><i class="bi bi-truck me-2 text-success"></i> Phương tiện: <strong>${t.transport_name}</strong></div>
                                                <div class="tour-meta">
                                                    <i class="bi bi-calendar-event-fill me-2 text-info"></i> Ngày khởi hành:
                                                    <c:choose>
                                                        <c:when test="${not empty startDates}">
                                                            <c:forEach var="sd" items="${startDates}">
                                                                <span class="date-badge">${sd.startDate}</span>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="date-badge">Chưa có lịch</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                            <div class="d-flex justify-content-between align-items-center mt-3 flex-wrap gap-2">
                                                <span class="price">
                                                    <i class="bi bi-cash-coin me-2 fs-5"></i>
                                                    <fmt:formatNumber value="${t.price}" type="number" groupingUsed="true" /> ₫
                                                </span>

                                                <div class="d-flex gap-2">
                                                    <form action="MainController" method="post">
                                                        <input type="hidden" name="idTourTicket" value="${t.idTourTicket}"/>
                                                        <input type="hidden" name="nameOfDestination" value="${t.destination}"/>
                                                        <button type="submit" name="action" value="ticketDetail" class="btn btn-primary btn-sm">
                                                            <i class="bi bi-eye"></i> Xem chi tiết
                                                        </button>
                                                    </form>
                                                    <form action="MainController" method="post" onsubmit="return confirm('Bạn có chắc muốn xóa?')">
                                                        <input type="hidden" name="action" value="removeFavorite"/>
                                                        <input type="hidden" name="idTourTicket" value="${t.idTourTicket}"/>
                                                        <input type="hidden" name="idUser" value="${sessionScope.nameUser.idUser}"/>
                                                        <button type="submit" class="btn btn-danger btn-sm">
                                                            <i class="bi bi-trash"></i> Xóa khỏi yêu thích 
                                                        </button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-5">
                                    <h4>Không có tour yêu thích nào.</h4>
                                    <p class="text-muted">Hãy khám phá và thêm tour vào danh sách yêu thích của bạn!</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div> 
                </div>
            </c:when>
            <c:otherwise>
                <div class="unauthorized-container text-center py-5 px-4">
                    <h2 class="unauthorized-title">
                        <i class="bi bi-shield-lock-fill me-2"></i> Bạn cần đăng nhập để truy cập
                    </h2>
                    <p class="unauthorized-desc">Vui lòng đăng nhập để xem danh sách tour yêu thích của bạn.</p>
                    <a href="placeController?action=destination&page=indexjsp" class="btn btn-warning rounded-pill mt-3">
                        <i class="bi bi-house-door-fill me-1"></i> Quay về trang chủ
                    </a>
                </div>
            </c:otherwise>
        </c:choose>



    </body>
</html>
