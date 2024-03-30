USE EasyLevelWise_DB;

CREATE TABLE IF NOT EXISTS pages(
		page_id INT,
		page_name VARCHAR(50));
	
CREATE TABLE IF NOT EXISTS page_likes(
		user_id INT,
        page_id INT,
        liked_date DATETIME);
	
INSERT INTO pages (page_id, page_name) VALUES
(20001, 'SQL Solutions'),
(20045, 'Brain Exercises'),
(20701, 'Tips for Data Analysts');

INSERT INTO page_likes (user_id, page_id, liked_date) VALUES
    (111, 20001, '2022-04-08 00:00:00'),
    (121, 20045, '2022-03-12 00:00:00'),
    (156, 20001, '2022-07-25 00:00:00');

SELECT * FROM pages;
SELECT * FROM page_likes;

-- Write a query to return the IDs of the Facebook pages which do not possess any likes.
-- The output should be sorted in ascending order.
SELECT 
	DISTINCT page_id
FROM pages 
WHERE page_id NOT IN (SELECT DISTINCT page_id FROM page_likes);
######################################################################################################################################
CREATE TABLE IF NOT EXISTS parts_assembly(
		part VARCHAR(50),
		finish_date DATETIME,
		assembly_step INT);

INSERT INTO parts_assembly (part, finish_date, assembly_step) VALUES
    ('battery', '2022-01-22 00:00:00', 1),
    ('battery', '2022-02-22 00:00:00', 2),
    ('battery', '2022-03-22 00:00:00', 3),
    ('bumper', '2022-01-22 00:00:00', 1),
    ('bumper', '2022-02-22 00:00:00', 2),
    ('bumper', NULL, 3),
    ('bumper', NULL, 4);

SELECT * FROM parts_assembly;

-- Write a query that determines which parts with the assembly steps have
-- initiated the assembly process but remain unfinished.
-- Assumptions:
-- ● parts_assembly table contains all parts currently in production, each at varying
-- stages of the assembly process.
-- ● An unfinished part is one that lacks a finish_date.
SELECT 
	part, assembly_step
FROM parts_assembly
WHERE finish_date IS NULL;
########################################################################################################
CREATE TABLE IF NOT EXISTS tweets(
		tweet_id INT,
		user_id INT,
		msg VARCHAR(1000),
		tweet_date TIMESTAMP);

INSERT INTO tweets (tweet_id, user_id, msg, tweet_date) VALUES
    (214252, 111, 'Am considering taking Tesla private at $420. Funding secured.', '2021-12-30 00:00:00'),
    (739252, 111, 'Despite the constant negative press covfefe', '2022-01-01 00:00:00'),
    (846402, 111, 'Following @NickSinghTech on Twitter changed my life!', '2022-02-14 00:00:00'),
    (241425, 254, 'If the salary is so competitive why won’t you tell me what it is?', '2022-03-01 00:00:00'),
    (231574, 148, "I no longer have a manager. I can't be managed", '2022-03-23 00:00:00');

SELECT * FROM tweets;

-- Q.3: Assume you're given a table Twitter tweet data, write a query to obtain a histogram of
-- tweets posted per user in 2022. Output the tweet count per user as the bucket and the
-- number of Twitter users who fall into that bucket.
-- In other words, group the users by the number of tweets they posted in 2022 and count
-- the number of users in each group.

SELECT 
	COUNT(*) AS tweet_bucket, users_num
FROM(
	SELECT
		user_id, COUNT(*) as users_num, YEAR(tweet_date) AS year
	FROM tweets
    WHERE YEAR(tweet_date) = 2022
	GROUP BY user_id, YEAR(tweet_date))t
GROUP BY users_num
ORDER BY tweet_bucket ASC;
#############################################################################################################################################
CREATE TABLE IF NOT EXISTS viewership(
		user_id INT,
		device_type ENUM ('laptop', 'tablet', 'phone'),
		view_time TIMESTAMP);

INSERT INTO viewership (user_id, device_type, view_time) VALUES
    (123, 'tablet', '2022-01-02 00:00:00'),
    (125, 'laptop', '2022-01-07 00:00:00'),
    (128, 'laptop', '2022-02-09 00:00:00'),
    (129, 'phone', '2022-02-09 00:00:00'),
    (145, 'tablet', '2022-02-24 00:00:00');
    
SELECT * FROM viewership;

-- Write a query that calculates the total viewership for laptops and mobile devices where
-- mobile is defined as the sum of tablet and phone viewership. Output the total viewership
-- for laptops as laptop_reviews and the total viewership for mobile devices as
-- mobile_views.

SELECT 
  SUM( CASE WHEN device_type = 'laptop' THEN 1 ELSE 0 END ) AS laptop_views,
  SUM( CASE WHEN device_type IN ('tablet', 'phone') THEN 1 ELSE 0 END ) AS mobile_views
FROM viewership;
#####################################################################################################################################
CREATE TABLE IF NOT EXISTS candidates(
		candidate_id INT,
		skill VARCHAR(20));

INSERT INTO candidates (candidate_id, skill) VALUES
    (123, 'Python'),
    (123, 'Tableau'),
    (123, 'PostgreSQL'),
    (234, 'R'),
    (234, 'PowerBI'),
    (234, 'SQL Server'),
    (345, 'Python'),
    (345, 'Tableau');

-- as I want to check one thing
INSERT INTO candidates (candidate_id, skill) VALUES
		(345, 'Python');

SELECT * FROM candidates;

-- Q.5: Given a table of candidates and their skills, you're tasked with finding the candidates
-- best suited for an open Data Science job. You want to find candidates who are proficient
-- in Python, Tableau, and PostgreSQL.
-- Write a query to list the candidates who possess all of the required skills for the job. Sort
-- the output by candidate ID in ascending order.

SELECT 
	candidate_id, COUNT( DISTINCT skill ) AS skill_count
FROM candidates c1
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT( DISTINCT skill ) = 3
ORDER BY candidate_id ASC;
############################################################################################################################
CREATE TABLE IF NOT EXISTS posts(
		user_id INT,
		post_id INT,
		post_date TIMESTAMP,
		post_content TEXT);

INSERT INTO posts (user_id, post_id, post_date, post_content) VALUES
    (151652, 599415, '2021-07-10 12:00:00', 'Need a hug'),
    (661093, 624356, '2021-07-29 13:00:00', 'Bed. Class 8-12. Work 12-3. Gym 3-5 or 6. Then class 6-10. Another day that\'s gonna fly by. I miss my girlfriend'),
    (004239, 784254, '2021-07-04 11:00:00', 'Happy 4th of July!'),
    (661093, 442560, '2021-07-08 14:00:00', 'Just going to cry myself to sleep after watching Marley and Me.'),
    (151652, 111766, '2021-07-12 19:00:00', 'I\'m so done with covid - need traveling. ASAP!');

SELECT * FROM posts;

-- Q.6: Given a table of Facebook posts, for each user who posted at least twice in 2021,
-- write a query to find the number of days between each user’s first post of the year and
-- last post of the year in the year 2021. Output the user and number of the days between
-- each user's first and last post.

SELECT
	DISTINCT user_id, days_between
FROM(
	SELECT
		*,
		FIRST_VALUE(post_date) OVER(PARTITION BY user_id ORDER BY post_date ASC) AS first_post,
		LAST_VALUE(post_date) OVER(PARTITION BY user_id ORDER BY post_date ASC) AS last_post,
		DAY(LAST_VALUE(post_date) OVER(PARTITION BY user_id ORDER BY post_date ASC)) - DAY(FIRST_VALUE(post_date) OVER(PARTITION BY user_id ORDER BY post_date ASC)) AS days_between
	FROM posts
	WHERE YEAR(post_date) = 2021) t
WHERE days_between >= 2;
##############################################################################################################################################
CREATE TABLE IF NOT EXISTS messages(
		message_id INT,
		sender_id INT,
		receiver_id INT,
		content TEXT,
		sent_date DATETIME);

INSERT INTO messages (message_id, sender_id, receiver_id, content, sent_date) VALUES
    (901, 3601, 4500, 'You up?', '2022-08-03 00:00:00'),
    (902, 4500, 3601, 'Only if you''re buying', '2022-08-03 00:00:00'),
    (743, 3601, 8752, 'Let''s take this offline', '2022-06-14 00:00:00'),
    (922, 3601, 4500, 'Get on the call', '2022-08-10 00:00:00');

SELECT * FROM messages;

-- Q.7: Write a query to identify the top 2 Power Users who sent the highest number of
-- messages on Microsoft Teams in August 2022. Display the IDs of these 2 users along with
-- the total number of messages they sent. Output the results in descending order based on
-- the count of the messages.
-- Assumption:
-- ● No two users have sent the same number of messages in August 2022.

SELECT
	sender_id, COUNT(*) AS message_count
FROM messages
WHERE YEAR(sent_date) = 2022 AND MONTH(sent_date) = 8
GROUP BY sender_id
ORDER BY message_count;
#######################################################################################################################
CREATE TABLE IF NOT EXISTS job_listings(
		job_id INT,
		company_id INT,
		title VARCHAR(30),
		description TEXT);

INSERT INTO job_listings (job_id, company_id, title, description) VALUES
    (248, 827, 'Business Analyst', 'Business analyst evaluates past and current business data with the primary goal of improving decision-making processes within organizations.'),
    (149, 845, 'Business Analyst', 'Business analyst evaluates past and current business data with the primary goal of improving decision-making processes within organizations.'),
    (945, 345, 'Data Analyst', 'Data analyst reviews data to identify key insights into a business''s customers and ways the data can be used to solve problems.');

INSERT INTO job_listings (job_id, company_id, title, description) VALUES
    (164, 345, 'Data Analyst', 'Data analyst reviews data to identify key insights into a business''s customers and ways the data can be used to solve problems.'),
    (172, 244, 'Data Engineer', 'Data engineer works in a variety of settings to build systems that collect, manage, and convert raw data into usable information for data scientists and business analysts to interpret.');


SELECT * FROM job_listings;

-- Q.8: Assume you are given the table below that shows job postings for all companies on
-- the LinkedIn platform. Write a query to get the number of companies that have posted
-- duplicate job listings.
-- Clarification:
-- ● Duplicate job listings refer to two jobs at the same company with the same title
-- and description.

SELECT
	SUM( CASE WHEN count > 1 THEN 1 ELSE 0 END) AS co_w_duplicate_jobs
FROM(
	SELECT
		company_id, title, description, COUNT(*) AS count
	FROM job_listings
	GROUP BY company_id, title, description)
t;

-- using join
SELECT 
	COUNT( DISTINCT l.company_id ) AS co_w_duplicate_jobs
FROM 
job_listings l INNER JOIN (
			SELECT 
				company_id, title, description
			FROM job_listings
			GROUP BY company_id, title, description
			HAVING COUNT(*) > 1
		) r
ON l.company_id = r.company_id AND l.title = r.title AND l.description = r.description;
#########################################################################################################################################
CREATE TABLE IF NOT EXISTS trades(
		order_id INT,
		user_id INT,
		price DECIMAL(10, 6),
		quantity INT,
		status ENUM ('Completed' ,'Cancelled'),
		timestamp DATETIME);

CREATE TABLE IF NOT EXISTS users(
		user_id INT,
		city VARCHAR(20),
		email VARCHAR(100),
		signup_date DATETIME);

INSERT INTO trades (order_id, user_id, price, quantity, status, timestamp) VALUES
    (100101, 111, 9.80, 10, 'Cancelled', '2022-08-17 12:00:00'),
    (100102, 111, 10.00, 10, 'Completed', '2022-08-17 12:00:00'),
    (100259, 148, 5.10, 35, 'Completed', '2022-08-25 12:00:00'),
    (100264, 148, 4.80, 40, 'Completed', '2022-08-26 12:00:00'),
    (100305, 300, 10.00, 15, 'Completed', '2022-09-05 12:00:00'),
    (100400, 178, 9.90, 15, 'Completed', '2022-09-09 12:00:00'),
    (100565, 265, 25.60, 5, 'Completed', '2022-12-19 12:00:00');

INSERT INTO users (user_id, city, email, signup_date) VALUES
    (111, 'San Francisco', 'rrok10@gmail.com', '2021-08-03 12:00:00'),
    (148, 'Boston', 'sailor9820@gmail.com', '2021-08-20 12:00:00'),
    (178, 'San Francisco', 'harrypotterfan182@gmail.com', '2022-01-05 12:00:00'),
    (265, 'Denver', 'shadower_@hotmail.com', '2022-02-26 12:00:00'),
    (300, 'San Francisco', 'houstoncowboy1122@hotmail.com', '2022-06-30 12:00:00');


SELECT * FROM trades;
SELECT * FROM users;

-- Q.9:Assume you're given the tables containing completed trade orders and user details in
-- a Robinhood trading system.
-- Write a query to retrieve the top three cities that have the highest number of completed
-- trade orders listed in descending order. Output the city name and the corresponding
-- number of completed trade orders

SELECT 
	u.city, count( * ) AS total_orders
FROM users u INNER JOIN trades t
ON u.user_id = t.user_id
WHERE t.status = 'Completed'
GROUP BY u.city
ORDER BY total_orders DESC
LIMIT 3;
########################################################################################################################################
CREATE TABLE IF NOT EXISTS reviews(
		review_id INT,
		user_id INT,
		submit_date DATETIME,
		product_id INT,
		stars INT CHECK ( stars >= 1 AND stars <= 5));

INSERT INTO reviews (review_id, user_id, submit_date, product_id, stars) VALUES
    (6171, 123, '2022-06-08 00:00:00', 50001, 4),
    (7802, 265, '2022-06-10 00:00:00', 69852, 4),
    (5293, 362, '2022-06-18 00:00:00', 50001, 3),
    (6352, 192, '2022-07-26 00:00:00', 69852, 3),
    (4517, 981, '2022-07-05 00:00:00', 69852, 2);

SELECT * FROM reviews;

-- Q.10: Given the reviews table, write a query to retrieve the average star rating for each
-- product, grouped by month. The output should display the month as a numerical value,
-- product ID, and average star rating rounded to two decimal places. Sort the output first by
-- month and then by product ID.

SELECT
	MONTH(submit_date) AS mth, product_id AS product, ROUND(AVG(stars), 2) AS avg_stars
FROM reviews
GROUP BY  MONTH(submit_date), product_id
ORDER BY mth, product;
#######################################################################################################################
CREATE TABLE IF NOT EXISTS events(
		app_id INT,
		event_type TEXT,
		timestamp DATETIME);

INSERT INTO events (app_id, event_type, timestamp) VALUES
    (123, 'impression', '2022-07-18 11:36:12'),
    (123, 'impression', '2022-07-18 11:37:12'),
    (123, 'click', '2022-07-18 11:37:42'),
    (234, 'impression', '2022-07-18 14:15:12'),
    (234, 'click', '2022-07-18 14:16:12');

SELECT * FROM events;

-- Q.11: Assume you have an events table on Facebook app analytics. Write a query to
-- calculate the click-through rate (CTR) for the app in 2022 and round the results to 2
-- decimal places.
-- Definition and note:
-- ● Percentage of click-through rate (CTR) = 100.0 * Number of clicks / Number of
-- impressions
-- ● To avoid integer division, multiply the CTR by 100.0, not 100

SELECT
	app_id,
    ROUND( SUM( CASE WHEN event_type = 'click' THEN 1 ELSE 0 END ) / NULLIF( SUM( CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END ), 0 )*100.0, 2) AS CTR
FROM events
WHERE YEAR(timestamp) = 2022 
GROUP BY app_id;
##########################################################################################################################################
CREATE TABLE IF NOT EXISTS emails(
		email_id INT,
		user_id INT,
		signup_date DATETIME);

CREATE TABLE IF NOT EXISTS texts(
		text_id INT,
		email_id INT,
		signup_action ENUM ('Confirmed', 'Not confirmed'),
		action_date DATETIME);

-- Insert values into the "emails" table
INSERT INTO emails (email_id, user_id, signup_date)
VALUES
  (125, 7771, '2022-06-14 00:00:00'),
  (433, 1052, '2022-07-09 00:00:00');

-- Insert values into the "texts" table
INSERT INTO texts (text_id, email_id, signup_action, action_date)
VALUES
  (6878, 125, 'Confirmed', '2022-06-14 00:00:00'),
  (6997, 433, 'Not Confirmed', '2022-07-09 00:00:00'),
  (7000, 433, 'Confirmed', '2022-07-10 00:00:00');

SELECT * FROM emails;
SELECT * FROM texts;

-- Q.12: Assume you're given tables with information about TikTok user sign-ups and
-- confirmations through email and text. New users on TikTok sign up using their email
-- addresses, and upon sign-up, each user receives a text message confirmation to activate
-- their account.
-- Write a query to display the user IDs of those who did not confirm their sign-up on the
-- first day, but confirmed on the second day.
-- Definition:
-- ● action_date refers to the date when users activated their accounts and
-- confirmed their sign-up through text messages

SELECT
	e.user_id
FROM texts t LEFT JOIN emails e
ON t.email_id = e.email_id
WHERE DATEDIFF(t.action_date, e.signup_date)=1 AND t.signup_action='Confirmed';
###################################################################################################################################################
CREATE TABLE IF NOT EXISTS monthly_cards_issued(
		issue_month INT,
		issue_year INT,
		card_name VARCHAR(50),
		issued_amount INT);

INSERT INTO monthly_cards_issued (card_name, issued_amount, issue_month, issue_year) VALUES
  ('Chase Freedom Flex', 55000, 1, 2021),
  ('Chase Freedom Flex', 60000, 2, 2021),
  ('Chase Freedom Flex', 65000, 3, 2021);

INSERT INTO monthly_cards_issued (card_name, issued_amount, issue_month, issue_year) VALUES
  ('Chase Freedom Flex', 70000, 4, 2021),
  ('Chase Sapphire Reserve', 170000, 1, 2021),
  ('Chase Sapphire Reserve', 175000, 2, 2021),
  ('Chase Sapphire Reserve', 180000, 3, 2021);

SELECT * FROM monthly_cards_issued;

-- Q.13: Your team at JPMorgan Chase is soon launching a new credit card, and to gain
-- some context, you are analyzing how many credit cards were issued each month.
-- Write a query that outputs the name of each credit card and the difference in issued
-- amount between the month with the most cards issued, and the least cards issued. Order
-- the results according to the biggest difference
SELECT
  card_name,
  MAX(issued_amount) - MIN(issued_amount) AS difference
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY difference DESC;
###########################################################################################################################
CREATE TABLE IF NOT EXISTS items_per_order(
		item_count INT,
		order_occurrences INT);

INSERT INTO items_per_order (item_count, order_occurrences) VALUES
  (1, 500),
  (2, 1000),
  (3, 800),
  (4, 1000);

SELECT * FROM items_per_order;

-- Q.14: You're trying to find the mean number of items per order on Alibaba, rounded to 1
-- decimal place using tables which includes information on the count of items in each order
-- (item_count table) and the corresponding number of orders for each item count
-- (order_occurrences table).

-- Hint: There are a total of 500 orders with one item per order, 1000 orders with two items per
		-- order, and 800 orders with three items per order."
SELECT 
	ROUND(SUM(item_count*order_occurrences) / SUM(order_occurrences), 1) AS mean
FROM items_per_order;
#######################################################################################################################################
CREATE TABLE IF NOT EXISTS pharmacy_sales(
		product_id INT,
		units_sold INT,
		total_sales DECIMAL(10, 2),
		cogs DECIMAL(10, 2),
		manufacturer VARCHAR(50),
		drug VARCHAR(50));

INSERT INTO pharmacy_sales (product_id, units_sold, total_sales, cogs, manufacturer, drug) VALUES
  (9, 37410, 293452.54, 208876.01, 'Eli Lilly', 'Zyprexa'),
  (34, 94698, 600997.19, 521182.16, 'AstraZeneca', 'Surmontil'),
  (61, 77023, 500101.61, 419174.97, 'Biogen', 'Varicose Relief'),
  (136, 144814, 1084258, 1006447.73, 'Biogen', 'Burkhart');

SELECT * FROM pharmacy_sales;

-- Q.15: CVS Health is trying to better understand its pharmacy sales, and how well different
-- products are selling. Each drug can only be produced by one manufacturer.
-- Write a query to find the top 3 most profitable drugs sold, and how much profit they made.
-- Assume that there are no ties in the profits. Display the result from the highest to the
-- lowest total profit.
-- Definition:
-- ● cogs stands for Cost of Goods Sold which is the direct cost associated with
-- producing the drug.
-- ● Total Profit = Total Sales - Cost of Goods Sold

SELECT 
	drug, total_sales - cogs AS total_profit
FROM (
	SELECT
		*,
		 DENSE_RANK() OVER(ORDER BY total_sales - cogs DESC) AS rn
	FROM pharmacy_sales) t
WHERE rn BETWEEN 1 AND 3
ORDER BY total_profit DESC;

-- Q.16: CVS Health is analyzing its pharmacy sales data, and how well different products
-- are selling in the market. Each drug is exclusively manufactured by a single manufacturer.
-- Write a query to identify the manufacturers associated with the drugs that resulted in
-- losses for CVS Health and calculate the total amount of losses incurred.
-- Output the manufacturer's name, the number of drugs associated with losses, and the
-- total losses in absolute value. Display the results sorted in descending order with the
-- highest losses displayed at the top.

INSERT INTO pharmacy_sales (product_id, units_sold, total_sales, cogs, manufacturer, drug) VALUES
  (156, 89514, 3130097.00, 3427421.73, 'Biogen', 'Acyclovir'),
  (25, 222331, 2753546.00, 2974975.36, 'AbbVie', 'Lamivudine and Zidovudine'),
  (50, 90484, 2521023.73, 2742445.90, 'Eli Lilly', 'Dermasorb TA Complete Kit'),
  (98, 110746, 813188.82, 140422.87, 'Biogen', 'Medi-Chord');

SELECT * FROM pharmacy_sales;

SELECT
  manufacturer,
  COUNT( drug ) AS drug_count,
  SUM( ABS(cogs - total_sales) ) AS total_loss
FROM pharmacy_sales
WHERE cogs > total_sales
GROUP BY manufacturer
ORDER BY total_loss DESC;
###############################################################################################################################################
TRUNCATE TABLE pharmacy_sales;
INSERT INTO pharmacy_sales (product_id, units_sold, total_sales, cogs, manufacturer, drug) VALUES
  (94, 132362, 2041758.41, 1373721.60, 'Biogen', 'UP and UP'),
  (9, 37410, 293452.54, 208876.01, 'Eli Lilly', 'Zyprexa'),
  (50, 90484, 2521023.73, 2742445.90, 'Eli Lilly', 'Dermasorb'),
  (61, 77023, 500101.61, 419174.97, 'Biogen', 'Varicose Relief'),
  (136, 144814, 1084258.00, 1006447.73, 'Biogen', 'Burkhart');

SELECT * FROM pharmacy_sales;

-- Q.17: CVS Health is trying to better understand its pharmacy sales, and how well different
-- products are selling.
-- Write a query to find the total drug sales for each manufacturer. Round your answer to the
-- closest million, and report your results in descending order of total sales.
-- Because this data is being directly fed into a dashboard which is being seen by business
-- stakeholders, format your result like this: "$36 million".

SELECT
	manufacturer, 
    CONCAT( '$', ROUND( SUM(total_sales) / 1000000 ), ' million' ) AS sales
FROM pharmacy_sales
GROUP BY  manufacturer
ORDER BY SUM(total_sales) DESC;
############################################################################################################################
CREATE TABLE IF NOT EXISTS callers(
		policy_holder_id INT,
		case_id VARCHAR(50),
		call_category VARCHAR(50),
		call_received TIMESTAMP,
		call_duration_secs INT,
		original_order INT);


INSERT INTO callers (policy_holder_id, case_id, call_category, call_received, call_duration_secs, original_order) VALUES
  (50837000, 'dc63-acae-4f39-bb04', 'claims', '2022-03-09 02:51:00', 205, 130),
  (50837000, '41bebebe-4bd0-a1ba', 'IT_support', '2022-03-12 05:37:00', 254, 129),
  (50936674, '12c8-b35c-48a3-b38d', 'claims', '2022-05-31 07:27:00', 240, 31),
  (50886837, 'd0b4-8ea7-4b8caa8b', 'IT_support', '2022-03-11 03:38:00', 276, 16),
  (50886837, 'a741-c279-41c0-90ba', NULL, '2022-03-19 10:52:00', 131, 325),
  (50837000, 'bab1-3ec5-4867-90ae', 'benefits', '2022-05-13 18:19:00', 228, 339);

SELECT * FROM callers;

SELECT 
	SUM( CASE WHEN count > 2 THEN 1 ELSE 0 END ) AS member_count
FROM (
	SELECT
		policy_holder_id,
		COUNT( * ) AS count
	FROM callers
	GROUP BY policy_holder_id) 
t;
#############################################################################################################################
-- Write a query to find the percentage of calls that cannot be categorised. Round your
-- answer to 1 decimal place
TRUNCATE TABLE callers;

INSERT INTO callers (policy_holder_id, case_id, call_category, call_received, call_duration_secs, original_order) VALUES
  (52481621, 'a94c-2213-4ba5-812d', NULL, '2022-01-17 19:37:00', 286, 161),
  (51435044, 'f0b5-0eb0-4c49-b21e', NULL, '2022-01-18 02:46:00', 208, 225),
  (52082925, '289bd7e8-4527-bdf5', 'benefits', '2022-01-18 03:01:00', 291, 352),
  (54624612, '62c2-d9a3-44d2-9065', 'IT_support', '2022-01-19 00:27:00', 273, 358),
  (54624612, '9f57-164b-4a36-934e', 'claims', '2022-01-19 06:33:00', 157, 362);

SELECT * FROM callers;

SELECT
	ROUND( ( IFNULL( SUM( CASE WHEN call_category IS NULL THEN 1 ELSE 0 END ), 0 ) / COUNT( * ) )*100.00, 1 ) AS call_percentage
FROM callers;

              ######################################################### XXXXXXXXXX ##########################################################
