(
    SELECT
        city,
        LENGTH(city)
    FROM station
    ORDER BY LENGTH(city) ASC, city ASC
    LIMIT 1
)
UNION
(
    SELECT
        city,
        LENGTH(city)
    FROM station
    ORDER BY LENGTH(city) DESC, city DESC
    LIMIT 1
)

--------------------------------------2nd solution--------------------------------------

WITH ranked_cities AS(
    SELECT
        city,
        LENGTH(city) AS len_city,
        ROW_NUMBER() OVER(ORDER BY LENGTH(city) ASC, city ASC) AS rn_shortest,
        ROW_NUMBER() OVER(ORDER BY LENGTH(city) DESC, city ASC) AS rn_longest
    FROM station
)
SELECT
    city,
    len_city
FROM ranked_cities
WHERE rn_shortest = 1 OR rn_longest = 1
