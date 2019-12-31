SELECT *
FROM  (SELECT EXTRACT(MONTH FROM creation_time) AS most_popular_vacancy
    FROM vacancy
    GROUP BY (EXTRACT(MONTH FROM creation_time))
    ORDER BY COUNT(*) DESC LIMIT 1
 ) AS vacancy_month,
(
    SELECT EXTRACT(MONTH FROM creation_time) AS most_popula_resume
    FROM resume
    GROUP BY (EXTRACT(MONTH FROM creation_time))
    ORDER BY COUNT(*) DESC LIMIT 1
) as resume_month;
