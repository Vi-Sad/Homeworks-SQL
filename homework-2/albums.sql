/* Создайте таблицу "Альбомы" со следующими атрибутами:
- id - первичный ключ, автоматически увеличиваемый.
- title - обязательное поле для заполнения, название альбома.
- artist - обязательное поле для заполнения, исполнитель альбома.
- release_date - дата выпуска альбома.
- genre - жанр музыки в альбоме.
Задача:
- Получить список всех альбомов вместе с их названиями, исполнителями, датами выпуска и жанрами.
- Найти альбомы, выпущенные после 2015 года.
- Получить список альбомов жанра "Рок".
- Найти альбомы с названием, начинающимся на букву "S".
- Получить список альбомов, исполнителями которых являются "The Beatles".
- Найти альбомы жанра "Металл", выпущенные до 2010 года.
- Найти альбомы с датой выпуска после 2000 года и жанром "Поп". */

-- -----------------------------------------------------------------------------------------------------------

-- Создание таблицы "Albums"
CREATE TABLE IF NOT EXISTS Albums(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	title TEXT NOT NULL UNIQUE,
	artist TEXT NOT NULL,
	release_date TEXT DEFAULT 'not found',
	genre TEXT DEFAULT 'not found'
);

-- Добавление данных в таблицу
INSERT OR IGNORE INTO Albums (title, artist, release_date, genre) VALUES
('Minutes to Midnight', 'Linkin Park', DATE('2007-05-14'), 'rock'),
('GOLDEN', 'Jung Kook', DATE('2023-11-03'), 'pop'),
('Teenage Dream', 'Katy Perry', DATE('2010-01-01'), 'pop'),
('Born This Way', 'Lady Gaga', DATE('2011-01-01'), 'pop'),
('Waking Up', 'OneRepublic', DATE('2009-01-01'), 'rock'),
('METAL RESISTANCE', 'BABYMETAL', DATE('2016-04-01'), 'metal'),
('Let It Be', 'The Beatles', DATE('1970-05-08'), 'rock'),
('Abbey Road', 'The Beatles', DATE('1969-09-26'), 'rock'),
('Bloom', 'Troye Sivan', DATE('2018-08-30'), 'pop'),
('Thriller 25 Super Deluxe Edition', 'Michael Jackson', DATE('1982-11-30'), 'pop'),
('PRISM', 'Katy Perry', DATE('2013-10-22'), 'pop'),
('Origins (Deluxe)', 'Imagine Dragons', DATE('2018-11-08'), 'rock'),
('Out Of Time (25th Anniversary Edition)', 'R.E.M.', DATE('1991-03-12'), 'rock'),
('Meliora (Deluxe Edition)', 'Ghost', DATE('2016-09-15'), 'metal'),
('Yellow Submarine', 'The Beatles', DATE('1966-08-05'), 'pop'),
('The Search for Everything', 'John Mayer', DATE('2017-04-13'), 'rock'),
('Meteora 20th Anniversary Edition', 'Linkin Park', DATE('2023-04-07'), 'metal'),
('Meteora (Bonus Track Version)', 'Linkin Park', DATE('2003-03-24'), 'metal'),
('Justified', 'Justin Timberlake', DATE('2002-11-04'), 'pop'),
('Born to Die (The Paradise Edition)', 'Lana Del Rey', DATE('2012-11-09'), 'pop'),
('Educated Horses', 'Rob Zombie', DATE('2006-01-01'), 'metal'),
('Camp Kill Yourself, Vol.1', 'CKY', DATE('1999-01-01'), 'metal'),
('Servant of the Mind (Deluxe)', 'Volbeat', DATE('2021-12-03'), 'metal');

-- Добавление не полных данных в таблицу
INSERT OR IGNORE INTO Albums (title, artist, release_date) VALUES
('The Long Road', 'Nickelback', DATE('2003-09-14')),
('SHOOTING STAR', 'XG', DATE('2023-01-25'));
INSERT OR IGNORE INTO Albums (title, artist, genre) VALUES
('A Decade Of Destruction', 'Five Finger Death Punch', 'metal');

-- -----------------------------------------------------------------------------------------------------------

-- Список всех альбомов вместе с их названиями, исполнителями, датами выпуска и жанрами.
SELECT * FROM Albums

-- Список альбомов, выпущенных после 2015 года.
-- SELECT title, artist, release_date FROM Albums WHERE strftime('%Y', release_date) > '2015'

-- Список альбомов жанра "Рок".
-- SELECT title, artist FROM Albums WHERE genre = 'rock'

-- Список альбомов с названием, начинающимся на букву "S".
-- SELECT title, artist, genre FROM Albums WHERE title LIKE 'S%'

-- Список альбомов, исполнителями которых являются "The Beatles".
-- SELECT title, genre, release_date FROM Albums WHERE artist = 'The Beatles'

-- Список альбомов жанра "Металл", выпущенных до 2010 года.
-- SELECT title, artist, release_date FROM Albums WHERE
-- genre = 'metal' AND
-- strftime('%Y', release_date) < '2010'

-- Список альбомов с датой выпуска после 2000 года и жанром "Поп".
-- SELECT title, artist, release_date FROM Albums WHERE 
-- genre = 'pop' AND
-- strftime('%Y', release_date) > '2000'