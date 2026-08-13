-- =====================================================
-- Project : Supermarket Sales Analysis
-- File    : 06_advanced_sql.sql
-- Purpose : Advanced SQL queries for business insights
-- =====================================================

-- =====================================================
-- 1. CASE Statement - Sales Category
-- =====================================================

SELECT
    invoice_id,
    sales,
    CASE
        WHEN sales >= 700 THEN 'High Sales'
        WHEN sales >= 300 THEN 'Medium Sales'
        ELSE 'Low Sales'
    END AS sales_category
FROM supermarket_sales;

-- =====================================================
-- 2. CASE Statement - Customer Rating
-- =====================================================

SELECT
    invoice_id,
    rating,
    CASE
        WHEN rating >= 9 THEN 'Excellent'
        WHEN rating >= 7 THEN 'Good'
        WHEN rating >= 5 THEN 'Average'
        ELSE 'Poor'
    END AS rating_category
FROM supermarket_sales;

-- =====================================================
-- 3. Subquery - Transactions Above Average Sales
-- =====================================================

SELECT
    invoice_id,
    sales
FROM supermarket_sales
WHERE sales >
(
    SELECT AVG(sales)
    FROM supermarket_sales
);

-- =====================================================
-- 4. Subquery - Products with Above Average Unit Price
-- =====================================================

SELECT
    product_line,
    unit_price
FROM supermarket_sales
WHERE unit_price >
(
    SELECT AVG(unit_price)
    FROM supermarket_sales
);

-- =====================================================
-- 5. Create a View - Sales Summary by Branch
-- =====================================================

CREATE VIEW branch_sales_summary AS

SELECT
    branch,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(AVG(sales),2) AS average_sales,
    COUNT(*) AS total_transactions
FROM supermarket_sales
GROUP BY branch;

-- View the View

SELECT *
FROM branch_sales_summary;

-- =====================================================
-- 6. Create a View - Product Performance
-- =====================================================

CREATE VIEW product_sales_summary AS

SELECT
    product_line,
    ROUND(SUM(sales),2) AS total_sales,
    SUM(quantity) AS total_quantity,
    ROUND(AVG(rating),2) AS average_rating
FROM supermarket_sales
GROUP BY product_line;

-- View the View

SELECT *
FROM product_sales_summary;

-- =====================================================
-- 7. Correlated Subquery
-- =====================================================

SELECT
    invoice_id,
    branch,
    sales
FROM supermarket_sales s1
WHERE sales >
(
    SELECT AVG(s2.sales)
    FROM supermarket_sales s2
    WHERE s1.branch = s2.branch
);

-- =====================================================
-- 8. CASE with GROUP BY
-- =====================================================

SELECT
    CASE
        WHEN quantity >= 8 THEN 'Bulk Purchase'
        ELSE 'Regular Purchase'
    END AS purchase_type,
    COUNT(*) AS total_transactions
FROM supermarket_sales
GROUP BY purchase_type;

-- =====================================================
-- 9. IF Function
-- =====================================================

SELECT
    invoice_id,
    sales,
    IF(sales > 500,'High','Normal') AS sales_status
FROM supermarket_sales;

-- =====================================================
-- 10. NULLIF Example
-- =====================================================

SELECT
    invoice_id,
    NULLIF(quantity,0) AS quantity
FROM supermarket_sales;