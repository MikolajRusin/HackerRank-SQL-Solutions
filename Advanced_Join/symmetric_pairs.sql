WITH cte1 AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY x) AS id,
        *
    FROM functions
)

SELECT DISTINCT
    f1.x,
    f1.y
FROM cte1 f1
JOIN cte1 f2 ON 
    f2.y = f1.x 
    AND f2.x = f1.y
WHERE 
    f1.id != f2.id 
    AND f1.x <= f1.y
ORDER BY f1.x