use employees;

select distinct title from titles;

select distinct last_name
FROM employees
ORDER BY last_name DESC
LIMIT 10;

SELECT * FROM employees
WHERE hire_date > '1990' AND hire_date < '2000' AND birth_date like '%12-25'
ORDER BY birth_date ASC, hire_date DESC
LIMIT 5;

SELECT * FROM employees
WHERE hire_date > '1990' AND hire_date < '2000' AND birth_date like '%12-25'
ORDER BY birth_date ASC, hire_date DESC
LIMIT 5 OFFSET 45;
