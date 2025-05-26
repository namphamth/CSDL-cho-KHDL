import sqlite3
conn = sqlite3.connect('Demo.db')
cursor = conn.cursor()
cursor.execute('''
    CREATE TABLE IF NOT EXISTS NhanVien (
        MaNV INTEGER PRIMARY KEY,
        HoTen TEXT,
        Tuoi INTEGER,
        PhongBan TEXT
    )
''')
data = [
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
cursor.executemany('INSERT OR IGNORE INTO NhanVien VALUES (?, ?, ?, ?)', data)
cursor.execute('SELECT * FROM NhanVien')
all_records = cursor.fetchall()
print("Toàn bộ thông tin nhân viên:")
for record in all_records:
    print(record)
cursor.execute("SELECT HoTen, Tuoi FROM NhanVien WHERE PhongBan = 'IT'")
it_employees = cursor.fetchall()
print("\nNhân viên phòng IT:")
for employee in it_employees:
    print(employee)
cursor.execute('SELECT * FROM NhanVien WHERE Tuoi > 25')
older_employees = cursor.fetchall()
print("\nNhân viên lớn hơn 25 tuổi:")
for employee in older_employees:
    print(employee)
cursor.execute('''
    SELECT PhongBan, HoTen, Tuoi
    FROM NhanVien
    WHERE Tuoi IN (
        SELECT MAX(Tuoi)
        FROM NhanVien
        GROUP BY PhongBan
    )
''')
oldest_in_department = cursor.fetchall()
print("\nNhân viên lớn tuổi nhất mỗi phòng ban:")
for record in oldest_in_department:
    print(record)
cursor.execute("UPDATE NhanVien SET PhongBan = 'Marketing' WHERE HoTen = 'Le Van C'")
conn.commit()
print("\nĐã chuyển đổi phòng ban của 'Le Van C' sang Marketing.")
cursor.execute("DELETE FROM NhanVien WHERE MaNV = 2")
conn.commit()
cursor.execute("SELECT PhongBan, COUNT(*) AS SoLuongNhanVien FROM NhanVien GROUP BY PhongBan")
employees_per_department = cursor.fetchall()
print("\nSố lượng nhân viên trong mỗi phòng ban sau khi xóa nhân viên MaNV = 2:")
for record in employees_per_department:
    print(record)
conn.commit()
conn.close()
