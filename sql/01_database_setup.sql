
-- Create Database
CREATE DATABASE supermarket_analysis;

-- Use Database
USE supermarket_analysis;

-- Verify Imported Data
SELECT *
FROM supermarket_sales;

-- Count Total Records
SELECT COUNT(*)
FROM supermarket_sales;

-- Rename Incorrect Column
ALTER TABLE supermarket_sales
CHANGE COLUMN `ï»¿Invoice ID` invoice_id VARCHAR(30);

-- Verify Table Structure
DESCRIBE supermarket_sales;

