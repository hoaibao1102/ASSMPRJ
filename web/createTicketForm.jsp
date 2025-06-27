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

            <form action="placeController" method="post" enctype="multipart/form-data">
                <!-- Xác định action dựa trên việc có tourTicket hay không -->
                <input type="hidden" name="action" 
                       value="${not empty requestScope.tourTicket ? 'submitUpdateTour' : 'submitAddTour'}"/>

                <!-- Nếu là update, cần có ID -->
                <c:if test="${not empty requestScope.tourTicket}">
                    <input type="hidden" name="tourId" value="${requestScope.tourTicket.idTourTicket}"/>
                </c:if>

                <fieldset>
                    <legend>Thông Tin Tour</legend>

                    <label for="nametour">Tên Tour</label>
                    <input type="text" name="nametour" id="nametour" required 
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
                        <option value="Xe lửa" 
                                ${not empty requestScope.tourTicket && requestScope.tourTicket.transport_name eq 'Xe lửa' ? 'selected' : ''}>
                            Xe lửa
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
                                        <input type="date" name="departureDate${status.index + 1}" min="${tomorrowDate}" 
                                               value="${dateTour.startDate}"/>
                                        <button type="button" class="remove-date-btn" 
                                                onclick="removeDepartureDate(${status.index + 1})" >✕</button>
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


                    <!--      phần ảnh -->
                    <label for="imgCover">Ảnh đại diện tour</label>
                    <input type="file" name="imgCover" id="imgCover" accept="image/*" 
                           onchange="previewCoverImage(this)"
                           ${empty requestScope.tourTicket ? 'required' : ''}/>

                    <div id="coverImagePreview" class="image-preview ${not empty requestScope.tourTicket.img_Tour ? '' : 'empty'}">
                        <!-- Hiển thị ảnh đại diện nếu đã có -->
                        <c:if test="${not empty requestScope.tourTicket.img_Tour}">
                            <div class="image-item">
                                <img src="${requestScope.tourTicket.img_Tour}" alt="Cover Image Preview" />
                                <button type="button" class="image-remove-btn" onclick="removeCoverImage()" title="Xóa ảnh">✕</button>
                                <div class="preview-label">${requestScope.tourTicket.img_Tour}</div>
                            </div>
                        </c:if>
                    </div>



                    <label for="imgGallery">Ảnh liên quan đến tour (tối đa 10 ảnh)</label>
                    <input type="file" name="imgGallery" id="imgGallery" accept="image/*" 
                           multiple onchange="previewGalleryImages(this)"/>

                    <div id="galleryImagePreview" class="image-preview ${not empty requestScope.tourTicket.imgGalleryList ? '' : 'empty'}">
                        <!-- Hiển thị ảnh đã có trong gallery -->
                        <c:if test="${not empty requestScope.ticketImgDetail}">
                            <c:forEach var="image" items="${requestScope.ticketImgDetail}">
                                <div class="image-item">
                                    <img src="${image}" alt="Gallery Image Preview"/>
                                    <button type="button" class="image-remove-btn" onclick="removeGalleryImage('${image}')" title="Xóa ảnh">✕</button>
                                    <div class="preview-label">${image}</div>
                                </div>
                            </c:forEach>
                        </c:if>
                    </div>



                    <div class="form-buttons">
                        <input type="submit" 
                               value="${not empty requestScope.tourTicket ? 'Cập nhật tour' : 'Thêm tour'}">
                        <input type="reset" value="Reset">
                    </div>
                    <a href="javascript:history.back()" class="back-link">← Quay lại</a>
                </fieldset>
            </form>
        </div>

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




            // Preview ảnh đại diện (chỉ 1 ảnh)
            function previewCoverImage(input) {
                const preview = document.getElementById('coverImagePreview');
                preview.innerHTML = '';

                if (input.files && input.files[0]) {
                    const file = input.files[0];

                    // Kiểm tra kích thước file (tối đa 5MB)
                    if (file.size > 5 * 1024 * 1024) {
                        alert('Kích thước ảnh không được vượt quá 5MB!');
                        input.value = '';
                        preview.classList.add('empty');
                        return;
                    }

                    // Kiểm tra định dạng file
                    if (!file.type.startsWith('image/')) {
                        alert('Vui lòng chọn file ảnh hợp lệ!');
                        input.value = '';
                        preview.classList.add('empty');
                        return;
                    }

                    const reader = new FileReader();
                    reader.onload = function (e) {
                        const imageItem = document.createElement('div');
                        imageItem.className = 'image-item';

                        imageItem.innerHTML = `
                            <img src="\${e.target.result}" alt="Cover Preview"/>
                            <button type="button" class="image-remove-btn" onclick="removeCoverImage()" title="Xóa ảnh">✕</button>
                            <div class="preview-label">\${file.name}</div>
                        `;

                        preview.appendChild(imageItem);
                        preview.classList.remove('empty');
                    };
                    reader.readAsDataURL(file);
                } else {
                    preview.classList.add('empty');
                }
            }

            // Xóa ảnh đại diện
            function removeCoverImage() {
                const input = document.getElementById('imgCover');
                const preview = document.getElementById('coverImagePreview');

                input.value = '';
                preview.innerHTML = '';
                preview.classList.add('empty');
            }

            // Preview ảnh gallery (nhiều ảnh)
            function previewGalleryImages(input) {
                const preview = document.getElementById('galleryImagePreview');

                if (input.files && input.files.length > 0) {
                    // Thêm files mới vào danh sách đã có
                    const newFiles = Array.from(input.files);

                    // Kiểm tra tổng số ảnh (tối đa 10 ảnh)
                    if (selectedGalleryFiles.length + newFiles.length > 10) {
                        alert('Chỉ được chọn tối đa 10 ảnh cho gallery!');
                        input.value = '';
                        return;
                    }

                    // Kiểm tra từng file
                    for (let file of newFiles) {
                        // Kiểm tra kích thước
                        if (file.size > 5 * 1024 * 1024) {
                            alert(`Ảnh "\${file.name}" có kích thước quá lớn (tối đa 5MB)!`);
                            input.value = '';
                            return;
                        }

                        // Kiểm tra định dạng
                        if (!file.type.startsWith('image/')) {
                            alert(`File "\${file.name}" không phải là ảnh hợp lệ!`);
                            input.value = '';
                            return;
                        }

                        // Kiểm tra trùng lặp
                        const isDuplicate = selectedGalleryFiles.some(existingFile =>
                            existingFile.name === file.name && existingFile.size === file.size
                        );

                        if (!isDuplicate) {
                            selectedGalleryFiles.push(file);
                        }
                    }

                    // Reset input và cập nhật preview
                    input.value = '';
                    updateGalleryPreview();
                }
            }

            // Cập nhật hiển thị gallery preview
            function updateGalleryPreview() {
                const preview = document.getElementById('galleryImagePreview');
                preview.innerHTML = '';

                if (selectedGalleryFiles.length === 0) {
                    preview.classList.add('empty');
                    return;
                }

                preview.classList.remove('empty');

                selectedGalleryFiles.forEach((file, index) => {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        const imageItem = document.createElement('div');
                        imageItem.className = 'image-item';

                        imageItem.innerHTML = `
                            <img src="\${e.target.result}" alt="Gallery Preview \${index + 1}"/>
                            <button type="button" class="image-remove-btn" onclick="removeGalleryImage(\${index})" title="Xóa ảnh">✕</button>
                            <div class="preview-label">\${file.name}</div>
                        `;

                        preview.appendChild(imageItem);
                    };
                    reader.readAsDataURL(file);
                });

                // Cập nhật input file với files đã chọn
                updateGalleryInput();
            }

            // Xóa ảnh khỏi gallery
            function removeGalleryImage(index) {
                selectedGalleryFiles.splice(index, 1);
                updateGalleryPreview();
            }

            // Cập nhật input file với danh sách files hiện tại
            function updateGalleryInput() {
                const input = document.getElementById('imgGallery');

                if (selectedGalleryFiles.length > 0) {
                    // Tạo DataTransfer object để set files cho input
                    const dataTransfer = new DataTransfer();
                    selectedGalleryFiles.forEach(file => {
                        dataTransfer.items.add(file);
                    });
                    input.files = dataTransfer.files;
                } else {
                    input.value = '';
                }
            }




        </script>
    </body>
</html>