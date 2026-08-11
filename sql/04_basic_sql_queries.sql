-- =====================================================
-- Project : Supermarket Sales Analysis
-- File    : 04_basic_sql_queries.sql
-- Author  : Siddhi Pednekar
-- Purpose : Perform basic business analysis using SQL
-- =====================================================

-- =====================================================
-- 1. Total Sales
-- =====================================================

SELECT
    ROUND(SUM(sales), 2) AS total_sales
FROM supermarket_sales;

-- =====================================================
-- 2. Total Transactions
-- =====================================================

SELECT
    COUNT(*) AS total_transactions
FROM supermarket_sales;

-- =====================================================
-- 3. Total Quantity Sold
-- =====================================================

SELECT
    SUM(quantity) AS total_quantity_sold
FROM supermarket_sales;

-- =====================================================
-- 4. Average Sales Per Transaction
-- =====================================================

SELECT
    ROUND(AVG(sales), 2) AS average_sales
FROM supermarket_sales;

-- =====================================================
-- 5. Average Customer Rating
-- =====================================================

SELECT
    ROUND(AVG(rating), 2) AS average_rating
FROM supermarket_sales;

-- =====================================================
-- 6. Highest Sale
-- =====================================================

SELECT
    MAX(sales) AS highest_sale
FROM supermarket_sales;

-- =====================================================
-- 7. Lowest Sale
-- =====================================================

SELECT
    MIN(sales) AS lowest_sale
FROM supermarket_sales;

-- =====================================================
-- 8. Highest Unit Price
-- =====================================================

SELECT
    MAX(unit_price) AS highest_unit_price
FROM supermarket_sales;

-- =====================================================
-- 9. Lowest Unit Price
-- =====================================================

SELECT
    MIN(unit_price) AS lowest_unit_price
FROM supermarket_sales;

-- =====================================================
-- 10. Average Quantity Purchased
-- =====================================================

SELECT
    ROUND(AVG(quantity), 2) AS average_quantity
FROM supermarket_sales;