---Lê Thế Khôi-22174600008

---1. Tao bang NhanVien
CREATE TABLE NhanVien (
    MaNV INT PRIMARY KEY,
    HoTen VARCHAR(50),
    Tuoi INT,
    PhongBan VARCHAR(50)
);
---2. Chen cac ban ghi vao bang NhanVien
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
---3.Lay toan bo thong tin cua nhan vien trong bang NhanVien
SELECT * FROM NhanVien;
---4. Truy van HoTen va Tuoi cua cac nhan vien trong phong IT
SELECT HoTen, Tuoi FROM NhanVien WHERE PhongBan = 'IT';
---5. Tim nhan vien co do tuoi lon hon 25
SELECT * FROM NhanVien WHERE Tuoi > 25;
---6. Cho biet nhan vien lon tuoi nhat cua cac phong ban
SELECT n.PhongBan, n.HoTen, n.Tuoi 
FROM NhanVien n
JOIN (
    SELECT PhongBan, MAX(Tuoi) AS MaxTuoi
    FROM NhanVien
    GROUP BY PhongBan
) AS max_table
ON n.PhongBan = max_table.PhongBan AND n.Tuoi = max_table.MaxTuoi;


---7. Chuyển đổi thông tin PhongBan của nhân viên "Le Van C" sang "Marketing".
UPDATE NhanVien 
SET PhongBan = 'Marketing' 
WHERE HoTen = 'Le Van C';
---Nếu HoTen không có ràng buộc duy nhất (UNIQUE), có thể có nhiều người tên "Le Van C", dẫn đến việc cập nhật nhiều dòng cùng lúc.
---Biện pháp giải quyết:
---Cập nhật dựa trên MaNV (khóa chính) thay vì chỉ dựa vào HoTen:
---UPDATE NhanVien
---SET PhongBan = 'Marketing'
---WHERE MaNV = 3; -- Giả sử "Le Van C" có MaNV = 3


---8. Xóa nhân viên có "MaSV = 2" rồi cho biết mỗi phòng ban có bao nhiêu người
DELETE FROM NhanVien WHERE MaNV = 2;
---Đếm số nhân viên còn lại sau khi xóa
SELECT PhongBan, COUNT(*) AS SoLuongNhanVien 
FROM NhanVien 
GROUP BY PhongBan;
---9 Các bước kết nối đến SQLite trong Python
import sqlite3
conn = sqlite3.connect("nhanvien.db")
cursor = conn.cursor()

cursor.execute("""
CREATE TABLE IF NOT EXISTS NhanVien (
    MaNV INT PRIMARY KEY,
    HoTen VARCHAR(50),
    Tuoi INT,
    PhongBan VARCHAR(50))
""")
conn.commit()

cursor.execute("INSERT INTO NhanVien VALUES (9, 'Pham Van I', 33, 'Marketing')")
conn.commit()                                  


cursor.execute("SELECT * FROM NhanVien")
rows = cursor.fetchall()
for row in rows:
    print(row)

conn.close()