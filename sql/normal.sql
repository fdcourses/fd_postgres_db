/* 2 Номмальная Форма */

CREATE TABLE employees(
  id serial PRIMARY KEY,
  "name" text,
  postition text,
  department text,
);
INSERT INTO employees ("name", postition, department, car_avalibility)
VALUES (
    'Test',
    'programmer',
    'IT',
    false
  ), 
  ( 'Test 2',
    'HR',
    'HR',
    true),
    ('Test3', 'driver','drive', false);

CREATE TABLE positions(
  id PRIMARY KEY,
  "name" text,
  car_avalibility
);

/* 3 НОРМАЛЬНАЯ ФОРМА */
CREATE TABLE employees(
  id serial PRIMARY KEY,
  "name" text,
  postition text,
  department text,
);

CREATE TABLE departments(
  department text PRIMARY KEY,
  department_phone int
);

/*

 teach n : 1 subject
 student n : subject
 student n : m teachers

*/

/* BCNF */
CREATE TABLE students (
  id serial PRIMARY KEY
);
CREATE TABLE teachers(
  id serial PRIMARY KEY
);

CREATE TABLE students_to_teachers_to_subjects(
  student_id int,
  tacher_id int,
  PRIMARY Key(student_id, tacher_id)
);

INSERT INTO students_to_teachers VALUES
(1,1),
(2,1),
(1,2),
(2,2);

CREATE TABLE subjects(
  id,
  teacher_id
)