DROP TABLE IF EXISTS NhanVien;
--Cau 1
CREATE TABLE NhanVien (
    MaNV INT PRIMARY KEY,
    HoTen VARCHAR(50),
    Tuoi INT,
    PhongBan VARCHAR(50)
);
--Cau 2
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

--Cau 3
SELECT * FROM NhanVien;

--Cau 4
SELECT HoTen, Tuoi FROM NhanVien WHERE PhongBan = 'IT';

--Cau 5
SELECT * FROM NhanVien WHERE Tuoi > 25;

--Cau 6
SELECT NV.PhongBan, NV.HoTen, NV.Tuoi 
FROM NhanVien NV
JOIN (
    SELECT PhongBan, MAX(Tuoi) AS MaxTuoi 
    FROM NhanVien 
    GROUP BY PhongBan
) AS MaxAge
ON NV.PhongBan = MaxAge.PhongBan AND NV.Tuoi = MaxAge.MaxTuoi;

--Cau 7
UPDATE NhanVien SET PhongBan = 'Marketing' WHERE HoTen = 'Le Van C';
SELECT * FROM NhanVien WHERE HoTen = 'Le Van C';
--Sau khi kiểm tra tính duy nhất của dữ liệu, ta thấy họ tên của nhân viên đó là duy nhất. Tuy nhiên đây là với dữ liệu nhỏ, nếu với dữ liệu lớn ta nên sử dụng khóa chính là MaNV để chuyển đổi phòng ban.
--Giả sử có vấn đề chuyển đổi thông tin, ta có thể có các giải pháp là:
--Giải pháp đề ra: Kiểm tra tính duy nhất của dữ liệu thay vì sử dụng HoTen thì dùng MaNV tránh sự trùng lặp vì mỗi NV chỉ có 1 mã
UPDATE NhanVien
SET PhongBan = 'Marketing'
WHERE MaNV = 3;

--Cau 8
DELETE FROM NhanVien WHERE MaNV = 2;
SELECT PhongBan, COUNT(*) AS SoLuongNhanVien FROM NhanVien GROUP BY PhongBan;
