/*
Задание
 
Описание:
В базе данных должна: 
	1. Содержать информацию о доступных курсах, включая их названия, описания и продолжительность.
	2. Хранить данные о студентах, которые записаны на курсы. Это включает в себя их идентификаторы, имена и электронные адреса.
	3. Содержать информацию о преподавателях, которые ведут эти курсы. Каждый преподаватель имеет свой уникальный идентификатор и имя.

10 запросов:
	1. Получить список всех курсов.
	2. Получить список студентов, записанных на определённый курс.
	3. Получить список всех преподавателей.
	4. Получить информацию о курсе по его названию.
	5. Получить список всех студентов.
	6. Получить список курсов, на которых учит конкретный преподаватель.
	7. Получить список курсов, продолжительность которых больше 20 часов.
	8. Получить список студентов с указанием их электронной почты.
	9. Получить информацию о преподавателе по его имени.
	10. Получить список студентов, записанных на курс по его идентификатору.
*/

-- ----------------------------------------------------------------------------------------------------

-- Создание таблицы "Students"
CREATE TABLE IF NOT EXISTS 
	Students(
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		name TEXT NOT NULL UNIQUE,
		email TEXT DEFAULT 'no email');
		
-- Создание таблицы "Teachers"
CREATE TABLE IF NOT EXISTS 
	Teachers(
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		name TEXT NOT NULL UNIQUE);

-- Создание таблицы "Courses"
CREATE TABLE IF NOT EXISTS 
	Courses(
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		id_teacher INTEGER NOT NULL,
		course TEXT NOT NULL UNIQUE,
		duration_in_hours INTEGER DEFAULT 'not defined',
		FOREIGN KEY (id_teacher) REFERENCES Teachers(id));

-- Создание таблицы "Sorting"
CREATE TABLE IF NOT EXISTS 
	Sorting(
		id INTEGER PRIMARY KEY UNIQUE,
		id_student INTEGER NOT NULL,
		id_course INTEGER NOT NULL,
		FOREIGN KEY (id_student) REFERENCES Students(id),
		FOREIGN KEY (id_course) REFERENCES Courses(id));

-- ----------------------------------------------------------------------------------------------------

-- Добавление студентов
INSERT OR IGNORE INTO
	Students (name, email)
VALUES
	('Adam Jensen', 'adam.jensen@gmail.com'),
	('Judy Alvarez', 'judy.alvarez2077@gmail.com'),
	('John Richards', 'j.richards5@gmail.com'),
	('Vincent Li', 'vi.li@gmail.com'),
	('Max Williams', 'max.williams@gmail.com'),
	('Jessie Carter', 'jes.carter@gmail.com'),
	('Ronald Parker', 'parker.ron.2001@gmail.com'),
	('Mary Black', 'mary.black@gmail.com'),
	('Ryan Hill', 'ryan.hill@gmail.com');

-- Добавление студентов без указания электронной почты
INSERT OR IGNORE INTO
	Students (name)
VALUES
	('Leo Nelson'), ('Eva Brown'), ('Ben Miller');

-- Добавление преподавателей
INSERT OR IGNORE INTO
	Teachers (name)
VALUES
	('Mr. Peterson'), ('Mrs. Adams'), ('Mr. Taylor');

-- Добавление курсов и прикрепленного к ним преподавателя
INSERT OR IGNORE INTO 
	Courses (course, duration_in_hours, id_teacher)
VALUES
	('English for manager', 30, 1),
	('The formula for successful sales', 45, 2),
	('Change Management', 20, 1),
	('Developing a chatbot in JavaScript', 9, 3),
	('Getting to know conditional operators in Python', 6, 2);

-- Добавление и сортирование студентов по курсам
INSERT OR IGNORE INTO 
	Sorting (id, id_student, id_course)
VALUES
	(1, 1, 1), (2, 2, 4), (3, 3, 2), (4, 1, 4), (5, 12, 3),
	(6, 8, 5), (7, 7, 5), (8, 6, 4), (9, 5, 5), (10, 9, 1),
	(11, 4, 1), (12, 5, 1), (13, 6, 5), (14, 4, 5), (15, 7, 2),
	(16, 8, 2), (17, 9, 3), (18, 2, 2), (19, 3, 5), (20, 10, 4),
	(21, 11, 5), (22, 10, 1), (23, 7, 3), (24, 11, 4), (25, 9, 5),
	(26, 12, 2), (27, 5, 2), (28, 3, 3), (29, 1, 1), (30, 1, 5);

-- ----------------------------------------------------------------------------------------------------

-- Полный список таблицы
SELECT
	Sorting.id,
	Courses.course,
	Courses.duration_in_hours,
	Teachers.id AS 'id_teacher',
	Teachers.name AS 'teacher',
	Students.id AS 'id_student',
	Students.name AS 'student',
	Students.email
FROM
	Sorting
JOIN
	Students ON Sorting.id_student = Students.id
JOIN
	Teachers ON Courses.id_teacher = Teachers.id
JOIN
	Courses ON Sorting.id_course = Courses.id

-- 1. Список всех курсов
/*
SELECT
	id,
	course,
	duration_in_hours
FROM
	Courses
*/

-- 2. Список студентов, записанных на определённый курс
/*
SELECT
	Students.id AS 'id_student',
	Students.name AS 'student',
	Courses.course
FROM
	Sorting
JOIN
	Students ON Sorting.id_student = Students.id
JOIN 
	Courses ON Sorting.id_course = Courses.id
ORDER BY
	Students.id
*/

-- 3. Cписок всех преподавателей
/*
SELECT
	id AS 'id_teacher',
	name AS 'teacher'
FROM
	Teachers
*/

-- 4. Информация о курсе по его названию
/*
SELECT
	id,
	course,
	duration_in_hours
FROM 
	Courses
WHERE
	course = 'Developing a chatbot in JavaScript'
*/

-- 5. Список всех студентов
/*
SELECT
	id AS 'id_student',
	name AS 'student',
	email
FROM
	Students
*/

-- 6. Список курсов, на которых учит конкретный преподаватель
/*
SELECT
	Courses.course,
	Courses.id_teacher,
	Teachers.name AS 'teacher'
FROM
	Courses
JOIN
	Teachers ON Courses.id_teacher = Teachers.id
WHERE
	Courses.id_teacher = 2
*/

-- 7. Список курсов, продолжительность которых больше 20 часов
/*
SELECT 
	id,
	course,
	duration_in_hours
FROM
	Courses
WHERE
	duration_in_hours >= 20
*/

-- 8. Список студентов с указанием их электронной почты
/*
SELECT 
	id AS 'id_student',
	name AS 'student',
	email
FROM 
	Students 
WHERE 
	email != 'no email'
*/

-- 9. Информация о преподавателе по его имени
/*
SELECT 
	id AS 'id_teacher', 
	name AS 'teacher' 
FROM 
	Teachers 
WHERE 
	name = 'Mr. Peterson'
*/

-- 10. Список студентов, записанных на курс по его идентификатору
/*
SELECT
	Students.id AS 'id_student',
	Students.name AS 'student',
	Students.email,
	Courses.course
FROM
	Sorting
JOIN
	Students ON Sorting.id_student = Students.id
JOIN
	Courses ON Sorting.id_course = Courses.id
WHERE 
	Sorting.id_course = 3
ORDER BY
	Students.id
*/
