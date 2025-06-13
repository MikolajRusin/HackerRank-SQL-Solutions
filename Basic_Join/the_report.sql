(
    SELECT
        s.name AS s_name,
        g.grade AS s_grade,
        s.marks AS s_mark
    FROM students s
    LEFT JOIN grades g ON s.marks BETWEEN g.min_mark and g.max_mark
    WHERE g.grade > 7
)
UNION ALL
(
    SELECT
        NULL AS s_name,
        g.grade AS s_grade,
        s.marks AS s_mark
    FROM students s
    LEFT JOIN grades g ON s.marks BETWEEN g.min_mark and g.max_mark
    WHERE g.grade <= 7
)
ORDER BY s_grade DESC, s_name ASC, s_mark ASC

--------------------------------------2nd solution--------------------------------------

SELECT
    CASE 
        WHEN g.grade > 7 THEN s.name
        ELSE NULL
    END AS name,
    g.grade,
    s.marks
FROM students s
LEFT JOIN grades g ON s.marks BETWEEN g.min_mark AND g.max_mark
ORDER BY 
    g.grade DESC,
    CASE 
        WHEN g.grade > 7 THEN s.name
    END ASC,
    CASE 
        WHEN g.grade <= 7 THEN s.marks
    END ASC