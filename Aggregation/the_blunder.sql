WITH samantha_mistakes AS (
    SELECT
        REPLACE(salary, '0', '') AS miscalculated_salary
    FROM employees
 )
 
 SELECT
    CEIL(AVG(e.salary) - AVG(sm.miscalculated_salary))
FROM employees e, samantha_mistakes sm
