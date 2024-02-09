-- 1. If each dollar sign ($) represents $10, how could you find all places that cost $20 or less?
SELECT name, address, average_rating, price_point, type
FROM places
WHERE price_point = '$'
  OR price_point = '$$'
ORDER BY price_point ASC;

-- 2. Write a query to do an INNER JOIN on the two tables to show all reviews for restaurants that have at least one review.
SELECT places.name, places.average_rating, reviews.username, reviews.rating, reviews.review_date, reviews.note
FROM places
INNER JOIN reviews
  ON places.id = reviews.place_id
WHERE places.type = 'Restaurant';

-- 3. In this case INNER JOIN is more useful cause if we use LEFT JOIN then the rows with no reviews will be displayed too. In INNER JOIN only those rows will be displayed which match the ON condition.
SELECT places.name, places.average_rating, reviews.username, reviews.rating, reviews.review_date, reviews.note
FROM places
LEFT JOIN reviews
  ON places.id = reviews.place_id
WHERE places.type = 'Restaurant';

-- 4. places without reviews
SELECT places.id, places.name
FROM places
LEFT JOIN reviews
  ON places.id = reviews.place_id
WHERE reviews.review_date IS NULL;

-- 5. all the reviews from 2020
WITH reviews_2020 AS (
  SELECT *
  FROM reviews
  WHERE strftime("%Y", review_date) = "2020"
  ORDER BY review_date DESC
)

SELECT places.name, places.type, places.price_point, reviews_2020.rating, reviews_2020.review_date
FROM places
JOIN reviews_2020
  ON places.id = reviews_2020.place_id;

-- 6. the reviever with the most reviews that are below average
SELECT ROUND(AVG(rating), 2)
FROM reviews;

SELECT username, ROUND(AVG(rating), 2) AS 'average_rating', COUNT(rating) AS 'number_of_ratings'
FROM reviews
GROUP BY username
HAVING  average_rating < 3.34
ORDER BY 3 DESC
LIMIT 3;

