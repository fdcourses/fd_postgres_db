/*
  VIEWS | Представления | Виртуальные таблицы
*/

SELECT users.id , count(orders.id) as orders_amount
FROM users
  JOIN orders ON orders."userId" = users.id
GROUP BY users.id;

CREATE VIEW users_with_orders_amount AS 
SELECT users.id , count(orders.id) as orders_amount
FROM users
  JOIN orders ON orders."userId" = users.id
GROUP BY users.id;

SELECT id FROM users_with_orders_amount
WHERE orders_amount > 3;
-- стоимость каждого заказа для каждого юзера
SELECT users.id as user_id, orders.id as order_id, sum(phones.price * phones_to_orders.quantity) as order_cost
FROM users
  JOIN orders ON orders."userId" = users.id
  JOIN phones_to_orders ON phones_to_orders."orderId" = orders.id
  JOIN phones ON phones.id = phones_to_orders."phoneId"
GROUP BY users.id, orders.id;

CREATE VIEW users_with_orders_with_order_cost AS 
SELECT orders."userId" as user_id, orders.id as order_id, 
sum(phones.price * phones_to_orders.quantity) as total_order_price
FROM users
  JOIN orders ON orders."userId" = users.id
  JOIN phones_to_orders ON phones_to_orders."orderId" = orders.id
  JOIN phones ON phones.id = phones_to_orders."phoneId"
GROUP BY orders.id;

CREATE VIEW users_wit_total_cost AS 
SELECT owc.user_id , sum(owc.total_order_price) as total_spent
FROM users_with_orders_with_order_cost owc
GROUP BY owc.user_id;


CREATE OR REPLACE VIEW spam_list AS 
SELECT  users.email, users.birthday, users.id
FROM users
  JOIN users_wit_total_cost owc ON users.id = owc.user_id
WHERE owc.total_spent > 4000000
GROUP BY users.id;

-- сделать вьюшку в которой  есть
-- id 
-- полное имя юзера
-- возраст
-- пол (словами)

-- concat(attr, "attr2", 'asfgrfgdffgds') as new_attr
-- extract , age 
SELECT id,
concat("firstName", ' ' ,"lastName") as full_name,
extract ( years from age(birthday)) as age,
CASE "isMale"
  WHEN true THEN 'Male'
  WHEN false THEN 'Female'
END as gender
FROM users;

CREATE VIEW user_info AS 
SELECT id,
concat("firstName", ' ' ,"lastName") as full_name,
extract ( years from age(birthday)) as age,
CASE "isMale"
  WHEN true THEN 'Male'
  WHEN false THEN 'Female'
END as gender
FROM users;

