SELECT
    h.hacker_id,
    h.name,
    COUNT(ch.challenge_id) AS total_challenges
FROM hackers h
LEFT JOIN challenges ch ON ch.hacker_id = h.hacker_id
GROUP BY h.hacker_id, h.name
HAVING COUNT(ch.challenge_id) = (
    SELECT
        MAX(cnt)
    FROM (
        SELECT
            COUNT(ch.challenge_id) AS cnt
        FROM challenges ch
        GROUP BY ch.hacker_id
    ) n_challenges
)
OR COUNT(ch.challenge_id) IN (
    SELECT
        total_challenges
    FROM (
        SELECT
            COUNT(ch.challenge_id) AS total_challenges
        FROM challenges ch
        GROUP BY ch.hacker_id
    ) n_challenges
    GROUP BY total_challenges
    HAVING COUNT(total_challenges) = 1
)
ORDER BY total_challenges DESC, h.hacker_id