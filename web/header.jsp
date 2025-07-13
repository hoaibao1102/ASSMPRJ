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

        <style>
            :root {
                --primary-color: #ff6b35;
                --secondary-color: #2c3e50;
                --accent-color: #f39c12;
                --text-dark: #2c3e50;
                --text-light: #7f8c8d;
                --bg-light: #f8f9fa;
            }

            * {
                font-family: 'Poppins', sans-serif;
            }

            /* Header Styles */
            .navbar {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                box-shadow: 0 2px 20px rgba(0,0,0,0.1);
                padding: 1rem 0;
                transition: all 0.3s ease;
            }

            .navbar.scrolled {
                background: rgba(255, 255, 255, 0.98);
                backdrop-filter: blur(15px);
            }

            .navbar-brand {
                font-size: 1.8rem;
                font-weight: 700;
                color: var(--primary-color) !important;
                text-decoration: none;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .navbar-brand i {
                font-size: 2rem;
                color: var(--accent-color);
            }

            .navbar-nav .nav-link {
                color: var(--text-dark) !important;
                font-weight: 500;
                margin: 0 10px;
                padding: 10px 15px !important;
                border-radius: 25px;
                transition: all 0.3s ease;
                position: relative;
                border: none;
                background: none;
            }

            .navbar-nav .nav-link:hover {
                color: var(--primary-color) !important;
                background: rgba(255, 107, 53, 0.1);
                transform: translateY(-2px);
            }

            .navbar-nav .nav-link::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 50%;
                width: 0;
                height: 2px;
                background: var(--primary-color);
                transition: all 0.3s ease;
                transform: translateX(-50%);
            }

            .navbar-nav .nav-link:hover::after {
                width: 80%;
            }

            /* Search Bar */
            .search-container {
                position: relative;
                max-width: 300px;
            }

            .search-input {
                background: rgba(248, 249, 250, 0.9);
                border: 2px solid transparent;
                border-radius: 25px;
                padding: 10px 45px 10px 20px;
                font-size: 14px;
                transition: all 0.3s ease;
                width: 100%;
                color: var(--text-dark);
            }

            .search-input:focus {
                outline: none;
                border-color: var(--primary-color);
                background: #fff;
                box-shadow: 0 0 10px rgba(255, 107, 53, 0.2);
            }

            .search-btn {
                position: absolute;
                right: 5px;
                top: 50%;
                transform: translateY(-50%);
                background: var(--primary-color);
                border: none;
                border-radius: 50%;
                width: 35px;
                height: 35px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: #fff;
                transition: all 0.3s ease;
            }

            .search-btn:hover {
                background: #e55a2b;
                transform: translateY(-50%) scale(1.1);
            }

            /* User Profile */
            .user-profile {
                display: flex;
                align-items: center;
                gap: 10px;
                cursor: pointer;
                padding: 8px 15px;
                border-radius: 25px;
                transition: all 0.3s ease;
                border: 2px solid transparent;
            }

            .user-profile:hover {
                background: rgba(255, 107, 53, 0.1);
                border-color: var(--primary-color);
            }

            .user-avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: 700;
                color: #fff;
                border: 2px solid rgba(255, 107, 53, 0.3);
            }

            .user-name {
                color: var(--text-dark);
                font-weight: 500;
                margin-left: 8px;
            }

            /* Auth Buttons */
            .auth-buttons .btn {
                margin: 0 5px;
                padding: 10px 20px;
                border-radius: 25px;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .btn-register {
                background: transparent;
                color: var(--primary-color);
                border: 2px solid var(--primary-color);
            }

            .btn-register:hover {
                background: var(--primary-color);
                color: #fff;
                transform: translateY(-2px);
            }

            .btn-login {
                background: var(--primary-color);
                color: #fff;
                border: 2px solid var(--primary-color);
            }

            .btn-login:hover {
                background: #e55a2b;
                transform: translateY(-2px);
            }

            .btn-logout {
                background: #e74c3c;
                color: #fff;
                border: 2px solid #e74c3c;
            }

            .btn-logout:hover {
                background: #c0392b;
                transform: translateY(-2px);
            }

            /* Cart */
            .cart-icon {
                position: relative;
                background: var(--accent-color);
                color: #fff;
                padding: 12px 16px;
                border-radius: 25px;
                text-decoration: none;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .cart-icon:hover {
                background: #d68910;
                transform: translateY(-2px);
                color: #fff;
                text-decoration: none;
            }

            .cart-count {
                background: #fff;
                color: var(--accent-color);
                border-radius: 50%;
                padding: 2px 8px;
                font-size: 12px;
                font-weight: 700;
                min-width: 20px;
                text-align: center;
            }

            /* Hotline */
            .hotline {
                background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
                color: #fff;
                padding: 10px 20px;
                border-radius: 25px;
                text-decoration: none;
                font-weight: 600;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .hotline:hover {
                background: linear-gradient(135deg, #e55a2b, #d68910);
                transform: translateY(-2px);
                color: #fff;
                text-decoration: none;
                box-shadow: 0 4px 15px rgba(255, 107, 53, 0.3);
            }

            .hotline i {
                animation: pulse 2s infinite;
            }

            @keyframes pulse {
                0%, 100% {
                    transform: scale(1);
                }
                50% {
                    transform: scale(1.1);
                }
            }

            /* Dropdown Menu */
            .dropdown-menu {
                border: none;
                box-shadow: 0 10px 30px rgba(0,0,0,0.1);
                border-radius: 15px;
                padding: 15px 0;
                margin-top: 10px;
                background: #fff;
            }

            .dropdown-item {
                padding: 12px 25px;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 10px;
                color: var(--text-dark);
                border: none;
                background: none;
                width: 100%;
                text-align: left;
            }

            .dropdown-item:hover {
                background: rgba(255, 107, 53, 0.1);
                color: var(--primary-color);
                transform: translateX(5px);
            }

            .dropdown-item i {
                width: 20px;
                text-align: center;
            }

            /* Admin Sidebar */
            .admin-sidebar {
                position: fixed;
                top: 0;
                left: 0;
                height: 100vh;
                width: 260px;
                background: linear-gradient(135deg, var(--secondary-color), #34495e);
                color: #fff;
                z-index: 1000;
                overflow-y: auto;
                box-shadow: 5px 0 15px rgba(0,0,0,0.1);
            }

            .sidebar-header {
                padding: 30px 20px;
                text-align: center;
                background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
                margin-bottom: 20px;
            }

            .sidebar-header h3 {
                margin: 0;
                font-size: 1.5rem;
                font-weight: 700;
            }

            .sidebar-nav {
                padding: 0 10px;
            }

            .sidebar-nav .nav-item {
                margin: 8px 0;
            }

            .sidebar-nav .nav-link {
                color: #bdc3c7;
                padding: 15px 20px;
                border-radius: 10px;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 15px;
                border: none;
                background: none;
                width: 100%;
                text-align: left;
            }

            .sidebar-nav .nav-link:hover {
                background: rgba(255, 107, 53, 0.2);
                color: #fff;
                transform: translateX(5px);
            }

            .sidebar-nav .nav-link i {
                width: 20px;
                text-align: center;
            }

            /* Mobile Responsive */
            @media (max-width: 768px) {
                .navbar-brand {
                    font-size: 1.5rem;
                }

                .search-container {
                    max-width: 200px;
                }

                .user-name {
                    display: none;
                }

                .hotline span {
                    display: none;
                }

                .admin-sidebar {
                    width: 100%;
                    transform: translateX(-100%);
                    transition: transform 0.3s ease;
                }

                .admin-sidebar.show {
                    transform: translateX(0);
                }
            }
        </style>
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
                    <a href="userController" class="nav-link">
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
                        <a href="tel:1900xxxx" class="hotline">
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
                                        <a href="wishlist.jsp" class="cart-icon">
                                            <i class="fas fa-heart"></i>
                                            <span class="cart-count" id="favoriteCount">0</span>
                                        </a>
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



