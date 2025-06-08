-- Step 5: Average Time Between Orders
-- Calculates average days between consecutive orders
-- Output: ~48.27 days (replace with your actual value)
WITH OrderGaps AS (
    SELECT 
        CustomerID,
        InvoiceNo,
        InvoiceDate,
        LAG(InvoiceDate) OVER (PARTITION BY CustomerID ORDER BY InvoiceDate) AS PreviousInvoiceDate
    FROM online_retail_transactions
),
DayDifferences AS (
    SELECT 
        CustomerID,
        EXTRACT(EPOCH FROM (InvoiceDate - PreviousInvoiceDate)) / 86400 AS DaysBetweenOrders
    FROM OrderGaps
    WHERE PreviousInvoiceDate IS NOT NULL
)
SELECT 
    ROUND(AVG(DaysBetweenOrders), 2) AS AvgDaysBetweenOrders
FROM DayDifferences;
