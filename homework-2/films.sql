/* Создайте таблицу ФИЛЬМЫ
АТРИБУТЫ :
- id - первичный ключ, автоматически увеличиваемый.
- title - обязательное поле для заполнения.
- release_date - дата выхода фильма.
- genre - жанр фильма.
- duration - длительность фильма в минутах.
ЗАДАНИЕ:
- Получить список всех фильмов вместе с их названиями, датами выхода и жанрами.
- Найти фильмы, вышедшие после 2010 года.
- Получить список фильмов жанра "Фантастика".
- Найти фильмы с длительностью более 150 минут.
- Получить список фильмов, названия которых начинаются на букву "B".
- Найти фильмы жанра "Боевик", вышедшие до 2005 года.
- Найти фильмы с длительностью менее 120 минут. */

-- -----------------------------------------------------------------------------------------------------------

-- Создание таблицы "Films"
CREATE TABLE IF NOT EXISTS Films(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	title TEXT NOT NULL UNIQUE,
	release_date TEXT DEFAULT 'not found',
	genre TEXT DEFAULT 'not found',
	duration TEXT DEFAULT 'not found'
);

-- Добавление данных в таблицу
INSERT OR IGNORE INTO Films (title, release_date, genre, duration) VALUES
('Avatar: The Way of Water', DATE('2022-12-16'), 'fantastic', TIME('03:12:34')),
('Aquaman and the Lost Kingdom', DATE('2023-12-25'), 'fantastic', TIME('02:04:07')),
('Shutter Island', DATE('2010-02-19'), 'thriller', TIME('02:18:02')),
('Charlie and the Chocolate Factory', DATE('2005-08-25'), 'adventures', TIME('01:55:21')),
('Spider-Man: Across the Spider-Verse', DATE('2023-05-30'), 'cartoon', TIME('02:20:03')),
('It', DATE('2017-09-05'), 'fantasy', TIME('02:14:40')),
('A Christmas Gift from Bob', DATE('2020-11-06'), 'drama', TIME('01:32:34')),
('Apocalypto', DATE('2006-12-08'), 'action movie', TIME('02:12:39')),
('To Catch A Killer', DATE('2023-04-20'), 'action movie', TIME('01:54:22')),
('Ted', DATE('2012-06-29'), 'comedy', TIME('01:52:13')),
('Resident Evil', DATE('2002-03-15'), 'action movie', TIME('01:40:31')),
('Jurassic Park III', DATE('2001-07-16'), 'action movie', TIME('01:32:24')),
('Wonka', DATE('2023-12-15'), 'fantasy', TIME('01:57:21')),
('Bicentennial Man', DATE('1999-12-17'), 'fantasy', TIME('02:11:18')),
('Home Alone', DATE('1990-11-16'), 'comedy', TIME('01:42:52')),
('Gamer', DATE('2009-04-09'), 'fantastic', TIME('01:34:44')),
('Emma', DATE('2020-02-13'), 'melodrama', TIME('02:04:20')),
('Kingsman: The Secret Service', DATE('2014-12-13'), 'action movie', TIME('02:08:44')),
('King Kong', DATE('2005-05-12'), 'action movie', TIME('03:07:23')),
('Countdown', DATE('2019-11-21'), 'horror', TIME('01:30:19'));

-- Частичное добавление данных в таблицу
INSERT OR IGNORE INTO Films (title, genre, duration) VALUES
('The Da Vinci Code', 'detective', TIME('02:54:35'));
INSERT OR IGNORE INTO Films (title, release_date, genre) VALUES
('Corpse Bride', DATE('2005-09-16'), 'cartoon');

-- -----------------------------------------------------------------------------------------------------------

-- Список всех фильмов вместе с их названиями, датами выхода и жанрами.
SELECT * FROM Films

-- Список фильмов, вышедших после 2010 года.
-- SELECT title, release_date FROM Films WHERE strftime('%Y', release_date) > '2010'

-- Список фильмов жанра "Фантастика".
-- SELECT title FROM Films WHERE genre = 'fantastic'

-- Список фильмов с длительностью более 150 минут.
-- SELECT title, duration FROM Films WHERE
-- strftime('%H', duration) = '02' AND strftime('%M', duration) >= '30' OR
-- strftime('%H', duration) > '02'

-- Список фильмов, названия которых начинаются на букву "B".
-- SELECT title, genre FROM Films WHERE title LIKE 'B%'

-- Список фильмов жанра "Боевик", вышедших до 2005 года.
-- SELECT title, release_date FROM Films WHERE strftime('%Y', release_date) <= '2005' AND genre = 'action movie'

-- Список фильмов с длительностью менее 120 минут.
-- SELECT title, duration FROM Films WHERE strftime('%H', duration) < '02'
