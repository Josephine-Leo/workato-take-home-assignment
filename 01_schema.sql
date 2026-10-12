DROP TABLE IF EXISTS titles;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    emp_no INT PRIMARY KEY,
    birth_date DATE,
    first_name VARCHAR(14),
    last_name VARCHAR(16),
    gender CHAR(1) CHECK (gender IN ('M', 'F')),
    hire_date DATE
);

CREATE TABLE titles (
    title VARCHAR(50),
    from_date DATE,
    to_date DATE,
    emp_no INT,

    CONSTRAINT pk_title_date PRIMARY KEY (title, from_date),
    CONSTRAINT fk_emp_no FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE dept_emp (
    dept_no CHAR(4),
    from_date DATE,
    to_date DATE,
    emp_no INT,

    CONSTRAINT fk_emp_no FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE departments(
    dept_no CHAR(4) PRIMARY KEY,
    dept_name VARCHAR(40)
);

CREATE TABLE dept_manager (
    from_date DATE,
    to_date DATE,
    emp_no INT,
    dept_no CHAR(4),

    CONSTRAINT fk_emp_no FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    CONSTRAINT fk_dept_no FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE salaries (
    from_date DATE PRIMARY KEY,
    to_date DATE,
    salary INT,
    emp_no INT,

    CONSTRAINT fk_emp_no FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);