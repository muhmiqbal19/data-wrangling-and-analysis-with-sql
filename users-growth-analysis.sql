-- QUESTION: How many users do we add each day?


-- 1. Explore the data
SELECT 
  id,
  parent_user_id,
  merged_at
FROM
  users
ORDER BY
  parent_user_id;
  
  
-- 2. Without worrying about deleted user or merged users,
	-- count the number of users added each day.
SELECT
  DATE(created_at) AS day,
  COUNT(*) AS users
FROM
  users
GROUP BY
  DATE(created_at)
ORDER BY 
  DATE(created_at);


-- 3. Now, we can include merged and deleted users while counting,
	-- but, is this the right way to count merged or deleted users? 
	-- If all of our users were deleted tomorrow what would the result look like?
SELECT
  DATE(created_at) AS day,
  COUNT(*) AS users
FROM users
WHERE
  deleted_at IS NULL -- deleted users
  AND (id <> parent_user_id
    OR parent_user_id IS NULL
  ) -- merged users
GROUP BY DATE(created_at);


-- 4. Count the number of users deleted each day
SELECT
  DATE(deleted_at) AS day,
  COUNT(*) AS deleted_users
FROM
  users
WHERE 
  deleted_at IS NOT NULL
GROUP BY
  DATE(deleted_at);


-- 5. Count the number of users merged each day
SELECT 
	DATE(merged_at) AS day,
	COUNT(*) AS merged_users
FROM users
WHERE 
	id <> parent_user_id 
	AND merged_at IS NOT NULL
GROUP BY
  DATE(merged_at);
  

-- 6. Use the pieces we’ve built as subtables and 
	-- create a table that has a column for the date,
	-- the number of users created, 
    -- the number of users deleted,
    -- and the number of users merged that day
SELECT
  new.day, 
  new.new_users_added,
  deleted.deleted_users,
  merged.merged_users
FROM
  (
    SELECT 
      DATE(created_at) AS day, 
      COUNT(*) AS new_users_added
    FROM users
    GROUP BY DATE(created_at)
  ) new
  LEFT JOIN (
    SELECT 
      DATE(deleted_at) AS day, 
      COUNT(*) AS deleted_users
    FROM users
    WHERE deleted_at IS NOT NULL
    GROUP BY DATE(deleted_at)
  ) deleted ON new.day = deleted.day
  LEFT JOIN (
    SELECT 
      DATE(merged_at) AS day,
      COUNT(*) AS merged_users
    FROM users
    WHERE 
      id <> parent_user_id 
      AND merged_at IS NOT NULL
    GROUP BY DATE(merged_at)
  ) merged ON new.day = merged.day
ORDER BY new.day DESC;


-- 7. Refine the query from #6 to have informative column names 
	-- and so that null columns return 0.
SELECT
  rollup.date,
  COALESCE(new.new_users_added, 0) AS new_users_added,
  COALESCE(deleted.deleted_users, 0) AS deleted_users,
  COALESCE(merged.merged_users, 0) AS merged_users,
  (
    COALESCE(new.new_users_added, 0) - COALESCE(deleted.deleted_users, 0) 
      - COALESCE(merged.merged_users, 0)
  ) AS net_added_users
FROM (
	SELECT date
    FROM dates_rollup
  ) rollup
  LEFT JOIN (
    SELECT DATE(created_at) AS DAY, COUNT(*) AS new_users_added
    FROM users
    GROUP BY DATE(created_at)
  ) new ON rollup.date = new.day
  LEFT JOIN (
    SELECT DATE(deleted_at) AS DAY, COUNT(*) AS deleted_users
    FROM users
    WHERE deleted_at IS NOT NULL
    GROUP BY DATE(deleted_at)
  ) deleted ON rollup.date = deleted.day
  LEFT JOIN (
    SELECT DATE(merged_at) AS DAY, COUNT(*) AS merged_users
    FROM users
    WHERE id <> parent_user_id AND merged_at IS NOT NULL
    GROUP BY DATE(merged_at)
  ) merged ON rollup.date = merged.day
ORDER BY rollup.date;


