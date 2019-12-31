SELECT responce_vacancies.name
FROM (SELECT name, count(responses) AS frequency
      FROM (vacancy JOIN vacancy_body ON vacancy.vacancy_id = vacancy_body.vacancy_body_id)
      LEFT JOIN responses USING (vacancy_id)
        WHERE (response_time - creation_time) < '1 week'::interval OR
               responses IS NULL
        GROUP BY vacancy_id, name) AS responce_vacancies
WHERE frequency < 5
ORDER BY name;
