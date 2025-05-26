DROP TABLE IF EXISTS student, course;

-- Tạo bảng course
CREATE TABLE course (
    id INTEGER PRIMARY KEY,
    course_name NVARCHAR(255) NOT NULL  -- Sửa TEXT thành NVARCHAR(255)
);

-- Chèn dữ liệu vào bảng course
INSERT INTO course (id, course_name) VALUES
(12, 'Giai tich'),
(34, 'Thong ke'),
(26, 'Tin hoc');

-- Tạo bảng student
CREATE TABLE student (
    student_id INTEGER PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    class NVARCHAR(255) NOT NULL,
    course_id INTEGER,
    score REAL
);

-- Chèn dữ liệu vào bảng student
INSERT INTO student (student_id, name, class, course_id, score) VALUES
(1, 'Nguyen Minh Hoang', 'May Tinh', 12, 6.7),
(2, 'Tran Thi Lan', 'Kinh Te', 34, 9.2),
(3, 'Pham Van Nam', 'Toan Tin', NULL, 7.9),
(4, 'Le Thanh Huyen', 'Toan Tin', 20, 7.2),
(5, 'Vu Quoc Anh', 'May Tinh', 24, 8.0),
(6, 'Dang Thuy Linh', 'May Tinh', 24, 5.5),
(7, 'Bui Tien Dung', 'Kinh Te', 34, 9.2),
(8, 'Ho Ngoc Mai', 'Toan Tin', 20, 8.8),
(9, 'Duong Huu Phuc', 'Kinh Te', NULL, 7.2),
(10, 'Cao Thi Hanh', 'May Tinh', NULL, 7.0);

---1.
-- Tích Descartes (Cross Join)
SELECT * FROM student CROSS JOIN course;

-- INNER JOIN 
SELECT student.*, course.course_name 
FROM student 
INNER JOIN course ON student.course_id = course.id;

-- LEFT JOIN 
SELECT student.*, course.course_name 
FROM student 
LEFT JOIN course ON student.course_id = course.id;

-- RIGHT JOIN 
SELECT student.*, course.course_name 
FROM student 
RIGHT JOIN course ON student.course_id = course.id;

-- FULL OUTER JOIN 
SELECT student.*, course.course_name 
FROM student 
FULL OUTER JOIN course ON student.course_id = course.id;


--- 2.

UPDATE student
SET course_id = 
    CASE 
        WHEN class = 'Toan Tin' THEN 12
        WHEN class = 'Kinh Te' THEN 34
        WHEN class = 'May Tinh' THEN 26
        ELSE NULL
    END
WHERE course_id IS NULL;

SELECT * FROM student;



-- Xóa sinh viên có course_id không tồn tại
DELETE FROM student 
WHERE course_id IS NOT NULL 
AND course_id NOT IN (SELECT id FROM course);
SELECT * FROM student;

-- Thống kê số lượng sinh viên và điểm trung bình theo lớp
SELECT class, COUNT(*) AS total_students, AVG(score) AS avg_score
FROM student
GROUP BY class;

-- Thống kê số lượng sinh viên và điểm trung bình theo môn học
SELECT course.course_name, COUNT(student.student_id) AS total_students, AVG(student.score) AS avg_score
FROM student
LEFT JOIN course ON student.course_id = course.id
GROUP BY course.course_name;

-- Phân loại học lực
SELECT name, score,
    CASE 
        WHEN score >= 9.0 THEN 'Xuat sac'
        WHEN score >= 6.0 THEN 'Tot'
        ELSE 'Kem'
    END AS ranking
FROM student;


---3.

--Điểm số
SELECT 
    student_id, 
    name, 
    class, 
    course_id, 
    score,
    ROW_NUMBER() OVER (ORDER BY score DESC) AS rank_continuous
FROM student;
--top 3 cao nhất
SELECT TOP 3 student_id, name, class, score
FROM student
ORDER BY score DESC;
--top 3 thấp nhất
SELECT TOP 3 student_id, name, class, score
FROM student
ORDER BY score ASC;

--Điểm số theo lớp hoc
SELECT 
    student_id, 
    name, 
    class, 
    score,
    RANK() OVER (PARTITION BY class ORDER BY score DESC) AS rank_in_class
FROM student
ORDER BY class, rank_in_class;

--top 3 cao nhất
WITH RankedStudents AS (
    SELECT student_id, name, class, score,
           RANK() OVER (PARTITION BY class ORDER BY score DESC) AS rank_position
    FROM student
)
SELECT student_id, name, class, score, rank_position
FROM RankedStudents
WHERE rank_position <= 3
ORDER BY class, rank_position;

--top 3 thấp nhất
WITH RankedStudents AS (
    SELECT student_id, name, class, score,
           RANK() OVER (PARTITION BY class ORDER BY score ASC) AS rank_position
    FROM student
)
SELECT student_id, name, class, score, rank_position
FROM RankedStudents
WHERE rank_position <= 3
ORDER BY class, rank_position;


-- Điểm số theo môn học
SELECT 
    student_id, 
    name, 
    class, 
    student.course_id, 
    course.course_name, 
    score,
    RANK() OVER (PARTITION BY student.course_id ORDER BY score DESC) AS rank_in_course
FROM student
LEFT JOIN course ON student.course_id = course.id
ORDER BY student.course_id, rank_in_course;
--top 3 thấp nhất
WITH RankedStudents AS (
    SELECT student_id, name, course_id, score,
           RANK() OVER (PARTITION BY course_id ORDER BY score ASC) AS rank_position
    FROM student
)
SELECT student_id, name, course_id, score, rank_position
FROM RankedStudents
WHERE rank_position <= 3
ORDER BY course_id, rank_position;
-- top 3 cao nhất
WITH RankedStudents AS (
    SELECT student_id, name, course_id, score,
           RANK() OVER (PARTITION BY course_id ORDER BY score DESC) AS rank_position
    FROM student
)
SELECT student_id, name, course_id, score, rank_position
FROM RankedStudents
WHERE rank_position <= 3
ORDER BY course_id, rank_position;


---4.
-- Thêm cột graduation_date nếu chưa có
ALTER TABLE student
ADD graduation_date DATETIME;

-- Cập nhật ngày tốt nghiệp dựa trên xếp hạng điểm số
UPDATE student
SET graduation_date = DATEADD(YEAR, rank_position, GETDATE())
FROM (
    SELECT student_id, 
           RANK() OVER (ORDER BY score DESC) AS rank_position
    FROM student
) AS ranked_students
WHERE student.student_id = ranked_students.student_id;

SELECT * FROM student;
