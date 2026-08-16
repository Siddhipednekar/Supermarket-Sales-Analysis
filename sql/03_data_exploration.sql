-- =====================================================
-- Project : Supermarket Sales Analysis
-- File    : 03_data_exploration.sql
-- Purpose : Explore the dataset before business analysis
-- =====================================================

-- =====================================================
-- Total Number of Records
-- =====================================================

SELECT COUNT(*) AS total_records
FROM supermarket_sales;

-- =====================================================
-- Total Number of Columns
-- =====================================================

SELECT COUNT(*) AS total_columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'supermarket_sales'
AND TABLE_SCHEMA = DATABASE();

-- =====================================================
-- View First 10 Records
-- =====================================================

SELECT *
FROM supermarket_sales
LIMIT 10;

-- =====================================================
-- View Last 10 Records
-- =====================================================

SELECT *
FROM supermarket_sales
ORDER BY invoice_id DESC
LIMIT 10;

-- =====================================================
-- Distinct Branches
-- =====================================================

SELECT DISTINCT branch
FROM supermarket_sales;

-- =====================================================
-- Distinct Cities
-- =====================================================

SELECT DISTINCT city
FROM supermarket_sales;

-- =====================================================
-- Distinct Customer Types
-- =====================================================

SELECT DISTINCT customer_type
FROM supermarket_sales;

-- =====================================================
-- Distinct Genders
-- =====================================================

SELECT DISTINCT gender
FROM supermarket_sales;

-- =====================================================
-- Distinct Product Lines
-- =====================================================

SELECT DISTINCT product_line
FROM supermarket_sales;

-- =====================================================
-- Distinct Payment Methods
-- =====================================================

SELECT DISTINCT payment
FROM supermarket_sales;

-- =====================================================
-- Date Range
-- =====================================================

SELECT
    MIN(order_date) AS first_date,
    MAX(order_date) AS last_date
FROM supermarket_sales;

-- =====================================================
-- Sales Range
-- =====================================================

SELECT
    MIN(sales) AS minimum_sales,
    MAX(sales) AS maximum_sales
FROM supermarket_sales;

-- =====================================================
-- Unit Price Range
-- =====================================================

SELECT
    MIN(unit_price) AS minimum_unit_price,
    MAX(unit_price) AS maximum_unit_price
FROM supermarket_sales;

-- =====================================================
-- Quantity Range
-- =====================================================

SELECT
    MIN(quantity) AS minimum_quantity,
    MAX(quantity) AS maximum_quantity
FROM supermarket_sales;

-- =====================================================
-- Rating Range
-- =====================================================

SELECT
    MIN(rating) AS minimum_rating,
    MAX(rating) AS maximum_rating
FROM supermarket_sales;
