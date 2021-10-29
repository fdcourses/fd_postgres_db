DROP TABLE "users";
/**/
CREATE TABLE "users"(
  id serial PRIMARY KEY,
  first_name varchar(64) NOT NULL CHECK(first_name != ''),
  last_name varchar(64) NOT NULL CHECK(last_name != ''),
  email varchar(256) NOT NULL UNIQUE,
  birthday date NOT NULL CHECK(
    birthday > '1945-1-1'
    AND birthday < current_date
  ),
  height numeric (3, 2) CHECK (
    height > 0.2
    AND height < 3
  ),
  is_male boolean,
  CONSTRAINT "CHECK_EMAIL_NOT_EMPTY" CHECK (email != '')
);

ALTER TABLE users
DROP CONSTRAINT users_birthday_check;

ALTER TABLE users
ADD COLUMN height numeric (3, 2) CHECK (
    height > 0.2
    AND height < 3
  );
  
/**/
CREATE TABLE products (
  id bigserial PRIMARY KEY,
  price numeric (15, 2) NOT NULL,
  product_name varchar(256) NOT NULL,
  quantity integer NOT NULL
);
/*
 1 : m 
 REFERENCES на основную таблицу
 */
CREATE TABLE orders (
  id bigserial PRIMARY KEY,
  created_at timestamp DEFAULT current_timestamp,
  customer_id integer REFERENCES users (id)
);
/*
  m : n
  СВЯЗУЮЩАЯ ТАБЛИЦА
*/
CREATE TABLE products_to_orders (
  order_id bigint REFERENCES orders (id),
  product_id bigint REFERENCES products (id),
  quantity integer,
  PRIMARY KEY (order_id, product_id)
);

INSERT INTO users (first_name, last_name, email, birthday, height, is_male)
VALUES ('Vasya', 'Pupkin', 'vp@mail.com', '1990/1/1', 1.65, true);

INSERT INTO products (product_name,price, quantity)
VALUES 
('Пылесос', 2500, 1500),
('Айфщо восмой', 99999.99,  999999),
('Газонокосилка', 1999, 4000);

INSERT INTO orders (customer_id)
VALUES (1);

INSERT INTO products_to_orders (order_id, product_id, quantity)
VALUES 
(1, 3, 2),
(1, 2, 1);

SELECT sum(p.price * pto.quantity)
FROM users AS u
  JOIN orders AS o ON o.customer_id = u.id
  JOIN products_to_orders AS pto ON pto.order_id = o.id
  JOIN products AS p ON p.id = pto.product_id
WHERE u.id = 1;

/*
   1 : 1
   
*/
CREATE TABLE coaches(
  id serial PRIMARY KEY,
  "name" varchar(256)
);

CREATE TABLE teams(
  id serial PRIMARY KEY,
  "name" varchar(256),
  coach_id integer REFERENCES coaches(id)
);

ALTER TABLE coaches
ADD COLUMN team_id int REFERENCES teams(id);

DROP TABLE coaches;