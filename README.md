# Restaurant Orders Data Analysis with SQL

## About the Project

This is a SQL portfolio project where I analysed restaurant and order data using PostgreSQL.

The goal was to practice SQL by working with transactional restaurant data and answering business-related questions about revenue, customers, restaurant performance, orders, delivery times, ratings and cancellations.

The analysis progresses from basic data exploration to more advanced SQL techniques, including joins, subqueries, Common Table Expressions (CTEs), and window functions.

## Dataset

Tables used:

Orders
Restaurants

The Orders dataset contains order-level information such as order date, restaurant, customer, dish, quantity, revenue, discounts, payment method, order status, delivery time and customer rating.

The Restaurants dataset contains restaurant-level information such as restaurant name, city, state, cuisine, price band, opening year and seating capacity.

## Tools Used

- PostgreSQL
- pgAdmin
- SQL

## What I Analyzed

- Total and average revenue
- Revenue by restaurant and city
- Restaurants generating above-average revenue
- Orders generating above-average revenue
- Top-performing dishes by revenue
- Restaurant performance within each city
- Top orders by restaurant
- Daily and monthly revenue trends
- Cumulative revenue using running totals
- Month-over-month revenue changes
- Revenue contribution by city
- Delivered and cancelled order analysis
- Cancellation rates by city
- Average customer ratings by restaurant
- Average delivery time by category
- Top customers based on revenue
- Customer value segmentation
- Restaurant revenue rankings and quartiles
- Restaurants without orders
- Duplicate order identification
- City-level restaurant performance analysis

## SQL Skills Practiced

- SELECT
- DISTINCT
- WHERE
- GROUP BY
   ORDER BY
- HAVING
- LIMIT
- BETWEEN
- IN
- ILIKE
- CASE
- INNER JOIN
- LEFT JOIN
- Aggregate Functions (COUNT, SUM, AVG, MAX, MIN)
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions
- PARTITION BY
- RANK
- DENSE_RANK
- ROW_NUMBER
- LAG
- NTILE
- Running Totals
- DATE_TRUNC
- Conditional Aggregation
- Percentage Calculations
- Data Exploration

## Files

- restaurant_orders_analysis.sql
- SQL_Project_Orders.csv
- SQL_Project_Restaurants.csv

## What I Learned

During this project I practiced importing data into PostgreSQL, creating tables, writing SQL queries, joining multiple datasets and using aggregate functions to answer business-related questions.

I also developed experience with more advanced SQL techniques including subqueries, Common Table Expressions (CTEs), window functions, ranking functions, running totals, month-over-month comparisons and customer segmentation.

The project helped me understand how SQL can be used to transform transactional data into meaningful business insights and performance analysis.

## Sample Outputs

### Restaurant Revenue Ranking

<img width="571" height="329" alt="restaurant_revenue_ranking" src="https://github.com/user-attachments/assets/765fb03f-9d05-4610-85c5-b510935ac767" />

### Top 3 Restaurant Rankings within Each City

<img width="680" height="368" alt="top 3 ranking" src="https://github.com/user-attachments/assets/a9f69a8b-cc4c-410c-85a2-ad2045771f30" />

### Cumulative Daily Revenue

<img width="580" height="304" alt="cumulative daily revenue" src="https://github.com/user-attachments/assets/a0241810-7490-4f34-a5d6-9e304604009a" />

### Month-over-Month Revenue Analysis

<img width="720" height="308" alt="month rev anal" src="https://github.com/user-attachments/assets/c6d20d64-ffee-40c7-8f10-d6521343c362" />


## Author

Vasileios Tatsidis

Finance professional with experience in financial reporting and analysis, currently expanding expertise in SQL, Power BI, data analytics and business intelligence.

GitHub Portfolio:
 https://github.com/TatsidisVasilis
