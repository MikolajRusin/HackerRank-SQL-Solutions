SELECT
    ROUND(lat_n, 4)
FROM (
        SELECT
            lat_n,
            PERCENT_RANK() OVER (ORDER BY lat_n ASC) AS percent_r
        FROM station
) AS percent_ranked
WHERE percent_r = 0.5
