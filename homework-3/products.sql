/* Задание: Анализ продуктов

Создайте таблицу "Products" со следующими столбцами:
- product_id - идентификатор продукта (уникальный ключ)
- category_id - идентификатор категории продукта
- product_name - название продукта
- price - цена продукта
- quantity - количество продукта на складе
- date_added - дата добавления продукта в ассортимент магазина

Вам нужно выполнить любые 5 запросов:
- Определить общее количество продуктов в магазине.
- Рассчитать среднюю цену продукта.
- Определить количество продуктов в каждой категории.
- Найти самый дорогой продукт.
- Рассчитать общее количество продуктов на складе.
- Найти среднее количество дней между добавлением продукта в ассортимент магазина и текущей датой.
- Определить месяц с наибольшим числом добавлений новых продуктов. */

-- ----------------------------------------------------------------------------------------------------

-- Создание таблицы "Categories"
CREATE TABLE IF NOT EXISTS 
	Categories( 
		product_id INTEGER PRIMARY KEY AUTOINCREMENT,
		product_name TEXT NOT NULL UNIQUE);

-- Создание таблицы "Products"
CREATE TABLE IF NOT EXISTS 
	Products( 
		product_id INTEGER PRIMARY KEY AUTOINCREMENT,
		category_id INTEGER,
		product_name TEXT NOT NULL UNIQUE,
		price REAL NOT NULL,
		quantity INTEGER DEFAULT 'not found',
		date_added TEXT DEFAULT 'not found',
		FOREIGN KEY (category_id) REFERENCES Categories(product_id));

-- ----------------------------------------------------------------------------------------------------

-- Добавление категорий продуктов
INSERT OR IGNORE INTO 
	Categories (product_name) 
VALUES
	('vegetable'), ('fruit'), ('dairy');

-- Добавление продуктов
INSERT OR IGNORE INTO 
	Products (category_id, product_name, price, quantity, date_added) 
VALUES
	(1, 'Carrot', 7.4, 143, date('2024-01-16')),
	(2, 'Apple', 27.7, 124, date('2024-01-20')),
	(2, 'Orange', 30.1, 90, date('2024-02-19')),
	(3, 'Milk', 90.9, 58, date('2024-02-29')),
	(3, 'Curd', 70.4, 46, date('2024-02-27')),
	(1, 'Cucumber', 8.3, 180, date('2024-02-18')),
	(3, 'Yogurt', 38.2, 122, date('2024-02-26')),
	(1, 'Potato', 10.6, 167, date('2024-01-29')),
	(2, 'Banana', 34.9, 98, date('2024-02-12')),
	(1, 'Tomato', 25.5, 101, date('2024-01-30'));

-- ----------------------------------------------------------------------------------------------------

-- Информация о всех продуктах
SELECT 
	Products.product_id, 
	Products.category_id, 
	Categories.product_name AS 'category', 
	Products.product_name, 
	Products.price, 
	Products.quantity, 
	Products.date_added 
FROM 
	Categories, Products 
WHERE 
	Categories.product_id = Products.category_id

-- 1. Общее количество продуктов в магазине
/*
SELECT 
	count(product_id) AS 'total_products'
FROM 
	Products
*/

-- 2. Количество продуктов в каждой категории
/*
SELECT 
	category_id, count(category_id) AS 'total_categories_products' 
FROM 
	Products 
GROUP BY 
	category_id
*/

-- 3. Самый дорогой продукт
/*
SELECT 
	product_name, max(price) 
FROM 
	Products
*/

-- 4. Общее количество продуктов на складе
/*
SELECT 
	sum(quantity) AS 'quantity_products' 
FROM 
	Products
*/

-- 5. Месяц с наибольшим числом добавлений новых продуктов (первая строка)
/*
SELECT 
	strftime('%m', date_added) AS 'month', 
	count(date_added) AS 'quantity_added' 
FROM 
	Products 
GROUP BY 
	strftime('%m', date_added) 
ORDER BY 
	count(date_added) DESC
*/

-- 6. Среднее количество дней между добавлением продукта в ассортимент магазина и текущей датой
/*
SELECT 
	product_name,
	julianday(date('now')) - julianday(date(date_added)) AS 'quantity_days_stored'
FROM
	Products
ORDER BY 
	date_added DESC
*/

-- 7. Средняя цена продукта 
/*
SELECT 
	avg(price) AS 'average_price' 
FROM 
	Products
*/
