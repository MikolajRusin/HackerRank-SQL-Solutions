-- Select cheapest wands for combination (power, age)
with min_coins_power_age AS (
    SELECT
        wp.age AS age,
        MIN(w.coins_needed) AS min_coins,
        w.power AS power
    FROM wands w 
    LEFT JOIN wands_property wp ON wp.code = w.code
    WHERE wp.is_evil = 0
    GROUP BY w.power, wp.age
)

SELECT
    w.id,
    wp.age,
    w.coins_needed,
    w.power
FROM wands w 
LEFT JOIN wands_property wp ON wp.code = w.code
JOIN (
    SELECT
        *
    FROM min_coins_power_age      
) mcpa 
    ON mcpa.min_coins = w.coins_needed 
    AND mcpa.power = w.power
    AND mcpa.age = wp.age
ORDER BY 
    w.power DESC, 
    wp.age DESC