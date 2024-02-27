/* Создать таблицу врачи (имя, должность, ставка),
добавить 3 любых врача,
показать всех врачей (имя должность ставка), должность которых равна Хирург */

-- Create table Doctors
CREATE TABLE IF NOT EXISTS doctors(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL UNIQUE,
	post TEXT NOT NULL,
	bet INTEGER
);

-- Create values in a table
INSERT OR IGNORE INTO doctors (name, post, bet) VALUES 
('Petrov', 'surgeon', 1000),
('Ivanov', 'surgeon', 1300),
('Macarov', 'dentist', 1500),
('Volkov', 'dentist', 1700),
('Kuznetsov', 'surgeon', 900);

-- Withdrawal of all doctors with the position of "surgeon"
SELECT * FROM doctors WHERE post = 'surgeon';
