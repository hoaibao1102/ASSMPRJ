<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar, java.util.Date" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>VN Tours</title>
        <link href="assets/css/create_ticket.css" rel="stylesheet">
    </head>
    <body>
        <div class="form-container">
            <button onclick="window.history.back();" style="background: var(--gradient-secondary); color: white; border: none; padding: 8px 15px; border-radius: 5px; cursor: pointer; margin-bottom: 15px;">← Quay lại</button>
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

            <form action="MainController" method="post" onsubmit="prepareFormSubmission()">
                <!-- Xác định action dựa trên việc có tourTicket hay không -->
                <input type="hidden" name="action" value="${not empty requestScope.tourTicket ? 'submitUpdateTour' : 'submitAddTour'}"/>
                <!-- Nếu là update, cần có ID -->
                <c:if test="${not empty requestScope.tourTicket}">
                    <input type="hidden" name="tourId" value="${requestScope.tourTicket.idTourTicket}"/>
                </c:if>
                <!-- Nếu là create, cần có ID -->
                <c:if test="${not empty requestScope.idTour and not empty requestScope.idPlace}">
                    <input type="hidden" name="tourId" value="${requestScope.idTour}"/>
                    <input type="hidden" name="idPlace" value="${requestScope.idPlace}"/>
                    <input type="hidden" name="destination" value="${requestScope.destination}"/>
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
                        <div class="progress-bar-container" id="progressContainer">
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
            // Biến toàn cục
            let selectedGalleryFiles = [];
            let galleryImages = [];
            let tomorrowDate = new Date();
            tomorrowDate.setDate(tomorrowDate.getDate() + 1);
            tomorrowDate = tomorrowDate.toISOString().split('T')[0];
            
            // Cập nhật chi tiết ngày dựa trên số ngày được chọn
            function updateDayDetails(duration) {
                const dayCount = parseInt(duration);
                const dayDetailsContainer = document.getElementById('dayDetails');
                // Chỉ cập nhật khi tạo mới (không có tourTicket)
                const isUpdate = ${not empty requestScope.tourTicket ? 'true' : 'false'};
                if (isUpdate) return;
                
                dayDetailsContainer.innerHTML = '';
                if (!dayCount || dayCount < 1) return;
                
                for (let i = 1; i <= dayCount; i++) {
                    const dayDetailHTML = `
                        <div class="day-details">
                            <div><b>Ngày ${i}</b></div>
                            <label for="Description_${i}">Mô tả chung:</label>
                            <textarea name="Description_${i}" id="Description_${i}" required  placeholder="Chưa có thông tin"></textarea>
                            <label for="morningDescription_${i}">Buổi sáng:</label>
                            <textarea name="morningDescription_${i}" id="morningDescription_${i}" required placeholder="Chưa có thông tin"></textarea>
                            <label for="afternoonDescription_${i}">Buổi chiều:</label>
                            <textarea name="afternoonDescription_${i}" id="afternoonDescription_${i}" required placeholder="Chưa có thông tin"></textarea>
                            <label for="eveningDescription_${i}">Buổi tối:</label>
                            <textarea name="eveningDescription_${i}" id="eveningDescription_${i}" required placeholder="Chưa có thông tin"></textarea>
                        </div>
                    `;
                    dayDetailsContainer.insertAdjacentHTML('beforeend', dayDetailHTML);
                }
            }
            
            // Thêm ngày xuất phát
            function addDepartureDate() {
                const container = document.getElementById('departureDatesContainer');
                const dateGroups = container.querySelectorAll('.date-input-group');
                if (dateGroups.length < 3) {
                    const newDateGroup = document.createElement('div');
                    newDateGroup.className = 'date-input-group';
                    newDateGroup.id = `dateGroup${dateGroups.length + 1}`;
                    newDateGroup.innerHTML = `
                        <input type="date" name="departureDate${dateGroups.length + 1}" 
                               id="departureDate${dateGroups.length + 1}" 
                               required min="${tomorrowDate}"/>
                        <button type="button" class="remove-date-btn" 
                                onclick="removeDepartureDate(${dateGroups.length + 1})">✕</button>
                    `;
                    container.appendChild(newDateGroup);
                    updateRemoveButtons();
                }
            }
            
            // Xóa ngày xuất phát
            function removeDepartureDate(index) {
                const dateGroup = document.getElementById(`dateGroup${index}`);
                if (dateGroup) {
                    dateGroup.remove();
                    reorderDateInputs();
                    updateRemoveButtons();
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
            
            // Cập nhật hiển thị nút xóa
            function updateRemoveButtons() {
                const container = document.getElementById('departureDatesContainer');
                const dateGroups = container.querySelectorAll('.date-input-group');
                const removeButtons = container.querySelectorAll('.remove-date-btn');
                
                removeButtons.forEach(btn => {
                    btn.style.display = dateGroups.length > 1 ? 'flex' : 'none';
                });
            }
            
            // Xử lý ảnh đại diện
            $(document).ready(function() {
                $('#imageUpload').change(function() {
                    const file = this.files[0];
                    if (!file) return;
                    
                    if (!file.type.match('image.*')) {
                        alert('Chỉ chấp nhận định dạng ảnh!');
                        this.value = '';
                        return;
                    }
                    
                    const reader = new FileReader();
                    reader.onprogress = function(e) {
                        if (e.lengthComputable) {
                            const percent = Math.round((e.loaded / e.total) * 100);
                            $('#progressBar').css('width', percent + '%');
                        }
                    };
                    
                    reader.onload = function(e) {
                        $('#imgCover').val(e.target.result);
                        $('#imagePreview').html('<img src="' + e.target.result + '" alt="Preview">');
                        $('#progressContainer').fadeOut(1000);
                    };
                    
                    reader.onerror = function() {
                        alert('Lỗi khi đọc file.');
                        $('#progressContainer').hide();
                    };
                    
                    reader.readAsDataURL(file);
                    $('#progressContainer').show();
                    $('#progressBar').css('width', '0%');
                });
            });
            
            // Xử lý ảnh gallery
            $(document).ready(function() {
                // Hàm nén ảnh từ URL (ảnh cũ)
                async function resizeImageFromUrl(url, maxWidth, maxHeight) {
                    try {
                        const response = await fetch(url);
                        const blob = await response.blob();
                        return new Promise((resolve) => {
                            const img = new Image();
                            img.onload = function() {
                                const canvas = document.createElement('canvas');
                                const ctx = canvas.getContext('2d');
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
                                const resizedBase64 = canvas.toDataURL("image/jpeg", 0.7);
                                resolve(resizedBase64);
                            };
                            img.src = URL.createObjectURL(blob);
                        });
                    } catch (error) {
                        console.error('Error resizing image:', error);
                        return null;
                    }
                }
                
                // Hàm nén ảnh mới từ File
                function resizeImage(file, maxWidth, maxHeight, callback) {
                    const img = new Image();
                    const reader = new FileReader();
                    
                    reader.onload = function(e) {
                        img.src = e.target.result;
                    };
                    
                    img.onload = function() {
                        const canvas = document.createElement('canvas');
                        const ctx = canvas.getContext('2d');
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
                        const resizedBase64 = canvas.toDataURL(file.type, 0.7);
                        callback(resizedBase64);
                    };
                    
                    reader.readAsDataURL(file);
                }
                
                // Đưa ảnh cũ vào mảng
                $("input[name='oldImgUrls']").each(function() {
                    const url = this.value;
                    resizeImageFromUrl(url, 800, 600).then((resizedBase64) => {
                        if (resizedBase64) {
                            galleryImages.push({
                                name: url,
                                data: resizedBase64,
                                isNew: false
                            });
                            updateGalleryPreview();
                        }
                    });
                });
                
                // Khi người dùng chọn ảnh mới
                $('#galleryUpload').change(function() {
                    const files = this.files;
                    if (files.length > 10) {
                        alert("Bạn chỉ được chọn tối đa 10 ảnh.");
                        this.value = '';
                        return;
                    }
                    
                    Array.from(files).forEach((file) => {
                        resizeImage(file, 800, 600, function(resizedBase64) {
                            const isDuplicate = galleryImages.some(img => img.data === resizedBase64);
                            if (isDuplicate) {
                                alert("Ảnh đã được chọn rồi.");
                                return;
                            }
                            galleryImages.push({name: file.name, data: resizedBase64, isNew: true});
                            updateGalleryPreview();
                        });
                    });
                });
            });
            
            // Xóa ảnh khỏi gallery
            window.removeImage = function(index, type) {
                galleryImages.splice(index, 1);
                updateGalleryPreview();
            };
            
            // Hiển thị lại ảnh và cập nhật dữ liệu gửi đi
            function updateGalleryPreview() {
                const previewContainer = document.getElementById("galleryPreviewContainer");
                previewContainer.innerHTML = '';
                
                galleryImages.forEach((img, index) => {
                    const container = document.createElement("div");
                    container.className = "image-item";
                    container.dataset.index = index;
                    
                    const imgElement = document.createElement("img");
                    imgElement.src = img.data;
                    container.appendChild(imgElement);
                    
                    const removeBtn = document.createElement("button");
                    removeBtn.textContent = "×";
                    removeBtn.onclick = function() {
                        removeImage(index, img.isNew ? 'new' : 'old');
                    };
                    container.appendChild(removeBtn);
                    
                    previewContainer.appendChild(container);
                });
                
                document.getElementById("imgGalleryData").value = galleryImages.map(img => img.data).join("---");
            }
            
            // Gửi form
            function prepareFormSubmission() {
                if (galleryImages.length === 0) {
                    alert("Bạn phải chọn ít nhất một ảnh.");
                    return false;
                }
                updateGalleryPreview();
                return true;
            }
            
            // Tự động cập nhật chi tiết ngày khi trang được load
            window.onload = function() {
                const durationSelect = document.getElementById('duration');
                const isUpdate = ${not empty requestScope.tourTicket ? 'true' : 'false'};
                
                if (!isUpdate && durationSelect.value) {
                    updateDayDetails(durationSelect.value);
                }
                
                updateRemoveButtons();
            };
        </script>
    </body>
</html>