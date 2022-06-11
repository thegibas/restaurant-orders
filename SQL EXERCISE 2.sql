-- EXPLORATORY ANALYSIS ON RESTAURANT ORDERS FROM KAGGLE

SELECT * FROM project_restaurant.orders

-- 1 What are the top 10 restaurants that have received the most orders
with a as (
select r.RestaurantID,r.RestaurantName,`Order Amount` 
from orders as o
inner join restaurants as r 
on o.`Restaurant ID` = r.RestaurantID
)
select RestaurantID,RestaurantName,sum(`Order Amount`) as Total_orders
from a
group by RestaurantName
order by Total_orders desc
limit 10

-- 2 What's the percentage of payment method for each transaction in the distribution
with asd as(
select count(*) as`Frequency` ,`Payment Mode`
from orders 
group by `Payment Mode`
order by `Frequency`desc)
select *, concat(round((`Frequency`/500)*100,2),"%") as percentage
from asd
group by `Payment Mode`
order by `Frequency`desc

-- 3 what's the percentage of restaurant for each type of cuisine in the distribution
with fgh as (
select Cuisine,count(*) as `N° of restaurant`
from restaurants
group by Cuisine
order by `N° of restaurant`
)
select * , concat(round((`N° of restaurant`/20)*100,0),"%") as percentage
from fgh
group by Cuisine
order by `N° of restaurant` desc

-- 4 Who are the best customers for each cuisine type
with jkl as (
select o.`Customer Name`,o.`Order Amount`,r.Cuisine
from orders as o
inner join restaurants as r 
on o.`Restaurant ID`= r.RestaurantID
)
select `Customer Name`,max(`Order Amount`) as N°_orders, Cuisine
from jkl
group by Cuisine
order by `Order Amount`desc

-- 5 What are the top 5 slowest restaurants to deliver their food on average
with sdf as (
select o.`Delivery Time Taken (mins)`, r.RestaurantName
from orders as o
inner join restaurants as r
on o.`Restaurant ID` = r.RestaurantID
)
select avg(`Delivery Time Taken (mins)`) as Total_delivery_time, RestaurantName 
from sdf
group by RestaurantName
order by Total_delivery_time  desc
limit 5;

-- 6 What's the average customer rating food for each restaurant
with kl as (
select o.`Customer Rating-Food`, r.RestaurantName
from orders as o
inner join restaurants as r
on o.`Restaurant ID` = r.RestaurantID
)
select round(avg(`Customer Rating-Food`),1) as Average_rating, RestaurantName
from kl
group by RestaurantName
order by Average_rating desc

-- 7 What's the total order for each customer and payment method
select `Customer Name`, sum(`Order Amount`) as Total_orders, `Payment Mode`
from orders
group by `Customer Name`,`Payment Mode`
order by Total_orders desc


