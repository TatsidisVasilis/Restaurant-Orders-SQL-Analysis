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

--1. Εμφάνισε όλες τις εγγραφές του restaurants.
--1. Display all records from restaurants.
SELECT * FROM Restaurants;

--2. Εμφάνισε τις πρώτες 10 παραγγελίες.
--2. Display the first 10 orders.
SELECT * FROM orders
LIMIT 10;

--3. Εμφάνισε order_id, customer_id και order_datetime.
--3. Display order_id, customer_id, and order_datetime.
select order_id, customer_id, order_datetime from orders;

--4. Εμφάνισε τις μοναδικές categories.
--4. Display the distinct categories.
select distinct category from orders;

--5. Εμφάνισε τις μοναδικές cities.
--5. Display the distinct cities.
select distinct city from restaurants;

--6. Ταξινόμησε restaurants από παλαιότερο opening_year.
--6. Sort restaurants by opening_year, oldest first.
Select restaurant_name, opening_year from Restaurants
ORDER BY opening_year DESC;

--7. Δείξε πρώτα τις παραγγελίες με το μεγαλύτερο revenue.
--7. Display orders with the highest revenue first.
Select * from orders
ORDER BY net_revenue_inr DESC;

--8. Εμφάνισε μόνο Delivered orders.
--8. Display only Delivered orders.
Select * from orders
WHERE order_status = 'Delivered';

--9. Εμφάνισε μόνο active restaurants.
--9. Display only active restaurants.
Select * from restaurants
WHERE is_active = 'Yes';

--10. Βρες ratings μεγαλύτερα ή ίσα με 4.5.
--10. Find ratings greater than or equal to 4.5.
SELECT * FROM Orders
WHERE customer_rating >= 4.5
ORDER BY customer_rating DESC;

--11. Βρες delivery time μεταξύ 30 και 45 λεπτών.
--11. Find delivery times between 30 and 45 minutes.
SELECT * FROM Orders
WHERE delivery_minutes BETWEEN 30 AND 45;
--Second_way
SELECT * FROM Orders
WHERE delivery_minutes >=30 AND delivery_minutes<=45;

--12. Βρες πληρωμές με Card ή UPI.
--12. Find payments made by Card or UPI.
SELECT * FROM orders
WHERE payment_method IN ('Card','UPI')
--Second_way
SELECT * FROM orders
WHERE payment_method = 'Card' or payment_method =  'UPI';

--13. Βρες dishes που περιέχουν Chicken.
--13. Find dishes containing Chicken.
SELECT * FROM orders
WHERE dish_name ILIKE '%Chicken%';

--14. Βρες orders χωρίς rating.
--14. Find orders without a rating.
SELECT * from orders
WHERE customer_rating IS NULL;

--15. Μέτρησε όλες τις γραμμές του orders.
--15. Count all rows in orders.
SELECT COUNT(*) AS TOTAL_rows from orders;

--16. Μέτρησε τους διαφορετικούς customers.
--16. Count the distinct customers.
SELECT COUNT( distinct customer_id) AS unique_customers from orders;

--17. Υπολόγισε το συνολικό net revenue.
--17. Calculate total net revenue.
SELECT SUM(net_revenue_inr) AS Total_Revenue  FROM orders;

--18. Υπολόγισε το μέσο rating.
--18. Calculate the average rating.
SELECT ROUND(AVG(customer_rating),2) AS average_rating FROM orders;

--19. Βρες τη μικρότερη και μεγαλύτερη unit price.
--19. Find the minimum and maximum unit price.
SELECT MAX(unit_price_inr), MIN(unit_price_inr) FROM orders

--20. Μέτρησε orders ανά status.
--20. Count orders by status.
SELECT order_status, COUNT(*) AS orders FROM orders
GROUP BY order_status
ORDER BY orders DESC;

--21.Υπολόγισε revenue ανά payment method.
--21. Calculate revenue by payment method.
SELECT DISTINCT(payment_method), SUM(net_revenue_inr) AS total_revenue FROM orders
GROUP BY payment_method
ORDER BY total_revenue DESC;
--second way
SELECT payment_method, SUM(net_revenue_inr) AS revenue FROM orders
GROUP BY payment_method
ORDER BY revenue DESC;

--22. Υπολόγισε average delivery time ανά category.
--22. Calculate average delivery time by category.
SELECT category, ROUND(AVG(delivery_minutes),2) AS AVG_delivery_minutes FROM orders
GROUP BY category
ORDER BY AVG_delivery_minutes ASC;

--23. Βρες total quantity ανά dish.
--23. Find the total quantity for each dish.
Select dish_name, SUM(quantity) AS total_quantity from orders
GROUP BY dish_name
ORDER BY total_quantity DESC;

--24. Βρες τα 10 dishes με μεγαλύτερο revenue.
--24. Find the 10 dishes with the highest revenue.
SELECT dish_name, SUM(net_revenue_inr) AS revenue FROM orders
GROUP BY dish_name
ORDER BY revenue DESC
LIMIT 10;

--25. Βρες categories με πάνω από 100 orders.
--25. Find categories with more than 100 orders.
SELECT category, count(*) AS orders from orders
GROUP BY category
HAVING COUNT(*) > 100
ORDER BY orders DESC

--26. Βρες restaurant IDs με avg rating >= 4 και τουλάχιστον 10 ratings.
--26. Find restaurant IDs with an average rating >= 4 and at least 10 ratings.
SELECT restaurant_id, ROUND(AVG(customer_rating),2) AS avg_rating, COUNT(customer_rating) AS count_ratings FROM orders
GROUP BY restaurant_id
HAVING AVG(customer_rating) >= 4 AND COUNT(customer_rating) >= 10
ORDER BY avg_rating DESC

--27. Χώρισε orders σε Low (<300), Medium (<800), High revenue.
--27. Classify orders as Low (<300), Medium (<800), or High revenue.
SELECT order_id, net_revenue_inr,
CASE WHEN net_revenue_inr<300 THEN 'Low'
WHEN net_revenue_inr<800 THEN 'Medium'
ELSE 'High' END AS revenue_band
FROM orders
ORDER BY net_revenue_inr ASC;

--28. Μέτρησε Delivered και Cancelled σε ξεχωριστές στήλες.
--28. Count Delivered and Cancelled orders in separate columns.
SELECT SUM(CASE WHEN order_status='Delivered' THEN 1 ELSE 0 END) AS delivered,
SUM(CASE WHEN order_status='Cancelled' THEN 1 ELSE 0 END) AS cancelled FROM orders;

--29. Μέτρησε orders ανά μήνα.
--29. Count orders by month.
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
--30. Calculate revenue from Delivered orders by month.
SELECT DATE_TRUNC('month', order_datetime)::date AS month, SUM(net_revenue_inr) AS Total_Delivered_Revenue FROM Orders
WHERE order_status='Delivered'
GROUP BY month
ORDER BY month ASC;

--31. Εμφάνισε order_id, restaurant_name, city και revenue.
--31. Display order_id, restaurant_name, city, and revenue.
SELECT o.order_id, r.restaurant_name, r.city, o.net_revenue_inr FROM orders o
JOIN restaurants r
ON o.restaurant_id=r.restaurant_id;

--32. Υπολόγισε revenue ανά restaurant.
--32. Calculate revenue by restaurant.
SELECT r.restaurant_id, r.restaurant_name, SUM(o.net_revenue_inr) AS revenue from orders o
JOIN restaurants r
ON r.restaurant_id=o.restaurant_id
GROUP BY r.restaurant_name, r.restaurant_id
ORDER BY revenue DESC;

--33. Υπολόγισε revenue ανά city.
--33. Calculate revenue by city.
SELECT r.city, SUM(o.net_revenue_inr) AS revenue FROM orders o
JOIN restaurants r
ON r.restaurant_id=o.restaurant_id
GROUP BY r.city
ORDER BY revenue DESC;

--34. Βρες restaurants χωρίς orders.
--34. Find restaurants with no orders.
SELECT r.* FROM restaurants r
LEFT JOIN orders o
ON r.restaurant_id=o.restaurant_id
WHERE order_id IS NULL

--35. Βρες duplicated order IDs.
--35. Find duplicate order IDs.
SELECT order_id, COUNT(*) AS dublicates FROM orders O
GROUP BY order_id
HAVING COUNT(*)> 1

--36. Υπολόγισε overall cancellation rate.
--36. Calculate the overall cancellation rate.
SELECT ROUND(100.0*SUM(CASE WHEN order_status='Cancelled' THEN 1 ELSE 0 END)/COUNT(*),2) AS cancellation_rate_pct FROM orders;

--37. Υπολόγισε cancellation rate ανά city.
--37. Calculate the cancellation rate by city.
SELECT r.city, COUNT(*) AS orders, ROUND(100.0*SUM(CASE WHEN o.order_status='Cancelled' THEN 1 ELSE 0 END)/COUNT(*),2) AS cancellation_rate_pct FROM orders o
JOIN restaurants r
ON o.restaurant_id=r.restaurant_id
GROUP BY r.city
ORDER BY cancellation_rate_pct DESC;

--38. Βρες orders με revenue πάνω από τον συνολικό μέσο όρο.
--38. Find orders with revenue above the overall average.
SELECT * FROM orders
WHERE net_revenue_inr>(
	SELECT AVG(net_revenue_inr) FROM orders)
ORDER BY net_revenue_inr DESC;

--39. Βρες restaurants με revenue πάνω από το average restaurant revenue
--39. Find restaurants with revenue above the average restaurant revenue.
WITH rr AS (SELECT restaurant_id,SUM(net_revenue_inr) revenue FROM orders
GROUP BY restaurant_id)
	SELECT rr.restaurant_id,r.restaurant_name,rr.revenue FROM rr
	JOIN restaurants r
	ON rr.restaurant_id=r.restaurant_id
	WHERE rr.revenue>
		(SELECT AVG(revenue) FROM rr)
		ORDER BY rr.revenue DESC;

--40. Κάνε rank τα orders βάσει revenue.
--40. Rank orders by revenue.
SELECT order_id,net_revenue_inr,RANK() OVER(ORDER BY net_revenue_inr DESC) AS revenue_rank FROM orders;

--41. Βρες τα 3 μεγαλύτερα orders ανά restaurant.
--41. Find the 3 largest orders by revenue for each restaurant.
WITH x AS (
	SELECT o.*, ROW_NUMBER() OVER(PARTITION BY restaurant_id ORDER BY net_revenue_inr DESC)AS rn
	FROM orders o)
SELECT * FROM x
WHERE rn<=3
ORDER BY restaurant_id, rn;

--42. Βρες top 3 restaurants ανά city βάσει revenue.
--42. Find the top 3 restaurants in each city by revenue.
WITH rr AS (SELECT r.city,r.restaurant_id,r.restaurant_name,SUM(o.net_revenue_inr) revenue FROM restaurants r
JOIN orders o
ON r.restaurant_id=o.restaurant_id
GROUP BY r.city,r.restaurant_id,r.restaurant_name),
x AS (SELECT *,DENSE_RANK() OVER(PARTITION BY city ORDER BY revenue DESC) city_rank FROM rr)
SELECT * FROM x
WHERE city_rank<=3
ORDER BY city,city_rank;

--43. Υπολόγισε cumulative daily revenue.
--43. Calculate cumulative daily revenue.
WITH d AS (SELECT order_datetime::date AS order_date, SUM(net_revenue_inr) AS revenue FROM orders
GROUP BY order_date)
SELECT order_date,revenue,SUM(revenue) OVER(ORDER BY order_date) AS running_revenue FROM d
ORDER BY order_date;

--44. Month-over-Month Revenue Analysis.
--44. Find monthly revenue and the change from the previous month.
WITH m AS (SELECT DATE_TRUNC('month',order_datetime)::date AS order_month,SUM(net_revenue_inr) AS revenue FROM orders
GROUP BY order_month)
SELECT order_month,revenue,revenue-(LAG(revenue) OVER(ORDER BY order_month)) AS change FROM m
ORDER BY order_month; 

--45. Υπολόγισε revenue contribution % κάθε city.
--45. Calculate each city's percentage contribution to revenue.
WITH c AS (SELECT r.city, SUM(o.net_revenue_inr) AS revenue FROM orders o
JOIN restaurants r
ON r.restaurant_id=o.restaurant_id
GROUP BY r.city)
SELECT city, revenue, ROUND(100.0*revenue/SUM(revenue) OVER(),2) AS percentage FROM c
ORDER BY revenue DESC;

--46. Βρες top 10 customers βάσει revenue.
--46. Find the top 10 customers by revenue.
SELECT customer_id, SUM(net_revenue_inr) AS revenue FROM orders
GROUP BY customer_id
ORDER BY revenue DESC
LIMIT 10;

--47.Χώρισε customers σε Low, Medium, High value.
--47. Segment customers into Low, Medium, and High value.
WITH c AS (SELECT customer_id, SUM(net_revenue_inr) AS revenue FROM orders
GROUP BY customer_id)
SELECT customer_id,revenue,
CASE WHEN revenue<1000 THEN 'Low'
WHEN revenue<3000 THEN 'Medium'
ELSE 'High' END
AS segment FROM c
ORDER BY revenue DESC;

--48. Χώρισε restaurants σε 4 revenue quartiles.
--48. Divide restaurants into 4 revenue quartiles.
WITH rr AS (SELECT r.restaurant_id,r.restaurant_name,SUM(o.net_revenue_inr) revenue FROM restaurants r
JOIN orders o
ON r.restaurant_id=o.restaurant_id
GROUP BY r.restaurant_id,r.restaurant_name)
SELECT *, NTILE(4) OVER(ORDER BY revenue DESC) AS quartile FROM rr
ORDER BY revenue DESC;

--49. Report ανά city: restaurants, orders, customers, revenue, rating, delivery και cancellation rate.
--49. Create a report by city showing restaurants, orders, customers, revenue, rating, delivery time, and cancellation rate.
SELECT r.city,
COUNT(DISTINCT r.restaurant_id) restaurants,
COUNT(*) orders,
COUNT(DISTINCT o.customer_id) customers,
SUM(o.net_revenue_inr) revenue,
ROUND(AVG(o.customer_rating),2) avg_rating,
ROUND(AVG(o.delivery_minutes),2) avg_delivery,
ROUND(100.0*SUM(CASE WHEN o.order_status='Cancelled' THEN 1 ELSE 0 END)/COUNT(*),2) cancellation_rate_pct FROM orders o
JOIN restaurants r
ON o.restaurant_id=r.restaurant_id
GROUP BY r.city
ORDER BY revenue DESC;

