# Задание
# Создать таблицу "Заказы" с полями: номер заказа, дата заказа, сумма заказа

import sqlite3

with sqlite3.connect('orders.db') as con:
    cur = con.cursor()
    cur.execute('''
CREATE TABLE IF NOT EXISTS Orders (
    id_order INTEGER PRIMARY KEY AUTOINCREMENT,
    name_order TEXT NOT NULL CHECK (length(name_order) >= 2),
    date_order TEXT NOT NULL,
    sum_order INTEGER NOT NULL
    )''')


def add_data(cur, name=None, day=None, summ=None):
    cur.execute(f'''
INSERT OR IGNORE INTO 
    Orders (name_order, date_order, sum_order) 
VALUES 
    ("{name}", date("now", "{day} day"), {summ});
    ''')


print('-' * 100)
add_count = 0
add_count_user = int(input('Сколько заказов добавить в таблицу? Введите число -> '))
print('-' * 100)

while True:
    if add_count == abs(add_count_user):
        print('Данные успешно занесены в таблицу. Проверьте базу данных "orders.db".\n'
              'Для просмотра таблицы откройте SQL файл (Open SQL file(s)) "orders.sql" в базе данных.')
        print('-' * 100)

        with open('orders.sql', 'w', encoding='utf-8') as file:
            file.write('''
-- Просмотр таблицы "Orders".
SELECT 
    id_order AS 'Номер заказа',
    name_order AS 'Имя заказа',
    date_order AS 'Дата получения заказа',
    sum_order AS 'Цена заказа (руб.)'
FROM
    Orders
            '''.strip())
        break
    else:
        add_count += 1
        user_name = input(f'Что хотите заказать? Напишите {add_count}-й заказ -> ')
        while len(user_name) < 2:
            user_name = input(f'Слишком короткое имя для заказа! Напишите другой {add_count}-й заказ -> ')
        user_day = int(input('Через сколько дней доставить заказ? Введите число -> '))
        user_sum = float(input('На какую сумму рассчитываете приобрести заказ? Введите число -> '))
        print('-' * 100)

        with sqlite3.connect('orders.db') as con:
            cur = con.cursor()
            add_data(cur, user_name, abs(user_day), abs(user_sum))
