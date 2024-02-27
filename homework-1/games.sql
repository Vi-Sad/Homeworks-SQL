/* Создать таблицу игры (имя игры, дата и время сохранения),
добавить 3 любые игры,
показать все записи игр */

-- Создание таблицы "Games"
CREATE TABLE IF NOT EXISTS games(
	game TEXT NOT NULL,
	date_save TEXT,
	time_save TEXT
);

-- Добавление данных в таблицу
INSERT INTO games (game, date_save, time_save) VALUES
('Sims 4', date('now'), time('now')),
('Sims 3', date('2015-06-11'), time('199:08:55')),
('Fortnite', date('2020-03-28'), time('12:22:21')),
('Cyberpunk 2077', date('2022-11-23'), time('20:09:24')),
('The Witcher 3', date('2022-10-22'), time('now', '3 hour')),
('Detroit', date('2019-09-02', '-2 month'), time('07:12:34', '-37 minute'));

-- Сортировка таблицы по колонке "date_save"
SELECT * FROM games ORDER BY date_save
