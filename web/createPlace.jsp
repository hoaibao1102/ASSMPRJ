<%@page import="DTO.PlacesDTO"%>
<%@page import="UTILS.AuthUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Create Place</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #FEFEFE; /* Trắng ngọc trai */
                margin: 0;
                padding: 40px;
                color: #1F2937; /* Text chính */
            }
            .back-button {
                background: linear-gradient(135deg, #0EA5E9, #10B981); /* Gradient chính */
                color: white;
                padding: 10px 16px;
                border: none;
                border-radius: 4px; /* Giảm độ bo tròn */
                cursor: pointer;
                font-size: 14px;
                text-decoration: none;
                position: absolute;
                top: 20px;
                left: 20px;
            }
            .back-button:hover {
                background: linear-gradient(135deg, #0EA5E9, #10B981);
                opacity: 0.9;
            }
            h2 {
                text-align: center;
                color: #1F2937;
                margin-bottom: 30px;
            }
            .form-container {
                background-color: white;
                max-width: 700px;
                margin: 80px auto 0 auto;
                padding: 40px;
                border-radius: 8px; /* Giảm độ bo tròn */
                border-left: 4px solid #0EA5E9; /* Xanh biển Việt Nam */
            }
            label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600;
                color: #1F2937;
            }
            input[type="text"], select {
                width: 100%;
                padding: 12px;
                margin-bottom: 24px;
                border-radius: 6px;
                border: 1px solid #ddd;
                font-size: 15px;
                box-sizing: border-box;
            }
            input[type="text"]:focus, select:focus {
                border: 1px solid #0EA5E9; /* Xanh biển Việt Nam */
                outline: none;
            }
            input[type="checkbox"] {
                margin-right: 8px;
            }
            .form-buttons {
                display: flex;
                justify-content: space-between;
                margin-top: 30px;
            }
            input[type="submit"], input[type="reset"] {
                padding: 12px 24px;
                border: none;
                border-radius: 6px;
                font-size: 15px;
                cursor: pointer;
                color: white;
            }
            input[type="submit"] {
                background: linear-gradient(135deg, #FF6B35, #F59E0B); /* Gradient phụ */
            }
            input[type="submit"]:hover {
                opacity: 0.9;
            }
            input[type="reset"] {
                background-color: #6B7280; /* Text phụ */
            }
            input[type="reset"]:hover {
                opacity: 0.9;
            }
            .upload-container {
                margin-bottom: 24px;
            }
            .file-upload-wrapper {
                position: relative;
                margin-bottom: 12px;
            }
            .file-upload-button {
                background-color: #0EA5E9; /* Xanh biển Việt Nam */
                color: white;
                padding: 10px 18px;
                border-radius: 6px;
                border: none;
                cursor: pointer;
            }
            .file-upload-input {
                position: absolute;
                left: 0;
                top: 0;
                opacity: 0;
                width: 100%;
                height: 100%;
                cursor: pointer;
            }
            .file-info {
                font-size: 14px;
                color: #6B7280; /* Text phụ */
            }
            .progress-bar-container {
                width: 100%;
                background-color: #ddd;
                border-radius: 6px;
                height: 10px;
                margin-top: 10px;
            }
            .progress-bar {
                height: 10px;
                width: 0%;
                background: linear-gradient(135deg, #FF6B35, #F59E0B); /* Gradient phụ */
                border-radius: 6px;
            }
            .image-preview img {
                margin-top: 20px;
                max-width: 100%;
                border-radius: 6px;
                border: 1px solid #ddd;
            }
            .error-message {
                color: #FF6B35; /* Cam nhiệt đới */
                font-size: 13px;
                margin-top: 8px;
            }
        </style>
    </head>
    <body>
        <%if(AuthUtils.isAdmin(session)){%>
        <%
        PlacesDTO place = (PlacesDTO)request.getAttribute("place");
        String action ;
        if(place != null){
           action = "updateNewPlace";
       }else{
           action = "addNewPlace";
       }
        %>
        <a href="placeController?action=destination&page=destinationjsp" class="back-button">← Quay lại</a>
        <div class="form-container">
            <h2>Thêm Địa Điểm Mới</h2>
            <form action="MainController" method="post">
                <input type="hidden" name="action" value="<%=action%>">
                <label for="placename">Tên địa điểm</label>
                <input type="text" name="placename" id="placename" required value="<%=(place!= null && place.getPlaceName()!= null)? place.getPlaceName():""%>">
                <label for="description">Mô tả</label>
                <input type="text" name="description" id="description" required value="<%=(place!= null && place.getDescription() != null)? place.getDescription():""%>">
                <label for="img_places">Ảnh điểm đến</label>
                <input type="hidden" id="txtImage" name="txtImage" value="<%=(place != null && place.getImg() != null)?place.getImg():""%>"  >
                <div class="upload-container">
                    <div class="file-upload-wrapper">
                        <button type="button" class="file-upload-button">Chọn ảnh</button>
                        <input type="file" id="imageUpload" class="file-upload-input" accept="image/*"/ >
                    </div>
                    <div class="progress-bar-container" id="progressContainer" style="display:none;">
                        <div class="progress-bar" id="progressBar"></div>
                    </div>
                   
                    <div class="image-preview" id="imagePreview">
                        <% if (place != null && place.getImg() != null && !place.getImg().isEmpty()) { %>
                        <img src="<%= place.getImg() %>" alt="<%= place.getPlaceName() != null ? place.getPlaceName() : "" %>"/>
                        <% } %>
                    </div>
                </div>
                <label for="Featured">Nổi bật</label>
                <select name="Featured" id="Featured">
                    <option value="1">YES</option>
                    <option value="0">NO</option>
                </select>
                <label for="status">Trạng thái</label>
                <select name="status" id="status">
                    <option value="1">Hiện</option>
                    <option value="0">Ẩn</option>
                </select>
                <div class="form-buttons">
                    <input type="submit" value="Save">
                    <input type="reset" value="Reset" id="resetBtn">
                </div>
            </form>
        </div>
        <!-- jQuery -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#imageUpload').change(function () {
                    const file = this.files[0];
                    if (file) {
                        if (!file.type.match('image.*')) {
                            alert('Chỉ chấp nhận định dạng ảnh!');
                            this.value = '';
                            $('#fileInfo').text('Chưa chọn file');
                            return;
                        }
                        const fileSize = (file.size / 1024).toFixed(2) + ' KB';
                        $('#fileInfo').text(file.name + ' (' + fileSize + ')');
                        $('#progressContainer').show();
                        const reader = new FileReader();
                        reader.onprogress = function (e) {
                            if (e.lengthComputable) {
                                const percent = Math.round((e.loaded / e.total) * 100);
                                $('#progressBar').css('width', percent + '%');
                            }
                        };
                        reader.onload = function (e) {
                            $('#progressBar').css('width', '100%');
                            $('#txtImage').val(e.target.result);
                            $('#imagePreview').html('<img src="' + e.target.result + '" alt="Preview">');
                            setTimeout(() => {
                                $('#progressContainer').hide();
                                $('#progressBar').css('width', '0%');
                            }, 1000);
                        };
                        reader.onerror = function () {
                            alert('Lỗi khi đọc file.');
                            $('#progressContainer').hide();
                            $('#progressBar').css('width', '0%');
                            $('#fileInfo').text('Chưa chọn file');
                        };
                        reader.readAsDataURL(file);
                    } else {
                        $('#fileInfo').text('Chưa chọn file');
                    }
                });
                $('#resetBtn').click(function () {
                    $('#imagePreview').empty();
                    $('#fileInfo').text('Chưa chọn file');
                    $('#txtImage').val('');
                    $('#progressContainer').hide();
                    $('#progressBar').css('width', '0%');
                });
            });
        </script>
        <%
        }%>
    </body>
</html>