show tables from practice;
use practice;

select * from department;
select * from employees;
select * from orders;

-- Question 1: Find all employees from Delhi

SELECT *
FROM employees
WHERE dept_id = 2;

-- Question 2: Find employees earning
-- more than 40000

SELECT *
FROM employees
WHERE salary > 70000;

-- Question 3: Calculate average salary

SELECT AVG(salary) AS average_salary
FROM employees;