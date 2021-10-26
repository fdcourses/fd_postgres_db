DROP TABLE users;

CREATE TABLE users(
  first_name varchar(64),
  last_name varchar(64),
  email varchar(256)
);

INSERT INTO users
VALUES 
('Test', 'Testovich', 'test@mail.com'),
('Test', 'Testovich', 'test@mail.com'),
('Test', 'Testovich', 'test@mail.com');

CREATE DATABASE test_db_new;
DROP DATABASE users;