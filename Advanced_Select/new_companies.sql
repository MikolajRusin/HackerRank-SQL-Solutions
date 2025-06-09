SELECT
    c.company_code,
    c.founder,
    COUNT(DISTINCT lm.lead_manager_code) as total_num_lead_man,
    COUNT(DISTINCT sm.senior_manager_code) as total_num_senior_man,
    COUNT(DISTINCT m.manager_code) as total_num_man,
    COUNT(DISTINCT e.employee_code) as total_num_empl
FROM company AS c
INNER JOIN lead_manager lm ON lm.company_code = c.company_code
INNER JOIN senior_manager sm ON sm.lead_manager_code = lm.lead_manager_code
INNER JOIN manager m ON m.senior_manager_code = sm.senior_manager_code
INNER JOIN employee e ON e.manager_code = m.manager_code
GROUP BY c.company_code, c.founder
ORDER BY c.company_code ASC
