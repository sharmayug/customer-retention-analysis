-- Step 2: Data Cleaning
-- Creates online_retail table, imports data, cleans to online_retail_clean, and creates transaction-level online_retail_transactions
-- Output: ~18566 transactions in online_retail_transactions
CREATE TABLE online_retail (
    InvoiceNo TEXT,
    StockCode TEXT,
    Description TEXT,
    Quantity INTEGER,
    InvoiceDate TIMESTAMP,
    UnitPrice FLOAT,
    CustomerID INTEGER,
    Country TEXT
);
Drop table online_retail_transactions
-- Create cleaned table (remove null CustomerIDs, negative quantities)
SELECT *
INTO online_retail_clean
FROM online_retail
WHERE CustomerID IS NOT NULL AND Quantity > 0;

-- Create transaction-level table (one row per transaction)
SELECT DISTINCT CustomerID, InvoiceNo, InvoiceDate
INTO online_retail_transactions
FROM online_retail_clean;
