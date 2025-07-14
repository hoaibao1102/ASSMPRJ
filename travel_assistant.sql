Create database Booking_Tour
use  Booking_Tour

-- Bảng người dùng
CREATE TABLE Users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    full_name NVARCHAR(255),
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255),
    phone VARCHAR(20),
    role VARCHAR(50) DEFAULT 'CS'
);

-- Bảng địa điểm
CREATE TABLE Places (
    idplace INT PRIMARY KEY IDENTITY(1,1),
    placename NVARCHAR(100) NOT NULL,
    description NVARCHAR(500),
    img_places varchar(max),
	Featured INT default 0
);

--Bảng Vé
CREATE TABLE TourTickets (
    idTourTicket varchar(5) PRIMARY KEY ,
    idplace INT NOT NULL,
    destination NVARCHAR(100),
    placestart NVARCHAR(100),
    duration NVARCHAR(50),         -- ví dụ: N'2 ngày 1 đêm'
    price DECIMAL(10,2),
    transport_name NVARCHAR(50),
    nametour NVARCHAR(150),
    img_Tour nvarchar(255),
    FOREIGN KEY (idplace) REFERENCES Places(idplace),
);

--  Tạo bảng mới chứa ngày khởi hành
CREATE TABLE TourStartDates (
    idTourTicket VARCHAR(5) NOT NULL,
    startdate DATE NOT NULL,
    startNum INT NOT NULL,
	quantity INT NOT NULL DEFAULT 20,
    PRIMARY KEY (idTourTicket, startNum),
    FOREIGN KEY (idTourTicket) REFERENCES TourTickets(idTourTicket)
);

--Bảng chứa ảnh của vé
CREATE TABLE TicketImgs(
    idTourTicket varchar(5) ,
	imgNum int not null,
    imgUrl varchar(500),
    FOREIGN KEY (idTourTicket) REFERENCES TourTickets(idTourTicket),
	PRIMARY KEY (idTourTicket, imgNum)
);
alter table [TicketImgs]
alter column [imgUrl] varchar(MAX)


--Bảng chứa thông tin chi tiết của vé

CREATE TABLE TicketDayDetails (
    idTourTicket varchar(5) not null ,
    Day int not null ,
	Description nvarchar(1000),
    FOREIGN KEY (idTourTicket) REFERENCES TourTickets(idTourTicket),
	PRIMARY KEY (idTourTicket, day)
);
Alter table TicketDayDetails add Morning nvarchar(1000);
Alter table TicketDayDetails add Afternoon nvarchar(1000);
Alter table TicketDayDetails add Evening nvarchar(1000);

-- Tạo bảng Orders :
CREATE TABLE Orders (
    idBooking VARCHAR(20) PRIMARY KEY,
    idUser INT NOT NULL,
    idTourTicket VARCHAR(5) NOT NULL,
    startNum INT NOT NULL,  -- ghi rõ ngày khởi hành (số thứ tự)
    BookingDate DATE NOT NULL,
    NumberTicket INT NOT NULL,
    TotalPrice DECIMAL(15,2) NOT NULL,
    Status INT NOT NULL,
    Note NVARCHAR(250),

	FOREIGN KEY (idTourTicket, startNum) REFERENCES TourStartDates(idTourTicket, startNum),
	FOREIGN KEY (idTourTicket) REFERENCES TourTickets(idTourTicket),
	FOREIGN KEY (idUser) REFERENCES Users(id)
);

-- Bảng yêu thích
CREATE TABLE Favorites (
    idUser INT NOT NULL,
    idTourTicket VARCHAR(5) NOT NULL,

    PRIMARY KEY (idUser, idTourTicket),
    FOREIGN KEY (idUser) REFERENCES Users(id),
    FOREIGN KEY (idTourTicket) REFERENCES TourTickets(idTourTicket)
);


-- Chúng ta sẽ lưu trữ thông tin tổng hợp để tối ưu hiển thị
ALTER TABLE TourTickets ADD 
    avgRating DECIMAL(3,2) DEFAULT 0,       -- Điểm đánh giá trung bình (ví dụ: 4.5)
    totalReviews INT DEFAULT 0,            -- Tổng số lượt đánh giá
    featuredReview NVARCHAR(1000) NULL;    -- Có thể lưu một vài bình luận nổi bật

-- Bước 1: Tạo bảng mới để lưu chi tiết từng bình luận
-- Bảng này sẽ lưu lịch sử đánh giá của người dùng
CREATE TABLE TourReviews (
    idReview INT IDENTITY(1,1) PRIMARY KEY,
    idUser INT NOT NULL,
    idTourTicket VARCHAR(5) NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5), -- Bắt buộc phải có điểm
    comment NVARCHAR(1000) NULL,                         -- Bình luận có thể để trống
    reviewDate DATETIME DEFAULT GETDATE(),
    isVerified BIT DEFAULT 0,                            -- 1 nếu người dùng đã mua tour này
	status VARCHAR(20) DEFAULT 'ACTIVE',     -- ACTIVE, HIDDEN, DELETED
    FOREIGN KEY (idUser) REFERENCES Users(id),
    FOREIGN KEY (idTourTicket) REFERENCES TourTickets(idTourTicket),
    UNIQUE (idUser, idTourTicket) -- Đảm bảo một người chỉ được đánh giá một lần cho một tour
);

DROP TRIGGER IF EXISTS trg_AfterInsertDeleteReview;

-- Bước 2: Tạo Trigger để tự động cập nhật thông tin đánh giá
-- Trigger này sẽ cập nhật avgRating, totalReviews mỗi khi có bình luận mới hoặc bị xóa
CREATE TRIGGER trg_AfterInsertDeleteReview
ON TourReviews
AFTER INSERT, DELETE, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Xác định tour bị ảnh hưởng
    WITH AffectedTours AS (
        SELECT DISTINCT idTourTicket FROM inserted
        UNION
        SELECT DISTINCT idTourTicket FROM deleted
    )
    
    -- Cập nhật avgRating và totalReviews (chỉ tính review ACTIVE)
    UPDATE TourTickets
    SET 
        avgRating = (
            SELECT AVG(CAST(rating AS DECIMAL(4,2)))
            FROM TourReviews
            WHERE idTourTicket = at.idTourTicket AND status = 'ACTIVE'
        ),
        totalReviews = (
            SELECT COUNT(*)
            FROM TourReviews
            WHERE idTourTicket = at.idTourTicket AND status = 'ACTIVE'
        )
    FROM AffectedTours at
    WHERE TourTickets.idTourTicket = at.idTourTicket;
END;
GO


--BẢNG VOUCHER
ALTER TABLE [dbo].[Orders]
ADD voucherID INT;

ALTER TABLE [dbo].[Orders]
ADD amount_off DECIMAL(10, 2);

ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT fk_voucherID
FOREIGN KEY (voucherID) REFERENCES Vouchers(voucherID);

CREATE TABLE Vouchers (
    voucherID INT IDENTITY(1,1) PRIMARY KEY,
    startDate DATE,
    discount DECIMAL(5, 2),
    numbers INT,
    duration INT,
	title NVARCHAR(100),
	status int default 1 ,
	minimumOrderValue DECIMAL(15,2) NOT NULL 
);

--==============================================================================
GO
CREATE TRIGGER update_status_after_duration
ON Vouchers
FOR UPDATE
AS
BEGIN
    -- Kiểm tra xem ngày kết thúc (startDate + duration) có quá ngày hiện tại không
    IF (DATEADD(DAY, (SELECT duration FROM INSERTED), (SELECT startDate FROM INSERTED)) < GETDATE())
    BEGIN
        -- Nếu quá hạn, set status = 0
        UPDATE Vouchers
        SET status = 0
        WHERE voucherID IN (SELECT voucherID FROM INSERTED);
    END
END;









--==========================================================================
--CHÈN DATA VÀO CÁC BẢNG


-- Insert admin & users
INSERT INTO Users (full_name, email, password, phone, role) VALUES
(N'Nguyễn Văn Dương', 'admin@gmail.com', '123123', '1234599890', 'AD'),
(N'Nguyễn Văn Bách', 'admin@example.com', 'adminpassword', '1234567890', 'AD'),
(N'Nguyễn Đình Huy', 'user1@example.com', 'userpassword1', '0987654321', 'CUS'),
(N'Phạm Thị Ánh', 'user2@example.com', 'userpassword2', '0123456789', 'CUS');

--=======================================================================================

-- Insert địa điểm Nha Trang
INSERT INTO Places (placename, description, img_places, Featured) VALUES
(N'Nha Trang', N'Nha Trang là thành phố biển xinh đẹp với những bãi cát trắng mịn, làn nước trong xanh và nhiều địa danh nổi tiếng như VinWonders, Tháp Bà Ponagar, chùa Long Sơn, và Hòn Mun.', 'nhatrangimg.jpg', 1);

-- Lấy ID Nha Trang vừa tạo
DECLARE @idNhaTrang INT = SCOPE_IDENTITY();
-- Insert danh sách tour Nha Trang

INSERT INTO TourTickets VALUES
('NT001', @idNhaTrang, N'Nha Trang', N'TP. Hồ Chí Minh', N'2 ngày 1 đêm', 2300000, N'Máy bay', N'Khám phá Nha Trang - VinWonders & biển đảo', 'nhatrang1.jpg'),
('NT002', @idNhaTrang, N'Nha Trang', N'TP. Hồ Chí Minh', N'3 ngày 2 đêm', 3500000, N'Tàu hỏa', N'Du lịch Nha Trang - Tháp Bà, Hòn Mun & nghỉ dưỡng', 'nhatrang2.jpg');

--NHA TRANG THÌ VÀO ĐÂY NHA
--TOUR NT001
INSERT INTO TicketDayDetails (idTourTicket, Day, Description) VALUES
('NT001', 1, N'Ngày 1 TP.HCM – NHA TRANG – VINWONDERS#Buổi sáng#
  Khởi hành từ TP.HCM đến Nha Trang bằng xe giường nằm hoặc máy bay./
  Đến nơi, đoàn ăn sáng đặc sản (bún cá- bánh căn Nha Trang)./
  Nhận phòng khách sạn, nghỉ ngơi./
  #Buổi chiều:#
  Di chuyển đến cảng, đi cáp treo vượt biển sang VinWonders Nha Trang./
  Tham quan công viên nước, thủy cung lớn nhất Đông Nam Á, tàu lượn siêu tốc, khu chơi cảm giác mạnh./
  Thưởng thức biểu diễn nhạc nước hoặc vũ điệu Hawaii bên biển./
  #Buổi tối:#
  Về lại trung tâm thành phố, ăn tối với set hải sản tại nhà hàng địa phương./
  Tự do khám phá Nha Trang về đêm: đi dạo phố biển Trần Phú, cà phê view biển hoặc chợ đêm Nha Trang./'),

('NT001', 2, N'Ngày 2: BIỂN TRẦN PHÚ – CHỢ ĐẦM – TP.HCM
  #Buổi sáng:#
  Dậy sớm tắm biển Trần Phú hoặc tham gia tour cano lặn ngắm san hô (tùy chọn)./
  Ăn sáng buffet tại khách sạn./
  #Buổi chiều:#
  Tham quan Chợ Đầm – trung tâm mua sắm đặc sản, quà lưu niệm nổi tiếng nhất Nha Trang./
  Thưởng thức món bánh canh chả cá, nem nướng Ninh Hòa./
  #Buổi tối:#
  Trả phòng khách sạn. Di chuyển ra sân bay/xe giường nằm, khởi hành về TP.HCM./
  Kết thúc tour, hẹn gặp lại./');

  -- Update for Day 1
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 1 TP.HCM – NHA TRANG – VINWONDERS',
    Morning = N'Khởi hành từ TP.HCM đến Nha Trang bằng xe giường nằm hoặc máy bay. Đến nơi, đoàn ăn sáng đặc sản (bún cá- bánh căn Nha Trang). Nhận phòng khách sạn, nghỉ ngơi.',
    Afternoon = N'Di chuyển đến cảng, đi cáp treo vượt biển sang VinWonders Nha Trang. Tham quan công viên nước, thủy cung lớn nhất Đông Nam Á, tàu lượn siêu tốc, khu chơi cảm giác mạnh. Thưởng thức biểu diễn nhạc nước hoặc vũ điệu Hawaii bên biển.',
    Evening = N'Về lại trung tâm thành phố, ăn tối với set hải sản tại nhà hàng địa phương. Tự do khám phá Nha Trang về đêm: đi dạo phố biển Trần Phú, cà phê view biển hoặc chợ đêm Nha Trang.'
WHERE idTourTicket = 'NT001' AND Day = 1;

-- Update for Day 2
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 2: BIỂN TRẦN PHÚ – CHỢ ĐẦM – TP.HCM',
    Morning = N'Dậy sớm tắm biển Trần Phú hoặc tham gia tour cano lặn ngắm san hô (tùy chọn). Ăn sáng buffet tại khách sạn.',
    Afternoon = N'Tham quan Chợ Đầm – trung tâm mua sắm đặc sản, quà lưu niệm nổi tiếng nhất Nha Trang. Thưởng thức món bánh canh chả cá, nem nướng Ninh Hòa.',
    Evening = N'Trả phòng khách sạn. Di chuyển ra sân bay/xe giường nằm, khởi hành về TP.HCM. Kết thúc tour, hẹn gặp lại.'
WHERE idTourTicket = 'NT001' AND Day = 2;

INSERT INTO TicketImgs (idTourTicket, imgNum, imgUrl) VALUES
('NT001', 1, 'NT2img1.jpg'),
('NT001', 2, 'NT2img2.jpg'),
('NT001', 3, 'NT2img3.jpg'),
('NT001', 4, 'NT2img4.jpg'),
('NT001', 5, 'NT2img5.jpg'),
('NT001', 6, 'NT2img6.jpg'),
('NT001', 7, 'NT2img7.jpg'),
('NT001', 8, 'NT2img8.jpg');
 
 --TOUR NT002
INSERT INTO TicketDayDetails (idTourTicket, Day, Description) VALUES
('NT002', 1, N'Ngày 1: TP.HCM – NHA TRANG – THÁP BÀ#Buổi sáng:# 
  Khởi hành sớm từ TP.HCM đến Nha Trang bằng xe hoặc máy bay./ 
  Nghỉ ngơi tại khách sạn 3 sao gần biển./ 
  Ăn trưa đặc sản bánh canh chả cá, nem nướng Ninh Hòa./
  #Buổi chiều:# 
  Tham quan Tháp Bà Ponagar – công trình kiến trúc Chăm Pa nổi tiếng./ 
  Trải nghiệm tắm bùn khoáng nóng Tháp Bà – giúp thư giãn, tái tạo năng lượng./
  #Buổi tối:# 
  Ăn tối tại nhà hàng hải sản view biển./ 
  Tự do dạo biển Trần Phú, uống nước dừa ven đường hoặc đi chợ đêm./'),

('NT002', 2, N'Ngày 2: HÒN MUN – LẶN BIỂN – LÀNG CHÀI#Buổi sáng:# 
  Lên cano tham gia tour đảo Hòn Mun – khu bảo tồn biển nổi tiếng./ 
  Trải nghiệm lặn ngắm san hô, bơi lội, chơi mô tô nước hoặc chèo thuyền kayak./
  #Buổi chiều:# 
  Thưởng thức hải sản tươi sống tại Làng Chài nổi trên vịnh./ 
  Về lại đất liền, nghỉ ngơi tại khách sạn, tắm biển Trần Phú./
  #Buổi tối:# 
  Khám phá ẩm thực đường phố: bánh xèo mực, bún sứa, bánh căn./ 
  Có thể đặt vé xem múa rối nước hoặc hát bài chòi ven biển (tùy ngày)./'),

('NT002', 3, N'Ngày 3: CHỢ ĐẦM – MUA SẮM – TRỞ VỀ TP.HCM#Buổi sáng:# 
  Tự do tắm biển sáng sớm hoặc ăn sáng buffet khách sạn./ 
  Tham quan và mua sắm tại Chợ Đầm – trung tâm đặc sản lớn nhất Nha Trang./
  #Buổi chiều:# 
  Trả phòng khách sạn./ 
  Di chuyển ra sân bay hoặc xe giường nằm về lại TP.HCM./ 
  Kết thúc hành trình./');

  -- Update for Day 1 of NT002
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 1: TP.HCM – NHA TRANG – THÁP BÀ',
    Morning = N'Khởi hành sớm từ TP.HCM đến Nha Trang bằng xe hoặc máy bay. Nghỉ ngơi tại khách sạn 3 sao gần biển. Ăn trưa đặc sản bánh canh chả cá, nem nướng Ninh Hòa.',
    Afternoon = N'Tham quan Tháp Bà Ponagar – công trình kiến trúc Chăm Pa nổi tiếng. Trải nghiệm tắm bùn khoáng nóng Tháp Bà – giúp thư giãn, tái tạo năng lượng.',
    Evening = N'Ăn tối tại nhà hàng hải sản view biển. Tự do dạo biển Trần Phú, uống nước dừa ven đường hoặc đi chợ đêm.'
WHERE idTourTicket = 'NT002' AND Day = 1;

-- Update for Day 2 of NT002
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 2: HÒN MUN – LẶN BIỂN – LÀNG CHÀI',
    Morning = N'Lên cano tham gia tour đảo Hòn Mun – khu bảo tồn biển nổi tiếng. Trải nghiệm lặn ngắm san hô, bơi lội, chơi mô tô nước hoặc chèo thuyền kayak.',
    Afternoon = N'Thưởng thức hải sản tươi sống tại Làng Chài nổi trên vịnh. Về lại đất liền, nghỉ ngơi tại khách sạn, tắm biển Trần Phú.',
    Evening = N'Khám phá ẩm thực đường phố: bánh xèo mực, bún sứa, bánh căn. Có thể đặt vé xem múa rối nước hoặc hát bài chòi ven biển (tùy ngày).'
WHERE idTourTicket = 'NT002' AND Day = 2;

-- Update for Day 3 of NT002
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 3: CHỢ ĐẦM – MUA SẮM – TRỞ VỀ TP.HCM',
    Morning = N'Tự do tắm biển sáng sớm hoặc ăn sáng buffet khách sạn. Tham quan và mua sắm tại Chợ Đầm – trung tâm đặc sản lớn nhất Nha Trang.',
    Afternoon = N'Trả phòng khách sạn. Di chuyển ra sân bay hoặc xe giường nằm về lại TP.HCM.',
    Evening = N'Kết thúc hành trình.'
WHERE idTourTicket = 'NT002' AND Day = 3;


 INSERT INTO TicketImgs (idTourTicket, imgNum, imgUrl) VALUES
('NT002', 1, 'NT3img1.jpg'),
('NT002', 2, 'NT3img2.jpg'),
('NT002', 3, 'NT3img3.jpg'),
('NT002', 4, 'NT3img4.jpg'),
('NT002', 5, 'NT3img5.jpg'),
('NT002', 6, 'NT3img6.jpg'),
('NT002', 7, 'NT3img7.jpg'),
('NT002', 8, 'NT3img8.jpg');



--VŨNG TÀU
-- Insert địa điểm Vũng Tàu
INSERT INTO Places (placename, description, img_places, Featured) VALUES
(N'Vũng Tàu', N'Vũng Tàu là thành phố biển nổi tiếng ở miền Nam Việt Nam, nổi bật với Bãi Trước, Bãi Sau, tượng Chúa Kitô Vua và ngọn Hải Đăng cổ.', 'vungtauimg.jpg', 1);

-- Lấy ID Vũng Tàu vừa tạo
DECLARE @idVungTau INT = SCOPE_IDENTITY();

-- Vung Tau Tours
INSERT INTO TourTickets VALUES
('VT001', @idVungTau, N'Vũng Tàu', N'TP. Hồ Chí Minh', N'2 ngày 1 đêm', 1800000, N'Xe khách', N'Thư giãn cuối tuần tại Vũng Tàu - Bãi Sau & Tượng Chúa', 'vungtau1.jpg'),
('VT002', @idVungTau, N'Vũng Tàu', N'TP. Hồ Chí Minh', N'3 ngày 2 đêm', 2700000, N'Xe khách', N'Trải nghiệm Vũng Tàu - Hải đăng & du lịch tâm linh', 'vungtau2.jpg');

--TOUR VT001
INSERT INTO TicketDayDetails (idTourTicket, Day, Description) VALUES
('VT001', 1, N'Ngày 1: TP.HCM – VŨNG TÀU – BÃI SAU
  #Buổi sáng:#
  Khởi hành sớm từ TP.HCM đến Vũng Tàu./
  Check-in khách sạn và nghỉ ngơi nhẹ./
  #Buổi chiều:#
  Tham quan Bãi Sau, tắm biển và thư giãn dưới ánh nắng./
  Tham quan các quán cà phê ven biển, thưởng thức đặc sản hải sản./
  #Buổi tối:#
  Dạo chợ đêm Vũng Tàu, mua sắm đặc sản và quà lưu niệm./
  Tự do thưởng thức ẩm thực đường phố./'),

('VT001', 2, N'Ngày 2: TƯỢNG CHÚA KITÔ – ĐỒI CON HEO – MUA SẮM
  #Buổi sáng:#
  Tham quan tượng Chúa Kitô Vua – điểm du lịch tâm linh nổi tiếng./
  Tham quan đồi con Heo, ngắm cảnh thành phố từ trên cao./
  #Buổi chiều:#
  Mua sắm đặc sản tươi ngon tại chợ hải sản Vũng Tàu./
Chuẩn bị hành lý và khởi hành về lại TP.HCM./');

-- Update for Day 1 of VT001
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 1: TP.HCM – VŨNG TÀU – BÃI SAU',
    Morning = N'Khởi hành sớm từ TP.HCM đến Vũng Tàu. Check-in khách sạn và nghỉ ngơi nhẹ. Tham quan Bãi Sau, tắm biển và thư giãn dưới ánh nắng. Tham quan các quán cà phê ven biển, thưởng thức đặc sản hải sản.',
    Afternoon = N'Tham quan Bãi Sau, tắm biển và thư giãn dưới ánh nắng. Tham quan các quán cà phê ven biển, thưởng thức đặc sản hải sản.',  -- Added content for the Afternoon.
    Evening = N'Dạo chợ đêm Vũng Tàu, mua sắm đặc sản và quà lưu niệm. Tự do thưởng thức ẩm thực đường phố.'
WHERE idTourTicket = 'VT001' AND Day = 1;

-- Update for Day 2 of VT001
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 2: TƯỢNG CHÚA KITÔ – ĐỒI CON HEO – MUA SẮM',
    Morning = N'Tham quan tượng Chúa Kitô Vua – điểm du lịch tâm linh nổi tiếng. Tham quan đồi con Heo, ngắm cảnh thành phố từ trên cao.',
    Afternoon = N'Mua sắm đặc sản tươi ngon tại chợ hải sản Vũng Tàu. Chuẩn bị hành lý và khởi hành về lại TP.HCM.',
    Evening = N'Kết thúc cuộc hành trình, chúc quý khách có 1 chuyến đi ý nghĩa và đáng nhớ.'
WHERE idTourTicket = 'VT001' AND Day = 2;


INSERT INTO TicketImgs (idTourTicket, imgNum, imgUrl) VALUES
('VT001', 1, 'VT2img1.jpg'),
('VT001', 2, 'VT2img2.jpg'),
('VT001', 3, 'VT2img3.jpg'),
('VT001', 4, 'VT2img4.jpg'),
('VT001', 5, 'VT2img5.jpg'),
('VT001', 6, 'VT2img6.jpg'),
('VT001', 7, 'VT2img7.jpg'),
('VT001', 8, 'VT2img8.jpg');

--TOUR VT002
INSERT INTO TicketDayDetails (idTourTicket, Day, Description) VALUES
('VT002', 1, N'Ngày 1: KHÁM PHÁ BÃI TRƯỚC & HẢI ĐĂNG VŨNG TÀU
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
  Tự do khám phá ẩm thực đêm hoặc đi dạo tại công viên Bãi Trước./'),

('VT002', 2, N'Ngày 2: TÂM LINH & VĂN HÓA VŨNG TÀU
  #Buổi sáng:#
  Viếng Niết Bàn Tịnh Xá – ngôi chùa cổ hướng biển linh thiêng./
  Tham quan Bạch Dinh – di tích lịch sử gắn liền với Pháp thuộc./
  #Buổi trưa:#
  Thưởng thức hải sản tươi sống tại nhà hàng địa phương./
  #Buổi chiều:#
  Tự do tắm biển, nghỉ dưỡng hoặc uống cà phê ngắm hoàng hôn./'),

('VT002', 3, N'Ngày 3: CHỢ XÓM LƯỚI – MUA ĐẶC SẢN – TRỞ VỀ TP.HCM
  #Buổi sáng:#
  Mua sắm tại chợ Xóm Lưới – nổi tiếng với hải sản tươi sống giá rẻ./
  Mua quà lưu niệm: mực khô, cá thu, bánh bông lan trứng muối…/
  #Buổi trưa:#
  Dùng bữa trưa nhẹ, trả phòng khách sạn./
  #Buổi chiều:#
  Khởi hành về lại TP.HCM. Kết thúc chương trình./');

  -- Update for Day 1 of VT002
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 1: KHÁM PHÁ BÃI TRƯỚC & HẢI ĐĂNG VŨNG TÀU',
    Morning = N'Khởi hành từ TP.HCM đến Vũng Tàu bằng xe du lịch chất lượng cao. Check-in Bãi Trước – một trong những điểm dạo biển đẹp nhất thành phố. Dùng bữa tại nhà hàng ven biển. Nhận phòng khách sạn, nghỉ ngơi.',
    Afternoon = N'Tham quan Hải đăng Vũng Tàu – biểu tượng cổ kính của thành phố. Chụp ảnh toàn cảnh Vũng Tàu từ trên cao.',
    Evening = N'Tự do khám phá ẩm thực đêm hoặc đi dạo tại công viên Bãi Trước.'
WHERE idTourTicket = 'VT002' AND Day = 1;

-- Update for Day 2 of VT002 (with a more appropriate Evening activity added)
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 2: TÂM LINH & VĂN HÓA VŨNG TÀU',
    Morning = N'Viếng Niết Bàn Tịnh Xá – ngôi chùa cổ hướng biển linh thiêng. Tham quan Bạch Dinh – di tích lịch sử gắn liền với Pháp thuộc.',
    Afternoon = N'Tự do tắm biển, nghỉ dưỡng hoặc uống cà phê ngắm hoàng hôn.',
    Evening = N'Khám phá chợ đêm Vũng Tàu, thưởng thức các món ăn vặt và mua sắm quà lưu niệm tại địa phương.'
WHERE idTourTicket = 'VT002' AND Day = 2;

-- Update for Day 3 of VT002
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 3: CHỢ XÓM LƯỚI – MUA ĐẶC SẢN – TRỞ VỀ TP.HCM',
    Morning = N'Mua sắm tại chợ Xóm Lưới – nổi tiếng với hải sản tươi sống giá rẻ. Mua quà lưu niệm: mực khô, cá thu, bánh bông lan trứng muối.',
    Afternoon = N'Dùng bữa trưa nhẹ, trả phòng khách sạn. Khởi hành về lại TP.HCM. Kết thúc chương trình.',
    Evening = N'Kết thúc cuộc hành trình, chúc quý khách có 1 chuyến đi ý nghĩa và đáng nhớ.'
WHERE idTourTicket = 'VT002' AND Day = 3;


  INSERT INTO TicketImgs (idTourTicket, imgNum, imgUrl) VALUES
('VT002', 1, 'VT3img1.jpg'),
('VT002', 2, 'VT3img2.jpg'),
('VT002', 3, 'VT3img3.jpg'),
('VT002', 4, 'VT3img4.jpg'),
('VT002', 5, 'VT3img5.jpg'),
('VT002', 6, 'VT3img6.jpg'),
('VT002', 7, 'VT3img7.jpg'),
('VT002', 8, 'VT3img8.jpg');


--HUẾ
-- Insert địa điểm Huế 
INSERT INTO Places (placename, description, img_places, Featured) VALUES
(N'Huế', N'Huế là kinh đô cổ của Việt Nam với nhiều di tích lịch sử, đền đài, lăng tẩm triều Nguyễn và sông Hương thơ mộng.', 'hueimg.jpg', 0);

-- Lấy ID Huế vừa tạo
DECLARE @idHue INT = SCOPE_IDENTITY();
-- Insert danh sách tour Huế
INSERT INTO TourTickets VALUES
('HU001', @idHue, N'Huế', N'TP. Hồ Chí Minh', N'3 ngày 2 đêm', 2900000, N'Máy bay', N'Du lịch Huế - Đại Nội, chùa Thiên Mụ & sông Hương', 'hue1.jpg'),
('HU002', @idHue, N'Huế', N'TP. Hồ Chí Minh', N'4 ngày 3 đêm', 3600000, N'Tàu hỏa', N'Hành trình khám phá cố đô Huế & ẩm thực miền Trung', 'hue2.jpg');

--TOUR HU001
-- Update for Day 1 of HU001
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 1: ĐẠI NỘI – LĂNG TỰ ĐỨC – CHÙA THIÊN MỤ',
    Morning = N'Bay từ TP.HCM đến Huế. Nhận phòng khách sạn, nghỉ ngơi nhẹ.',
    Afternoon = N'Tham quan Đại Nội Kinh Thành Huế – hoàng cung triều Nguyễn. Ghé thăm lăng Tự Đức, một trong những lăng tẩm đẹp nhất xứ Huế.',
    Evening = N'Đi thuyền sông Hương, thả đèn hoa đăng và nghe ca Huế truyền thống.'
WHERE idTourTicket = 'HU001' AND Day = 1;

-- Update for Day 2 of HU001
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 2: CHÙA THIÊN MỤ – CHỢ ĐÔNG BA – TP.HCM',
    Morning = N'Viếng chùa Thiên Mụ – biểu tượng văn hóa tâm linh lâu đời. Tự do dạo chơi và mua sắm tại chợ Đông Ba, trung tâm ẩm thực – đặc sản Huế.',
    Afternoon = N'Trả phòng, ra sân bay Phú Bài để bay về TP.HCM.',
    Evening = N'Kết thúc chuyến tham quan, chúc quý khách có một chuyến đi ý nghĩa và đáng nhớ.'  -- Added farewell message for the final day.
WHERE idTourTicket = 'HU001' AND Day = 2;


 INSERT INTO TicketImgs (idTourTicket, imgNum, imgUrl) VALUES
('HU001', 1, 'HUE2img1.jpg'),
('HU001', 2, 'HUE2img2.jpg'),
('HU001', 3, 'HUE2img3.jpg'),
('HU001', 4, 'HUE2img4.jpg'),
('HU001', 5, 'HUE2img5.jpg'),
('HU001', 6, 'HUE2img6.jpg'),
('HU001', 7, 'HUE2img7.jpg'),
('HU001', 8, 'HUE2img8.jpg');


--TOUR HU002
INSERT INTO TicketDayDetails (idTourTicket, Day, Description) VALUES
('HU002', 1, N'Ngày 1: ĐẠI NỘI – LĂNG KHẢI ĐỊNH – SÔNG HƯƠNG
  #Buổi sáng:#
  Đón khách tại sân bay hoặc điểm hẹn tại Huế./
  Nhận phòng khách sạn, nghỉ ngơi./
  #Buổi chiều:#
  Tham quan Đại Nội Kinh Thành Huế, tìm hiểu lịch sử triều Nguyễn./
  Khám phá lăng Khải Định – kiệt tác kiến trúc giao thoa Đông – Tây./
  #Buổi tối:#
  Thưởng thức ca Huế trên sông Hương, trải nghiệm thả đèn hoa đăng./'),

('HU002', 2, N'Ngày 2: ĐỒI VỌNG CẢNH – CHÙA THIÊN MỤ – LÀNG HƯƠNG
  #Buổi sáng:#
  Di chuyển lên Đồi Vọng Cảnh ngắm toàn cảnh sông Hương uốn lượn./
  Viếng chùa Thiên Mụ – biểu tượng tâm linh xứ Huế./
  #Buổi chiều:#
  Tham quan làng hương Thủy Xuân, trải nghiệm làm hương truyền thống./
  Mua sắm các sản phẩm đặc trưng thủ công mỹ nghệ Huế./'),

('HU002', 3, N'Ngày 3: ẨM THỰC HUẾ – PHỐ CỔ – TRỞ VỀ
  #Buổi sáng:#
  Thưởng thức đặc sản nổi tiếng: bánh bèo, bánh khoái, bún bò Huế./
  Dạo quanh khu phố cổ Huế, check-in, mua sắm đặc sản./
  #Buổi chiều:#
  Trả phòng, di chuyển ra sân bay/tuyến xe trở về điểm hẹn ban đầu./');

  -- Update for Day 1 of HU002
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 1: ĐẠI NỘI – LĂNG KHẢI ĐỊNH – SÔNG HƯƠNG',
    Morning = N'Đón khách tại sân bay hoặc điểm hẹn tại Huế. Nhận phòng khách sạn, nghỉ ngơi.',
    Afternoon = N'Tham quan Đại Nội Kinh Thành Huế, tìm hiểu lịch sử triều Nguyễn. Khám phá lăng Khải Định – kiệt tác kiến trúc giao thoa Đông – Tây.',
    Evening = N'Thưởng thức ca Huế trên sông Hương, trải nghiệm thả đèn hoa đăng.'
WHERE idTourTicket = 'HU002' AND Day = 1;

-- Update for Day 2 of HU002
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 2: ĐỒI VỌNG CẢNH – CHÙA THIÊN MỤ – LÀNG HƯƠNG',
    Morning = N'Di chuyển lên Đồi Vọng Cảnh ngắm toàn cảnh sông Hương uốn lượn. Viếng chùa Thiên Mụ – biểu tượng tâm linh xứ Huế.',
    Afternoon = N'Tham quan làng hương Thủy Xuân, trải nghiệm làm hương truyền thống. Mua sắm các sản phẩm đặc trưng thủ công mỹ nghệ Huế.',
    Evening = N'Khám phá ẩm thực đêm tại khu phố cổ, thưởng thức các món ăn đặc sản Huế.'
WHERE idTourTicket = 'HU002' AND Day = 2;

-- Update for Day 3 of HU002
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 3: ẨM THỰC HUẾ – PHỐ CỔ – TRỞ VỀ',
    Morning = N'Thưởng thức đặc sản nổi tiếng: bánh bèo, bánh khoái, bún bò Huế. Dạo quanh khu phố cổ Huế, check-in, mua sắm đặc sản.',
    Afternoon = N'Trả phòng, di chuyển ra sân bay/tuyến xe trở về điểm hẹn ban đầu.',
    Evening = N'Kết thúc hành trình, chúc quý khách có một chuyến đi ý nghĩa và đáng nhớ.'
WHERE idTourTicket = 'HU002' AND Day = 3;


  INSERT INTO TicketImgs (idTourTicket, imgNum, imgUrl) VALUES
('HU002', 1, 'HUE3img1.jpg'),
('HU002', 2, 'HUE3img2.jpg'),
('HU002', 3, 'HUE3img3.jpg'),
('HU002', 4, 'HUE3img4.jpg'),
('HU002', 5, 'HUE3img5.jpg'),
('HU002', 6, 'HUE3img6.jpg'),
('HU002', 7, 'HUE3img7.jpg'),
('HU002', 8, 'HUE3img8.jpg');


--HÀ NỘI
INSERT INTO Places (placename, description, img_places, Featured) VALUES
(N'Hà Nội', N'Hà Nội là thủ đô ngàn năm văn hiến với Hồ Gươm, Văn Miếu, Lăng Bác và ẩm thực đường phố phong phú.', 'hanoiimg.jpg', 0);


-- Lấy ID Hà Nội vừa tạo
DECLARE @idHanoi INT = SCOPE_IDENTITY();

-- Insert danh sách tour Hà Nội
INSERT INTO TourTickets VALUES
('HN001', @idHanoi, N'Hà Nội', N'TP. Hồ Chí Minh', N'3 ngày 2 đêm', 3100000, N'Máy bay', N'Khám phá Hà Nội - Hồ Gươm, Lăng Bác & phố cổ', 'hanoi1.jpg'),
('HN002', @idHanoi, N'Hà Nội', N'TP. Hồ Chí Minh', N'4 ngày 3 đêm', 3900000, N'Tàu hỏa', N'Tour Hà Nội - Văn Miếu, chùa Trấn Quốc & ẩm thực phố cổ', 'hanoi2.jpg');


--TOUR HN001
INSERT INTO TicketDayDetails (idTourTicket, Day, Description) VALUES
('HN001', 1, N'Ngày 1: VĂN MIẾU – HỒ TÂY – CHÙA TRẤN QUỐC – ẨM THỰC HÀ NỘI
  #Buổi sáng:#
  Bay từ TP.HCM ra Hà Nội./
  Nhận phòng khách sạn, nghỉ ngơi nhẹ./
  Tham quan Văn Miếu – Quốc Tử Giám, công trình mang đậm nét văn hóa – giáo dục./
  #Buổi chiều:#
  Dạo quanh Hồ Tây, ghé thăm chùa Trấn Quốc – ngôi chùa cổ nhất Thăng Long./
  Check-in tại các quán cafe ven hồ, không gian thơ mộng./
  #Buổi tối:#
  Trải nghiệm ẩm thực phố cổ Hà Nội: bún chả, phở bò, cafe trứng…/
  Dạo phố đi bộ Hồ Gươm, ngắm đền Ngọc Sơn về đêm./'),

('HN001', 2, N'Ngày 2: PHỐ CỔ – CẦU LONG BIÊN – CHỢ HÔM – NHÀ HÁT LỚN
  #Buổi sáng:#
  Tham quan cầu Long Biên – biểu tượng lịch sử Hà Nội, chụp ảnh kỷ niệm./
  Mua sắm đặc sản tại chợ Hôm./
  #Buổi chiều:#
  Tham quan Nhà hát Lớn Hà Nội – công trình kiến trúc Pháp cổ./
  Trả phòng, di chuyển ra sân bay Nội Bài, bay về TP.HCM./');

  -- Update for Day 1 of HN001
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 1: VĂN MIẾU – HỒ TÂY – CHÙA TRẤN QUỐC – ẨM THỰC HÀ NỘI',
    Morning = N'Bay từ TP.HCM ra Hà Nội. Nhận phòng khách sạn, nghỉ ngơi nhẹ. Tham quan Văn Miếu – Quốc Tử Giám, công trình mang đậm nét văn hóa – giáo dục.',
    Afternoon = N'Dạo quanh Hồ Tây, ghé thăm chùa Trấn Quốc – ngôi chùa cổ nhất Thăng Long. Check-in tại các quán cafe ven hồ, không gian thơ mộng.',
    Evening = N'Trải nghiệm ẩm thực phố cổ Hà Nội: bún chả, phở bò, cafe trứng… Dạo phố đi bộ Hồ Gươm, ngắm đền Ngọc Sơn về đêm.'
WHERE idTourTicket = 'HN001' AND Day = 1;

-- Update for Day 2 of HN001
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 2: PHỐ CỔ – CẦU LONG BIÊN – CHỢ HÔM – NHÀ HÁT LỚN',
    Morning = N'Tham quan cầu Long Biên – biểu tượng lịch sử Hà Nội, chụp ảnh kỷ niệm. Mua sắm đặc sản tại chợ Hôm.',
    Afternoon = N'Tham quan Nhà hát Lớn Hà Nội – công trình kiến trúc Pháp cổ. Trả phòng, di chuyển ra sân bay Nội Bài, bay về TP.HCM.',
    Evening = N'Kết thúc chuyến tham quan, chúc quý khách có một chuyến đi ý nghĩa và đáng nhớ.'
WHERE idTourTicket = 'HN001' AND Day = 2;


INSERT INTO TicketImgs (idTourTicket, imgNum, imgUrl) VALUES
('HN001', 1, 'HN2img1.jpg'),
('HN001', 2, 'HN2img2.jpg'),
('HN001', 3, 'HN2img3.jpg'),
('HN001', 4, 'HN2img4.jpg'),
('HN001', 5, 'HN2img5.jpg'),
('HN001', 6, 'HN2img6.jpg'),
('HN001', 7, 'HN2img7.jpg'),
('HN001', 8, 'HN2img8.jpg');

--TOUR HN002
INSERT INTO TicketDayDetails (idTourTicket, Day, Description) VALUES
('HN002', 1, N'Ngày 1: BAY ĐẾN HÀ NỘI – HỒ GƯƠM & PHỐ ĐI BỘ
  #Buổi sáng:#
  Bay từ TP.HCM ra Hà Nội./
  Di chuyển về khách sạn, nhận phòng nghỉ ngơi./
  #Buổi chiều:#
  Tham quan Hồ Gươm – biểu tượng văn hóa – lịch sử của thủ đô./
  Ghé đền Ngọc Sơn, cầu Thê Húc, tìm hiểu kiến trúc cổ kính đặc trưng./
  #Buổi tối:#
  Dạo phố đi bộ quanh Hồ Gươm, xem trình diễn nghệ thuật đường phố./
  Thưởng thức đặc sản Hà Nội như phở, bún chả, kem Tràng Tiền./'),

('HN002', 2, N'Ngày 2: LĂNG BÁC – CHÙA MỘT CỘT – BẢO TÀNG
  #Buổi sáng:#
  Tham quan Lăng Chủ tịch Hồ Chí Minh, quảng trường Ba Đình./
  Ghé chùa Một Cột – ngôi chùa độc đáo có kiến trúc “hoa sen”./
  #Buổi trưa:#
  Dùng bữa với các món ăn truyền thống như bún thang, bún mọc./
  #Buổi chiều:#
  Tham quan Bảo tàng Hồ Chí Minh./
  Tự do dạo phố cổ, tham quan 36 phố phường với các nghề truyền thống./'),

('HN002', 3, N'Ngày 3: MUA SẮM & VỀ LẠI TP.HCM
  #Buổi sáng:#
  Mua sắm tại chợ Đồng Xuân – khu chợ lâu đời, sầm uất nhất Hà Nội./
  Tự do mua quà lưu niệm, đặc sản như ô mai, trà sen, bánh cốm./
  #Buổi trưa:#
  Trả phòng khách sạn, dùng bữa nhẹ./
  #Buổi chiều:#
  Di chuyển ra sân bay Nội Bài, bay về TP.HCM. Kết thúc hành trình./');

  -- Update for Day 1 of HN002
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 1: BAY ĐẾN HÀ NỘI – HỒ GƯƠM & PHỐ ĐI BỘ',
    Morning = N'Bay từ TP.HCM ra Hà Nội. Di chuyển về khách sạn, nhận phòng nghỉ ngơi.',
    Afternoon = N'Tham quan Hồ Gươm – biểu tượng văn hóa – lịch sử của thủ đô. Ghé đền Ngọc Sơn, cầu Thê Húc, tìm hiểu kiến trúc cổ kính đặc trưng.',
    Evening = N'Dạo phố đi bộ quanh Hồ Gươm, xem trình diễn nghệ thuật đường phố. Thưởng thức đặc sản Hà Nội như phở, bún chả, kem Tràng Tiền.'
WHERE idTourTicket = 'HN002' AND Day = 1;

-- Update for Day 2 of HN002
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 2: LĂNG BÁC – CHÙA MỘT CỘT – BẢO TÀNG',
    Morning = N'Tham quan Lăng Chủ tịch Hồ Chí Minh, quảng trường Ba Đình. Ghé chùa Một Cột – ngôi chùa độc đáo có kiến trúc “hoa sen”.',
    Afternoon = N'Tham quan Bảo tàng Hồ Chí Minh. Tự do dạo phố cổ, tham quan 36 phố phường với các nghề truyền thống.',
    Evening = N'Khám phá ẩm thực đêm tại khu phố cổ, thưởng thức các món ăn vặt Hà Nội và mua sắm quà lưu niệm.'
WHERE idTourTicket = 'HN002' AND Day = 2;

-- Update for Day 3 of HN002
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 3: MUA SẮM & VỀ LẠI TP.HCM',
    Morning = N'Mua sắm tại chợ Đồng Xuân – khu chợ lâu đời, sầm uất nhất Hà Nội. Tự do mua quà lưu niệm, đặc sản như ô mai, trà sen, bánh cốm.',
    Afternoon = N'Trả phòng khách sạn, dùng bữa nhẹ. Di chuyển ra sân bay Nội Bài, bay về TP.HCM. Kết thúc hành trình.',
    Evening = N'Kết thúc chuyến tham quan, chúc quý khách có một chuyến đi ý nghĩa và đáng nhớ.'
WHERE idTourTicket = 'HN002' AND Day = 3;


  INSERT INTO TicketImgs (idTourTicket, imgNum, imgUrl) VALUES
('HN002', 1, 'HN3img1.jpg'),
('HN002', 2, 'HN3img2.jpg'),
('HN002', 3, 'HN3img3.jpg'),
('HN002', 4, 'HN3img4.jpg'),
('HN002', 5, 'HN3img5.jpg'),
('HN002', 6, 'HN3img6.jpg'),
('HN002', 7, 'HN3img7.jpg'),
('HN002', 8, 'HN3img8.jpg');

--------------------------------------------------------------------------------------------------
--ĐÀ LẠT
-- Insert địa điểm Đà Lạt
INSERT INTO Places (placename, description, img_places, Featured) VALUES
(N'Đà Lạt', N'Đà Lạt là thành phố cao nguyên thơ mộng với khí hậu mát mẻ quanh năm, nổi tiếng với hồ Xuân Hương, Thung lũng Tình yêu và đồi chè Cầu Đất.', 'dalatimg.webp', 0);

-- Lấy ID Đà Lạt
DECLARE @idDalat INT = SCOPE_IDENTITY();

-- Tour Đà Lạt
INSERT INTO TourTickets VALUES
('DL001', @idDalat, N'Đà Lạt', N'TP. Hồ Chí Minh', N'2 ngày 1 đêm', 1900000, N'Xe khách', N'Du lịch Đà Lạt - Thung lũng Tình yêu & chợ đêm', 'dalat1.jpg'),
('DL002', @idDalat, N'Đà Lạt', N'TP. Hồ Chí Minh', N'3 ngày 2 đêm', 2800000, N'Xe khách', N'Thành phố sương mù - đồi chè & Langbiang', 'dalat2.jpg');



-- Chi tiết tour Đà Lạt
-- DL001 (2 ngày)
INSERT INTO TicketDayDetails (idTourTicket, Day, Description) VALUES
('DL001', 1, N'Ngày 1: ĐÀ LẠT – THUNG LŨNG TÌNH YÊU – HỒ XUÂN HƯƠNG#Buổi sáng:# 
  Khởi hành từ TP.HCM đến Đà Lạt, tham quan Thung lũng Tình Yêu, Hồ Xuân Hương, vườn hoa thành phố./ 
  #Buổi trưa:# 
  Ăn đặc sản Đà Lạt (lẩu gà lá é, bánh tráng nướng...)./ 
  #Buổi chiều:# 
  Tham quan Thiền viện Trúc Lâm, Hồ Tuyền Lâm, đồi Robin (cầu kính)./ 
  #Buổi tối:# 
  Tham quan chợ đêm Đà Lạt, thưởng thức đặc sản đường phố./'),

('DL001', 2, N'Ngày 2: VƯỜN DÂU TÂY – NHÀ THỜ DOMAIN DE MARIE – DINH BẢO ĐẠI#Buổi sáng:# 
  Tham quan vườn dâu tây hoặc nhà thờ Domain De Marie, đồi chè Cầu Đất./ 
  #Buổi trưa:# 
  Ăn trưa tại quán nổi tiếng./ 
  #Buổi chiều:# 
  Tham quan Dinh Bảo Đại hoặc Crazy House, mua quà lưu niệm./ 
  #Buổi tối:# 
  Quay về TP.HCM hoặc nghỉ thêm đêm./');

  -- Update for Day 1 of DL001
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 1: ĐÀ LẠT – THUNG LŨNG TÌNH YÊU – HỒ XUÂN HƯƠNG',
    Morning = N'Khởi hành từ TP.HCM đến Đà Lạt, tham quan Thung lũng Tình Yêu, Hồ Xuân Hương, vườn hoa thành phố.',
    Afternoon = N'Tham quan Thiền viện Trúc Lâm, Hồ Tuyền Lâm, đồi Robin (cầu kính).',
    Evening = N'Tham quan chợ đêm Đà Lạt, thưởng thức đặc sản đường phố.'
WHERE idTourTicket = 'DL001' AND Day = 1;

-- Update for Day 2 of DL001
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 2: VƯỜN DÂU TÂY – NHÀ THỜ DOMAIN DE MARIE – DINH BẢO ĐẠI',
    Morning = N'Tham quan vườn dâu tây hoặc nhà thờ Domain De Marie, đồi chè Cầu Đất.',
    Afternoon = N'Tham quan Dinh Bảo Đại hoặc Crazy House, mua quà lưu niệm.',
    Evening = N'Quay về TP.HCM hoặc nghỉ thêm đêm.'
WHERE idTourTicket = 'DL001' AND Day = 2;


INSERT INTO TicketImgs (idTourTicket, imgNum, imgUrl) VALUES
('DL001', 1, 'DL2img1.jpg'),
('DL001', 2, 'DL2img2.jpg'),
('DL001', 3, 'DL2img3.jpg'),
('DL001', 4, 'DL2img4.jpg'),
('DL001', 5, 'DL2img5.jpg'),
('DL001', 6, 'DL2img6.jpg'),
('DL001', 7, 'DL2img7.jpg'),
('DL001', 8, 'DL2img8.jpg');

-- DL002 (3 ngày)
INSERT INTO TicketDayDetails (idTourTicket, Day, Description) VALUES
('DL002', 1, N'Ngày 1: Khám phá Đà Lạt
#Buổi sáng:#Tham quan đồi chè Cầu Đất xanh mướt, tận hưởng không khí trong lành./
Tham quan vườn dâu tây Đà Lạt, hái dâu và chụp ảnh sống ảo tại quảng trường Lâm Viên./
#Buổi chiều:#Thưởng thức đặc sản bánh căn, nem nướng ngay tại trung tâm thành phố./
Tham quan chợ Đà Lạt./
#Buổi tối:#Tự do dạo phố và thưởng thức đặc sản địa phương./'),

('DL002', 2, N'Ngày 2: Thiên nhiên và trải nghiệm
#Buổi sáng:#Trekking đỉnh Langbiang, chiêm ngưỡng toàn cảnh Đà Lạt mờ sương./
Tham gia trải nghiệm cưỡi xe jeep khám phá núi rừng Langbiang./
#Buổi chiều:#Thưởng thức buffet rau tươi đặc sản Đà Lạt tại nhà hàng địa phương./
Dạo chợ đêm Đà Lạt, mua sắm quà lưu niệm và thưởng thức các món ăn đường phố./
#Buổi tối:
#Tự do nghỉ ngơi.'),

('DL002', 3, N'Ngày 3: Văn hóa và mua sắm
#Buổi sáng:#Tham quan hồ Xuân Hương, đi dạo quanh bờ hồ thơ mộng./
Tham quan Thiền viện Trúc Lâm và cáp treo Đà Lạt./
#Buổi chiều:#Mua sắm đặc sản tại chợ Đà Lạt trước khi trở về./
#Buổi tối:#Kết thúc chuyến đi./');

-- Update for Day 1 of DL002
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 1: Khám phá Đà Lạt',
    Morning = N'Tham quan đồi chè Cầu Đất xanh mướt, tận hưởng không khí trong lành. Tham quan vườn dâu tây Đà Lạt, hái dâu và chụp ảnh sống ảo tại quảng trường Lâm Viên.',
    Afternoon = N'Thưởng thức đặc sản bánh căn, nem nướng ngay tại trung tâm thành phố. Tham quan chợ Đà Lạt.',
    Evening = N'Tự do dạo phố và thưởng thức đặc sản địa phương.'
WHERE idTourTicket = 'DL002' AND Day = 1;

-- Update for Day 2 of DL002
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 2: Thiên nhiên và trải nghiệm',
    Morning = N'Trekking đỉnh Langbiang, chiêm ngưỡng toàn cảnh Đà Lạt mờ sương. Tham gia trải nghiệm cưỡi xe jeep khám phá núi rừng Langbiang.',
    Afternoon = N'Thưởng thức buffet rau tươi đặc sản Đà Lạt tại nhà hàng địa phương. Dạo chợ đêm Đà Lạt, mua sắm quà lưu niệm và thưởng thức các món ăn đường phố.',
    Evening = N'Tự do nghỉ ngơi.'
WHERE idTourTicket = 'DL002' AND Day = 2;

-- Update for Day 3 of DL002
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 3: Văn hóa và mua sắm',
    Morning = N'Tham quan hồ Xuân Hương, đi dạo quanh bờ hồ thơ mộng. Tham quan Thiền viện Trúc Lâm và cáp treo Đà Lạt.',
    Afternoon = N'Mua sắm đặc sản tại chợ Đà Lạt trước khi trở về.',
    Evening = N'Kết thúc chuyến đi.'
WHERE idTourTicket = 'DL002' AND Day = 3;


INSERT INTO TicketImgs (idTourTicket, imgNum, imgUrl) VALUES
('DL002', 1, 'DL3img1.jpg'),
('DL002', 2, 'DL3img2.jpg'),
('DL002', 3, 'DL3img3.jpg'),
('DL002', 4, 'DL3img4.jpg'),
('DL002', 5, 'DL3img5.jpg'),
('DL002', 6, 'DL3img6.jpg'),
('DL002', 7, 'DL3img7.jpg'),
('DL002', 8, 'DL3img8.jpg');



--ĐÀ NẴNG
-- Insert địa điểm Đà Nẵng
INSERT INTO Places (placename, description, img_places, Featured) VALUES
(N'Đà Nẵng', N'Đà Nẵng là thành phố biển năng động với bãi biển Mỹ Khê, Cầu Rồng, bán đảo Sơn Trà và Bà Nà Hills nổi tiếng.', 'danang2img.jpg', 1);

-- Lấy ID Đà Nẵng
DECLARE @idDanang INT = SCOPE_IDENTITY();

-- Tour Đà Nẵng
INSERT INTO TourTickets VALUES
('DN001', 6, N'Đà Nẵng', N'TP. Hồ Chí Minh', N'2 ngày 1 đêm', 2200000, N'Máy bay', N'Tour Đà Nẵng - Bà Nà Hills & cầu Vàng', 'danang1.jpg'),
('DN002', 6, N'Đà Nẵng', N'TP. Hồ Chí Minh', N'3 ngày 2 đêm', 3200000, N'Máy bay', N'Khám phá Đà Nẵng - Sơn Trà, Ngũ Hành Sơn & biển Mỹ Khê', 'danang2.jpg');


-- DN001 (2 ngày)
INSERT INTO TicketDayDetails (idTourTicket, Day, Description) VALUES
('DN001', 1, N'Ngày 1: KHÁM PHÁ BÀ NÀ HILLS & CẦU VÀNG#Buổi sáng:#
Khởi hành từ TP.HCM đến Đà Nẵng bằng máy bay./
#Buổi trưa:#Ăn trưa buffet tại nhà hàng trên Bà Nà./
Nghỉ ngơi và ngắm cảnh núi non tuyệt đẹp./
#Buổi chiều:#Tham quan Cầu Vàng – điểm check-in nổi tiếng với thiết kế độc đáo “bàn tay khổng lồ”./
Vui chơi tại Fantasy Park – khu giải trí trong nhà lớn thứ 3 thế giới./
#Buổi tối:#Về lại trung tâm Đà Nẵng, dùng bữa tối và nghỉ đêm tại khách sạn./'),

('DN001', 2, N'Ngày 2: Biển Mỹ Khê & Cầu Rồng
#Buổi sáng:#Ăn sáng tại khách sạn./
Tham quan và tắm biển Mỹ Khê – một trong những bãi biển quyến rũ nhất hành tinh./
#Buổi trưa:#Thưởng thức hải sản địa phương tại nhà hàng ven biển./
#Buổi chiều:#Tham quan Cầu Rồng, cầu quay sông Hàn, chợ Hàn./
Mua sắm đặc sản làm quà: tré, mực rim, bánh khô mè, nước mắm Nam Ô…/
#Buổi tối:#Di chuyển ra sân bay, kết thúc chuyến hành trình, bay về lại TP.HCM./');

-- Update for Day 1 of DN001
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 1: KHÁM PHÁ BÀ NÀ HILLS & CẦU VÀNG',
    Morning = N'Khởi hành từ TP.HCM đến Đà Nẵng bằng máy bay.',
    Afternoon = N'Tham quan Cầu Vàng – điểm check-in nổi tiếng với thiết kế độc đáo “bàn tay khổng lồ”. Vui chơi tại Fantasy Park – khu giải trí trong nhà lớn thứ 3 thế giới.',
    Evening = N'Về lại trung tâm Đà Nẵng, dùng bữa tối và nghỉ đêm tại khách sạn.'
WHERE idTourTicket = 'DN001' AND Day = 1;

-- Update for Day 2 of DN001
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 2: Biển Mỹ Khê & Cầu Rồng',
    Morning = N'Ăn sáng tại khách sạn. Tham quan và tắm biển Mỹ Khê – một trong những bãi biển quyến rũ nhất hành tinh.',
    Afternoon = N'Thưởng thức hải sản địa phương tại nhà hàng ven biển. Tham quan Cầu Rồng, cầu quay sông Hàn, chợ Hàn. Mua sắm đặc sản làm quà: tré, mực rim, bánh khô mè, nước mắm Nam Ô.',
    Evening = N'Di chuyển ra sân bay, kết thúc chuyến hành trình, bay về lại TP.HCM.'
WHERE idTourTicket = 'DN001' AND Day = 2;


-- DN002 (3 ngày)
INSERT INTO TicketDayDetails (idTourTicket, Day, Description) VALUES
('DN002', 1, N'Ngày 1: BÁN ĐẢO SƠN TRÀ – NGŨ HÀNH SƠN#Buổi sáng:#
Khởi hành từ TP.HCM đến bán đảo Sơn Trà./
Tham quan chùa Linh Ứng – ngôi chùa nổi tiếng với tượng Phật Bà Quan Âm cao lớn./
Tham quan Ngũ Hành Sơn với các hang động và cảnh quan thiên nhiên tuyệt đẹp./
#Buổi chiều:#
Khám phá ẩm thực địa phương tại các quán ăn nổi tiếng./
Tản bộ quanh các bãi biển gần đó, tận hưởng không khí trong lành./
#Buổi tối:#
Nghỉ ngơi và chuẩn bị cho ngày tiếp theo./'),

('DN002', 2, N'Ngày 2: BIỂN MỸ KHÊ – GIẢI TRÍ – MUA SẮM#Buổi sáng:#
Tự do tắm biển Mỹ Khê, một trong những bãi biển đẹp nhất Việt Nam./
Tham gia các hoạt động thể thao biển (nếu muốn)./
#Buổi chiều:#
Thưởng thức hải sản tươi ngon tại các nhà hàng ven biển./
Tham quan các địa điểm giải trí hoặc mua sắm đặc sản./
#Buổi tối:#
Tham quan phố đêm Đà Nẵng, thưởng thức ẩm thực đường phố./'),

('DN002', 3, N'Ngày 3: BẢO TÀNG CHĂM – TRẢ PHÒNG – TRỞ VỀ#Buổi sáng:#
Tham quan Bảo tàng Chăm để tìm hiểu văn hóa Champa cổ đại./
Chuẩn bị hành lý và trả phòng khách sạn./
#Buổi chiều:#
Di chuyển về TP.HCM, kết thúc chuyến đi./');

-- Update for Day 1 of DN002
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 1: BÁN ĐẢO SƠN TRÀ – NGŨ HÀNH SƠN',
    Morning = N'Khởi hành từ TP.HCM đến bán đảo Sơn Trà. Tham quan chùa Linh Ứng – ngôi chùa nổi tiếng với tượng Phật Bà Quan Âm cao lớn. Tham quan Ngũ Hành Sơn với các hang động và cảnh quan thiên nhiên tuyệt đẹp.',
    Afternoon = N'Khám phá ẩm thực địa phương tại các quán ăn nổi tiếng. Tản bộ quanh các bãi biển gần đó, tận hưởng không khí trong lành.',
    Evening = N'Nghỉ ngơi và chuẩn bị cho ngày tiếp theo.'
WHERE idTourTicket = 'DN002' AND Day = 1;

-- Update for Day 2 of DN002
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 2: BIỂN MỸ KHÊ – GIẢI TRÍ – MUA SẮM',
    Morning = N'Tự do tắm biển Mỹ Khê, một trong những bãi biển đẹp nhất Việt Nam. Tham gia các hoạt động thể thao biển (nếu muốn).',
    Afternoon = N'Thưởng thức hải sản tươi ngon tại các nhà hàng ven biển. Tham quan các địa điểm giải trí hoặc mua sắm đặc sản.',
    Evening = N'Tham quan phố đêm Đà Nẵng, thưởng thức ẩm thực đường phố.'
WHERE idTourTicket = 'DN002' AND Day = 2;

-- Update for Day 3 of DN002
UPDATE TicketDayDetails
SET 
    Description = N'Ngày 3: BẢO TÀNG CHĂM – TRẢ PHÒNG – TRỞ VỀ',
    Morning = N'Tham quan Bảo tàng Chăm để tìm hiểu văn hóa Champa cổ đại. Chuẩn bị hành lý và trả phòng khách sạn.',
    Afternoon = N'Di chuyển về TP.HCM, kết thúc chuyến đi.',
    Evening = N'Kết thúc chuyến đi, chúc quý khách có một chuyến đi ý nghĩa và đáng nhớ.'
WHERE idTourTicket = 'DN002' AND Day = 3;


-- DN001
INSERT INTO TicketImgs (idTourTicket, imgNum, imgUrl) VALUES
('DN001', 1, 'DN2img1.jpg'),
('DN001', 2, 'DN2img2.jpg'),
('DN001', 3, 'DN2img3.jpg'),
('DN001', 4, 'DN2img4.jpg'),
('DN001', 5, 'DN2img5.jpg'),
('DN001', 6, 'DN2img6.jpg'),
('DN001', 7, 'DN2img7.jpg'),
('DN001', 8, 'DN2img8.jpg');

-- DN002
INSERT INTO TicketImgs (idTourTicket, imgNum, imgUrl) VALUES
('DN002', 1, 'DN3img1.jpg'),
('DN002', 2, 'DN3img2.jpg'),
('DN002', 3, 'DN3img3.jpg'),
('DN002', 4, 'DN3img4.jpg'),
('DN002', 5, 'DN3img5.jpg'),
('DN002', 6, 'DN3img6.jpg'),
('DN002', 7, 'DN3img7.jpg'),
('DN002', 8, 'DN3img8.jpg');

--=======================================================================================
--insert data
INSERT INTO TourStartDates (idTourTicket, startdate, startNum) VALUES
('NT001', '2025-07-10', 1),('NT001', '2025-07-15', 2),('NT001', '2025-07-20', 3),
('NT002', '2025-07-20', 1),('NT002', '2025-07-25', 2),('NT002', '2025-07-30', 3),
('VT001', '2025-08-01', 1),('VT001', '2025-08-05', 2),('VT001', '2025-08-10', 3),
('VT002', '2025-08-15', 1),('VT002', '2025-08-20', 2),('VT002', '2025-08-25', 3),
('HU001', '2025-09-05', 1),('HU001', '2025-09-10', 2),('HU001', '2025-09-15', 3),
('HU002', '2025-09-20', 1),('HU002', '2025-09-25', 2),('HU002', '2025-09-30', 3),
('HN001', '2025-10-05', 1),('HN001', '2025-10-10', 2),('HN001', '2025-10-15', 3),
('HN002', '2025-10-18', 1),('HN002', '2025-10-22', 2),('HN002', '2025-10-26', 3),
('DL001', '2025-11-01', 1),('DL001', '2025-11-05', 2),('DL001', '2025-11-09', 3),
('DL002', '2025-11-10', 1),('DL002', '2025-11-15', 2),('DL002', '2025-11-20', 3),
('DN001', '2025-12-01', 1),('DN001', '2025-12-05', 2),('DN001', '2025-12-09', 3),
('DN002', '2025-12-15', 1),('DN002', '2025-12-20', 2),('DN002', '2025-12-25', 3);