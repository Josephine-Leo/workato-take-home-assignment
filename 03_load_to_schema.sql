-- departments
MERGE INTO departments AS t
USING (SELECT dept_no, dept_name FROM stg_departments) AS s
ON t.dept_no = s.dept_no
WHEN MATCHED THEN
  UPDATE SET dept_name = s.dept_name
WHEN NOT MATCHED THEN
  INSERT (dept_no, dept_name) VALUES (s.dept_no, s.dept_name);

-- employees
MERGE INTO employees AS t
USING (
  SELECT emp_no::INT          AS emp_no,
         birth_date::DATE     AS birth_date,
         first_name, last_name,
         gender::gender_enum  AS gender,
         hire_date::DATE      AS hire_date
  FROM stg_employees
) AS s
ON t.emp_no = s.emp_no
WHEN MATCHED THEN
  UPDATE SET birth_date = s.birth_date, first_name = s.first_name,
             last_name = s.last_name, gender = s.gender, hire_date = s.hire_date
WHEN NOT MATCHED THEN
  INSERT (emp_no, birth_date, first_name, last_name, gender, hire_date)
  VALUES (s.emp_no, s.birth_date, s.first_name, s.last_name, s.gender, s.hire_date);

-- titles
MERGE INTO titles AS t
USING (
  SELECT emp_no::INT AS emp_no, title,
         from_date::DATE AS from_date, to_date::DATE AS to_date
  FROM stg_titles
) AS s
ON t.emp_no = s.emp_no AND t.title = s.title AND t.from_date = s.from_date
WHEN MATCHED THEN
  UPDATE SET to_date = s.to_date
WHEN NOT MATCHED THEN
  INSERT (emp_no, title, from_date, to_date)
  VALUES (s.emp_no, s.title, s.from_date, s.to_date);

-- salaries
MERGE INTO salaries AS t
USING (
  SELECT emp_no::INT AS emp_no, salary::INT AS salary,
         from_date::DATE AS from_date, to_date::DATE AS to_date
  FROM stg_salaries
) AS s
ON t.emp_no = s.emp_no AND t.from_date = s.from_date
WHEN MATCHED THEN
  UPDATE SET salary = s.salary, to_date = s.to_date
WHEN NOT MATCHED THEN
  INSERT (emp_no, salary, from_date, to_date)
  VALUES (s.emp_no, s.salary, s.from_date, s.to_date);

-- dept_emp
MERGE INTO dept_emp AS t
USING (
  SELECT emp_no::INT AS emp_no, dept_no,
         from_date::DATE AS from_date, to_date::DATE AS to_date
  FROM stg_dept_emp
) AS s
ON t.emp_no = s.emp_no AND t.dept_no = s.dept_no
WHEN MATCHED THEN
  UPDATE SET from_date = s.from_date, to_date = s.to_date
WHEN NOT MATCHED THEN
  INSERT (emp_no, dept_no, from_date, to_date)
  VALUES (s.emp_no, s.dept_no, s.from_date, s.to_date);

-- dept_manager (ids kept exactly as given)
MERGE INTO dept_manager AS t
USING (
  SELECT emp_no::INT     AS emp_no,
         dept_no,
         from_date::DATE AS from_date,
         to_date::DATE   AS to_date
  FROM stg_dept_manager
) AS s
ON t.emp_no = s.emp_no AND t.dept_no = s.dept_no
WHEN MATCHED THEN
  UPDATE SET from_date = s.from_date, to_date = s.to_date
WHEN NOT MATCHED THEN
  INSERT (emp_no, dept_no, from_date, to_date)
  VALUES (s.emp_no, s.dept_no, s.from_date, s.to_date);