SELECT
    SUM(population)
FROM city
WHERE countrycode = 'JPN'

--------------------------------------2nd solution--------------------------------------

WITH country_population AS (
    SELECT
        countrycode AS code,
        SUM(population) AS total_pop
    FROM city
    GROUP BY code
)

SELECT
    total_pop
FROM country_population
WHERE code = 'JPN'
