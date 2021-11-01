SELECT count(*)
FROM users;

/*

  max
  min
  avg
  sum

  count

*/

/*
Найти максимальнй рост
*/
SELECT max(height) FROM users;
/*
Найти минимальный рост
*/
SELECT min(height) FROM users;
/*
Количество Иванов в таблице
*/
SELECT count(*)
FROM users
WHERE "firstName" = 'John';

--
SELECT avg(weight)
FROM users
WHERE "isMale" = true;
--
SELECT avg(weight)
FROM users
WHERE "isMale" = false;
--
SELECT avg(weight), email
FROM users
GROUP BY "email";
-- Средний рост по именам в таблице
SELECT avg(height), "firstName"
FROM users
GROUP BY "firstName", "lastName";
--
SELECT count (*)
FROM users
WHERE height > 1.5;
