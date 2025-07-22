<%@page import="DTO.PlacesDTO"%>
<%@page import="UTILS.AuthUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>VN Tours</title>
        <link href="assets/css/create_place.css" rel="stylesheet">
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