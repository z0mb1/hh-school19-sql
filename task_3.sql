SELECT area_id, low.avg_salary AS avg_low, hight.avg_salary AS avg_hight, (low.avg_salary + hight.avg_salary) / 2 AS avg_of_avg 
FROM (SELECT
    AVG(compensation_from * (1 - 0.13 * (compensation_gross = True)::int)) as avg_salary, 
    area_id
    FROM vacancy_body 
    WHERE compensation_from > 0 
    GROUP BY area_id ) AS low
JOIN
    (SELECT	
    AVG(compensation_to * (1 - 0.13 * (compensation_gross = True)::int)) as avg_salary, 
    area_id
    FROM vacancy_body 
    WHERE compensation_to > 0
	GROUP BY area_id) AS hight
USING (area_id)
ORDER BY avg_hight DESC;
