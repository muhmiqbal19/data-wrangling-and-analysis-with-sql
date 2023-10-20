-- QUESTION:
-- How many times do users re-order a specific item?
-- How many times do users re-order an item from a specific category?
-- How long between orders and re-orders?


-- 1. Find out how many users have ever ordered
SELECT COUNT(DISTINCT user_id) 
FROM orders;

-- 2. Find how many users have reordered the same item
SELECT
  COUNT(DISTINCT user_id)
FROM
  (
    SELECT
      user_id,
      item_id,
      COUNT(DISTINCT line_item_id) AS times_user_ordered
    FROM
      orders
    GROUP BY
      user_id,
      item_id
    HAVING
      COUNT(DISTINCT line_item_id) > 1 -- subtitution with WHERE clause outside
  ) user_level_order;
-- WHERE times_user_ordered > 1;


-- 3. Multiple orders. Do users even order more than once?
SELECT
  COUNT(DISTINCT user_id)
FROM
  (
    SELECT
      user_id,
      COUNT(DISTINCT invoice_id) AS order_count
    FROM
      orders
    GROUP BY
      user_id
    HAVING
      COUNT(DISTINCT invoice_id) > 1
  ) user_level;


-- 4. Orders per item
SELECT
  item_id,
  item_name,
  COUNT(DISTINCT line_item_id) AS order_count
FROM
  orders
GROUP BY
  item_id,
  item_name;
  

-- 5. Orders per category
SELECT
  item_category,
  COUNT(DISTINCT line_item_id) AS order_count
FROM
  orders
GROUP BY
  item_category;

-- 6. Do user order multiple things from the same category?
SELECT
  user_id,
  item_category,
  COUNT(DISTINCT line_item_id) AS times_category_ordered
FROM
  orders
GROUP BY
  user_id,
  item_category;
  

-- 7. Catefory with the most orders
SELECT
  item_category,
  AVG(times_category_ordered) AS avg_times_category_ordered
FROM
  (
    SELECT
      user_id,
      item_category,
      COUNT(DISTINCT line_item_id) AS times_category_ordered
    FROM
      orders
    GROUP BY
      user_id,
      item_category
  ) user_level
GROUP BY
  item_category;


-- 8. Item with the most orders
SELECT
  item_id,
  item_name,
  AVG(times_item_ordered) AS avg_times_item_ordered
FROM
  (
    SELECT
      user_id,
      item_id,
      item_name,
      COUNT(DISTINCT line_item_id) AS times_item_ordered
    FROM
      orders
    GROUP BY
      user_id,
      item_id,
      item_name
  ) user_level
GROUP BY
  item_id,
  item_name
ORDER BY avg_times_item_ordered DESC;


-- 9. Find the average time between orders
SELECT 
  DISTINCT first_orders.user_id,
  DATE(first_orders.paid_at) AS first_order_date,
  DATE(second_orders.paid_at) AS second_order_date,
  DATE(second_orders.paid_at) - DATE(first_orders.paid_at) AS date_diff
FROM
  (
    SELECT
      user_id,
      invoice_id,
      paid_at,
      DENSE_RANK() OVER(
        PARTITION BY user_id ORDER BY paid_at
      ) AS order_num
    FROM orders
  ) first_orders
  JOIN (
    SELECT
      user_id,
      invoice_id,
      paid_at,
      DENSE_RANK() OVER(
        PARTITION BY user_id ORDER BY paid_at
      ) AS order_num
    FROM orders
  ) second_orders ON first_orders.user_id = second_orders.user_id
WHERE
  first_orders.order_num = 1
  AND second_orders.order_num = 2
ORDER BY date_diff;