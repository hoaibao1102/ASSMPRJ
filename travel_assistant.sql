Create database travel_assistant
use  travel_assistant

-- Bảng người dùng
CREATE TABLE Users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    full_name NVARCHAR(255),
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255),
    phone VARCHAR(20),
    role VARCHAR(50) DEFAULT 'user'
);


CREATE TABLE Places (
    idplace INT PRIMARY KEY IDENTITY(1,1),
    placename NVARCHAR(100) NOT NULL,
    description nvarchar(500)
);
--update thêm ảnh trong bảng này nhé
ALTER TABLE Places
ADD img_places varchar(50) ;
-- sau đó thêm ảnh nè
UPDATE Places SET img_places = 'nhatrangimg.jpg' WHERE idplace = 1;
UPDATE Places SET img_places = 'vungtauimg.jpg' WHERE idplace = 2;
UPDATE Places SET img_places = 'hueimg.jpg' WHERE idplace = 3;
UPDATE Places SET img_places = 'hanoiimg.jpg' WHERE idplace = 4;
UPDATE Places SET img_places = 'dalatimg.webp' WHERE idplace = 5;
UPDATE Places SET img_places = 'danang2img.jpg' WHERE idplace = 6;


CREATE TABLE Transport (
    transport_id INT PRIMARY KEY,
    transport_name NVARCHAR(50),
    description nvarchar(500)
);

CREATE TABLE TourList (
    idTour varchar(5) PRIMARY KEY ,
    idplace INT NOT NULL,
    destination NVARCHAR(100),
    placestart NVARCHAR(100),
    duration NVARCHAR(50),         -- ví dụ: N'2 ngày 1 đêm'
    startdate varchar(50),
    price DECIMAL(10,2),
    transport_id INT,
    nametour NVARCHAR(150),
    img nvarchar(255),
    FOREIGN KEY (idplace) REFERENCES Places(idplace),
	FOREIGN KEY (transport_id) REFERENCES Transport(transport_id)
);

CREATE TABLE TourDetail (
    idTour varchar(5) PRIMARY KEY,
    day1descrip nvarchar(4000),
    day2descrip nvarchar(4000),
    day3descrip nvarchar(4000),
    imgDetail varchar(500),
    FOREIGN KEY (idTour) REFERENCES tourList(idTour)
);
-- Insert admin
INSERT INTO Users (full_name, email, password, phone, role)
VALUES 
(N'Nguyễn Văn A', 'admin@example.com', 'adminpassword', '1234567890', 'admin');

-- Insert user 1
INSERT INTO Users (full_name, email, password, phone, role)
VALUES 
(N'Nguyễn Đình Huy', 'user1@example.com', 'userpassword1', '0987654321', 'user');

-- Insert user 2
INSERT INTO Users (full_name, email, password, phone, role)
VALUES 
(N'Phạm Thị Ánh', 'user2@example.com', 'userpassword2', '0123456789', 'user');


--Transport
INSERT INTO Transport (transport_id, transport_name, description) VALUES
(1, N'Xe khách', N'Di chuyển bằng xe giường nằm chất lượng cao, tiện nghi, có điều hòa và dừng nghỉ giữa đường.'),
(2, N'Máy bay', N'Bay thẳng đến sân bay Cam Ranh với các hãng hàng không nội địa uy tín như Vietjet, Vietnam Airlines.'),
(3, N'Tàu hỏa', N'Hành trình bằng tàu hỏa giúp du khách ngắm cảnh và trải nghiệm chuyến đi an toàn, tiết kiệm chi phí.');


-- Insert địa điểm Nha Trang
INSERT INTO Places (placename, description) VALUES
( N'Nha Trang', N'Nha Trang là thành phố biển xinh đẹp với những bãi cát trắng mịn, làn nước trong xanh và nhiều địa danh nổi tiếng như VinWonders, Tháp Bà Ponagar, chùa Long Sơn, và Hòn Mun. Đây là điểm đến lý tưởng cho cả du lịch nghỉ dưỡng và khám phá.');

-- Lấy ID Nha Trang vừa tạo
DECLARE @idNhaTrang INT = SCOPE_IDENTITY();
-- Insert danh sách tour Nha Trang
INSERT INTO TourList (idTour, idplace, destination, placestart, duration, startdate, price, transport_id, nametour, img) VALUES
('NT001', @idNhaTrang, N'Nha Trang', N'TP. Hồ Chí Minh', N'2 ngày 1 đêm', '2025-07-10', 2300000, 2, N'Khám phá Nha Trang - VinWonders & biển đảo', 'nhatrang1.jpg'),
('NT002', @idNhaTrang, N'Nha Trang', N'TP. Hồ Chí Minh', N'3 ngày 2 đêm', '2025-07-20', 3500000, 3, N'Du lịch Nha Trang - Tháp Bà, Hòn Mun & nghỉ dưỡng', 'nhatrang2.jpg');


--NHA TRANG THÌ VÀO ĐÂY NHA
-- Insert chi tiết tour Nha Trang
INSERT INTO TourDetail (idTour, day1descrip, day2descrip, day3descrip, imgDetail) VALUES
('NT001',
  N'Ngày 1 TP.HCM – NHA TRANG – VINWONDERS#Buổi sáng#
  Khởi hành từ TP.HCM đến Nha Trang bằng xe giường nằm hoặc máy bay./
  Đến nơi, đoàn ăn sáng đặc sản (bún cá- bánh căn Nha Trang)./
  Nhận phòng khách sạn, nghỉ ngơi./
  #Buổi chiều:#
  Di chuyển đến cảng, đi cáp treo vượt biển sang VinWonders Nha Trang./
  Tham quan công viên nước, thủy cung lớn nhất Đông Nam Á, tàu lượn siêu tốc, khu chơi cảm giác mạnh./
  Thưởng thức biểu diễn nhạc nước hoặc vũ điệu Hawaii bên biển./
  #Buổi tối:#
  Về lại trung tâm thành phố, ăn tối với set hải sản tại nhà hàng địa phương./
  Tự do khám phá Nha Trang về đêm: đi dạo phố biển Trần Phú, cà phê view biển hoặc chợ đêm Nha Trang./',
  N'Ngày 2: BIỂN TRẦN PHÚ – CHỢ ĐẦM – TP.HCM
  #Buổi sáng:#
  Dậy sớm tắm biển Trần Phú hoặc tham gia tour cano lặn ngắm san hô (tùy chọn)./
  Ăn sáng buffet tại khách sạn./
  #Buổi chiều:#
  Tham quan Chợ Đầm – trung tâm mua sắm đặc sản, quà lưu niệm nổi tiếng nhất Nha Trang./
  Thưởng thức món bánh canh chả cá, nem nướng Ninh Hòa./
  #Buổi tối:#
  Trả phòng khách sạn. Di chuyển ra sân bay/xe giường nằm, khởi hành về TP.HCM./
  Kết thúc tour, hẹn gặp lại./',
  NULL,
  'NT2img1.jpg#NT2img2.jpg#NT2img3.jpg#NT2img4.jpg#NT2img5.jpg#NT2img6.jpg#NT2img7.jpg#NT2img8.jpg');

INSERT INTO TourDetail (idTour, day1descrip, day2descrip, day3descrip, imgDetail) VALUES
('NT002',
  N'Ngày 1: TP.HCM – NHA TRANG – THÁP BÀ#Buổi sáng:# 
  Khởi hành sớm từ TP.HCM đến Nha Trang bằng xe hoặc máy bay./ 
  Nghỉ ngơi tại khách sạn 3 sao gần biển./ 
  Ăn trưa đặc sản bánh canh chả cá, nem nướng Ninh Hòa./
  #Buổi chiều:# 
  Tham quan Tháp Bà Ponagar – công trình kiến trúc Chăm Pa nổi tiếng./ 
  Trải nghiệm tắm bùn khoáng nóng Tháp Bà – giúp thư giãn, tái tạo năng lượng./
  #Buổi tối:# 
  Ăn tối tại nhà hàng hải sản view biển./ 
  Tự do dạo biển Trần Phú, uống nước dừa ven đường hoặc đi chợ đêm./',

  N'Ngày 2: HÒN MUN – LẶN BIỂN – LÀNG CHÀI#Buổi sáng:# 
  Lên cano tham gia tour đảo Hòn Mun – khu bảo tồn biển nổi tiếng./ 
  Trải nghiệm lặn ngắm san hô, bơi lội, chơi mô tô nước hoặc chèo thuyền kayak./
  #Buổi chiều:# 
  Thưởng thức hải sản tươi sống tại Làng Chài nổi trên vịnh./ 
  Về lại đất liền, nghỉ ngơi tại khách sạn, tắm biển Trần Phú./
  #Buổi tối:# 
  Khám phá ẩm thực đường phố: bánh xèo mực, bún sứa, bánh căn./ 
  Có thể đặt vé xem múa rối nước hoặc hát bài chòi ven biển (tùy ngày)./',

  N'Ngày 3: CHỢ ĐẦM – MUA SẮM – TRỞ VỀ TP.HCM#Buổi sáng:# 
  Tự do tắm biển sáng sớm hoặc ăn sáng buffet khách sạn./ 
  Tham quan và mua sắm tại Chợ Đầm – trung tâm đặc sản lớn nhất Nha Trang./
  #Buổi chiều:# 
  Trả phòng khách sạn./ 
  Di chuyển ra sân bay hoặc xe giường nằm về lại TP.HCM./ 
  Kết thúc hành trình./',

  'NT3img1.jpg#NT3img2.jpg#NT3img3.jpg#NT3img4.jpg#NT3img5.jpg#NT3img6.jpg#NT3img7.jpg#NT3img8.jpg');



--VŨNG TÀU
-- Insert địa điểm Vũng Tàu
INSERT INTO Places (placename, description) VALUES
(N'Vũng Tàu', N'Vũng Tàu là thành phố biển nổi tiếng ở miền Nam Việt Nam, nổi bật với Bãi Trước, Bãi Sau, tượng Chúa Kitô Vua và ngọn Hải Đăng cổ.');

-- Lấy ID Vũng Tàu vừa tạo
DECLARE @idVungTau INT = SCOPE_IDENTITY();

-- Insert danh sách tour Vũng Tàu
INSERT INTO TourList (idTour, idplace, destination, placestart, duration, startdate, price, transport_id, nametour, img) VALUES
('VT001', @idVungTau, N'Vũng Tàu', N'TP. Hồ Chí Minh', N'2 ngày 1 đêm', '2025-08-01', 1800000, 1, N'Thư giãn cuối tuần tại Vũng Tàu - Bãi Sau & Tượng Chúa', 'vungtau1.jpg'),
('VT002', @idVungTau, N'Vũng Tàu', N'TP. Hồ Chí Minh', N'3 ngày 2 đêm', '2025-08-15', 2700000, 1, N'Trải nghiệm Vũng Tàu - Hải đăng & du lịch tâm linh', 'vungtau2.jpg');






-- Insert chi tiết tour Vũng Tàu 2 ngày
INSERT INTO TourDetail (idTour, day1descrip, day2descrip, day3descrip, imgDetail) VALUES
('VT001',
  N'Ngày 1: TP.HCM – VŨNG TÀU – BÃI SAU
  #Buổi sáng:#
  Khởi hành sớm từ TP.HCM đến Vũng Tàu./
  Check-in khách sạn và nghỉ ngơi nhẹ./
  #Buổi chiều:#
  Tham quan Bãi Sau, tắm biển và thư giãn dưới ánh nắng./
  Tham quan các quán cà phê ven biển, thưởng thức đặc sản hải sản./
  #Buổi tối:#
  Dạo chợ đêm Vũng Tàu, mua sắm đặc sản và quà lưu niệm./
  Tự do thưởng thức ẩm thực đường phố./',

  N'Ngày 2: TƯỢNG CHÚA KITÔ – ĐỒI CON HEO – MUA SẮM
  #Buổi sáng:#
  Tham quan tượng Chúa Kitô Vua – điểm du lịch tâm linh nổi tiếng./
  Tham quan đồi con Heo, ngắm cảnh thành phố từ trên cao./
  #Buổi chiều:#
  Mua sắm đặc sản tươi ngon tại chợ hải sản Vũng Tàu./
Chuẩn bị hành lý và khởi hành về lại TP.HCM./',
  NULL,

  'VT2img1.jpg#VT2img2.jpg#VT2img3.jpg#VT2img4.jpg#VT2img5.jpg#VT2img6.jpg#VT2img7.jpg#VT2img8.jpg');
-- Insert chi tiết tour Vũng Tàu 3 ngày
INSERT INTO TourDetail (idTour, day1descrip, day2descrip, day3descrip, imgDetail) VALUES
('VT002',
  N'Ngày 1: KHÁM PHÁ BÃI TRƯỚC & HẢI ĐĂNG VŨNG TÀU
  #Buổi sáng:#
  Khởi hành từ TP.HCM đến Vũng Tàu bằng xe du lịch chất lượng cao./
  Check-in Bãi Trước – một trong những điểm dạo biển đẹp nhất thành phố./
  #Buổi trưa:#
  Dùng bữa tại nhà hàng ven biển./
  Nhận phòng khách sạn, nghỉ ngơi./
  #Buổi chiều:#
  Tham quan Hải đăng Vũng Tàu – biểu tượng cổ kính của thành phố./
  Chụp ảnh toàn cảnh Vũng Tàu từ trên cao./
  #Buổi tối:#
  Tự do khám phá ẩm thực đêm hoặc đi dạo tại công viên Bãi Trước./',

  N'Ngày 2: TÂM LINH & VĂN HÓA VŨNG TÀU
  #Buổi sáng:#
  Viếng Niết Bàn Tịnh Xá – ngôi chùa cổ hướng biển linh thiêng./
  Tham quan Bạch Dinh – di tích lịch sử gắn liền với Pháp thuộc./
  #Buổi trưa:#
  Thưởng thức hải sản tươi sống tại nhà hàng địa phương./
  #Buổi chiều:#
  Tự do tắm biển, nghỉ dưỡng hoặc uống cà phê ngắm hoàng hôn./',

  N'Ngày 3: CHỢ XÓM LƯỚI – MUA ĐẶC SẢN – TRỞ VỀ TP.HCM
  #Buổi sáng:#
  Mua sắm tại chợ Xóm Lưới – nổi tiếng với hải sản tươi sống giá rẻ./
  Mua quà lưu niệm: mực khô, cá thu, bánh bông lan trứng muối…/
  #Buổi trưa:#
  Dùng bữa trưa nhẹ, trả phòng khách sạn./
  #Buổi chiều:#
  Khởi hành về lại TP.HCM. Kết thúc chương trình./',

 'VT3img1.jpg#VT3img2.jpg#VT3img3.jpg#VT3img4.jpg#VT3img5.jpg#VT3img6.jpg#VT3img7.jpg#VT3img8.jpg');


--HUẾ
-- Insert địa điểm Huế
INSERT INTO Places (placename, description) VALUES
(N'Huế', N'Huế là kinh đô cổ của Việt Nam với nhiều di tích lịch sử, đền đài, lăng tẩm triều Nguyễn và sông Hương thơ mộng.');

-- Lấy ID Huế vừa tạo
DECLARE @idHue INT = SCOPE_IDENTITY();

-- Insert danh sách tour Huế
INSERT INTO TourList (idTour, idplace, destination, placestart, duration, startdate, price, transport_id, nametour, img) VALUES
('HU001', @idHue, N'Huế', N'TP. Hồ Chí Minh', N'3 ngày 2 đêm', '2025-09-05', 2900000, 2, N'Du lịch Huế - Đại Nội, chùa Thiên Mụ & sông Hương', 'hue1.jpg'),
('HU002', @idHue, N'Huế', N'TP. Hồ Chí Minh', N'4 ngày 3 đêm', '2025-09-20', 3600000, 3, N'Hành trình khám phá cố đô Huế & ẩm thực miền Trung', 'hue2.jpg');

-- Insert chi tiết tour Huế
-- Insert chi tiết tour 2 ngày Huế (có 8 ảnh)
INSERT INTO TourDetail (idTour, day1descrip, day2descrip, day3descrip, imgDetail) VALUES
('HU001',
  N'Ngày 1: ĐẠI NỘI – LĂNG TỰ ĐỨC – CHÙA THIÊN MỤ
  #Buổi sáng:#
  Bay từ TP.HCM đến Huế./
  Nhận phòng khách sạn, nghỉ ngơi nhẹ./
  #Buổi chiều:#
  Tham quan Đại Nội Kinh Thành Huế – hoàng cung triều Nguyễn./
  Ghé thăm lăng Tự Đức, một trong những lăng tẩm đẹp nhất xứ Huế./
  #Buổi tối:#
  Đi thuyền sông Hương, thả đèn hoa đăng và nghe ca Huế truyền thống./',

  N'Ngày 2: CHÙA THIÊN MỤ – CHỢ ĐÔNG BA – TP.HCM
  #Buổi sáng:#
  Viếng chùa Thiên Mụ – biểu tượng văn hóa tâm linh lâu đời./
  Tự do dạo chơi và mua sắm tại chợ Đông Ba, trung tâm ẩm thực – đặc sản Huế./
  #Buổi chiều:#
  Trả phòng, ra sân bay Phú Bài để bay về TP.HCM./',

  null,

  'HUE2img1.jpg#HUE2img2.jpg#HUE2img3.jpg#HUE2img4.jpg#HUE2img5.jpg#HUE2img6.jpg#HUE2img7.jpg#HUE2img8.jpg');

-- Insert chi tiết tour 3 ngày Huế (8 ảnh minh họa)
INSERT INTO TourDetail (idTour, day1descrip, day2descrip, day3descrip, imgDetail) VALUES
('HU002',
  N'Ngày 1: ĐẠI NỘI – LĂNG KHẢI ĐỊNH – SÔNG HƯƠNG
  #Buổi sáng:#
  Đón khách tại sân bay hoặc điểm hẹn tại Huế./
  Nhận phòng khách sạn, nghỉ ngơi./
  #Buổi chiều:#
  Tham quan Đại Nội Kinh Thành Huế, tìm hiểu lịch sử triều Nguyễn./
  Khám phá lăng Khải Định – kiệt tác kiến trúc giao thoa Đông – Tây./
  #Buổi tối:#
  Thưởng thức ca Huế trên sông Hương, trải nghiệm thả đèn hoa đăng./',

  N'Ngày 2: ĐỒI VỌNG CẢNH – CHÙA THIÊN MỤ – LÀNG HƯƠNG
  #Buổi sáng:#
  Di chuyển lên Đồi Vọng Cảnh ngắm toàn cảnh sông Hương uốn lượn./
  Viếng chùa Thiên Mụ – biểu tượng tâm linh xứ Huế./
  #Buổi chiều:#
  Tham quan làng hương Thủy Xuân, trải nghiệm làm hương truyền thống./
  Mua sắm các sản phẩm đặc trưng thủ công mỹ nghệ Huế./',

  N'Ngày 3: ẨM THỰC HUẾ – PHỐ CỔ – TRỞ VỀ
  #Buổi sáng:#
  Thưởng thức đặc sản nổi tiếng: bánh bèo, bánh khoái, bún bò Huế./
  Dạo quanh khu phố cổ Huế, check-in, mua sắm đặc sản./
  #Buổi chiều:#
  Trả phòng, di chuyển ra sân bay/tuyến xe trở về điểm hẹn ban đầu./',

  'HUE3img1.jpg#HUE3img2.jpg#HUE3img3.jpg#HUE3img4.jpg#HUE3img5.jpg#HUE3img6.jpg#HUE3img7.jpg#HUE3img8.jpg');


--HÀ NỘI
INSERT INTO Places (placename, description) VALUES
(N'Hà Nội', N'Hà Nội là thủ đô ngàn năm văn hiến với Hồ Gươm, Văn Miếu, Lăng Bác và ẩm thực đường phố phong phú.');

-- Lấy ID Hà Nội vừa tạo
DECLARE @idHanoi INT = SCOPE_IDENTITY();

-- Insert danh sách tour Hà Nội
INSERT INTO TourList (idTour, idplace, destination, placestart, duration, startdate, price, transport_id, nametour, img) VALUES
('HN001', @idHanoi, N'Hà Nội', N'TP. Hồ Chí Minh', N'3 ngày 2 đêm', '2025-10-05', 3100000, 2, N'Khám phá Hà Nội - Hồ Gươm, Lăng Bác & phố cổ', 'hanoi1.jpg'),
('HN002', @idHanoi, N'Hà Nội', N'TP. Hồ Chí Minh', N'4 ngày 3 đêm', '2025-10-18', 3900000, 3, N'Tour Hà Nội - Văn Miếu, chùa Trấn Quốc & ẩm thực phố cổ', 'hanoi2.jpg');

-- Insert chi tiết tour Hà Nội
-- Insert chi tiết tour Hà Nội 2 ngày
INSERT INTO TourDetail (idTour, day1descrip, day2descrip, day3descrip, imgDetail) VALUES
('HN001',
  N'Ngày 1: VĂN MIẾU – HỒ TÂY – CHÙA TRẤN QUỐC – ẨM THỰC HÀ NỘI
  #Buổi sáng:#
  Bay từ TP.HCM ra Hà Nội./
  Nhận phòng khách sạn, nghỉ ngơi nhẹ./
  Tham quan Văn Miếu – Quốc Tử Giám, công trình mang đậm nét văn hóa – giáo dục./
  #Buổi chiều:#
  Dạo quanh Hồ Tây, ghé thăm chùa Trấn Quốc – ngôi chùa cổ nhất Thăng Long./
  Check-in tại các quán cafe ven hồ, không gian thơ mộng./
  #Buổi tối:#
  Trải nghiệm ẩm thực phố cổ Hà Nội: bún chả, phở bò, cafe trứng…/
  Dạo phố đi bộ Hồ Gươm, ngắm đền Ngọc Sơn về đêm./',

  N'Ngày 2: PHỐ CỔ – CẦU LONG BIÊN – CHỢ HÔM – NHÀ HÁT LỚN
  #Buổi sáng:#
  Tham quan cầu Long Biên – biểu tượng lịch sử Hà Nội, chụp ảnh kỷ niệm./
  Mua sắm đặc sản tại chợ Hôm./
  #Buổi chiều:#
  Tham quan Nhà hát Lớn Hà Nội – công trình kiến trúc Pháp cổ./
  Trả phòng, di chuyển ra sân bay Nội Bài, bay về TP.HCM./',

  NULL,

  'HN2img1.jpg#HN2img2.jpg#HN2img3.jpg#HN2img4.jpg#HN2img5.jpg#HN2img6.jpg#HN2img7.jpg#HN2img8.jpg');
-- Insert chi tiết tour Hà Nội 3 ngày
INSERT INTO TourDetail (idTour, day1descrip, day2descrip, day3descrip, imgDetail) VALUES
('HN002',
  N'Ngày 1: BAY ĐẾN HÀ NỘI – HỒ GƯƠM & PHỐ ĐI BỘ
  #Buổi sáng:#
  Bay từ TP.HCM ra Hà Nội./
  Di chuyển về khách sạn, nhận phòng nghỉ ngơi./
  #Buổi chiều:#
  Tham quan Hồ Gươm – biểu tượng văn hóa – lịch sử của thủ đô./
  Ghé đền Ngọc Sơn, cầu Thê Húc, tìm hiểu kiến trúc cổ kính đặc trưng./
  #Buổi tối:#
  Dạo phố đi bộ quanh Hồ Gươm, xem trình diễn nghệ thuật đường phố./
  Thưởng thức đặc sản Hà Nội như phở, bún chả, kem Tràng Tiền./',

  N'Ngày 2: LĂNG BÁC – CHÙA MỘT CỘT – BẢO TÀNG
  #Buổi sáng:#
  Tham quan Lăng Chủ tịch Hồ Chí Minh, quảng trường Ba Đình./
  Ghé chùa Một Cột – ngôi chùa độc đáo có kiến trúc “hoa sen”./
  #Buổi trưa:#
  Dùng bữa với các món ăn truyền thống như bún thang, bún mọc./
  #Buổi chiều:#
  Tham quan Bảo tàng Hồ Chí Minh./
  Tự do dạo phố cổ, tham quan 36 phố phường với các nghề truyền thống./',

  N'Ngày 3: MUA SẮM & VỀ LẠI TP.HCM
  #Buổi sáng:#
  Mua sắm tại chợ Đồng Xuân – khu chợ lâu đời, sầm uất nhất Hà Nội./
  Tự do mua quà lưu niệm, đặc sản như ô mai, trà sen, bánh cốm./
  #Buổi trưa:#
  Trả phòng khách sạn, dùng bữa nhẹ./
  #Buổi chiều:#
  Di chuyển ra sân bay Nội Bài, bay về TP.HCM. Kết thúc hành trình./',

  'HN3img1.jpg#HN3img2.jpg#HN3img3.jpg#HN3img4.jpg#HN3img5.jpg#HN3img6.jpg#HN3img7.jpg#HN3img8.jpg');


--ĐÀ LẠT
-- Insert địa điểm Đà Lạt
INSERT INTO Places (placename, description) VALUES
(N'Đà Lạt', N'Đà Lạt là thành phố cao nguyên thơ mộng với khí hậu mát mẻ quanh năm, nổi tiếng với hồ Xuân Hương, Thung lũng Tình yêu và đồi chè Cầu Đất.');

-- Lấy ID Đà Lạt
DECLARE @idDalat INT = SCOPE_IDENTITY();

-- Tour Đà Lạt
INSERT INTO TourList (idTour, idplace, destination, placestart, duration, startdate, price, transport_id, nametour, img) VALUES
('DL001', @idDalat, N'Đà Lạt', N'TP. Hồ Chí Minh', N'2 ngày 1 đêm', '2025-11-01', 1900000, 1, N'Du lịch Đà Lạt - Thung lũng Tình yêu & chợ đêm', 'dalat1.jpg'),
('DL002', @idDalat, N'Đà Lạt', N'TP. Hồ Chí Minh', N'3 ngày 2 đêm', '2025-11-10', 2800000, 1, N'Thành phố sương mù - đồi chè & Langbiang', 'dalat2.jpg');

-- Chi tiết tour Đà Lạt

INSERT INTO TourDetail (idTour, day1descrip, day2descrip, day3descrip, imgDetail) VALUES
('DL001',
  N'Ngày 1: ĐÀ LẠT – THUNG LŨNG TÌNH YÊU – HỒ XUÂN HƯƠNG#Buổi sáng:# 
  Khởi hành từ TP.HCM đến Đà Lạt, tham quan Thung lũng Tình Yêu, Hồ Xuân Hương, vườn hoa thành phố./ 
  #Buổi trưa:# 
  Ăn đặc sản Đà Lạt (lẩu gà lá é, bánh tráng nướng...)./ 
  #Buổi chiều:# 
  Tham quan Thiền viện Trúc Lâm, Hồ Tuyền Lâm, đồi Robin (cầu kính)./ 
  #Buổi tối:# 
  Tham quan chợ đêm Đà Lạt, thưởng thức đặc sản đường phố./',

  N'Ngày 2: VƯỜN DÂU TÂY – NHÀ THỜ DOMAIN DE MARIE – DINH BẢO ĐẠI#Buổi sáng:# 
  Tham quan vườn dâu tây hoặc nhà thờ Domain De Marie, đồi chè Cầu Đất./ 
  #Buổi trưa:# 
  Ăn trưa tại quán nổi tiếng./ 
  #Buổi chiều:# 
  Tham quan Dinh Bảo Đại hoặc Crazy House, mua quà lưu niệm./ 
  #Buổi tối:# 
  Quay về TP.HCM hoặc nghỉ thêm đêm./',
  NULL,
  'DL2img1.jpg#DL2img2.jpg#DL2img3.jpg#DL2img4.jpg#DL2img5.jpg#DL2img6.jpg#DL2img7.jpg#DL2img8.jpg'
);

INSERT INTO TourDetail (idTour, day1descrip, day2descrip, day3descrip, imgDetail) VALUES
('DL002',
N'Ngày 1: Khám phá Đà Lạt
#Buổi sáng:#Tham quan đồi chè Cầu Đất xanh mướt, tận hưởng không khí trong lành./
Tham quan vườn dâu tây Đà Lạt, hái dâu và chụp ảnh sống ảo tại quảng trường Lâm Viên./
#Buổi chiều:#Thưởng thức đặc sản bánh căn, nem nướng ngay tại trung tâm thành phố./
Tham quan chợ Đà Lạt./
#Buổi tối:#Tự do dạo phố và thưởng thức đặc sản địa phương./',
N'Ngày 2: Thiên nhiên và trải nghiệm
#Buổi sáng:#Trekking đỉnh Langbiang, chiêm ngưỡng toàn cảnh Đà Lạt mờ sương./
Tham gia trải nghiệm cưỡi xe jeep khám phá núi rừng Langbiang./
#Buổi chiều:#Thưởng thức buffet rau tươi đặc sản Đà Lạt tại nhà hàng địa phương./
Dạo chợ đêm Đà Lạt, mua sắm quà lưu niệm và thưởng thức các món ăn đường phố./
#Buổi tối:
#Tự do nghỉ ngơi.',
N'Ngày 3: Văn hóa và mua sắm
#Buổi sáng:#Tham quan hồ Xuân Hương, đi dạo quanh bờ hồ thơ mộng./
Tham quan Thiền viện Trúc Lâm và cáp treo Đà Lạt./
#Buổi chiều:#Mua sắm đặc sản tại chợ Đà Lạt trước khi trở về./
#Buổi tối:#Kết thúc chuyến đi./',
N'DL3img1.jpg#DL3img2.jpg#DL3img3.jpg#DL3img4.jpg#DL3img5.jpg#DL3img6.jpg#DL3img7.jpg#DL3img8.jpg'
);

--ĐÀ NẴNG
-- Insert địa điểm Đà Nẵng
INSERT INTO Places (placename, description) VALUES
(N'Đà Nẵng', N'Đà Nẵng là thành phố biển năng động với bãi biển Mỹ Khê, Cầu Rồng, bán đảo Sơn Trà và Bà Nà Hills nổi tiếng.');

-- Lấy ID Đà Nẵng
DECLARE @idDanang INT = SCOPE_IDENTITY();

-- Tour Đà Nẵng
INSERT INTO TourList (idTour, idplace, destination, placestart, duration, startdate, price, transport_id, nametour, img) VALUES
('DN001', @idDanang, N'Đà Nẵng', N'TP. Hồ Chí Minh', N'2 ngày 1 đêm', '2025-12-01', 2200000, 2, N'Tour Đà Nẵng - Bà Nà Hills & cầu Vàng', 'danang1.jpg'),
('DN002', @idDanang, N'Đà Nẵng', N'TP. Hồ Chí Minh', N'3 ngày 2 đêm', '2025-12-15', 3200000, 2, N'Khám phá Đà Nẵng - Sơn Trà, Ngũ Hành Sơn & biển Mỹ Khê', 'danang2.jpg');

INSERT INTO TourDetail (idTour, day1descrip, day2descrip, day3descrip, imgDetail) VALUES
('DN001',
  N'Ngày 1: KHÁM PHÁ BÀ NÀ HILLS & CẦU VÀNG#Buổi sáng:#Khởi hành từ TP.HCM đến Đà Nẵng bằng máy bay./
  #Buổi trưa:#Ăn trưa buffet tại nhà hàng trên Bà Nà./
  Nghỉ ngơi và ngắm cảnh núi non tuyệt đẹp./
  #Buổi chiều:#Tham quan Cầu Vàng – điểm check-in nổi tiếng với thiết kế độc đáo “bàn tay khổng lồ”./
  Vui chơi tại Fantasy Park – khu giải trí trong nhà lớn thứ 3 thế giới./
  #Buổi tối:#Về lại trung tâm Đà Nẵng, dùng bữa tối và nghỉ đêm tại khách sạn./',
  N'Ngày 2: Biển Mỹ Khê & Cầu Rồng
  #Buổi sáng:#Ăn sáng tại khách sạn./
  Tham quan và tắm biển Mỹ Khê – một trong những bãi biển quyến rũ nhất hành tinh./
  #Buổi trưa:#Thưởng thức hải sản địa phương tại nhà hàng ven biển./
  #Buổi chiều:#Tham quan Cầu Rồng, cầu quay sông Hàn, chợ Hàn./
  Mua sắm đặc sản làm quà: tré, mực rim, bánh khô mè, nước mắm Nam Ô…/
  #Buổi tối:#Di chuyển ra sân bay, kết thúc chuyến hành trình, bay về lại TP.HCM./',NULL,
  N'DN2img1.jpg#DN2img2.jpg#DN2img3.jpg#DN2img4.jpg#DN2img5.jpg#DN2img6.jpg#DN2img7.jpg#DN2img8.jpg'
);
INSERT INTO TourDetail (idTour, day1descrip, day2descrip, day3descrip, imgDetail) VALUES
('DN002',
  N'Ngày 1: BÁN ĐẢO SƠN TRÀ – NGŨ HÀNH SƠN#Buổi sáng:# 
  Khởi hành từ TP.HCM đến bán đảo Sơn Trà./ 
  Tham quan chùa Linh Ứng – ngôi chùa nổi tiếng với tượng Phật Bà Quan Âm cao lớn./ 
  Tham quan Ngũ Hành Sơn với các hang động và cảnh quan thiên nhiên tuyệt đẹp./
  #Buổi chiều:# 
  Khám phá ẩm thực địa phương tại các quán ăn nổi tiếng./ 
  Tản bộ quanh các bãi biển gần đó, tận hưởng không khí trong lành./
  #Buổi tối:# 
  Nghỉ ngơi và chuẩn bị cho ngày tiếp theo./',

  N'Ngày 2: BIỂN MỸ KHÊ – GIẢI TRÍ – MUA SẮM#Buổi sáng:# 
  Tự do tắm biển Mỹ Khê, một trong những bãi biển đẹp nhất Việt Nam./ 
  Tham gia các hoạt động thể thao biển (nếu muốn)./
  #Buổi chiều:# 
  Thưởng thức hải sản tươi ngon tại các nhà hàng ven biển./ 
  Tham quan các địa điểm giải trí hoặc mua sắm đặc sản./
  #Buổi tối:# 
  Tham quan phố đêm Đà Nẵng, thưởng thức ẩm thực đường phố./',

  N'Ngày 3: BẢO TÀNG CHĂM – TRẢ PHÒNG – TRỞ VỀ#Buổi sáng:# 
  Tham quan Bảo tàng Chăm để tìm hiểu văn hóa Champa cổ đại./ 
  Chuẩn bị hành lý và trả phòng khách sạn./
  #Buổi chiều:# 
  Di chuyển về TP.HCM, kết thúc chuyến đi./',

  'DN3img1.jpg#DN3img2.jpg#DN3img3.jpg#DN3img4.jpg#DN3img5.jpg#DN3img6.jpg#DN3img7.jpg#DN3img8.jpg'
);


-- Tạo bảng Orders :
CREATE TABLE Orders (
    idBooking VARCHAR(20) PRIMARY KEY,
    idUser int NOT NULL,
    idTour VARCHAR(5) NOT NULL,
    BookingDate DATE NOT NULL,
    NumberTicket INT NOT NULL,
    TotalPrice DECIMAL(15,2) NOT NULL,
    Status int NOT NULL,
	Note nvarchar(250),
	FOREIGN KEY (idTour) REFERENCES TourList(idTour),
	FOREIGN KEY (idUser) REFERENCES Users(id)
);