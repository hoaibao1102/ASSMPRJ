<%-- 
    Document   : RegisForm
    Created on : May 13, 2025, 4:54:54 PM
    Author     : MSI PC
--%>
<%@ page import="DTO.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Register - Tour Booking</title>
        <link rel="stylesheet" href="assets/css/bodyCss.css"/>
        <style>
            .content_sub{
                margin: 0 auto;
            }

            /* Định dạng container của form đăng ký */
            .register-container {
                background-color: #fff;
                padding: 3rem;
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 450px;
                box-sizing: border-box;
                text-align: center;
                margin-top: 2rem;/* Đảm bảo form không bị che khuất bởi header */
                margin-bottom: 2rem; /* Để form không bị đè lên footer */
            }

            /* Tiêu đề form */
            .register-container h2 {
                color: #333;
                font-size: 1.8rem;
                margin-bottom: 1.5rem;
            }

            /* Định dạng các input */
            .register-container input[type="text"],
            .register-container input[type="email"],
            .register-container input[type="tel"],
            .register-container input[type="password"] {
                width: 100%;
                padding: 12px;
                margin: 8px 0;
                border: 1px solid #ccc;
                border-radius: 8px;
                font-size: 14px;
                box-sizing: border-box;
            }

            /* Định dạng cho nhãn của các input */
            .register-container label {
                font-weight: 500;
                margin-top: 10px;
                display: block;
                text-align: left;
                width: 100%;
            }

            /* Định dạng nút đăng ký */
            .register-container button {
                width: 100%;
                padding: 12px;
                background: #3498db;
                color: white;
                font-size: 16px;
                border: none;
                border-radius: 8px;
                margin-top: 20px;
                cursor: pointer;
            }

            .register-container button:hover {
                background: #2980b9;
            }

            /* Điều khoản */
            .register-container .terms {
                font-size: 13px;
                margin-top: 10px;
                text-align: left;
            }

            /* Liên kết đăng nhập */
            .register-container .login-link {
                text-align: center;
                margin-top: 15px;
                font-size: 14px;
            }

            .register-container .login-link a {
                color: #3498db;
                text-decoration: none;
            }

            .register-container .login-link a:hover {
                text-decoration: underline;
            }

            .error-mess{
                color: red;
                font-size: 14px;
                position: relative;
                top: -7px;
                text-align: left;
            }
        </style>
    </head>
    <body>

        <%@include file="header.jsp" %>
        <div class="content content_sub">
            <div class="register-container">
                <%
                    String mode = request.getAttribute("mode") != null ? request.getAttribute("mode").toString() : "register";
                    boolean isEditMode = "edit".equals(mode);
                    
                    UserDTO userRegis = (UserDTO)request.getAttribute("newUser");
                    UserDTO currentUser = (UserDTO)session.getAttribute("nameUser");

                    // Sử dụng newUser attribute cho cả 2 trường hợp
                    UserDTO displayUser = userRegis != null ? userRegis : currentUser;
                    String userName = displayUser != null && displayUser.getFullName() != null ? displayUser.getFullName() : "";
                    String userPhone = displayUser != null && displayUser.getPhone() != null ? displayUser.getPhone() : "";
                    String userEmail = displayUser != null && displayUser.getEmail() != null ? displayUser.getEmail() : "";
                %>

                <h2><%= isEditMode ? "Edit Your Profile" : "Create Your Account" %></h2>
                
                <%
                    String successMsg = (String) request.getAttribute("successMsg");
                    String updateError = (String) request.getAttribute("updateError");
                %>
                <% if (successMsg != null) { %>
                <div style="background-color: #d4edda; color: #155724; padding: 10px; border-radius: 5px; margin-bottom: 15px;">
                    <%= successMsg %>
                </div>
                <% } %>
                <% if (updateError != null) { %>
                <div style="background-color: #f8d7da; color: #721c24; padding: 10px; border-radius: 5px; margin-bottom: 15px;">
                    <%= updateError %>
                </div>
                <% } %>

                <form action="<%= isEditMode ? "userController" : "regisController" %>" method="get">
                    <input type="hidden" value="<%= isEditMode ? "updateProfile" : "regis" %>" name="action"> 
                    <% if (isEditMode) { %>
                    <input type="hidden" name="userId" value="<%= currentUser.getIdUser() %>" />
                    <% } %>

                    <label for="name">Full Name</label>
                    <input type="text" id="name" name="txtFullname" placeholder="John Doe" required value="<%=userName%>">
                    <%
                        String txtFullname_error = request.getAttribute("txtFullname_error")+"";
                    %>
                    <div class="error-mess">
                        <i> <%=txtFullname_error.equals("null")?"":txtFullname_error%></i>  
                    </div>

                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="txtEmail" placeholder="example@email.com" 
                           <%= isEditMode ? "readonly style='background-color: #f5f5f5; cursor: not-allowed;'" : "required" %> 
                           value="<%=userEmail%>">
                    <% if (isEditMode) { %>
                    <small style="color: green;">Email không thể thay đổi</small>
                    <% } else { %>
                    <%
                        String txtEmail_error = request.getAttribute("txtEmail_error")+"";
                    %>
                    <div class="error-mess">
                        <i> <%=txtEmail_error.equals("null")?"":txtEmail_error%></i> 
                    </div>
                    <% } %>

                    <label for="phone">Phone Number</label>
                    <input type="tel" id="phone" name="txtPhone" placeholder="0123 456 789" required value="<%=userPhone%>">
                    <%
                        String txtPhone_error = request.getAttribute("txtPhone_error")+"";
                    %>
                    <div class="error-mess">
                        <i> <%=txtPhone_error.equals("null")?"":txtPhone_error%></i> 
                    </div>

                    <% if (!isEditMode) { %>
                    <!-- Chỉ hiển thị password khi đăng ký -->
                    <label for="password">Password</label>
                    <input type="password" id="password" name="txtPassword" placeholder="********" required>
                    <%
                        String txtPassword_error = request.getAttribute("txtPassword_error")+"";
                    %>
                    <div class="error-mess">
                        <i> <%=txtPassword_error.equals("null")?"":txtPassword_error%></i> 
                    </div>

                    <label for="confirm">Confirm Password</label>
                    <input type="password" id="confirm" name="txtConfirmPassword" placeholder="********" required>
                    <%
                        String txtConfirmPassword_error = request.getAttribute("txtConfirmPassword_error")+"";
                    %>
                    <div class="error-mess">
                        <span><i> <%=txtConfirmPassword_error.equals("null")?"":txtConfirmPassword_error%></i></span>  
                    </div>

                    <div class="terms">
                        <input type="checkbox" id="agree" required>
                        <label for="agree">I agree to the <a href="#">Terms & Conditions</a></label>
                    </div>
                    <% } else { %>
                    <!-- Phần đổi mật khẩu cho edit mode (tùy chọn) -->
                    <div style="margin-top: 20px; padding-top: 20px; border-top: 1px solid #ddd;">
                        <h3 style="color: #666; font-size: 16px;">Đổi mật khẩu (tùy chọn)</h3>

                        <label for="currentPassword">Current Password</label>
                        <input type="password" id="currentPassword" name="txtCurrentPassword" placeholder="********">
                        <%
                            String txtCurrentPassword_error = request.getAttribute("txtCurrentPassword_error")+"";
                        %>
                        <div class="error-mess">
                            <i> <%=txtCurrentPassword_error.equals("null")?"":txtCurrentPassword_error%></i>
                        </div>

                        <label for="newPassword">New Password</label>
                        <input type="password" id="newPassword" name="txtNewPassword" placeholder="********">
                        <%
                            String txtNewPassword_error = request.getAttribute("txtNewPassword_error")+"";
                        %>
                        <div class="error-mess">
                            <i> <%=txtNewPassword_error.equals("null")?"":txtNewPassword_error%></i>
                        </div>

                        <label for="confirmNewPassword">Confirm New Password</label>
                        <input type="password" id="confirmNewPassword" name="txtConfirmNewPassword" placeholder="********">
                        <%
                            String txtConfirmNewPassword_error = request.getAttribute("txtConfirmNewPassword_error")+"";
                        %>
                        <div class="error-mess">
                            <i> <%=txtConfirmNewPassword_error.equals("null")?"":txtConfirmNewPassword_error%></i>
                        </div>

                        <small style="color: #666;">Để trống nếu không muốn đổi mật khẩu</small>
                    </div>
                    <% } %>

                    <button type="submit">
                        <%= isEditMode ? "Update Profile" : "Sign Up" %>
                    </button>
                </form>

                <% if (!isEditMode) { %>
                <div class="login-link">
                    Already have an account? <a href="LoginForm.jsp">Login here</a>
                </div>
                <% } else { %>
                <div class="login-link">
                    <a href="placeController?action=destination&page=indexjsp">Back to Home</a>
                </div>
                <% } %>
            </div>
        </div>
        <%@include file="footer.jsp" %>

    </body>
</html>