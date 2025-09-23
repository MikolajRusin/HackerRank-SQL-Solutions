WITH ddiff AS (
    SELECT
        start_date,
        end_date,
        LAG(end_date) OVER (ORDER BY end_date) AS lagged_day,
        DATEDIFF(start_date, LAG(end_date) OVER (ORDER BY end_date)) AS date_diff
    FROM projects
)

SELECT
    start_date AS start_project,
    COALESCE(LEAD(lagged_day) OVER (ORDER BY end_date), DATE_ADD(start_date, INTERVAL 1 DAY)) AS end_project
FROM ddiff
WHERE date_diff is NULL OR date_diff != 0
ORDER BY DATEDIFF(
    start_date,
    COALESCE(LEAD(lagged_day) OVER (ORDER BY end_date), DATE_ADD(start_date, INTERVAL 1 DAY))
) DESC,
start_date ASC