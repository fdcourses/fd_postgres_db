SELECT sum(quantity)
FROM phones_to_orders;
-- посортировать телефоны от дорогих к дешевым ORDER BY id ASC | DESC
SELECT *
FROM phones
ORDER BY price DESC;
-- Посортировать юзеров по высоте и имени
SELECT * 
FROM users
ORDER BY height DESC, "firstName" ASC;
-- наименьшее число телефонов среди всех брендов
SELECT sum(quantity) AS "amount", brand
FROM phones
GROUP BY brand
ORDER BY "amount";
-- ФИЛЬТРАЦИЯ ГРУПП --
SELECT sum(quantity) AS "amount", brand
FROM phones
GROUP BY brand
HAVING sum(quantity) < 5000
ORDER BY "amount";
/*
 число телефонов среди всех брендов 
при этом телефонов у бренда должно быть больше 7000
*/
SELECT sum(quantity) AS "amount", brand
FROM phones
GROUP BY brand
HAVING sum(quantity) > 7000
ORDER BY "amount";

-- 
SELECT sum(quantity) AS "amount", brand
FROM phones
WHERE price > 5000
GROUP BY brand
d


SELECT brand
FROM (
  SELECT sum(quantity) AS "amount", brand
  FROM phones
  WHERE price > 5000
  GROUP BY brand
) AS result
WHERE "amount" > 8000;
--
/*

  Поиск  по тексту

  LIKE - с учетом регистра
  ILIKE - без учета регчистра

  * | %
  ? | _
  
  SIMILAR TO

  first_name ~ '[A-Z]{0,5}'
  ~*
  !~
  !~*
*/

SELECT *
FROM users
WHERE "firstName" ILIKE '%d';

SELECT *
FROM users
WHERE "firstName" SIMILAR TO '[BDE]{1}.*%d';
