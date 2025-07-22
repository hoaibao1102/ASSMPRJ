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
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>VN Tours</title>
        
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href="assets/css/register.css" rel="stylesheet">
    </head>
    <body>
        <%@include file="header.jsp" %>
        
        <div class="header-pattern"></div>
        
        <div class="content content_sub">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-6 col-md-8 col-sm-10">
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
                            <div class="register-header">
                                <div class="icon-wrapper">
                                    <i class="fas fa-${isEditMode ? 'user-cog' : 'plane'} fa-2x text-white"></i>
                                </div>
                                <h2>
                                    <c:choose>
                                        <c:when test="${isEditMode}">Chỉnh sửa thông tin cá nhân</c:when>
                                        <c:otherwise>Tạo tài khoản</c:otherwise>
                                    </c:choose>
                                </h2>
                                <p>
                                    <c:choose>
                                        <c:when test="${isEditMode}">Cập nhật thông tin của bạn để tiếp tục khám phá</c:when>
                                        <c:otherwise>Nhập vào để bắt đầu hành trình nhiệt đới</c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                            
                            <div class="register-form">
                                <!-- Hiển thị thông báo thành công -->
                                <c:if test="${not empty requestScope.successMsg}">
                                    <div class="alert alert-success" role="alert">
                                        <i class="fas fa-check-circle me-2"></i>
                                        ${requestScope.successMsg}
                                    </div>
                                </c:if>
                                
                                <!-- Hiển thị thông báo lỗi -->
                                <c:if test="${not empty requestScope.updateError}">
                                    <div class="alert alert-danger" role="alert">
                                        <i class="fas fa-exclamation-circle me-2"></i>
                                        ${requestScope.updateError}
                                    </div>
                                </c:if>
                                <form action="${isEditMode ? 'userController' : 'regisController'}" method="post">
                                    <input type="hidden" value="${isEditMode ? 'updateProfile' : 'regis'}" name="action"> 
                                    <c:if test="${isEditMode}">
                                        <input type="hidden" name="userId" value="${sessionScope.nameUser.idUser}" />
                                    </c:if>
                                    <div class="form-floating">
                                        <input type="text" class="form-control" id="name" name="txtFullname" 
                                               placeholder="John Doe" required 
                                               value="${not empty param.txtFullname ? param.txtFullname : (displayUser.fullName != null ? displayUser.fullName : '')}">
                                        <label for="name"><i class="fas fa-user me-2"></i>Họ và tên</label>
                                        <c:if test="${not empty requestScope.txtFullname_error}">
                                            <div class="error-mess">
                                                <i>${requestScope.txtFullname_error}</i>  
                                            </div>
                                        </c:if>
                                    </div>
                                    <div class="form-floating">
                                        <input type="email" class="form-control" id="email" name="txtEmail" 
                                               placeholder="example@email.com" 
                                               value="${not empty param.txtEmail ? param.txtEmail : (displayUser.email != null ? displayUser.email : '')}"
                                               <c:choose>
                                                   <c:when test="${isEditMode}">readonly</c:when>
                                                   <c:otherwise>required</c:otherwise>
                                               </c:choose>>
                                        <label for="email"><i class="fas fa-envelope me-2"></i>Email</label>
                                        <c:choose>
                                            <c:when test="${isEditMode}">
                                                <div class="readonly-info">
                                                    Email không thể thay đổi
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <c:if test="${not empty requestScope.txtEmail_error}">
                                                    <div class="error-mess">
                                                        <i>${requestScope.txtEmail_error}</i> 
                                                    </div>
                                                </c:if>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="form-floating">
                                        <input type="tel" class="form-control" id="phone" name="txtPhone" 
                                               placeholder="0123 456 789" required 
                                               value="${not empty param.txtPhone ? param.txtPhone : (displayUser.phone != null ? displayUser.phone : '')}">
                                        <label for="phone"><i class="fas fa-phone me-2"></i>Số điện thoại</label>
                                        <c:if test="${not empty requestScope.txtPhone_error}">
                                            <div class="error-mess">
                                                <i>${requestScope.txtPhone_error}</i> 
                                            </div>
                                        </c:if>
                                    </div>
                                    <c:if test="${not isEditMode}">
                                        <!-- Chỉ hiển thị password khi đăng ký -->
                                        <div class="form-floating">
                                            <input type="password" class="form-control" id="password" name="txtPassword" 
                                                   placeholder="********" required>
                                            <label for="password"><i class="fas fa-lock me-2"></i>Mật khẩu</label>
                                            <c:if test="${not empty requestScope.txtPassword_error}">
                                                <div class="error-mess">
                                                    <i>${requestScope.txtPassword_error}</i> 
                                                </div>
                                            </c:if>
                                        </div>
                                        <div class="form-floating">
                                            <input type="password" class="form-control" id="confirm" name="txtConfirmPassword" 
                                                   placeholder="********" required>
                                            <label for="confirm"><i class="fas fa-lock me-2"></i>Nhập lại mật khẩu</label>
                                            <c:if test="${not empty requestScope.txtConfirmPassword_error}">
                                                <div class="error-mess">
                                                    <i>${requestScope.txtConfirmPassword_error}</i>
                                                </div>
                                            </c:if>
                                        </div>
                                        <div class="terms-checkbox">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" id="agree" required>
                                                <label class="form-check-label" for="agree">
                                                    Tôi đồng ý với <a href="#" style="color: var(--coral-orange);">Điều khoản & Điều kiện</a>
                                                </label>
                                            </div>
                                        </div>
                                    </c:if>
                                    
                                    <c:if test="${isEditMode}">
                                        <!-- Phần đổi mật khẩu cho edit mode (tùy chọn) -->
                                        <div class="password-section">
                                            <h3>
                                                <i class="fas fa-key me-2"></i>
                                                Thay đổi mật khẩu (Tùy chọn)
                                            </h3>
                                            <div class="form-floating">
                                                <input type="password" class="form-control" id="currentPassword" name="txtCurrentPassword" 
                                                       placeholder="********">
                                                <label for="currentPassword"><i class="fas fa-unlock me-2"></i>Mật khẩu hiện tại</label>
                                                <c:if test="${not empty requestScope.txtCurrentPassword_error}">
                                                    <div class="error-mess">
                                                        <i>${requestScope.txtCurrentPassword_error}</i>
                                                    </div>
                                                </c:if>
                                            </div>
                                            <div class="form-floating">
                                                <input type="password" class="form-control" id="newPassword" name="txtNewPassword" 
                                                       placeholder="********">
                                                <label for="newPassword"><i class="fas fa-lock me-2"></i>Mật khẩu mới</label>
                                                <c:if test="${not empty requestScope.txtNewPassword_error}">
                                                    <div class="error-mess">
                                                        <i>${requestScope.txtNewPassword_error}</i>
                                                    </div>
                                                </c:if>
                                            </div>
                                            <div class="form-floating">
                                                <input type="password" class="form-control" id="confirmNewPassword" name="txtConfirmNewPassword" 
                                                       placeholder="********">
                                                <label for="confirmNewPassword"><i class="fas fa-lock me-2"></i>Nhập lại mật khẩu mới</label>
                                                <c:if test="${not empty requestScope.txtConfirmNewPassword_error}">
                                                    <div class="error-mess">
                                                        <i>${requestScope.txtConfirmNewPassword_error}</i>
                                                    </div>
                                                </c:if>
                                            </div>
                                            <small class="text-muted">
                                                <i class="fas fa-info-circle me-1"></i>
                                                Để trống nếu bạn không muốn thay đổi mật khẩu
                                            </small>
                                        </div>
                                    </c:if>
                                    <div class="d-grid gap-2 mt-4">
                                        <button type="submit" class="btn btn-primary btn-lg">
                                            <i class="fas fa-${isEditMode ? 'save' : 'user-plus'} me-2"></i>
                                            <c:choose>
                                                <c:when test="${isEditMode}">Cập nhật thông tin</c:when>
                                                <c:otherwise>Đăng ký</c:otherwise>
                                            </c:choose>
                                        </button>
                                    </div>
                                </form>
                                <div class="login-link">
                                    <c:choose>
                                        <c:when test="${not isEditMode}">
                                            <p class="mb-0">Đã có tài khoản? 
                                                <a href="LoginForm.jsp">
                                                    <i class="fas fa-sign-in-alt me-1"></i>Đăng nhập
                                                </a>
                                            </p>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="placeController?action=destination&page=indexjsp">
                                                <i class="fas fa-home me-1"></i>Quay lại trang chủ
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <%@include file="footer.jsp" %>
        <!-- Bootstrap 5 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>