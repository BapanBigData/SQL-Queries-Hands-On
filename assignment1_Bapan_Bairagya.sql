use todo_db;

-- assignment 1

-- Query all columns for all American cities in the CITY table with populations larger than 100000.
select * from city
where country_code = 'USA' and population > 100000;

-- Query the NAME field for all American cities in the CITY table with populations larger than 120000.
select name from city
where country_code = 'USA' and population > 120000;

-- Query all columns (attributes) for every row in the CITY table.
select * from city;

-- Query all columns for a city in CITY with the ID 1661.
select * from city 
where id = 1661;

-- Query all attributes of every Japanese city in the CITY table.
select * from city
where country_code = 'JPN';

-- Query the names of all the Japanese cities in the CITY table.
select name from city
where country_code = 'JPN';

-- Query a list of CITY and STATE from the STATION table.
select city, state from station;
