#câu 1
CREATE TABLE NhanVien (
    MaNV INT PRIMARY KEY,
    HoTen VARCHAR(50),
    Tuoi INT,
    PhongBan VARCHAR(50)
);
#câu 2
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
SELECT * FROM NhanVien;
#câu3
SELECT * FROM NhanVien;
#câu 4
SELECT HoTen, Tuoi FROM NhanVien
WHERE PhongBan = 'IT';
#câu 5
SELECT * FROM NhanVien
WHERE Tuoi > 25;
#câu 6
SELECT n1.* 
FROM NhanVien n1
WHERE Tuoi = (SELECT MAX(n2.Tuoi) 
              FROM NhanVien n2 
              WHERE n2.PhongBan = n1.PhongBan);
#câu 7
UPDATE NhanVien
SET PhongBan = 'Marketing'
WHERE HoTen = 'Le Van C';
SELECT * FROM NhanVien WHERE HoTen = 'Le Van C';
Sau khi kiểm tra tính duy nhất của dữ liệu, ta thấy mỗi nhân viên trong bảng có một mã nhân viên (MaNV) duy nhất để dễ dàng xác định bản ghi cần cập nhật
---Như vậy, không có vấn đề gặp phải khi thực hiện chuyển đổi thông tin 

#câu 8
DELETE FROM NhanVien
WHERE MaNV = 2;
SELECT * FROM NhanVien;
SELECT PhongBan, COUNT(*) AS SoLuongNhanVien
FROM NhanVien
GROUP BY PhongBan;


