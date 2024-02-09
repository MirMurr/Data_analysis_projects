/* Codecademy Virtual Reality (CVR), Inc. is the latest startup on the VR scene. 
As head of the Project Completion team, you have been given a list of upcoming projects needing to be delivered. 
Your main responsibility is to analyze our current talent pool to ensure each project can be completed efficiently and effectively.
Each project needs a Project Manager, Team Lead, Designer, Database Administrator (DBA), and at least two Developers. There are 2 tables employees and projects*/

SELECT * 
FROM employees;

SELECT * 
FROM projects;

-- 3. names of employees who have not chosen a project
SELECT first_name, last_name
FROM employees
WHERE current_project IS NULL;

-- 4. names of projects that were not chosen by any employees
SELECT projects.project_name
FROM projects
LEFT JOIN employees
  ON projects.project_id = employees.current_project
WHERE employee_id IS NULL;

-- another way to solve 4. - NOT IN: 
SELECT project_name 
FROM projects
WHERE project_id NOT IN (
   SELECT current_project
   FROM employees
   WHERE current_project IS NOT NULL);

-- 5. name of the most popular projects
SELECT projects.project_name, COUNT(project_name)
FROM projects
INNER JOIN employees
  ON projects.project_id = employees.current_project
GROUP BY projects.project_name
ORDER BY 2 DESC
LIMIT 1;

-- 6. which projects were chosen by multiple employees
SELECT projects.project_name
FROM projects
INNER JOIN employees
  ON projects.project_id = employees.current_project
WHERE current_project IS NOT NULL
GROUP BY current_project
  HAVING COUNT(current_project) > 1;


-- 7. each project needs at least 2 devs, do we have enough devs to fill in the positions?
SELECT (COUNT(*) * 2) - (
  SELECT COUNT(*)
  FROM employees
  WHERE current_project IS NOT NULL
    AND position = 'Developer') AS 'Count'
FROM projects;

-- 9. most common personality
SELECT personality, COUNT(personality)
FROM employees
GROUP BY personality
ORDER BY COUNT(personality) DESC
LIMIT 1;

-- 10. names of projects chosen by employees with the most common personality type
SELECT project_name, 
personality
FROM projects
INNER JOIN employees
  ON projects.project_id = employees.current_project
WHERE personality = (
  SELECT personality
  FROM employees
  GROUP BY personality
  ORDER BY COUNT(personality) DESC
  LIMIT 1);

-- 11. the most common personality type in project FistsOfFury 
SELECT first_name,
last_name,
personality,
project_name
FROM employees
JOIN projects
  ON projects.project_id = employees.current_project
WHERE personality = (
  SELECT personality
  FROM employees
  WHERE current_project IS NOT NULL
    AND current_project = 'FistsOfFury'
  GROUP BY personality
  ORDER BY COUNT(personality) DESC
  LIMIT 1);

-- 12. incompatible personalities
SELECT 
    first_name,
    last_name,
    personality,
    project_name,
    CASE
        WHEN personality = 'INFP' THEN (
            SELECT COUNT(*)
            FROM employees
            WHERE personality IN ('ISFP', 'ESFP', 'ISTP', 'ESTP', 'ISFJ', 'ESFJ', 'ISTJ', 'ESTJ')
        )
        WHEN personality = 'ENFP' THEN (
            SELECT COUNT(*)
            FROM employees
            WHERE personality IN ('ISFP', 'ESFP', 'ISTP', 'ESTP', 'ISFJ', 'ESFJ', 'ISTJ', 'ESTJ')
        )
        WHEN personality = 'INFJ' THEN (
            SELECT COUNT(*)
            FROM employees
            WHERE personality IN ('ISFP', 'ESFP', 'ISTP', 'ESTP', 'ISFJ', 'ESFJ', 'ISTJ', 'ESTJ')
        )
        WHEN personality = 'ENFJ' THEN (
            SELECT COUNT(*)
            FROM employees
            WHERE personality IN ('ESFP', 'ISTP', 'ESTP', 'ISFJ', 'ESFJ', 'ISTJ', 'ESTJ')
        )
        WHEN personality = 'ISFP' THEN (
            SELECT COUNT(*)
            FROM employees
            WHERE personality IN ('INFP', 'ENFP', 'INFJ')
        )
        WHEN personality = 'ESFP' THEN (
            SELECT COUNT(*)
            FROM employees
            WHERE personality IN ('INFP', 'ENFP', 'INFJ', 'ENFJ')
        )
        WHEN personality = 'ISTP' THEN (
            SELECT COUNT(*)
            FROM employees
            WHERE personality IN ('INFP', 'ENFP', 'INFJ', 'ENFJ')
        )
        WHEN personality = 'ESTP' THEN (
            SELECT COUNT(*)
            FROM employees
            WHERE personality IN ('INFP', 'ENFP', 'INFJ', 'ENFJ')
        )
        WHEN personality = 'ISFJ' THEN (
            SELECT COUNT(*)
            FROM employees
            WHERE personality IN ('INFP', 'ENFP', 'INFJ', 'ENFJ')
        )
        WHEN personality = 'ESFJ' THEN (
            SELECT COUNT(*)
            FROM employees
            WHERE personality IN ('INFP', 'ENFP', 'INFJ', 'ENFJ')
        )
        WHEN personality = 'ISTJ' THEN (
            SELECT COUNT(*)
            FROM employees
            WHERE personality IN ('INFP', 'ENFP', 'INFJ', 'ENFJ')
        )
        WHEN personality = 'ESTJ' THEN (
            SELECT COUNT(*)
            FROM employees
            WHERE personality IN ('INFP', 'ENFP', 'INFJ', 'ENFJ')
        )
        ELSE 0
    END AS 'INCOMPATS'
FROM 
    employees
LEFT JOIN 
    projects ON employees.current_project = projects.project_id;
