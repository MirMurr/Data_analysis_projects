 -- 1.
 SELECT *
 FROM survey
 GROUP BY question
 LIMIT 10;

-- Quiz Funnel
 -- 2. number of responses for each questions
 SELECT question, 
  COUNT(response) AS 'number_of_responses'
 FROM survey
 GROUP BY 1
 ORDER BY 1;
-- 2. explanation: there are 500 users who started to fill out this survey. From 500 users 475 moved on to the 2. question, 380 users moved to the 3., 361 users moved on to the 4. question and only 270 users moved on to the 5. question.

-- another solution to 2, mine is the same results
 SELECT question, 
  COUNT(DISTINCT user_id) AS 'number_of_responses'
 FROM survey
 GROUP BY 1
 ORDER BY 1;


-- The data is distributed across 3 tables:
SELECT *
FROM quiz
LIMIT 5;

SELECT *
FROM home_try_on
LIMIT 5;

SELECT *
FROM purchase
LIMIT 5;

-- 5.
SELECT DISTINCT quiz.user_id,
  home_try_on.user_id IS NOT NULL AS 'is_home_try_on',
  home_try_on.number_of_pairs,
  purchase.user_id IS NOT NULL AS 'is_purchase'
FROM quiz
LEFT JOIN home_try_on
  ON quiz.user_id = home_try_on.user_id
LEFT JOIN purchase
  ON purchase.user_id = quiz.user_id
WHERE is_home_try_on > 0
LIMIT 10;

-- 6. 
-- overall conversion rates
-- how many users completed the quiz - all questions?
SELECT COUNT(DISTINCT user_id) AS 'number_of_users_completed_quiz'
FROM quiz;

-- how many users made purchase, who strted the quiz:
SELECT COUNT(DISTINCT quiz.user_id) AS 'number_of_users_made_purchase' 
FROM quiz
JOIN purchase
  ON quiz.user_id = purchase.user_id;

-- 6. analyze these based on Q5: overall conversion rates
-- home try on users:
SELECT COUNT(DISTINCT home_try_on.user_id) AS 'number_of_all_users_home_try_on'
FROM home_try_on;

-- how many users made purchase after home_try_on:
SELECT COUNT(DISTINCT home_try_on.user_id) AS 'number_of_purchases_home_try_on'
FROM home_try_on
JOIN purchase
  ON home_try_on.user_id = purchase.user_id;
-- from 750 home try on users 495 users purchased at least one item.


-- purchase rate between difference between number_of_pairs 3 and number_of pairs 5:
  -- 3 pairs:
SELECT COUNT(DISTINCT home_try_on.user_id) AS 'number_of_users_home_try_on_3_pairs'
FROM home_try_on
JOIN purchase
  ON home_try_on.user_id = purchase.user_id
WHERE home_try_on.number_of_pairs = '3 pairs';
  -- 201 users purchased an item after receiving 3 pairs of glasses to try on.

  -- 5 pairs:
SELECT COUNT(DISTINCT home_try_on.user_id) AS 'number_of_users_home_try_on_5_pairs'
FROM home_try_on
JOIN purchase
  ON home_try_on.user_id = purchase.user_id
WHERE home_try_on.number_of_pairs = '5 pairs';
  -- 295 users purchased an item after receiving 5 pairs of glasses to try on. This is X % more than the users who got 3 pairs of glasses.


  -- compare conversion from quiz - home try on; home try on - purchase:
  SELECT COUNT(DISTINCT quiz.user_id) AS 'completed_quiz'
  --home_try_on.user_id IS NOT NULL AS 'is_try'
  FROM quiz
  LEFT JOIN home_try_on
    ON quiz.user_id = home_try_on.user_id
  --WHERE is_try != 0;
  WHERE home_try_on.user_id IS NOT NULL;


  -- most common results of style qiuz:
  SELECT style, 
  COUNT(style) AS 'number_of_styles'
  FROM quiz
  GROUP BY style
  ORDER BY 2 DESC;
  --Women´s Styles are the most common in the quiz.

  -- most common types of purchase
  SELECT model_name, COUNT(DISTINCT user_id) AS 'number_of_model_bought', style
  FROM purchase
  GROUP BY 1
  ORDER BY 2 DESC;


-- most popular model in women´s styles:
SELECT style, 
model_name,
COUNT(DISTINCT user_id) AS 'number_of_items_sold', 
price
FROM purchase 
WHERE style = 'Women''s Styles'
GROUP BY 2
ORDER BY 3 DESC;
--Eugene Narrow is the most commonly bought model in Women´s styles, 116 item´s were sold from this model. This model costs 95$, which isn´t the most expensive model in Women´s styles.


--the most expensive model:
SELECT style, 
model_name,
COUNT(DISTINCT user_id) AS 'number_of_items_sold', 
price
FROM purchase 
WHERE style = 'Women''s Styles'
GROUP BY 2
ORDER BY 4 DESC;


-- most popular model in men´s style:
SELECT style, 
model_name,
COUNT(DISTINCT user_id) AS 'number_of_items_sold',
price
FROM purchase 
WHERE style = 'Men''s Styles'
GROUP BY 2
ORDER BY 3 DESC;
--Dawes is the most commonly bought model in Men´s styles, 107 item´s were sold from this model. This model costs 150$. This is the most expensive model in Men´s styles.


--AVG Price Where style Women´s styles:
  SELECT style,
  ROUND(AVG(price), 2) AS 'average_style_price'
  FROM purchase
  GROUP BY style
  ORDER BY 1 DESC;
  --On average Women´s style is slightly more expensive than the Men´s style.
