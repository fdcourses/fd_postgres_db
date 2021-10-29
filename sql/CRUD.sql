SELECT * FROM users;

SELECT first_name, last_name FROM users;

SELECT * 
FROM users
WHERE id = 2;

-- найти всех пользователей которые выше 1.50
SELECT *
FROM users
WHERE height > 1.50;
--
SELECT *
FROM users
WHERE id % 2 = 0;
--
SELECT *
FROM users
WHERE first_name IN ('Test', 'Ron', 'Jane');
--
SELECT *
FROM users
WHERE id >= 10 AND id <= 50;

/*
  UPDATE
*/

UPDATE users 
SET first_name = 'Ne timofey' 
WHERE id =115
RETURNING *;
--
DELETE FROM users 
WHERE height < 1.5
RETURNING *;


-- найти всех пользователей кому больше / меньше 30 лет
-- часть 2 глава 9 
SELECT first_name || ' ' || last_name AS "Имя фамилия",
id "Айдишник",
id + 5,
email AS "Электронная почта"
FROM users
WHERE age(birthday) > make_interval(30)
ORDER BY id ASC
LIMIT 10 OFFSET 20;
--
SELECT 5 * 5;