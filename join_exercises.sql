use employees;

select title, count(title) as count
from titles
join dept_emp on dept_emp.emp_no = titles.emp_no
join departments on dept_emp.dept_no = departments.dept_no
where titles.to_date > curdate()
and dept_emp.to_date > curdate()
and departments.dept_name = 'Customer Service'
group by title;

select e.first_name, e.last_name
from employees e
join dept_manager dm on dm.emp_no = e.emp_no
join departments d on d.dept_no = dm.dept_no
where dm.to_date > curdate()
and gender = 'f';

select t.title, count(*)
from titles as t 
join dept_emp as de on de.emp_no = t.emp_no
join departments d on de.dept_no = d.dept_no
where de.to_date > curdate()
and t.to_date > curdate()
and d.dept_name = "Customer Service"
group by t.title;

select dept_name, first_name, last_name, salary
from employees
join dept_manager using(emp_no)
join departments using(dept_no)
join salaries using(emp_no)
where dept_manager.to_date > curdate()
and salaries.to_date > curdate()
order by dept_name;

select dept_no, dept_name, count(*)
from departments
join dept_emp using(dept_no)
where dept_emp.to_date > curdate()
group by dept_no;

select dept_name, avg(salary) as "Highest Avg Salary of All Departments"
from salaries
join dept_emp using(emp_no)
join departments using(dept_no)
where dept_emp.to_date > curdate()
and salaries.to_date > curdate()
group by dept_no
order by avg(salary) desc
limit 1;

select first_name, last_name
from employees
join dept_emp using(emp_no)
join departments using(dept_no)
join salaries using(emp_no)
where dept_name = "Marketing"
order by salary desc
limit 1;

select first_name, last_name, salary, dept_name
from employees
join dept_manager using(emp_no)
join salaries using(emp_no)
join departments using(dept_no)
where salaries.to_date > curdate()
and dept_manager.to_date > curdate()
order by salary desc
limit 1;