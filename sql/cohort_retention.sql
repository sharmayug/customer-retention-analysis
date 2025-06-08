-- Step 4: Cohort Retention
-- Builds cohort table tracking retention by first-purchase month
-- Output: Table with CohortMonth, PurchaseMonth, RetainedCustomers (e.g., 2010-01: 95 customers, 6 in 2010-02)
WITH FirstPurchase AS (
    SELECT CustomerID, MIN(InvoiceDate) AS FirstPurchaseDate
    FROM online_retail_transactions
    GROUP BY CustomerID
),
Cohort AS (
    SELECT 
        CustomerID,
        TO_CHAR(FirstPurchaseDate, 'YYYY-MM') AS CohortMonth
    FROM FirstPurchase
),
Purchases AS (
    SELECT 
        o.CustomerID,
        TO_CHAR(o.InvoiceDate, 'YYYY-MM') AS PurchaseMonth
    FROM online_retail_transactions o
    JOIN Cohort c ON o.CustomerID = c.CustomerID
)
SELECT 
    c.CohortMonth,
    p.PurchaseMonth,
    COUNT(DISTINCT p.CustomerID) AS RetainedCustomers
FROM Cohort c
LEFT JOIN Purchases p ON c.CustomerID = p.CustomerID
GROUP BY c.CohortMonth, p.PurchaseMonth
ORDER BY c.CohortMonth, p.PurchaseMonth;
