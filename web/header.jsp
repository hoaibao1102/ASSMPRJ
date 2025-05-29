<%-- 
    Document   : header
    Created on : May 12, 2025, 3:41:05 PM
    Author     : MSI PC
--%>
<%@ page import="DTO.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

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

            /* Logo */
            .logo {
                color: #fff;
                font-size: 1.5rem;
                font-weight: 700;
                text-decoration: none;
            }

            /* Menu toggle (hamburger) */
            .menu-toggle {
                display: none;
                font-size: 1.8rem;
                color: #fff;
                cursor: pointer;
            }

            /* Menu list */
            .menu {
                display: flex;
                list-style: none;
                gap: 1.5rem;
            }

            .menu-item {
                /* tránh form bị tràn khi có form trong menu */
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
                font-family: inherit;
                transition: color 0.3s ease;
            }

            .menu-item a:hover,
            .menu-item input[type="submit"]:hover {
                color: #f1c40f;
            }

            /* Right section: search + auth */
            .right-section {
                display: flex;
                align-items: center;
                gap: 1rem;
                flex-wrap: wrap;
            }

            /* Search bar */
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

            /* Auth buttons */
            .auth-buttons {
                display: flex;
                gap: 0.8rem;
            }

            /* Link buttons */
            .auth-buttons a {
                background-color: #3498db;
                color: #fff;
                padding: 0.4rem 0.8rem;
                border-radius: 4px;
                text-decoration: none;
                font-size: 0.9rem;
                transition: background-color 0.3s ease;
                white-space: nowrap;
            }

            .auth-buttons a:hover {
                background-color: #2980b9;
            }

            /* User circle */
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
                cursor: default;
                user-select: none;
                margin-right: 0.5rem;
                text-transform: uppercase;
            }

            /* Logout button */
            .logout-btn {
                background: #3498db;
                border: none;
                border-radius: 4px;
                color: #fff;
                padding: 0.4rem 0.8rem;
                cursor: pointer;
                transition: background-color 0.3s ease;
                white-space: nowrap;
            }

            .logout-btn:hover {
                background: #2980b9;
            }

            /* Responsive: Mobile */
            @media (max-width: 768px) {
                /* Menu hidden by default */
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

                /* Show menu when toggled */
                .menu.show {
                    display: flex;
                }

                /* Show hamburger */
                .menu-toggle {
                    display: block;
                }

                /* Menu items: full width, center text */
                .menu-item {
                    width: 100%;
                    text-align: center;
                    padding: 0.5rem 0;
                }

                .menu-item a,
                .menu-item input[type="submit"] {
                    font-size: 1.1rem;
                    display: block;
                    width: 100%;
                }

                /* Right section vertical */
                .right-section {
                    flex-direction: column;
                    align-items: flex-start;
                    margin-top: 1rem;
                    width: 100%;
                    gap: 0.8rem;
                }

                /* Search bar full width */
                .search-bar {
                    width: 100%;
                    padding: 0.5rem 1rem;
                }

                .search-input {
                    width: 100%;
                    font-size: 1rem;
                }

                /* Auth buttons full width */
                .auth-buttons {
                    width: 100%;
                    justify-content: flex-start;
                    gap: 0.5rem;
                }

                .auth-buttons a,
                .logout-btn {
                    width: auto;
                    font-size: 1rem;
                    padding: 0.5rem 1rem;
                }
            }


        </style>
    </head>
    <body>
        <header class="header">
            <div class="container">
                <nav class="nav">
                    <a href="index.jsp" class="logo">VN Tours</a>

                    <div class="menu-toggle" onclick="toggleMenu()">☰</div>

                    <ul class="menu" id="menu">
                        <li class="menu-item"><a href="index.jsp">Trang chủ</a></li>
                        <li class="menu-item">
                            <form action="placeController" method="get">
                                <input type="hidden" name="action" value="destination">
                                <input type="submit"  value="Điểm đến">
                            </form>

                        </li>
                        <li class="menu-item"><a href="about.jsp">Giới thiệu</a></li>
                        <li class="menu-item"><a href="contact.jsp">Liên hệ</a></li>
                    </ul>

                    <div class="right-section">

                        <%
                                String searchTour = request.getAttribute("searchTourInfor")+"";
                                if(searchTour.equals("null")){
                                     searchTour = "";
                                }
                        %>
                        <form action="placeController" method="get">
                            <div class="search-bar">
                                <input type="hidden" name="action" value="search">
                                <input type="text" class="search-input" name="searchTour" placeholder="Tìm Kiếm...." value="<%=searchTour%>">
                                <button class="search-button">🔍</button>
                            </div>
                        </form>

                        <div class="auth-buttons">
                            <%
                                 UserDTO user = (UserDTO)session.getAttribute("nameUser");
                                 if (user == null) {
                            %>
                            <a href="RegisForm.jsp">Đăng ký</a>
                            <a href="LoginForm.jsp">Đăng nhập</a>
                            <%
                                } else {
                            %>
                            <div class="user-circle" title="<%= user.getFullName() %>">
                                <%= user.getFullName().substring(0,1).toUpperCase() %>
                            </div>                            
                            <form action="loginController" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="logout" />
                                <button type="submit" class="logout-btn">Đăng xuất</button>
                            </form>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </nav>
            </div>
        </header>

        <script>
            function toggleMenu() {
                const menu = document.getElementById("menu");
                menu.classList.toggle("show");
            }
        </script>

    </body>
</html>
