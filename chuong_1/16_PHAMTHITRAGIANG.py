import sqlite3
#Kết nối đến database
conn = sqlite3.connect("NhanVien.db")
cursor = conn.cursor()
#Tạo bảng
cursor.execute("""
    CREATE TABLE IF NOT EXISTS NhanVien(
        MaNV INTEGER PRIMARY KEY,
        HoTen TEXT NOT NULL,
        Tuoi INTEGER NOT NULL,
        PhongBan TEXT NOT NULL
    )
""")
conn.commit()

# Xóa dữ liệu cũ (để chạy nhiều lần mà không lỗi)
cursor.execute("DELETE FROM NhanVien")

# Chèn dữ liệu vào bảng
nhan_vien_data = [
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
    (15, 'Hoang Thi O', 27, 'IT')
]

cursor.executemany("INSERT INTO NhanVien (MaNV, HoTen, Tuoi, PhongBan) VALUES (?, ?, ?, ?)", nhan_vien_data)
conn.commit()

#Truy vấn dữ liệu
#Lấy toàn bộ thông tin của nhân viên trong bảng NhanVien
cursor.execute("SELECT * FROM NhanVien")
rows = cursor.fetchall()
print("📌 Danh sách tất cả nhân viên:")
for row in rows:
    print(row)

# Truy vấn HoTen và Tuoi của các nhân viên trong phòng IT.
cursor.execute("SELECT HoTen, Tuoi FROM NhanVien WHERE PhongBan = 'IT'")
rows = cursor.fetchall()
print("\n📌 Nhân viên phòng IT:")
for row in rows:
    print(row)

# Lọc nhân viên có tuổi > 25
cursor.execute("SELECT * FROM NhanVien WHERE Tuoi > 25")
rows = cursor.fetchall()
print("\n📌 Nhân viên có tuổi lớn hơn 25:")
for row in rows:
    print(row)

# Nhân viên lớn tuổi nhất của mỗi phòng ban
cursor.execute("""
    SELECT PhongBan, HoTen, Tuoi
    FROM NhanVien
    WHERE Tuoi IN (SELECT MAX(Tuoi) FROM NhanVien GROUP BY PhongBan)
""")
rows = cursor.fetchall()
print("\n📌 Nhân viên lớn tuổi nhất của mỗi phòng ban:")
for row in rows:
    print(row)

#  Cập nhật phòng ban của nhân viên "Le Van C" thành "Marketing"
cursor.execute("UPDATE NhanVien SET PhongBan = 'Marketing' WHERE HoTen = 'Le Van C'")
conn.commit()
#Không có vấn đề gì gặp phải khi thực hiện chuyển đổi thông tin

# Xóa nhân viên có MaNV = 2
cursor.execute("DELETE FROM NhanVien WHERE MaNV = 2")
conn.commit()

# Đếm số lượng nhân viên theo phòng ban
cursor.execute("""
    SELECT PhongBan, COUNT(*) AS SoLuongNhanVien
    FROM NhanVien
    GROUP BY PhongBan
""")
rows = cursor.fetchall()
print("\n📌 Số lượng nhân viên theo từng phòng ban:")
for row in rows:
    print(row)

# Đóng kết nối sau khi thực hiện xong tất cả truy vấn
conn.close()