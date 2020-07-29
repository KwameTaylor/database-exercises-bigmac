USE employees;

SELECT *
FROM titles;

SELECT COUNT(*), COUNT(title)
FROM titles;

SELECT title
FROM titles
WHERE title = 'Staff';

SELECT COUNT(title)
from titles
WHERE title = 'Staff';

SELECT title
FROM titles
WHERE title IN ('Staff', 'Manager');

SELECT title, COUNT(title)
FROM titles
WHERE title IN ('Staff', 'Manager')
GROUP BY title;

SELECT title, COUNT(title) as total
FROM titles
GROUP BY title;

SELECT SUM(subtotal.total) AS total_rows
	FROM (SELECT title, COUNT(title) as total
		FROM titles
		GROUP BY title
	) AS subtotal;
	
SELECT *
FROM salaries
LIMIT 50;

SELECT DISTINCT title
FROM titles;

SELECT last_name 
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY last_name;

SELECT CONCAT(first_name, ' ', last_name) AS unique_full_names
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY unique_full_names ASC;

SELECT last_name
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name;

SELECT last_name, COUNT(last_name)
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name
ORDER BY COUNT(last_name);

SELECT COUNT(*), gender
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY gender;

SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1), 
						SUBSTR(last_name, 1, 4), 
						'_',
						SUBSTR(birth_date, 6, 2), 
						SUBSTR(birth_date, 3, 2)
					)) AS user_name
FROM employees; 

SELECT DISTINCT LOWER(CONCAT(SUBSTR(first_name, 1, 1), 
						SUBSTR(last_name, 1, 4), 
						'_',
						SUBSTR(birth_date, 6, 2), 
						SUBSTR(birth_date, 3, 2)
					)) AS user_name
FROM employees;

SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1), 
						SUBSTR(last_name, 1, 4), 
						'_',
						SUBSTR(birth_date, 6, 2), 
						SUBSTR(birth_date, 3, 2)
					)) AS user_name
FROM employees
GROUP BY user_name;

SELECT CONCAT(LOWER(SUBSTR(first_name, 1, 1)), 
					LOWER(SUBSTR(last_name, 1, 4)), "_", 
					SUBSTR(birth_date, 6, 2),
					SUBSTR(birth_date, 3, 2)) AS username, 
					COUNT(*) as username_count
        FROM employees
        GROUP BY username
        HAVING username_count > 1
        ORDER BY username_count DESC;
        
        SELECT sum(temp.username_count) AS total_users_with_duplicated_usernames, 
		COUNT(temp.username_count) AS distinct_usernames_that_are_duplicated, 
		sum(temp.username_count) - COUNT(temp.username_count) AS number_of_users_who_need_unique_usernames
FROM (SELECT CONCAT(LOWER(SUBSTR(first_name, 1, 1)), 
					LOWER(SUBSTR(last_name, 1, 4)), "_", 
					SUBSTR(birth_date, 6, 2),
					SUBSTR(birth_date, 3, 2)) AS username, 
					COUNT(*) as username_count
        FROM employees
        GROUP BY username
        ORDER BY username_count DESC
) as temp
WHERE username_count > 1;