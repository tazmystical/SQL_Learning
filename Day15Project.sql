/*
 This is the SQL script for the Udemy SQL course.
 Going to use this script to also practice some git and github commands.
 */

--Task 1.1
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

--task 1.2
create table departments (
    department_id int PRIMARY KEY ,
    department text not null,
    division text not null
);

--task 2
alter table if exists employees
    alter department_id set not null,
    alter start_date set DEFAULT current_date,
    add column if not exists end_date date,
    add CONSTRAINT const_dob_check CHECK (birth_date <= current_date);

alter table if exists employees
    rename column job_position to job_title;


--task 3.1
insert into employees values
(1,'Morrie','Conaboy','CTO',21268.94,'2005-04-30','1983-07-10',1,1,NULL,NULL),
(2,'Miller','McQuarter','Head of BI',14614.00,'2019-07-23','1978-11-09',1,1,1,NULL),
(3,'Christalle','McKenny','Head of Sales',12587.00,'1999-02-05','1973-01-09',2,3,1,NULL),
(4,'Sumner','Seares','SQL Analyst',9515.00,'2006-05-31','1976-08-03',2,1,6,NULL),
(5,'Romain','Hacard','BI Consultant',7107.00,'2012-09-24','1984-07-14',1,1,6,NULL),
(6,'Ely','Luscombe','Team Lead Analytics',12564.00,'2002-06-12','1974-08-01',1,1,2,NULL),
(7,'Clywd','Filyashin','Senior SQL Analyst',10510.00,'2010-04-05','1989-07-23',2,1,2,NULL),
(8,'Christopher','Blague','SQL Analyst',9428.00,'2007-09-30','1990-12-07',2,2,6,NULL),
(9,'Roddie','Izen','Software Engineer',4937.00,'2019-03-22','2008-08-30',1,4,6,NULL),
(10,'Ammamaria','Izhak','Customer Support',2355.00,'2005-03-17','1974-07-27',2,5,3,'2013-04-14'),
(11,'Carlyn','Stripp','Customer Support',3060.00,'2013-09-06','1981-09-05',1,5,3,NULL),
(12,'Reuben','McRorie','Software Engineer',7119.00,'1995-12-31','1958-08-15',1,5,6,NULL),
(13,'Gates','Raison','Marketing Specialist',3910.00,'2013-07-18','1986-06-24',1,3,3,NULL),
(14,'Jordanna','Raitt','Marketing Specialist',5844.00,'2011-10-23','1993-03-16',2,3,3,NULL),
(15,'Guendolen','Motton','BI Consultant',8330.00,'2011-01-10','1980-10-22',2,3,6,NULL),
(16,'Doria','Turbat','Senior SQL Analyst',9278.00,'2010-08-15','1983-01-11',1,1,6,NULL),
(17,'Cort','Bewlie','Project Manager',5463.00,'2013-05-26','1986-10-05',1,5,3,NULL),
(18,'Margarita','Eaden','SQL Analyst',5977.00,'2014-09-24','1978-10-08',2,1,6,'2020-03-16'),
(19,'Hetty','Kingaby','SQL Analyst',7541.00,'2009-08-17','1999-04-25',1,2,6,NULL),
(20,'Lief','Robardley','SQL Analyst',8981.00,'2002-10-23','1971-01-25',2,3,6,'2016-07-01'),
(21,'Zaneta','Carlozzi','Working Student',1525.00,'2006-08-29','1995-04-16',1,3,6,'2012-02-19'),
(22,'Giana','Matz','Working Student',1036.00,'2016-03-18','1987-09-25',1,3,6,NULL),
(23,'Hamil','Evershed','Web Developper',3088.00,'2022-02-03','2012-03-30',1,4,2,NULL),
(24,'Lowe','Diamant','Web Developper',6418.00,'2018-12-31','2002-09-07',1,4,2,NULL),
(25,'Jack','Franklin','SQL Analyst',6771.00,'2013-05-18','2005-10-04',1,2,2,NULL),
(26,'Jessica','Brown','SQL Analyst',8566.00,'2003-10-23','1965-01-29',1,1,2,NULL);

select * from employees;

--task 3.2
insert into departments values
                            (1,'Analytics','IT'),
                            (2,'Finance','Administration'),
                            (3,'Sales','Sales'),
                            (4,'Website','IT'),
                            (5,'Back Office','Administration')
                            ;

select * from departments;

--task 4.1
select * from employees
where first_name = 'Jack' and last_name = 'Franklin';

update employees set salary = 7200, job_title = 'Senior SQL Analyst'
where first_name = 'Jack' and last_name = 'Franklin'
RETURNING *;

--task 4.2
select * from employees where job_title = 'Customer Support';

update employees set job_title = 'Customer Specialist'
where job_title = 'Customer Support'
returning *;

--task 4.3
select * from employees where job_title like '%SQL Analyst%';

update employees set salary = salary * 1.06
where job_title like '%SQL Analyst%'
returning *;

--task 4.4
select round(Avg(salary),2) from employees where job_title = 'SQL Analyst';

select job_title, round(Avg(salary),2) as avg_salary
from employees e
where job_title like '%SQL%'
group by job_title ;


--task 5.1
--Write a query that shows each employee's Manager Full name as a single column named Manager.
--Then modify the query to include a column that shows their employment status as Active or Inactive.
SELECT e.*,
       m.first_name || ' ' || m.last_name AS Manager,
       CASE
           WHEN e.end_date IS NULL THEN 'true'
           ELSE 'false'
           END                            AS is_active
FROM employees e
         FULL JOIN employees m ON e.manager_id = m.emp_id;


--5.2 create a view from 5.1
CREATE VIEW v_employees_info AS
(
SELECT e.*,
       m.first_name || ' ' || m.last_name AS Manager,
       CASE
           WHEN e.end_date IS NULL THEN 'true'
           ELSE 'false'
           END                            AS is_active
FROM employees e
         FULL JOIN employees m ON e.manager_id = m.emp_id
    )

--Task 6
-- write a query with average salaries per position. Please round.
Select e.job_title, round(Avg(e.salary),2) as Avg_Salary from employees e
group by e.job_title
order by e.job_title asc;

--Task 7
--write a query that returns salary avg per division
select d.department, round(avg(e.salary),2) from departments d
left join employees e on d.department_id = e.department_id
group by d.department;

--task 8.1
--write a query that returns emp id, f nmae, l name, title, salary and avg salary per title. order by emp id
with cte_salary_info as (SELECT e.emp_id,
                                e.first_name,
                                e.last_name,
                                e.job_title,
                                e.salary,
                                ROUND(AVG(e.salary) OVER (PARTITION BY e.job_title), 2) AS avg_salary
                         FROM employees e
                         ORDER BY e.emp_id)

--task 8.2
-- how many people earn less than their positions avg salary?
select count(*) from cte_salary_info
where avg_salary > salary;
