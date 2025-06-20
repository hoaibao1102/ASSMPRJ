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
            input[type="submit"], input[type="reset"] {
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
                <input type="text" name="placestart" id="placestart" value="Hồ Chí Minh" readonly/>

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

                <label>Ngày xuất phát (tối đa 3 ngày, tương lai)</label>
                <input type="date" name="departureDate1" required min="<%= java.time.LocalDate.now() %>"/>
                <input type="date" name="departureDate2" min="<%= java.time.LocalDate.now() %>"/>
                <input type="date" name="departureDate3" min="<%= java.time.LocalDate.now() %>"/>

                <label for="imgCover">Ảnh đại diện tour</label>
                <input type="file" name="imgCover" id="imgCover" accept="image/*" required/>

                <label for="imgGallery">Ảnh liên quan đến tour (nhiều ảnh)</label>
                <input type="file" name="imgGallery" id="imgGallery" accept="image/*" multiple/>

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
                    const label = document.createElement("label");
                    label.textContent = `Mô tả ngày ${i}`;
                    label.setAttribute("for", `dayDescription${i}`);

                    const textarea = document.createElement("textarea");
                    textarea.name = `dayDescription${i}`;
                    textarea.id = `dayDescription${i}`;
                    textarea.rows = 8;
                    textarea.required = true;
                    textarea.placeholder =
                            `#Buổi sáng:#\nHoạt động sáng ngày ${i}/\n\n#Buổi chiều:#\nHoạt động chiều ngày ${i}/\n\n#Buổi tối:#\nHoạt động tối ngày ${i}/`;

                    wrapper.appendChild(label);
                    wrapper.appendChild(textarea);
                }
            }

            // Preview ảnh đại diện
            document.getElementById('imgCover').addEventListener('change', function (e) {
                const file = e.target.files[0];
                if (file && file.type.startsWith('image/')) {
                    const reader = new FileReader();
                    reader.onload = function (evt) {
                        let preview = document.querySelector('.preview-cover');
                        if (!preview) {
                            preview = document.createElement('img');
                            preview.className = 'preview-cover';
                            preview.style.maxWidth = '200px';
                            preview.style.marginTop = '10px';
                            document.getElementById('imgCover').insertAdjacentElement('afterend', preview);
                        }
                        preview.src = evt.target.result;
                    };
                    reader.readAsDataURL(file);
                }
            });
        </script>
    </body>
</html>
