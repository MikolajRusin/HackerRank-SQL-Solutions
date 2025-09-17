WITH hackers_max_score AS (
    SELECT  
        s.hacker_id,
        s.score
    FROM submissions s
    LEFT JOIN challenges ch ON ch.challenge_id = s.challenge_id
    LEFT JOIN difficulty d ON d.difficulty_level = ch.difficulty_level
    WHERE s.score = d.score
)

SELECT
    hms.hacker_id,
    h.name
FROM hackers_max_score hms
LEFT JOIN hackers h ON h.hacker_id = hms.hacker_id
GROUP BY hms.hacker_id, h.name
HAVING COUNT(*) >= 2
ORDER BY COUNT(*) DESC, hms.hacker_id ASC