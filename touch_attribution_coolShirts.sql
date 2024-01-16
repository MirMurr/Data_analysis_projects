- 1. How many campaigns and sources does CoolTShirts use? Which source is used for each campaign?
SELECT COUNT(DISTINCT utm_campaign)
FROM page_visits;
-- How many campaigns: 8

SELECT COUNT(DISTINCT utm_source)
FROM page_visits;
-- how many utm_sources: 6

-- how they are related:
SELECT DISTINCT utm_campaign, utm_source
FROM page_visits;

-- 2. What pages are on the CoolTShirts website?
SELECT DISTINCT page_name
FROM page_visits;
-- landing page, shopping cart, checkout, purchase

-- 3. How many first touches is each campaign responsible for?
WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT ft.user_id,
    ft.first_touch_at,
    pv.utm_source,
		pv.utm_campaign,
    COUNT(utm_campaign)
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
GROUP BY utm_campaign
ORDER BY utm_campaign DESC;

-- 4. How many last touches is each campaign responsible for?
  -- 1.creating a last_touch temporary table
WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
  -- 2. selecting the actual columns which we want to display in our new table (lt - abbreviation fot last_touch)
SELECT lt.user_id,
    lt.last_touch_at,
    pv.utm_source,
		pv.utm_campaign,
    COUNT(utm_campaign)
FROM last_touch lt
-- 3. join the page visits table, important to join it on user_id AND on timestamp and last_touch_at
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY utm_campaign
ORDER BY utm_campaign DESC;
  

-- 5. how many visitors make a purchase?
SELECT COUNT(DISTINCT user_id) AS 'user_made_purchase'
FROM page_visits
WHERE page_name = '4 - purchase';


-- 6. how many last touches are on the purchase page
WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    WHERE page_name = '4 - purchase'
    GROUP BY user_id)
SELECT lt.user_id,
    lt.last_touch_at,
    pv.utm_source,
		pv.utm_campaign,
    COUNT(utm_campaign)
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY utm_campaign
ORDER BY COUNT(utm_campaign) DESC;
