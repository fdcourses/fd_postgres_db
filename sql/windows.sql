CREATE SCHEMA wf;

CREATE TABLE wf.departments (
  id serial PRIMARY KEY,
  "name" varchar(64) NOT NULL
);

CREATE TABLE wf.employees (
  id serial PRIMARY KEY,
  department_id integer REFERENCES wf.departments,
  salary numeric(10,2) NOT NULL CHECK(salary > 0),
  "name" text NOT NULL,
  hire_date date NOT NULL CHECK(hire_date <= current_date)
);

INSERT INTO wf.departments("name")
VALUES ('SALES'),
  ('HR'),
  ('DEVELOPMENT'),
  ('QA'),
  ('TOP MANAGEMENT');

INSERT INTO wf.employees ("name", salary, hire_date, department_id)
VALUES ('Test Developer', 10000, '1990-1-1', 3),
  ('John Doe', 6000, '2010-1-1', 2),
  ('Matew Doe', 3456, '2020-1-1', 2),
  ('Matew Doe1', 53462, '2020-1-1', 3),
  ('Matew Doe2', 124543, '2012-1-1', 4),
  ('Matew Doe3', 12365, '2004-1-1', 5),
  ('Matew Doe4', 1200, '2000-8-1', 5),
  ('Matew Doe5', 2535, '2010-1-1', 2),
  ('Matew Doe6', 1000, '2014-1-1', 3),
  ('Matew Doe6', 63456, '2017-6-1', 1),
  ('Matew Doe7', 1000, '2020-1-1', 3),
  ('Matew Doe8', 346434, '2015-4-1', 2),
  ('Matew Doe9', 3421, '2018-1-1', 3),
  ('Matew Doe0', 34563, '2013-2-1', 5),
  ('Matew Doe10', 2466, '2011-1-1', 1),
  ('Matew Doe11', 9999, '1999-1-1', 5),
  ('TESTing 1', 1000, '2019-1-1', 2),
  ('New Tester', 1200, '2015-4-1', 4);

-- скок сотрудников в отделе
SELECT count(emp.id) as employees_in_department, dep.name
FROM wf.departments AS dep
  JOIN wf.employees AS emp ON emp.department_id = dep.id
GROUP BY dep.id;
-- сотрудники и имя его отдела
SELECT emp.*, dep.name as department_name
FROM wf.employees emp
  JOIN wf.departments dep ON dep.id = emp.department_id;
-- средняя по отделу
SELECT avg(emp.salary) as avg_salary, dep.name
FROM wf.departments AS dep
  JOIN wf.employees AS emp ON emp.department_id = dep.id
GROUP BY dep.id;
-- инфу про юзера + имя его отдела + средняя зп отдела
SELECT emp.*, dep.name, avg_salary_table.avg_salary
FROM wf.departments AS dep
  JOIN wf.employees AS emp ON emp.department_id = dep.id
  JOIN (
    SELECT avg(emp.salary) as avg_salary
    FROM wf.departments AS dep
      JOIN wf.employees AS emp ON emp.department_id = dep.id
  ) as avg_salary_table ON dep.id = avg_salary_table.id;

-- Window Functions

SELECT emp.*,
dep.name,
avg(emp.salary) OVER (PARTITION BY dep.id ORDER BY emp.salary DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as avg_salary_for_department,
avg(emp.salary) OVER () as avg_salary_for_company
FROM wf.employees emp
  JOIN wf.departments dep ON dep.id = emp.department_id;
