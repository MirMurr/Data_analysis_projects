--2. How many art pieces are there
SELECT COUNT(*)
FROM met;

--3. Count the number of pieces where the category includes 'celery'
SELECT COUNT(*)
FROM met
WHERE category LIKE '%celery%';

--4. Title and medium of the oldest piece(s) in the collection
SELECT MIN(date), title, medium
FROM met;

--5. Find the top 10 countries with the most pieces in the collection. not American
SELECT country, COUNT(*) AS 'number_of_art'
FROM met
GROUP BY country
ORDER BY 2 DESC
LIMIT 10;

--6. American decorative art categories HAVING more than 100 pieces
SELECT category, COUNT(*) AS 'num_of_art', country
FROM met
GROUP BY 1
HAVING num_of_art > 100
  AND country = 'United States';

--7. the number of pieces where the medium contains ‘gold’ or ‘silver’
SELECT medium, COUNT(*) AS 'no_of_pieces'
FROM met
WHERE medium LIKE '%gold%'
  OR medium LIKE '%silver%'
GROUP BY 1
ORDER BY no_of_pieces DESC;


