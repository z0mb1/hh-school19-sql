CREATE TABLE vacancy_body (
    vacancy_body_id serial PRIMARY KEY,
    company_name varchar(150) DEFAULT ''::varchar NOT NULL,
    name varchar(220) DEFAULT ''::varchar NOT NULL,
    text text,
    area_id integer,
    address_id integer,
    work_experience integer DEFAULT 0 NOT NULL,
    compensation_from bigint DEFAULT 0,
    compensation_to bigint DEFAULT 0,
    compensation_gross boolean,
    test_solution_required boolean DEFAULT false NOT NULL,
    work_schedule_type integer DEFAULT 0 NOT NULL,
    employment_type integer DEFAULT 0 NOT NULL
);

CREATE TABLE vacancy (
    vacancy_id serial PRIMARY KEY,
    creation_time timestamp NOT NULL,
    expire_time timestamp NOT NULL,
    employer_id integer DEFAULT 0 NOT NULL,
    disabled boolean DEFAULT false NOT NULL,
    visible boolean DEFAULT true NOT NULL,
    vacancy_body_id integer,
    area_id integer,
    FOREIGN KEY (vacancy_body_id) REFERENCES vacancy_body (vacancy_body_id)
);

CREATE TABLE resume(
    resume_id serial PRIMARY KEY,
    user_id  integer,
    area_id integer,
    text text,
    creation_time timestamp NOT NULL,
    channged_at timestamp DEFAULT NULL,
    active boolean DEFAULT true not NULL,
    previous_id integer DEFAULT null
);

CREATE TABLE responses (
    resume_id integer REFERENCES resume(resume_id),
    vacancy_id integer REFERENCES vacancy(vacancy_id),
    response_time   timestamp NOT NULL
);
