use todo_db;
-- starting with Q. 38
##########################################################################################################################################
create table if not exists departments(
			id int,
            name varchar(50),
            primary key (id));
            
create table if not exists students(
			 id int,
             name varchar(50),
             department_id int,
             primary key (id));

INSERT INTO departments (id, name) VALUES
    (1, 'Electrical Engineering'),
    (7, 'Computer Engineering'),
    (13, 'Business Administration');

INSERT INTO students (id, name, department_id) VALUES
    (23, 'Alice', 1),
    (1, 'Bob', 7),
    (5, 'Jennifer', 13),
    (2, 'John', 14),
    (4, 'Jasmine', 77),
    (3, 'Steve', 74),
    (6, 'Luis', 1),
    (8, 'Jonathan', 7),
    (7, 'Daiana', 33),
    (11, 'Madelynn', 1);

select * from departments;
select * from students;

-- Write an SQL query to find the id and the name of all students who are enrolled in departments that no
-- longer exist.
-- Return the result table in any order.
SELECT s.id, s.name
FROM students s
WHERE department_id NOT IN  (SELECT id FROM departments);
################################################################################################################################################
create table if not exists calls(
            from_id int,
            to_id int,
            duration int);

INSERT INTO calls (from_id, to_id, duration) VALUES
    (1, 2, 59),
    (2, 1, 11),
    (1, 3, 20),
    (3, 4, 100),
    (3, 4, 200),
    (3, 4, 200),
    (4, 3, 499);

select * from calls;

-- Write an SQL query to report the number of calls and the total call duration between each pair of
-- distinct persons (person1, person2) where person1 < person2.
-- Return the result table in any order.

SELECT person1, person2, count(*) AS call_count, sum(duration) AS total_duration FROM(
	SELECT
		CASE WHEN from_id < to_id THEN from_id ELSE to_id END AS person1,
		CASE WHEN from_id < to_id THEN to_id ELSE from_id END AS person2,
		duration
	FROM calls) t
GROUP BY person1, person2;
###################################################################################################################################################
create table if not exists warehouse(
           name varchar(50),
		   product_id int,
		   units int,
           primary key (name, product_id));

create table if not exists products41(
		product_id int,
		product_name varchar(50),
		Width int NOT NULL,
		Length int NOT NULL,
		Height int NOT NULL,
        primary key (product_id));


INSERT INTO warehouse (name, product_id, units) VALUES
    ('LCHouse1', 1, 1),
    ('LCHouse1', 2, 10),
    ('LCHouse1', 3, 5),
    ('LCHouse2', 1, 2),
    ('LCHouse2', 2, 2),
    ('LCHouse3', 4, 1);

INSERT INTO products41 (product_id, product_name, Width, Length, Height) VALUES
    (1, 'LC-TV', 5, 50, 40),
    (2, 'LC-KeyChain', 5, 5, 5),
    (3, 'LC-Phone', 2, 10, 10),
    (4, 'LC-T-Shirt', 4, 10, 20);

SELECT * FROM warehouse;
SELECT * FROM products41;

-- Write an SQL query to report the number of cubic feet of volume the inventory occupies in each
-- warehouse.
-- Return the result table in any order.
SELECT name, sum(volume) as volume
	FROM(
		SELECT w.*, p.product_name, p.Width, p.Length, p.Height, p.Width*p.Length*p.Height*w.units AS volume
			FROM warehouse w LEFT JOIN products41 p
			ON w.product_id = p.product_id) t
GROUP BY name;
######################################################################################################################################################
create table if not exists sales42(
		sale_date date,
		fruit enum ("apples", "oranges"),
		sold_num int,
        primary key (sale_date, fruit));

INSERT INTO sales42 (sale_date, fruit, sold_num) VALUES
    ('2020-05-01', 'apples', 10),
    ('2020-05-01', 'oranges', 8),
    ('2020-05-02', 'apples', 15),
    ('2020-05-02', 'oranges', 15),
    ('2020-05-03', 'apples', 20),
    ('2020-05-03', 'oranges', 0),
    ('2020-05-04', 'apples', 15),
    ('2020-05-04', 'oranges', 16);

SELECT * FROM sales42;

-- Write an SQL query to report the difference between the number of apples and oranges sold each day.
-- Return the result table ordered by sale_date.
SELECT sale_date, diff 
	FROM (
		SELECT *,
			sold_num - LEAD(sold_num) OVER(PARTITION BY sale_date) AS diff
		FROM sales42) t
WHERE diff IS NOT NULL;
#########################################################################################################################################################
create table if not exists activity43(
		player_id int,
		device_id int,
		event_date date,
		games_played int,
        primary key (player_id, event_date));

INSERT INTO activity43 (player_id, device_id, event_date, games_played) VALUES
    (1, 2, '2016-03-01', 5),
    (1, 2, '2016-03-02', 6),
    (2, 3, '2017-06-25', 1),
    (3, 1, '2016-03-02', 0),
    (3, 4, '2018-07-03', 5);

SELECT * FROM activity43;

-- Write an SQL query to report the fraction of players that logged in again on the day after the day they
-- first logged in, rounded to 2 decimal places. In other words, you need to count the number of players
-- that logged in for at least two consecutive days starting from their first login date, then divide that
-- number by the total number of players.

WITH first_login AS (
	SELECT player_id, MIN(event_date) AS first_login_date
	FROM activity43
	GROUP BY player_id),
    
consecutive_logins AS (
	SELECT a.player_id, f.first_login_date, a.event_date AS second_login_date
	FROM activity43 a INNER JOIN first_login f 
	ON a.player_id = f.player_id
	WHERE DATEDIFF(a.event_date, f.first_login_date) = 1)

SELECT ROUND( COUNT( c.player_id ) / COUNT( f.player_id ), 2 ) AS fraction
FROM first_login f LEFT JOIN consecutive_logins c
ON f.player_id = c.player_id;

#########################################################################################################################################
CREATE TABLE IF NOT EXISTS employees44(
		id int,
		name varchar(50),
		department varchar(30),
		managerId int,
        primary key (id));

INSERT INTO employees44 (id, name, department, managerId) VALUES
    (101, 'John', 'A', NULL),
    (102, 'Dan', 'A', 101),
    (103, 'James', 'A', 101),
    (104, 'Amy', 'A', 101),
    (105, 'Anne', 'A', 101),
    (106, 'Ron', 'B', 101);

SELECT * FROM employees44;

-- Write an SQL query to report the managers with at least five direct reports.
-- Return the result table in any order.

-- using join
SELECT mangr_name AS name
FROM(
	SELECT mngr.name AS mangr_name, emp.name AS reportees  
	FROM employees44 emp INNER JOIN employees44 mngr
	ON emp.managerId = mngr.id) t
GROUP BY mangr_name
HAVING COUNT(*) >= 5;

-- using correlated subquery
SELECT mngr.name 
FROM employees44 AS mngr
WHERE (
    SELECT COUNT(*) 
    FROM employees44 AS emp
    WHERE emp.managerId = mngr.id
) >= 5;

############################################################################################################################
CREATE TABLE IF NOT EXISTS departments45(
		dept_id int,
		dept_name varchar(30),
        primary key (dept_id));
        
CREATE TABLE IF NOT EXISTS students45(
		student_id int,
		student_name varchar(50),
		gender varchar(20),
		dept_id int,
        primary key (student_id),
        foreign key (dept_id) references departments45 (dept_id));
        
INSERT INTO departments45 (dept_id, dept_name) VALUES
    (1, 'Engineering'),
    (2, 'Science'),
    (3, 'Law');

INSERT INTO students45 (student_id, student_name, gender, dept_id) VALUES
    (1, 'Jack', 'M', 1),
    (2, 'Jane', 'F', 1),
    (3, 'Mark', 'M', 2);

SELECT * FROM departments45;
SELECT * FROM students45;

-- Write an SQL query to report the respective department name and number of students majoring in
-- each department for all departments in the Department table (even ones with no current students).
-- Return the result table ordered by student_number in descending order. In case of a tie, order them by
-- dept_name alphabetically.

SELECT dept_name, 
		IFNULL( COUNT(student_name), 0 ) AS student_number
FROM (
	SELECT d.dept_name, s.student_name
	FROM departments45 d LEFT JOIN students45 s 
	ON d.dept_id = s.dept_id) t
GROUP BY dept_name
ORDER BY IFNULL( COUNT(student_name), 0 ) DESC, dept_name ASC;

#########################################################################################################################################
CREATE TABLE IF NOT EXISTS products46(
		product_key int,
        primary key (product_key));
        
CREATE TABLE IF NOT EXISTS customers46(
		customer_id int,
		product_key int,
        foreign key (product_key) references products46 (product_key));
        
INSERT INTO products46 (product_key) VALUES (5), (6);

INSERT INTO customers46 (customer_id, product_key) VALUES
	(1, 5),
    (2, 6),
    (3, 5),
    (3, 6),
    (1, 6);

select * from products46;
select * from customers46;

-- Write an SQL query to report the customer ids from the Customer table that bought all the products in
-- the Product table.
-- Return the result table in any order.

SELECT customer_id
FROM customers46
GROUP BY customer_id
HAVING COUNT( DISTINCT product_key ) = (SELECT COUNT(*) FROM products46);

############################################################################################################################################
CREATE TABLE IF NOT EXISTS employees47(
		employee_id int,
		name varchar(50),
		experience_years int,
        primary key (employee_id));

CREATE TABLE IF NOT EXISTS projects47(
		project_id int,
		employee_id int,
        primary key (project_id, employee_id),
        foreign key (employee_id) references employees47 (employee_id));
        
INSERT INTO employees47 (employee_id, name, experience_years) VALUES
    (1, 'Khaled', 3),
    (2, 'Ali', 2),
    (3, 'John', 3),
    (4, 'Doe', 2);

INSERT INTO projects47 (project_id, employee_id) VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 1),
    (2, 4);

SELECT * FROM employees47;
SELECT * FROM projects47;

-- Write an SQL query that reports the most experienced employees in each project. In case of a tie,
-- report all employees with the maximum number of experience years.
-- Return the result table in any order.

SELECT project_id, employee_id
FROM (
	SELECT *,
	DENSE_RANK() OVER(PARTITION BY project_id ORDER BY experience_years DESC) AS rank_
	FROM (
		SELECT e.*, p.project_id
		FROM projects47 P LEFT JOIN employees47 e
		ON p.employee_id = e.employee_id) t ) tt
WHERE rank_ = 1;
#################################################################################################################################
CREATE TABLE IF NOT EXISTS enrollments(
		student_id int,
		course_id int,
		grade int,
        primary key(student_id, course_id));

INSERT INTO enrollments (student_id, course_id, grade) VALUES
    (2, 2, 95),
    (2, 3, 95),
    (1, 1, 90),
    (1, 2, 99),
    (3, 1, 80),
    (3, 2, 75),
    (3, 3, 82);

SELECT * FROM enrollments;

-- Write a SQL query to find the highest grade with its corresponding course for each student. In case of
-- a tie, you should find the course with the smallest course_id.
-- Return the result table ordered by student_id in ascending order.

SELECT student_id, course_id, grade
FROM(
	SELECT *,
	DENSE_RANK() OVER(PARTITION BY student_id ORDER BY grade DESC, course_id ASC) AS rank_
	FROM enrollments) t
WHERE rank_ = 1;






























