use noob_db;

show tables;

select * from employees_v4;
select * from dept_v4;

select dept_id, sum(salary) as total_salary from employees_v4
group by dept_id
having sum(salary) > 100000;

select * from (
select dept_id, sum(salary) as total_salary from employees_v4
group by dept_id)t
where total_salary > 100000;

select dept_id,
       max(salary) as max_salary,
       min(salary) as min_salary,
       avg(salary) as avg_salary,
       sum(salary) as total_salary,
       count(*) as count
from employees_v4
group by dept_id;

-- CREATE DATABASE IF NOT exists my_retail_db;
-- select coalesce(null, null) from 1;

# Examples for join
create table orders
(
    order_id int,
    cust_id int,
    order_dat date, 
    shipper_id int
);

create table customers
(
    cust_id int,
    cust_name varchar(50),
    country varchar(50)
);

create table shippers
(
    ship_id int,
    shipper_name varchar(50)
);

insert into orders values(10308, 2, '2022-09-15', 3);
insert into orders values(10309, 30, '2022-09-16', 1);
insert into orders values(10310, 41, '2022-09-19', 2);

insert into customers values(1, 'Neel', 'India');
insert into customers values(2, 'Nitin', 'USA');
insert into customers values(3, 'Mukesh', 'UK');

insert into shippers values(3,'abc');
insert into shippers values(1,'xyz');


select * from customers;
select * from shippers;

# perform inner JOIN
# get the customer informations for each order order, if value of customer is present in orders TABLE
select * from orders;
select * from customers;

select o.*, c.*
from orders o inner join customers c
on o.cust_id = c.cust_id;

select o.*, c.*
from orders o left join customers c
on o.cust_id = c.cust_id;

select o.*, c.*
from orders o right join customers c
on o.cust_id = c.cust_id;

# get the customer informations for each order order, if value of customer is present in orders TABLE
# also get the information of shipper name

select o.*, c.*, s.*
from orders o inner join customers c
on o.cust_id = c.cust_id
inner join shippers s
on o.shipper_id = s.ship_id;

select o.*, c.*, s.*
from orders o left join customers c
on o.cust_id = c.cust_id
left join shippers s
on o.shipper_id = s.ship_id;

select o.*, s.*
from orders o inner join shippers s
on o.shipper_id = s.ship_id;
###################################################################################################
create table employees_full_data
(
    emp_id int,
    name varchar(50),
    mgr_id int
);

insert into employees_full_data values(1, 'Shashank', 3);
insert into employees_full_data values(2, 'Amit', 3);
insert into employees_full_data values(3, 'Rajesh', 4);
insert into employees_full_data values(4, 'Ankit', 6);
insert into employees_full_data values(6, 'Nikhil', null);

select * from employees_full_data;

select emp.emp_id, emp.name as emp_name, emp.mgr_id as mngr_id, mngr.name as mngr_name
from employees_full_data emp inner join employees_full_data mngr
on mngr.emp_id = emp.mgr_id;

# Write a query to print the distinct names of managers.
select distinct mgr_id as mgr_id from employees_full_data;

select emp.name as mngr_name
from employees_full_data as emp inner join (select distinct mgr_id as mgr_id from employees_full_data) as mgr
on mgr.mgr_id = emp.emp_id;

# Write a query to print the distinct names of managers.
-- much more convient to me
select distinct mgr.name as mngr_name
from employees_full_data emp inner join employees_full_data mgr
on emp.mgr_id = mgr.emp_id;
######################################################################################################################################
USE noob_db;

SELECT * FROM shop_sales_data;

SELECT
	*,
	SUM(sales_amount) OVER() AS GRANT_TOTAL_SALES,
    SUM(sales_amount) OVER(ORDER BY sales_amount DESC) AS SINGLE_WINDOW_RUNNING_SUM
FROM shop_sales_data;

SELECT
	*,
    SUM(sales_amount) OVER(PARTITION BY shop_id) AS OP
FROM shop_sales_data;

SELECT
	*,
    SUM(sales_amount) OVER(PARTITION BY shop_id ORDER BY sales_amount DESC) AS OP
FROM shop_sales_data;

####################################################################################################
SELECT * FROM amazon_sales_data;

# Query - Calculate the date wise rolling average of amazon sales

SELECT 
	*,
    AVG(sales_amount) OVER(ORDER BY sales_date ASC) AS ROLLING_AVG_SALES_AMOUNT,
    SUM(sales_amount) OVER(ORDER BY sales_date ASC) AS ROLLING_SUM_SALES_AMOUNT
FROM amazon_sales_data;

# Rank(), Row_Number(), Dense_Rank() window functions
SELECT * FROM shop_sales_data;

# Query - get one employee from each department who is getting maximum salary (employee can be random if salary is same)
SELECT * FROM employees;

SELECT 
	*
FROM(
	SELECT
		*,
		ROW_NUMBER() OVER(PARTITION BY dept_name ORDER BY salary DESC) AS RANK_
	FROM employees) t
WHERE RANK_ = 1;

# Query - get all employees from each department who are getting maximum salary

SELECT 
	*
FROM(
	SELECT
		*,
		DENSE_RANK() OVER(PARTITION BY dept_name ORDER BY salary DESC) AS RANK_
	FROM employees) t
WHERE RANK_ = 1;

# Query - get all top 2 ranked employees from each department who are getting maximum salary
SELECT 
	*
FROM(
	SELECT
		*,
		DENSE_RANK() OVER(PARTITION BY dept_name ORDER BY salary DESC) AS RANK_
	FROM employees) t
WHERE RANK_ <= 2;

##########################################################################################################
-- LAG AND LEAD
SELECT * FROM daily_sales;

SELECT 
	*,
    sales_amount - next_day_sales AS DIFF
FROM(
	SELECT 
		*,
		LAG(sales_amount, 1) OVER(ORDER BY sales_date ASC) AS next_day_sales
	FROM daily_sales) t;

####################################################################################################################################
-- frame clause
SELECT * FROM daily_sales;

SELECT
	*,
    SUM(sales_amount) OVER(ORDER BY sales_date ASC ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS prev_plus_nxt_sales_sum
FROM daily_sales;

SELECT
	*,
    SUM(sales_amount) OVER(ORDER BY sales_date ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS till_day_sales_sum
FROM daily_sales;


SELECT
	*,
    SUM(sales_amount) OVER(ORDER BY sales_date ASC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS OP
FROM daily_sales;

SELECT
	*,
    SUM(sales_amount) OVER(ORDER BY sales_date ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS total_sales_amount,
    SUM(sales_amount) OVER(ORDER BY sales_date ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) - sales_amount AS exclude_curr_row_from_sum
FROM daily_sales;

-- RANGE BETWEEN
SELECT
	*,
    SUM(sales_amount) OVER(ORDER BY sales_amount ASC RANGE BETWEEN 200 PRECEDING AND 200 FOLLOWING) AS op
FROM daily_sales;

# Calculate the running sum for a week

SELECT
	*,
    SUM(sales_amount) OVER(ORDER BY sales_date ASC RANGE BETWEEN INTERVAL 6 DAY PRECEDING AND CURRENT ROW) AS weekly_running_sum
FROM daily_sales;

SELECT
	*,
    SUM(sales_amount) OVER(ORDER BY sales_date ASC RANGE BETWEEN INTERVAL 29 DAY PRECEDING AND CURRENT ROW) AS monthly_running_sum
FROM daily_sales;


