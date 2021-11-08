DELETE FROM wf.departments WHERE id = 1;

CREATE TABLE wf.departments (
  id serial PRIMARY KEY,
  "name" varchar(64) NOT NULL
);

DROP TABLE wf.employees ;

CREATE TABLE wf.employees (
  id serial PRIMARY KEY,
  department_id integer REFERENCES wf.departments ON DELETE CASCADE ON UPDATE CASCADE,
  salary numeric(10,2) NOT NULL CHECK(salary > 0),
  "name" text NOT NULL,
  hire_date date NOT NULL CHECK(hire_date <= current_date)
);