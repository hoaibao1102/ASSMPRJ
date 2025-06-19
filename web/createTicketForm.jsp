<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Thêm Tour</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma;
                background-color: #f4f6f8;
                padding: 40px;
            }
            .form-container {
                background: white;
                max-width: 800px;
                margin: auto;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }
            h2 {
                text-align: center;
                color: #2c3e50;
            }
            label {
                display: block;
                margin: 15px 0 5px;
                font-weight: bold;
            }
            input[type="text"],
            input[type="number"],
            input[type="date"],
            select,
            textarea {
                width: 100%;
                padding: 10px;
                border-radius: 6px;
                border: 1px solid #ccc;
                box-sizing: border-box;
            }
            input[type="submit"], input[type="reset"], button {
                padding: 12px 24px;
                margin-top: 20px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-weight: bold;
            }
            input[type="submit"] {
                background-color: #27ae60;
                color: white;
            }
            input[type="reset"] {
                background-color: #e74c3c;
                color: white;
            }
            .toggle-title {
                cursor: pointer;
                font-weight: bold;
                margin-top: 20px;
                padding: 10px;
                background-color: #ecf0f1;
                border-radius: 5px;
            }
            .day-content {
                display: none;
                margin-top: 10px;
            }
            .image-preview img {
                margin: 10px;
                max-width: 120px;
                border-radius: 6px;
                border: 1px solid #ccc;
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <h2>Thêm Tour Mới</h2>
            <form action="placeController" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="submitAddTour"/>

                <label for="nametour">Tên Tour</label>
                <input type="text" name="nametour" id="nametour" required/>

                <label for="placestart">Điểm khởi hành</label>
                <input type="text" name="placestart" id="placestart" placeholder="Nhập điểm khởi hành" required/>

                <label for="duration">Thời gian</label>
                <select name="duration" id="duration" required onchange="generateDayDescriptions()">
                    <option value="">-- Chọn thời gian --</option>
                    <option value="2 ngày 1 đêm">2 ngày 1 đêm</option>
                    <option value="3 ngày 2 đêm">3 ngày 2 đêm</option>
                </select>

                <div id="descriptionWrapper"></div>

                <label for="transport">Phương tiện</label>
                <select name="transport_name" id="transport" required>
                    <option value="">-- Chọn phương tiện --</option>
                    <option value="Máy bay">Máy bay</option>
                    <option value="Xe lửa">Xe lửa</option>
                    <option value="Xe khách">Xe khách</option>
                </select>

                <label for="price">Giá (VND)</label>
                <input type="number" name="price" id="price" min="0" required/>

                <label for="maxTickets">Số lượng vé tối đa (tối đa 20)</label>
                <input type="number" name="maxTickets" id="maxTickets" min="1" max="20" required/>

                <label>Ngày xuất phát (tối đa 3 ngày)</label>
                <div id="departureDatesContainer">
                    <input type="date" name="departureDate1" id="departureDate1" required min="<%= java.time.LocalDate.now() %>"/>
                </div>
                <button type="button" onclick="addDepartureDate()">+ Thêm ngày</button>

                <label for="imgCover">Ảnh đại diện tour</label>
                <input type="file" name="imgCover" id="imgCover" accept="image/*" required/>

                <label for="imgGallery">Ảnh liên quan đến tour (nhiều ảnh)</label>
                <input type="file" name="imgGallery[]" id="imgGallery" accept="image/*" multiple/>

                <div class="form-buttons">
                    <input type="submit" value="Thêm tour">
                    <input type="reset" value="Reset">
                </div>
                <a href="javascript:history.back()" class="back-link">← Quay lại</a>
            </form>
        </div>

        <script>
            function generateDayDescriptions() {
                const wrapper = document.getElementById("descriptionWrapper");
                wrapper.innerHTML = "";
                const duration = document.getElementById("duration").value;
                let days = 0;

                if (duration === "2 ngày 1 đêm")
                    days = 2;
                else if (duration === "3 ngày 2 đêm")
                    days = 3;

                for (let i = 1; i <= days; i++) {
                    const section = document.createElement("div");

                    const toggle = document.createElement("div");
                    toggle.className = "toggle-title";
                    toggle.textContent = `▶ Ngày ` + i;
                    toggle.onclick = function () {
                        const content = this.nextElementSibling;
                        content.style.display = content.style.display === "none" ? "block" : "none";
                    };

                    const content = document.createElement("div");
                    content.className = "day-content";
                    content.style.display = "none";

                    const fields = [
                        {label: "Mô tả chung", name: `summary` + i},
                        {label: "Hoạt động buổi sáng", name: `morning` + i},
                        {label: "Hoạt động buổi chiều", name: `afternoon` + i},
                        {label: "Hoạt động buổi tối", name: `evening` + i}
                    ];

                    fields.forEach(field => {
                        const label = document.createElement("label");
                        label.textContent = field.label;
                        label.setAttribute("for", field.name);

                        const textarea = document.createElement("textarea");
                        textarea.name = field.name;
                        textarea.id = field.name;
                        textarea.rows = 4;
                        textarea.required = true;

                        content.appendChild(label);
                        content.appendChild(textarea);
                    });

                    section.appendChild(toggle);
                    section.appendChild(content);
                    wrapper.appendChild(section);
                }
            }

            let departureCount = 1;
            function addDepartureDate() {
                if (departureCount >= 3)
                    return;

                departureCount++;
                const container = document.getElementById("departureDatesContainer");

                const wrapper = document.createElement("div");
                wrapper.className = "departure-wrapper";
                wrapper.style.display = "flex";
                wrapper.style.alignItems = "center";
                wrapper.style.gap = "10px";
                wrapper.style.marginTop = "8px";

                const input = document.createElement("input");
                input.type = "date";
                input.name = `departureDate${departureCount}`;
                input.id = `departureDate${departureCount}`;
                input.min = "<%= java.time.LocalDate.now() %>";
                input.required = false;

                const removeBtn = document.createElement("button");
                removeBtn.type = "button";
                removeBtn.textContent = "✖";
                removeBtn.style.background = "#e74c3c";
                removeBtn.style.color = "white";
                removeBtn.style.border = "none";
                removeBtn.style.padding = "6px 12px";
                removeBtn.style.borderRadius = "4px";
                removeBtn.style.cursor = "pointer";

                removeBtn.onclick = function () {
                    container.removeChild(wrapper);
                    departureCount--;
                };

                wrapper.appendChild(input);
                wrapper.appendChild(removeBtn);
                container.appendChild(wrapper);
            }

            // ✅ Preview ảnh không trùng và hiển thị liên tục
            const selectedFileNames = new Set();
            document.getElementById('imgGallery').addEventListener('change', function (e) {
                const files = e.target.files;
                let previewContainer = document.getElementById('galleryPreview');
                if (!previewContainer) {
                    previewContainer = document.createElement('div');
                    previewContainer.id = 'galleryPreview';
                    e.target.insertAdjacentElement('afterend', previewContainer);
                }

                Array.from(files).forEach(file => {
                    if (file.type.startsWith('image/') && !selectedFileNames.has(file.name)) {
                        selectedFileNames.add(file.name);
                        const reader = new FileReader();
                        reader.onload = function (evt) {
                            const img = document.createElement('img');
                            img.src = evt.target.result;
                            img.style.maxWidth = '120px';
                            img.style.margin = '8px';
                            previewContainer.appendChild(img);
                        };
                        reader.readAsDataURL(file);
                    }
                });
            });

            // ✅ Reset toàn bộ phần tử động khi bấm nút Reset
            document.querySelector("form").addEventListener("reset", function () {
                const previewCover = document.querySelector(".preview-cover");
                if (previewCover)
                    previewCover.remove();

                const previewGallery = document.getElementById("galleryPreview");
                if (previewGallery) {
                    previewGallery.innerHTML = '';
                    selectedFileNames.clear();
                }

                const container = document.getElementById("departureDatesContainer");
                container.innerHTML = '';
                departureCount = 1;
                const firstDate = document.createElement("input");
                firstDate.type = "date";
                firstDate.name = "departureDate1";
                firstDate.id = "departureDate1";
                firstDate.min = "<%= java.time.LocalDate.now() %>";
                firstDate.required = true;
                container.appendChild(firstDate);

                const descWrapper = document.getElementById("descriptionWrapper");
                descWrapper.innerHTML = '';
            });
        </script>
    </body>
</html>