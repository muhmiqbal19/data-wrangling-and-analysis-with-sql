-- QUESTION: We should email people a picture of what they looked at most recently!


-- 1. Format the view_item event from events table into 
	-- a table with the appropriate columns (view_item_events table)
CREATE TABLE IF NOT EXISTS view_item_events AS
SELECT
  event_id AS item_view_id,
  event_time,
  user_id,
  platform,
  MAX(
    CASE
      WHEN parameter_name = 'item_id' 
      THEN CAST(parameter_value AS SIGNED)
      ELSE NULL
    END
  ) AS item_id,
  MAX(
    CASE
      WHEN parameter_name = 'referrer' 
      THEN parameter_value
      ELSE NULL
    END 
  ) AS referrer
FROM
  events
WHERE
  event_name = 'view_item'
GROUP BY
  event_id,
  event_time,
  user_id,
  platform;
  
  
-- 2. Create a subtable for recently viewed events 
	-- using the view_item_events table
SELECT
  user_id,
  item_id,
  event_time,
  ROW_NUMBER() OVER (
    PARTITION BY user_id
    ORDER BY
      event_time DESC
  ) AS view_number
FROM
  view_item_events;


-- 3. Check the join. 
	-- Join tables together recent_views, users, items
SELECT
  *
FROM
  (
    SELECT
      user_id,
      item_id,
      event_time,
      ROW_NUMBER() OVER (
        PARTITION BY user_id
        ORDER BY
          event_time DESC
      ) AS view_number
    FROM
      view_item_events
  ) recent_views
  JOIN users ON users.id = recent_views.user_id
  JOIN items ON items.id = recent_views.item_id;
  

-- 4. Clean up columns.
	-- Return all of the information we’ll need to send users an email 
	-- about the item they viewed more recently. 
	-- Make sure they are named appropriately so that another human can 
	-- read and understand their contents.
SELECT
  users.id AS user_id,
  users.email_address,
  items.id AS item_id,
  items.name AS item_name,
  items.category AS item_category
FROM
  (
    SELECT
      user_id,
      item_id,
      event_time,
      ROW_NUMBER() OVER (
        PARTITION BY user_id
        ORDER BY
          event_time DESC
      ) AS view_number
    FROM
      view_item_events
  ) recent_views
  JOIN users ON users.id = recent_views.user_id
  JOIN items ON items.id = recent_views.item_id
ORDER BY
  user_id;
  

-- 5. Consider any edge cases.
	-- If we sent an email to everyone in the results of this query, 
    -- what would we want to filter out. 
    -- Add in any extra filtering that you think would make this email better. 
    -- For example should we include deleted users? Should we send this email 
    -- to users who already ordered the item they viewed most recently? 
SELECT
  COALESCE(users.parent_user_id, users.id) AS user_id,
  users.email_address,
  items.id AS item_id,
  items.name AS item_name,
  items.category AS item_category
FROM
  (
    SELECT
      user_id,
      item_id,
      event_time,
      ROW_NUMBER() OVER (
        PARTITION BY user_id
        ORDER BY
          event_time DESC
      ) AS view_number
    FROM
      view_item_events
    WHERE
      event_time >= '2018-01-01' 
  ) recent_views
  JOIN users ON users.id = recent_views.user_id
  JOIN items ON items.id = recent_views.item_id
  LEFT JOIN orders ON orders.item_id = recent_views.item_id
  AND orders.user_id = recent_views.user_id
WHERE
  view_number = 1
  AND users.deleted_at IS NOT NULL
  AND orders.item_id IS NULL
ORDER BY
  user_id;