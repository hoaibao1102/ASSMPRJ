<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="DTO.PlacesDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Danh sách địa điểm</title>
        <link rel="stylesheet" href="assets/css/bodyCss.css"/>
        <style>
            /* --- CSS giữ nguyên như bạn đã có --- */
            .places-container {
                max-width: 1200px;
                margin: 40px auto;
                display: flex;
                flex-direction: column;
                gap: 24px;
                padding: 0 20px;
                margin-left: 20%;
            }

            .place-card {
                display: flex;
                background-color: #ffffff;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                height: auto;
                text-decoration: none;
                border-left: 6px solid #2ecc71;
                position: relative;
            }

            .place-card:hover {
                transform: scale(1.02);
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            }

            .place-image {
                width: 200px;
                height: 180px;
                object-fit: cover;
                object-position: center;
                flex-shrink: 0;
                border-right: 1px solid #eee;
            }

            .place-content {
                padding: 20px;
                flex: 1;
                display: flex;
                flex-direction: column;
                justify-content: center;
                position: relative;
            }

            .place-content h4 {
                margin: 0 0 8px 0;
                font-size: 20px;
                font-weight: 700;
                color: #2c3e50;
            }

            .place-content p {
                margin: 0;
                font-size: 15px;
                color: #555;
                line-height: 1.5;
            }

            .btn-group {
                display: flex;
                gap: 10px;
                margin-top: 16px;
            }

            .btn-overlay {
                background-color: #3498db;
                color: white;
                border-radius: 20px;
                padding: 8px 16px;
                font-weight: 600;
                font-size: 14px;
                border: none;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .btn-overlay.orange {
                background-color: #e67e22;
            }

            .btn-overlay.red {
                background-color: #e74c3c;
            }

            .btn-overlay:hover {
                filter: brightness(1.1);
            }

            .btn-add-place {
                background-color: #2ecc71;
                color: white;
                border: none;
                border-radius: 24px;
                padding: 10px 20px;
                font-weight: 600;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease;
                margin-top: 20px;
            }

            .btn-add-place:hover {
                background-color: #27ae60;
            }

            .places-header {
                display: flex;
                flex-direction: column;
                align-items: center;
                margin: 20px 0;
                text-align: center;
            }

            .featured-label {
                position: absolute;
                top: 16px;
                left: 16px;
                background-color: #f39c12;
                color: white;
                padding: 4px 10px;
                font-size: 12px;
                font-weight: bold;
                border-radius: 12px;
            }

            @media (max-width: 768px) {
                .place-card {
                    flex-direction: column;
                    height: auto;
                }

                .place-image {
                    width: 100%;
                    height: 200px;
                }

                .place-content {
                    padding: 16px;
                }

                .btn-group {
                    flex-direction: column;
                    gap: 8px;
                }

                .btn-overlay {
                    width: 100%;
                    text-align: center;
                }
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>

        <div class="content places-container">
            <h2>Danh sách địa điểm</h2>

            <c:if test="${sessionScope.nameUser.role eq 'AD'}">
                📍 Danh sách điểm đến đang ngưng hoạt động
                <c:forEach var="place" items="${placeList}">
                    <c:if test="${!place.status}">
                            <form class="place-card" action="placeController" method="post">
                               
                                <img class="place-image" src="${place.img}" onerror="this.src='default.jpg'" alt="${place.placeName}" />

                                <div class="place-content">
                                    <h4>${place.placeName}</h4>
                                    <p>${place.description}</p>

                                    <input type="hidden" name="location" value="${place.placeName}" />
                                    <input type="hidden" name="img" value="${place.img}" />
                                    <input type="hidden" name="description" value="${place.description}" />

                                    <div class="btn-group">
                                        <button type="submit" name="action" value="takeListTicket" class="btn-overlay blue">Xem thêm</button>

                                        <c:if test="${sessionScope.nameUser.role eq 'AD'}">
                                            <button type="submit" name="action" value="updatePlace" class="btn-overlay orange">Cập nhật</button>
                                        </c:if>
                                    </div>
                                </div>
                            </form>
                        </c:if>
                </c:forEach>
                <br>
                <form action="placeController" method="get">
                    <input type="hidden" name="action" value="addPlace">
                    <button type="submit" class="btn-add-place">+ Thêm địa điểm</button>
                </form>
            </c:if>

            <c:choose>
                <c:when test="${not empty placeList}">
                    📍 Danh sách điểm đến đang hoạt động
                    <c:forEach var="place" items="${placeList}">
                        <c:if test="${place.status}">
                            <form class="place-card" action="placeController" method="post">
                                <c:if test="${place.featured and sessionScope.nameUser.role eq 'AD'}">
                                    <div class="featured-label">Nổi bật</div>
                                </c:if>

                                <img class="place-image" src="${place.img}" onerror="this.src='default.jpg'" alt="${place.placeName}" />

                                <div class="place-content">
                                    <h4>${place.placeName}</h4>
                                    <p>${place.description}</p>

                                    <input type="hidden" name="location" value="${place.placeName}" />
                                    <input type="hidden" name="img" value="${place.img}" />
                                    <input type="hidden" name="description" value="${place.description}" />

                                    <div class="btn-group">
                                        <button type="submit" name="action" value="takeListTicket" class="btn-overlay blue">Xem thêm</button>

                                        <c:if test="${sessionScope.nameUser.role eq 'AD'}">
                                            <button type="submit" name="action" value="updatePlace" class="btn-overlay orange">Cập nhật</button>
                                            <button type="submit" name="action" value="deletePlace" class="btn-overlay red"
                                                    onclick="return confirm('Bạn có chắc chắn muốn xóa không?');">Xóa</button>
                                        </c:if>
                                    </div>
                                </div>
                            </form>
                        </c:if>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <h3 style="text-align: center;">Không có thông tin địa điểm.</h3>
                </c:otherwise>
            </c:choose>
        </div>

        <%@include file="footer.jsp" %>
    </body>
</html>
