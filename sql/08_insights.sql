-- =====================================================
-- Project : Supermarket Sales Analysis
-- File    : 08_insights.sql
-- Author  : Siddhi Pednekar
-- Purpose : Advanced SQL analysis and business insights
-- =====================================================


USE supermarket_db;


-- 1. Product Line Sales and Gross Income

SELECT product_line, ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(gross_income), 2) AS total_gross_income
FROM supermarket_sales
GROUP BY product_line
ORDER BY total_sales DESC;

-- 2. Rank Product Lines by Total Sales

SELECT
    product_line,
    ROUND(SUM(sales), 2) AS total_sales,
    RANK() OVER (ORDER BY SUM(sales) DESC) AS sales_rank
FROM supermarket_sales
GROUP BY product_line
ORDER BY sales_rank;

-- 3. Compare Product Line Sales with Average Sales

WITH product_sales AS (
    SELECT
        product_line,
        ROUND(SUM(sales), 2) AS total_sales
    FROM supermarket_sales
    GROUP BY product_line
)
SELECT
    product_line,
    total_sales,
    ROUND(AVG(total_sales) OVER (), 2) AS average_product_sales,
    ROUND(total_sales - AVG(total_sales) OVER (), 2) AS difference_from_average
FROM product_sales
ORDER BY total_sales DESC;



-- 4. Branch Performance Analysis

SELECT
    branch,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(gross_income), 2) AS total_gross_income,
    ROUND(AVG(rating), 2) AS average_rating
FROM supermarket_sales
GROUP BY branch
ORDER BY total_sales DESC;

-- 5. Rank Branches by Sales

SELECT
    branch,
    ROUND(SUM(sales), 2) AS total_sales,
    DENSE_RANK() OVER (ORDER BY SUM(sales) DESC) AS sales_rank
FROM supermarket_sales
GROUP BY branch
ORDER BY sales_rank;

-- 6. Customer Type Performance

SELECT
    customer_type,
    COUNT(*) AS transaction_count,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(AVG(sales), 2) AS average_transaction_value,
    ROUND(SUM(gross_income), 2) AS total_gross_income
FROM supermarket_sales
GROUP BY customer_type
ORDER BY total_sales DESC;


-- 7. Customer Type Contribution to Total Sales

SELECT
    customer_type,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(
        SUM(sales) * 100 /
        (SELECT SUM(sales) FROM supermarket_sales),
        2
    ) AS sales_percentage
FROM supermarket_sales
GROUP BY customer_type
ORDER BY total_sales DESC;

-- 8. Product Line Performance by Customer Type

SELECT
    product_line,
    customer_type,
    COUNT(*) AS transaction_count,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(AVG(sales), 2) AS average_transaction_value
FROM supermarket_sales
GROUP BY product_line, customer_type
ORDER BY product_line, total_sales DESC;

-- 9. Top Product Line by Customer Type

WITH customer_product_sales AS (
    SELECT
        customer_type,
        product_line,
        ROUND(SUM(sales), 2) AS total_sales
    FROM supermarket_sales
    GROUP BY customer_type, product_line
),
ranked_products AS (
    SELECT
        customer_type,
        product_line,
        total_sales,
        ROW_NUMBER() OVER (
            PARTITION BY customer_type
            ORDER BY total_sales DESC
        ) AS sales_position
    FROM customer_product_sales
)
SELECT
    customer_type,
    product_line,
    total_sales,
    sales_position
FROM ranked_products
WHERE sales_position = 1;

-- 10. Gross Income Percentage by Product Line

SELECT
    product_line,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(gross_income), 2) AS total_gross_income,
    ROUND(
        SUM(gross_income) * 100 / SUM(sales),
        2
    ) AS gross_income_percentage
FROM supermarket_sales
GROUP BY product_line
ORDER BY gross_income_percentage DESC;

-- 11. Gross Income Percentage by Branch

SELECT
    branch,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(gross_income), 2) AS total_gross_income,
    ROUND(
        SUM(gross_income) * 100 / SUM(sales),
        2
    ) AS gross_income_percentage
FROM supermarket_sales
GROUP BY branch
ORDER BY total_gross_income DESC;

-- 12. Monthly Sales Analysis

SELECT
    DATE_FORMAT(
        CASE
            WHEN `Date` LIKE '%-%' THEN STR_TO_DATE(`Date`, '%d-%m-%Y')
            WHEN `Date` LIKE '%/%' THEN STR_TO_DATE(`Date`, '%m/%d/%Y')
        END,
        '%Y-%m'
    ) AS sales_month,
    ROUND(SUM(sales), 2) AS total_sales,
    COUNT(*) AS transaction_count
FROM supermarket_sales
GROUP BY sales_month
ORDER BY sales_month;


-- 13. Rank Months by Total Sales

WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(
            CASE
                WHEN `Date` LIKE '%-%'
                    THEN STR_TO_DATE(`Date`, '%d-%m-%Y')
                WHEN `Date` LIKE '%/%'
                    THEN STR_TO_DATE(`Date`, '%m/%d/%Y')
            END,
            '%Y-%m'
        ) AS sales_month,
        ROUND(SUM(sales), 2) AS total_sales
    FROM supermarket_sales
    GROUP BY sales_month
)
SELECT
    sales_month,
    total_sales,
    RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM monthly_sales
ORDER BY sales_rank;


-- 14. Top Sales Dates

SELECT
    DATE(
        CASE
            WHEN `Date` LIKE '%-%'
                THEN STR_TO_DATE(`Date`, '%d-%m-%Y')
            WHEN `Date` LIKE '%/%'
                THEN STR_TO_DATE(`Date`, '%m/%d/%Y')
        END
    ) AS sales_date,
    COUNT(*) AS transaction_count,
    ROUND(SUM(sales), 2) AS total_sales
FROM supermarket_sales
GROUP BY sales_date
ORDER BY total_sales DESC
LIMIT 10;

-- 15. Sales by Time of Day

SELECT
    CASE
        WHEN HOUR(STR_TO_DATE(`Time`, '%H:%i:%s')) < 12
            THEN 'Morning'
        WHEN HOUR(STR_TO_DATE(`Time`, '%H:%i:%s')) < 17
            THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_period,
    COUNT(*) AS transaction_count,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(AVG(sales), 2) AS average_transaction_value
FROM supermarket_sales
GROUP BY time_period
ORDER BY total_sales DESC;

-- 16. Payment Method Analysis

SELECT
    payment,
    COUNT(*) AS transaction_count,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(AVG(sales), 2) AS average_transaction_value
FROM supermarket_sales
GROUP BY payment
ORDER BY total_sales DESC;


-- 17. Top Product Line in Each Branch

WITH branch_product_sales AS (
    SELECT
        branch,
        product_line,
        ROUND(SUM(sales), 2) AS total_sales
    FROM supermarket_sales
    GROUP BY branch, product_line
),
ranked_products AS (
    SELECT
        branch,
        product_line,
        total_sales,
        ROW_NUMBER() OVER (
            PARTITION BY branch
            ORDER BY total_sales DESC
        ) AS sales_position
    FROM branch_product_sales
)
SELECT
    branch,
    product_line,
    total_sales,
    sales_position
FROM ranked_products
WHERE sales_position = 1
ORDER BY branch;

-- =====================================================
-- 18. Overall Business Performance Summary
-- =====================================================

SELECT
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT invoice_id) AS unique_invoices,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(AVG(sales), 2) AS average_transaction_value,
    ROUND(SUM(gross_income), 2) AS total_gross_income,
    ROUND(AVG(rating), 2) AS average_customer_rating
FROM supermarket_sales;
