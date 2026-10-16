DROP TABLE IF EXISTS titles;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS employees;
DROP TYPE  IF EXISTS gender_enum;

CREATE TYPE gender_enum AS ENUM ('M', 'F');

CREATE TABLE employees (
  emp_no     INT PRIMARY KEY,
  birth_date DATE,
  first_name VARCHAR(14),
  last_name  VARCHAR(16),
  gender     gender_enum,
  hire_date  DATE
);

CREATE TABLE departments (
  dept_no   CHAR(4) PRIMARY KEY,
  dept_name VARCHAR(40)
);

-- children
CREATE TABLE titles (
  emp_no    INT         NOT NULL,
  title     VARCHAR(50) NOT NULL,
  from_date DATE        NOT NULL,
  to_date   DATE,
  CONSTRAINT pk_titles PRIMARY KEY (emp_no, title, from_date),
  CONSTRAINT fk_titles_emp FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE salaries (
  emp_no    INT  NOT NULL,
  salary    INT,
  from_date DATE NOT NULL,
  to_date   DATE,
  CONSTRAINT pk_salaries PRIMARY KEY (emp_no, from_date),
  CONSTRAINT fk_salaries_emp FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE dept_emp (
  emp_no    INT     NOT NULL,
  dept_no   CHAR(4) NOT NULL,
  from_date DATE,
  to_date   DATE,
  CONSTRAINT pk_dept_emp PRIMARY KEY (emp_no, dept_no),
  CONSTRAINT fk_dept_emp_emp  FOREIGN KEY (emp_no)  REFERENCES employees(emp_no),
  CONSTRAINT fk_dept_emp_dept FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- no FK on emp_no coz it doesnt exist in employee.csv
CREATE TABLE dept_manager (
  emp_no    INT     NOT NULL,
  dept_no   CHAR(4) NOT NULL,
  from_date DATE,
  to_date   DATE,
  CONSTRAINT pk_dept_manager PRIMARY KEY (emp_no, dept_no),
  CONSTRAINT fk_dept_manager_dept FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);