WITH students_salary AS (
    SELECT
        s.id AS s_id,
        s.name AS s_name,
        p.salary AS s_salary
    FROM students s
    LEFT JOIN packages p ON p.id = s.id
),
friend_salary AS (
    SELECT
        f.id s_id,
        p.salary AS f_salary
    FROM friends f
    LEFT JOIN packages p ON p.id = f.friend_id
)

SELECT
    s_name
FROM students_salary
LEFT JOIN friend_salary ON friend_salary.s_id = students_salary.s_id
WHERE students_salary.s_salary < friend_salary.f_salary
ORDER BY friend_salary.f_salary ASC