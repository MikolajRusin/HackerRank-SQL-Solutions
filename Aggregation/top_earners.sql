SELECT
    MAX(months*salary),
    COUNT(*)
FROM employee
WHERE months*salary = (SELECT MAX(months*salary) FROM employee)

--------------------------------------2nd solution--------------------------------------

WITH salaries AS (
    SELECT
        (months * salary) AS tot_salary
    FROM employee
)

SELECT
    tot_salary,
    COUNT(*)
FROM salaries
GROUP BY tot_salary
HAVING tot_salary = (SELECT MAX(tot_salary) FROM salaries)