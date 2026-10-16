DROP TABLE IF EXISTS stg_departments;
DROP TABLE IF EXISTS stg_employees;
DROP TABLE IF EXISTS stg_titles;
DROP TABLE IF EXISTS stg_salaries;
DROP TABLE IF EXISTS stg_dept_emp;
DROP TABLE IF EXISTS stg_dept_manager;

CREATE TABLE stg_departments  (dept_no TEXT, dept_name TEXT);
CREATE TABLE stg_employees    (emp_no TEXT, birth_date TEXT, first_name TEXT, last_name TEXT, gender TEXT, hire_date TEXT);
CREATE TABLE stg_titles       (emp_no TEXT, title TEXT, from_date TEXT, to_date TEXT);
CREATE TABLE stg_salaries     (emp_no TEXT, salary TEXT, from_date TEXT, to_date TEXT);
CREATE TABLE stg_dept_emp     (emp_no TEXT, dept_no TEXT, from_date TEXT, to_date TEXT);
CREATE TABLE stg_dept_manager (emp_no TEXT, dept_no TEXT, from_date TEXT, to_date TEXT);