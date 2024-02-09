/* CodeCademy project - Multiple Tables with Reddit
For this project, you’ll be working as a Data Analyst who will be examining some fictional data from Reddit, a social news aggregation, content rating site.

On Reddit, users can create posts with content such as text, media, and links to other websites. Users can post content to different communities known as subreddits, which focus on a particular topic. Users can then rate others’ content by upvoting or downvoting them, and each post will show its total cumulative score.

For this task you were given three tables:

users: users data
posts: posts information
subreddits: information about subreddits*/

-- Queries:

-- 1. number of subreddits
SELECT COUNT(*) AS 'subreddit_count'
FROM subreddits;

-- 4. user with highest score
SELECT username, MAX(score)
FROM users;

-- 5. post with highest score
SELECT title, MAX(score)
FROM posts;

-- 6. top 5 subreddits with highest subscriber count
SELECT name, subscriber_count
FROM subreddits
ORDER BY 2 DESC
LIMIT 5;

-- 7. How many posts each user has made
SELECT users.username, COUNT(posts.title) AS 'number_of_posts'
FROM users
LEFT JOIN posts
  ON users.id = posts.user_id
GROUP BY users.username;

-- 8. most popular subreddits > 5000 score - subreddites.name, posts.score, posts.subreddit_id
WITH popular_posts AS (
  SELECT *
  FROM posts
  WHERE score >= 5000
)

SELECT subreddits.name, popular_posts.title, popular_posts.score
FROM subreddits
INNER JOIN popular_posts
  ON subreddits.id = popular_posts.subreddit_id
ORDER BY popular_posts.score DESC;

-- 9. highest scoring post for each subreddit
SELECT posts.title, MAX(posts.score) AS 'subreddit_score', subreddits.name AS 'subreddit_name'
FROM posts
INNER JOIN subreddits
  ON posts.subreddit_id = subreddits.id
GROUP BY 3
ORDER BY 2 DESC;

-- 10. average score of all the posts for each subreddits
SELECT subreddits.id, subreddits.name, ROUND(AVG(posts.score))
FROM subreddits
INNER JOIN posts
  ON subreddits.id = posts.subreddit_id
GROUP BY 1
ORDER BY 1 DESC;
