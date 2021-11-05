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