<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="DTO.PlacesDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>VN Tours</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <link href="assets/css/destination.css" rel="stylesheet">
    </head>
    <body>
        <%@include file="header.jsp" %>

        <div class="container-fluid">
            <div class="${sessionScope.nameUser.role eq 'AD' ? 'places-container' : 'other-container'}">
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
                        <form action="MainController" method="post">
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
                                                

                                                <div class="btn-group">
                                                    <button type="submit" name="action" value="takeListTicket" class="btn-overlay blue">
                                                        <i class="fas fa-eye" aria-hidden="true"></i>
                                                        Xem thêm
                                                    </button>

                                                    <c:if test="${sessionScope.nameUser.role eq 'AD'}">
                                                        <input type="hidden" name="img" value="${place.img}" />
                                                        <input type="hidden" name="description" value="${place.description}" />
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
        <c:if test="${sessionScope.nameUser.role ne 'AD'}">
                <%@include file="footer.jsp" %>
        </c:if>
        
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>