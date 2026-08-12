-- =====================================================
-- Project : Supermarket Sales Analysis
-- File    : 05_intermediate_sql.sql
-- Purpose : Intermediate SQL queries for business analysis
-- =====================================================

-- =====================================================
-- 1. Total Sales by Branch
-- =====================================================

SELECT
    branch,
    ROUND(SUM(sales), 2) AS total_sales
FROM supermarket_sales
GROUP BY branch;

-- =====================================================
-- 2. Total Sales by City
-- =====================================================

SELECT
    city,
    ROUND(SUM(sales), 2) AS total_sales
FROM supermarket_sales
GROUP BY city;

-- =====================================================
-- 3. Total Sales by Customer Type
-- =====================================================

SELECT
    customer_type,
    ROUND(SUM(sales), 2) AS total_sales
FROM supermarket_sales
GROUP BY customer_type;

-- =====================================================
-- 4. Total Sales by Gender
-- =====================================================

SELECT
    gender,
    ROUND(SUM(sales), 2) AS total_sales
FROM supermarket_sales
GROUP BY gender;

-- =====================================================
-- 5. Total Sales by Product Line
-- =====================================================

SELECT
    product_line,
    ROUND(SUM(sales), 2) AS total_sales
FROM supermarket_sales
GROUP BY product_line;

-- =====================================================
-- 6. Total Sales by Payment Method
-- =====================================================

SELECT
    payment,
    ROUND(SUM(sales), 2) AS total_sales
FROM supermarket_sales
GROUP BY payment;

-- =====================================================
-- 7. Top 5 Highest Sales Transactions
-- =====================================================

SELECT
    invoice_id,
    sales
FROM supermarket_sales
ORDER BY sales DESC
LIMIT 5;

-- =====================================================
-- 8. Top 5 Lowest Sales Transactions
-- =====================================================

SELECT
    invoice_id,
    sales
FROM supermarket_sales
ORDER BY sales ASC
LIMIT 5;

-- =====================================================
-- 9. Transactions with Sales Greater Than 500
-- =====================================================

SELECT
    invoice_id,
    customer_type,
    sales
FROM supermarket_sales
WHERE sales > 500;

-- =====================================================
-- 10. Members Only Transactions
-- =====================================================

SELECT
    invoice_id,
    customer_type,
    sales
FROM supermarket_sales
WHERE customer_type = 'Member';

-- =====================================================
-- 11. Female Customers Only
-- =====================================================

SELECT
    invoice_id,
    gender,
    sales
FROM supermarket_sales
WHERE gender = 'Female';

-- =====================================================
-- 12. Product Lines with Total Sales Greater Than 50,000
-- =====================================================

SELECT
    product_line,
    ROUND(SUM(sales), 2) AS total_sales
FROM supermarket_sales
GROUP BY product_line
HAVING SUM(sales) > 50000;

-- =====================================================
-- 13. Branches Ordered by Total Sales
-- =====================================================

SELECT
    branch,
    ROUND(SUM(sales), 2) AS total_sales
FROM supermarket_sales
GROUP BY branch
ORDER BY total_sales DESC;

-- =====================================================
-- 14. Cities Ordered by Total Sales
-- =====================================================

SELECT
    city,
    ROUND(SUM(sales), 2) AS total_sales
FROM supermarket_sales
GROUP BY city
ORDER BY total_sales DESC;

-- =====================================================
-- 15. Payment Methods Ordered by Number of Transactions
-- =====================================================

SELECT
    payment,
    COUNT(*) AS total_transactions
FROM supermarket_sales
GROUP BY payment
ORDER BY total_transactions DESC;
