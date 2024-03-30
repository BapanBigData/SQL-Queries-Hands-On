USE Interview_db;
################################################################################################################################

CREATE TABLE IF NOT EXISTS orders01(
		customer_id INT,
        order_date DATE
);

INSERT INTO orders01 values 
(1, '2023-01-01'),
(1, '2023-01-02'),
(2, '2023-02-10'),
(3, '2023-03-03'),
(3, '2023-03-05');

SELECT * FROM orders01;

-- write a SQL query to find the customers who have made at least 2 consecutive orders.
SELECT 
	DISTINCT customer_id
FROM (
SELECT
	*,
	DATEDIFF(order_date, LAG(order_date) OVER(PARTITION BY customer_id ORDER BY order_date)) AS diff
FROM orders01) t
WHERE diff = 1;
###########################################################################################################################################
## Combine Two Tables 
CREATE TABLE IF NOT EXISTS person (
    PersonId INT,
    FirstName VARCHAR(255),
    LastName VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS address (
    AddressId INT,
    PersonId INT,
    City VARCHAR(255),
    State VARCHAR(255)
);


-- Inserting demo data into the person table
INSERT INTO person VALUES
(1, 'John', 'Doe'),
(2, 'Jane', 'Smith'),
(3, 'Alice', 'Johnson');

-- Inserting demo data into the address table
INSERT INTO address VALUES
(1, 1, 'New York', 'NY'),
(2, 2, 'Los Angeles', 'CA'),
(3, 3, 'Chicago', 'IL');

select * from person;
select * from address;

-- Write a SQL query for a report that provides the following information for each
-- person in the Person table, regardless if there is an address for each of those
-- people: FirstName, LastName, City, State

SELECT
	p.FirstName,
    p.LastName,
    a.City,
    a.State
FROM 
	person p LEFT JOIN address a 
    ON p.PersonId = a.PersonId;
    
#######################################################################################################################
## 180. Consecutive Numbers 
## **Important**
-- **Write a SQL query to find all numbers that appear at least three times consecutively**.

CREATE TABLE IF NOT EXISTS Logs(
		Id INT,
        Num INT
);

INSERT INTO Logs VALUES (1, 1), (2, 1), (3, 1), (4, 2), (5, 1), (6, 2), (7, 2);

SELECT * FROM Logs;

SELECT
	DISTINCT c1.Num AS ConsecutiveNums
FROM 
	Logs AS c1 
    INNER JOIN 
    Logs AS c2
    ON c1.Num = c2.Num
    INNER JOIN
    Logs AS c3
    ON c2.Num = c3.Num
WHERE 
	c1.Id = c2.Id - 1 AND c2.Id = c3.Id - 1;

-- Optimized Soln
SELECT
	Num AS ConsecutiveNums
FROM (
	SELECT
		Num,
		(Id - ROW_NUMBER() OVER(PARTITION BY Num ORDER BY Id)) AS Gp
	FROM Logs
) AS t
GROUP BY Num, Gp
HAVING COUNT(*) > 2;

-- 
WITH ConsecutiveGroups AS (
    SELECT Num, 
           (Id - ROW_NUMBER() OVER (PARTITION BY Num ORDER BY Id)) AS grp
    FROM Logs
)
SELECT Num
FROM ConsecutiveGroups
GROUP BY Num, grp
HAVING COUNT(*) > 2;

#####################################################################################################################
## 181. Employees Earning More Than Their Managers 
-- employees earning more than their manager

CREATE TABLE IF NOT EXISTS employees01 (
    Id INT,
    Name VARCHAR(255),
    Salary INT,
    ManagerId INT
);

INSERT INTO employees01 VALUES
(1, 'Joe', 70000, 3),
(2, 'Henry', 80000, 4),
(3, 'Sam', 60000, NULL),
(4, 'Max', 90000, NULL);

SELECT * FROM employees01;

SELECT
	emp.Name
FROM 
	employees01 emp INNER JOIN employees01 mngr
    ON emp.ManagerId = mngr.Id
WHERE 
	emp.Salary > mngr.Salary;

############################################################################################################################
## 182. Duplicate Emails 
-- Write a SQL query to find all duplicate emails in a table named Person.
CREATE TABLE IF NOT EXISTS emails (
    Id INT,
    Email VARCHAR(255)
);

INSERT INTO emails VALUES
(1, 'a@b.com'),
(2, 'c@d.com'),
(3, 'a@b.com');

SELECT 
	Email 
FROM emails
GROUP BY Email
HAVING COUNT(*) > 1;
################################################################################################################################
## 183. Customers Who Never Order 
-- Suppose that a website contains two tables, the Customers table and the Orders
-- table. Write a SQL query to find all customers who never order anything.

CREATE TABLE IF NOT EXISTS Customers (
    Id INT,
    Name VARCHAR(255)
);

INSERT INTO Customers VALUES
(1, 'Joe'),
(2, 'Henry'),
(3, 'Sam'),
(4, 'Max');

CREATE TABLE IF NOT EXISTS Orders (
    Id INT,
    CustomerId INT
);

INSERT INTO Orders VALUES
(1, 3),
(2, 1);

SELECT * FROM Customers;
SELECT * FROM Orders;

-- customers who never orders

-- using join
SELECT
    c.Name as CustomerName
FROM 
	Customers c LEFT JOIN Orders o
    ON c.Id = o.CustomerId
WHERE o.Id IS NULL;

SELECT
	Name
FROM Customers
WHERE Id NOT IN (SELECT CustomerId FROM Orders);
#####################################################################################################################
## 196. Delete Duplicate Emails 
-- Delete duplicate emails

CREATE TABLE IF NOT EXISTS emails01 (
    Id INT,
    Email VARCHAR(255)
);

INSERT INTO emails01 VALUES
(1, 'john@example.com'),
(2, 'bob@example.com'),
(3, 'john@example.com');

SELECT * FROM emails01;

DELETE p1
FROM emails01 p1, emails01 p2
WHERE p1.Email = p2.Email and p1.Id > p2.Id;
###############################################################################################################################
## 197. Rising Temperature 
-- Given a Weather table, write a SQL query to find all dates' Ids with higher
-- temperature compared to its previous (yesterday's) dates.

CREATE TABLE Weather (
    Id INT,
    RecordDate DATE,
    Temperature INT
);

INSERT INTO Weather VALUES (1, '2015-01-01', 10);
INSERT INTO Weather VALUES (2, '2015-01-02', 25);
INSERT INTO Weather VALUES (3, '2015-01-03', 20);
INSERT INTO Weather VALUES (4, '2015-01-04', 30);

SELECT * FROM Weather;

SELECT
	today.Id
FROM 
	Weather as today INNER JOIN Weather yesterday
    ON DATEDIFF(today.RecordDate, yesterday.RecordDate) = 1 AND today.Temperature > yesterday.Temperature;
###############################################################################################################################################
## 511. Game Play Analysis I 
-- Write an SQL query that reports the first login date for each player.

CREATE TABLE Activity (
    player_id INT,
    device_id INT,
    event_date DATE,
    games_played INT,
    PRIMARY KEY (player_id, event_date)
);

INSERT INTO Activity (player_id, device_id, event_date, games_played)
VALUES
    (1, 2, '2016-03-01', 5),
    (1, 2, '2016-05-02', 6),
    (2, 3, '2017-06-25', 1),
    (3, 1, '2016-03-02', 0),
    (3, 4, '2018-07-03', 5);
    
SELECT * FROM Activity;

SELECT
	player_id, MIN(event_date) as first_login
FROM activity
GROUP BY player_id;

## 512. Game Play Analysis II 
-- Write a SQL query that reports the device that is first logged in for each player.

SELECT
	player_id,
    device_id
FROM activity
WHERE (player_id, event_date) IN (
	SELECT
		player_id, MIN(event_date)
	FROM activity
	GROUP BY player_id
);

## 534. Game Play Analysis III 
-- Write an SQL query that reports for each player and date, how many games played
-- so far by the player. That is, the total number of games played by the player
-- until that date.

TRUNCATE TABLE Activity;

INSERT INTO Activity (player_id, device_id, event_date, games_played)
VALUES
    (1, 2, '2016-03-01', 5),
    (1, 2, '2016-05-02', 6),
    (1, 3, '2017-06-25', 1),
    (3, 1, '2016-03-02', 0),
    (3, 4, '2018-07-03', 5);

SELECT * FROM Activity;

SELECT
	player_id,
    event_date,
    SUM(games_played) OVER(PARTITION BY player_id ORDER BY event_date ASC) AS games_played_so_far
FROM Activity;

##############################################################################################################################################
## 570. Managers with at Least 5 Direct Reports 
-- The Employee table holds all employees including their managers. Every employee
-- has an Id, and there is also a column for the manager Id.

CREATE TABLE employees02 (
    Id INT,
    Name VARCHAR(50),
    Department VARCHAR(50),
    ManagerId INT
);

INSERT INTO employees02 (Id, Name, Department, ManagerId)
VALUES
    (101, 'John', 'A', NULL),
    (102, 'Dan', 'A', 101),
    (103, 'James', 'A', 101),
    (104, 'Amy', 'A', 101),
    (105, 'Anne', 'A', 101),
    (106, 'Ron', 'B', 101);

SELECT * FROM employees02;

-- write a SQL query that finds out managers with at least 5 direct report.

-- Using Join
SELECT
    mngr.Name as Name
FROM
	employees02 as emp INNER JOIN employees02 as mngr
    ON emp.ManagerId = mngr.Id
GROUP BY 
	mngr.Name
HAVING 
	COUNT(*) >= 5;

SELECT
	NAME
FROM employees02
WHERE Id IN (
	SELECT
		ManagerId 
	FROM employees02
	GROUP BY ManagerId
	HAVING COUNT(*) >= 5
);
###########################################################################################################################################
## 577. Employee Bonus 
###########################################################################################################################################
## 584. Find Customer Referee 
###########################################################################################################################################
## 586. Customer Placing the Largest Number of Orders 
CREATE TABLE orders02 (
    order_number INT PRIMARY KEY,
    customer_number INT,
    order_date DATE,
    required_date DATE,
    shipped_date DATE,
    status CHAR(15),
    comment CHAR(200)
);

-- Inserting values into the Orders table
INSERT INTO orders02 (order_number, customer_number, order_date, required_date, shipped_date, status, comment)
VALUES
    (1, 1, '2017-04-09', '2017-04-13', '2017-04-12', 'Closed', 'Comment for Order 1'),
    (2, 2, '2017-04-15', '2017-04-20', '2017-04-18', 'Closed', 'Comment for Order 2'),
    (3, 3, '2017-04-16', '2017-04-25', '2017-04-20', 'Closed', 'Comment for Order 3'),
    (4, 3, '2017-04-18', '2017-04-28', '2017-04-25', 'Closed', 'Comment for Order 4');

SELECT * FROM orders02;

-- Query the customer_number from the orders table for the customer who has placed
-- the largest number of orders.

-- Find customer_number with the largest number of orders
SELECT customer_number
FROM orders02
GROUP BY customer_number
ORDER BY COUNT(*) DESC
LIMIT 1;

#########################################################################################################################################
## 595. Big Countries 
#########################################################################################################################################
## 596. Classes More Than 5 Students
#########################################################################################################################################
## 597. Friend Requests I: Overall Acceptance Rate 
-- In social network like Facebook or Twitter, people send friend requests and
-- accept others’ requests as well. Now given two tables as below:

-- Create the friend_request table
CREATE TABLE friend_request (
    sender_id INT,
    send_to_id INT,
    request_date DATE
);

-- Insert values into the friend_request table
INSERT INTO friend_request (sender_id, send_to_id, request_date)
VALUES
    (1, 2, '2016-06-01'),
    (1, 3, '2016-06-01'),
    (1, 4, '2016-06-01'),
    (2, 3, '2016-06-02'),
    (3, 4, '2016-06-09');

-- Create the request_accepted table
CREATE TABLE request_accepted (
    requester_id INT,
    accepter_id INT,
    accept_date DATE
);

-- Insert values into the request_accepted table
INSERT INTO request_accepted (requester_id, accepter_id, accept_date)
VALUES
    (1, 2, '2016-06-03'),
    (1, 3, '2016-06-08'),
    (2, 3, '2016-06-08'),
    (3, 4, '2016-06-09'),
    (3, 4, '2016-06-10');


SELECT * FROM friend_request;
SELECT * FROM request_accepted;

-- Write a query to find the overall acceptance rate of requests rounded to 2
-- decimals, which is the number of acceptance divide the number of requests.

SELECT
	ROUND( IF( request=0, 0,  accept / request ), 2 ) AS accept_rate
FROM (
	SELECT
		COUNT( DISTINCT sender_id, send_to_id ) AS request
	FROM friend_request
) AS r,
(
	SELECT
		COUNT( DISTINCT requester_id, accepter_id ) AS accept
	FROM request_accepted
) AS a;

-- Follow-up:

-- Can you write a query to return the accept rate but for every month?

INSERT INTO friend_request (sender_id, send_to_id, request_date)
VALUES
    (5, 6, '2016-07-01'),
    (5, 7, '2016-07-02'),
    (6, 8, '2016-07-05'),
    (7, 6, '2016-07-08'),
    (7, 9, '2016-07-12');

-- Insert additional data for the month of July
INSERT INTO request_accepted (requester_id, accepter_id, accept_date)
VALUES
    (5, 6, '2016-07-03'),
    (5, 7, '2016-07-08'),
    (6, 8, '2016-07-08'),
    (7, 6, '2016-07-09'),
    (6, 8, '2016-07-10'),
    (7, 6, '2016-07-15');

INSERT INTO request_accepted (requester_id, accepter_id, accept_date)
VALUES (7, 9, '2016-07-15');

SELECT
	r.Month,
	ROUND( IF( request=0, 0,  accept / request ), 2 ) AS accept_rate
FROM (
	SELECT
		MONTH(request_date) AS `MONTH`,
		COUNT( DISTINCT sender_id, send_to_id ) AS request
	FROM friend_request
	GROUP BY 
		MONTH(request_date)
) AS r,
(
	SELECT
		MONTH(accept_date) AS `Month`,
		COUNT( DISTINCT requester_id, accepter_id ) AS accept
	FROM request_accepted
	GROUP BY 
		MONTH(accept_date)
) AS a
WHERE 
	r.Month = a.Month;

-- With Clause
WITH MonthlyRequests AS (
    SELECT
        MONTH(request_date) AS month,
        COUNT( DISTINCT sender_id, send_to_id ) AS request
    FROM friend_request
    GROUP BY MONTH(request_date)
),
MonthlyAcceptances AS (
    SELECT
        MONTH(accept_date) AS month,
        COUNT( DISTINCT requester_id, accepter_id ) AS accept
    FROM request_accepted 
    GROUP BY MONTH(accept_date)
)

-- now, calculate the acceptance rate in each month
SELECT 
	mr.month,
    ROUND( IF( mr.request=0, 0,  ma.accept / mr.request ), 2 ) AS accept_rate
FROM 
	MonthlyRequests mr LEFT JOIN MonthlyAcceptances ma
    ON mr.month = ma.month;

#######################################################################################################################################################
## 603. Consecutive Available Seats 
## **Important**
-- Several friends at a cinema ticket office would like to reserve consecutive available seats.
-- Can you help to query all the consecutive available seats order by the seat_id using the following cinema table?

CREATE TABLE seats (
    seat_id INT PRIMARY KEY,
    free INT
);

TRUNCATE TABLE seats;
-- Inserting data into the seats table
-- Inserting data into the seats table
INSERT INTO seats (seat_id, free)
VALUES
    (1, 1),
    (2, 0),
    (3, 1),
    (4, 1),
    (5, 1);
    
SELECT * FROM seats;

-- This is one way to solve it, and it's give good visualization of the output. 
-- (But it does not match with output they ask for.)

WITH seatGroup AS (
	SELECT
		*,
		(seat_id - ROW_NUMBER() OVER(PARTITION BY free ORDER BY seat_id ASC)) AS group_id
	FROM seats
)

SELECT
	MIN(seat_id) AS start_seat,
    MAX(seat_id) AS end_seat,
    MAX(seat_id) - MIN(seat_id) + 1 AS num_seat_empty
FROM 
	seatGroup
WHERE 
	free = 1
GROUP BY 
	group_id
ORDER BY 
	start_seat;

###############################################################################################################################
## 607. Sales Person 

-- Create the salesperson table
CREATE TABLE salesperson (
    sales_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    commission_rate INT,
    hire_date DATE
);

-- Insert data into the salesperson table
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date)
VALUES
    (1, 'John', 100000, 6, '2006-04-01'),
    (2, 'Amy', 120000, 5, '2010-05-01'),
    (3, 'Mark', 65000, 12, '2008-12-25'),
    (4, 'Pam', 25000, 25, '2005-01-01'),
    (5, 'Alex', 50000, 10, '2007-02-03');
    
-- Creation of the 'company' table
CREATE TABLE company (
    com_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

-- Insertion of data into the 'company' table
INSERT INTO company (com_id, name, city)
VALUES
    (1, 'RED', 'Boston'),
    (2, 'ORANGE', 'New York'),
    (3, 'YELLOW', 'Boston'),
    (4, 'GREEN', 'Austin');


-- Creation of the 'orders' table
CREATE TABLE orders03 (
    order_id INT PRIMARY KEY,
    order_date DATE,
    com_id INT,
    sales_id INT,
    amount DECIMAL(10, 2)
);

-- Insertion of data into the 'orders' table
INSERT INTO orders03 (order_id, order_date, com_id, sales_id, amount)
VALUES
    (1, '2014-01-01', 3, 4, 100000.00),
    (2, '2014-02-01', 4, 5, 5000.00),
    (3, '2014-03-01', 1, 1, 50000.00),
    (4, '2014-04-01', 1, 4, 25000.00);

SELECT * FROM salesperson;
SELECT * FROM company;
SELECT * FROM orders03;

-- Given three tables: salesperson, company, orders.
-- Output all the names in the table salesperson, who didn’t have sales to company 'RED'.

SELECT
	name
FROM 
	salesperson
WHERE 
	sales_id NOT IN (
		SELECT
			o.sales_id
		FROM 
			orders03 o LEFT JOIN company c
			ON c.com_id = o.com_id
		WHERE 
			c.name = 'RED'
    );
############################################################################################################################
## 608. Tree Node 

CREATE TABLE IF NOT EXISTS tree_nodes(
	Id INT,
    P_Id INT
);

INSERT INTO tree_nodes (Id, P_Id)
VALUES
	(1, NULL),
    (2, 1),
    (3, 1),
    (4, 2),
    (5, 2);
    
SELECT * FROM tree_nodes;

SELECT
	Id,
    CASE
		WHEN P_Id IS NULL THEN 'Root'
        WHEN Id NOT IN (
				SELECT
					DISTINCT P_Id
				FROM tree_nodes
                WHERE P_Id IS NOT NULL
        ) THEN 'Leaf'
		ELSE 'Inner'
	END AS `Type`
FROM tree_nodes;

##########################################################################################################################################################
## 610. Triangle Judgement 
CREATE TABLE trianglesides(
		x INT,
        y INT,
        z INT
);


INSERT INTO trianglesides VALUES (13, 15, 30), (10, 20, 15);

SELECT * FROM trianglesides;

SELECT
	x, y, z,
    CASE
		WHEN x+y > z AND y+z > x AND x+z > y THEN 'Yes'
        ELSE 'No'
	END AS `triangle`
FROM trianglesides;
#############################################################################################################################################
## 612. Shortest Distance in a Plane 
CREATE TABLE points(
		x INT,
        y INT
);

INSERT INTO points VALUES (-1, -1), (0, 0), (-1, -2);

SELECT * FROM points;

SELECT
	MIN(dist) AS  shortest
FROM (
	SELECT
		*,
		ROUND(sqrt(x*x + y*y), 2) AS dist
	FROM points
) t;

###################################################################################################################################################
## 613. Shortest Distance in a Line 
-- Write a query to find the shortest distance between two points in these points.

CREATE TABLE line(
		x INT
);

INSERT INTO line VALUES (-1), (0), (2);

SELECT * FROM line;

SELECT
	MIN(ABS(a.x - b.x)) AS shortest
FROM line a, line b
WHERE a.x != b.x;

-- Follow-up: What if all these points have an id and are arranged from the left
-- most to the right most of x axis?

CREATE TABLE lineId(
		Id INT,
        x INT
);

INSERT INTO lineId VALUES (0, -7), (1, -4), (2, -3), (3, -1), (4, 0),
						  (5, 2), (6, 5), (7, 6), (8, 8), (9, 11);

SELECT * FROM lineId;

SELECT
	MIN(ABS(a.x - b.x)) AS shortest
FROM 
	lineId a INNER JOIN lineId b
    ON a.Id < b.Id;
###########################################################################################################################################
## 619. Biggest Single Number 
-- Table my_numbers contains many numbers in column num including duplicated ones.
-- Can you write a SQL query to find the biggest number, which only appears once.

-- Create a table
CREATE TABLE numbers (
    num INT
);

-- Insert the values
INSERT INTO numbers (num) VALUES (8), (8), (3), (3), (1), (4), (5), (6);
    
SELECT * FROM numbers;

SELECT
	max(num) AS num
FROM (
		SELECT 
			num 
		FROM numbers
		GROUP BY num
		HAVING COUNT(*) = 1
	) t;

##############################################################################################################################################
## 626. Exchange Seats 
CREATE TABLE IF NOT EXISTS students(
	Id INT,
    Student VARCHAR(100)
);

INSERT INTO students VALUES (1, 'Abbot'), (2, 'Doris'), (3, 'Emerson'), (4, 'Green'), (5, 'Jeames');

SELECT * FROM students;

SELECT
	CASE
		WHEN Id % 2 = 1 AND Id < (SELECT MAX(Id) FROM students) THEN Id + 1   -- Odd Id but Id is less than the max Id 
        WHEN Id % 2 = 0 THEN Id - 1
        ELSE Id
	END AS Id,
    Student
FROM students
ORDER BY Id;
####################################################################################################################################################
## 627. Swap Salary 
CREATE TABLE salaries (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    sex VARCHAR(10),
    salary DECIMAL(10, 2)
);

INSERT INTO salaries (id, name, sex, salary) VALUES
    (1, 'A', 'm', 2500),
    (2, 'B', 'f', 1500),
    (3, 'C', 'm', 5500),
    (4, 'D', 'f', 500);
    
SELECT * FROM salaries;


UPDATE salaries
SET sex = CASE WHEN sex = 'm' THEN 'f' ELSE 'm' END;

SELECT * FROM salaries;
########################################################################################################################################################
