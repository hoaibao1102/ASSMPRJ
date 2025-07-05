<%-- 
    Document   : RegisForm
    Created on : May 13, 2025, 4:54:54 PM
    Author     : MSI PC
--%>
<%@ page import="DTO.UserDTO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
                <!-- Xác định mode: edit hoặc register -->
                <c:set var="isEditMode" value="${param.mode eq 'edit' or requestScope.mode eq 'edit'}" />
                
                <!-- Xác định user data để hiển thị -->
                <c:choose>
                    <c:when test="${isEditMode}">
                        <c:set var="displayUser" value="${sessionScope.nameUser}" />
                    </c:when>
                    <c:otherwise>
                        <c:set var="displayUser" value="${requestScope.newUser}" />
                    </c:otherwise>
                </c:choose>

                <h2>
                    <c:choose>
                        <c:when test="${isEditMode}">Edit Your Profile</c:when>
                        <c:otherwise>Create Your Account</c:otherwise>
                    </c:choose>
                </h2>
                
                <!-- Hiển thị thông báo thành công -->
                <c:if test="${not empty requestScope.successMsg}">
                    <div style="background-color: #d4edda; color: #155724; padding: 10px; border-radius: 5px; margin-bottom: 15px;">
                        ${requestScope.successMsg}
                    </div>
                </c:if>
                
                <!-- Hiển thị thông báo lỗi -->
                <c:if test="${not empty requestScope.updateError}">
                    <div style="background-color: #f8d7da; color: #721c24; padding: 10px; border-radius: 5px; margin-bottom: 15px;">
                        ${requestScope.updateError}
                    </div>
                </c:if>

                <form action="${isEditMode ? 'userController' : 'regisController'}" method="get">
                    <input type="hidden" value="${isEditMode ? 'updateProfile' : 'regis'}" name="action"> 
                    <c:if test="${isEditMode}">
                        <input type="hidden" name="userId" value="${sessionScope.nameUser.idUser}" />
                    </c:if>

                    <label for="name">Full Name</label>
                    <input type="text" id="name" name="txtFullname" placeholder="John Doe" required 
                           value="${not empty param.txtFullname ? param.txtFullname : (displayUser.fullName != null ? displayUser.fullName : '')}">
                    <c:if test="${not empty requestScope.txtFullname_error}">
                        <div class="error-mess">
                            <i>${requestScope.txtFullname_error}</i>  
                        </div>
                    </c:if>

                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="txtEmail" placeholder="example@email.com" 
                           value="${not empty param.txtEmail ? param.txtEmail : (displayUser.email != null ? displayUser.email : '')}"
                           <c:choose>
                               <c:when test="${isEditMode}">readonly style="background-color: #f5f5f5; cursor: not-allowed;"</c:when>
                               <c:otherwise>required</c:otherwise>
                           </c:choose>>
                    <c:choose>
                        <c:when test="${isEditMode}">
                            <small style="color: green;">Email không thể thay đổi</small>
                        </c:when>
                        <c:otherwise>
                            <c:if test="${not empty requestScope.txtEmail_error}">
                                <div class="error-mess">
                                    <i>${requestScope.txtEmail_error}</i> 
                                </div>
                            </c:if>
                        </c:otherwise>
                    </c:choose>

                    <label for="phone">Phone Number</label>
                    <input type="tel" id="phone" name="txtPhone" placeholder="0123 456 789" required 
                           value="${not empty param.txtPhone ? param.txtPhone : (displayUser.phone != null ? displayUser.phone : '')}">
                    <c:if test="${not empty requestScope.txtPhone_error}">
                        <div class="error-mess">
                            <i>${requestScope.txtPhone_error}</i> 
                        </div>
                    </c:if>

                    <c:if test="${not isEditMode}">
                        <!-- Chỉ hiển thị password khi đăng ký -->
                        <label for="password">Password</label>
                        <input type="password" id="password" name="txtPassword" placeholder="********" required>
                        <c:if test="${not empty requestScope.txtPassword_error}">
                            <div class="error-mess">
                                <i>${requestScope.txtPassword_error}</i> 
                            </div>
                        </c:if>

                        <label for="confirm">Confirm Password</label>
                        <input type="password" id="confirm" name="txtConfirmPassword" placeholder="********" required>
                        <c:if test="${not empty requestScope.txtConfirmPassword_error}">
                            <div class="error-mess">
                                <span><i>${requestScope.txtConfirmPassword_error}</i></span>  
                            </div>
                        </c:if>

                        <div class="terms">
                            <input type="checkbox" id="agree" required>
                            <label for="agree">I agree to the <a href="#">Terms & Conditions</a></label>
                        </div>
                    </c:if>
                    
                    <c:if test="${isEditMode}">
                        <!-- Phần đổi mật khẩu cho edit mode (tùy chọn) -->
                        <div style="margin-top: 20px; padding-top: 20px; border-top: 1px solid #ddd;">
                            <h3 style="color: #666; font-size: 16px;">Đổi mật khẩu (tùy chọn)</h3>

                            <label for="currentPassword">Current Password</label>
                            <input type="password" id="currentPassword" name="txtCurrentPassword" placeholder="********">
                            <c:if test="${not empty requestScope.txtCurrentPassword_error}">
                                <div class="error-mess">
                                    <i>${requestScope.txtCurrentPassword_error}</i>
                                </div>
                            </c:if>

                            <label for="newPassword">New Password</label>
                            <input type="password" id="newPassword" name="txtNewPassword" placeholder="********">
                            <c:if test="${not empty requestScope.txtNewPassword_error}">
                                <div class="error-mess">
                                    <i>${requestScope.txtNewPassword_error}</i>
                                </div>
                            </c:if>

                            <label for="confirmNewPassword">Confirm New Password</label>
                            <input type="password" id="confirmNewPassword" name="txtConfirmNewPassword" placeholder="********">
                            <c:if test="${not empty requestScope.txtConfirmNewPassword_error}">
                                <div class="error-mess">
                                    <i>${requestScope.txtConfirmNewPassword_error}</i>
                                </div>
                            </c:if>

                            <small style="color: #666;">Để trống nếu không muốn đổi mật khẩu</small>
                        </div>
                    </c:if>

                    <button type="submit">
                        <c:choose>
                            <c:when test="${isEditMode}">Update Profile</c:when>
                            <c:otherwise>Sign Up</c:otherwise>
                        </c:choose>
                    </button>
                </form>

                <c:choose>
                    <c:when test="${not isEditMode}">
                        <div class="login-link">
                            Already have an account? <a href="LoginForm.jsp">Login here</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="login-link">
                            <a href="placeController?action=destination&page=indexjsp">Back to Home</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <%@include file="footer.jsp" %>

    </body>
</html>