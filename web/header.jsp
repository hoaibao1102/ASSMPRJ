<%-- 
    Document   : header
    Created on : May 12, 2025
    Author     : MSI PC
--%>
<%@ page import="UTILS.AuthUtils"%>
<%@ page import="DTO.UserDTO"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>VN Tours</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href="assets/css/header.css" rel="stylesheet">
        
    </head>
    <body>
        <%
            UserDTO user = (UserDTO) session.getAttribute("nameUser");
            boolean isAdmin = AuthUtils.isAdmin(session);
            String searchTour = (request.getAttribute("searchTourInfor") != null) ?
                    request.getAttribute("searchTourInfor").toString() : "";
        %>

        <% if (isAdmin) { %>
        <!-- Admin Sidebar -->
        <div class="admin-sidebar">
            <div class="sidebar-header">
                <h3><i class="fas fa-cog"></i> Admin Panel</h3>
            </div>
            <nav class="sidebar-nav">
                <div class="nav-item">
                    <a href="placeController?action=destination&page=indexjsp" class="nav-link">
                        <i class="fas fa-home"></i> Trang chủ
                    </a>
                </div>
                <div class="nav-item">
                    <a href="placeController?action=destination&page=destinationjsp" class="nav-link">
                        <i class="fas fa-map-marker-alt"></i> Quản lý điểm đến
                    </a>
                </div>
                <div class="nav-item">
                    <a href="userController?action=listUser " class="nav-link">
                        <i class="fas fa-users"></i> Quản lý người dùng
                    </a>
                </div>
                <div class="nav-item">
                    <a href="MainController?action=goVoucherPage" class="nav-link">
                        <i class="fas fa-ticket-alt"></i> Quản lý vouchers
                    </a>
                </div>
                <div class="nav-item">
                    <form action="loginController" method="post" class="m-0">
                        <input type="hidden" name="action" value="logout" />
                        <button type="submit" class="nav-link btn btn-link text-start w-100 border-0">
                            <i class="fas fa-sign-out-alt"></i> Đăng xuất
                        </button>
                    </form>
                </div>
            </nav>
        </div>
        <% } else { %>
        <!-- Regular Header -->
        <nav class="navbar navbar-expand-lg fixed-top" id="mainNavbar">
            <div class="container">
                <a class="navbar-brand" href="placeController?action=destination&page=indexjsp">
                    <i class="fas fa-plane"></i> VN Tours
                </a>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <form action="MainController" method="get" class="d-inline">
                                <input type="hidden" name="action" value="destination">
                                <input type="hidden" name="page" value="indexjsp">
                                <button type="submit" class="nav-link btn btn-link">
                                    <i class="fas fa-home"></i> Trang chủ
                                </button>
                            </form>
                        </li>
                        <li class="nav-item">
                            <form action="MainController" method="get" class="d-inline">
                                <input type="hidden" name="action" value="destination">
                                <input type="hidden" name="page" value="destinationjsp">
                                <button type="submit" class="nav-link btn btn-link">
                                    <i class="fas fa-map-marker-alt"></i> Điểm đến
                                </button>
                            </form>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="about.jsp">
                                <i class="fas fa-info-circle"></i> Giới thiệu
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="contact.jsp">
                                <i class="fas fa-envelope"></i> Liên hệ
                            </a>
                        </li>
                    </ul>

                    <div class="d-flex align-items-center gap-3">
                        <!-- Search Bar -->
                        <form action="MainController" method="get" class="search-container">
                            <input type="hidden" name="action" value="search">
                            <input type="text" class="search-input" name="searchItem" 
                                   placeholder="Tìm kiếm tour..." value="<%= searchTour %>" >
                            <button type="submit" class="search-btn">
                                <i class="fas fa-search"></i>
                            </button>
                        </form>

                        <!-- Hotline -->
                        <a href="" class="hotline">
                            <i class="fas fa-phone"></i>
                            <span>1900-xxxx</span>
                        </a>

                        <!-- Auth Section -->
                        <% if (user == null) { %>
                        <div class="auth-buttons">
                            <a href="RegisForm.jsp" class="btn btn-register">Đăng ký</a>
                            <a href="LoginForm.jsp" class="btn btn-login">Đăng nhập</a>
                        </div>
                        <% } else { %>
                        <div class="d-flex align-items-center gap-2">


                            <!-- User Dropdown -->
                            <div class="dropdown">
                                <div class="user-profile" data-bs-toggle="dropdown">
                                    <div class="user-avatar">
                                        <%= user.getFullName().trim().substring(0,1).toUpperCase() %>
                                    </div>
                                    <span class="user-name"><%= user.getFullName() %></span>
                                    <i class="fas fa-chevron-down"></i>
                                </div>
                                <ul class="dropdown-menu">
                                    <li>
                                        <form action="MainController" method="post" class="d-inline">
                                            <input type="hidden" name="action" value="editProfile" />
                                            <input type="hidden" name="userId" value="<%= user.getIdUser() %>" />
                                            <button type="submit" class="dropdown-item">
                                                <i class="fas fa-user-edit"></i> Chỉnh sửa hồ sơ
                                            </button>
                                        </form>
                                    </li>
                                    <li>
                                        <form action="MainController" method="post" class="d-inline">
                                            <input type="hidden" name="action" value="orderOfUser" />
                                            <input type="hidden" name="userId" value="<%= user.getIdUser() %>" />
                                            <button type="submit" class="dropdown-item">
                                                <i class="fas fa-history"></i> Lịch sử giao dịch
                                            </button>
                                        </form>
                                    </li>
                                    <li>
                                        <form action="MainController" method="get" class="d-inline">
                                            <input type="hidden" name="action" value="showFavoriteList" />
                                            <input type="hidden" name="idUser" value="${sessionScope.nameUser.idUser}" />
                                            <button type="submit" class="dropdown-item btn btn-link text-start w-100">
                                                <i class="fas fa-heart"></i> 
                                                Yêu thích 
                                                <c:if test="${not empty sessionScope.favoriteCount}">
                                                    (${sessionScope.favoriteCount})
                                                </c:if>
                                            </button>
                                        </form>
                                    </li>

                                </ul>


                            </div>

                            <!-- Logout Button -->
                            <form action="loginController" method="post" class="d-inline">
                                <input type="hidden" name="action" value="logout" />
                                <button type="submit" class="btn btn-logout">
                                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                                </button>
                            </form>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </nav>
        <% } %>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            // Navbar scroll effect
            window.addEventListener('scroll', function () {
                const navbar = document.getElementById('mainNavbar');
                if (window.scrollY > 50) {
                    navbar.classList.add('scrolled');
                } else {
                    navbar.classList.remove('scrolled');
                }
            });

            // Update cart count function
            function updateFavoriteCount(count) {
                const favoriteCountElement = document.getElementById('favoriteCount');
                if (favoriteCountElement) {
                    favoriteCountElement.textContent = count;
                }
            }


            // Example usage
            // updateCartCount(3);
        </script>
    </body>
</html>



