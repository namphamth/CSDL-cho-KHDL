--cau1:tạo bảng nhân viên
CREATE TABLE nhanvien(
	MaNV INT PRIMARY KEY,
	HoTen VARCHAR(50),
	Tuoi INT,
	PhongBan VARCHAR(50)
);

--câu 2: chèn các bản ghi
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

--cau3:lấy toàn bộ thông tin của bảng nhan vien
SELECT * FROM nhanvien;
--cau4:truy vấn HoTen và Tuoi của các nhân viên trong phòng IT
SELECT HoTen,Tuoi FROM nhanvien
WHERE (PhongBan='IT');
--cau5:tìm nhân vien có độ tuổi lớn hơn 25
SELECT HoTen,Tuoi FROM nhanvien
WHERE (	Tuoi>25);

--cau6:Cho biết nhân viên lớn tuổi nhất của các PhongBan

SELECT PhongBan, HoTen, MAX(Tuoi) FROM NhanVien GROUP BY PhongBan;
--cau7:Chuyển đổi thông tin PhongBan của nhân viên “Le Van C” sang “Marketing”
UPDATE nhanvien SET PhongBan='Marketing' 
WHERE HoTen='Le Van C';
SELECT * FROM NhanVien WHERE HoTen = 'Le Van C';
--không có vấn đề gì khi chuyển đổi thông tin

--cau8

DELETE FROM nhanvien 
WHERE MaNV=2;
SELECT PhongBan, count(*) FROM nhanvien
GROUP BY PhongBan
