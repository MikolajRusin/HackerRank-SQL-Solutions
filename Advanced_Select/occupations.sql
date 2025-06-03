SELECT
    MAX(CASE WHEN occupation = 'Doctor' THEN name ELSE NULL END) AS doctor,
    MAX(CASE WHEN occupation = 'Professor' THEN name ELSE NULL END) AS professor,
    MAX(CASE WHEN occupation = 'Singer' THEN name ELSE NULL END) AS singer,
    MAX(CASE WHEN occupation = 'Actor' THEN name ELSE NULL END) AS actor
FROM (
    SELECT
        name,
        occupation,
        ROW_NUMBER() OVER(PARTITION BY occupation ORDER BY name ASC) AS rn
    FROM occupations
) AS partitioned_occupation
GROUP BY rn
