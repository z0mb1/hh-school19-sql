INSERT INTO vacancy (creation_time, employer_id, disabled, visible, area_id, expire_time)
SELECT *,
-- expire_time >= creation_time
creation_time + (random() * 365 * 24 * 3600 * 10) * '1 second'::interval AS expire_time
FROM (
SELECT
    -- random in last 10 years
    now()-(random() * 365 * 24 * 3600 * 10) * '1 second'::interval AS creation_time,
    (random() * 1000000)::int AS employer_id,
    (random() > 0.5) AS disabled,
    (random() > 0.5) AS visible,
    (random() * 1000)::int AS area_id
FROM generate_series(1, 10000) AS g(i)) as created;


INSERT INTO vacancy_body(
    company_name, name, text, area_id, address_id, work_experience,
    compensation_from, compensation_to, compensation_gross
)
SELECT
    (SELECT substr(repeat(md5((random() * i)::text), 5), 0, (random()*(140)+10)::int)) AS company_name,
    (SELECT substr(repeat(md5((random() * i)::text), 7), 0, (random()*(210)+10)::int)) AS name,
    (SELECT substr(repeat(md5((random() * i)::text), 7), 0, (random()*(210)+10)::int)) AS text,
    (random() * 1000)::int AS area_id,
    (random() * 50000)::int AS address_id,
    (random()*20)::int AS work_experience,
    (random()> 0.2)::int * (25000 + (random() * 75000)::int) AS compensation_from,
    (random()> 0.2)::int * (100000 + (random() * 75000)::int) AS compensation_to,
    (random() > 0.5) AS compensation_gross
FROM generate_series(1, 10000) AS g(i);


INSERT INTO resume(
    user_id, area_id, text, creation_time
)
SELECT
    (random() * 1000)::int AS user_id,
    (random() * 1000)::int AS area_id,
    (SELECT substr(repeat(md5((random() * i)::text), 7), 0, (random()*(210)+10)::int)) AS text,
    now()-(random() * 365 * 24 * 3600 * 10) * '1 second'::interval AS creation_time
FROM generate_series(1, 100000) AS g(i);


INSERT INTO responses(resume_id, vacancy_id, response_time)
SELECT
    (SELECT (FLOOR(random()*100000)+1)::integer) AS resume_id,
    response_vacancy_id AS vacancy_id,
    (SELECT vacancy.creation_time + (random() * 7 * 24 * 3600 * 10) * '1 second'::interval
     from vacancy
     WHERE vacancy.vacancy_id = response_vacancy_id
    ) AS response_time
FROM
    (SELECT (FLOOR(random()*10000)+1)::integer AS response_vacancy_id
    FROM generate_series(1, 50000) AS i) AS response;

