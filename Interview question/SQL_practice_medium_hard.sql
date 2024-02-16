--create database database_10;
use database_10;


/*
Subquery and Aggregation:
Retrieve the names of departments that have more than twice the average salary of all employees in each department.

Window Functions:
Rank employees within each department based on their salary, and retrieve the top three highest-paid employees in each department.

Recursive Queries:
Implement a recursive query to generate a list of all employees who directly or indirectly report to a given manager.

Complex Joins:
Retrieve the names of employees who work in all departments of a company with more than five departments.


*/


---1. Employee Hierarchy:
--Find the hirarchy of the employees.


CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(255),
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);


INSERT INTO employees (employee_id, employee_name, manager_id)
VALUES (1, 'John Doe', NULL),
       (2, 'Jane Smith', 1),
       (3, 'Alice Johnson', 1),
       (4, 'Bob Brown', 2);


-- Solution


select 
e1.employee_id as [manager id], 
e1.employee_name as [employee name], 
e2.employee_id as [employee id], 
e2.employee_name as [employee name] 
from employees as e1
inner join employees as e2
on e1.employee_id = e2.manager_id


drop table employees;



---2. Subquery and Aggregation:
--Retrieve the names of departments that have more than twice the average salary of all employees in each department.

-- Create departments table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(255)
);

-- Create employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(255),
    department_id INT,
    salary DECIMAL(10, 2),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Insert departments
INSERT INTO departments (department_id, department_name)
VALUES (1, 'Sales'),
       (2, 'Marketing'),
       (3, 'Engineering');

-- Insert employees
INSERT INTO employees (employee_id, employee_name, department_id, salary)
VALUES (1, 'John Doe', 1, 50000.00),
       (2, 'Jane Smith', 1, 55000.00),
       (3, 'Alice Johnson', 2, 60000.00),
       (4, 'Bob Brown', 2, 65000.00),
       (5, 'Charlie Wilson', 3, 70000.00),
       (6, 'David Lee', 3, 75000.00),
       (7, 'Emily White', 3, 80000.00),
       (8, 'Frank Harris', 3, 85000.00),
       (9, 'Grace Miller', 3, 90000.00),
       (10, 'Henry Taylor', 3, 95000.00),
       (11, 'Isabella Martinez', 3, 100000.00),
       (12, 'Jack Anderson', 3, 105000.00),
       (13, 'Karen Thomas', 3, 110000.00),
       (14, 'Liam Wilson', 3, 115000.00),
       (15, 'Mia Garcia', 3, 120000.00);


--Solutions



SELECT d1.department_id, d1.department_name, AVG(e1.salary) as avg_salary
FROM employees AS e1
LEFT JOIN departments AS d1 
ON d1.department_id = e1.department_id
GROUP BY d1.department_id, d1.department_name
HAVING AVG(e1.salary) > (SELECT AVG(salary) * 2 FROM employees);


drop table departments;
drop table employees;




---3. Window Functions:
--Rank employees within each department based on their salary, and retrieve the top three highest-paid employees in each department.


-- Create departments table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(255)
);

-- Create employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(255),
    department_id INT,
    salary DECIMAL(10, 2),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Insert departments
INSERT INTO departments (department_id, department_name)
VALUES (1, 'Sales'),
       (2, 'Marketing'),
       (3, 'Engineering');

-- Insert employees
INSERT INTO employees (employee_id, employee_name, department_id, salary)
VALUES (1, 'John Doe', 1, 60000.00),
       (2, 'Jane Smith', 1, 65000.00),
       (3, 'Alice Johnson', 1, 70000.00),
       (4, 'Bob Brown', 2, 70000.00),
       (5, 'Charlie Wilson', 2, 75000.00),
       (6, 'David Lee', 2, 80000.00),
       (7, 'Emily White', 3, 80000.00),
       (8, 'Frank Harris', 3, 85000.00),
       (9, 'Grace Miller', 3, 90000.00),
       (10, 'Henry Taylor', 3, 95000.00),
       (11, 'Isabella Martinez', 3, 100000.00),
       (12, 'Jack Anderson', 3, 105000.00),
       (13, 'Karen Thomas', 3, 110000.00),
       (14, 'Liam Wilson', 3, 115000.00),
       (15, 'Mia Garcia', 3, 120000.00),
       (16, 'Nathan Clark', 1, 65000.00),
       (17, 'Olivia Moore', 1, 68000.00),
       (18, 'Peter Taylor', 1, 72000.00),
       (19, 'Rachel Brown', 2, 76000.00),
       (20, 'Samuel Wilson', 2, 78000.00);


-- Solution


with cte as 
(select e1.department_id, e1.employee_id, e1.employee_name
, rank() over(partition by e1.department_id order by e1.salary desc) as rank_ 
from employees as e1)
select * from cte
where rank_ <= 3


drop table employees;
drop table departments;


---4. Recursive Queries:
--Implement a recursive query to generate a list of all employees who directly or indirectly report to a given manager.

-- Create employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(255),
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

-- Insert employees
INSERT INTO employees (employee_id, employee_name, manager_id)
VALUES (1, 'John Doe', NULL),
       (2, 'Jane Smith', 1),
       (3, 'Alice Johnson', 1),
       (4, 'Bob Brown', 2),
       (5, 'Charlie Wilson', 2),
       (6, 'David Lee', 3),
       (7, 'Emily White', 3),
       (8, 'Frank Harris', 4),
       (9, 'Grace Miller', 4),
       (10, 'Henry Taylor', 5),
       (11, 'Isabella Martinez', 5),
       (12, 'Jack Anderson', 6),
       (13, 'Karen Thomas', 6),
       (14, 'Liam Wilson', 7),
       (15, 'Mia Garcia', 7);




--Approach-1
-- To get all the chains :
SELECT concat( t1.employee_name, ' -> ',t2.employee_name, ' -> ',t3.employee_name, ' -> ',t4.employee_name) AS [Chains]
FROM employees t1 
LEFT JOIN employees t2 ON t1.Manager_id=t2.Employee_id
LEFT JOIN employees t3 ON t2.Manager_id=t3.Employee_id
LEFT JOIN employees t4 ON t3.Manager_id=t4.Employee_id
ORDER BY len(concat(t1.employee_name, ' -> ',t2.employee_name, ' -> ',t3.employee_name, ' -> ',t4.employee_name)) DESC;
GO

--Approach-2

WITH RecursiveHierarchy AS (
    SELECT employee_id, employee_name, Manager_id, 0 AS Level
    FROM Employees
    WHERE Manager_id IS NULL
    UNION ALL
    SELECT e.employee_id, e.employee_name, e.Manager_id, rh.Level + 1
    FROM Employees e
    JOIN RecursiveHierarchy rh ON e.Manager_id = rh.employee_id
)
SELECT * FROM RecursiveHierarchy;


drop table employees



--Complex Joins:
-- 5. Retrieve the names of employees who work in all departments of a company with more than five departments.



-- Table for Employees
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100)
);

-- Table for Departments
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

-- Linking table to represent the relationship between employees and departments
CREATE TABLE employee_department (
    employee_id INT,
    department_id INT,
    PRIMARY KEY (employee_id, department_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Sample data insertion for demonstration
INSERT INTO employees (employee_id, employee_name) VALUES
(1, 'John'),
(2, 'Jane'),
(3, 'Mike'),
(4, 'Emily'),
(5, 'Chris');

INSERT INTO departments (department_id, department_name) VALUES
(1, 'Marketing'),
(2, 'Finance'),
(3, 'Human Resources'),
(4, 'IT'),
(5, 'Operations'),
(6, 'Sales'),
(7, 'Research');

-- Sample data for employee_department table
-- John works in all departments
INSERT INTO employee_department (employee_id, department_id) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7);
-- Jane works in Marketing, Finance, and Human Resources
INSERT INTO employee_department (employee_id, department_id) VALUES
(2, 1), (2, 2), (2, 3);
-- Mike works in IT and Operations
INSERT INTO employee_department (employee_id, department_id) VALUES
(3, 4), (3, 5);
-- Emily works in Sales and Research
INSERT INTO employee_department (employee_id, department_id) VALUES
(4, 6), (4, 7);
-- Chris works in Marketing, Finance, and Sales
INSERT INTO employee_department (employee_id, department_id) VALUES
(5, 1), (5, 2), (5, 6);




select 
e.employee_id, e.employee_name 
from employee_department ed
left join departments d
on ed.department_id = d.department_id
left join employees e
on e.employee_id = ed.employee_id
group by e.employee_id, e.employee_name
having count(d.department_id) = (select count(*) from departments)





















