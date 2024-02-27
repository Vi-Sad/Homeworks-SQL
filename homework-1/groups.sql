/* Создать таблицу группа (имя, рейтинг, курс),
добавить 3 любые группы,
показать группы (имя, рейтинг и курс), рейтинг которых меньше либо равен 50 */

-- Создание таблицы "Groups"
CREATE TABLE IF NOT EXISTS groups(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL UNIQUE,
	rating INTEGER NOT NULL,
	course TEXT DEFAULT 'undefined' -- использовать по умолчанию, если значения не существует
);

-- Добавление всех данных в таблицу
INSERT OR IGNORE INTO groups (name, rating, course) VALUES
('Adam', 100, 'B-41'),
('Jessie', 50, 'AS-31'),
('Max', 32, 'P-11');
-- Добавление данных в таблицу, без указания значений в колонку "course"
INSERT OR IGNORE INTO groups (name, rating) VALUES
('Ryan', 46),
('John', 102);

-- Вывод таблицы в консоль
SELECT * FROM groups WHERE rating <= 50;