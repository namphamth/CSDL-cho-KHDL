-- Bước 1: Tạo bảng

CREATE TABLE NhanVien (
    MaNV INTEGER PRIMARY KEY,
    HoTen VARCHAR(50),
    Tuoi INTEGER,
    PhongBan VARCHAR(50)
);

-- Bước 2: Chèn dữ liệu vào bảng
INSERT INTO NhanVien (MaNV, HoTen, Tuoi, PhongBan) VALUES
(1, 'Nguyen Van A', 30, 'Ke Toan'),
(2, 'Tran Thi B', 25, 'Nhan Su'),
(3, 'Le Van C', 28, 'IT'),
(4, 'Pham Thi D', 32, 'Ke Toan'),
(5, 'Vu Van E', 26, 'IT'),
(6, 'Nguyen Thi F', 29, 'Marketing'),
(7, 'Le Thi G', 27, 'Nhan Su'),
(8, 'Hoang Van H', 35, 'Ke Toan'),
(9, 'Pham Van I', 33, 'Marketing'),
(10, 'Tran Van J', 24, 'IT'),
(11, 'Dang Thi K', 31, 'Nhan Su'),
(12, 'Nguyen Van L', 28, 'Ke Toan'),
(13, 'Tran Thi M', 26, 'Marketing'),
(14, 'Pham Van N', 30, 'Nhan Su'),
(15, 'Hoang Thi O', 27, 'IT');

-- Bước 3: Lấy toàn bộ thông tin của nhân viên trong bảng
SELECT * FROM NhanVien;

-- Bước 4: Truy vấn HoTen và Tuoi của các nhân viên trong phòng IT
SELECT HoTen, Tuoi FROM NhanVien WHERE PhongBan = 'IT';

-- Bước 5: Tìm nhân viên có độ tuổi lớn hơn 25
SELECT * FROM NhanVien WHERE Tuoi > 25;

-- Bước 6: Cho biết nhân viên lớn tuổi nhất của các PhongBan
SELECT PhongBan, HoTen, Tuoi
FROM NhanVien
WHERE Tuoi = (SELECT MAX(Tuoi) FROM NhanVien);

-- Bước 7: Chuyển đổi thông tin PhongBan của nhân viên "Le Van C" sang "Marketing"
UPDATE NhanVien 
SET PhongBan = 'Marketing' 
WHERE HoTen = 'Le Van C';
-- Vấn đề có thể gặp phải: Nếu có nhiều người trùng tên "Le Van C", lệnh này sẽ cập nhật tất cả.
-- Giải pháp: Xác định nhân viên bằng MaNV để cập nhật chính xác.
UPDATE NhanVien 
SET PhongBan = 'Marketing' 
WHERE MaNV = 3; -- Giả sử MaNV của "Le Van C" là 3

-- Bước 8: Xóa nhân viên có MaNV = 2 rồi cho biết mỗi phòng ban có bao nhiêu người
DELETE FROM NhanVien WHERE MaNV = 2;

SELECT PhongBan, COUNT(*) AS SoLuongNhanVien 
FROM NhanVien 
GROUP BY PhongBan;

