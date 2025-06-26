<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="DTO.TourTicketDTO"%>
<%@page import="DTO.TicketDayDetailDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

            .image-preview img {
                margin: 10px;
                max-width: 120px;
                border-radius: 6px;
                border: 1px solid #ccc;
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

            input[type="date"] {
                padding: 12px;
                font-size: 14px;
            }

            /* Thêm hiệu ứng hover cho các trường nhập */
            input:focus, select:focus, textarea:focus {
                outline: none;
                border-color: #3498db;
            }
        </style>

    </head>
    <body>
        <div class="form-container">
            <h2>${requestScope.tourTicket != null ? "Cập nhật Tour" : "Thêm Tour Mới"}</h2>
            <form action="placeController" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="${requestScope.tourTicket != null ? 'submitUpdateTour':'submitAddTour'}"/>

                <fieldset>
                    <legend>Thông Tin Tour</legend>
                    <label for="nametour">Tên Tour</label>
                    <input type="text" name="nametour" id="nametour" required value="${requestScope.tourTicket != null ? requestScope.tourTicket.nametour :""}"/>

                    <label for="placestart">Điểm khởi hành</label>
                    <input type="text" name="placestart" id="placestart" placeholder="Nhập điểm khởi hành" required value="${requestScope.tourTicket != null ? requestScope.tourTicket.placestart :""}"/>

                    <label for="duration">Thời gian</label>
                    <select name="duration" id="duration" onchange="updateDayDetails(this)" required>
                        <option value="">-- Chọn số ngày --</option>
                        <option value="2" ${requestScope.tourTicket != null && requestScope.tourTicket.duration != null && (requestScope.tourTicket.duration.contains("2")) ? 'selected' : ''}>2 ngày 1 đêm</option>
                        <option value="3" ${requestScope.tourTicket != null && requestScope.tourTicket.duration != null && (requestScope.tourTicket.duration.contains("3")) ? 'selected' : ''}>3 ngày 2 đêm</option>
                    </select>

                    <fieldset id="dayDetailsContainer">
                        <legend>Chi Tiết Ngày</legend>
                        <div id="dayDetails">
                            <%
                                TourTicketDTO tourTicket = (TourTicketDTO) request.getAttribute("tourTicket");
                                String duration = (tourTicket != null && tourTicket.getDuration() != null) ? tourTicket.getDuration() : "2";
                                List<TicketDayDetailDTO> listDayDetail = (List<TicketDayDetailDTO>) request.getAttribute("ticketDayDetail");
                                int dayCount = 2;
                                try {
                                    if (tourTicket != null && tourTicket.getDuration() != null) {
                                        String[] tokens = tourTicket.getDuration().split(" ");
                                        dayCount = Integer.parseInt(tokens[0]);
                                    }
                                } catch (Exception e) { dayCount = 2; }
                            %>
                            <% if (listDayDetail != null && !listDayDetail.isEmpty()) { %>
                            <% int dayNum = 1;
                                   for (TicketDayDetailDTO i : listDayDetail) { %>
                            <div class="day-details">
                                <div><b>Ngày <%= dayNum++ %></b></div>
                                <label for="morningDescription_<%=dayNum%>">Buổi sáng:</label>
                                <textarea name="morningDescription_<%=dayNum%>" id="morningDescription_<%=dayNum%>"><%=i.getMorning()%></textarea>
                                <label for="afternoonDescription_<%=dayNum%>">Buổi chiều:</label>
                                <textarea name="afternoonDescription_<%=dayNum%>" id="afternoonDescription_<%=dayNum%>"><%=i.getAfternoon()%></textarea>
                                <label for="eveningDescription_<%=dayNum%>">Buổi tối:</label>
                                <textarea name="eveningDescription_<%=dayNum%>" id="eveningDescription_<%=dayNum%>"><%=i.getEvening()%></textarea>
                            </div>
                            <% } %>
                            <% } else { %>
                            <% for (int i = 0; i < dayCount; i++) { %>
                            <div class="day-details">
                                <div><b>Ngày <%= i+1 %></b></div>
                                <label for="morningDescription_<%=i%>">Buổi sáng:</label>
                                <textarea name="morningDescription_<%=i%>" id="morningDescription_<%=i%>">Chưa có thông tin</textarea>
                                <label for="afternoonDescription_<%=i%>">Buổi chiều:</label>
                                <textarea name="afternoonDescription_<%=i%>" id="afternoonDescription_<%=i%>">Chưa có thông tin</textarea>
                                <label for="eveningDescription_<%=i%>">Buổi tối:</label>
                                <textarea name="eveningDescription_<%=i%>" id="eveningDescription_<%=i%>">Chưa có thông tin</textarea>
                            </div>
                            <% } %>
                            <% } %>
                        </div>
                    </fieldset>

                    <label for="transport">Phương tiện</label>
                    <select name="transport_name" id="transport" required>
                        <option value="">-- Chọn phương tiện --</option>
                        <option value="Máy bay" ${requestScope.tourTicket != null && requestScope.tourTicket.transport_name == 'Máy bay' ? 'selected' : ''}>Máy bay</option>
                        <option value="Xe lửa" ${requestScope.tourTicket != null && requestScope.tourTicket.transport_name == 'Xe lửa' ? 'selected' : ''}>Xe lửa</option>
                        <option value="Xe khách" ${requestScope.tourTicket != null && requestScope.tourTicket.transport_name == 'Xe khách' ? 'selected' : ''}>Xe khách</option>
                    </select>

                    <label for="price">Giá (VND)</label>
                    <input type="number" name="price" id="price" min="0" required value="${requestScope.tourTicket != null ? requestScope.tourTicket.price : ''}"/>

                    <c:if test="${requestScope.tourTicket == null || requestScope.tourTicket.price == null}">
                        <label for="maxTickets">Số lượng vé tối đa (tối đa 20)</label>
                        <input type="number" name="maxTickets" id="maxTickets" min="1" max="20" required/>
                    </c:if>

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
                        <input type="submit" value="${requestScope.tourTicket != null ? 'Cập nhật tour' : 'Thêm tour'}">
                        <input type="reset" value="Reset">
                    </div>
                    <a href="javascript:history.back()" class="back-link">← Quay lại</a>
                </fieldset>
            </form>
        </div>
        <script>
            // JavaScript cập nhật chi tiết ngày dựa trên số ngày được chọn
            function updateDayDetails(select) {
                const duration = parseInt(select.value);
                const dayDetailsContainer = document.getElementById('dayDetails');
                dayDetailsContainer.innerHTML = '';
                if (!duration || duration < 1)
                    return;
                for (let i = 0; i < duration; i++) {
                    const dayDetailHTML = `
                        <div class="day-details">
                            <div><b>Ngày ${i+1}</b></div>
                            <label for="morningDescription_${i}">Buổi sáng:</label>
                            <textarea name="morningDescription_${i}" id="morningDescription_${i}">Chưa có thông tin</textarea>
                            <label for="afternoonDescription_${i}">Buổi chiều:</label>
                            <textarea name="afternoonDescription_${i}" id="afternoonDescription_${i}">Chưa có thông tin</textarea>
                            <label for="eveningDescription_${i}">Buổi tối:</label>
                            <textarea name="eveningDescription_${i}" id="eveningDescription_${i}">Chưa có thông tin</textarea>
                        </div>
                    `;
                    dayDetailsContainer.insertAdjacentHTML('beforeend', dayDetailHTML);
                }
            }
            // Tự động cập nhật chi tiết ngày khi trang được load (chỉ khi tạo mới)
            window.onload = function () {
                const durationSelect = document.getElementById('duration');
                if (!${requestScope.tourTicket != null}) {
                    updateDayDetails(durationSelect);
                }
            };
            // Thêm ngày xuất phát
            function addDepartureDate() {
                const container = document.getElementById('departureDatesContainer');
                let inputs = container.querySelectorAll('input[type="date"]');
                if (inputs.length < 3) {
                    const newInput = document.createElement('input');
                    newInput.type = "date";
                    newInput.name = "departureDate" + (inputs.length + 1);
                    newInput.required = true;
                    newInput.min = "<%= java.time.LocalDate.now() %>";
                    container.appendChild(newInput);
                }
            }
        </script>
    </body>
</html>