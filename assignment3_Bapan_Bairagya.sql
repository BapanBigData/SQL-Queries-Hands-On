use todo_db;

create table if not exists products(
      product_id int,
      product_name varchar(50),
      unit_price int,
      primary key (product_id));

create table if not exists sales(
	  seller_id int,
      product_id int,
      buyer_id int,
      sale_date date,
      quantity int,
      price int,
      constraint fk foreign key (product_id) references products (product_id));


insert into products values (1, 'S8', 1000), (2, 'G4', 800), (3, 'iPhone', 1400);

insert into sales values (1, 1, 1, '2019-01-21', 2, 2000), (1, 2, 2, '2019-02-17', 1, 800), (2, 2, 3, '2019-06-02', 1, 800), 
						 (3, 3, 4, '2019-05-13', 2, 2800);

select * from products;
select * from sales;

-- Write an SQL query that reports the products that were only sold in the first quarter of 2019. That is,
-- between 2019-01-01 and 2019-03-31 inclusive.
select p.product_id, p.product_name
from sales s inner join products p
on s.product_id = p.product_id
where s.sale_date between '2019-01-01' and '2019-03-31'
      and p.product_id not in ( select distinct product_id from sales where sale_date not between '2019-01-01' and '2019-03-31');

-- optimal query
select p.product_id, p.product_name from(
select s.*
from sales s where s.sale_date between '2019-01-01' and '2019-03-31')temp inner join products p
on temp.product_id = p.product_id
where p.product_id not in (select distinct product_id from sales where sale_date not between '2019-01-01' and '2019-03-31');

################################################################################################################################################################
create table if not exists views(
				article_id int,
                author_id int,
                viewer_id int,
                view_date date);

insert into views values (1, 3, 5, '2019-08-01'), (1, 3, 6, '2019-08-02'), (2, 7, 7, '2019-08-01'), (2, 7, 6, '2019-08-02'),
						 (4, 7, 1, '2019-07-22'), (3, 4, 4, '2019-07-21'), (3, 4, 4, '2019-07-21');

select * from views;

-- Write an SQL query to find all the authors that viewed at least one of their own articles.
-- Return the result table sorted by id in ascending order.

select distinct v.author_id
from views v
where v.author_id = v.viewer_id
order by v.author_id asc;

######################################################################################################################################
create table if not exists delivery(
                delivery_id int,
                customer_id int,
                order_date date,
                customer_pref_delivery_date date,
                constraint pk primary key (delivery_id));

insert into delivery values (1, 1, '2019-08-01', '2019-08-02'), (2, 5, '2019-08-02', '2019-08-02'), (3, 1, '2019-08-11', '2019-08-11'),
						    (4, 3, '2019-08-24', '2019-08-26'), (5, 4, '2019-08-21', '2019-08-22'), (6, 2, '2019-08-11', '2019-08-13');
                            
select * from delivery;

-- If the customer's preferred delivery date is the same as the order date, then the order is called
-- immediately; otherwise, it is called scheduled.
-- Write an SQL query to find the percentage of immediate orders in the table, rounded to 2 decimal
-- places.
select
round(count( case when date_diff = 0 then 1 end ) / count(*)*100, 2) as immediate_percentage
from(
select *, datediff(customer_pref_delivery_date, order_date) as date_diff from delivery)t;

##########################################################################################################################################################
create table if not exists ads (
    ad_id int,
    user_id int,
    action enum('Clicked', 'Viewed', 'Ignored'),
    primary key (ad_id, user_id)
);

insert into ads values (1, 1, 'Clicked'), (2, 2, 'Clicked'), (3, 3,'Viewed'), (5, 5, 'Ignored'), (1, 7, 'Ignored'), (2, 7, 'Viewed'), (3, 5, 'Clicked'),
                       (1, 4, 'Viewed'), (2, 11, 'Viewed'), (1, 2, 'Clicked');

select * from ads;

-- Write an SQL query to find the ctr of each Ad. Round ctr to two decimal points.
-- Return the result table ordered by ctr in descending order and by ad_id in ascending order in case of a
-- tie.

select ad_id,
round(
      ifnull(
      nullif( sum( case when action='Clicked' then count end ), 0 ) / nullif( sum( case when action in ('Clicked', 'Viewed') then count end), 0 ), 
             0)*100, 
	  2) as ctr
from(
select ad_id, action, count(*) as count
from ads
group by ad_id, action)t
group by ad_id
order by ctr desc, ad_id asc;

####################################################################################################################################
create table if not exists employee(
          employee_id int,
          team_id int,
          constraint pk primary key (employee_id));

insert into employee values (1, 8), (2, 8), (3, 8), (4, 7), (5, 9), (6, 9);

select * from employee;

-- Write an SQL query to find the team size of each of the employees.
-- Return result table in any order.

select e2.employee_id, e2.team_id, count(*) as team_size
from employee e1 inner join employee e2
on e1.team_id = e2.team_id
group by e2.employee_id, e2.team_id;

###########################################################################################################################################
create table if not exists countries(
			country_id int,
			country_name varchar(20),
            constraint pk primary key (country_id));

create table if not exists weather(
            country_id int,
            weather_state int,
            day date,
            primary key (country_id, day));

insert into countries values (2, 'USA'), (3, 'Australia'), (7, 'Peru'), (5, 'China'), (8, 'Morocco'), (9, 'Spain');

insert into weather values (2, 15, '2019-11-01'), (2, 12, '2019-10-28');

INSERT INTO weather (country_id, weather_state, day) VALUES
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

select * from countries;
select * from weather;

-- Write an SQL query to find the type of weather in each country for November 2019.

select country_name,
case
when avg_weather <= 15.0 then 'Cold'
when avg_weather >= 25.0 then 'Hot'
else 'Worm'
end as weather_type
from(
select country_name, avg(weather_state) as avg_weather
from(
select c.*, w.weather_state, w.day
from countries c inner join (select * from weather where year(day)=2019 and month(day)=11) w
on c.country_id = w.country_id)t
group by country_name)tt;

###############################################################################################################################################
create table if not exists prices(
			product_id int,
            start_date date,
            end_date date,
            price int,
            primary key (product_id, start_date, end_date));

create table if not exists units_sold(
            product_id int,
            purchase_date date,
            units int);

INSERT INTO prices (product_id, start_date, end_date, price)
VALUES
    (1, '2019-02-17', '2019-02-28', 5),
    (1, '2019-03-01', '2019-03-22', 20),
    (2, '2019-02-01', '2019-02-20', 15),
    (2, '2019-02-21', '2019-03-31', 30);


INSERT INTO units_sold (product_id, purchase_date, units)
VALUES
    (1, '2019-02-25', 100),
    (1, '2019-03-01', 15),
    (2, '2019-02-10', 200),
    (2, '2019-03-22', 30);

select * from prices;
select * from units_sold;

alter table units_sold rename column purchase_date to sold_date;

-- Write an SQL query to find the average selling price for each product. average_price should be
-- rounded to 2 decimal places.
select product_id, round(sum(priceXunits) / sum(units), 2) as average_price from(
select p.*, u.sold_date, u.units, p.price*u.units as priceXunits
from prices p inner join units_sold u 
on p.product_id = u.product_id
and u.sold_date between p.start_date and p.end_date)t
group by product_id;

########################################################################################################################################
create table if not exists activity(
			player_id int,
            device_id int,
            event_date date,
            games_played int,
            primary key (player_id, event_date));

INSERT INTO activity (player_id, device_id, event_date, games_played)
VALUES
    (1, 2, '2016-03-01', 5),
    (1, 2, '2016-05-02', 6),
    (2, 3, '2017-06-25', 1),
    (3, 1, '2016-03-02', 0),
    (3, 4, '2018-07-03', 5);

select * from activity;

-- Write an SQL query to report the first login date for each player.
-- Return the result table in any order.
select player_id, event_date as first_login from(
select *,
row_number() over(partition by player_id order by event_date asc) as row_num
from activity)t
where row_num = 1;

-- Write an SQL query to report the device that is first logged in for each player.
-- Return the result table in any order.
select player_id, device_id from(
select *,
row_number() over(partition by player_id order by event_date asc) as row_num
from activity)t
where row_num = 1;

####################################################################################################################
create table if not exists products26 (
			product_id int,
            product_name varchar(50),
            product_category varchar(40),
            primary key (product_id));

create table if not exists orders26(
            product_id int,
            order_date date,
            unit int,
            constraint fk_product_id_products26 foreign key (product_id) references products26 (product_id));
            
INSERT INTO products26 (product_id, product_name, product_category) VALUES
    (1, 'Leetcode Solutions', 'Book'),
    (2, 'Jewels of Stringology', 'Book'),
    (3, 'HP', 'Laptop'),
    (4, 'Lenovo', 'Laptop'),
    (5, 'Leetcode Kit', 'T-shirt');

INSERT INTO orders26 (product_id, order_date, unit) VALUES
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


select * from products26;
select * from orders26;

-- Write an SQL query to get the names of products that have at least 100 units ordered in February 2020
-- and their amount.
-- Return result table in any order.
select product_name, sum(unit) as amount from(
select o.*, p.product_name 
from products26 p inner join (select * from orders26 where year(order_date)=2020 and month(order_date)=2) o
on p.product_id = o.product_id)t
group by product_name
having sum(unit) >= 100;

#############################################################################################################################################
create table if not exists users(
			user_id int,
            name varchar(30),
            mail varchar(50),
            primary key (user_id));

INSERT INTO users (user_id, name, mail) VALUES
    (1, 'Winston', 'winston@leetcode.com'),
    (2, 'Jonathan', 'jonathanisgreat'),
    (3, 'Annabelle', 'bella-@leetcode.com'),
    (4, 'Sally', 'sally.come@leetcode.com'),
    (5, 'Marwan', 'quarz#2020@leetcode.com'),
    (6, 'David', 'david69@gmail.com'),
    (7, 'Shapiro', '.shapo@leetcode.com');

select * from users;

-- Write an SQL query to find the users who have valid emails.
############################################################################################################################
create table if not exists customers28(
             customer_id int,
             name varchar(30),
             country varchar(25),
             primary key(customer_id));

create table if not exists products28(
             product_id int,
             description varchar(100),
             price int,
             primary key (product_id));

create table if not exists orders28(
             order_id int,
             customer_id int,
             product_id int,
             order_date date,
             quantity int,
             primary key (order_id));

INSERT INTO customers28 (customer_id, name, country) VALUES
    (1, 'Winston', 'USA'),
    (2, 'Jonathan', 'Peru'),
    (3, 'Moustafa', 'Egypt');

INSERT INTO products28 (product_id, description, price) VALUES
    (10, 'LC Phone', 300),
    (20, 'LC T-Shirt', 10),
    (30, 'LC Book', 45),
    (40, 'LC Keychain', 2);

INSERT INTO orders28 (order_id, customer_id, product_id, order_date, quantity) VALUES
    (1, 1, 10, '2020-06-10', 1),
    (2, 1, 20, '2020-07-01', 1),
    (3, 1, 30, '2020-07-08', 2),
    (4, 2, 10, '2020-06-15', 2),
    (5, 2, 40, '2020-07-01', 10),
    (6, 3, 20, '2020-06-24', 2),
    (7, 3, 30, '2020-06-25', 2),
    (9, 3, 30, '2020-05-08', 3);

select * from customers28;
select * from products28;
select * from orders28;

-- Write an SQL query to report the customer_id and customer_name of customers who have spent at
-- least $100 in each month of June and July 2020.

select customer_id, name
from(
select month(order_date) as month, customer_id, name, sum(quantityXprice) as total_spent
from(
select o.order_date, o.customer_id, c.name, p.price, o.quantity*p.price as quantityXprice
from customers28 c inner join (select * from orders28 where year(order_date)=2020 and month(order_date) in (6, 7)) o
on c.customer_id = o.customer_id
inner join products28 p
on p.product_id = o.product_id) t
group by month(order_date), customer_id, name
having sum(quantityXprice) >= 100) tt
group by customer_id, name
having count(*) = 2;
############################################################################################################################################
create table if not exists tv_programs(
		program_date datetime,
        content_id int,
        channel varchar(30),
        primary key (program_date, content_id));

create table if not exists contents(
		content_id int,
        title varchar(30),
        Kids_content enum ('Y', 'N'),
        content_type varchar(20),
        primary key (content_id));

INSERT INTO tv_programs (program_date, content_id, channel) VALUES
    ('2020-06-10 08:00', 1, 'LC-Channel'),
    ('2020-05-11 12:00', 2, 'LC-Channel'),
    ('2020-05-12 12:00', 3, 'LC-Channel'),
    ('2020-05-13 14:00', 4, 'Disney Ch'),
    ('2020-06-18 14:00', 4, 'Disney Ch'),
    ('2020-07-15 16:00', 5, 'Disney Ch');

INSERT INTO contents (content_id, title, Kids_content, content_type) VALUES
    (1, 'Leetcode Movie', 'N', 'Movies'),
    (2, 'Alg. for Kids', 'Y', 'Series'),
    (3, 'Database Sols', 'N', 'Series'),
    (4, 'Aladdin', 'Y', 'Movies'),
    (5, 'Cinderella', 'Y', 'Movies');

select * from tv_programs;
select * from contents;

-- Write an SQL query to report the distinct titles of the kid-friendly movies streamed in June 2020.
-- Return the result table in any order.
SELECT DISTINCT c.title
FROM contents c INNER JOIN (SELECT * FROM tv_programs WHERE YEAR(program_date)=2020 AND MONTH(program_date)=6) tv
ON c.content_id = tv.content_id
WHERE c.Kids_content = 'Y';
#######################################################################################################################################################
create table if not exists npv(
			id int,
            year int,
            npv int,
            primary key (id, year));

create table if not exists queries(
            id int,
            year int,
            primary key (id, year));

INSERT INTO npv (id, year, npv) VALUES
    (1, 2018, 100),
    (7, 2020, 30),
    (13, 2019, 40),
    (1, 2019, 113),
    (2, 2008, 121),
    (3, 2009, 12),
    (11, 2020, 99),
    (7, 2019, 0);

INSERT INTO queries (id, year) VALUES
    (1, 2019),
    (2, 2008),
    (3, 2009),
    (7, 2018),
    (7, 2019),
    (7, 2020),
    (13, 2019);

select * from npv;
select * from queries;

-- Write an SQL query to find the npv of each query of the Queries table.
-- Return the result table in any order.
SELECT q.id, q.year, ifnull(np.npv, 0) as npv
FROM queries q LEFT JOIN npv np
ON q.id = np.id AND q.year = np.year;
##########################################################################################################################################
create table if not exists employees32(
             id int,
			 name varchar(50),
             primary key (id));

create table if not exists employees_UNI32(
             id int,
             unique_id int,
             primary key (id, unique_id));

INSERT INTO employees32 (id, name) VALUES
    (1, 'Alice'),
    (7, 'Bob'),
    (11, 'Meir'),
    (90, 'Winston'),
    (3, 'Jonathan');

INSERT INTO employees_UNI32 (id, unique_id) VALUES
    (3, 1),
    (11, 2),
    (90, 3);

select * from employees32;
select * from employees_UNI32;

-- Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just
-- show null.
-- Return the result table in any order.
SELECT uni.unique_id, e.name
FROM employees32 e LEFT JOIN employees_UNI32 uni
ON e.id = uni.id;
###############################################################################################################################
create table if not exists users33(
             id int,
			 name varchar(50),
             primary key (id));

create table if not exists rides33(
			id int,
			user_id int,
			distance int,
            primary key (id));

INSERT INTO users33 (id, name) VALUES
    (1, 'Alice'),
    (2, 'Bob'),
    (3, 'Alex'),
    (4, 'Donald'),
    (7, 'Lee'),
    (13, 'Jonathan'),
    (19, 'Elvis');

INSERT INTO rides33 (id, user_id, distance) VALUES
    (1, 1, 120),
    (2, 2, 317),
    (3, 3, 222),
    (4, 7, 100),
    (5, 13, 312),
    (6, 19, 50),
    (7, 7, 120),
    (8, 19, 400),
    (9, 7, 230);

select * from users33;
select * from rides33;

-- Write an SQL query to report the distance travelled by each user.
-- Return the result table ordered by travelled_distance in descending order, if two or more users
-- travelled the same distance, order them by their name in ascending order.

SELECT u.name, ifnull(r.total_distance_travelled, 0) as travelled_distance
FROM users33 u LEFT JOIN (SELECT user_id, sum(distance) as total_distance_travelled
						FROM rides33 
                        group by user_id) r
ON u.id = r.user_id
ORDER BY r.total_distance_travelled DESC, u.name ASC;

###########################################################################################################################
create table if not exists movies35(
			 movie_id int,
			 title varchar(30),
             primary key (movie_id));

create table if not exists users35(
             user_id int,
			 name varchar(50),
             primary key (user_id));

create table if not exists movie_ratings35(
             movie_id int,
		     user_id int,
		     rating int,
		     created_at date,
             primary key (movie_id, user_id));

INSERT INTO movies35 (movie_id, title) VALUES
    (1, 'Avengers'),
    (2, 'Frozen 2'),
    (3, 'Joker');

INSERT INTO users35 (user_id, name) VALUES
    (1, 'Daniel'),
    (2, 'Monica'),
    (3, 'Maria'),
    (4, 'James');

INSERT INTO movie_ratings35 (movie_id, user_id, rating, created_at) VALUES
    (1, 1, 3, '2020-01-12'),
    (1, 2, 4, '2020-02-11'),
    (1, 3, 2, '2020-02-12'),
    (1, 4, 1, '2020-01-01'),
    (2, 1, 5, '2020-02-17'),
    (2, 2, 2, '2020-02-01'),
    (2, 3, 2, '2020-03-01'),
    (3, 1, 3, '2020-02-22'),
    (3, 2, 4, '2020-02-25');

select * from movies35;
select * from users35;
select * from movie_ratings35;

-- Write an SQL query to:

-- ● Find the name of the user who has rated the greatest number of movies. In case of a tie,
-- return the lexicographically smaller user name.
-- ● Find the movie name with the highest average rating in February 2020. In case of a tie, return
-- the lexicographically smaller movie name.

WITH user_rated_greatest_number_of_movies AS (
SELECT u.name, count(*) AS nums_of_movie_rated
FROM users35 u LEFT JOIN movie_ratings35 mr
ON u.user_id = mr.user_id
GROUP BY u.name),

february_ratings AS(
SELECT m.title, AVG(mr.rating) AS avg_ratings
FROM movies35 m LEFT JOIN (SELECT * FROM movie_ratings35 WHERE YEAR(created_at)=2020 AND MONTH(created_at)=2) mr
ON m.movie_id = mr.movie_id
GROUP BY m.title)

SELECT results 
FROM (

(SELECT name AS results
FROM user_rated_greatest_number_of_movies
WHERE nums_of_movie_rated = (SELECT MAX(nums_of_movie_rated) FROM user_rated_greatest_number_of_movies)
ORDER BY name ASC
LIMIT 1)
                                      UNION 
(SELECT title AS results
FROM february_ratings
WHERE avg_ratings = (SELECT MAX(avg_ratings) FROM february_ratings)
ORDER BY title ASC
LIMIT 1)

) AS combined_results;