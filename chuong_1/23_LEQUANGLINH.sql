CREATE TABLE NhanVien (
    MaNV INTEGER PRIMARY KEY,
    HoTen VARCHAR(50),
    Tuoi INTEGER,
    PhongBan VARCHAR(50)
);

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


-- 3. Hiển thị toàn bộ nhân viên
SELECT * FROM NhanVien;

-- 4. Truy vấn HoTen và Tuoi của các nhân viên trong phòng IT
SELECT HoTen, Tuoi FROM NhanVien WHERE PhongBan = 'IT';

-- 5. Tìm nhân viên có độ tuổi lớn hơn 25
SELECT * FROM NhanVien WHERE Tuoi > 25;

-- 6. Cho biết nhân viên lớn tuổi nhất của các PhongBan
SELECT PhongBan, MAX(Tuoi) AS TuoiLonNhat
FROM NhanVien
GROUP BY PhongBan;

-- 7. Chuyển đổi thông tin PhongBan của nhân viên “Le Van C” sang “Marketing” (có vấn đề gặp phải khi thực hiện chuyển đổi thông tin hay không? Nếu có, vấn đề đó là gì và hãy đề xuất biện pháp giải quyết)
UPDATE NhanVien
SET PhongBan = 'Marketing'
WHERE HoTen = 'Le Van C';

-- Sau khi kiểm tra tính duy nhất của dữ liệu, ta thấy mỗi nhân viên trong bảng có một mã nhân viên (MaNV) duy nhất để dễ dàng xác định bản ghi cần cập nhật
-- Như vậy, không có vấn đề gặp phải khi thực hiện chuyển đổi thông tin Bước 7
-- Giả sử có vấn đề chuyển đổi thông tin, ta có thể có các giải pháp là:
-- C1: Kiểm tra tính duy nhất của dữ liệu thay vì sử dụng HoTen thì dùng MaNV tránh sự trùng lặp vì mỗi NV chỉ có 1 mã
UPDATE NhanVien
SET PhongBan = 'Marketing'
WHERE MaNV = 3;
-- C2: Kiểm tra dữ liệu trước khi cập nhật
SELECT * 
FROM NhanVien
WHERE HoTen = 'Le Van C';
-- C3: Xác nhận tính chính xác sau khi cập nhật

-- 8. Xóa nhân viên có “MaSV = 2” rồi cho biết mỗi phòng ban có bao nhiêu người
-- Xóa nhân viên có MaNV = 2
DELETE FROM NhanVien WHERE MaNV = 2;
SELECT * FROM NhanVien;

-- Đếm số lượng nhân viên trong mỗi phòng ban
SELECT PhongBan, COUNT(*) AS SoLuong
FROM NhanVien
GROUP BY PhongBan;