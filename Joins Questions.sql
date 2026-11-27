-- 1. Basic Inner Join (orders & product): Write a query to display the order_id, order_date, amount, 
-- and product_name for all orders that have a matching product_id.   --

select * from orders;
select * from customers;
select * from employees;
select * from products;

select o.order_id, o.order_date,o.amount,p.product_name from orders o join products p on o.product_id=p.product_id;

-- 2. Inner Join with Filtering (orders & customers): Write a query to list the emp_name, order_id, and amount for all 
-- orders where order_payment_type is 'upi' (matching orders.cust_id with customers.emp_id).
select e.emp_name, o.order_id,o.amount from orders o join employees e on o.cust_id=e.emp_id
where order_payment_type='UPI';

-- 3. Left Join (orders to product): Write a query to retrieve all order_ids along with their product_name, ensuring that orders with a product_id missing 
-- from the product table are still included in the result

select o.order_id,p.product_name from orders o right  join products p on o.product_id=p.product_id;

-- 4. Finding Unmatched Products (product to orders): Using a LEFT JOIN, find the product_id and product_name of
-- any product that has never been ordered.

select o.order_id,p.product_name from products p  left  join orders o on o.product_id=p.product_id;

-- 5. Finding Inactive Customers (customers to orders): Using a LEFT JOIN, find the emp_id and emp_name of all customers 
-- who have not placed any orders.

select e.emp_id,e.emp_name from employees e   left join orders o on o.cust_id=e.emp_id where o.cust_id is null;

-- 6. Three-Table Inner Join (customers, orders, & product): Write a query to display emp_name, product_name, order_date, and amount for 
-- all records that have valid matches across all three tables

select e.emp_name, p.product_name, o.order_date,o.amount from employees e join orders o on e.emp_id=o.cust_id
join products p on o.product_id=p.product_id;

-- 7. Join with Aggregation (customers & orders): Write a query to calculate the total amount spent by each customer, 
-- displaying their emp_name and total order amount.

select p.emp_name,sum(o.amount) from orders o  join employees p on o.cust_id=p.emp_id group by p.emp_name;

-- 8. Self Join (customers): Write a query to display each customer's emp_name alongside their manager's name by joining the customers
 -- table to itself using manager_id and emp_id.
 
 select m.emp_name, e.emp_name as Manager_Name from employees e join employees m on e.emp_id=m.manager_id;
select * from employees;

-- 9. Join with a WHERE Subquery (orders & product): Write a query to display the order_id, amount, and product_name for all orders whose 
-- amount is greater than the average amount of all orders.
select * from orders;
select o.order_id,o.amount, p.product_name from orders o join products p on o.product_id=p.product_id
where o.amount>(select avg(amount) from orders);

-- 10. Join with a FROM Subquery (customers & orders): Write a query to find the emp_name and total order count of customers who have
-- placed more than one order, by joining the customers table with a derived table that groups orders by cust_id.

select e.emp_name, count(o.cust_id) from employees e join orders o on e.emp_id=o.cust_id group by e.emp_id;
select * from (select e.emp_name, count(o.cust_id) from employees e join orders o on e.emp_id=o.cust_id group by cust_id) t1;

-- Print Department name, location and maximum salary from employees using joins--
select d.dept_id, max(e.salary) from employees e join (select dept_id,  max(salary) as max_salary from employees
group by dept_id)  dm on dm.dept_id=e.dept_id join department d on d.dept_id=e.dept_id
where dm.max_salary>e.salary group by d.dept_id;

select * from employees e join (select dept_id,  max(salary) as max_salary from employees
group by dept_id)  dm on dm.dept_id=e.dept_id join department d on d.dept_id=e.dept_id
where dm.max_salary>e.salary ;

select * from employees e where e.salary =(select max(salary) from employees
group by dept_id and e.salary>(select max(salary) from employees));

select * from employees e where 1=(select count(*) from employees where salary>e.salary and dept_id=e.dept_id);

select * from employees;
-- INTERMEDIATE TO ADVANCE QUESTIONS --
select order_id, order_date, amount, emp_name, product_name
from employees e  join orders o on e.emp_id=o.cust_id left join products p
on p.product_id=o.product_id;

select e.emp_name, e.salary,m.emp_name,m.salary from employees e join
employees m on e.salary>m.salary and e.manager_id=m.emp_id;

select emp_name,salary,total.maximum from employees e join (
select cust_id, max(amount) as maximum from orders group by cust_id) total on 
total.cust_id=e.emp_id;

select p.product_name,sum(amount) as total from orders o join products p on 
o.product_id=p.product_id and (o.order_payment_type='Upi' or
o.order_payment_type='card')
group by p.product_name having total>2000;
select * from employees ;
select * from orders ;

select emp_name,p.product_name from employees e left join orders o 
on e.emp_id=o.cust_id left join 
products p on p.product_id=o.product_id;

select m.emp_name as Manager,sum(o.amount)  from employees e inner
join employees m on m.emp_id=e.manager_id inner join orders o on 
o.cust_id=e.emp_id group by m.emp_name ;

SELECT 
    m.emp_name AS manager_name,
    SUM(o.amount) AS team_total_spending
FROM employees m
INNER JOIN employees e 
    ON m.emp_id = e.manager_id
INNER JOIN orders o 
    ON e.emp_id = o.cust_id
GROUP BY m.emp_name;

select * from orders;
select e.* from employees e join orders o on e.emp_id=o.cust_id join products p 
on p.product_id=o.product_id where
 o.amount=(select max(amount) from orders);
 
 select avg(amount) from orders group by cust_id;
 select sum(amount) from orders group by cust_id;
 
select * from employees e join 
(select cust_id,  avg(amount) as avg_amount from orders group by cust_id) average
on e.emp_id=average.cust_id
join (select o.cust_id, sum(amount) as total_sum from orders o group by cust_id) total
on total.cust_id=average.cust_id
where total.total_sum>=average.avg_amount;


-- omparing Against Average Spend (Derived Table Joins): Write a query using joins and derived tables to find the emp_name and total spending of customers whose total order amount 
-- is greater than the average total spending of all customers who have placed orders.
select * from employees e join 
 (select o.cust_id, sum(amount) as total_sum from orders o group by cust_id) total
on e.emp_id=total.cust_id
where total.total_sum>=(select avg(amount) as avg_amount from orders);

select * from orders o join orders p on o.cust_id=p.cust_id;

-- CASE WHEN --

select e.*,d.dept_name,
case 
when d.dept_name in ('Finance','IT')
then 'Technical'
when d.dept_name in ('Sales','HR')
then 'Non-Technical' 
else 'OTHER'
end as 'Dept_Category'
 from employees e right join department d 
on e.dept_id=d.dept_id;
