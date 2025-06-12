<%-- 
    Document   : TourDetailForm
    Created on : May 21, 2025, 11:14:40 PM
    Author     : MSI PC
--%>
<%@page import="java.util.List"%>
<%@page import="DTO.TourTicketDTO"%>
<%@page import="DTO.TicketDayDetailDTO"%>
<%@page import="DTO.TicketImgDTO"%>
<%@page import="DTO.StartDateDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết Tour</title>
        <link rel="stylesheet" href="assets/css/bodyCss.css"/>
        <style>


            .containerdetail {
                display: flex;
                max-width: 1200px;
                margin: 30px auto;
                gap: 30px;
            }

            .left-content {
                flex: 7;
                background-color: #f5f5f5;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
            }

            .right-content {
                flex: 3;
                background-color: #fff8f0;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
            }

            .left-content h1 {
                font-size: 2rem;
                color: #2c3e50;
                text-align: center;
                margin-bottom: 30px;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .left-content h2 {
                font-size: 1.3rem;
                color: #2980b9;
                margin-top: 25px;
                margin-bottom: 10px;
            }

            .left-content p {
                font-size: 1rem;
                color: #444;
                line-height: 1.6;
                margin-bottom: 15px;
            }

            .left-content img {
                width: 100%;
                max-width: 700px;
                height: auto;
                display: block;
                margin-top: 10px;
                margin-bottom: 25px;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            }

            /*            BÊN PHAIR */
            .right-content {
                background: #fff;
                border-radius: 12px;
                padding: 24px;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
                font-family: Arial, sans-serif;
                width: 100%;
                max-width: 360px;
                height: 40%;
            }

            .startdate-box {
                margin-top: 10px; /* giảm khoảng cách phía trên */
                margin-bottom: 15px;
                font-size: 15px;
                font-weight: 600;
                color: #444;
            }

            .startdate-box label {
                display: block;
                margin-bottom: 6px;
                font-weight: bold;
                color: #333;
            }

            .startdate-select-wrap {
                display: flex;
                gap: 10px;
                align-items: center;
            }

            .startdate-select-wrap select {
                flex: 1;
                padding: 10px 40px 10px 14px; /* thêm padding phải để tránh mũi tên đè */
                font-size: 15px;
                border-radius: 8px;
                border: 1px solid #ccc;
                background-color: #fff;
                color: #2c3e50;
                box-shadow: 0 2px 6px rgba(0,0,0,0.04);
                transition: border 0.3s ease;
                appearance: none;
                background-image: url('https://cdn-icons-png.flaticon.com/512/271/271210.png');
                background-repeat: no-repeat;
                background-position: right 14px center; /* dịch mũi tên ra xa chữ */
                background-size: 12px;
                min-width: 220px; /* tăng chiều rộng tối thiểu */
            }

            .startdate-select-wrap select:focus {
                outline: none;
                border-color: #2980b9;
                box-shadow: 0 0 0 3px rgba(41, 128, 185, 0.15);
            }


            .btn-go {
                padding: 10px 18px;
                background-color: #e74c3c;
                color: white;
                font-weight: bold;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                transition: background-color 0.25s;
            }

            .label {
                font-weight: bold;
                margin-bottom: 8px;
            }

            .price {
                font-size: 24px;
                color: red;
                margin-bottom: 16px;
            }

            .original-price {
                font-size: 18px;
                text-decoration: line-through;
                color: #999;
                margin-right: 8px;
            }

            .current-price {
                font-weight: bold;
                font-size: 28px;
                color: #e74c3c;
            }

            .discount-note {
                background-color: #ffe6e6;
                color: #d63031;
                padding: 10px;
                border-radius: 8px;
                font-size: 14px;
                margin-bottom: 20px;
            }

            .tour-details {
                list-style: none;
                padding: 0;
                margin: 0 0 20px 0;
                font-size: 14px;
            }

            .tour-details li {
                margin-bottom: 10px;
                display: flex;
                align-items: center;
            }

            .icon {
                margin-right: 6px;
                font-size: 16px;
            }

            .blue {
                color: #007bff;
                font-weight: bold;
            }

            .tour-actions {
                display: flex;
                gap: 10px;
                margin-bottom: 20px;
            }

            .btn-outline,
            .btn-primary,
            .btn-call {
                padding: 10px 14px;
                font-size: 14px;
                border-radius: 6px;
                cursor: pointer;
                border: 1px solid #e0e0e0;
                flex: 1;
            }

            .btn-outline {
                background-color: white;
                color: #d63031;
                border: 1px solid #d63031;
            }

            .btn-outline:hover {
                background-color: #fceeee;
            }

            .btn-primary {
                background-color: #e74c3c;
                color: white;
                border: none;
            }

            .btn-call {
                background-color: #0052cc;
                color: white;
                border: none;
                margin-bottom: 8px;
            }

            .tour-support {
                display: flex;
                flex-direction: column;
                gap: 8px;
            }


            <!--LÀM DETAIL O DUOI-->
            .collapsible {
                cursor: pointer;
                user-select: none;
                color: #2980b9;
                font-weight: bold;
                margin-top: 20px;
                margin-bottom: 5px;
                font-size: 1.3rem;
                border-bottom: 1px solid #2980b9;
                padding-bottom: 4px;
            }

            .sub_content {
                max-height: 0;
                overflow: hidden;
                transition: max-height 0.3s ease-out;
                font-size: 1rem;
                color: #444;
                line-height: 1.6;
                margin-bottom: 15px;
                padding-left: 8px;
                border-left: 3px solid #2980b9;
            }


            .collapsible .toggle-text {
                font-style: italic;
                font-weight: normal;
                color: #555;
                margin-left: 10px;
                cursor: pointer;
            }


            .muiten {
                width: 2% !important;
                transition: transform 0.3s ease;
                vertical-align: middle;
                cursor: pointer;
            }

            .collapsible.active .muiten {
                transform: rotate(180deg);
            }


            .gallery {
                display: flex;
                gap: 15px;
                margin-top: 20px;
            }

            .thumbnails {
                display: flex;
                flex-direction: column;
                max-height: 450px;
                overflow-y: auto;
                width: 100px;
            }

            .thumbnail-img {
                width: 100%;
                margin-bottom: 12px;
                cursor: pointer;
                border-radius: 8px;
                transition: transform 0.2s ease;
            }

            .thumbnail-img:hover {
                transform: scale(1.05);
                box-shadow: 0 0 8px rgba(0,0,0,0.3);
            }

            .main-image {
                flex-grow: 1;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .main-img {
                width: 600px;
                border-radius: 12px;
                cursor: pointer;
                box-shadow: 0 0 15px rgba(0,0,0,0.2);
            }

            /* Modal styles */
            .modal {
                display: none;
                position: fixed;
                z-index: 9999;
                padding-top: 60px;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0,0,0,0.8);
            }

            .modal-content {
                margin: auto;
                display: block;
                width: 80%;
                max-width: 900px;
                border-radius: 12px;
            }

            .close {
                position: absolute;
                top: 20px;
                right: 35px;
                color: white;
                font-size: 40px;
                font-weight: bold;
                cursor: pointer;
            }

            .prev, .next {
                cursor: pointer;
                position: fixed;
                top: 50%;
                width: auto;
                padding: 16px;
                color: white;
                font-weight: bold;
                font-size: 40px;
                user-select: none;
                -webkit-user-select: none;
                transition: 0.3s ease;
            }

            .prev:hover, .next:hover {
                color: #ddd;
            }

            .prev {
                left: 15px;
            }

            .next {
                right: 15px;
            }

            .modal-thumbnails-wrapper {
                width: 80%;
                max-width: 900px;
                margin: 15px auto 0 auto;
                overflow-x: auto;
            }

            .modal-thumbnails {
                display: flex;
                gap: 10px;
                padding-bottom: 10px;
            }

            .modal-thumbnails img {
                width: 100px;
                height: 60px;
                object-fit: cover;
                cursor: pointer;
                border: 2px solid transparent;
                border-radius: 6px;
                transition: border-color 0.3s ease;
            }

            .modal-thumbnails img.selected {
                border-color: #ff4b2b; /* viền đỏ highlight ảnh nhỏ đang chọn */
            }

            /*====================================================================  css back form*/
            .breadcrumb {
                margin: 1rem 2rem; /* cách đều trái phải giống header padding */
                font-size: 1rem;
                color: #555;
                font-family: Arial, sans-serif;
            }

            .breadcrumb a {
                color: #2980b9; /* màu xanh link */
                text-decoration: none;
                font-weight: 600;
            }

            .breadcrumb a:hover {
                text-decoration: underline;
            }

            .breadcrumb .current {
                color: #2c3e50; /* màu đậm hơn, font bold */
                font-weight: 700;
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%  
                    List<TicketImgDTO> listImg = (List<TicketImgDTO>)request.getAttribute("ticketImgDetail");
                    List<TicketDayDetailDTO> listDayDetail = (List<TicketDayDetailDTO>)request.getAttribute("ticketDayDetail");
                    TourTicketDTO tourTicket = (TourTicketDTO)request.getAttribute("tourTicket");
                    List<StartDateDTO> startDates = (List<StartDateDTO>) request.getAttribute("startDateTour");
                    DecimalFormat vnd = new DecimalFormat("#,###");
        %>

        <div class="content">
            <!<!-- dieu huong  -->
            <div class="breadcrumb">
                <div class="breadcrumb">
                    <a href="placeController?action=destination&page=indexjsp">Trang chủ</a> /
                    <a href="placeController?action=destination&page=destinationjsp">Điểm đến</a> /
                    <a href="placeController?action=takeListTicket&location=<%=tourTicket.getDestination()%>"> Du lịch <%= tourTicket.getDestination() %></a>/
                    <span class="current">chi tiết tour</span>

                    <!--                ============================================================-->
                    <div class="containerdetail">
                        <div class="left-content">
                            <%
                                List<String> img = new ArrayList<>();
                                if (listImg != null) {
                                    for (TicketImgDTO i : listImg) {
                                        img.add(i.getImgUrl());
                                    }
                                }
                            %>
                            <% if (listImg != null && listDayDetail != null && tourTicket != null) { %>
                            <h1><%= tourTicket.getDestination() %>: <%= tourTicket.getNametour() %></h1>
                            <div class="gallery">
                                <div class="thumbnails">
                                    <% for (int i = 0; i < img.size(); i++) { %>
                                    <img src="assets/images/imgticket/<%= img.get(i) %>"
                                         onclick="showMainImage('<%= img.get(i) %>')"
                                         class="thumbnail-img">
                                    <% } %>
                                </div>
                                <div class="main-image">
                                    <img id="mainImg" 
                                         src="assets/images/imgticket/<%= img.size() > 0 ? img.get(0) : "" %>"
                                         onclick="openModal()" 
                                         class="main-img">
                                </div>
                            </div>
                            <div id="modal" class="modal" onclick="closeModal(event)">
                                <span class="close" onclick="closeModal(event)">&times;</span>
                                <div class="modal-content-wrapper">
                                    <a class="prev" onclick="changeImage(-1)">&#10094;</a>
                                    <img class="modal-content" id="modalImg">
                                    <a class="next" onclick="changeImage(1)">&#10095;</a>
                                </div>
                                <div class="modal-thumbnails-wrapper">
                                    <div id="modalThumbnails" class="modal-thumbnails"></div>
                                </div>
                            </div>
                            <div>
                                <% for (TicketDayDetailDTO i : listDayDetail) {
                                       renderDescription(i.getDescription(), out);
                                   }
                                %>
                            </div>
                            <% } else { %>
                            <p>Không tìm thấy thông tin chi tiết cho tour này.</p>
                            <% } %>
                        </div>

                        <!--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////-->
                        <div class="right-content">
                            <div class="price">
                                <span class="label">Giá:</span>
                                <span class="original-price"><%= vnd.format(tourTicket.getPrice() + 1000000) %> ₫</span> 
                            </div>
                            <span class="current-price"><%= vnd.format(tourTicket.getPrice())%> <span class="currency">₫</span></span> / Khách
                            <div class="discount-note">
                                🎁 Đặt ngay để nhận được Ưu đãi online tiết kiệm thêm <strong>1,000K</strong>
                            </div>
                            <ul class="tour-details">
                                <li><span class="icon">🧾</span> Mã tour: <a href="#" class="blue"><%=tourTicket.getIdTourTicket() %></a></li>
                                <li><span class="icon">📍</span> Khởi hành: <span class="blue"><%=tourTicket.getPlacestart() %></span></li>

                                <li><span class="icon">⏳</span> Thời gian: <span class="blue"><%=tourTicket.getDuration()%></span></li>
                            </ul>
                            <form action="loginController" method="get" class="tour-actions">
                                <input type="hidden" name="idTour" value="<%=tourTicket.getIdTourTicket()%>">
                                <input type="hidden" name="action" value="order">
                                <div class="startdate-box">
                                    <label for="startNum">🗓️ Ngày khởi hành:</label>
                                    <div class="startdate-select-wrap">
                                        <select name="startNum" id="startNum">
                                            <!--/xử lí vé nếu hết thì không hiện-->
                                            <% if (startDates != null) {
                                                    for (StartDateDTO sd : startDates) { 
                                                            if(sd.getQuantity() != 0){
                                                    %>
                                                    <option value="<%= sd.getStartNum() %>">
                                                        <%= sd.getStartDate() %> (còn <%= sd.getQuantity()%> vé)
                                                    </option>
                                                    <%
                                                            }
                                                    } 
                                            } %>
                                        </select>
                                        <button type="submit" class="btn-go">Đặt ngay</button>
                                    </div>
                                </div>

                            </form>
                            <div class="tour-support">
                                <button class="btn-call">📞 Gọi miễn phí qua internet</button>
                                <button class="btn-outline">💬 Liên hệ tư vấn</button>
                            </div>
                        </div>
                    </div>

                    <%@include file="footer.jsp" %>
                    </body>


                    <script>
                        document.addEventListener("DOMContentLoaded", function () {
                            var coll = document.getElementsByClassName("collapsible");
                            for (var i = 0; i < coll.length; i++) {
                                coll[i].addEventListener("click", function () {
                                    this.classList.toggle("active");
                                    var content = this.nextElementSibling;
                                    if (content.style.maxHeight) {
                                        content.style.maxHeight = null;
                                    } else {
                                        content.style.maxHeight = content.scrollHeight + "px";
                                    }
                                });
                            }
                        });
                        //====================================================================== moi sua doan duoi
                        let currentIndex = 0;
                        const images = [];

                        // Lấy ảnh từ thumbnails ngoài gallery để tạo mảng images
                        document.querySelectorAll('.thumbnails img').forEach((img, index) => {
                            images.push(img.src);
                        });

                        // Hiển thị ảnh chính bên ngoài gallery
                        function showMainImage(url) {
                            document.getElementById('mainImg').src = "assets/images/imgticket/" + url;
                        }

                        // Mở modal và khởi tạo ảnh chính + ảnh nhỏ
                        function openModal() {
                            const modal = document.getElementById('modal');
                            modal.style.display = "block";
                            showModalImage(currentIndex);
                            initModalThumbnails();
                        }

                        // Đóng modal
                        function closeModal(event) {
                            if (event.target.id === 'modal' || event.target.className === 'close') {
                                document.getElementById('modal').style.display = "none";
                            }
                        }

                        // Chuyển ảnh trong modal (prev/next)
                        function changeImage(direction) {
                            currentIndex += direction;
                            if (currentIndex < 0)
                                currentIndex = images.length - 1;
                            if (currentIndex >= images.length)
                                currentIndex = 0;
                            showModalImage(currentIndex);
                        }

                        // Hiển thị ảnh trong modal
                        function showModalImage(index) {
                            currentIndex = index;
                            document.getElementById('modalImg').src = images[currentIndex];
                            highlightThumbnail(currentIndex);
                            // Đồng bộ main image bên ngoài gallery
                            document.getElementById('mainImg').src = images[currentIndex];
                        }

                        // Khởi tạo ảnh nhỏ trong modal
                        function initModalThumbnails() {
                            const container = document.getElementById('modalThumbnails');
                            container.innerHTML = '';
                            images.forEach((src, index) => {
                                const img = document.createElement('img');
                                img.src = src;
                                img.onclick = () => {
                                    showModalImage(index);
                                };
                                container.appendChild(img);
                            });
                            highlightThumbnail(currentIndex);
                        }

                        // Tô viền đỏ ảnh thumbnail đang chọn trong modal
                        function highlightThumbnail(index) {
                            const thumbnails = document.querySelectorAll('#modalThumbnails img');
                            thumbnails.forEach((thumb, i) => {
                                thumb.classList.toggle('selected', i === index);
                            });
                        }


                    </script>
                    </html>
                    <%! 
                        public void renderDescription(String descript, jakarta.servlet.jsp.JspWriter out) throws java.io.IOException {
                            String[] list = descript.split("#");
                            out.println("<div>");
                    //        out.println("<div class='collapsible'><h2>" + list[0] + "</h2> <span class='toggle-text'>chi tiết</span></div>");
                            out.println("<div class='collapsible'><span><h2>" + list[0] + "</h2></span> <img class=\"muiten\" src=\"https://icons.iconarchive.com/icons/fa-team/fontawesome/128/FontAwesome-Angles-Down-icon.png\" width=\"128\" height=\"128\"></div>");
                            out.println("<div class='sub_content'>"); 
                                for (int i = 1; i < list.length; i++) {
                                    if (i % 2 != 0) {
                                        out.println("<h3>" + list[i] + "</h3>");
                                    } else {
                                        out.println("<p>" + list[i].replace("/", "<br>")  + "</p>");
                                    }
                                }
                            out.println("</div>");
                            out.println("</div>");
                        }
                    %>