/*To practice what you’ve learned about window functions, you are going to use climate data from each state in the United States. 
A labeled map of the United States can be found here.
These data will show the average annual temperature for each state – this is the average temperature of every day in all parts of the state for that year.
For this project, you will be working with one table:
state_climate*/

-- Queries:

-- 2. how the average temperature changes over time in each state.
SELECT state,
year,
tempc,
AVG(tempc) OVER (
  PARTITION BY state
  ORDER BY year
) AS 'running_avg_temperature'
FROM state_climate; 

-- 3. the lowest temperatures for each state.
SELECT state,
year,
tempc,
FIRST_VALUE(tempc) OVER (
  PARTITION BY state
  ORDER BY tempc
) 'lowest_temp'
FROM state_climate;

-- 4. Are the highest recorded temps for each state more recent or more historic
SELECT state,
year,
tempc,
LAST_VALUE(tempc) OVER (
  PARTITION BY state
  ORDER BY year DESC
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) 'highest_temp'
FROM state_climate;

-- 5. how temperature has changed each year in each state
SELECT state,
year,
tempc,
tempc - LAG (tempc, 1, tempc) OVER (
  PARTITION BY state
  ORDER BY year
) 'change_in_temp'
FROM state_climate
ORDER BY change_in_temp DESC;

-- 6. return a rank of the coldest temperatures on record along with year, state, and tempf or tempc.
SELECT state,
year,
tempc,
ROW_NUMBER() OVER (
  ORDER BY tempc ASC
) 'coldest_rank'
FROM state_climate;

-- 7.
SELECT state,
year,
tempc,
ROW_NUMBER() OVER (
  ORDER BY tempc DESC
) 'warmest_rank'
FROM state_climate;*/

-- 8. return the average yearly temperatures in quartiles
SELECT state,
year,
tempc,
NTILE(4) OVER (
  PARTITION BY state
  ORDER BY tempc ASC
) 'quartile'
FROM state_climate
ORDER BY tempc ASC;*/

-- 9. return the average yearly temperatures in quintiles (5)
SELECT state,
year,
tempc,
NTILE(5) OVER (
  ORDER BY tempc ASC
) 'quintile'
FROM state_climate;
