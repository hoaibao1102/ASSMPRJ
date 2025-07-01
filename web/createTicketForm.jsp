<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar, java.util.Date" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Thêm Tour</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f4f6f8;
                padding: 40px;
                margin: 0;
            }

            .form-container {
                background: white;
                max-width: 900px;
                margin: auto;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }

            h2 {
                text-align: center;
                color: #2c3e50;
                font-size: 24px;
                margin-bottom: 20px;
            }

            label {
                display: block;
                margin-top: 15px;
                font-weight: 500;
                font-size: 14px;
                color: #34495e;
            }

            input, select, textarea {
                width: 100%;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 5px;
                margin-top: 5px;
                font-size: 14px;
                box-sizing: border-box;
            }

            input[type="file"] {
                padding: 5px;
            }

            select {
                cursor: pointer;
            }

            fieldset {
                border: 1px solid #e1e1e1;
                padding: 20px;
                border-radius: 7px;
                margin-top: 20px;
                background-color: #fafafa;
            }

            legend {
                font-size: 16px;
                font-weight: bold;
                color: #2c3e50;
            }

            .day-details {
                background-color: #ecf0f1;
                border-radius: 5px;
                padding: 15px;
                margin-bottom: 15px;
                margin-top: 10px;
            }

            .form-buttons {
                display: flex;
                gap: 20px;
                margin-top: 20px;
                justify-content: center;
            }

            .form-buttons input[type="submit"], .form-buttons input[type="reset"] {
                padding: 12px 20px;
                font-size: 16px;
                cursor: pointer;
                border: none;
                border-radius: 5px;
                background-color: #3498db;
                color: white;
                transition: background-color 0.3s;
            }

            .form-buttons input[type="submit"]:hover, .form-buttons input[type="reset"]:hover {
                background-color: #2980b9;
            }

            .back-link {
                display: inline-block;
                margin-top: 20px;
                color: #2980b9;
                text-decoration: none;
                font-size: 14px;
            }

            .back-link:hover {
                text-decoration: underline;
            }

            .image-preview {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                margin-top: 10px;
                padding: 10px;
                border: 1px dashed #ddd;
                border-radius: 5px;
                background-color: #f9f9f9;
                min-height: 60px;
                align-items: center;
            }

            .image-preview.empty {
                display: none;
            }

            .image-item {
                position: relative;
                display: inline-block;
            }

            .image-preview img {
                max-width: 120px;
                max-height: 120px;
                border-radius: 6px;
                border: 1px solid #ccc;
                object-fit: cover;
            }

            .image-remove-btn {
                position: absolute;
                top: -8px;
                right: -8px;
                background-color: #e74c3c;
                color: white;
                border: none;
                border-radius: 50%;
                width: 20px;
                height: 20px;
                font-size: 12px;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 0;
            }

            .image-remove-btn:hover {
                background-color: #c0392b;
            }

            .preview-label {
                font-size: 12px;
                color: #666;
                margin-top: 5px;
                text-align: center;
                word-break: break-all;
            }

            button {
                padding: 10px 15px;
                font-size: 14px;
                background-color: #2ecc71;
                border: none;
                border-radius: 5px;
                color: white;
                cursor: pointer;
                margin-top: 10px;
            }

            button:hover {
                background-color: #27ae60;
            }

            .date-input-group {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-top: 10px;
            }

            .date-input-group input[type="date"] {
                flex: 1;
                margin-top: 0;
            }

            .remove-date-btn {
                background-color: #e74c3c;
                color: white;
                border: none;
                border-radius: 50%;
                width: 30px;
                height: 30px;
                font-size: 16px;
                cursor: pointer;
                margin-top: 0;
                padding: 0;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .remove-date-btn:hover {
                background-color: #c0392b;
            }

            input[type="date"] {
                padding: 12px;
                font-size: 14px;
            }

            input:focus, select:focus, textarea:focus {
                outline: none;
                border-color: #3498db;
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <button onclick="window.history.back();">← Quay lại</button>

            <h2>
                <c:choose>
                    <c:when test="${not empty requestScope.tourTicket}">
                        Cập nhật Tour
                    </c:when>
                    <c:otherwise>
                        Thêm Tour Mới
                    </c:otherwise>
                </c:choose>
            </h2>


            <form action="placeController" method="post" onsubmit="prepareFormSubmission()">

                <!-- Xác định action dựa trên việc có tourTicket hay không -->
                <input type="hidden" name="action" value="${not empty requestScope.tourTicket ? 'submitUpdateTour' : 'submitAddTour'}"/>

                <!-- Nếu là update, cần có ID -->
                <c:if test="${not empty requestScope.tourTicket}">
                    <input type="hidden" name="tourId" value="${requestScope.tourTicket.idTourTicket}"/>
                </c:if>

                <fieldset>
                    <legend>Thông Tin Tour</legend>

                    <label for="nametour">Tên Tour</label>
                    <input type="text" name="nametour" id="nametour" required ${not empty requestScope.tourTicket?'style="pointer-events: none;"' : '' } 
                           value="${not empty requestScope.tourTicket ? requestScope.tourTicket.nametour : ''}"/>

                    <label for="placestart">Điểm khởi hành</label>
                    <input type="text" name="placestart" id="placestart" 
                           placeholder="Nhập điểm khởi hành" required 
                           value="${not empty requestScope.tourTicket ? requestScope.tourTicket.placestart : ''}"/>

                    <label for="duration">Thời gian</label>
                    <select name="duration" id="duration" onchange="updateDayDetails(this.value)" required ${not empty requestScope.tourTicket?'style="pointer-events: none;"' : ''}>
                        <option value="">-- Chọn số ngày --</option>
                        <option value="2" 
                                ${not empty requestScope.tourTicket && requestScope.tourTicket.duration eq '2 ngày 1 đêm' ? 'selected' : ''}>
                            2 ngày 1 đêm
                        </option>
                        <option value="3" 
                                ${not empty requestScope.tourTicket && requestScope.tourTicket.duration eq '3 ngày 2 đêm' ? 'selected' : ''}>
                            3 ngày 2 đêm
                        </option>
                        <option value="4" 
                                ${not empty requestScope.tourTicket && requestScope.tourTicket.duration eq '4 ngày 3 đêm' ? 'selected' : ''}>
                            4 ngày 3 đêm
                        </option>
                    </select>

                    <fieldset id="dayDetailsContainer">
                        <legend>Chi Tiết Ngày</legend>
                        <div id="dayDetails">
                            <!-- Hiển thị chi tiết ngày nếu có dữ liệu -->

                            <c:if test="${not empty requestScope.ticketDayDetail}">
                                <!-- Trường hợp có dữ liệu chi tiết ngày (update mode) -->
                                <c:forEach var="dayDetail" items="${requestScope.ticketDayDetail}" varStatus="status">
                                    <div class="day-details">
                                        <div><b>Ngày ${status.index + 1}</b></div>

                                        <label for="Description_${status.index + 1}">Mô tả chung:</label>
                                        <textarea name="Description_${status.index + 1}" 
                                                  id="Description_${status.index + 1}">${dayDetail.description}</textarea>

                                        <label for="morningDescription_${status.index + 1}">Buổi sáng:</label>
                                        <textarea name="morningDescription_${status.index + 1}" 
                                                  id="morningDescription_${status.index + 1}">${dayDetail.morning}</textarea>

                                        <label for="afternoonDescription_${status.index + 1}">Buổi chiều:</label>
                                        <textarea name="afternoonDescription_${status.index + 1}" 
                                                  id="afternoonDescription_${status.index + 1}">${dayDetail.afternoon}</textarea>

                                        <label for="eveningDescription_${status.index + 1}">Buổi tối:</label>
                                        <textarea name="eveningDescription_${status.index + 1}" 
                                                  id="eveningDescription_${status.index + 1}">${dayDetail.evening}</textarea>
                                    </div>
                                </c:forEach>
                            </c:if>

                        </div>
                    </fieldset>

                    <label for="transport">Phương tiện</label>
                    <select name="transport_name" id="transport" required>
                        <option value="">-- Chọn phương tiện --</option>
                        <option value="Máy bay" 
                                ${not empty requestScope.tourTicket && requestScope.tourTicket.transport_name eq 'Máy bay' ? 'selected' : ''}>
                            Máy bay
                        </option>
                        <option value="Tàu hỏa" 
                                ${not empty requestScope.tourTicket && requestScope.tourTicket.transport_name eq 'Tàu hỏa' ? 'selected' : ''}>
                            Tàu hỏa
                        </option>
                        <option value="Xe khách" 
                                ${not empty requestScope.tourTicket && requestScope.tourTicket.transport_name eq 'Xe khách' ? 'selected' : ''}>
                            Xe khách
                        </option>
                    </select>

                    <label for="price">Giá (VND)</label>
                    <input type="number" name="price" id="price" min="0"  required 
                           value="${not empty requestScope.tourTicket ? requestScope.tourTicket.price : ''}"/>

                    <!-- Chỉ hiển thị số lượng vé khi tạo mới -->
                    <c:if test="${empty requestScope.tourTicket}">
                        <label for="maxTickets">Số lượng vé tối đa (tối đa 20)</label>
                        <input type="number" name="maxTickets" id="maxTickets" min="1" max="20" required/>
                    </c:if>


                    <label>Ngày xuất phát (tối đa 3 ngày)</label>
                    <div id="departureDatesContainer">
                        <!-- Container chứa tất cả các input ngày -->
                        <c:choose>
                            <c:when test="${not empty startDateTour}">
                                <c:forEach var="dateTour" items="${startDateTour}" varStatus="status">
                                    <div class="date-input-group" id="dateGroup${status.index + 1}">
                                        <input type="date" name="departureDate${status.index + 1}" min="${dateTour.startDate}" 
                                               value="${dateTour.startDate}"/>
                                    </div>
                                </c:forEach>
                            </c:when>

                            <c:otherwise>
                                <div class="date-input-group" id="dateGroup1">
                                    <input type="date" name="departureDate1" 
                                           required min="${tomorrowDate}"/>
                                    <button type="button" class="remove-date-btn" 
                                            onclick="removeDepartureDate(1)">✕</button>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <button type="button" onclick="addDepartureDate()">+ Thêm ngày</button>


                    <!-- liên quan đến ảnh -->
                    <label for="imgCover">Ảnh đại diện tour</label>
                    <input type="hidden" id="imgCover" name="imgCover" value="${not empty requestScope.tourTicket ? tourTicket.img_Tour : ''}"  >

                    <div class="upload-container">
                        <div class="file-upload-wrapper">
                            <input type="file" id="imageUpload" class="file-upload-input" accept="image/*"/ >
                        </div>

                        <div class="progress-bar-container" id="progressContainer" style="display:none;">
                            <div class="progress-bar" id="progressBar"></div>
                        </div>

                        <div class="image-preview" id="imagePreview">
                            <c:if test="${not empty requestScope.tourTicket}">
                                <img src="${tourTicket.img_Tour}" alt="${tourTicket.nametour}"/> 
                            </c:if>
                        </div>
                    </div>




                    <label for="galleryUpload">Ảnh liên quan đến tour (có thể chọn nhiều ảnh)</label>
                    <input type="file" id="galleryUpload" accept="image/*" multiple onchange="previewGalleryImages(this)" />
                    <!-- Preview chung cho ảnh cũ (có thể đổi) và ảnh mới -->
                    <div id="galleryPreviewContainer" class="image-preview">
                        <c:forEach var="image" items="${requestScope.ticketImgDetail}" varStatus="status">
                            <div class="image-item" data-index="${status.index}">
                                <!-- Hiển thị ảnh cũ -->
                                <img src="${image.imgUrl}" id="oldImg-${status.index}" />

                                <!-- Nút xóa ảnh cũ -->
                                <button type="button" onclick="removeImage(${status.index}, 'old')">×</button>

                                <!-- Ẩn input để gửi URL của ảnh cũ -->
                                <input type="hidden" name="oldImgUrls" value="${image.imgUrl}" id="oldImgUrl-${status.index}">
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Input hidden để lưu tất cả ảnh -->
                    <input type="hidden" id="imgGalleryData" name="imgGalleryData" value="">



                    <div class="form-buttons">
                        <input type="submit" 
                               value="${not empty requestScope.tourTicket ? 'Cập nhật tour' : 'Thêm tour'}">
                        <input type="reset" value="Reset">
                    </div>
                    <a href="javascript:history.back()" class="back-link">← Quay lại</a>
                </fieldset>
            </form>
        </div>




        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>
                                    //xử lý các ô cập nhật mô tả và buổi dựa vào select trên thời gian
                                    // Cập nhật chi tiết ngày dựa trên số ngày được chọn
                                    function updateDayDetails(duration) {
                                        const dayCount = parseInt(duration);
                                        const dayDetailsContainer = document.getElementById('dayDetails');

                                        // Chỉ cập nhật khi tạo mới (không có tourTicket)
                                        const isUpdate = ${not empty requestScope.tourTicket ? 'true' : 'false'};
                                        if (isUpdate)
                                            return;

                                        dayDetailsContainer.innerHTML = '';
                                        if (!dayCount || dayCount < 1)
                                            return;

                                        for (let i = 1; i <= dayCount; i++) {
                                            const dayDetailHTML = `
                        <div class="day-details">
                            <div><b>Ngày \${i}</b></div>
                            <label for="Description_\${i}">Mô tả chung:</label>
                            <textarea name="Description_\${i}" id="Description_\${i}">Chưa có thông tin</textarea>
                            <label for="morningDescription_\${i}">Buổi sáng:</label>
                            <textarea name="morningDescription_\${i}" id="morningDescription_\${i}">Chưa có thông tin</textarea>
                            <label for="afternoonDescription_\${i}">Buổi chiều:</label>
                            <textarea name="afternoonDescription_\${i}" id="afternoonDescription_\${i}">Chưa có thông tin</textarea>
                            <label for="eveningDescription_\${i}">Buổi tối:</label>
                            <textarea name="eveningDescription_\${i}" id="eveningDescription_\${i}">Chưa có thông tin</textarea>
                        </div>
                    `;
                                            dayDetailsContainer.insertAdjacentHTML('beforeend', dayDetailHTML);
                                        }
                                    }

                                    // Tạo ngày hiện tại cho JavaScript
                                    const tomorrow = new Date();
                                    tomorrow.setDate(tomorrow.getDate() + 1);
                                    const tomorrowStr = tomorrow.toISOString().split('T')[0];
                                    // Biến lưu trữ files đã chọn cho gallery
                                    let selectedGalleryFiles = [];
                                    // Thêm ngày xuất phát

                                    function addDepartureDate() {
                                        const container = document.getElementById('departureDatesContainer');
                                        const dateGroups = container.querySelectorAll('.date-input-group');

                                        if (dateGroups.length < 3) {
                                            const tomorrow = new Date();
                                            tomorrow.setDate(tomorrow.getDate() + 1);
                                            const tomorrowStr = tomorrow.toISOString().split('T')[0];

                                            const groupIndex = dateGroups.length + 1;
                                            const newDateGroup = document.createElement('div');
                                            newDateGroup.className = 'date-input-group';
                                            newDateGroup.id = `dateGroup${groupIndex}`;

                                            newDateGroup.innerHTML = `
                    <input type="date" name="departureDate\${groupIndex}" 
                    id="departureDate\${groupIndex}" 
                    required min="\${tomorrowStr}"/>
                    <button type="button" class="remove-date-btn" 
                    onclick="removeDepartureDate(\${groupIndex})">✕</button>
        `;

                                            container.appendChild(newDateGroup);
                                            updateRemoveButtons();
                                        }
                                    }

                                    // Xóa ngày xuất phát
                                    function removeDepartureDate(index) {
                                        const dateGroup = document.getElementById(`dateGroup${index}`);
                                        if (dateGroup) {
                                            dateGroup.remove();           // Xóa element
                                            reorderDateInputs();          // Sắp xếp lại thứ tự
                                            updateRemoveButtons();        // Cập nhật nút xóa
                                        }
                                    }

                                    // Sắp xếp lại thứ tự các input sau khi xóa
                                    function reorderDateInputs() {
                                        const container = document.getElementById('departureDatesContainer');
                                        const dateGroups = container.querySelectorAll('.date-input-group');

                                        dateGroups.forEach((group, index) => {
                                            const newIndex = index + 1;
                                            group.id = `dateGroup${newIndex}`;

                                            const input = group.querySelector('input[type="date"]');
                                            input.name = `departureDate${newIndex}`;
                                            input.id = `departureDate${newIndex}`;

                                            const removeBtn = group.querySelector('.remove-date-btn');
                                            removeBtn.setAttribute('onclick', `removeDepartureDate(${newIndex})`);
                                        });
                                    }

                                    function updateRemoveButtons() {
                                        const container = document.getElementById('departureDatesContainer');
                                        const dateGroups = container.querySelectorAll('.date-input-group');
                                        const removeButtons = container.querySelectorAll('.remove-date-btn');

                                        // Hiện/ẩn nút xóa dựa trên số lượng ngày
                                        removeButtons.forEach(btn => {
                                            btn.style.display = dateGroups.length > 1 ? 'flex' : 'none';
                                        });
                                    }

                                    // Tự động cập nhật chi tiết ngày khi trang được load (chỉ khi tạo mới)
                                    window.onload = function () {
                                        const durationSelect = document.getElementById('duration');
                                        const isUpdate = ${not empty requestScope.tourTicket ? 'true' : 'false'};

                                        if (!isUpdate && durationSelect.value) {
                                            updateDayDetails(durationSelect.value);
                                        }

                                        // Cập nhật trạng thái nút xóa dkhi trang load
                                        updateRemoveButtons();
                                    };



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
                                                    $('#imgCover').val(e.target.result);
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
                                            $('#imgCover').val('');
                                            $('#progressContainer').hide();
                                            $('#progressBar').css('width', '0%');
                                        });
                                    });



                                    let galleryImages = []; // Mảng lưu trữ dữ liệu gallery images, bao gồm cả ảnh cũ và mới
                                    let galleryImagesSend = []; // Mảng gửi ảnh, sẽ chứa dữ liệu base64 của tất cả ảnh
                                    let hasChanges = false;

                                    $(document).ready(function () {
                                        // Đưa ảnh cũ vào mảng galleryImages
                                        $("input[name='oldImgUrls']").each(function () {
                                            galleryImages.push({
                                                name: this.value,
                                                data: this.value, // Dùng imgUrl như là base64 hoặc URL để gửi qua servlet
                                                isNew: false  // Đánh dấu ảnh cũ
                                            });

                                            document.getElementById("imgGalleryData").value += "---" + this.value;
                                        });

                                        function resizeImage(file, maxWidth, maxHeight, callback) {
                                            const img = new Image();
                                            const reader = new FileReader();

                                            reader.onload = function (e) {
                                                img.src = e.target.result;
                                            };

                                            img.onload = function () {
                                                const canvas = document.createElement('canvas');
                                                const ctx = canvas.getContext('2d');

                                                // Giữ tỷ lệ của ảnh ban đầu
                                                let width = img.width;
                                                let height = img.height;

                                                if (width > height) {
                                                    if (width > maxWidth) {
                                                        height *= maxWidth / width;
                                                        width = maxWidth;
                                                    }
                                                } else {
                                                    if (height > maxHeight) {
                                                        width *= maxHeight / height;
                                                        height = maxHeight;
                                                    }
                                                }

                                                canvas.width = width;
                                                canvas.height = height;

                                                ctx.drawImage(img, 0, 0, width, height);

                                                // Chuyển canvas thành base64
                                                const resizedBase64 = canvas.toDataURL(file.type); // Hoặc bạn có thể chọn định dạng file khác như 'image/jpeg'

                                                callback(resizedBase64);  // Trả về base64 sau khi nén
                                            };

                                            reader.readAsDataURL(file); // Đọc file ảnh
                                        }

                                        $('#galleryUpload').change(function () {
                                            const files = this.files;

                                            if (files.length > 10) {
                                                alert("Bạn chỉ được chọn tối đa 10 ảnh.");
                                                this.value = ''; // reset lại
                                                return;
                                            }

                                            Array.from(files).forEach((file, index) => {
                                                resizeImage(file, 800, 600, function (resizedBase64) { // Giới hạn kích thước là 800x600px
                                                    // Kiểm tra xem ảnh đã có trong mảng chưa
                                                    const isDuplicate = galleryImages.some(img => img.data === resizedBase64);
                                                    if (isDuplicate) {
                                                        alert("Ảnh đã được chọn rồi.");
                                                        return; // Ngừng thêm ảnh nếu trùng
                                                    }

                                                    // Thêm ảnh mới vào mảng galleryImages
                                                    galleryImages.push({name: file.name, data: resizedBase64, isNew: true});
                                                    updateGalleryPreview();
                                                });
                                            });
                                        });



                                        // Xóa ảnh khỏi danh sách khi nhấn nút xóa (cả ảnh cũ và mới)
                                        window.removeImage = function (index, type) {
                                            if (type === 'old') {
                                                // Xóa ảnh cũ khỏi mảng galleryImages
                                                galleryImages = galleryImages.filter((img, i) => i !== index && img.isNew === false);
                                            } else {
                                                // Xóa ảnh mới khỏi mảng galleryImages
                                                galleryImages = galleryImages.filter((img, i) => i !== index && img.isNew === true);
                                            }

                                            updateGalleryPreview(); // Cập nhật lại phần preview
                                        };
                                    });

// Cập nhật preview gallery
                                    function updateGalleryPreview() {
                                        const previewContainer = document.getElementById("galleryPreviewContainer");
                                        previewContainer.innerHTML = ''; // Xoá preview cũ

                                        // Làm mới mảng galleryImagesSend trước khi thêm dữ liệu mới
                                        galleryImagesSend = []; // Reset mảng gửi

                                        // Hiển thị ảnh đã có trong galleryImages
                                        galleryImages.forEach((img, index) => {
                                            const container = document.createElement("div");
                                            container.className = "image-item";
                                            container.dataset.index = index;

                                            const imgElement = document.createElement("img");
                                            imgElement.src = img.data;
                                            container.appendChild(imgElement);

                                            // Thêm nút xóa cho mỗi ảnh
                                            const removeBtn = document.createElement("button");
                                            removeBtn.textContent = "×"; // Dấu chéo
                                            removeBtn.onclick = function () {
                                                removeImage(index, img.isNew ? 'new' : 'old'); // Gọi hàm xóa ảnh
                                            };
                                            container.appendChild(removeBtn); // Thêm dấu chéo vào ảnh

                                            previewContainer.appendChild(container);

                                            // Thêm dữ liệu vào mảng galleryImagesSend
                                            galleryImagesSend.push(img.data);
                                        });

                                        // Cập nhật dữ liệu vào input hidden (chuẩn bị gửi qua servlet)
                                        document.getElementById("imgGalleryData").value = galleryImagesSend.join("---");
                                    }

// Hàm gửi dữ liệu form với các ảnh đã chọn
                                    function submitForm() {
                                        if (galleryImages.length === 0) {
                                            alert("Bạn phải chọn ít nhất một ảnh.");
                                            return;
                                        }

                                        // Cập nhật lại dữ liệu nếu cần thiết (trước khi gửi đi)
                                        updateGalleryPreview();

                                        // Gửi form
                                        document.forms["yourForm"].submit(); // Thay "yourForm" bằng tên form của bạn
                                    }


        </script>
    </body>
</html>