-- =====================================================
-- Project : Supermarket Sales Analysis
-- File    : 02_data_cleaning.sql
-- Purpose : Clean and validate the supermarket sales dataset
-- =====================================================

-- Note:
-- Execute this script on a freshly imported dataset.
-- The order_date column should not already exist.

-- =====================================================
-- Check Table Structure
-- =====================================================

DESCRIBE supermarket_sales;

-- =====================================================
-- Add New Date Column
-- =====================================================

ALTER TABLE supermarket_sales
ADD COLUMN order_date DATE;

-- =====================================================
-- Convert Mixed Date Formats
-- =====================================================

UPDATE supermarket_sales
SET order_date =
CASE
    WHEN `Date` LIKE '%-%'
        THEN STR_TO_DATE(`Date`, '%m-%d-%Y')
    WHEN `Date` LIKE '%/%'
        THEN STR_TO_DATE(`Date`, '%m/%d/%Y')
    ELSE NULL
END;

-- =====================================================
-- Verify Converted Dates
-- =====================================================

SELECT
    `Date`,
    order_date
FROM supermarket_sales
LIMIT 20;

-- =====================================================
-- Verify Date Range
-- =====================================================

SELECT
    MIN(order_date) AS first_date,
    MAX(order_date) AS last_date
FROM supermarket_sales;

-- Result:
-- Date range verified successfully (2019-01-01 to 2019-03-30).

-- =====================================================
-- Check Duplicate Records
-- Every invoice_id should be unique.
-- =====================================================

SELECT
    invoice_id,
    COUNT(*) AS duplicate_count
FROM supermarket_sales
GROUP BY invoice_id
HAVING COUNT(*) > 1;

-- Result:
-- No duplicate invoice IDs found.

-- =====================================================
-- Check NULL Values
-- =====================================================

SELECT
    SUM(CASE WHEN invoice_id IS NULL THEN 1 ELSE 0 END) AS invoice_id_nulls,
    SUM(CASE WHEN branch IS NULL THEN 1 ELSE 0 END) AS branch_nulls,
    SUM(CASE WHEN city IS NULL THEN 1 ELSE 0 END) AS city_nulls,
    SUM(CASE WHEN customer_type IS NULL THEN 1 ELSE 0 END) AS customer_type_nulls,
    SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS gender_nulls,
    SUM(CASE WHEN product_line IS NULL THEN 1 ELSE 0 END) AS product_line_nulls,
    SUM(CASE WHEN unit_price IS NULL THEN 1 ELSE 0 END) AS unit_price_nulls,
    SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS quantity_nulls,
    SUM(CASE WHEN tax IS NULL THEN 1 ELSE 0 END) AS tax_nulls,
    SUM(CASE WHEN sales IS NULL THEN 1 ELSE 0 END) AS sales_nulls,
    SUM(CASE WHEN cogs IS NULL THEN 1 ELSE 0 END) AS cogs_nulls,
    SUM(CASE WHEN gross_margin_percentage IS NULL THEN 1 ELSE 0 END) AS gross_margin_percentage_nulls,
    SUM(CASE WHEN gross_income IS NULL THEN 1 ELSE 0 END) AS gross_income_nulls,
    SUM(CASE WHEN payment IS NULL THEN 1 ELSE 0 END) AS payment_nulls,
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS order_date_nulls,
    SUM(CASE WHEN rating IS NULL THEN 1 ELSE 0 END) AS rating_nulls
FROM supermarket_sales;

-- Result:
-- No NULL values found.

-- =====================================================
-- Check Blank Values
-- =====================================================

SELECT
    SUM(CASE WHEN TRIM(branch) = '' THEN 1 ELSE 0 END) AS branch_blanks,
    SUM(CASE WHEN TRIM(city) = '' THEN 1 ELSE 0 END) AS city_blanks,
    SUM(CASE WHEN TRIM(customer_type) = '' THEN 1 ELSE 0 END) AS customer_type_blanks,
    SUM(CASE WHEN TRIM(gender) = '' THEN 1 ELSE 0 END) AS gender_blanks,
    SUM(CASE WHEN TRIM(product_line) = '' THEN 1 ELSE 0 END) AS product_line_blanks,
    SUM(CASE WHEN TRIM(payment) = '' THEN 1 ELSE 0 END) AS payment_blanks
FROM supermarket_sales;

-- Result:
-- No blank values found.

-- =====================================================
-- Check Extra Spaces
-- =====================================================

SELECT
    COUNT(*) AS rows_with_extra_spaces
FROM supermarket_sales
WHERE
    branch <> TRIM(branch)
    OR city <> TRIM(city)
    OR customer_type <> TRIM(customer_type)
    OR gender <> TRIM(gender)
    OR product_line <> TRIM(product_line)
    OR payment <> TRIM(payment);

-- Result:
-- No leading or trailing spaces found.

-- =====================================================
-- Validate Numeric Columns
-- =====================================================

SELECT
    SUM(CASE WHEN quantity <= 0 THEN 1 ELSE 0 END) AS invalid_quantity,
    SUM(CASE WHEN unit_price < 0 THEN 1 ELSE 0 END) AS invalid_unit_price,
    SUM(CASE WHEN sales < 0 THEN 1 ELSE 0 END) AS invalid_sales,
    SUM(CASE WHEN tax < 0 THEN 1 ELSE 0 END) AS invalid_tax,
    SUM(CASE WHEN cogs < 0 THEN 1 ELSE 0 END) AS invalid_cogs,
    SUM(CASE WHEN gross_income < 0 THEN 1 ELSE 0 END) AS invalid_gross_income,
    SUM(CASE WHEN rating < 0 OR rating > 10 THEN 1 ELSE 0 END) AS invalid_rating
FROM supermarket_sales;

-- Result:
-- No invalid numeric values found.

-- =====================================================
-- Data Cleaning Summary
-- =====================================================

-- ✔ Column names standardized.
-- ✔ Mixed date formats converted successfully.
-- ✔ Date range verified (2019-01-01 to 2019-03-30).
-- ✔ No duplicate invoice IDs found.
-- ✔ No NULL values found.
-- ✔ No blank values found.
-- ✔ No leading or trailing spaces found.
-- ✔ No invalid numeric values found.

-- Dataset is clean and ready for data exploration.