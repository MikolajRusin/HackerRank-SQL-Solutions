SELECT
    ROUND(SUM(lat_n), 4)
FROM station
WHERE lat_n > 38.788 AND lat_n < 137.2345

--------------------------------------2nd solution--------------------------------------

SELECT
    ROUND(SUM(lat_n), 4)
FROM station
WHERE lat_n BETWEEN 38.7879 AND 137.23449
