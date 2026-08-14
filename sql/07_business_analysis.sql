-- Supermarket Sales Analysis
-- File: 07_business_analysis.sql


USE supermarket_db;


-- 1. Total Sales

SELECT
    ROUND(SUM(sales), 2) AS total_sales
FROM supermarket_sales;


-- 2. Sales by Branch

SELECT
    branch,
    ROUND(SUM(sales), 2) AS total_sales
FROM supermarket_sales
GROUP BY branch
ORDER BY total_sales DESC;


-- 3. Sales by City

SELECT
    city,
    ROUND(SUM(sales), 2) AS total_sales
FROM supermarket_sales
GROUP BY city
ORDER BY total_sales DESC;


-- 4. Sales by Product Line

SELECT
    product_line,
    ROUND(SUM(sales), 2) AS total_sales
FROM supermarket_sales
GROUP BY product_line
ORDER BY total_sales DESC;


-- 5. Quantity Sold by Product Line

SELECT
    product_line,
    SUM(quantity) AS total_quantity
FROM supermarket_sales
GROUP BY product_line
ORDER BY total_quantity DESC;


-- 6. Average Sales per Transaction

SELECT
    ROUND(AVG(sales), 2) AS average_transaction_value
FROM supermarket_sales;


-- 7. Sales by Customer Type

SELECT
    customer_type,
    ROUND(SUM(sales), 2) AS total_sales
FROM supermarket_sales
GROUP BY customer_type
ORDER BY total_sales DESC;


-- 8. Sales by Gender

SELECT
    gender,
    ROUND(SUM(sales), 2) AS total_sales
FROM supermarket_sales
GROUP BY gender
ORDER BY total_sales DESC;


-- 9. Sales by Payment Method

SELECT
    payment,
    ROUND(SUM(sales), 2) AS total_sales
FROM supermarket_sales
GROUP BY payment
ORDER BY total_sales DESC;


-- 10. Number of Transactions by Payment Method

SELECT
    payment,
    COUNT(*) AS transaction_count
FROM supermarket_sales
GROUP BY payment
ORDER BY transaction_count DESC;


-- 11. Average Rating by Product Line

SELECT
    product_line,
    ROUND(AVG(rating), 2) AS average_rating
FROM supermarket_sales
GROUP BY product_line
ORDER BY average_rating DESC;


-- 12. Average Rating by Branch

SELECT
    branch,
    ROUND(AVG(rating), 2) AS average_rating
FROM supermarket_sales
GROUP BY branch
ORDER BY average_rating DESC;


-- 13. Monthly Sales

SELECT
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    ROUND(SUM(sales), 2) AS total_sales
FROM supermarket_sales
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;


-- 14. Daily Sales

SELECT
    order_date,
    ROUND(SUM(sales), 2) AS total_sales
FROM supermarket_sales
GROUP BY order_date
ORDER BY order_date;


-- 15. Top 10 Highest-Value Transactions

SELECT
    invoice_id,
    branch,
    city,
    product_line,
    sales
FROM supermarket_sales
ORDER BY sales DESC
LIMIT 10;


-- 16. Product Line with Highest Average Transaction Value

SELECT
    product_line,
    ROUND(AVG(sales), 2) AS average_sales
FROM supermarket_sales
GROUP BY product_line
ORDER BY average_sales DESC;


-- 17. Sales Above Overall Average

SELECT
    invoice_id,
    branch,
    product_line,
    sales
FROM supermarket_sales
WHERE sales > (
    SELECT AVG(sales)
    FROM supermarket_sales
)
ORDER BY sales DESC;


-- 18. Branch Performance by Customer Type

SELECT
    branch,
    customer_type,
    ROUND(SUM(sales), 2) AS total_sales
FROM supermarket_sales
GROUP BY branch, customer_type
ORDER BY branch, total_sales DESC;


-- 19. Product Line Sales Contribution

SELECT
    product_line,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(
        SUM(sales) * 100 /
        (SELECT SUM(sales) FROM supermarket_sales),
        2
    ) AS sales_percentage
FROM supermarket_sales
GROUP BY product_line
ORDER BY total_sales DESC;


-- 20. Branch Ranking by Sales

SELECT
    branch,
    ROUND(SUM(sales), 2) AS total_sales,
    RANK() OVER (
        ORDER BY SUM(sales) DESC
    ) AS sales_rank
FROM supermarket_sales
GROUP BY branch;