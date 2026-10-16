-- 1. List all employees for each department with their first name, last name, emp no, dept no & name
SELECT e.first_name, e.last_name, e.emp_no, d.dept_no, d.dept_name
FROM employees e
JOIN dept_emp de   ON de.emp_no = e.emp_no
JOIN departments d ON d.dept_no = de.dept_no
ORDER BY d.dept_no, e.emp_no;

-- 400

-- 2. List all employees where their salary exceeds the salary of their manager
SELECT e.emp_no, e.first_name, e.last_name,
       es.salary AS employee_salary, ms.salary AS manager_salary
FROM employees e
JOIN dept_emp de     ON de.emp_no = e.emp_no AND de.to_date = '9999-01-01'
JOIN dept_manager dm ON dm.dept_no = de.dept_no AND dm.to_date = '9999-01-01'
JOIN salaries es     ON es.emp_no = e.emp_no AND es.to_date = '9999-01-01'
JOIN salaries ms     ON ms.emp_no = dm.emp_no AND ms.to_date = '9999-01-01'
WHERE es.salary > ms.salary;

-- 0 (issue with manager employee id)

-- 3. List highest salaried employees for each department
SELECT d.dept_no, d.dept_name, e.emp_no, e.first_name, e.last_name, s.salary
FROM employees e
JOIN dept_emp de   ON de.emp_no = e.emp_no AND de.to_date = '9999-01-01'
JOIN departments d ON d.dept_no = de.dept_no
JOIN salaries s    ON s.emp_no = e.emp_no AND s.to_date = '9999-01-01'
WHERE s.salary = (
  SELECT MAX(s2.salary)
  FROM dept_emp de2
  JOIN salaries s2 ON s2.emp_no = de2.emp_no AND s2.to_date = '9999-01-01'
  WHERE de2.dept_no = de.dept_no AND de2.to_date = '9999-01-01'
)
ORDER BY d.dept_no;

-- 8

-- 4. List all employees that don't have a manager
SELECT e.emp_no, e.first_name, e.last_name
FROM employees e
LEFT JOIN dept_emp de     ON de.emp_no = e.emp_no
LEFT JOIN dept_manager dm ON dm.dept_no = de.dept_no
WHERE dm.dept_no IS NULL;

-- 37

-- 5. List all employees who are their own manager
SELECT e.emp_no, e.first_name, e.last_name, de.dept_no
FROM employees e
JOIN dept_emp de     ON de.emp_no = e.emp_no
JOIN dept_manager dm ON dm.dept_no = de.dept_no AND dm.emp_no = e.emp_no;

-- 0 (manager id issue)

-- 6. List all employees who have been hired prior to their manager
SELECT e.emp_no, e.first_name, e.last_name, e.hire_date,
       m.emp_no AS manager_emp_no, m.hire_date AS manager_hire_date
FROM employees e
JOIN dept_emp de     ON de.emp_no = e.emp_no
JOIN dept_manager dm ON dm.dept_no = de.dept_no
JOIN employees m     ON m.emp_no = dm.emp_no
WHERE e.hire_date < m.hire_date;

-- 0 (manager id issue)