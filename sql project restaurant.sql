Create table Orders (
order_id VARCHAR(20),
customer_id INTEGER,
restaurant_id INTEGER,
order_datetime TIMESTAMP,
dish_name VARCHAR(100),
category VARCHAR(50),
quantity INTEGER,
unit_price_inr NUMERIC(10,2),
gross_amount_inr NUMERIC(12,2),
discount_pct NUMERIC(5,2),
discount_amount_inr NUMERIC(12,2),
delivery_fee_inr NUMERIC(10,2),
net_revenue_inr NUMERIC(12,2),
payment_method VARCHAR(20),
order_status VARCHAR(20),
delivery_minutes INTEGER,
customer_rating NUMERIC(2,1)
)


create table Restaurants (
restaurant_id INTEGER,
restaurant_name VARCHAR(100),
state VARCHAR(50),
city VARCHAR(50),
cuisine VARCHAR(50),
price_band VARCHAR(50),
opening_year INTEGER,
seating_capacity INTEGER,
is_active VARCHAR(10)
);

SELECT * FROM Restaurants
limit 10;

SELECT *
FROM orders
LIMIT 10;

select order_id, customer_id, order_datetime from orders;

select distinct category from orders;

select distinct city from restaurants;

Select restaurant_name, opening_year from Restaurants
ORDER BY opening_year DESC;

Select * from orders
ORDER BY net_revenue_inr DESC;

Select * from orders
WHERE order_status = 'Delivered';

Select * from restaurants
WHERE is_active = 'Yes';

SELECT * FROM Orders
WHERE customer_rating >= 4.5
ORDER BY customer_rating DESC;

SELECT * FROM Orders
WHERE delivery_minutes BETWEEN 30 AND 45;
--Second_way
SELECT * FROM Orders
WHERE delivery_minutes >=30 AND delivery_minutes<=45;

SELECT * FROM orders
WHERE payment_method IN ('Card','UPI')
--Second_way
SELECT * FROM orders
WHERE payment_method = 'Card' or payment_method =  'UPI';

SELECT * FROM orders
WHERE dish_name ILIKE '%Chicken%';

SELECT * from orders
WHERE customer_rating IS NULL;

SELECT COUNT(*) AS TOTAL_rows from orders;

SELECT COUNT( distinct customer_id) AS unique_customers from orders;

SELECT SUM(net_revenue_inr) AS Total_Revenue  FROM orders;

SELECT ROUND(AVG(customer_rating),2) AS average_rating FROM orders;

SELECT MAX(unit_price_inr), MIN(unit_price_inr) FROM orders

--Wrong mine
SELECT DISTINCT COUNT(order_status) AS count_order FROM orders
--Solution
SELECT order_status, COUNT(*) AS orders FROM orders
GROUP BY order_status
ORDER BY orders DESC;

--Mine correct
SELECT DISTINCT(payment_method), SUM(net_revenue_inr) AS total_revenue FROM orders
GROUP BY payment_method
ORDER BY total_revenue DESC;
--Solution
SELECT payment_method, SUM(net_revenue_inr) AS revenue FROM orders
GROUP BY payment_method
ORDER BY revenue DESC;

SELECT category, ROUND(AVG(delivery_minutes),2) AS AVG_delivery_minutes FROM orders
GROUP BY category
ORDER BY AVG_delivery_minutes ASC;

SELECT order_status, COUNT(*) AS orders FROM orders
GROUP BY order_status
ORDER BY orders DESC;

Select dish_name, SUM(quantity) AS total_quantity from orders
GROUP BY dish_name
ORDER BY total_quantity DESC;

--25. Βρες categories με πάνω από 100 orders.
SELECT category, count(*) AS orders from orders
GROUP BY category
HAVING COUNT(*) > 100
ORDER BY orders DESC

--26. Βρες restaurant IDs με avg rating >= 4 και τουλάχιστον 10 ratings.
SELECT restaurant_id, ROUND(AVG(customer_rating),2) AS avg_rating, COUNT(customer_rating) AS count_ratings FROM orders
GROUP BY restaurant_id
HAVING AVG(customer_rating) >= 4 AND COUNT(customer_rating) >= 10
ORDER BY avg_rating DESC

--27. Χώρισε orders σε Low (<300), Medium (<800), High revenue.
--MINE WRONG
select order_id, net_revenue_inr from orders
WHERE net_revenue_inr <300 AS LOW AND net_revenue_inr <800 AS MEDIUM AND net_revenue_inr >=800 AS HIGH REVENUE
GROUP BY order_id
ORDER BY net_revenue_inr DESC;
--CORRECT
SELECT order_id, net_revenue_inr,
CASE WHEN net_revenue_inr<300 THEN 'Low'
WHEN net_revenue_inr<800 THEN 'Medium'
ELSE 'High' END AS revenue_band
FROM orders
ORDER BY net_revenue_inr ASC;

--28. Μέτρησε Delivered και Cancelled σε ξεχωριστές στήλες.
--MINE WRONG
SELECT order_status,COUNT(order_status) AS status FROM orders
GROUP BY order_Status
IF order_status 'Delivered' AS Delivered
AND IF 'Cancelled' AS Cancelled;
--CORRECT
SELECT SUM(CASE WHEN order_status='Delivered' THEN 1 ELSE 0 END) AS delivered,
SUM(CASE WHEN order_status='Cancelled' THEN 1 ELSE 0 END) AS cancelled FROM orders;

--29. Μέτρησε orders ανά μήνα.
SELECT DATE_TRUNC('month',order_datetime)::date AS month,
COUNT(*) AS orders FROM orders
GROUP BY DATE_TRUNC('month',order_datetime)
ORDER BY month;
--SECOND WAY
SELECT DATE_TRUNC('month',order_datetime)::date AS month,
COUNT(*) AS orders FROM orders
GROUP BY 1
ORDER BY 1;

--30. Υπολόγισε delivered revenue ανά μήνα.
SELECT DATE_TRUNC('month', order_datetime)::date AS month, SUM(net_revenue_inr) AS Total_Delivered_Revenue FROM Orders
WHERE order_status='Delivered'
GROUP BY month
ORDER BY month ASC;

--31. Εμφάνισε order_id, restaurant_name, city και revenue.
--Mine Wrong
Select order_id, restaurant_name, city, revenue from orders
JOIN restaurants
restaurants.restaurant_id = orders.restaurants_id
--Correct
SELECT o.order_id, r.restaurant_name, r.city, o.net_revenue_inr FROM orders o
JOIN restaurants r
ON o.restaurant_id=r.restaurant_id;

--32. Υπολόγισε revenue ανά restaurant.
--Να τσεκαρω γιατι χρειαζεται το restaurant id?? Γιατί έχει διαφορετικά μαγαζία με ίδιο όνομα
SELECT r.restaurant_id, r.restaurant_name, SUM(o.net_revenue_inr) AS revenue from orders o
JOIN restaurants r
ON r.restaurant_id=o.restaurant_id
GROUP BY r.restaurant_name, r.restaurant_id
ORDER BY revenue DESC;

--33. Υπολόγισε revenue ανά city.
SELECT r.city, SUM(o.net_revenue_inr) AS revenue FROM orders o
JOIN restaurants r
ON r.restaurant_id=o.restaurant_id
GROUP BY r.city
ORDER BY revenue DESC;

--34. Βρες restaurants χωρίς orders.
SELECT r.* FROM restaurants r
LEFT JOIN orders o
ON r.restaurant_id=o.restaurant_id
WHERE order_id IS NULL

--35. Βρες duplicated order IDs.
SELECT order_id, COUNT(*) AS dublicates FROM orders O
GROUP BY order_id
HAVING COUNT(*)> 1

--36. Υπολόγισε overall cancellation rate.
SELECT ROUND(100.0*SUM(CASE WHEN order_status='Cancelled' THEN 1 ELSE 0 END)/COUNT(*),2) AS cancellation_rate_pct FROM orders;
--Μαθηματικά: Cancellation Rate = Cancelled Orders / Total Orders × 100 π.χ. 25 cancelled / 200 total × 100 = 12.50%

--37. Υπολόγισε cancellation rate ανά city.
SELECT r.city, COUNT(*) AS orders, ROUND(100.0*SUM(CASE WHEN o.order_status='Cancelled' THEN 1 ELSE 0 END)/COUNT(*),2) AS cancellation_rate_pct FROM orders o
JOIN restaurants r
ON o.restaurant_id=r.restaurant_id
GROUP BY r.city
ORDER BY cancellation_rate_pct DESC;

--38. Βρες orders με revenue πάνω από τον συνολικό μέσο όρο.
--mine wrong
SELECT order_id, ROUND(100.0*net_revenue_inr/sum(net_revenue_inr),2) AS avg_revenue FROM orders
GROUP BY order_id
HAVING net_revenue_inr>ROUND(100.0*net_revenue_inr/sum(net_revenue_inr),2)
--mine wrong 2
SELECT order_id, AVG(net_revenue_inr) AS avg_rev FROM orders 
WHERE net_revenue_inr>AVG(net_revenue_inr)
GROUP by order_id
ORDER BY 
--correct
SELECT * FROM orders
WHERE net_revenue_inr>(
	SELECT AVG(net_revenue_inr) FROM orders)
ORDER BY net_revenue_inr DESC;


select * from orders;
select * from Restaurants;

--39. Βρες restaurants με revenue πάνω από το average restaurant revenue.
--mine wrong
SELECT r.restaurant_name, r.restaurant_id, SUM(o.net_revenue_inr) AS revenue_restaurant FROM restaurants r
JOIN orders o
ON r.restaurant_id=o.restaurant_id
WHERE net_revenue_inr>(
	SELECT AVG(net_revenue_inr) FROM orders o)
GROUP BY restaurant_name, r.restaurant_id, o.net_Revenue_inr
ORDER BY o.net_Revenue_inr DESC;
--correct
WITH rr AS (SELECT restaurant_id,SUM(net_revenue_inr) revenue FROM orders
GROUP BY restaurant_id)
	SELECT rr.restaurant_id,r.restaurant_name,rr.revenue FROM rr
	JOIN restaurants r
	ON rr.restaurant_id=r.restaurant_id
	WHERE rr.revenue>
		(SELECT AVG(revenue) FROM rr)
		ORDER BY rr.revenue DESC;

--40. Κάνε rank τα orders βάσει revenue.
SELECT order_id,net_revenue_inr,RANK() OVER(ORDER BY net_revenue_inr DESC) AS revenue_rank FROM orders;

--41. Βρες τα 3 μεγαλύτερα orders ανά restaurant.
WITH x AS (
	SELECT o.*, ROW_NUMBER() OVER(PARTITION BY restaurant_id ORDER BY net_revenue_inr DESC)AS rn
	FROM orders o)
SELECT * FROM x
WHERE rn<=3
ORDER BY restaurant_id, rn;

--42. Βρες top 3 restaurants ανά city βάσει revenue.
--mine_wrong
WITH rr AS (SELECT r.*, ROW_NUMBER() OVER(PARTITION BY r.city, r.restaurant_id, ORDER BY o.net_revenue_inr DESC) top_city FROM restaurants r
JOIN orders o
ON r.restaurant_id=o.restaurant_id
SELECT * FROM rr
WHERE top_city<=3
ORDER BY r.city, top_city
--correct
WITH rr AS (SELECT r.city,r.restaurant_id,r.restaurant_name,SUM(o.net_revenue_inr) revenue FROM restaurants r
JOIN orders o
ON r.restaurant_id=o.restaurant_id
GROUP BY r.city,r.restaurant_id,r.restaurant_name),
x AS (SELECT *,DENSE_RANK() OVER(PARTITION BY city ORDER BY revenue DESC) city_rank FROM rr)
SELECT * FROM x
WHERE city_rank<=3
ORDER BY city,city_rank;

--43. Υπολόγισε cumulative daily revenue.
WITH d AS (SELECT order_datetime::date order_date,SUM(net_revenue_inr) revenue FROM orders GROUP BY order_datetime::date) SELECT order_date,revenue,SUM(revenue) OVER(ORDER BY order_date) AS running_revenue FROM d ORDER BY order_date;
