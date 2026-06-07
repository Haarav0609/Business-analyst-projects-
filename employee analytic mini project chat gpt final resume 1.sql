CREATE TABLE e (
    id INT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    age INT,
    gender VARCHAR(10),
    dept VARCHAR(30),
    salary INT
);

insert into e( id,name,age,gender,dept,salary)
values
(1,'sumit',22,'male','hr',20000),
(2,'pravin',23,'male','hr',250000),
(3,'rajat',21,'male','sales',18000),
(4,'anil',25,'male','sales',30000),
(5,'amit',26,'male','it',40000),
(6,'rohan',27,'male','it',50000),
(7,'neha',24,'female','hr',28000),
(8,'pooja',29,'female','it',55000);

SELECT 
    *
FROM
    e;

-- question 1

SELECT 
    name
FROM
    e
WHERE
    age < 26;

SELECT 
    *
FROM
    e;

-- question 2

SELECT 
    *
FROM
    e
WHERE
    dept = 'hr' AND salary > 25000;


-- question 3

SELECT 
    name,
    salary,
    CASE
        WHEN salary < 28000 THEN 'rich'
        WHEN salary > 50000 THEN 'riche rich'
        ELSE 'poor'
    END AS salary_level
FROM
    e;

-- question 4

SELECT 
    dept, COUNT(*) AS employee_count
FROM
    e
GROUP BY dept
ORDER BY employee DESC;


-- question 5

SELECT 
    dept, AVG(SALARY) AS AVG_SALARY
FROM
    e
GROUP BY dept
HAVING AVG(SALARY) > 30000;

-- question 6

SELECT 
    *
FROM
    e
WHERE
    salary > (SELECT 
            AVG(salary)
        FROM
            e);

-- question 7

CREATE TABLE dept_info (
    dep VARCHAR(100),
    manager VARCHAR(200)
);

insert into dept_info (dep,manager)
values('hr','ramesh'),
      ('sales','suresh'),
      ('it','mahesh');
      
select*from dept_info

select *
from e
join dept_info d
on e.dept=d.dep;

-- question 8

SELECT 
    name, dept
FROM
    e
WHERE
    dept = 'hr' 
UNION SELECT 
    name, dept
FROM
    e
WHERE
    dept = 'it';



-- question 9

SELECT 
    name, salary
FROM
    e
ORDER BY salary DESC
LIMIT 3;

-- question 10

SELECT 
    dept, SUM(salary) AS total_salary
FROM
    e
GROUP BY dept
ORDER BY total_salary DESC
LIMIT 3;

SELECT 
    *
FROM
    e
