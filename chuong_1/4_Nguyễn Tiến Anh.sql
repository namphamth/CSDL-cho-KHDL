-- 1. Kiểm tra và chỉ tạo bảng nếu chưa tồn tại
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'NhanVien') AND type = N'U')
BEGIN
    CREATE TABLE NhanVien (
        MaNV INT PRIMARY KEY,
        HoTen VARCHAR(50),
        Tuoi INT,
        PhongBan VARCHAR(50)
    );
END;

-- 2. Làm mới dữ liệu trong bảng NhanVien
TRUNCATE TABLE NhanVien;

-- 3. Chèn các bản ghi vào bảng NhanVien
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

-- 4. Truy vấn các nhân viên có họ là 'Nguyen'
SELECT * 
FROM NhanVien
WHERE HoTen LIKE 'Nguyen%';

-- 5. Truy vấn họ tên và tuổi của nhân viên trong phòng 'IT'
SELECT HoTen, Tuoi
FROM NhanVien
WHERE PhongBan = 'IT';

-- 6. Truy vấn các nhân viên có độ tuổi lớn hơn 25
SELECT *
FROM NhanVien
WHERE Tuoi > 25;
--7. NHÂN VIÊN LỚN TUỔI TRONG CÁC PHÒNG BAN
SELECT nv.MaNV, nv.HoTen, nv.Tuoi, nv.PhongBan
FROM NhanVien nv
JOIN (
    SELECT PhongBan, MAX(Tuoi) AS MaxTuoi
    FROM NhanVien
    GROUP BY PhongBan
) AS max_nv ON nv.PhongBan = max_nv.PhongBan AND nv.Tuoi = max_nv.MaxTuoi;
--8 sửa đổi phòng ban của "Le Van C" sang "MAKETING"
UPDATE NhanVien
SET PhongBan = 'Marketing'
WHERE HoTen = 'Le Van C';
---Vấn đề có thể gặp phải khi thực hiện cập nhật
-----Trường hợp có nhiều nhân viên tên "Le Van C":
-------Nếu trong bảng có nhiều nhân viên cùng tên "Le Van C", tất cả sẽ bị chuyển sang "Marketing", điều này có thể không chính xác.
-----Trường hợp không có nhân viên nào tên "Le Van C":
-------Nếu không có ai tên "Le Van C", lệnh UPDATE sẽ không thực hiện bất kỳ thay đổi nào, nhưng cũng không báo lỗi.
---Giải quyếtquyết
--Cách 1: Kiểm tra trước khi cập nhật
---Trước khi thực hiện UPDATE, kiểm tra có bao nhiêu nhân viên tên "Le Van C".
----Truy vấn kiểm tra số lượng nhân viên có tên "Le Van C"
SELECT MaNV, HoTen, PhongBan FROM NhanVien WHERE HoTen = 'Le Van C';
----TH1: Nếu chỉ có 1 nhân viên, chạy UPDATE như bình thường.
----TH2: Nếu có nhiều người trùng tên, yêu cầu người dùng chọn MaNV cụ thể để cập nhật đúng người.
----TH3: Nếu không có nhân viên nào, thông báo lỗi và không thực hiện UPDATE.
---Cách 2: Cập nhật dựa trên MaNV để tránh nhầm lẫn
-----Nếu có nhiều nhân viên tên "Le Van C", chỉ cập nhật nhân viên có MaNV cụ thể:
UPDATE NhanVien
SET PhongBan = 'Marketing'
WHERE HoTen = 'Le Van C' AND MaNV = 3;
--9 xóa nhân viên có MASV = 2
DELETE FROM NhanVien
WHERE MaNV = 2;
-- số người còn trong mỗi phòng ban
SELECT PhongBan, COUNT(*) AS SoLuongNhanVien
FROM NhanVien
GROUP BY PhongBan;

#9 Các bước kết nối đến SQLite trong Python
import sqlite3
# 1. Kết nối đến database
conn = sqlite3.connect("nhanvien.db")
cursor = conn.cursor()

# 2. Tạo bảng nếu chưa có
cursor.execute("""
CREATE TABLE IF NOT EXISTS NhanVien (
    MaNV INT PRIMARY KEY,
    HoTen VARCHAR(50),
    Tuoi INT,
    PhongBan VARCHAR(50))
""")
conn.commit()

# 3. Chèn dữ liệu vào bảng
cursor.execute("INSERT INTO NhanVien VALUES (9, 'Pham Van I', 33, 'Marketing')")
conn.commit()                                  

# 4. Truy vấn dữ liệu
cursor.execute("SELECT * FROM NhanVien")
rows = cursor.fetchall()
for row in rows:
    print(row)
    
# 5. Đóng kết nối
conn.close()

