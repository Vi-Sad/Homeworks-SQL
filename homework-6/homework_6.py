# Задача
# Создать БД "система управления задачами", с таблицами users, tasks (таблицы можно создать и не через питон).
# Требования:
# 1. Пользователи могут регистрироваться, входить в систему и изменять свои данные.
# 2. Администратор может назначать, удалять и изменять задачи.
# 3. Пользователи могут создавать новые задачи, просматривать список задач и изменять их статус.
# 4. Пользователь должен получить уведомление о назначении новой задачи или изменении статуса по электронной почте.

# ---------------------------------------------------------------------------------------------------------------------

import sqlite3

with sqlite3.connect('task_management_system.db') as con:
    cur = con.cursor()

    # Создание таблицы "Users".
    cur.execute('''
CREATE TABLE IF NOT EXISTS 
    Users(
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        name TEXT NOT NULL UNIQUE
        CHECK(
            length(name) >= 2
        ),
        email TEXT NOT NULL UNIQUE 
        CHECK(
            email LIKE '%@yandex.ru' OR 
            email LIKE '%@gmail.com'
        )
    );
    ''')

    # Создание таблицы "Tasks".
    cur.execute('''
CREATE TABLE IF NOT EXISTS 
    Tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_user INTEGER NOT NULL,
        task TEXT NOT NULL 
        CHECK(
            length(task) >= 2
        ),
        status TEXT NOT NULL,
        FOREIGN KEY(id_user) REFERENCES Users(id)
    )
    ''')


# ---------------------------------------------------------------------------------------------------------------------

def add_user(name, email):
    # Добавление нового пользователя
    cur.execute(f'''
INSERT OR IGNORE INTO 
Users(name, email) 
VALUES 
('{name}', '{email}');
    ''')


def add_task(id_user, task):
    # Добавление новой задачи
    cur.execute(f'''
INSERT OR IGNORE INTO 
    Tasks(id_user, task, status) 
VALUES 
    ({id_user}, '{task}', 'not finished');
    ''')


def update_user(id, name, email, command):
    # Изменение данных пользователя по id
    if command == 1:
        cur.execute(f'''
UPDATE Users
SET name = '{name}'
WHERE id = '{id}'
        ''')
        print('Ваше имя было успешно обновлено\n'
              'Для правильного вывода Вашего имени используйте команду "Выйти из системы"')
    elif command == 2:
        cur.execute(f'''
UPDATE Users
SET email = '{email}'
WHERE id = '{id}'
        ''')
        print('Идет проверка новой электронной почты...\n'
              'Чтобы убедиться, что Ваш email был изменен, используйте команду "Посмотреть свои данные"')
    else:
        print(f'Команды "{command}" не существует\nДанные не обновлены.')


def update_task(id, status, task, command):
    # Изменение статуса задач по id
    if command == 1:
        cur.execute(f'''
UPDATE Tasks
SET status = '{status}'
WHERE id = '{id}'
        ''')
    # Изменение задачи по id
    elif command == 2:
        cur.execute(f'''
UPDATE Tasks
SET task = '{task}'
WHERE id = '{id}'
        ''')
    else:
        print(f'Команды "{command}" не существует\nДанные не обновлены')


def del_task(id, status, command):
    # Удаление задачи по id
    if command == 1:
        cur.execute(f'''
DELETE FROM Tasks
WHERE id = '{id}'
        ''')
    # Удаление задачи по статусу
    elif command == 2:
        cur.execute(f'''
DELETE FROM Tasks
WHERE status = '{status}'
        ''')


def view_tasks(id, command):
    # Просмотр всех задач
    if command == 1:
        cur.execute('''
SELECT
    Tasks.id AS 'id_task',
    Tasks.id_user,
    Tasks.task,
    Tasks.status
FROM 
    Tasks 
JOIN 
    Users ON Users.id = Tasks.id_user
        ''')
        print('Задачи:')
        print('(id_task, id_user, task, status)')
        for i in cur.fetchall():
            print(i)
    # Просмотр задач по id пользователя
    elif command == 2:
        cur.execute(f'''
SELECT
    Tasks.id AS 'id_task',
    Tasks.task,
    Tasks.status
FROM 
    Tasks 
JOIN 
    Users ON Users.id = Tasks.id_user
WHERE id_user = '{id}'
        ''')
        print('Задачи:')
        print('(id_task, task, status)')
        for i in cur.fetchall():
            print(i)
    else:
        print(f'\nКоманды "{command}" не существует')


def view_users():
    # Просмотр данных всех пользователей
    cur.execute('''
SELECT *
FROM Users
    ''')
    print('Данные пользователей:')
    print('(id, name, email)')
    for i in cur.fetchall():
        print(i)


def view_user(id):
    # Просмотр данных конкретного пользователя
    cur.execute(f'''
SELECT *
FROM Users
WHERE id = '{id}'
    ''')
    print('Данные пользователя:')
    print('(id, name, email)')
    for i in cur.fetchall():
        print(i)


def login_users(email):
    # Вход в систему
    cur.execute(f'''
SELECT *
FROM Users
WHERE email = '{email}'
    ''')
    user_data = cur.fetchall()
    if user_data == []:
        return 'Guest'
    else:
        for i in user_data:
            return ['User', i[1], i[0]]


# ---------------------------------------------------------------------------------------------------------------------

with sqlite3.connect('task_management_system.db') as con:
    cur = con.cursor()
    add_user('Admin', 'main.admin@yandex.ru')

main = 'Guest'

while True:
    print(f'\nРады Вас видеть, {main}!\nЧтобы выйти из программы, введите число 0')
    # Гость
    if main == 'Guest':
        command = int(input('Что можно сделать? Команды, которые Вам доступны:\n'
                            '1. Зарегистрироваться\n2. Войти в систему\nВведите число -> '))
        if command == 1:
            print('\nРегистрация пользователя')
            name = input('Введите свое имя -> ')
            email = input('Введите свою электронную почту -> ')
            with sqlite3.connect('task_management_system.db') as con:
                cur = con.cursor()
                add_user(name, email)
            print('Введенные Вами данные проходят проверку...\n'
                  'Чтобы проверить на корректность данных, попробуйте "Войти в систему"')
        elif command == 2:
            print('\nВход в систему')
            check_main = input('Введите адрес своей электронной почты -> ')
            with sqlite3.connect('task_management_system.db') as con:
                cur = con.cursor()
                if login_users(check_main) == 'Guest':
                    print(f'\nВозможно, при регистрации где-то была допущена ошибка или '
                          f'пользователя с email "{check_main}" не существует')
                else:
                    main, main_name, main_id = login_users(check_main)[0], login_users(check_main)[1], \
                        login_users(check_main)[2]
                    if main_name == 'Admin':
                        main = 'Admin'
        elif command == 0:
            print('\nПрограмма успешно завершена. База данных сохранена как "task_management_system.db"')
            break
        else:
            print(f'\nКоманды "{command}" не существует')
    # Пользователь
    elif main == 'User':
        print(f'\n{main_name}, что хотите узнать?', end=' ')
        command = int(input('Команды, которые Вам доступны:\n'
                            '1. Выйти из системы\n2. Посмотреть свои данные\n3. Изменить свои данные\n'
                            '4. Создать задачу\n5. Изменить статус задачи\n6. Посмотреть список задач\n'
                            'Введите число -> '))
        if command == 1:
            main = 'Guest'
            print('\nВы успешно вышли из системы')
        elif command == 2:
            print()
            with sqlite3.connect('task_management_system.db') as con:
                cur = con.cursor()
                view_user(main_id)
        elif command == 3:
            update = int(input('\nЧто хотите изменить в своей Базе данных?\nДоступные команды:\n'
                               '1. Изменить имя\n2. Изменить email\nВведите число -> '))
            if update == 1:
                new_name = input('Введите свое новое имя -> ')
                print()
                with sqlite3.connect('task_management_system.db') as con:
                    cur = con.cursor()
                    update_user(main_id, new_name, None, 1)
            elif update == 2:
                new_email = input('Введите свой новый email -> ')
                print()
                with sqlite3.connect('task_management_system.db') as con:
                    cur = con.cursor()
                    update_user(main_id, None, new_email, 2)
            else:
                print(f'\nКоманды "{update}" не существует')
        elif command == 4:
            new_task = input('Введите свою новую задачу -> ')
            with sqlite3.connect('task_management_system.db') as con:
                cur = con.cursor()
                add_task(main_id, new_task)
        elif command == 5:
            update_by_id = int(input('Введите id своей задачи -> '))
            update_status = input('Введите новый статус своей задачи -> ')
            with sqlite3.connect('task_management_system.db') as con:
                cur = con.cursor()
                update_task(update_by_id, update_status, None, 1)
        elif command == 6:
            print()
            with sqlite3.connect('task_management_system.db') as con:
                cur = con.cursor()
                view_tasks(main_id, 2)
        elif command == 0:
            print('\nПрограмма успешно завершена. База данных сохранена как "task_management_system.db"')
            break
        else:
            print(f'\nКоманды "{command}" не существует')
    # Админ
    elif main == 'Admin':
        command = int(input('\nКоманды, которые Вам доступны:\n'
                            '1. Выйти из системы\n2. Посмотреть свои данные\n3. Изменить свой email\n'
                            '4. Добавить задачу пользователю\n5. Изменить задачу пользователю\n'
                            '6. Удалить задачу пользователя\n7. Посмотреть список задач пользователя\n'
                            '8. Посмотреть список всех задач\n9. Посмотреть данные всех пользователей\n'
                            'Введите число -> '))
        if command == 1:
            main = 'Guest'
            print('\nВы успешно вышли из системы')
        elif command == 2:
            print()
            with sqlite3.connect('task_management_system.db') as con:
                cur = con.cursor()
                view_user(main_id)
        elif command == 3:
            new_email = input('Введите свой новый email -> ')
            print()
            with sqlite3.connect('task_management_system.db') as con:
                cur = con.cursor()
                update_user(main_id, None, new_email, 2)
        elif command == 4:
            id_user = int(input('Введите id пользователя -> '))
            new_task = input('Введите новую задачу -> ')
            with sqlite3.connect('task_management_system.db') as con:
                cur = con.cursor()
                add_task(id_user, new_task)
        elif command == 5:
            id_task = int(input('Введите id задачи -> '))
            new_task = input('Введите новую (обновленную) задачу -> ')
            with sqlite3.connect('task_management_system.db') as con:
                cur = con.cursor()
                update_task(id_task, None, new_task, 2)
        elif command == 6:
            delete = int(input('\nВозможные команды по удалению задач:\n'
                               '1. Удалить конкретную задачу\n2. Удалить все задачи по статусу\nВведите число -> '))
            if delete == 1:
                delete_by_id = int(input('Введите id задачи -> '))
                with sqlite3.connect('task_management_system.db') as con:
                    cur = con.cursor()
                    del_task(delete_by_id, None, 1)
            elif delete == 2:
                delete_by_status = input('Введите статус задач -> ')
                with sqlite3.connect('task_management_system.db') as con:
                    cur = con.cursor()
                    del_task(None, delete_by_status, 2)
            else:
                print(f'\nКоманды "{delete}" не существует\nДанные не удалены')
        elif command == 7:
            id_user = int(input('Введите id пользователя -> '))
            print()
            with sqlite3.connect('task_management_system.db') as con:
                cur = con.cursor()
                view_tasks(id_user, 2)
        elif command == 8:
            print()
            with sqlite3.connect('task_management_system.db') as con:
                cur = con.cursor()
                view_tasks(None, 1)
        elif command == 9:
            print()
            with sqlite3.connect('task_management_system.db') as con:
                cur = con.cursor()
                view_users()
        elif command == 0:
            print('\nПрограмма успешно завершена. База данных сохранена как "task_management_system.db"')
            break
        else:
            print(f'\nКоманды "{command}" не существует')
