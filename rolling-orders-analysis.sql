-- QUESTION: How many orders each day? What is the trend over a period?


-- 1. Create a subtable of orders per day
SELECT
  DATE(paid_at) AS day,
  COUNT(DISTINCT invoice_id) AS orders,
  COUNT(DISTINCT line_item_id) AS items_ordered
FROM
  orders
GROUP BY
  DATE(paid_at);
  

-- 2. Daily rollup, check the join.
	-- Join the sub table from the sub table to the dates rollup table 
	-- so we can get a row for every date
SELECT *
FROM dates_rollup 
LEFT JOIN 
  (
  SELECT
    DATE(paid_at) AS day,
    COUNT(DISTINCT invoice_id) AS orders,
    COUNT(DISTINCT line_item_id) AS items_ordered
  FROM orders
  GROUP BY DATE(paid_at)
  ) daily_orders
ON daily_orders.day = dates_rollup.date;


-- 3. Daily rollup, clean up columns.
	-- Specify the columns we actually want to return, 
    -- and if necessary do any aggregation needed to get 
    -- a count of the orders made per day.
SELECT 
  dates_rollup.date,
  COALESCE(SUM(orders), 0) AS orders,
  COALESCE(SUM(items_ordered), 0) AS items_ordered
FROM dates_rollup 
LEFT JOIN 
  (
  SELECT
    DATE(paid_at) AS day,
    COUNT(DISTINCT invoice_id) AS orders,
    COUNT(DISTINCT line_item_id) AS items_ordered
  FROM
    orders
  GROUP BY
    DATE(paid_at)
  ) daily_orders
ON daily_orders.day = dates_rollup.date
GROUP BY dates_rollup.date;


-- 4. Weekly Rollup, check the join.
	-- Figure out which parts of the JOIN condition need to be edited.
	-- Create 7 day rolling orders table.
SELECT *
FROM dates_rollup
  LEFT JOIN (
    SELECT
      DATE(paid_at) AS day,
      COUNT(DISTINCT invoice_id) AS orders,
      COUNT(DISTINCT line_item_id) AS items_ordered
    FROM orders
    GROUP BY DATE(paid_at)
  ) daily_orders ON daily_orders.day <= dates_rollup.date
  AND daily_orders.day > dates_rollup.d7_ago;


-- 5. Weekly Rollup, clean up columns.
	-- Finish creating the weekly rolling orders table, by performing
	-- any aggregation steps and naming your columns appropriately.
SELECT
  dates_rollup.date,
  COALESCE(SUM(orders), 0) AS orders,
  COALESCE(SUM(items_ordered), 0) AS items_ordered,
  COUNT(*) AS row_count
FROM
  dates_rollup
  LEFT JOIN (
    SELECT
      DATE(paid_at) AS day,
      COUNT(DISTINCT invoice_id) AS orders,
      COUNT(DISTINCT line_item_id) AS items_ordered
    FROM
      orders
    GROUP BY
      DATE(paid_at)
  ) daily_orders ON daily_orders.day <= dates_rollup.date
  AND daily_orders.day > dates_rollup.d7_ago
GROUP BY
  dates_rollup.date 

