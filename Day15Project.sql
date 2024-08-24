create table employees (
    emp_id int PRIMARY KEY ,
    first_name text not NULL ,
    last_name text not NULL ,
    job_position text NOT NULL ,
    salary numeric (8,2),
    start_date date not null,
    birth_date date not null,
    store_id int,
    department_id int,
    manager_id int
);

create table departments (
    department_id int PRIMARY KEY ,
    department text not null,
    division text not null
);

alter table if exists employees
    alter department_id set not null,
    alter start_date set DEFAULT current_date,
    add column if not exists end_date date,
    add CONSTRAINT const_dob_check CHECK (birth_date <= current_date);

alter table if exists employees
    rename column job_position to job_title;


