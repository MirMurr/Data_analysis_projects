/*Suppose you are a Data Analyst at Lyft, a ride-sharing platform. For a project, you were given three tables:

trips: trips information
riders: user data
cars: autonomous cars
*/

-- 1. combine riders with car models, not so useful.
SELECT *
FROM riders
CROSS JOIN cars;

-- 2. join the trips and riders tables
SELECT *
FROM trips
LEFT JOIN riders
  ON trips.rider_id = riders.id;

-- 3. join trips and cars
SELECT *
FROM trips
INNER JOIN cars
  ON trips.car_id = cars.id;

-- 4. stack the riders table on top of the new table named riders2
SELECT *
FROM riders
UNION
SELECT *
FROM riders2;

-- 5. AVG cost of a trip per model
SELECT cars.model, ROUND(AVG(cost), 2) AS 'average_cost_of_trip'
FROM trips
JOIN cars
  ON trips.car_id = cars.id
GROUP BY cars.model;

-- 6. Find all the riders who have used Lyft less than 500 times!
SELECT *
FROM riders
WHERE total_trips < 500;

-- 7. Calculate the number of cars that are active.
SELECT COUNT(*)
FROM cars
WHERE status = 'active';

-- 10. Write a query that finds the two cars that have the highest trips_completed.
SELECT *
FROM cars
ORDER BY trips_completed DESC
LIMIT 2;
