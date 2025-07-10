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
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>VN Tours</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <style>
            /* header */
            :root {
                /* Bảng màu chính - Tropical Vietnam */
                --primary-blue: #0EA5E9;
                --primary-orange: #FF6B35;
                --primary-green: #10B981;
                /* Bảng màu phụ */
                --golden-yellow: #F59E0B;
                --purple: #8B5CF6;
                --pearl-white: #FEFEFE;
                /* Gradient */
                --gradient-main: linear-gradient(135deg, #0EA5E9, #10B981);
                --gradient-secondary: linear-gradient(135deg, #FF6B35, #F59E0B);
                --gradient-accent: linear-gradient(135deg, #8B5CF6, #0EA5E9);
                /* Màu text */
                --text-dark: #1F2937;
                --text-medium: #6B7280;
                --text-light: #9CA3AF;
                /* Màu nền */
                --bg-light: #f8f9fa;
                --bg-white: #ffffff;
                /* Header height */
                --header-height: 70px;
            }
            /* Body padding to prevent content being hidden behind fixed header */
            body {
                padding-top: var(--header-height);
            }
            /* ===== HEADER STYLES (for regular users) ===== */
            .header {
                background: var(--gradient-main);
                padding: 0;
                box-shadow: 0 2px 10px rgba(14, 165, 233, 0.15);
                position: fixed; /* ← ADDED: Fixed position */
                top: 0; /* ← ADDED: Stick to top */
                left: 0; /* ← ADDED: Start from left */
                right: 0; /* ← ADDED: Extend to right */
                z-index: 1030; /* ← UPDATED: Higher z-index than Bootstrap's default */
                width: 100%; /* ← ADDED: Full width */
                height: var(--header-height); /* ← ADDED: Fixed height */
            }
            .header::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                right: 0;
                height: 2px;
                background: var(--gradient-secondary);
            }
            .navbar {
                padding: 0.75rem 0;
                height: 100%; /* ← ADDED: Full height of header */
                display: flex;
                align-items: center;
            }
            .navbar-brand {
                color: var(--pearl-white) !important;
                font-size: 1.75rem;
                font-weight: 700;
                text-decoration: none;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }
            .navbar-brand:hover {
                color: var(--golden-yellow) !important;
                transform: scale(1.05);
            }
            .navbar-brand i {
                font-size: 1.5rem;
                color: var(--golden-yellow);
            }
            .navbar-nav .nav-link {
                color: var(--pearl-white) !important;
                font-weight: 500;
                padding: 0.5rem 1rem !important;
                border-radius: 6px;
                transition: all 0.3s ease;
                position: relative;
                margin: 0 0.25rem;
            }
            .navbar-nav .nav-link:hover {
                color: var(--golden-yellow) !important;
                background: rgba(255, 255, 255, 0.1);
                transform: translateY(-2px);
            }
            .navbar-nav .nav-link::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 50%;
                width: 0;
                height: 2px;
                background: var(--golden-yellow);
                transition: all 0.3s ease;
                transform: translateX(-50%);
            }
            .navbar-nav .nav-link:hover::after {
                width: 80%;
            }
            .navbar-nav .btn {
                background: none;
                border: none;
                color: var(--pearl-white) !important;
                font-weight: 500;
                padding: 0.5rem 1rem;
                border-radius: 6px;
                transition: all 0.3s ease;
                position: relative;
                margin: 0 0.25rem;
            }
            .navbar-nav .btn:hover {
                color: var(--golden-yellow) !important;
                background: rgba(255, 255, 255, 0.1);
                transform: translateY(-2px);
            }
            .search-container {
                position: relative;
                margin: 0 1rem;
            }
            .search-form {
                display: flex;
                align-items: center;
                background: var(--bg-white);
                border-radius: 25px;
                padding: 0.25rem;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
                min-width: 250px;
            }
            .search-form:focus-within {
                box-shadow: 0 4px 15px rgba(14, 165, 233, 0.2);
                transform: translateY(-2px);
            }
            .search-input {
                border: none;
                outline: none;
                padding: 0.5rem 1rem;
                flex: 1;
                background: transparent;
                font-size: 0.95rem;
                color: var(--text-dark);
            }
            .search-input::placeholder {
                color: var(--text-medium);
            }
            .search-btn {
                background: var(--gradient-secondary);
                border: none;
                color: var(--pearl-white);
                padding: 0.5rem 1rem;
                border-radius: 20px;
                cursor: pointer;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }
            .search-btn:hover {
                transform: scale(1.05);
                box-shadow: 0 2px 8px rgba(255, 107, 53, 0.3);
            }
            .auth-section {
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }
            .auth-btn {
                background: var(--gradient-secondary);
                border: none;
                color: var(--pearl-white);
                padding: 0.5rem 1.25rem;
                border-radius: 20px;
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
            }
            .auth-btn:hover {
                color: var(--pearl-white);
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(255, 107, 53, 0.3);
            }
            .auth-btn.secondary {
                background: transparent;
                border: 2px solid var(--pearl-white);
            }
            .auth-btn.secondary:hover {
                background: var(--pearl-white);
                color: var(--primary-blue);
            }
            .logout-btn {
                background: var(--gradient-accent);
                border: none;
                color: var(--pearl-white);
                padding: 0.5rem 1.25rem;
                border-radius: 20px;
                cursor: pointer;
                transition: all 0.3s ease;
                font-weight: 500;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
            }
            .logout-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(139, 92, 246, 0.3);
            }
            .user-dropdown-container {
                position: relative;
            }
            .user-circle {
                width: 45px;
                height: 45px;
                border-radius: 50%;
                background: var(--gradient-secondary);
                color: var(--pearl-white);
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: 700;
                font-size: 1.1rem;
                cursor: pointer;
                transition: all 0.3s ease;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            }
            .user-circle:hover {
                transform: scale(1.1);
                box-shadow: 0 4px 15px rgba(255, 107, 53, 0.3);
            }
            .user-dropdown-menu {
                position: absolute;
                top: 60px;
                right: 0;
                background: var(--bg-white);
                border-radius: 12px;
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
                min-width: 250px;
                z-index: 1000;
                opacity: 0;
                visibility: hidden;
                transform: translateY(-10px);
                transition: all 0.3s ease;
                border: 1px solid rgba(14, 165, 233, 0.1);
                overflow: hidden;
            }
            .user-dropdown-menu.show {
                opacity: 1;
                visibility: visible;
                transform: translateY(0);
            }
            .user-dropdown-menu::before {
                content: '';
                position: absolute;
                top: -8px;
                right: 20px;
                width: 0;
                height: 0;
                border-left: 8px solid transparent;
                border-right: 8px solid transparent;
                border-bottom: 8px solid var(--bg-white);
            }
            .dropdown-header {
                padding: 1rem;
                text-align: center;
                background: var(--gradient-main);
                color: var(--pearl-white);
                font-weight: 600;

            }
            .dropdown-item {

                width: 100%;
                padding: 0.75rem 1rem;
                border: none;
                background: none;
                width: 100%;
                text-align: left;
                cursor: pointer;
                transition: all 0.3s ease;
                font-size: 0.95rem;
                color: var(--text-dark);
                display: flex;
                align-items: center;
                gap: 0.75rem;
                text-decoration: none;
            }
            .dropdown-item:hover {
                background: var(--bg-light);
                color: var(--primary-blue);
                transform: translateX(5px);
            }
            .dropdown-item i {
                color: var(--primary-blue);
                font-size: 1rem;
            }
            .dropdown-item-form {
                margin: 0;
                padding: 0;
            }
            /* ===== ADMIN SIDEBAR STYLES ===== */
            .admin-sidebar {
                position: fixed;
                top: 0;
                left: 0;
                height: 100vh;
                width: 260px;
                background: var(--gradient-main);
                padding: 1.5rem 1rem;
                color: var(--pearl-white);
                display: flex;
                flex-direction: column;
                z-index: 1000;
                box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
            }
            .sidebar-header {
                font-size: 1.75rem;
                font-weight: 700;
                margin-bottom: 2rem;
                text-align: center;
                padding-bottom: 1rem;
                border-bottom: 2px solid rgba(255, 255, 255, 0.2);
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
            }
            .sidebar-header i {
                color: var(--golden-yellow);
            }
            .sidebar-menu {
                list-style: none;
                padding: 0;
                margin: 0;
                flex: 1;
            }
            .sidebar-menu li {
                margin: 0.5rem 0;
            }
            .sidebar-menu a,
            .sidebar-menu button {
                color: var(--pearl-white);
                text-decoration: none;
                font-size: 1rem;
                background: none;
                border: none;
                cursor: pointer;
                transition: all 0.3s ease;
                width: 100%;
                padding: 0.75rem 1rem;
                display: flex;
                align-items: center;
                gap: 0.75rem;
                border-radius: 8px;
                position: relative;
                overflow: hidden;
            }
            .sidebar-menu a:hover,
            .sidebar-menu button:hover {
                background: rgba(255, 255, 255, 0.1);
                transform: translateX(5px);
            }
            .sidebar-menu a::before,
            .sidebar-menu button::before {
                content: '';
                position: absolute;
                left: 0;
                top: 0;
                bottom: 0;
                width: 0;
                background: var(--golden-yellow);
                transition: width 0.3s ease;
            }
            .sidebar-menu a:hover::before,
            .sidebar-menu button:hover::before {
                width: 4px;
            }
            .sidebar-menu form {
                margin: 0;
                width: 100%;
            }
            /* Body padding adjustment for admin layout */
            body.admin-layout {
                padding-top: 0;
                margin-left: 260px;
            }
            /* Responsive */
            @media (max-width: 991.98px) {
                .search-container {
                    margin: 0.5rem 0;
                    order: 3;
                    width: 100%;
                }
                .search-form {
                    min-width: 100%;
                }
                .auth-section {
                    margin-top: 0.5rem;
                }
            }
            @media (max-width: 767.98px) {
                .navbar-brand {
                    font-size: 1.5rem;
                }
                .user-dropdown-menu {
                    right: -50px;
                    min-width: 200px;
                }

                .admin-sidebar {
                    width: 100%;
                    transform: translateX(-100%);
                    transition: transform 0.3s ease;
                }
                .admin-sidebar.show {
                    transform: translateX(0);
                }
                body.admin-layout {
                    margin-left: 0;
                }
            }
            /* Smooth animations */
            * {
                transition: all 0.3s ease;
            }
            /* Focus states for accessibility */
            .search-input:focus,
            .navbar-nav .btn:focus,
            .dropdown-item:focus {
                outline: 2px solid var(--golden-yellow);
                outline-offset: 2px;
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
        <!-- Admin Sidebar Layout -->
        <div class="admin-sidebar" id="adminSidebar">
            <div class="sidebar-header">
                <i class="fas fa-cog"></i>
                Admin Panel
            </div>
            <ul class="sidebar-menu">
                <li>
                    <a href="placeController?action=destination&page=indexjsp">
                        <i class="fas fa-home"></i>
                        Trang chủ
                    </a>
                </li>
                <li>
                    <a href="placeController?action=destination&page=destinationjsp">
                        <i class="fas fa-map-marker-alt"></i>
                        Quản lý điểm đến
                    </a>
                </li>
                <li>
                    <a href="userController">
                        <i class="fas fa-users"></i>
                        Quản lý người dùng
                    </a>
                </li>
                <li>
                    <form action="loginController" method="post">
                        <input type="hidden" name="action" value="logout" />
                        <button type="submit" class="logout-btn">
                            <i class="fas fa-sign-out-alt"></i>
                            Đăng xuất
                        </button>
                    </form>
                </div>
            </nav>
        </div>
        <% } else { %>
        <!-- Regular Header Layout -->
        <header class="header">
            <nav class="navbar navbar-expand-lg">
                <div class="container">
                    <a class="navbar-brand" href="placeController?action=destination&page=indexjsp">
                        <i class="fas fa-plane"></i>
                        VN Tours
                    </a>

                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" 
                            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav me-auto">
                            <li class="nav-item">
                                <form action="MainController" method="get" class="d-inline">
                                    <input type="hidden" name="action" value="destination">
                                    <input type="hidden" name="page" value="indexjsp">
                                    <button type="submit" class="btn nav-link">
                                        <i class="fas fa-home"></i>
                                        Trang chủ
                                    </button>
                                </form>
                            </li>
                            <li class="nav-item">
                                <form action="MainController" method="get" class="d-inline">
                                    <input type="hidden" name="action" value="destination">
                                    <input type="hidden" name="page" value="destinationjsp">
                                    <button type="submit" class="btn nav-link">
                                        <i class="fas fa-map-marker-alt"></i>
                                        Điểm đến
                                    </button>
                                </form>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="about.jsp">
                                    <i class="fas fa-info-circle"></i>
                                    Giới thiệu
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="contact.jsp">
                                    <i class="fas fa-phone"></i>
                                    Liên hệ
                                </a>
                            </li>
                        </ul>

                        <div class="d-flex align-items-center flex-wrap">
                            <!-- Search Form -->
                            <div class="search-container">
                                <form action="MainController" method="get" class="search-form">
                                    <input type="hidden" name="action" value="search">
                                    <input type="text" class="search-input" name="searchItem" 
                                           placeholder="Tìm kiếm địa điểm..." value="<%= searchTour %>">
                                    <button type="submit" class="search-btn">
                                        <i class="fas fa-search"></i>
                                    </button>
                                </form>
                            </div>

                            <!-- Auth Section -->
                            <div class="auth-section">
                                <% if (user == null) { %>
                                <a href="RegisForm.jsp" class="auth-btn secondary">
                                    <i class="fas fa-user-plus"></i>
                                    Đăng ký
                                </a>
                                <a href="LoginForm.jsp" class="auth-btn">
                                    <i class="fas fa-sign-in-alt"></i>
                                    Đăng nhập
                                </a>
                                <% } else { %>
                                <!-- User Dropdown -->
                                <div class="user-dropdown-container">
                                    <div class="user-circle" onclick="toggleUserDropdown()" 
                                         title="<%= user.getFullName() %>">
                                        <%= user.getFullName().trim().substring(0,1).toUpperCase() %>
                                    </div>

                                    <div class="user-dropdown-menu" id="userDropdownMenu">
                                        <div class="dropdown-header">
                                            <strong><%= user.getFullName() %></strong>
                                        </div>

                                        <form action="MainController" method="post" class="dropdown-item-form">
                                            <input type="hidden" name="action" value="editProfile" />
                                            <input type="hidden" name="userId" value="<%= user.getIdUser() %>" />
                                            <button type="submit" class="dropdown-item">
                                                <i class="fas fa-user-edit"></i>
                                                Chỉnh sửa hồ sơ
                                            </button>
                                        </form>

                                        <form action="MainController" method="post" class="dropdown-item-form">
                                            <input type="hidden" name="action" value="orderOfUser" />
                                            <input type="hidden" name="userId" value="<%= user.getIdUser() %>" />
                                            <button type="submit" class="dropdown-item">
                                                <i class="fas fa-history"></i>
                                                Lịch sử giao dịch
                                            </button>
                                        </form>
                                    </div>
                                </div>

                                <form action="loginController" method="post" class="d-inline">
                                    <input type="hidden" name="action" value="logout" />
                                    <button type="submit" class="logout-btn">
                                        <i class="fas fa-sign-out-alt"></i>
                                        Đăng xuất
                                    </button>
                                </form>
                                <% } %>
                            </div>

                        </div>
                        <% } %>
                    </div>
                </div>
            </nav>
        </header>

        <% } %>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                        function toggleUserDropdown() {
                                            const dropdown = document.getElementById("userDropdownMenu");
                                            dropdown.classList.toggle("show");
                                        }

                                        // Close dropdown when clicking outside
                                        document.addEventListener('click', function (event) {
                                            const userContainer = document.querySelector('.user-dropdown-container');
                                            const dropdown = document.getElementById("userDropdownMenu");

                                            if (userContainer && !userContainer.contains(event.target)) {
                                                dropdown.classList.remove("show");
                                            }
                                        });

                                        // Mobile admin sidebar toggle (if needed)
                                        function toggleAdminSidebar() {
                                            const sidebar = document.getElementById("adminSidebar");
                                            if (sidebar) {
                                                sidebar.classList.toggle("show");
                                            }
                                        }

                                        // Close mobile menu when clicking outside
                                        document.addEventListener('click', function (event) {
                                            const navbarCollapse = document.getElementById('navbarNav');
                                            const navbarToggler = document.querySelector('.navbar-toggler');

                                            if (navbarCollapse && navbarToggler) {
                                                if (!navbarCollapse.contains(event.target) && !navbarToggler.contains(event.target)) {
                                                    const bsCollapse = new bootstrap.Collapse(navbarCollapse, {
                                                        toggle: false
                                                    });
                                                    bsCollapse.hide();
                                                }
                                            }
                                        });
        </script>
    </body>
</html>
