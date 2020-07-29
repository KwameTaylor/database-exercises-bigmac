USE employees;

SELECT dept_emp.emp_no
		, max(dept_emp.to_date) AS last_date_of_employment
		, max(CASE WHEN dept_emp.to_date > curdate() THEN 1 ELSE 0 END) 
			AS is_current_emp
FROM dept_emp
GROUP BY dept_emp.emp_no;

SELECT dept_emp.emp_no
		, max(employees.hire_date) AS start_date
		, max(dept_emp.to_date) AS end_date
		, max(CASE WHEN dept_emp.to_date > curdate() THEN 1 ELSE 0 END) 
			AS is_current_emp
			FROM dept_emp
JOIN employees USING(emp_no)
GROUP BY dept_emp.emp_no;

SELECT emp.emp_no, d.dept_no, emp.start_date, emp.end_date, emp.is_current_emp
FROM dept_emp d 
JOIN 
(SELECT dept_emp.emp_no # dept.dept_no
		, max(employees.hire_date) AS start_date
		, max(dept_emp.to_date) AS end_date
		, max(CASE WHEN dept_emp.to_date > curdate() THEN 1 ELSE 0 END) 
			AS is_current_emp
FROM dept_emp
JOIN employees USING(emp_no)
GROUP BY dept_emp.emp_no #, dept.dept_no
) emp
ON d.emp_no = emp.emp_no AND d.to_date = emp.end_date
;

USE employees;

SELECT first_name, last_name, substr(last_name, 1, 1) AS last_initial
    , CASE WHEN last_name REGEXP '^[A-H]' THEN 'A-H'
        WHEN last_name REGEXP '^[I-Q]' THEN 'I-Q'
        WHEN last_name REGEXP '^[R-Z]' THEN 'R-Z' 
        ELSE null
        END AS alpha_group 
FROM employees;

SELECT first_name, 
	   last_name,
	   CASE WHEN SUBSTR(last_name, 1, 1) < 'I' THEN 'A-H'
	   		WHEN SUBSTR(last_name, 1, 1) < 'R' THEN 'I-Q'
	   		WHEN SUBSTR(last_name, 1, 1) > 'Q' THEN 'R-Z'
	   		ELSE null END AS alpha_group
FROM employees
ORDER BY alpha_group;

SELECT MIN(birth_date), MAX(birth_date) FROM employees; 

SELECT 
	sum(CASE WHEN YEAR(birth_date) >= 1950 AND YEAR(birth_date) < 1960 THEN 1 ELSE null end) as fifties, 
	sum(CASE WHEN YEAR(birth_date) >= 1960 AND YEAR(birth_date) < 1970 THEN 1 ELSE null end) as sixties 
FROM employees;

select count(birth_date)
	, case when birth_date like '195%' then '1950s'
		when birth_date like '196%' then '1960s'
		end as birth_decade
FROM employees
group by birth_decade;