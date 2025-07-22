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
        <link href="assets/css/favorite.css" rel="stylesheet">
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
