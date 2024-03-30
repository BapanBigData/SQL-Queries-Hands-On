-- variables

-- first approach
SET @name = "I'm Bapan";
SELECT @name; 

-- second approach
SELECT @msg := "Hello, World!"; 
SELECT @msg;
#######################################################################################################################################################
USE my_retail_db;

SHOW tables;
SELECT * FROM products;

SET @avg_price = (
	SELECT
		ROUND(AVG(product_price), 4)
	FROM products
    WHERE product_category_id % 2 = 0
);

SELECT @avg_price AS avg_price;

-- more experiment
SET @x = 2;
SELECT @x := @x + 2 AS col;
SELECT @y := @x  / 10 AS y;
################################################################################################################################
-- functions
SELECT NOW();
SELECT DATE_ADD(NOW(), INTERVAL 20 DAY) AS next20;