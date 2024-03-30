USE medium_levelwise_db;

CREATE TABLE IF NOT EXISTS transactions(
		user_id INT,
		spend DECIMAL(10, 2),
		transaction_date TIMESTAMP);

INSERT INTO transactions (user_id, spend, transaction_date) VALUES
  (111, 100.50, '2022-01-08 12:00:00'),
  (111, 55.00, '2022-01-10 12:00:00'),
  (121, 36.00, '2022-01-18 12:00:00'),
  (145, 24.99, '2022-01-26 12:00:00'),
  (111, 89.60, '2022-02-05 12:00:00');
  
  SELECT * FROM transactions;
  
--   Q.1: Assume you are given the table below on Uber transactions made by users. Write a query
-- to obtain the third transaction of every user. Output the user id, spend and transaction date.

SELECT
	user_id, spend, transaction_date
FROM (
	SELECT
		*,
		DENSE_RANK() OVER(PARTITION BY user_id ORDER BY transaction_date ASC) AS rn
	FROM transactions) 
t
WHERE rn = 3;
############################################################################################################################
CREATE TABLE IF NOT EXISTS activities(
		activity_id INT,
		user_id INT,
		activity_type ENUM ('send', 'open', 'chat'),
		time_spent DECIMAL(10, 2),
		activity_date DATETIME);
        
CREATE TABLE IF NOT EXISTS age_breakdown(
		user_id INT,
		age_bucket VARCHAR(10));

INSERT INTO activities (activity_id, user_id, activity_type, time_spent, activity_date) VALUES
  (7274, 123, 'open', 4.50, '2022-06-22 12:00:00'),
  (2425, 123, 'send', 3.50, '2022-06-22 12:00:00'),
  (1413, 456, 'send', 5.67, '2022-06-23 12:00:00'),
  (1414, 789, 'chat', 11.00, '2022-06-25 12:00:00'),
  (2536, 456, 'open', 3.00, '2022-06-25 12:00:00');
  
INSERT INTO age_breakdown (user_id, age_bucket) VALUES
  (123, '31-35'),
  (456, '26-30'),
  (789, '21-25');

SELECT * FROM activities;
SELECT * FROM age_breakdown;

-- Write a query to obtain a breakdown of the time spent sending vs. opening snaps as a
-- percentage of total time spent on these activities grouped by age group. Round the percentage
-- to 2 decimal places in the output.
-- Notes:
-- ● Calculate the following percentages:
-- ○ time spent sending / (Time spent sending + Time spent opening)
-- ○ Time spent opening / (Time spent sending + Time spent opening)
-- ● To avoid integer division in percentages, multiply by 100.0 and not 100.

SELECT 
	b.age_bucket,
    ROUND( 
		IFNULL( 
			(
				SUM( CASE WHEN a.activity_type = 'send' THEN a.time_spent ELSE 0 END ) / 
				SUM( CASE WHEN a.activity_type IN ('send', 'open') THEN a.time_spent ELSE 0 END )
             ) *100.0 , 
         0), 
	2 ) AS send_perc,
                        
	ROUND( 
		IFNULL(
			(
				SUM( CASE WHEN a.activity_type = 'open' THEN a.time_spent ELSE 0 END ) / 
				SUM( CASE WHEN a.activity_type IN ('send', 'open') THEN a.time_spent ELSE 0 END )
             ) *100.0 ,
		0),
	 2 ) AS open_perc
         
FROM 
	activities a 
LEFT JOIN 
	age_breakdown b ON a.user_id = b.user_id
GROUP BY b.age_bucket;
###########################################################################################################################
CREATE TABLE IF NOT EXISTS tweets(
		user_id INT,
		tweet_date TIMESTAMP,
		tweet_count INT);

INSERT INTO tweets (user_id, tweet_date, tweet_count) VALUES
  (111, '2022-06-01 00:00:00', 2),
  (111, '2022-06-02 00:00:00', 1),
  (111, '2022-06-03 00:00:00', 3),
  (111, '2022-06-04 00:00:00', 4),
  (111, '2022-06-05 00:00:00', 5);


SELECT * FROM tweets;

-- calculate the 3 days rolling average of each user
SELECT
	user_id,
    tweet_date,
    ROUND( AVG(tweet_count) OVER(PARTITION BY user_id ORDER BY tweet_date ASC RANGE BETWEEN INTERVAL 2 DAY PRECEDING AND CURRENT ROW), 2 ) AS rolling_avg_3d
FROM tweets;
################################################################################################################################################################
CREATE TABLE IF NOT EXISTS product_spend(
		category VARCHAR(50),
		product VARCHAR(50),
		user_id INT,
		spend DECIMAL(10, 2),
		transaction_date TIMESTAMP);

INSERT INTO product_spend (category, product, user_id, spend, transaction_date) VALUES
  ('appliance', 'refrigerator', 165, 246.00, '2021-12-26 12:00:00'),
  ('appliance', 'refrigerator', 123, 299.99, '2022-03-02 12:00:00'),
  ('appliance', 'washing machine', 123, 219.80, '2022-03-02 12:00:00'),
  ('electronics', 'vacuum', 178, 152.00, '2022-04-05 12:00:00'),
  ('electronics', 'wireless headset', 156, 249.90, '2022-07-08 12:00:00'),
  ('electronics', 'vacuum', 145, 189.00, '2022-07-15 12:00:00');

SELECT * FROM product_spend;

SELECT 
	category, 
    product, 
    spend AS total_spend
FROM(
	SELECT
		*,
		DENSE_RANK() OVER(PARTITION BY category ORDER BY spend DESC) AS rn
	FROM product_spend
    WHERE YEAR(transaction_date)=2022)
t
WHERE rn BETWEEN 1 AND 2;
#######################################################################################################################################

## ** Important ** ##
CREATE TABLE IF NOT EXISTS artists(
		artist_id INT,
		artist_name VARCHAR(50));

CREATE TABLE IF NOT EXISTS songs(
		song_id INT,
        artice_id INT);

CREATE TABLE IF NOT EXISTS global_song_rank (
    day INT CHECK (day >= 1 AND day <= 52),
    song_id INT,
    rank_ INT CHECK (rank_ >= 1 AND rank_ <= 1000000)
);

INSERT INTO artists (artist_id, artist_name) VALUES
  (101, 'Ed Sheeran'),
  (120, 'Drake');
  
  INSERT INTO songs (song_id, artice_id) VALUES
		(45202, 101),
        (19960, 120);

INSERT INTO global_song_rank (day, song_id, rank_) VALUES
  (1, 45202, 5),
  (3, 45202, 2),
  (1, 19960, 3),
  (9, 19960, 15);
  
  -- Additional data for the artists table
INSERT INTO artists (artist_id, artist_name) VALUES
  (102, 'Adele'),
  (103, 'Taylor Swift'),
  (104, 'The Weeknd'),
  (105, 'Justin Bieber'),
  (106, 'Billie Eilish'),
  (107, 'Post Malone'),
  (108, 'Ariana Grande'),
  (109, 'Beyoncé'),
  (110, 'Kanye West'),
  (111, 'Dua Lipa');

-- Additional data for the songs table
INSERT INTO songs (song_id, artice_id) VALUES
  (78901, 102),
  (56789, 103),
  (34567, 104),
  (23456, 105),
  (12345, 106),
  (87654, 107),
  (76543, 108),
  (65432, 109),
  (54321, 110),
  (43210, 111);

-- Additional data for the global_song_rank table
INSERT INTO global_song_rank (day, song_id, rank_) VALUES
  (2, 78901, 8),
  (4, 78901, 1),
  (2, 56789, 4),
  (10, 56789, 12),
  (4, 34567, 6),
  (10, 34567, 9),
  (2, 23456, 2),
  (6, 23456, 7),
  (8, 12345, 3),
  (12, 12345, 11);

  
  SELECT * FROM artists;
  SELECT * FROM songs;
  SELECT * FROM global_song_rank;
  
-- Q.5:Assume there are three Spotify tables containing information about the artists,
-- songs, and music charts. Write a query to find the top 5 artists whose songs appear most
-- frequently in the Top 10 of the global_song_rank table.
-- Grow Data Skills
-- Display the top 5 artist names in ascending order, along with their song appearance
-- ranking. Note that if two artists have the same number of song appearances, they should
-- have the same ranking, and the rank numbers should be continuous (i.e. 1, 2, 2, 3, 4, 5).
-- For instance, if Ed Sheeran appears in the Top 10 five times and Bad Bunning four times,
-- Ed Sheeran should be ranked 1st, and Bad Bunny should be ranked 2nd.

SELECT
    a.artist_name,
    DENSE_RANK() OVER(ORDER BY COUNT( * ) DESC) AS artist_rank 
FROM 
	artists a INNER JOIN songs s
ON 
	a.artist_id = s.artice_id
	INNER JOIN global_song_rank g
ON 
	g.song_id = s.song_id
WHERE 
	g.rank_ < 11
GROUP BY 
	a.artist_name
ORDER BY 
	a.artist_name ASC;
###############################################################################################################################################
CREATE TABLE IF NOT EXISTS emails(
		email_id INT,
		user_id INT,
		signup_date DATETIME);

CREATE TABLE IF NOT EXISTS texts(
		text_id INT,
		email_id INT,
		signup_action VARCHAR(20));

INSERT INTO emails (email_id, user_id, signup_date) VALUES
  (125, 7771, '2022-06-14 00:00:00'),
  (236, 6950, '2022-07-01 00:00:00'),
  (433, 1052, '2022-07-09 00:00:00');
  
INSERT INTO texts (text_id, email_id, signup_action) VALUES
  (6878, 125, 'Confirmed'),
  (6920, 236, 'Not Confirmed'),
  (6994, 236, 'Confirmed');

SELECT * FROM emails;
SELECT * FROM texts;

-- using CASE STATEMENT
SELECT
	ROUND( 
			SUM( CASE WHEN t.signup_action = 'Confirmed' THEN 1 ELSE 0 END ) / COUNT(t.email_id),
        2) AS confirm_rate
FROM 
	texts t LEFT JOIN emails e 
ON 
	e.email_id = t.email_id;


SELECT
	ROUND( 
			COUNT(e.email_id) / COUNT(t.email_id),
         2) AS confirm_rate
FROM 
	texts t LEFT JOIN emails e 
ON 
	e.email_id = t.email_id
AND 
	t.signup_action = 'Confirmed';
##########################################################################################################################################
CREATE TABLE IF NOT EXISTS customer_contracts(
		customer_id INT,
		product_id INT,
		amount INT);
        
CREATE TABLE IF NOT EXISTS products(
		product_id INT,
        product_category VARCHAR(30),
        product_name VARCHAR(30));

INSERT INTO customer_contracts (customer_id, product_id, amount)
VALUES
  (1, 1, 1000),
  (1, 3, 2000),
  (1, 5, 1500),
  (2, 2, 3000),
  (2, 6, 2000);

INSERT INTO products (product_id, product_category, product_name) VALUES
  (1, 'Analytics', 'Azure Databricks'),
  (2, 'Analytics', 'Azure Stream Analytics'),
  (4, 'Containers', 'Azure Kubernetes Service'),
  (5, 'Containers', 'Azure Service Fabric'),
  (6, 'Compute', 'Virtual Machines'),
  (7, 'Compute', 'Azure Functions');

INSERT INTO products (product_id, product_category, product_name) VALUES
	(3, 'Compute', 'Virtual Machines');

  
SELECT * FROM customer_contracts;
SELECT * FROM products;
    
WITH super_customers AS (
	SELECT
		c.customer_id, 
		COUNT( DISTINCT p.product_category ) AS unique_count
	FROM
		customer_contracts c LEFT JOIN products p 
	ON
		p.product_id = c.product_id
	GROUP BY 
		c.customer_id 
	)

SELECT
	customer_id
FROM 
	super_customers
WHERE 
	unique_count = ( SELECT COUNT( DISTINCT product_category) FROM products )
ORDER BY 
	customer_id;


SELECT
	customer_id
FROM (
	SELECT
		c.customer_id, 
		COUNT( DISTINCT p.product_category ) AS unique_count
	FROM
		customer_contracts c LEFT JOIN products p 
	ON
		p.product_id = c.product_id
	GROUP BY 
		c.customer_id 
	HAVING 
		COUNT( DISTINCT p.product_category ) = ( SELECT COUNT( DISTINCT product_category) FROM products )
	) t
ORDER BY 
	customer_id;
###################################################################################################################################
CREATE TABLE IF NOT EXISTS measurements(
		measurement_id INT,
        measurement_value DECIMAL(10, 2),
        measurement_time DATETIME);

INSERT INTO measurements (measurement_id, measurement_value, measurement_time) VALUES
  (131233, 1109.51, '2022-07-10 09:00:00'),
  (135211, 1662.74, '2022-07-10 11:00:00'),
  (523542, 1246.24, '2022-07-10 13:15:00'),
  (143562, 1124.50, '2022-07-11 15:00:00'),
  (346462, 1234.14, '2022-07-11 16:45:00');

SELECT *, HOUR(measurement_time) FROM measurements;

SELECT
	DATE(measurement_time) AS measurement_day,
    SUM( CASE WHEN rn % 2 != 0 THEN measurement_value ELSE 0 END ) AS odd_sum,
    SUM( CASE WHEN rn % 2 = 0 THEN measurement_value ELSE 0 END ) AS even_sum
FROM (
	SELECT
		*,
		DENSE_RANK() OVER(PARTITION BY DATE(measurement_time) ORDER BY measurement_time ASC) AS rn
	FROM measurements) t
GROUP BY 
	DATE(measurement_time);
###################################################################################################################################
CREATE TABLE IF NOT EXISTS user_transactions(
		product_id INT,
		user_id INT,
		spend DECIMAL(10, 2),
		transaction_date TIMESTAMP);

INSERT INTO user_transactions (product_id, user_id, spend, transaction_date) VALUES
  (3673, 123, 68.90, '2022-07-08 12:00:00'),
  (9623, 123, 274.10, '2022-07-08 12:00:00'),
  (1467, 115, 19.90, '2022-07-08 12:00:00'),
  (2513, 159, 25.00, '2022-07-08 12:00:00'),
  (1452, 159, 74.50, '2022-07-10 12:00:00');

SELECT * FROM user_transactions;

SELECT
	transaction_date,
	user_id,
    COUNT( DISTINCT product_id) AS purchase_count
FROM (
	SELECT
		*,
		DENSE_RANK() OVER(PARTITION BY user_id ORDER BY DATE(transaction_date) DESC) AS rn
	FROM user_transactions) 
t
WHERE 
	rn = 1
GROUP BY
	transaction_date, user_id
ORDER BY
	transaction_date;

#########################################################################################################################################
CREATE TABLE IF NOT EXISTS items_per_order(
		item_count INT,
        order_occurrences INT);

INSERT INTO items_per_order (item_count, order_occurrences) VALUES
  (1, 500),
  (2, 1000),
  (3, 800),
  (4, 1000);
  
SELECT * FROM items_per_order;

SELECT 
	item_count AS mode
FROM 
	items_per_order
WHERE 
	order_occurrences IN ( SELECT MAX(order_occurrences) FROM items_per_order );

########################################################################################################################################
CREATE TABLE IF NOT EXISTS monthly_cards_issued(
		issue_month INT,
		issue_year INT,
		card_name VARCHAR(30),
		issued_amount INT);

INSERT INTO monthly_cards_issued (issue_month, issue_year, card_name, issued_amount) VALUES
  (1, 2021, 'Chase Sapphire Reserve', 170000),
  (2, 2021, 'Chase Sapphire Reserve', 175000),
  (3, 2021, 'Chase Sapphire Reserve', 180000),
  (3, 2021, 'Chase Freedom Flex', 65000),
  (4, 2021, 'Chase Freedom Flex', 70000);

SELECT * FROM monthly_cards_issued;

SELECT
	card_name,
    issued_amount
FROM (
	SELECT
		*,
		FIRST_VALUE(issue_month) OVER(PARTITION BY card_name) AS launch_month
	FROM 
		monthly_cards_issued)
t
WHERE 
	issue_month = launch_month
ORDER BY
	issued_amount DESC;


-- USING JOIN
WITH card_releases AS (
	SELECT
		*,
		FIRST_VALUE(issue_month) OVER(PARTITION BY card_name) AS launch_month
	FROM 
		monthly_cards_issued
	)

SELECT
	DISTINCT l.card_name,
    l.issued_amount
FROM
	card_releases l INNER JOIN card_releases r
ON
	l.card_name = r.card_name AND l.issue_month = r.launch_month
ORDER BY
	l.issued_amount DESC;
###################################################################################################################################
## **Important** ##

CREATE TABLE IF NOT EXISTS phone_calls(
		caller_id INT,
		receiver_id INT,
		call_time TIMESTAMP);


CREATE TABLE IF NOT EXISTS phone_info(
		caller_id INT,
		country_id VARCHAR(10),
		network VARCHAR(20),
		phone_number VARCHAR(30));

INSERT INTO phone_calls (caller_id, receiver_id, call_time) VALUES
  (1, 2, '2022-07-04 10:13:49'),
  (1, 5, '2022-08-21 23:54:56'),
  (5, 1, '2022-05-13 17:24:06'),
  (5, 6, '2022-03-18 12:11:49');

INSERT INTO phone_info (caller_id, country_id, network, phone_number) VALUES
  (1, 'US', 'Verizon', '+1-212-897-1964'),
  (2, 'US', 'Verizon', '+1-703-346-9529'),
  (3, 'US', 'Verizon', '+1-650-828-4774'),
  (4, 'US', 'Verizon', '+1-415-224-6663'),
  (5, 'IN', 'Vodafone', '+91 7503-907302'),
  (6, 'IN', 'Vodafone', '+91 2287-664895');

SELECT * FROM phone_calls;
SELECT * FROM phone_info;

SELECT
	callers.caller_id, 
    calls.receiver_id,
    callers.country_id AS caller_nationality,
    receivers.country_id AS receiver_natinality
FROM 
	phone_calls calls LEFT JOIN  phone_info callers
ON 
	callers.caller_id = calls.caller_id
    LEFT JOIN phone_info receivers
ON 
	receivers.caller_id = calls.receiver_id;
 
 
SELECT
	ROUND(
		 SUM( CASE WHEN callers.country_id <> receivers.country_id THEN 1 ELSE 0 END ) / COUNT( * ),
        1) * 100 AS international_calls_pct
FROM 
	phone_calls calls LEFT JOIN  phone_info callers
ON 
	callers.caller_id = calls.caller_id
    LEFT JOIN phone_info receivers
ON 
	receivers.caller_id = calls.receiver_id;

                            ##################################################### **END** #####################################################
