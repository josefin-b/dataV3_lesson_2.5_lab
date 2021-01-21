-- Lab 2.5
use sakila;
show tables;

-- 1 Select all the actors with the first name ‘Scarlett’.
select * from actor
where first_name = 'Scarlett';

-- 2 How many films (movies) are available for rent and how many films have been rented?
select count(distinct film_id) as 'films_available_for_rent' from film; 
select count(distinct rental_id) as 'total_films_rented' from rental;

-- 3 What are the shortest and longest movie duration? Name the values max_duration and min_duration.
select min(length) as 'min_duration', max(length) as 'max_duration' from film;

-- 4 What's the average movie duration expressed in format (hours, minutes)?
select floor(avg(length) / 60) as hours, round(avg(length) % 60) as minutes from film;

-- 5 How many distinct (different) actors' last names are there?
select count(distinct last_name) from actor;

-- 6 Since how many days has the company been operating (check DATEDIFF() function)?
select min(rental_date), max(rental_date) from rental;
select datediff('2006-02-14 15:16:03', '2005-05-24 22:53:30') as days_operating;

#select datediff(min(rental_date), max(rental_date)) as days_operating from rental;

-- 7 Show rental info with additional columns month and weekday. Get 20 results.
select *, date_format(rental_date, '%M') as month, dayname(rental_date) as weekday from rental
limit 20;

-- 8 Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
alter table rental
add column day_type varchar(20) after last_update;

select *,
case 
	when dayname(rental_date) in ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday') then 'Workday'
    when dayname(rental_date) in ('Saturday', 'Sunday') then 'Weekend'
    
end as day_type
from rental;

-- 9 How many rentals were in the last month of activity?
select date(max(rental_date)) - interval 30 day, date(max(rental_date))
from rental;
select count(rental_id) from rental
where date(rental_date) between date("2006-01-15") and date("2006-02-14"); #182

