SELECT
    ROUND(SUM(lat_n), 2) AS lat,
    ROUND(SUM(long_w), 2) AS lon
FROM station