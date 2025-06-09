-- Step 3: Repeat Purchase Rate
-- Calculates percentage of customers with multiple orders
-- Output: ~65.57% 
WITH PurchaseCounts AS (
    SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS PurchaseCount
    FROM online_retail_transactions
    GROUP BY CustomerID
)
SELECT 
    ROUND(100.0 * SUM(CASE WHEN PurchaseCount > 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS RepeatPurchaseRate
FROM PurchaseCounts;
