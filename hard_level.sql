USE hard_levelwise_db;

CREATE TABLE IF NOT EXISTS user_actions(
		user_id INT,
		event_id INT,
		event_type ENUM ("sign-in", "like", "comment"),
		event_date DATETIME);
        
-- Insert values into the "user_actions" table
INSERT INTO user_actions (user_id, event_id, event_type, event_date) VALUES
  (445, 7765, 'sign-in', '2022-05-31 12:00:00'),
  (742, 6458, 'sign-in', '2022-06-03 12:00:00'),
  (445, 3634, 'like', '2022-06-05 12:00:00'),
  (742, 1374, 'comment', '2022-06-05 12:00:00'),
  (648, 3124, 'like', '2022-06-18 12:00:00');
  
-- Additional data for the "user_actions" table
INSERT INTO user_actions (user_id, event_id, event_type, event_date) VALUES
  (123, 1111, 'sign-in', '2022-06-15 12:00:00'),
  (456, 2222, 'like', '2022-06-20 12:00:00'),
  (789, 3333, 'comment', '2022-06-25 12:00:00'),
  (123, 4444, 'sign-in', '2022-07-05 12:00:00'),
  (456, 5555, 'like', '2022-07-10 12:00:00'),
  (789, 6666, 'comment', '2022-07-15 12:00:00');

  
  SELECT * FROM user_actions;
  
-- Q.1: Assume you're given a table containing information on Facebook user actions. Write a
-- query to obtain the number of monthly active users (MAUs) in July 2022, including the month in
-- numerical format "1, 2, 3".
-- Hint:
-- ● An active user is defined as a user who has performed actions such as 'sign-in', 'like', or
-- 'comment' in both the current month and the previous month.

SELECT
    MONTH(curr_month.event_date) AS mnth,
    COUNT( DISTINCT curr_month.user_id ) AS monthly_active_users
FROM
    user_actions curr_month
JOIN
    user_actions last_month
ON
    curr_month.user_id = last_month.user_id
    AND YEAR(curr_month.event_date) = YEAR(last_month.event_date)
    AND MONTH(curr_month.event_date) = MONTH(last_month.event_date) + 1
WHERE
    MONTH(curr_month.event_date) = 7 AND YEAR(curr_month.event_date) = 2022
GROUP BY
    MONTH(curr_month.event_date);
###############################################################################################################
CREATE TABLE IF NOT EXISTS user_transactions(
			transaction_id INT,
			product_id INT,
			spend DECIMAL(10, 2),
			transaction_date DATETIME);

-- Insert values into the "user_transactions" table
INSERT INTO user_transactions (transaction_id, product_id, spend, transaction_date) VALUES
  (1341, 123424, 1500.60, '2019-12-31 12:00:00'),
  (1423, 123424, 1000.20, '2020-12-31 12:00:00'),
  (1623, 123424, 1246.44, '2021-12-31 12:00:00'),
  (1322, 123424, 2145.32, '2022-12-31 12:00:00');

SELECT * FROM user_transactions;

-- Q.2: Assume you are given the table below containing information on user transactions for
-- particular products. Write a query to obtain the year-on-year growth rate for the total spend of
-- each product for each year.
-- Output the year (in ascending order) partitioned by product id, current year's spend, previous
-- year's spend and year-on-year growth rate (percentage rounded to 2 decimal places).


SELECT
	*,
    ROUND( 
		((curr_year_spend - prev_year_spend) / prev_year_spend)*100.00, 
        2 )AS yoy_rate
FROM (
	SELECT
		YEAR(curr_year.transaction_date) AS year,
		curr_year.product_id,
		curr_year.spend AS curr_year_spend,
		LAG( curr_year.spend ) OVER( PARTITION BY curr_year.product_id ORDER BY curr_year.transaction_date ) AS prev_year_spend
	FROM
		user_transactions curr_year
	ORDER BY
		curr_year.product_id, year) 
t;

-- SELECT
-- 	YEAR(curr_year.transaction_date) AS year,
-- 	curr_year.product_id,
--     curr_year.spend AS curr_year_spend,
--     last_year.spend AS prev_year_spend
-- FROM
-- 	user_transactions last_year
-- JOIN 
-- 	user_transactions curr_year
-- ON 
-- 	last_year.product_id = curr_year.product_id
--     AND YEAR(last_year.transaction_date) = YEAR(curr_year.transaction_date) - 1;

#################################################################################################################################
CREATE TABLE IF NOT EXISTS inventory(
		item_id INT,
		item_type VARCHAR(30),
		item_category VARCHAR(30),
		square_footage DECIMAL(10, 2));

-- Insert values into the "inventory" table
INSERT INTO inventory (item_id, item_type, item_category, square_footage) VALUES
  (1374, 'prime_eligible', 'mini refrigerator', 68.00),
  (4245, 'not_prime', 'standing lamp', 26.40),
  (2452, 'prime_eligible', 'television', 85.00),
  (3255, 'not_prime', 'side table', 22.60),
  (1672, 'prime_eligible', 'laptop', 8.50);

SELECT * FROM inventory;


SELECT
	SUM( CASE WHEN item_type = 'prime_eligible' THEN square_footage ELSE 0 END) AS prime_item_square_footage,
    SUM( CASE WHEN item_type <> 'prime_eligible' THEN square_footage ELSE 0 END) AS not_prime_square_footage,
    SUM( CASE WHEN item_type = 'prime_eligible' THEN 1 ELSE 0 END) AS prime_item_count,
    SUM( CASE WHEN item_type <> 'prime_eligible' THEN 1 ELSE 0 END) AS not_prime_count
FROM inventory;

WITH summary AS(
	SELECT
	SUM( CASE WHEN item_type = 'prime_eligible' THEN square_footage ELSE 0 END ) AS prime_item_square_footage,
    SUM( CASE WHEN item_type <> 'prime_eligible' THEN square_footage ELSE 0 END ) AS not_prime_square_footage,
    SUM( CASE WHEN item_type = 'prime_eligible' THEN 1 ELSE 0 END ) AS prime_item_count,
    SUM( CASE WHEN item_type <> 'prime_eligible' THEN 1 ELSE 0 END ) AS not_prime_count
FROM inventory),

prime_items_occupy AS (
	SELECT 
		s.prime_item_square_footage,
		FLOOR( (500000 * s.prime_item_count) / s.prime_item_square_footage ) AS total_prime_item_can_store,
        (500000 - ((s.prime_item_square_footage/3)*FLOOR( (500000 * s.prime_item_count) / s.prime_item_square_footage ))) AS storage_left_for_non_prime
	FROM summary s)
    
SELECT 
    'prime_eligible' AS item_type,
    p.total_prime_item_can_store AS total_items_can_store
FROM prime_items_occupy p

UNION

SELECT 
	'not_prime' AS item_type,
    FLOOR( (p.storage_left_for_non_prime * s.not_prime_count) / s.not_prime_square_footage) AS total_non_prime_tem_can_store
FROM prime_items_occupy p, summary s;

#######################################################################################################################################
CREATE TABLE IF NOT EXISTS search_frequency(
		searches INT,
		num_users INT);

-- Insert values into the "search_frequency" table
INSERT INTO search_frequency (searches, num_users)
VALUES
  (1, 2),
  (2, 2),
  (3, 3),
  (4, 1);
  
  SELECT * FROM search_frequency;
  
--  Write a query to report the median of searches made by a user. Round the median to one
-- decimal point.

WITH RankSearches AS (
	SELECT
		searches,
		ROW_NUMBER() OVER (ORDER BY searches ASC) AS RowNumASC,
		ROW_NUMBER() OVER (ORDER BY searches DESC) AS RowNumDESC
	FROM search_frequency)

SELECT
	ROUND( AVG (searches) , 1) AS median
FROM RankSearches
WHERE RowNumASC = RowNumDESC OR RowNumDESC + 1 = RowNumASC OR RowNumASC + 1 = RowNumDESC;
#################################################################################################################################
CREATE TABLE IF NOT EXISTS advertiser(
		user_id VARCHAR(50),
		status VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS daily_pay(
		user_id VARCHAR(50),
		paid DECIMAL(10, 2)
);

truncate table advertiser;
truncate table daily_pay;

-- Insert values into the "advertiser" table
INSERT INTO advertiser (user_id, status) VALUES
  ('bing', 'NEW'),
  ('yahoo', 'NEW'),
  ('alibaba', 'EXISTING');
  
-- Insert data into advertiser table 
-- INSERT INTO advertiser (user_id, status) VALUES
--     ('yahoo', 'Existing'),
--     ('alibaba', 'Churn'),
--     ('target', 'New'),
--     ('facebook', 'Existing'),
--     ('google', 'Churn');

-- Insert values into the "daily_pay" table
INSERT INTO daily_pay (user_id, paid) VALUES
  ('yahoo', 45.00),
  ('alibaba', 100.00),
  ('target', 13.00);

-- Insert data into daily_pay table
-- INSERT INTO daily_pay (user_id, paid) VALUES
--     ('yahoo', 45.00),
--     ('alibaba', 100.00),
--     ('target', 13.00),
--     ('facebook', 75.00),
--     ('google', 0.00);

SELECT * FROM advertiser;
SELECT * FROM daily_pay;

SELECT
	a.user_id,
    a.status,
    d.paid
FROM 
	advertiser a 
    LEFT JOIN daily_pay d
ON 
	a.user_id = d.user_id;
    
    
WITH payment_advertise AS (
		SELECT
			a.user_id,
			a.status,
			d.paid
		FROM 
			advertiser a 
			LEFT JOIN daily_pay d
		ON 
			a.user_id = d.user_id
)

SELECT
	pa.user_id,
    CASE
		WHEN pa.paid IS NULL THEN "CHURN"
        WHEN pa.status = "CHURN" AND pa.paid IS NOT NULL THEN "RESURRENT"
        WHEN pa.status <> "CHURN" AND pa.paid IS NOT NULL THEN "EXISTING"
        WHEN pa.status IS NULL THEN "NEW"
        END AS new_status
FROM 
	payment_advertise pa
ORDER BY 
	pa.user_id;

####################################################################################################################################
CREATE TABLE IF NOT EXISTS pizza_toppings(
		topping_name VARCHAR(100),
		ingredient_cost DECIMAL(10,2)
);


-- Insert values into the "pizza_toppings" table
INSERT INTO pizza_toppings (topping_name, ingredient_cost) VALUES
  ('Pepperoni', 0.50),
  ('Sausage', 0.70),
  ('Chicken', 0.55),
  ('Extra Cheese', 0.40);
  
  SELECT * FROM pizza_toppings;
  
  SELECT
	p1.topping_name,
    p1.ingredient_cost,
	p2.topping_name,
    p2.ingredient_cost,
	p3.topping_name,
    p3.ingredient_cost
  FROM 
	pizza_toppings p1 
    INNER JOIN pizza_toppings p2
ON
	p1.topping_name < p2.topping_name
    INNER JOIN pizza_toppings p3
ON 
	p2.topping_name < p3.topping_name;
    
    
  SELECT
	CONCAT(p1.topping_name, ',', p2.topping_name, ',', p3.topping_name) AS pizza,
    p1.ingredient_cost + p2.ingredient_cost + p3.ingredient_cost AS total_cost
  FROM 
	pizza_toppings p1 
    INNER JOIN pizza_toppings p2
ON
	p1.topping_name < p2.topping_name
    INNER JOIN pizza_toppings p3
ON 
	p2.topping_name < p3.topping_name
ORDER BY 
	total_cost DESC, pizza;
######################################################################################################################################
CREATE TABLE IF NOT EXISTS callers(
		policy_holder_id integer,
		case_id varchar(100),
		call_category varchar(100),
		call_received timestamp,
		call_duration_secs integer,
		original_order integer
);

-- Insert values into the "callers" table
INSERT INTO callers (policy_holder_id, case_id, call_category, call_received, call_duration_secs, original_order) VALUES
    (50986511, 'b274-c8f0-4d5c-8704', NULL, '2022-01-28T09:46:00', 252, 456),
    (54026568, '405a-b9be-45c2-b311', NULL, '2022-01-29T16:19:00', 397, 217),
    (54026568, 'c4cc-fd40-4780-8a53', 'benefits', '2022-01-30T08:18:00', 320, 134),
    (54026568, '81e8-6abf-425b-add2', NULL, '2022-02-20T17:26:00', 1324, 83),
	(54475101, '5919-b9c2-49a5-8091', NULL, '2022-02-24T18:07:00', 206, 498),
    (54624612, 'a17f-a415-4727-9a3f', 'benefits', '2022-02-27T10:56:00', 435, 19),
    (53777383, 'dfa9-e5a7-4a9b-a756', 'benefits', '2022-03-19T00:10:00', 318, 69),
    (52880317, 'cf00-56c4-4e76-963a', 'claims', '2022-03-21T01:12:00', 340, 254),
    (52680969, '0c3c-7b87-489a-9857', NULL, '2022-03-21T14:00:00', 310, 213),
    (54574775, 'ca73-bf99-46b2-a79b', 'billing', '2022-04-18T14:09:00', 181, 312),
    (51435044, '6546-61b4-4a05-9a5e', NULL, '2022-04-18T21:58:00', 354, 439),
    (52780643, 'e35a-a7c2-4718-a65d', 'billing', '2022-05-06T14:31:00', 318, 186),
    (54026568, '61ac-eee7-42fa-a674', NULL, '2022-05-07T01:27:00', 404, 341),
    (54674449, '3d9d-e6e2-49d5-a1a0', 'billing', '2022-05-09T11:00:00', 107, 450),
    (54026568, 'c516-0063-4b8f-aa74', NULL, '2022-05-13T01:06:00', 404, 270);
    
SELECT * FROM callers;

-- Write a query to get the patients who made a call within 7 days of their previous call. If a patient
-- called more than twice in a span of 7 days, count them as once.





















