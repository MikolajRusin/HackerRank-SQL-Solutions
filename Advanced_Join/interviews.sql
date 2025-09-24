-- Total sum of all views per challenge_id
with total_sum_views AS (
    SELECT
        challenge_id,
        SUM(total_views) AS sum_v,
        SUM(total_unique_views) AS sum_uv
    FROM view_stats
    GROUP BY challenge_id
),
-- Total sum of all submissions per challenge_id
total_sum_submissions AS (
    SELECT
        challenge_id,
        SUM(total_submissions) AS sum_s,
        SUM(total_accepted_submissions) AS sum_as
    FROM submission_stats
    GROUP BY challenge_id
),
-- Total sum of all view and submissions per college_id
total_sum_college_id AS (
    SELECT
        ch.college_id,
        SUM(tss.sum_s) AS total_submissions,
        SUM(tss.sum_as) AS total_accepted_submissions,
        SUM(tsv.sum_v) AS total_views,
        SUM(tsv.sum_uv) AS total_unique_views
    FROM challenges ch
    LEFT JOIN total_sum_views tsv ON tsv.challenge_id = ch.challenge_id
    LEFT JOIN total_sum_submissions tss ON tss.challenge_id = ch.challenge_id
    GROUP BY ch.college_id
)

SELECT
    col.contest_id,
    c.hacker_id,
    c.name,
    SUM(t.total_submissions),
    SUM(t.total_accepted_submissions),
    SUM(t.total_views),
    SUM(t.total_unique_views)
FROM colleges col
LEFT JOIN contests c ON c.contest_id = col.contest_id
LEFT JOIN total_sum_college_id t ON t.college_id = col.college_id
GROUP BY 
    col.contest_id,
    c.hacker_id,
    c.name
HAVING 
    SUM(t.total_submissions) != 0
    OR SUM(t.total_accepted_submissions) != 0
    OR SUM(t.total_views) != 0
    OR SUM(t.total_unique_views) != 0
ORDER BY col.contest_id