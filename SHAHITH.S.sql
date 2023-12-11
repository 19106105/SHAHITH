CREATE DATABASE sisdb;

USE sisdb;
CREATE TABLE student(
student_id VARCHAR (10)NOT NULL,
first_name VARCHAR(20) NOT NULL,
last_name VARCHAR(20) NOT NULL,
date_of_birth DATE,
email VARCHAR(20) NOT NULL,
phone_number VARCHAR(20) NOT NULL,
PRIMARY KEY (student_id)
);
USE sisdb;
CREATE TABLE course(
course_id VARCHAR (10) NOT NULL,
course_name VARCHAR(20) NOT NULL,
credits INT NOT NULL,
teacher_id VARCHAR(10) NOT NULL,
PRIMARY KEY (course_id),
FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id)
);
USE sisdb;
CREATE TABLE enrollment(
enrollment_id VARCHAR (10)NOT NULL,
student_id VARCHAR(20) NOT NULL,
course_id VARCHAR(20) NOT NULL,
enrollment_date DATE,
PRIMARY KEY (enrollment_id),
FOREIGN KEY (student_id) REFERENCES student(student_id),
FOREIGN KEY (course_id) REFERENCES course(course_id)
);

USE sisdb;
CREATE TABLE teacher(
teacher_id VARCHAR (10)NOT NULL,
first_name VARCHAR(20) NOT NULL,
last_name VARCHAR(20) NOT NULL,
email VARCHAR(20) NOT NULL,
PRIMARY KEY (teacher_id)
);


USE sisdb;
CREATE TABLE payment(
payment_id VARCHAR (10)NOT NULL,
student_id VARCHAR(20) NOT NULL,
amount VARCHAR(20) NOT NULL,
payment_date DATE,
PRIMARY KEY (payment_id),
FOREIGN KEY (student_id) REFERENCES student(student_id)
);

INSERT INTO student(student_id, first_name, last_name, date_of_birth, email, phone_number)
VALUES
('s1','John','Moxley','2001-06-20','mox@gmail.com',9476824340),
('s2','Rowan','Atkinson','2001-05-13','rowan@gmail.com',9342354673),
('s3','Eddie','Gurrero','2001-01-03','eddie@gmail.com',9677836453),
('s4','David','Beckham','2001-02-20','david@gmail.com',9423173863),
('s5','Robert','Junior','2001-07-10','robert@gmail.com',9534423256),
('s6','Carl','Anderson','2001-10-06','carl@gmail.com',9768035467),
('s7','Michael','Cole','2001-08-11','michael@gmail.com',9087654767),
('s8','Roy','Mathew','2001-07-05','roy@gmail.com',9875675678),
('s9','Chelsea','Green','2001-05-05','chelsea@gmail.com',9076563453),
('s10','Jack','Morison','2001-11-20','jack@gmail.com',9876526470);
INSERT INTO teacher(teacher_id, first_name, last_name, email)
VALUES
('t1','Leana','Brooke','leana@gmail.com'),
('t2','Teena','Paul','teena@gmail.com'),
('t3','Megan','Knox','megan@gmail.com'),
('t4','laula','George','laula@gmail.com'),
('t5','Mich','Luke','mich@gmail.com'),
('t6','Jacob','Downey','jacob@gmail.com'),
('t7','Laura','Grace','laura@gmail.com'),
('t8','Baron','Corbin','baron@gmail.com'),
('t9','Cayla','Ruke','cayla@gmail.com'),
('t10','Bruce','Baner','bruce@gmail.com');

INSERT INTO course(course_id,course_name,credits,teacher_id)
VALUES
('c1','python', 09,'t1'),
('c2','java', 07,'t2'),
('c3','sql', 08,'t3'),
('c4','web development', 07,'t4'),
('c5','cybersecurity', 08,'t5'),
('c6','networking', 07,'t6'),
('c7','DevOps', 09,'t7'),
('c8','Cloud computing', 08,'t8'),
('c9','Database Management', 09,'t9'),
('c10','Javascript', 08,'t10');

INSERT INTO enrollment(enrollment_id,student_id,course_id,enrollment_date)
VALUES
('e1','s1','c1','2023-06-20'),
('e2','s2','c2','2023-07-17'),
('e3','s3','c3','2023-06-11'),
('e4','s4','c4','2023-05-21'),
('e5','s5','c5','2023-06-11'),
('e6','s6','c6','2023-07-06'),
('e7','s7','c7','2023-05-03'),
('e8','s8','c8','2023-06-05'),
('e9','s9','c9','2023-07-13'),
('e10','s10','c10','2023-05-10');
select*from enrollment;
INSERT INTO payment(payment_id,student_id,amount,payment_date)
VALUES
('p1','s1','10,000','2023-06-30'),
('p2','s2','9,000','2023-07-27'),
('p3','s3','15,000','2023-06-21'),
('p4','s4','12,000','2023-06-01'),
('p5','s5','18,000','2023-06-21'),
('p6','s6','25,000','2023-07-16'),
('p7','s7','18,000','2023-05-13'),
('p8','s8','30,000','2023-06-15'),
('p9','s9','11,000','2023-07-23'),
('p10','s10','8,000','2023-05-20');

INSERT INTO student(student_id, first_name, last_name,date_of_birth, email,phone_number)
VALUES('s11','John','Doe','1995-08-15','john.doe@example.com','1234567890');


INSERT INTO enrollment(enrollment_id,student_id, course_id,enrollment_date)
VALUES('e11','s11','c10','2023-07-10');

UPDATE teacher
SET email= 'teena.paul@gmail.com'
WHERE teacher_id='t2';

DELETE FROM enrollment
WHERE enrollment_id = 'e11';

INSERT INTO course(course_id,course_name,credits,teacher_id)
VALUES('c11','c++','08','t9');

DELETE FROM Enrollment
WHERE student_id = 's8';
DELETE FROM payment
WHERE student_id = 's8';
DELETE FROM student
WHERE student_id = 's8';

UPDATE payment
SET amount=23000
WHERE payment_id= 'p6';

SELECT student.first_name, payment.amount
FROM student INNER JOIN payment
ON student.student_id=payment.student_id;

SELECT course.course_id,course.course_name, COUNT(enrollment.student_id) AS enrolled_students
FROM course
LEFT JOIN enrollment ON course.course_id=enrollment.course_id
GROUP BY course.course_id,course.course_name
ORDER BY enrolled_students DESC;

SELECT course.course_id,course.course_name, COUNT(student.student_id) AS enrolled_students
FROM course
LEFT JOIN enrollment AS enrollment ON course.course_id=enrollment.course_id
LEFT JOIN student AS student ON enrollment.student_id=student.student_id
GROUP BY course.course_id,course.course_name
HAVING COUNT(student.student_id)=0;

SELECT student.first_name,student.last_name,course.course_name
FROM student INNER JOIN enrollment ON student.student_id=enrollment.student_id
INNER JOIN course ON enrollment.course_id=course.course_id;

SELECT teacher.first_name, teacher.last_name,course.course_name
FROM teacher INNER JOIN course
ON teacher.teacher_id=course.teacher_id;

SELECT student.first_name,student.last_name,enrollment.enrollment_date,course.course_name
FROM student INNER JOIN enrollment ON student.student_id=enrollment.student_id
INNER JOIN course ON enrollment.course_id=course.course_id;

SELECT student.first_name
FROM student
LEFT JOIN payment ON student.student_id=payment.student_id
WHERE payment.payment_id IS NULL;

SELECT course.course_name
FROM course
LEFT JOIN enrollment ON enrollment.course_id=course.course_id
WHERE enrollment.enrollment_id IS NULL;

SELECT DISTINCT E1.student_id,student.first_name,student.last_name
FROM enrollment E1
JOIN enrollment E2 ON E1.student_id=E2.student_id 
AND E1.course_id<>E2.course_id
JOIN student ON E1.student_id=student.student_id; 

SELECT teacher.teacher_id,teacher.first_name
FROM teacher
LEFT JOIN course ON teacher.teacher_id=course.teacher_id
WHERE course_id IS NULL;

SELECT course.course_id,course.course_name, AVG (enrollment.student_id) AS average_students
FROM course 
INNER JOIN (
    SELECT student_id, COUNT(*) AS enrolled_courses
    FROM enrollment
    GROUP BY student_id
) AS enrollment ON course.course_id= enrollment.enrolled_courses
GROUP BY course.course_id,course.course_name;

SELECT student.first_name, payment.amount
FROM student
INNER JOIN payment ON student.student_id=payment.student_id
WHERE payment.amount=(
     SELECT MAX(amount)
     FROM payment
);

SELECT course.course_id, course.course_name, COUNT(*) AS enrolled_students
FROM course
INNER JOIN enrollment ON course.course_id=enrollment.course_id
GROUP BY course.course_id, course.course_name
HAVING COUNT(*) =(
   SELECT MAX(enrolled_count)
   FROM(
        SELECT course.course_id, COUNT(*) AS enrolled_count
        FROM course
        INNER JOIN enrollment
        GROUP BY course.course_id
        ) AS sub_query
);

SELECT teacher.teacher_id, teacher.first_name,SUM(payment.amount) AS total_amount
FROM teacher
INNER JOIN course ON teacher.teacher_id= course.teacher_id
INNER JOIN enrollment ON course.course_id=enrollment.course_id
INNER JOIN payment ON enrollment.student_id=payment.student_id
GROUP BY teacher.teacher_id, teacher.first_name;
   
   SELECT student.student_id, student.first_name
FROM student
INNER JOIN (
     SELECT COUNT(*) AS total_courses
     FROM course
     )AS course ON(
     SELECT COUNT(*) AS enrolled_courses
     FROM enrollment
     WHERE enrollment.student_id=student.student_id
     )=course.total_courses;
     
     
     SELECT  teacher.first_name
FROM teacher
WHERE NOT EXISTS(
     SELECT 1
     FROM course
     WHERE course.teacher_id=teacher.teacher_id
);

SELECT AVG (age) AS average_age
FROM(
    SELECT student_id, datediff(CURDATE(),date_of_birth)/365.25 AS age
    FROM student
) AS student_ages;

SELECT course.course_name
FROM course
WHERE NOT EXISTS(
      SELECT 1
      FROM enrollment
      WHERE enrollment.course_id=course.course_id
);

SELECT student.student_id, student.first_name,course.course_id,course.course_name,
SUM(payment.amount) AS total_payment
FROM student
INNER JOIN enrollment ON student.student_id=enrollment.student_id
INNER JOIN course ON course.course_id=enrollment.course_id
INNER JOIN payment ON payment.student_id=enrollment.student_id
GROUP BY student.student_id,student.first_name,course.course_id,course.course_name;

SELECT student.student_id,student.first_name, COUNT(*) AS total_payments
FROM student
INNER JOIN  payment ON student.student_id=payment.student_id
GROUP BY student.student_id, student.first_name
HAVING COUNT(*)>1;

SELECT student.student_id,student.first_name, SUM(payment.amount) AS total_payments
FROM student
INNER JOIN  payment ON student.student_id=payment.student_id
GROUP BY student.student_id, student.first_name;

SELECT course.course_name, COUNT(*) AS enrolled_students
FROM course
INNER JOIN enrollment ON course.course_id=enrollment.course_id
GROUP BY course.course_name
ORDER BY enrolled_students DESC;

SELECT AVG(payment.amount) AS average_payment
FROM student
INNER JOIN payment ON student.student_id=payment.student_id;
