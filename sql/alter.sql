/*
• Добавлять столбцы
• Удалять столбцы
• Добавлять ограничения
• Удалять ограничения
• Изменять значения по умолчанию
• Изменять типы столбцов
 • Переименовывать столбцы
• Переименовывать таблицы
*/

CREATE TABLE tasks (
  id serial PRIMARY KEY,
  body text,
  is_done boolean,
  created_at timestamp
);

INSERT INTO tasks (body, is_done, created_at)
VALUES (
    'task 1',
    false,
    current_timestamp
  );

-- Создание столбца
ALTER TABLE tasks
ADD COLUMN deadline date NOT NULL DEFAULT current_date CHECK (deadline >= current_date);

-- Удалять столбцы
ALTER TABLE tasks
DROP COLUMN created_at;

-- добавлять ограничения

ALTER TABLE tasks
ADD CHECK(body != '');

ALTER TABLE tasks
ADD PRIMARY KEY(id);

ALTER TABLE tasks
ADD CONSTRAINT unique_task_name UNIQUE(body);

ALTER TABLE tasks
ALTER COLUMN is_done SET NOT NULL;

-- удаляем ограничения

ALTER TABLE tasks
DROP CONSTRAINT tasks_pkey;

ALTER TABLE tasks
ALTER COLUMN is_done DROP NOT NULL;

-- Изменять значения по умолчанию
ALTER TABLE tasks
ALTER COLUMN body SET DEFAULT 'test 32323432 task';

INSERT INTO tasks ( is_done)
VALUES (
    true
  );
-- удалять знач по умолч
  ALTER TABLE tasks
  ALTER COLUMN body DROP DEFAULT;

  --Изменять типы столбцов

  ALTER TABLE tasks
  ALTER COLUMN body TYPE varchar(512);

  -- Переименование столбца
  ALTER TABLE tasks
  RENAME COLUMN body  TO task_text;

-- переименование таблицы
  ALTER TABLE tasks RENAME TO to_do;

/*
  Переименовать users в customers;

  Созадайте таблицы
  users^
    login,
    password,
    email
    
  employees:
    salary,
    department,
    position,
    name,
    hire_date
    
  * 
*/

CREATE SCHEMA task;

CREATE TABLE task.users(
  id serial PRIMARY KEY,
  "login" varchar(32),
  "password" varchar(32),
  email varchar(128)
);

CREATE TABLE task.employees (
  id serial PRIMARY KEY,
  department text,
  postition text,
  "name" text,
  hire_date date DEFAULT current_date
);

/*
  добавить ограничение уникальности для емейла
  удлить пароль
  создать столбец password_hash для юзера и прокинуть ему ограничения,
  связать users и employees 

*/

INSERT INTO task.users ("login", "password_hash", "email") values 
('testa343', '12345asfaogn;dfdsasgdfasgsd', 'tes123t@mail.com'),
('user2', 'asfgbflu342389sFdfgfdhdsfSFg23423d', 'user@m32423ail.mail'),
('bigBoss', 'admin12345sagdhgdfgsdfd213', 'bigBoss234235@company.net');

ALTER TABLE task.users
ADD UNIQUE(email);

ALTER TABLE task.users
DROP COLUMN password;

ALTER TABLE task.users
ADD COLUMN password_hash varchar(64) CHECK(password_hash != '');

ALTER TABLE task.employees
ADD COLUMN user_id int NOT NULL REFERENCES task.users;

INSERT INTO task.employees (user_id ,department, postition) VALUES
(4,'IT', 'coder'),
(6,'Sales', 'Sales manages');


ALTER TABLE task.employees
ADD COLUMN salary numeric(10,2) NOT NULL DEFAULT 1000 CHECK (salary > 0);

-- Получить ВСЕХ ЮЗЕРОВ с их зарплатой
SELECT u.* , coalesce(emp.salary , 0) as salary
FROM task.users  as u
  LEFT JOIN task.employees as emp ON u.id = emp.user_id;