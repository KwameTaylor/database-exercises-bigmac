use employees;

SELECT *
FROM employees
WHERE hire_date = (
    SELECT hire_date
	FROM employees
	WHERE emp_no = 101010
);

SELECT title
FROM titles
WHERE emp_no IN (
	SELECT emp_no
	FROM employees
	WHERE first_name = "Aamod"
);

ELECT DISTINCT title as "Distinct Titles"
FROM titles
WHERE emp_no IN (
	SELECT emp_no
	FROM employees
	WHERE first_name = "Aamod"
);

SELECT title, count(*)
FROM titles
WHERE emp_no IN (
	SELECT emp_no
	FROM employees
	WHERE first_name = "Aamod"
)
GROUP BY title;

SELECT *
FROM employees
WHERE emp_no NOT IN (
	SELECT emp_no
	FROM dept_emp
	WHERE to_date > curdate()
);

SELECT first_name, last_name
FROM employees 
WHERE emp_no IN (
	SELECT emp_no
	FROM dept_manager
	WHERE emp_no IN (
		SELECT emp_no
		FROM employees
		WHERE gender = 'F'
	)
	AND to_date > CURDATE()
);

SELECT first_name, last_name, salary
FROM employees
JOIN salaries on salaries.emp_no = employees.emp_no
WHERE salary > (
	SELECT AVG(salary)
	FROM salaries
)
AND to_date > curdate();

SELECT max(salary)
FROM salaries;

SELECT STDDEV(salary)
FROM salaries;

SELECT *
FROM salaries
WHERE salary > (158220 - 16904.8282)
AND to_date > curdate();

SELECT *
FROM salaries
WHERE salary >= 
(
	(SELECT max(salary) FROM salaries) - (SELECT STDDEV(salary) FROM salaries)
)
AND to_date > curdate();

# What percentage of salaries is this?
# It seems to be !00 perfect
	SELECT count(*) as "num_salaries_1_stddev_below_max", 
	(count(*) / (SELECT count(*) FROM salaries)) * 100 as "percentage_of_current_salaries"
	FROM salaries
	WHERE salary >= 
	(
		(SELECT max(salary) FROM salaries) - (SELECT STDDEV(salary) FROM salaries)
	)
	AND to_date > curdate();