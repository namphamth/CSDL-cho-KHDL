import sqlite3

conn = sqlite3.connect('bai_tap_chuong_01.db')
cursor = conn.cursor()

#1. Tạo bảng NhanVien
cursor.execute('''
               CREATE TABLE IF NOT EXISTS NhanVien (
                   MaNV INTEGER PRIMARY KEY,
                   HoTen VARCHAR(50),
                   Tuoi INTEGER,
                   PhongBan VARCHAR(50)
                   )
                   ''')

#2. Chèn các bản ghi vào bảng
cursor.execute('''
                   INSERT INTO NhanVien (MaNV, HoTen, Tuoi, PhongBan)
                   VALUES (1, 'Nguyen Van A', 30, 'Ke Toan'),
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
                       ''')

#3. Lấy toàn bộ thông tin của nhân viên trong bảng NhanVien
cursor.execute("SELECT * FROM NhanVien")
rows = cursor.fetchall()
print('Danh sách thông tin của nhân viên:')
for row in rows:
    print(row)
    
#4. Truy vấn HoTen và Tuoi của các nhân viên trong phòng IT
cursor.execute("SELECT HoTen, Tuoi FROM NhanVien WHERE PhongBan = 'IT'")
nv_it = cursor.fetchall()
print("\nNhân viên phòng IT:")
for it in nv_it:
    print(it)
    
#5. Tìm nhân viên có độ tuổi lớn hơn 25
cursor.execute("SELECT * FROM NhanVien WHERE Tuoi > 25")
over_25 = cursor.fetchall()
print("\nNhân viên có độ tuổi lớn hơn 25:")
for o25 in over_25:
    print(o25)
    
#6. Cho biết nhân viên lớn tuổi nhất của các PhongBan
cursor.execute('''SELECT PhongBan, HoTen, MAX(Tuoi)
                   FROM NhanVien
                   GROUP BY PhongBan
                   ''')
nv_lon_tuoi = cursor.fetchall()
print('\nNhân viên lớn tuổi nhất của mỗi phòng ban:')
for oldest in nv_lon_tuoi:
    print(oldest)
    
#7. Chuyển đổi thông tin PhongBan của nhân viên “Le Van C” sang “Marketing” 
cursor.execute("UPDATE NhanVien SET PhongBan = 'Marketing' WHERE HoTen = 'Le Van C'")
cursor.execute("SELECT * FROM NhanVien WHERE HoTen = 'Le Van C'")
doi_phongban = cursor.fetchall()
print('\nThông tin của nhân viên Le Van C sau khi thay đổi:')
for change in doi_phongban:
    print(change)
print('''Như vậy, không có vấn đề gì gặp phải khi thực hiện chuyển đổi thông tin
Tuy nhiên, thuộc tính của HoTen không unique nên có thể có trường hợp bị trùng tên Le Van C
Vậy thì ta sẽ phải thêm điều kiện MaNV = 3 để cập nhật chính xác nhân viên''')

#8. Xóa nhân viên có “MaSV = 2” rồi cho biết mỗi phòng ban có bao nhiêu người
cursor.execute("DELETE FROM NhanVien WHERE MaNV = 2")
cursor.execute("SELECT PhongBan, COUNT(*) FROM NhanVien GROUP BY PhongBan")
so_nv_moi_phongban = cursor.fetchall()
print("\nSố lượng nhân viên của mỗi phòng ban:")
for nv in so_nv_moi_phongban:
    print(nv)

conn.commit()
cursor.close()
conn.close()
