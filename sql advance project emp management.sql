/*
============================================================
SQL PROJECT - EMPLOYEE MANAGEMENT DATABASE


CREATE DATABASE IF NOT EXISTS employee_management;
USE employee_management;

DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;

CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL UNIQUE,
    location VARCHAR(50) NOT NULL
);

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    age INT,
    gender VARCHAR(10),
    salary DECIMAL(10,2) NOT NULL,
    joining_date DATE NOT NULL,
    department_id INT,
    manager_id INT NULL,
    email VARCHAR(120) UNIQUE,
    CONSTRAINT fk_employee_department
        FOREIGN KEY (department_id)
        REFERENCES Departments(department_id),
    CONSTRAINT fk_employee_manager
        FOREIGN KEY (manager_id)
        REFERENCES Employees(employee_id)
);


 PART 2: INSERT SAMPLE DATA

INSERT INTO Departments (department_id, department_name, location) VALUES
(1, 'HR', 'Mumbai'),
(2, 'IT', 'Bengaluru'),
(3, 'Sales', 'Pune'),
(4, 'Finance', 'Delhi');

INSERT INTO Employees
(employee_id, employee_name, age, gender, salary, joining_date,
 department_id, manager_id, email)
VALUES
(101, 'Asha',   35, 'Female', 50000, '2022-01-10', 1, NULL, 'asha@company.com'),
(102, 'Rohan',  40, 'Male',   65000, '2021-03-15', 2, NULL, 'rohan@company.com'),
(103, 'Neha',   29, 'Female', 55000, '2023-06-01', 1, 101,  'neha@company.com'),
(104, 'Vikram', 38, 'Male',   80000, '2020-11-20', 2, 102,  'vikram@company.com'),
(105, 'Priya',  31, 'Female', 60000, '2022-08-12', 3, 101,  'priya@company.com'),
(106, 'Arjun',  33, 'Male',   72000, '2019-04-05', 3, 105,  'arjun@company.com'),
(107, 'Meera',  27, 'Female', 45000, '2024-02-18', 4, 101,  'meera@company.com'),
(108, 'Kabir',  42, 'Male',   90000, '2018-07-09', 2, 102,  'kabir@company.com'),
(109, 'Isha',   30, 'Female', 52000, '2023-09-25', 4, 107,  'isha@company.com'),
(110, 'Dev',    36, 'Male',   58000, '2021-12-01', 3, 105,  'dev@company.com'),
(111, 'Sana',   26, 'Female', 48000, '2024-05-14', 1, 103,  'sana@company.com'),
(112, 'Omar',   39, 'Male',   75000, '2020-01-30', 4, 107,  'omar@company.com');

-- Check that the data was inserted.
SELECT * FROM Departments;
SELECT * FROM Employee

--1. Display all employee records.
-- Answer: Returns all 12 employees and every column.
SELECT * FROM Employees;

-- 2. Display only employee names and salaries.
-- Answer: Returns two columns for all 12 employees.
SELECT employee_name, salary
FROM Employees;

-- 3. Find employees earning more than 60,000.

SELECT employee_name, salary
FROM Employees
WHERE salary > 60000;

-- Q4. Find employees who work in department 1 (HR).

SELECT employee_name, department_id
FROM Employees
WHERE department_id = 1;

-- Q5. Find employees whose salary is between 50,000 and 70,000.
-- Answer: Asha, Rohan, Neha, Priya, Isha, and Dev.
SELECT employee_name, salary
FROM Employees
WHERE salary BETWEEN 50000 AND 70000;

-- Q6. Find employees who belong to HR or Finance using IN.
-- Answer: Employees in department IDs 1 and 4.
SELECT employee_name, department_id
FROM Employees
WHERE department_id IN (1, 4);

-- Q7. Find employees whose names start with 'A'.
-- Answer: Asha and Arjun.
SELECT employee_name
FROM Employees
WHERE employee_name LIKE 'A%';

-- Q8. Find employees whose email address is not missing.
-- Answer: All 12 employees have an email address.
SELECT employee_name, email
FROM Employees
WHERE email IS NOT NULL;

-- Q9. Display employees in descending order of salary.
-- Answer: Kabir appears first (90,000); Asha appears near the bottom.
SELECT employee_name, salary
FROM Employees
ORDER BY salary DESC;

-- Q10. Display the five highest-paid employees.
-- Answer: Kabir, Vikram, Omar, Arjun, and Rohan.
SELECT employee_name, salary
FROM Employees
ORDER BY salary DESC
LIMIT 5;

-- Q11. Count the total number of employees.
-- Answer: 12.
SELECT COUNT(*) AS total_employees
FROM Employees;

-- Q12. Find the minimum, maximum, and average salary.
-- Answer: Minimum = 45,000; Maximum = 90,000; Average = 62,500.
SELECT
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary,
    ROUND(AVG(salary), 2) AS average_salary
FROM Employees;

-- Q13. Find the total salary expense for the company.
-- Answer: 750,000.
SELECT SUM(salary) AS total_salary_expense
FROM Employees;

-- Q14. Count employees in each department.
-- Answer: HR = 3, IT = 3, Sales = 3, Finance = 3.
SELECT department_id, COUNT(*) AS employee_count
FROM Employees
GROUP BY department_id
ORDER BY department_id;

-- Q15. Find the average salary in each department.
-- Answer: HR = 51,000; IT = 78,333.33; Sales = 63,333.33;
-- Finance = 57,333.33.
SELECT department_id, ROUND(AVG(salary), 2) AS average_salary
FROM Employees
GROUP BY department_id;

-- Q16. Show departments whose average salary is greater than 60,000.
-- Answer: IT and Sales.
SELECT department_id, ROUND(AVG(salary), 2) AS average_salary
FROM Employees
GROUP BY department_id
HAVING AVG(salary) > 60000;

-- Q17. Use AND to find employees earning over 50,000 and younger than 35.
-- Answer: Neha, Priya, Arjun, and Isha.
SELECT employee_name, age, salary
FROM Employees
WHERE salary > 50000 AND age < 35;

-- Q18. Use OR to find employees in HR or employees earning over 85,000.
-- Answer: All HR employees plus Kabir.
SELECT employee_name, department_id, salary
FROM Employees
WHERE department_id = 1 OR salary > 85000;

-- Q19. INNER JOIN: show each employee with their department name.
-- Answer: Returns employees matched to their department.
SELECT
    e.employee_id,
    e.employee_name,
    d.department_name,
    d.location
FROM Employees AS e
INNER JOIN Departments AS d
    ON e.department_id = d.department_id
ORDER BY e.employee_id;

-- Q20. LEFT JOIN: show all departments and their employees, if any.
-- Answer: Shows every department; unmatched departments would show NULL
-- for employee columns. In this sample, each department has employees.
SELECT
    d.department_name,
    e.employee_name
FROM Departments AS d
LEFT JOIN Employees AS e
    ON d.department_id = e.department_id
ORDER BY d.department_id, e.employee_name;

-- Q21. RIGHT JOIN: show all employees and their department names.
-- Answer: Returns all employees with their matching department.
SELECT
    e.employee_name,
    d.department_name
FROM Departments AS d
RIGHT JOIN Employees AS e
    ON d.department_id = e.department_id
ORDER BY e.employee_id;

-- Q22. SELF JOIN: display each employee and their manager.
-- Answer: Employees without a manager (Asha and Rohan) show NULL.
SELECT
    e.employee_name AS employee,
    m.employee_name AS manager
FROM Employees AS e
LEFT JOIN Employees AS m
    ON e.manager_id = m.employee_id
ORDER BY e.employee_id;

-- Q23. UNION: combine names of employees earning at least 70,000
-- with names of employees aged below 28, without duplicates.
-- Answer: Returns the combined distinct list.
SELECT employee_name
FROM Employees
WHERE salary >= 70000
UNION
SELECT employee_name
FROM Employees
WHERE age < 28
ORDER BY employee_name;

-- Q24. UNION ALL: combine the same two lists, keeping duplicates.
-- Answer: Unlike UNION, UNION ALL does not remove duplicate rows.
SELECT employee_name
FROM Employees
WHERE salary >= 70000
UNION ALL
SELECT employee_name
FROM Employees
WHERE age < 28
ORDER BY employee_name;

-- Q25. Subquery: find employees earning more than the company average.
-- Answer: Employees earning more than 62,500.
SELECT employee_name, salary
FROM Employees
WHERE salary > (
    SELECT AVG(salary)
    FROM Employees
)
ORDER BY salary DESC;

-- Q26. CASE: classify employees into salary bands.
-- Answer: High = 75,000 or more; Medium = 55,000 to 74,999;
-- Low = below 55,000.
SELECT
    employee_name,
    salary,
    CASE
        WHEN salary >= 75000 THEN 'High'
        WHEN salary >= 55000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_category
FROM Employees
ORDER BY salary DESC;

-- Q27. String functions: display names in uppercase and email usernames.
-- Answer: UPPER converts names to uppercase; SUBSTRING_INDEX
-- extracts the text before @.
SELECT
    employee_name,
    UPPER(employee_name) AS uppercase_name,
    SUBSTRING_INDEX(email, '@', 1) AS email_username
FROM Employees;

-- Q28. Date functions: calculate how many years each employee has worked.
-- Answer: DATEDIFF calculates elapsed days; divide by 365.25 for
-- an approximate number of years. The result changes with the run date.
SELECT
    employee_name,
    joining_date,
    ROUND(DATEDIFF(CURDATE(), joining_date) / 365.25, 1)
        AS years_worked
FROM Employees
ORDER BY joining_date;

-- Q29. Window function: rank employees by salary from highest to lowest.
-- Answer: Highest salary gets rank 1; equal salaries would share a rank.
SELECT
    employee_name,
    salary,
    RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM Employees;

-- Q30. CTE + window function: find the highest-paid employee(s)
-- in each department.
-- Answer: Returns the top salary earner in each department.
WITH DepartmentSalary AS (
    SELECT
        e.employee_name,
        d.department_name,
        e.salary,
        DENSE_RANK() OVER (
            PARTITION BY e.department_id
            ORDER BY e.salary DESC
        ) AS salary_rank
    FROM Employees AS e
    INNER JOIN Departments AS d
        ON e.department_id = d.department_id
)
SELECT employee_name, department_name, salary
FROM DepartmentSalary
WHERE salary_rank = 1
ORDER BY department_name;

-- ============================================================
-- PART 4: OPTIONAL PRACTICE - DATA MODIFICATION
-- These examples are not counted among the 30 questions above.
-- Run them only after completing the SELECT queries.
-- ============================================================

-- UPDATE example: give employee 103 a 5% salary increase.
-- UPDATE Employees
-- SET salary = salary * 1.05
-- WHERE employee_id = 103;

-- DELETE example: delete a specific employee record.
-- DELETE FROM Employees
-- WHERE employee_id = 112;

-- ============================================================
-- END OF PROJECT
-- ============================================================
