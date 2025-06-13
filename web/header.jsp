<%-- 
    Document   : header
    Created on : May 12, 2025
    Author     : MSI PC
--%>
<%@ page import="UTILS.AuthUtils"%>
<%@ page import="DTO.UserDTO"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>VN Tours</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            /* ===== COMMON STYLES ===== */
            a {
                text-decoration: none;
            }

            button {
                font-family: inherit;
            }

            /* ===== HEADER STYLES (for regular users) ===== */
            .header {
                background-color: #2c3e50;
                padding: 1rem 0;
                width: 100%;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 1rem;
            }

            .nav {
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
                position: relative;
            }

            .logo {
                color: #fff;
                font-size: 1.5rem;
                font-weight: 700;
            }

            .menu-toggle {
                display: none;
                font-size: 1.8rem;
                color: #fff;
                cursor: pointer;
            }

            .menu {
                display: flex;
                list-style: none;
                gap: 1.5rem;
            }

            .menu-item {
                display: flex;
                align-items: center;
            }

            .menu-item a,
            .menu-item input[type="submit"] {
                color: #fff;
                text-decoration: none;
                font-size: 1rem;
                background: none;
                border: none;
                cursor: pointer;
                padding: 0;
                transition: color 0.3s ease;
            }

            .menu-item a:hover,
            .menu-item input[type="submit"]:hover {
                color: #f1c40f;
            }

            .right-section {
                display: flex;
                align-items: center;
                gap: 1rem;
                flex-wrap: wrap;
            }

            .search-bar {
                display: flex;
                align-items: center;
                background: #fff;
                border-radius: 20px;
                padding: 0.4rem 1rem;
            }

            .search-input {
                border: none;
                outline: none;
                padding: 0.2rem 0.5rem;
                width: 160px;
                font-size: 1rem;
            }

            .search-button {
                background: none;
                border: none;
                cursor: pointer;
                color: #2c3e50;
                font-size: 1.2rem;
            }

            .auth-buttons {
                display: flex;
                gap: 0.8rem;
            }

            .auth-buttons a {
                background-color: #3498db;
                color: #fff;
                padding: 0.4rem 0.8rem;
                border-radius: 4px;
                font-size: 0.9rem;
                transition: background-color 0.3s ease;
            }

            .auth-buttons a:hover {
                background-color: #2980b9;
            }

            .logout-btn {
                background: #3498db;
                border: none;
                border-radius: 4px;
                color: #fff;
                padding: 0.4rem 0.8rem;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .logout-btn:hover {
                background: #2980b9;
            }

            .user-circle {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                background-color: #3498db;
                color: #fff;
                font-weight: 700;
                width: 40px;
                height: 40px;
                border-radius: 50%;
                font-size: 1.2rem;
                margin-right: 0.5rem;
            }

            @media (max-width: 768px) {
                .menu {
                    display: none;
                    flex-direction: column;
                    background-color: #2c3e50;
                    position: absolute;
                    top: 100%;
                    left: 0;
                    width: 100%;
                    padding: 1rem 0;
                    z-index: 99;
                    gap: 0;
                }

                .menu.show {
                    display: flex;
                }

                .menu-toggle {
                    display: block;
                }

                .menu-item {
                    width: 100%;
                    text-align: center;
                    padding: 0.5rem 0;
                }

                .right-section {
                    flex-direction: column;
                    align-items: flex-start;
                    width: 100%;
                }

                .search-bar {
                    width: 100%;
                }

                .auth-buttons {
                    width: 100%;
                }

                .auth-buttons a,
                .logout-btn {
                    width: auto;
                }
            }

            /* ===== ADMIN SIDEBAR STYLES ===== */
            .admin-sidebar {
                position: fixed;
                top: 0;
                left: 0;
                height: 100vh;
                width: 240px;
                background-color: #2c3e50;
                padding: 1.5rem 1rem;
                color: #fff;
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            .sidebar-header {
                font-size: 1.6rem;
                font-weight: bold;
                margin-bottom: 2rem;
                text-align: center;
                width: 100%;
            }

            .sidebar-menu {
                list-style: none;
                width: 100%;
                display: flex;
                flex-direction: column;
                align-items: center;
                padding: 0;
            }

            .sidebar-menu li {
                width: 100%;
                margin: 0.5rem 0;
                text-align: center;
            }

            .sidebar-menu a,
            .sidebar-menu button {
                color: #fff;
                font-size: 1rem;
                background: none;
                border: none;
                cursor: pointer;
                transition: color 0.3s ease;
                width: 100%;
                padding: 0.6rem 0;
                display: inline-block;
            }

            .sidebar-menu a:hover,
            .sidebar-menu button:hover {
                color: #f1c40f;
            }

            .sidebar-menu form {
                margin: 0;
                width: 100%;
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
        <div class="admin-sidebar">
            <div class="sidebar-header">Admin Panel</div>
            <ul class="sidebar-menu">
                <li><a href="placeController?action=destination&page=indexjsp">Trang chủ</a></li>
                <li><a href="placeController?action=destination&page=destinationjsp">Điểm đến</a></li>

                <li><a href="UserManager.jsp">User</a></li>
                <li>
                    <form action="loginController" method="post">
                        <input type="hidden" name="action" value="logout" />
                        <button class="logout-btn">Đăng xuất</button>
                    </form>
                </li>
            </ul>
        </div>
        <% } else { %>
        <!-- Regular Header Layout -->
        <header class="header">
            <div class="container">
                <nav class="nav">
                    <a href="placeController?action=destination&page=indexjsp" class="logo">VN Tours</a>
                    <div class="menu-toggle" onclick="toggleMenu()">☰</div>
                    <ul class="menu" id="menu">
                        <li class="menu-item">
                            <form action="placeController" method="get">
                                <input type="hidden" name="action" value="destination">
                                <input type="hidden" name="page" value="indexjsp">
                                <input type="submit" value="Trang chủ">
                            </form>
                        </li>
                        <li class="menu-item">
                            <form action="placeController" method="get">
                                <input type="hidden" name="action" value="destination">
                                <input type="hidden" name="page" value="destinationjsp">
                                <input type="submit" value="Điểm đến">
                            </form>
                        </li>
                        <li class="menu-item"><a href="about.jsp">Giới thiệu</a></li>
                        <li class="menu-item"><a href="contact.jsp">Liên hệ</a></li>
                    </ul>
                    <div class="right-section">
                        <form action="placeController" method="get">
                            <div class="search-bar">
                                <input type="hidden" name="action" value="search">
                                <input type="text" class="search-input" name="searchItem" placeholder="Tìm Kiếm...." value="<%= searchTour %>">
                                <button class="search-button">🔍</button>
                            </div>
                        </form>
                        <div class="auth-buttons">
                            <% if (user == null) { %>
                            <a href="RegisForm.jsp">Đăng ký</a>
                            <a href="LoginForm.jsp">Đăng nhập</a>
                            <% } else { %>
                            <div class="user-circle" title="<%= user.getFullName() %>">
                                <%= user.getFullName().substring(0,1).toUpperCase() %>
                            </div>
                            <form action="loginController" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="logout" />
                                <button type="submit" class="logout-btn">Đăng xuất</button>
                            </form>
                            <% } %>
                        </div>
                    </div>
                </nav>
            </div>
        </header>
        <% } %>

        <script>
            function toggleMenu() {
                const menu = document.getElementById("menu");
                menu.classList.toggle("show");
            }
        </script>
    </body>
</html>
