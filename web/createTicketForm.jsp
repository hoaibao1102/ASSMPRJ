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
                        <option value="2" ${requestScope.tourTicket != null && "2 ngày 1 đêm".equals(requestScope.tourTicket.getDuration()) ? 'selected' : ''}>2 ngày 1 đêm</option>
                        <option value="3" ${requestScope.tourTicket != null && "3 ngày 2 đêm".equals(requestScope.tourTicket.getDuration()) ? 'selected' : ''}>3 ngày 2 đêm</option>
                    </select>

                    <fieldset id="dayDetailsContainer">
                        <legend>Chi Tiết Ngày</legend>
                        <div id="dayDetails">
                            <% 
                                // Lấy tourTicket từ request và kiểm tra giá trị duration
                                TourTicketDTO tourTicket = (TourTicketDTO) request.getAttribute("tourTicket");
                                String duration = (tourTicket != null && tourTicket.getDuration() != null) ? tourTicket.getDuration() : "2 ngày 1 đêm"; 
                                
                                // Lấy danh sách chi tiết ngày tour
                                List<TicketDayDetailDTO> listDayDetail = (List<TicketDayDetailDTO>) request.getAttribute("ticketDayDetail");
                            %>

                            <% if (listDayDetail != null && !listDayDetail.isEmpty()) { %>
                            <% for (TicketDayDetailDTO i : listDayDetail) { %>
                            <div class="day-details">
                                <label for="morningDescription_<%=i.getIdTourTicket() %>">Buổi sáng:</label>
                                <textarea name="morningDescription_<%=i.getIdTourTicket() %>" id="morningDescription_<%=i.getIdTourTicket() %>">
                                    <%=i.getMorning()%>
                                </textarea>

                                <label for="afternoonDescription_<%=i.getIdTourTicket() %>">Buổi chiều:</label>
                                <textarea name="afternoonDescription_<%=i.getIdTourTicket() %>" id="afternoonDescription_<%=i.getIdTourTicket() %>">
                                    <%=i.getAfternoon()%>
                                </textarea>

                                <label for="eveningDescription_<%=i.getIdTourTicket() %>">Buổi tối:</label>
                                <textarea name="eveningDescription_<%=i.getIdTourTicket() %>" id="eveningDescription_<%=i.getIdTourTicket() %>">
                                    <%=i.getEvening()%>
                                </textarea>
                            </div>
                            <% } %>
                            <% } else { %>
                            <% for (int i = 0; i < Integer.parseInt(duration.split(" ")[0]); i++) { %> 
                            <!-- duration.split(" ")[0] sẽ lấy số ngày -->
                            <div class="day-details">
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
                        <input type="submit" value="Thêm tour">
                        <input type="reset" value="Reset">
                    </div>
                    <a href="javascript:history.back()" class="back-link">← Quay lại</a>
                </fieldset>
            </form>
        </div>

        <script>
            // JavaScript để cập nhật ngày
            function updateDayDetails(select) {
                const duration = select.value;
                const dayDetailsContainer = document.getElementById('dayDetails');

                // Reset container
                dayDetailsContainer.innerHTML = '';

                // Thêm ngày tương ứng với lựa chọn
                for (let i = 0; i < duration; i++) {
                    const dayDetailHTML = `
                        <div class="day-details">
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

            // Initial call to set the day details on page load
            window.onload = function () {
                const durationSelect = document.getElementById('duration');
                updateDayDetails(durationSelect);
            };
        </script>
    </body>
</html>
