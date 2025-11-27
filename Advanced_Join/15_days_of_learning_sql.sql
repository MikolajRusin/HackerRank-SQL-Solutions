-- Set the start date of the contest
DECLARE @start_date AS DATETIME2 = '2016-03-01';

WITH
    -- Number of submissions per hacker per day
    hacker_n_sub_day AS (
        SELECT
            submission_date,
            hacker_id,
            COUNT(hacker_id) AS n_sub_day
        FROM 
            submissions
        GROUP BY 
            submission_date, hacker_id
    ),
    -- Hacker with maximum number of submissions per day
    hacker_max_sub_day AS (
        SELECT
            submission_date,
            hacker_id
        FROM (
            -- Daily ranking of hackers with the maximum number of submissions and the minimum hacker ID
            SELECT
                submission_date,
                hacker_id,
                ROW_NUMBER() OVER(PARTITION BY submission_date ORDER BY n_sub_day DESC, hacker_id ASC) AS sub_rnk
            FROM 
                hacker_n_sub_day
        ) t1
        -- Select only those with ranking = 1
        WHERE 
            sub_rnk = 1
    ),
    -- All submissions per day for hackers who keep a daily strike
    n_sub_per_day AS (
        SELECT
            submission_date,
            COUNT(hacker_id) AS n_sub
        FROM (
            -- For each hacker define running sum of submissions from the start date to the end date
            SELECT
                submission_date,
                hacker_id,
                ROW_NUMBER() OVER(PARTITION BY hacker_id ORDER BY submission_date) as run_n_sub
            FROM 
                hacker_n_sub_day
        ) t2
        -- Select only those with the strike started from the start date
        WHERE 
            (run_n_sub - 1) = DATEDIFF(day, @start_date, submission_date)
        GROUP BY 
            submission_date
    )
    
-- Join all data
SELECT
    t1.submission_date,
    t1.n_sub,
    t2.hacker_id,
    t3.name
FROM 
    n_sub_per_day t1
LEFT JOIN 
    hacker_max_sub_day t2 ON t1.submission_date = t2.submission_date
LEFT JOIN 
    hackers t3 ON t2.hacker_id = t3.hacker_id
ORDER BY 
    t1.submission_date