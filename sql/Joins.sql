CREATE TABLE a(
  x char(3),
  v int
);

CREATE TABLE b(
  x char(3),
  c text
);

INSERT INTO a (x, v)
VALUES 
('AAA', 1),
('AAB', 2),
('AAC', 3),
('ABA', 4),
('ABB', 5),
('ABC', 6),
('CCC', 7),
('XYZ', 999);

INSERT INTO b (x, c)
VALUES 
('AAA', 'Test 1'),
('AAB', 'Test2'),
('AAC', 'Test3'),
('ABA', 'Test4'),
('ABB', 'Test5'),
('ABC', 'Test6'),
('CCC', 'Test7');

-- SELECT *  FROM a,b WHERE a.x = b.x;
-- SELECT *  FROM users, orders WHERE users.id = orders."userId"; 
SELECT * 
FROM users
  JOIN orders ON users.id = orders."userId";

-- находим все уникальные значения
SELECT x FROM a
UNION
SELECT x FROM b;
-- находим все совпадающие значения
SELECT x FROM a
INTERSECT
SELECT x FROM b;
-- вычитание
SELECT x FROM b
EXCEPT
SELECT x FROM a;
--
INSERT INTO users (
    "firstName",
    "lastName",
    email,
    "isMale",
    birthday,
    "createdAt",
    height,
    weight
  )
VALUES (
    'New',
    'User',
    'new@new.t',
    true,
    '1991-1-1',
    current_timestamp,
    1.70,
    99
  );

--
SELECT id FROM users
EXCEPT
SELECT "userId" FROM orders;

SELECT * FROM users WHERE id = 1001;


-- SELECT orders.id, users.email FROM users, orders WHERE users.id = 1;

SELECT orders.id
FROM orders
WHERE orders."userId" = 2;
--
SELECT users.*
FROM orders
JOIN users ON users.id = orders."userId"
WHERE orders."userId" = 1;

SELECT *
FROM  users
JOIN orders ON users.id = orders."userId"
WHERE orders."userId" = 1;
-- мобилы для первого заказа
SELECT phones.brand, phones.model
FROM phones
  JOIN phones_to_orders ON phones.id = phones_to_orders."phoneId"
  JOIN orders ON phones_to_orders."orderId" = orders.id
WHERE orders.id = 1;
-- айдишники ордеров для заказов с сименсами
SELECT orders.id, p.model
FROM orders
  JOIN phones_to_orders AS pto ON orders.id = pto."orderId"
  JOIN phones AS p ON p.id = pto."phoneId"
WHERE  p.brand = 'Siemens';
-- 
SELECT phones.brand, phones.model
FROM phones_to_orders
RIGHT JOIN phones ON phones.id = phones_to_orders."phoneId"
WHERE phones_to_orders."phoneId" IS NULL;
-- GROUP BY "phoneId", phones.brand, phones.model;
SELECT *
FROM  phones
FULL JOIN phones_to_orders ON phones.id = phones_to_orders."phoneId"
;
/*

стоимость каждого совершенного заказа
просмотрите все телефоны конкретного заказа
количестов телефонов которое было куплено в определенном заказе
количестов заказов для каждого пользователя

*/

--стоимость каждого совершенного заказа
SELECT sum( phones.price * phones_to_orders.quantity) as "стоимость",
phones_to_orders."orderId" as "order id"
FROM phones
JOIN phones_to_orders ON phones_to_orders."phoneId" = phones.id
GROUP BY phones_to_orders."orderId";
--просмотрите все телефоны конкретного заказа
SELECT phones.brand, phones.model
FROM phones_to_orders
JOIN phones ON phones.id = phones_to_orders."phoneId"
WHERE phones_to_orders."orderId" = 1;
-- количестов телефонов которое было куплено в определенном заказе
SELECT sum(phones_to_orders.quantity)
FROM phones_to_orders
JOIN phones ON phones.id = phones_to_orders."phoneId"
WHERE phones_to_orders."orderId" = 5;
--количестов заказов для каждого пользователя
SELECT count(*) AS "количество заказов"
FROM orders
JOIN users ON users.id = orders."userId"
GROUP BY users.id;

SELECT * FROM orders WHERE "userId" = 652;


SELECT * 
FROM users
JOIN orders USING "userId";

-- найти самый популярный телефон
SELECT sum(phones_to_orders.quantity) as "покупок",brand, model
FROM phones
JOIN phones_to_orders ON phones_to_orders."phoneId" = phones.id
GROUP BY phones.id
ORDER BY "покупок" DESC
LIMIT 1;
-- найти самого растратного пользователя
SELECT sum(phones.price * phones_to_orders.quantity) as full_price,
concat(users."firstName" , ' ' , users."lastName") as full_name,
users.id
FROM users
  JOIN orders ON orders."userId" = users.id
  JOIN phones_to_orders ON phones_to_orders."orderId" = orders.id
  JOIN phones ON phones.id = phones_to_orders."phoneId"
GROUP BY users.id
ORDER BY full_price DESC
LIMIT 1;
-- извлечь пользователя и количество моделей телефонов которые он покупал
SELECT users.id, phones_to_orders."phoneId"
FROM users
  JOIN orders ON orders."userId" = users.id
  JOIN phones_to_orders ON phones_to_orders."orderId" = orders.id
GROUP BY users.id, phones_to_orders."phoneId";
--
SELECT count(users_with_phones."phoneId") as "количество моделей",
users_with_phones.id
FROM (
  SELECT users.id, phones_to_orders."phoneId"
    FROM users
    JOIN orders ON orders."userId" = users.id
    JOIN phones_to_orders ON phones_to_orders."orderId" = orders.id
  GROUP BY users.id, phones_to_orders."phoneId"
  ) as "users_with_phones"
GROUP BY users_with_phones.id;

-- ** все заказы со стоимостью чека выше средней стоимости заказа
-- общая стоимость каждого заказа
SELECT sum(phones.price * phones_to_orders.quantity) as full_price
FROM orders
  JOIN phones_to_orders ON phones_to_orders."orderId" = orders.id
  JOIN phones ON phones.id = phones_to_orders."phoneId"
GROUP BY orders.id;
--  средняя стоимость заказа
SELECT avg(orders_price.full_price)
FROM (
  SELECT sum(phones.price * phones_to_orders.quantity) as full_price
  FROM orders
    JOIN phones_to_orders ON phones_to_orders."orderId" = orders.id
    JOIN phones ON phones.id = phones_to_orders."phoneId"
  GROUP BY orders.id
) as orders_price;
-- итоговое
SELECT sum(phones.price * phones_to_orders.quantity) as full_price,
orders.id
FROM orders
  JOIN phones_to_orders ON phones_to_orders."orderId" = orders.id
  JOIN phones ON phones.id = phones_to_orders."phoneId"
GROUP BY orders.id
HAVING sum(phones.price * phones_to_orders.quantity) > (
  SELECT avg(orders_price.full_price)
  FROM (
    SELECT sum(phones.price * phones_to_orders.quantity) as full_price
    FROM orders
      JOIN phones_to_orders ON phones_to_orders."orderId" = orders.id
      JOIN phones ON phones.id = phones_to_orders."phoneId"
    GROUP BY orders.id
  ) as orders_price
);
--
WITH orders_with_price AS (
  SELECT sum(phones.price * phones_to_orders.quantity) as full_price,
  orders.id
  FROM orders
    JOIN phones_to_orders ON phones_to_orders."orderId" = orders.id
    JOIN phones ON phones.id = phones_to_orders."phoneId"
  GROUP BY orders.id
), avg_order_price AS (
  SELECT avg(orders_with_price.full_price)
  FROM orders_with_price
)
SELECT *
FROM orders_with_price 
WHERE orders_with_price.full_price > (SELECT * FROM avg_order_price);