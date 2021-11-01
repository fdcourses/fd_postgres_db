DROP TABLE IF EXISTS phones_to_orders;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS phones;
DROP TABLE IF EXISTS users;

CREATE TABLE "users" (
  id serial PRIMARY KEY,
  "firstName" varchar(64) NOT NULL,
  "lastName" varchar(64) NOT NULL,
  email varchar(256) NOT NULL CHECK (email != ''),
  "isMale" boolean NOT NULL,
  birthday date NOT NULL CHECK (
    birthday < current_date
    AND birthday > '1900/1/1'
  ),
  "createdAt" timestamp default current_timestamp,
  height numeric(3, 2) NOT NULL CHECK (
    height > 0.20
    AND height < 2.5
  ),
  "weight" decimal(5,2) CHECK("weight" > 0 AND "weight" < 700)
  CONSTRAINT "CK_FULL_NAME" CHECK (
    "firstName" != ''
    AND "lastName" != ''
  )
);

CREATE TABLE phones(
  id serial PRIMARY KEY,
  brand varchar(20) NOT NULL,
  model varchar(40) NOT NULL,
  price decimal(10, 2) NOT NULL CHECK(price >= 0),
  quantity int NOT NULL CHECK(quantity >= 0) DEFAULT 0,
  "description" text,
  "createdAt" timestamp NOT NULL DEFAULT current_timestamp,
  CONSTRAINT "unique_phone" UNIQUE (brand, model)
);

CREATE TABLE orders (
  id serial PRIMARY KEY,
  "userId" int REFERENCES users,
  "createdAt" timestamp NOT NULL DEFAULT current_timestamp
);

CREATE TABLE phones_to_orders (
  "orderId" int REFERENCES orders,
  "phoneId" int REFERENCES phones,
  quantity int NOT NULL CHECK (quantity > 0) DEFAULT 1,
  PRIMARY KEY ("orderId", "phoneId")
);