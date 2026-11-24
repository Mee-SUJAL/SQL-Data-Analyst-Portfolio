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

-- USING MULTIPLE AGGREGATIONS --
SELECT AVG(SALARY), SUM(SALARY), MAX(SALARY), MIN(SALARY) 
FROM employees;

-- YOU CAN GIVE ALIAS ALSO WHICH WORKS AS A TEMPORARY NAME OF A COLUMN --
 SELECT AVG(SALARY) as Average, SUM(SALARY) Total_Salary, MAX(SALARY) Maximum_Salary, MIN(SALARY) Minimum_salary
FROM employees; -- You can use 'as' or you don't it your choice --

-- HAVING CLAUSE :- This clause provides you the condition on your Aggregated table --
SELECT SUM(SALARY) as Total_salary
FROM employees group by dept_id having  Total_salary>100000;  -- IT returns the total salary which is more than 100000

-- LOGICAL OPERATORS IN SQL --
-- IN Operator --
select * from employees where emp_name in ('Alice','bob','Frank','hannah');

-- NOT IN Operator -- 
select * from employees where emp_name not in ('Alice','bob','Frank','hannah'); -- It will return only the people who does not belong to the in condition


-- Or operato --
select * from employees where dept_id = 2 or emp_name= 'Bob'; -- It will return the condition which is true, will return both if they are true

-- And Operator --
select * from employees where dept_id =1 and emp_name='Alice'; -- it will only return the condition which is true 
select * from employees where dept_id =1 and emp_name='Bob'; -- here only dept_id is true 
select * from employees where dept_id =1 and dept_id=3; -- here you cannot give both same condtion

-- less than operator is to compare both --



