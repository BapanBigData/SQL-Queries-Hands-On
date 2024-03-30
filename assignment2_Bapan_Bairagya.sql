use todo_db;

-- assignment 2

-- Query a list of CITY names from STATION for cities that have an even ID number. Print the results
-- in any order, but exclude duplicates from the answer.
select distinct(city) from station
where id % 2 = 0;

-- Find the difference between the total number of CITY entries in the table and the number of
-- distinct CITY entries in the table.
select count(1) - count( distinct(city) ) as difference from station;

-- Query the two cities in STATION with the shortest and longest CITY names, as well as their
-- respective lengths (i.e.: number of characters in the name). If there is more than one smallest or
-- largest city, choose the one that comes first when ordered alphabetically.

## The below query giving me error: 'union all' invalid placed
## in such case we need to use CTEs or subqueries with JOIN
-- select city, length(city) as city_length from station
-- where length(city) = (select min(length(city)) from station)
-- order by length(city), city limit 1
-- union all
-- select city, length(city) as city_length from station
-- where length(city) = (select max(length(city)) from station)
-- order by length(city), city limit 1;

select city, length(city) as city_length from station
where length(city) = (select min(length(city)) from station)
order by length(city), city limit 1;
-- union all
select city, length(city) as city_length from station
where length(city) = (select max(length(city)) from station)
order by length(city), city limit 1;

-- Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result
-- cannot contain duplicates.
## indexing starts from 1 and last index is included
select distinct(city) from station
where substring(city, 1, 1) in ('a', 'e', 'i', 'o', 'u');

-- Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot
-- contain duplicates.
select distinct(city) from station
where substring(city, length(city), length(city)) in ('a', 'e', 'i', 'o', 'u');

-- Query the list of CITY names from STATION that do not start with vowels. Your result cannot
-- contain duplicates.
select distinct(city) from station
where substring(city, 1, 1) not in ('a', 'e', 'i', 'o', 'u');

-- Query the list of CITY names from STATION that do not end with vowels. Your result cannot
-- contain duplicates.
select distinct(city) from station
where substring(city, length(city), length(city)) not in ('a', 'e', 'i', 'o', 'u');

-- Query the list of CITY names from STATION that either do not start with vowels or do not end
-- with vowels. Your result cannot contain duplicates.
select distinct(city) from station
where substring(city, 1, 1) not in ('a', 'e', 'i', 'o', 'u')
      or
      substring(city, length(city), length(city)) not in ('a', 'e', 'i', 'o', 'u');
      
-- Query the list of CITY names from STATION that do not start with vowels and do not end with
-- vowels. Your result cannot contain duplicates.
select distinct(city) from station
where substring(city, 1, 1) not in ('a', 'e', 'i', 'o', 'u')
      and
      substring(city, length(city), length(city)) not in ('a', 'e', 'i', 'o', 'u');