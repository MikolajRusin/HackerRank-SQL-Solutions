WITH student_ch_max_score AS (
    SELECT
        s.hacker_id,
        h.name,
        MAX(s.score) AS max_score
    FROM submissions s
    LEFT JOIN hackers h ON h.hacker_id = s.hacker_id
    GROUP BY s.hacker_id, h.name, s.challenge_id 
)
SELECT
    ms.hacker_id,
    ms.name,
    SUM(ms.max_score) AS total_score
FROM student_ch_max_score ms
GROUP BY ms.hacker_id, ms.name
HAVING SUM(ms.max_score) != 0
ORDER BY total_score DESC, ms.hacker_id ASC