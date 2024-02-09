--1. total score of the stories:
SELECT SUM(score)
FROM hacker_news;

--2. find the individual users who have gotten combined scores of more than 200, and their combined scores.
SELECT user, SUM(score) AS 'sum_scores'
FROM hacker_news
GROUP BY 1
 HAVING sum_scores > 200
 ORDER BY sum_scores DESC;

--3. add these users´scores together and divide by the total to get the percentage:
SELECT (517 + 309 + 304 + 282) / 6366.0 AS 'average';

--4. how many times each user posted the following link
SELECT user, COUNT(*) AS 'posted'
FROM hacker_news
WHERE url LIKE '%https://www.youtube.com/watch?v=dQw4w9WgXcQ%'
GROUP BY user
-ORDER BY posted DESC;

--5. Which of these sites feed Hacker News the most:
SELECT CASE
  WHEN url LIKE '%github.com%' THEN 'Github'
  WHEN url LIKE '%medium.com%' THEN 'Medium'
  WHEN url LIKE '%nytimes.com%' THEN 'New York Times'
  ELSE 'Other'
END AS 'Source',
COUNT(*)
FROM hacker_news
GROUP BY 1;

--6. Wich hour is the best to post a story
SELECT strftime('%H', timestamp) AS 'hour', ROUND(AVG(score), 2) AS 'average_score', COUNT(*) AS 'count'
FROM hacker_news
WHERE hour IS NOT NULL
GROUP BY 1
ORDER BY 3 DESC;
