USE interview_db1;

########################################################################################################################################
-- 1327. List the Products Ordered in a Period 
CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(255),
    product_category VARCHAR(255)
);

CREATE TABLE orders (
    product_id INT,
    order_date DATE,
    unit INT
);

INSERT INTO products (product_id, product_name, product_category)
VALUES
    (1, 'Leetcode Solutions', 'Book'),
    (2, 'Jewels of Stringology', 'Book'),
    (3, 'HP', 'Laptop'),
    (4, 'Lenovo', 'Laptop'),
    (5, 'Leetcode Kit', 'T-shirt');
    
INSERT INTO Orders (product_id, order_date, unit)
VALUES
    (1, '2020-02-05', 60),
    (1, '2020-02-10', 70),
    (2, '2020-01-18', 30),
    (2, '2020-02-11', 80),
    (3, '2020-02-17', 2),
    (3, '2020-02-24', 3),
    (4, '2020-03-01', 20),
    (4, '2020-03-04', 30),
    (4, '2020-03-04', 60),
    (5, '2020-02-25', 50),
    (5, '2020-02-27', 50),
    (5, '2020-03-01', 50);

SELECT * FROM products;
SELECT * FROM orders;

-- Write an SQL query to get the names of products with greater than or equal to 
-- 100 units ordered in February 2020 and their amount. 

SELECT
	p.product_name,
    SUM(o.unit) AS total_unit
FROM 
	products p INNER JOIN (SELECT * FROM orders WHERE YEAR(order_date) = 2020 AND MONTH(order_date) = 2) o
    ON p.product_id = o.product_id
GROUP BY
	p.product_name
HAVING
	SUM(o.unit) >= 100;
######################################################################################################################################################
-- 1322. Ads Performance 

CREATE TABLE Ads (
    ad_id INT,
    user_id INT,
    action ENUM('Clicked', 'Viewed', 'Ignored'),
    PRIMARY KEY (ad_id, user_id)
);

INSERT INTO Ads (ad_id, user_id, action) VALUES (1, 1, 'Clicked'), (2, 2, 'Clicked'), (3, 3, 'Viewed'), (5, 5, 'Ignored'), (1, 7, 'Ignored'), (2, 7, 'Viewed'),
	(3, 5, 'Clicked'),
    (1, 4, 'Viewed'),
    (2, 11, 'Viewed'),
    (1, 2, 'Clicked');

SELECT * FROM ads;

SELECT
	a.ad_id,
    ROUND(IFNULL(SUM( CASE WHEN a.action = "Clicked" THEN 1 ELSE 0 END ) / (SUM(CASE WHEN a.action = "Clicked" THEN 1 ELSE 0 END) + SUM(CASE WHEN a.action = "Viewed" THEN 1 ELSE 0 END)), 0)*100, 2) AS ctr
FROM ads a
GROUP BY 
	a.ad_id
ORDER BY 
	ctr DESC, a.ad_id;

#######################################################################################################################################################################
-- 1321. Restaurant Growth 
-- ** Have to look into this problem **

CREATE TABLE customers (
    customer_id INT,
    name VARCHAR(255),
    visited_on DATE,
    amount INT,
    PRIMARY KEY (customer_id, visited_on)
);

INSERT INTO customers (customer_id, name, visited_on, amount) VALUES
    (1, 'Jhon', '2019-01-01', 100),
    (2, 'Daniel', '2019-01-02', 110),
    (3, 'Jade', '2019-01-03', 120),
    (4, 'Khaled', '2019-01-04', 130),
    (5, 'Winston', '2019-01-05', 110),
    (6, 'Elvis', '2019-01-06', 140),
    (7, 'Anna', '2019-01-07', 150),
    (8, 'Maria', '2019-01-08', 80),
    (9, 'Jaze', '2019-01-09', 110),
    (1, 'Jhon', '2019-01-10', 130),
    (3, 'Jade', '2019-01-10', 150);
    
SELECT * FROM customers;

-- below the isn't the desire result
SELECT
	name,
	visited_on,
    amount,
    SUM(amount) OVER(PARTITION BY NAME ORDER BY visited_on ASC RANGE BETWEEN INTERVAL 15 DAY preceding AND CURRENT ROW) AS runnig_amount,
    AVG(amount) OVER(PARTITION BY NAME ORDER BY visited_on ASC RANGE BETWEEN INTERVAL 15 DAY preceding AND CURRENT ROW) AS average_amount
FROM 
	customers;
###################################################################################################################################################
-- 1308. Running Total for Different Genders

CREATE TABLE IF NOT EXISTS scores (
    player_name VARCHAR(255),
    gender VARCHAR(10),
    day DATE,
    score_points INT,
    PRIMARY KEY (gender, day)
);

INSERT INTO Scores (player_name, gender, day, score_points) VALUES
    ('Aron', 'F', '2020-01-01', 17),
    ('Alice', 'F', '2020-01-07', 23),
    ('Bajrang', 'M', '2020-01-07', 7),
    ('Khali', 'M', '2019-12-25', 11),
    ('Slaman', 'M', '2019-12-30', 13),
    ('Joe', 'M', '2019-12-31', 3),
    ('Jose', 'M', '2019-12-18', 2),
    ('Priya', 'F', '2019-12-31', 23),
    ('Priyanka', 'F', '2019-12-30', 17);
    
SELECT * FROM scores;

SELECT
	gender,
    day,
    SUM(score_points) OVER(PARTITION BY gender ORDER BY day ASC) AS total
FROM scores;
####################################################################################################################################################
-- 1303. Find the Team Size 

CREATE TABLE IF NOT EXISTS employees(
		employee_id INT,
        team_id INT
);

INSERT INTO employees (employee_id, team_id) VALUES
    (1, 8),
    (2, 8),
    (3, 8),
    (4, 7),
    (5, 9),
    (6, 9);
    
SELECT * FROM employees;

-- Write an SQL query to find the team size of each of the employees. 

SELECT
	e.employee_id,
    t.cnt AS team_size
FROM 
	employees AS e INNER JOIN (
				SELECT
					team_id,
					COUNT(*) AS cnt
				FROM employees
				GROUP BY team_id
		) AS t
	ON e.team_id = t.team_id;
##############################################################################################################################################################
-- 1294. Weather Type in Each Country 

CREATE TABLE IF NOT EXISTS countries (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS weather (
    country_id INT,
    weather_state VARCHAR(255),
    day DATE,
    PRIMARY KEY (country_id, day)
);

INSERT INTO countries (country_id, country_name) VALUES
    (2, 'USA'),
    (3, 'Australia'),
    (7, 'Peru'),
    (5, 'China'),
    (8, 'Morocco'),
    (9, 'Spain');
    
INSERT INTO weather (country_id, weather_state, day) VALUES
    (2, 15, '2019-11-01'),
    (2, 12, '2019-10-28'),
    (2, 12, '2019-10-27'),
    (3, -2, '2019-11-10'),
    (3, 0, '2019-11-11'),
    (3, 3, '2019-11-12'),
    (5, 16, '2019-11-07'),
    (5, 18, '2019-11-09'),
    (5, 21, '2019-11-23'),
    (7, 25, '2019-11-28'),
    (7, 22, '2019-12-01'),
    (7, 20, '2019-12-02'),
    (8, 25, '2019-11-05'),
    (8, 27, '2019-11-15'),
    (8, 31, '2019-11-25'),
    (9, 7, '2019-10-23'),
    (9, 3, '2019-12-23');

SELECT * FROM countries;
SELECT * FROM weather;

-- Write an SQL query to find the type of weather in each country for November 
-- 2019. 
--  
-- The type of weather is Cold if the average weather_state is less than or equal 
-- 15, Hot if the average weather_state is greater than or equal 25 and Warm 
-- otherwise.

SELECT
	country_name,
    CASE
		WHEN avg_state <= 15.0 THEN "Cold"
        WHEN avg_state >= 25.0 THEN "Hot"
        ELSE "Warm"
	END AS weather_type
FROM (
	SELECT
		c.country_name,
		ROUND(AVG(w.weather_state), 2) AS avg_state
	FROM 
		countries AS c INNER JOIN (SELECT * FROM weather WHERE YEAR(day) = 2019 AND MONTH(day) = 11) AS w
		ON c.country_id = w.country_id
	GROUP BY
		c.country_name
) AS t;
##########################################################################################################################################################
-- 1285. Find the Start and End Number of Continuous Ranges 
## **IMPORTANT**

CREATE TABLE IF NOT EXISTS Logs (
    log_id INT PRIMARY KEY
);

INSERT INTO Logs (log_id) VALUES (1), (2), (3), (7), (8), (10);

SELECT * FROM logs;

-- Since some IDs have been removed from Logs. Write an SQL query to find the start 
-- and end number of continuous ranges in table Logs. 
-- Order the result table by start_id. 

WITH logsRank AS (
	SELECT
		*,
        (log_id - ROW_NUMBER() OVER(ORDER BY log_id)) AS diff
	FROM logs
)
SELECT
	MIN(log_id) AS start_id,
    MAX(log_id) AS end_id
FROM 
	logsRank
GROUP BY
	diff
ORDER BY
	start_id;
##################################################################################################################################################
-- 1264. Page Recommendations 
## ** IMPORTANT **
CREATE TABLE IF NOT EXISTS Friendship (
    user1_id INT,
    user2_id INT,
    PRIMARY KEY (user1_id, user2_id)
);

CREATE TABLE IF NOT EXISTS Likes (
    user_id INT,
    page_id INT,
    PRIMARY KEY (user_id, page_id)
);

INSERT INTO Friendship (user1_id, user2_id) VALUES 
    (1, 2),
    (1, 3),
    (1, 4),
    (2, 3),
    (2, 4),
    (2, 5),
    (6, 1);

INSERT INTO Likes (user_id, page_id) VALUES 
    (1, 88),
    (2, 23),
    (3, 24),
    (4, 56),
    (5, 11),
    (6, 33),
    (2, 77),
    (3, 77),
    (6, 88);
    
SELECT * FROM Friendship;
SELECT * FROM likes;

-- Write an SQL query to recommend pages to the user with user_id = 1 using the 
-- pages that your friends liked. It should not recommend pages you already liked. 
-- Return result table in any order without duplicates. 
    
WITH part1 AS (
	SELECT
		DISTINCT l.page_id
	FROM
		likes AS l LEFT JOIN Friendship AS f
		ON l.user_id = f.user2_id
	WHERE
		f.user1_id = 1 AND l.page_id NOT IN (
						SELECT page_id FROM likes WHERE user_id = 1
		)
),
part2 AS (
	SELECT
		DISTINCT l.page_id
	FROM 
		likes AS l LEFT JOIN Friendship AS f
		ON l.user_id = f.user1_id
	WHERE
		f.user2_id = 1 AND l.page_id NOT IN (
						SELECT page_id FROM likes WHERE user_id = 1
		)
)

SELECT * FROM part1
UNION
SELECT * FROM part2;
########################################################################################################################################
-- 1251. Average Selling Price 
CREATE TABLE IF NOT EXISTS prices (
    product_id INT,
    start_date DATE,
    end_date DATE,
    price INT,
    PRIMARY KEY (product_id, start_date, end_date)
);

CREATE TABLE IF NOT EXISTS UnitsSold (
    product_id INT,
    purchase_date DATE,
    units INT
);

INSERT INTO Prices (product_id, start_date, end_date, price) VALUES 
    (1, '2019-02-17', '2019-02-28', 5),
    (1, '2019-03-01', '2019-03-22', 20),
    (2, '2019-02-01', '2019-02-20', 15),
    (2, '2019-02-21', '2019-03-31', 30);

INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES 
    (1, '2019-02-25', 100),
    (1, '2019-03-01', 15),
    (2, '2019-02-10', 200),
    (2, '2019-03-22', 30);

SELECT * FROM Prices;
SELECT * FROM UnitsSold;

-- Write an SQL query to find the average selling price for each product. 
-- average_price should be rounded to 2 decimal places. 
SELECT
	p.product_id,
    ROUND(SUM(p.price*u.units) / SUM(u.units), 2) AS average_price
FROM 
	Prices AS p INNER JOIN UnitsSold AS u
    ON p.product_id = u.product_id
WHERE 
	u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY
	p.product_id;

###################################################################################################################################################
-- 1241. Number of Comments per Post 
## **IMPORTANT**
-- Create Submissions table
CREATE TABLE IF NOT EXISTS Submissions (
    sub_id INT,
    parent_id INT
);

-- Insert given values into Submissions table
INSERT INTO Submissions (sub_id, parent_id) VALUES
    (1, NULL),
    (2, NULL),
    (1, NULL),
    (12, NULL),
    (3, 1),
    (5, 2),
    (3, 1),
    (4, 1),
    (9, 1),
    (10, 2),
    (6, 7);
    
SELECT * FROM Submissions;

WITH grouped AS (
	SELECT
		parent_id AS  post_id,
        COUNT( DISTINCT sub_id, parent_id ) AS number_of_comments 
    FROM Submissions
    WHERE parent_id IS NOT NULL AND parent_id IN (SELECT sub_id FROM Submissions WHERE parent_id IS NULL)
    GROUP BY parent_id

)
SELECT
	l.sub_id AS post_id,
    IFNULL(g.number_of_comments, 0) AS number_of_comments
FROM 
	(SELECT DISTINCT sub_id FROM Submissions WHERE parent_id IS NULL) AS l LEFT JOIN grouped AS g
    ON l.sub_id = g.post_id
ORDER BY
	post_id ASC;
###########################################################################################################################################################
-- 1225. Report Contiguous Dates
## **IMPORTANT**
-- Create Failed table
CREATE TABLE IF NOT EXISTS Failed (
    fail_date DATE PRIMARY KEY
);

-- Create Succeeded table
CREATE TABLE IF NOT EXISTS Succeeded (
    success_date DATE PRIMARY KEY
);

INSERT INTO Failed (fail_date) VALUES
    ('2018-12-28'),
    ('2018-12-29'),
    ('2019-01-04'),
    ('2019-01-05');

INSERT INTO Succeeded (success_date) VALUES
    ('2018-12-30'),
    ('2018-12-31'),
    ('2019-01-01'),
    ('2019-01-02'),
    ('2019-01-03'),
    ('2019-01-06');

SELECT * FROM Failed;
SELECT * FROM Succeeded;

-- Write an SQL query to generate a report of period_state for each continuous 
-- interval of days in the period from 2019-01-01 to 2019-12-31. 
-- period_state is 'failed' if tasks in this interval failed or 'succeeded' if 
-- tasks in this interval succeeded. Interval of days are retrieved as start_date 
-- and end_date.

WITH dateRanges AS (
	SELECT
		*
	FROM (
		SELECT
			fail_date AS date_range,
			'failed' AS period_state
		FROM 
			Failed
		UNION ALL
		SELECT
			success_date AS date_range,
			'succeeded' AS period_state
		FROM 
			Succeeded) AS t
	WHERE date_range BETWEEN '2019-01-01' AND '2019-12-31'
)
SELECT 
	period_state,
    MIN(date_range) AS start_date,
    MAX(date_range) AS end_date 
FROM (
	SELECT
		*,
		( date_range - INTERVAL ROW_NUMBER() OVER(PARTITION BY period_state ORDER BY period_state ASC) DAY ) rn
	FROM dateRanges 
) AS tt
GROUP BY
	period_state, rn
ORDER BY 
	start_date;

#########################################################################################################################################################
## 1212. Team Scores in Football Tournament 
## **IMPORTANT**
CREATE TABLE IF NOT EXISTS Teams (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Matches (
    match_id INT PRIMARY KEY,
    host_team INT,
    guest_team INT,
    host_goals INT,
    guest_goals INT
);

INSERT INTO Teams (team_id, team_name) VALUES
    (10, 'Leetcode FC'),
    (20, 'NewYork FC'),
    (30, 'Atlanta FC'),
    (40, 'Chicago FC'),
    (50, 'Toronto FC');

INSERT INTO Matches (match_id, host_team, guest_team, host_goals, guest_goals) VALUES
    (1, 10, 20, 3, 0),
    (2, 30, 10, 2, 2),
    (3, 10, 50, 5, 1),
    (4, 20, 30, 1, 0),
    (5, 50, 30, 1, 0);

SELECT * FROM teams;
SELECT * FROM matches;

-- Write an SQL query that selects the team_id, team_name and num_points of each 
-- team in the tournament after all described matches.
WITH teamPoints AS (
	SELECT 
		team_id,
		SUM(num_points) AS num_points
	FROM (
		SELECT
			host_team AS team_id,
			SUM(
				CASE 
					WHEN host_goals > guest_goals THEN 3
					WHEN host_goals = guest_goals THEN 1
					ELSE 0
					END
				) AS num_points
		FROM 
			matches
		GROUP BY 
			host_team
		UNION ALL
		SELECT
			guest_team AS team_id,
			SUM(
				CASE 
					WHEN guest_goals > host_goals THEN 3
					WHEN guest_goals = host_goals THEN 1
					ELSE 0
					END
				) AS num_points
		FROM 
			matches
		GROUP BY 
			guest_team) 
	AS t
	GROUP BY
		team_id
	)
    
SELECT 
	t.team_id,
    t.team_name,
    IFNULL(tp.num_points, 0) AS num_points
FROM 
	teams AS t LEFT JOIN teamPoints AS tp
    ON t.team_id = tp.team_id
ORDER BY
	num_points DESC, team_id ASC;
############################################################################################################################################################
## 1211. Queries Quality and Percentage 
CREATE TABLE IF NOT EXISTS Queries (
    query_name VARCHAR(255),
    result VARCHAR(255),
    position INT,
    rating INT
);

INSERT INTO Queries (query_name, result, position, rating) VALUES
    ('Dog', 'Golden Retriever', 1, 5),
    ('Dog', 'German Shepherd', 2, 5),
    ('Dog', 'Mule', 200, 1),
    ('Cat', 'Shirazi', 5, 2),
    ('Cat', 'Siamese', 3, 3),
    ('Cat', 'Sphynx', 7, 4);

SELECT * FROM Queries;

SELECT
	query_name,
	ROUND(AVG(rating/position), 2) AS quality,
    ROUND( (SUM( CASE WHEN rating < 3 THEN 1 ELSE 0 END ) / COUNT(rating))*100, 2) AS poor_query_percentage 
FROM 
	Queries
GROUP BY
	query_name;
#######################################################################################################################################################
## 1204. Last Person to Fit in the Elevator 
## **IMPORTANT**
CREATE TABLE IF NOT EXISTS Queue (
    person_id INT PRIMARY KEY,
    person_name VARCHAR(255),
    weight INT,
    turn INT
);

INSERT INTO Queue (person_id, person_name, weight, turn) VALUES
    (5, 'George Washington', 250, 1),
    (3, 'John Adams', 350, 2),
    (6, 'Thomas Jefferson', 400, 3),
    (2, 'Will Johnliams', 200, 4),
    (4, 'Thomas Jefferson', 175, 5),
    (1, 'James Elephant', 500, 6);

SELECT * FROM queue;

WITH cummWeights AS (
	SELECT
		person_name,
		@total_weight := @total_weight + weight AS total_weight
	FROM 
		queue, (SELECT @total_weight := 0) AS t
	ORDER BY
		turn ASC
)

SELECT
	person_name
FROM 
	cummWeights
WHERE 
	total_weight <= 1000
ORDER BY
	total_weight DESC
LIMIT 1;

-- using window fn
SELECT 
	person_name
FROM (
	SELECT
		*,
		SUM(weight) OVER( ORDER BY turn ) as total_weight
	FROM queue
) AS t
WHERE total_weight <= 1000
ORDER BY total_weight DESC
LIMIT 1;

-- using JOIN
##############################################################################################################
## 1193. Monthly Transactions I 
CREATE TABLE IF NOT EXISTS Transactions (
    id INT PRIMARY KEY,
    country VARCHAR(255),
    state ENUM('approved', 'declined'),
    amount INT,
    trans_date DATE
);

INSERT INTO Transactions (id, country, state, amount, trans_date) VALUES
	(121, 'US', 'approved', 1000, '2018-12-18'),
    (122, 'US', 'declined', 2000, '2018-12-19'),
    (123, 'US', 'approved', 2000, '2019-01-01'),
    (124, 'DE', 'approved', 2000, '2019-01-07');

SELECT * FROM Transactions;
-- Write an SQL query to find for each month and country, the number of 
-- transactions and their total amount, the number of approved transactions and 
-- their total amount. 

SELECT
	DATE_FORMAT(t.trans_date, '%Y-%m') AS month,
    t.country,
    COUNT(t.state) AS the_number_of_transactions,
    SUM(t.amount) AS total_transactions_amount,
    SUM( CASE WHEN t.state = 'approved' THEN 1 ELSE 0 END ) AS number_of_approved_transactions,
    SUM( CASE WHEN t.state = 'approved' THEN t.amount ELSE 0 END ) total_transactions_approved_amount
FROM 
	Transactions AS t
GROUP BY
	DATE_FORMAT(t.trans_date, '%Y-%m'), t.country;
##############################################################################################################################################
## 1179. Reformat Department Table 
CREATE TABLE IF NOT EXISTS Department (
    id INT,
    revenue INT,
    month VARCHAR(3),
    PRIMARY KEY (id, month)
);

INSERT INTO Department (id, revenue, month) VALUES
    (1, 8000, 'Jan'),
    (2, 9000, 'Jan'),
    (3, 10000, 'Feb'),
    (1, 7000, 'Feb'),
    (1, 6000, 'Mar');

SELECT * FROM Department;

SELECT
	id,
	SUM( CASE WHEN month = 'Jan' THEN revenue ELSE NULL END) AS Jan_Revenue,
    SUM( CASE WHEN month = 'Feb' THEN revenue ELSE NULL END) AS Feb_Revenue,
    SUM( CASE WHEN month = 'Mar' THEN revenue ELSE NULL END) AS Mar_Revenue,
    SUM( CASE WHEN month = 'Apr' THEN revenue ELSE NULL END) AS Apr_Revenue
FROM 
	Department
GROUP BY
	id;
###################################################################################################################################################
## 1174. Immediate Food Delivery II 
CREATE TABLE IF NOT EXISTS Delivery (
    delivery_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    customer_pref_delivery_date DATE
);

INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES
    (1, 1, '2019-08-01', '2019-08-02'),
    (2, 2, '2019-08-02', '2019-08-02'),
    (3, 1, '2019-08-11', '2019-08-12'),
    (4, 3, '2019-08-24', '2019-08-24'),
    (5, 3, '2019-08-21', '2019-08-22'),
    (6, 2, '2019-08-11', '2019-08-13'),
    (7, 4, '2019-08-09', '2019-08-09');

SELECT * FROM Delivery;

WITH Subquery AS (
	SELECT
		*,
		DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY order_date ASC) AS rn
	FROM 
		Delivery
)

SELECT
	ROUND( (SUM( CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END ) / COUNT(*) )*100, 2) AS immediate_percentage 
FROM 
	Subquery
WHERE 
	rn = 1;

## 1173. Immediate Food Delivery I 
TRUNCATE TABLE Delivery;

INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES
    (1, 1, '2019-08-01', '2019-08-02'),
    (2, 5, '2019-08-02', '2019-08-02'),
    (3, 1, '2019-08-11', '2019-08-11'),
    (4, 3, '2019-08-24', '2019-08-26'),
    (5, 4, '2019-08-21', '2019-08-22'),
    (6, 2, '2019-08-11', '2019-08-13');

SELECT * FROM delivery;

SELECT
	ROUND( (SUM( CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END) / COUNT(delivery_id) )*100, 2) AS immediate_percentage 
FROM
	Delivery;
############################################################################################################################################################
## 1164. Product Price at a Given Date
## **IMPORTANT** 
CREATE TABLE IF NOT EXISTS Products01 (
    product_id INT,
    new_price INT,
    change_date DATE,
    PRIMARY KEY (product_id, change_date)
);

INSERT INTO Products01 (product_id, new_price, change_date) VALUES
    (1, 20, '2019-08-14'),
    (2, 50, '2019-08-14'),
    (1, 30, '2019-08-15'),
    (1, 35, '2019-08-16'),
    (2, 65, '2019-08-17'),
    (3, 20, '2019-08-18');

SELECT * FROM Products01;

-- Write an SQL query to find the prices of all products on 2019-08-16. Assume the 
-- price of all products before any change is 10. 

WITH productPrice AS (
	SELECT
		product_id,
		new_price AS price
	FROM(
		SELECT
			*,
			DENSE_RANK() OVER(PARTITION BY product_id ORDER BY change_date DESC) AS rn
		FROM 
			Products01
		WHERE
			change_date <= '2019-08-16') 
	AS t
	WHERE 
		rn = 1
)

SELECT
	l.product_id,
    IFNULL(r.price, 10) AS price
FROM 
	( SELECT DISTINCT product_id FROM Products01 ) AS l LEFT JOIN productPrice AS r
    ON l.product_id = r.product_id
ORDER BY
	price DESC;
##########################################################################################################################################################
## 1148. Article Views I 
CREATE TABLE IF NOT EXISTS Views (
    article_id INT,
    author_id INT,
    viewer_id INT,
    view_date DATE
);

INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES
(1, 3, 5, '2019-08-01'),
(1, 3, 6, '2019-08-02'),
(2, 7, 7, '2019-08-01'),
(2, 7, 6, '2019-08-02'),
(4, 7, 1, '2019-07-22'),
(3, 4, 4, '2019-07-21'),
(3, 4, 4, '2019-07-21');

SELECT * FROM views;

-- Write an SQL query to find all the authors that viewed at least one of their own 
-- articles, sorted in ascending order by their id. 

SELECT
	DISTINCT author_id AS id
FROM 
	views
WHERE
	author_id = viewer_id
ORDER BY
	id;
############################################################################################################################################################
## 1142. User Activity for the Past 30 Days II 
## **IMPORTANT**
CREATE TABLE IF NOT EXISTS Activity (
    user_id INT,
    session_id INT,
    activity_date DATE,
    activity_type ENUM('open_session', 'end_session', 'scroll_down', 'send_message')
);

INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES
(1, 1, '2019-07-20', 'open_session'),
(1, 1, '2019-07-20', 'scroll_down'),
(1, 1, '2019-07-20', 'end_session'),
(2, 4, '2019-07-20', 'open_session'),
(2, 4, '2019-07-21', 'send_message'),
(2, 4, '2019-07-21', 'end_session'),
(3, 2, '2019-07-21', 'open_session'),
(3, 2, '2019-07-21', 'send_message'),
(3, 2, '2019-07-21', 'end_session'),
(3, 5, '2019-07-21', 'open_session'),
(3, 5, '2019-07-21', 'scroll_down'),
(3, 5, '2019-07-21', 'end_session'),
(4, 3, '2019-06-25', 'open_session'),
(4, 3, '2019-06-25', 'end_session');

SELECT * FROM Activity
WHERE 
	activity_date BETWEEN DATE_SUB('2019-07-27', INTERVAL 29 DAY) AND '2019-07-27';

-- Write an SQL query to find the average number of sessions per user for a period 
-- of 30 days ending 2019-07-27 inclusively, rounded to 2 decimal places. The 
-- sessions we want to count for a user are those with at least one activity in that time period. 

WITH subquery AS (
	SELECT
		DISTINCT user_id, session_id
	FROM
		Activity
	WHERE
		activity_date BETWEEN DATE_SUB('2019-07-27', INTERVAL 29 DAY) AND '2019-07-27'
	GROUP BY
		user_id, session_id
)

SELECT 
	ROUND( COUNT( DISTINCT session_id ) / COUNT( DISTINCT user_id ), 2 ) AS average_sessions_per_user
FROM subquery;

## 1141. User Activity for the Past 30 Days I 
-- Write an SQL query to find the daily active user count for a period of 30 days 
-- ending 2019-07-27 inclusively. A user was active on some day if he/she made at 
-- least one activity on that day.

SELECT
	activity_date AS day,
    COUNT( DISTINCT user_id ) AS active_users 
FROM 
	Activity
WHERE 
	activity_date BETWEEN DATE_SUB('2019-07-27', INTERVAL 29 DAY) AND '2019-07-27'
GROUP BY
	activity_date;

#####################################################################################################################################################
## 1126. Active Businesses 
## **IMPORTANT**
CREATE TABLE IF NOT EXISTS Events (
    business_id INT,
    event_type VARCHAR(255),
    occurrences INT,
    PRIMARY KEY (business_id, event_type)
);

INSERT INTO Events (business_id, event_type, occurrences) VALUES
    (1, 'reviews', 7),
    (3, 'reviews', 3),
    (1, 'ads', 11),
    (2, 'ads', 7),
    (3, 'ads', 6),
    (1, 'page views', 3),
    (2, 'page views', 12);

SELECT * FROM events;

-- Write an SQL query to find all active businesses. 
-- An active business is a business that has more than one event type with 
-- occurences greater than the average occurences of that event type among all 
-- businesses.

WITH avgOcc AS (
	SELECT
		event_type,
		AVG(occurrences) AS avg_occ
	FROM events
	GROUP BY event_type
)

SELECT
	e.business_id
FROM 
	events AS e INNER JOIN avgOcc AS a
    ON e.event_type = a.event_type AND e.occurrences > a.avg_occ
GROUP BY
	e.business_id
HAVING
	COUNT( * ) > 1;

###############################################################################################################################################################
## 1113. Reported Posts 
CREATE TABLE UserActions (
    user_id INT,
    post_id INT,
    action_date DATE,
    action ENUM('view', 'like', 'reaction', 'comment', 'report', 'share'),
    extra VARCHAR(255)
);

INSERT INTO UserActions (user_id, post_id, action_date, action, extra) VALUES
    (1, 1, '2019-07-01', 'view', null),
    (1, 1, '2019-07-01', 'like', null),
    (1, 1, '2019-07-01', 'share', null),
    (2, 4, '2019-07-04', 'view', null),
    (2, 4, '2019-07-04', 'report', 'spam'),
    (3, 4, '2019-07-04', 'view', null),
    (3, 4, '2019-07-04', 'report', 'spam'),
    (4, 3, '2019-07-02', 'view', null),
    (4, 3, '2019-07-02', 'report', 'spam'),
    (5, 2, '2019-07-04', 'view', null),
    (5, 2, '2019-07-04', 'report', 'racism'),
    (5, 5, '2019-07-04', 'view', null),
    (5, 5, '2019-07-04', 'report', 'racism');

SELECT * FROM UserActions;

-- Write an SQL query that reports the number of posts reported yesterday for each 
-- report reason. Assume today is 2019-07-05. 
SELECT
	extra AS report_reason,
    SUM(cnt) AS report_count
FROM (
	SELECT
		post_id,
		extra,
		COUNT(*) AS cnt
	FROM
		UserActions
	WHERE action_date = '2019-07-04' AND action = 'report'
	GROUP BY post_id, extra
) AS t
GROUP BY extra;
##################################################################################################################################################
## 1112. Highest Grade For Each Student 
## **IMPORTANT**
CREATE TABLE Enrollments (
    student_id INT,
    course_id INT,
    grade INT,
    PRIMARY KEY (student_id, course_id)
);

INSERT INTO Enrollments (student_id, course_id, grade) VALUES
    (2, 2, 95),
    (2, 3, 95),
    (1, 1, 90),
    (1, 2, 99),
    (3, 1, 80),
    (3, 2, 75),
    (3, 3, 82);

SELECT * FROM Enrollments;
-- Write a SQL query to find the highest grade with its corresponding course for 
-- each student. In case of a tie, you should find the course with the smallest 
-- course_id. The output must be sorted by increasing student_id. 

SELECT
	student_id, MIN(course_id) AS course_id, MAX(grade) AS grade
FROM Enrollments
WHERE (student_id, grade) IN (
		SELECT
			student_id, MAX(grade) AS grade
		FROM Enrollments
        GROUP BY student_id
)
GROUP BY student_id
ORDER BY student_id ASC;
####################################################################################################################################################
## 1084. Sales Analysis III 
-- Create Product table
CREATE TABLE IF NOT EXISTS Product02 (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    unit_price INT
);

-- Create Sales table
CREATE TABLE IF NOT EXISTS Sales02 (
    seller_id INT,
    product_id INT,
    buyer_id INT,
    sale_date DATE,
    quantity INT,
    price INT,
    FOREIGN KEY (product_id) REFERENCES Product02(product_id)
);

INSERT INTO Product02 (product_id, product_name, unit_price) VALUES
    (1, 'S8', 1000),
    (2, 'G4', 800),
    (3, 'iPhone', 1400);

INSERT INTO Sales02 (seller_id, product_id, buyer_id, sale_date, quantity, price) VALUES
    (1, 1, 1, '2019-01-21', 2, 2000),
    (1, 2, 2, '2019-02-17', 1, 800),
    (2, 2, 3, '2019-06-02', 1, 800),
    (3, 3, 4, '2019-05-13', 2, 2800);

SELECT * FROM Product02;
SELECT * FROM Sales02;

-- Write an SQL query that reports the products that were only sold in spring 2019. 
-- That is, between 2019-01-01 and 2019-03-31 inclusive.

SELECT 
	t.product_id, p.product_name
FROM 
	product02 AS p INNER JOIN (
			SELECT 
				*
			FROM Sales02
			WHERE sale_date BETWEEN '2019-01-01' AND '2019-03-31' AND product_id NOT IN (
				SELECT
					product_id
				FROM Sales02
				WHERE sale_date NOT BETWEEN '2019-01-01' AND '2019-03-31'
		)
    )  AS t
ON p.product_id = t.product_id;
    
WITH onlySpring AS (
	SELECT 
		*
	FROM Sales02
	WHERE sale_date BETWEEN '2019-01-01' AND '2019-03-31' AND product_id NOT IN (
		SELECT
			product_id
		FROM Sales02
		WHERE sale_date NOT BETWEEN '2019-01-01' AND '2019-03-31'
	)
)
SELECT
	o.product_id, p.product_name
FROM 
	onlySpring AS o INNER JOIN Product02 AS p
    ON o.product_id = p.product_id;

## 1083. Sales Analysis II 
-- Write an SQL query that reports the buyers who have bought S8 but not iPhone. 
-- Note that S8 and iPhone are products present in the Product table.
SELECT
	t.buyer_id
FROM (
	SELECT
		s.product_id, p.product_name, s.buyer_id
	FROM 
		Product02 AS p INNER JOIN Sales02 AS s
		ON p.product_id = s.product_id
) AS t
WHERE t.product_name = 'S8' AND t.product_name <> 'iPhone';

WITH productSales AS (
		SELECT
			s.product_id, p.product_name, s.buyer_id
		FROM 
			Product02 AS p INNER JOIN Sales02 AS s
			ON p.product_id = s.product_id
)

SELECT 
	DISTINCT buyer_id
FROM productSales
WHERE product_name = 'S8' AND buyer_id NOT IN (
		SELECT buyer_id FROM productSales WHERE product_name = 'iPhone'
	);

## 1082. Sales Analysis I 
-- Write an SQL query that reports the best seller by total sales price, If there 
-- is a tie, report them all. 
SELECT * FROM Sales02;

SELECT
	seller_id
FROM Sales02
GROUP BY seller_id
HAVING SUM(price) >= (
		SELECT
			SUM(price) AS total_sales_amount
		FROM Sales02
		GROUP BY seller_id
		ORDER BY total_sales_amount DESC
		LIMIT 1
);
#####################################################################################################################################################
## 1077. Project Employees III 
CREATE TABLE Projects (
    project_id INT,
    employee_id INT,
    PRIMARY KEY (project_id, employee_id)
);

CREATE TABLE Employees_Projects (
    employee_id INT PRIMARY KEY,
    name VARCHAR(255),
    experience_years INT
);

INSERT INTO Projects (project_id, employee_id) VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 1),
    (2, 4);

INSERT INTO Employees_Projects (employee_id, name, experience_years) VALUES
	(1, 'Khaled', 3),
    (2, 'Ali', 2),
    (3, 'John', 3),
    (4, 'Doe', 2);

-- Write an SQL query that reports the most experienced employees in each project. 
-- In case of a tie, report all employees with the maximum number of experience years. 

SELECT * FROM projects;
SELECT * FROM employees_projects;

WITH subquery AS (
	SELECT 
		p.project_id,
		e.employee_id,
		e.name,
		e.experience_years
	FROM 
		projects AS p INNER JOIN employees_projects AS e
		ON p.employee_id = e.employee_id
)
SELECT 
	project_id,
    employee_id
FROM (
	SELECT
		*,
		DENSE_RANK() OVER(PARTITION BY project_id ORDER BY experience_years DESC) AS rn
	FROM subquery
	) AS t
WHERE 
	rn = 1;
    
-- using only JOIN
WITH subquery AS (
	SELECT 
		p.project_id,
		MAX(e.experience_years) AS experience_years
	FROM 
		projects AS p INNER JOIN employees_projects AS e
		ON p.employee_id = e.employee_id
	GROUP BY 
		p.project_id
)
SELECT 
	p.project_id,
    e.employee_id
FROM 
	projects AS p INNER JOIN employees_projects AS e
	ON p.employee_id = e.employee_id AND (p.project_id, e.experience_years) IN (
			SELECT * FROM subquery
		);
        
## 1076. Project Employees II 
-- Write an SQL query that reports all the projects that have the most employees. 
SELECT
	project_id
FROM projects
GROUP BY 
	project_id
HAVING COUNT(employee_id) >= (
		SELECT
			COUNT(employee_id) AS cnt
		FROM projects
		GROUP BY project_id
        ORDER BY cnt DESC
        LIMIT 1
);

## 1075. Project Employees I 
-- Write an SQL query that reports the average experience years of all the 
-- employees for each project, rounded to 2 digits.
SELECT 
	p.project_id,
	ROUND(AVG(e.experience_years), 2) AS average_years 
FROM 
	projects AS p INNER JOIN employees_projects AS e
	ON p.employee_id = e.employee_id
GROUP BY p.project_id;
#####################################################################################################################################
## 1070. Product Sales Analysis III 
CREATE TABLE Products03 (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255)
);

CREATE TABLE Sales03 (
    sale_id INT PRIMARY KEY,
    product_id INT,
    year INT,
    quantity INT,
    price INT,
    FOREIGN KEY (product_id) REFERENCES Products03(product_id)
);

INSERT INTO Products03 (product_id, product_name) VALUES
    (100, 'Nokia'),
    (200, 'Apple'),
    (300, 'Samsung');


INSERT INTO Sales03 (sale_id, product_id, year, quantity, price) VALUES
    (1, 100, 2008, 10, 5000),
    (2, 100, 2009, 12, 5000),
    (7, 200, 2011, 15, 9000);

SELECT * FROM Products03;
SELECT * FROM Sales03;

-- Write an SQL query that selects the product id, year, quantity, and price for 
-- the first year of every product sold. 
SELECT
	product_id, year AS first_year, quantity, price
FROM (
	SELECT
		*,
		DENSE_RANK() OVER(PARTITION BY product_id ORDER BY year ASC) AS rn
	FROM Sales03
) AS t
WHERE rn=1;

SELECT 
	product_id, year AS first_year, quantity, price
FROM Sales03
WHERE (product_id, year) IN (
	SELECT
		product_id,
		MIN(year)
	FROM Sales03
	GROUP BY product_id
);

## 1069. Product Sales Analysis II
-- Write an SQL query that reports the total quantity sold for every product id. 
SELECT
	product_id,
    SUM(quantity) AS total_quantity
FROM Sales03
GROUP BY product_id;

## 1068. Product Sales Analysis I 
-- Write an SQL query that reports all product names of the products in the Sales 
-- table along with their selling year and price.
SELECT * FROM Products03;
SELECT * FROM Sales03;

SELECT
	p.product_name,
    s.year,
    s.price
FROM 
	Products03 AS p INNER JOIN ( SELECT product_id, year, price FROM Sales03 ) AS s
    ON p.product_id = s.product_id;
####################################################################################################################################
## 1050. Actors and Directors Who Cooperated At Least Three Times 
CREATE TABLE IF NOT EXISTS ActorDirector (
    actor_id INT,
    director_id INT,
    timestamp INT,
    PRIMARY KEY (timestamp)
);

INSERT INTO ActorDirector (actor_id, director_id, timestamp) VALUES
    (1, 1, 0),
    (1, 1, 1),
    (1, 1, 2),
    (1, 2, 3),
    (1, 2, 4),
    (2, 1, 5),
    (2, 1, 6);

-- Write a SQL query for a report that provides the pairs (actor_id, director_id) 
-- where the actor have cooperated with the director at least 3 times.
SELECT * FROM ActorDirector;

SELECT
	actor_id,
    director_id
FROM ActorDirector
GROUP BY actor_id, director_id
HAVING COUNT( * ) >= 3;
################################################################################################################################################
## 1045. Customers Who Bought All Products
CREATE TABLE Products1045 (
    product_key INT PRIMARY KEY
);

CREATE TABLE Customers1045 (
    customer_id INT,
    product_key INT,
    FOREIGN KEY (product_key) REFERENCES Products1045(product_key)
);

INSERT INTO Products1045 (product_key) VALUES (5), (6);
INSERT INTO Customers1045 (customer_id, product_key) VALUES (1, 5), (2, 6), (3, 5), (3, 6), (1, 6);

-- Write an SQL query for a report that provides the customer ids from the Customer 
-- table that bought all the products in the Product table. 
SELECT * FROM Products1045;
SELECT * FROM Customers1045;

SELECT
	customer_id
FROM Customers1045
GROUP BY customer_id
HAVING SUM(product_key) = ( SELECT SUM(product_key) FROM Products1045 );
###########################################################################################################################################

