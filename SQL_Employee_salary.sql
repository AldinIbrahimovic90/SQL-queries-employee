-- Create the Employee
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2)
)
-- INSERT data Employee
INSERT INTO Employee (EmployeeID, FirstName, LastName, Department, Salary)
VALUES
    (1, 'John', 'Doe', 'IT', 50000.00),
    (2, 'Jane', 'Smith', 'HR', 60000.00),
    (3, 'Bob', 'Johnson', 'Finance', 70000.00),
	(4, 'Alice', 'Johnson', 'Finance', 75000.00),
    (5, 'Charlie', 'Williams', 'IT', 55000.00)
	
	--SELECT DATA 
	SELECT * FROM Employee
	
	-- Create the SalaryHistory
CREATE TABLE SalaryHistory (
    SalaryHistoryID INT PRIMARY KEY,
    EmployeeID INT,
    Salary DECIMAL(10, 2),
    DateS DATE,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);
-- Insert  data into the Employee table
INSERT INTO SalaryHistory (SalaryHistoryID, EmployeeID, Salary, DateS)
VALUES
    (1, 1, 52000.00, '2022-02-15'),
    (2, 1, 54000.00, '2022-05-10'),
    (3, 1, 56000.00, '2022-08-20'),

	(4, 2, 65000.00, '2022-01-10'),
    (5, 2, 68000.00, '2022-04-25'),
    (6, 2, 70000.00, '2022-07-15'),

	(7, 3, 72000.00, '2022-03-05'),
    (8, 3, 75000.00, '2022-06-12'),
    (9, 3, 78000.00, '2022-09-30'),

	(10, 4, 77000.00, '2022-02-20'),
    (11, 4, 80000.00, '2022-05-15'),
    (12, 4, 82000.00, '2022-08-25'),

    (13, 5, 56000.00, '2022-01-10'),
    (14, 5, 58000.00, '2022-04-20'),
    (15, 5, 60000.00, '2022-07-30')

	-- SELECT DATA
	SELECT * FROM SalaryHistory

	--This SQL query selects employee details, including 
	--EmployeeID, FirstName, LastName, Department,
	--Salary, and DateS, utilizing a LEFT JOIN
	--between the "Employee" and
	--"SalaryHistory" tables to
	--include all employees, 
	--even those without 
	--salary change records.

SELECT
    E.EmployeeID,
    E.FirstName,
    E.LastName,
    E.Department,
    SH.Salary,
    SH.DateS
FROM
    Employee E
LEFT JOIN
    SalaryHistory SH ON E.EmployeeID = SH.EmployeeID;

	--This SQL query retrieves information about employees, 
	--including their current salary, new salary after
	--any recorded salary changes, the percentage
	--increase in salary, and the date of each
	--salary change, utilizing a left join
	--between the "Employee" and
	--"SalaryHistory" tables.

SELECT
    E.EmployeeID,
    E.FirstName,
    E.LastName,
    E.Department,
	E.Salary CurrentSalary,
    SH.Salary NewSalary,
	( SH.Salary / E.Salary  - 1) * 100 PercentageIncrease,
    SH.DateS DateOfIncrease
FROM
    Employee E
LEFT JOIN
    SalaryHistory SH ON E.EmployeeID = SH.EmployeeID;

--This SQL query employs a Common Table Expression (CTE) named "SalaryChanges"
--to compute the percentage increase in salary for each employee, considering
--their salary change history. It subsequently selects and presents
--EmployeeID, FirstName, LastName, Department, DateS (date of
--salary change), Salary, PreviousSalary (preceding salary
--before the change), and PercentageIncrease for each
--employee by joining the "Employee" table with the "SalaryChanges" CTE.

WITH SalaryChanges AS (
    SELECT
        EmployeeID,
        SalaryHistoryID,
        Salary,
        DateS,
        LAG(Salary, 1, Salary) OVER (PARTITION BY EmployeeID ORDER BY DateS) AS PreviousSalary,
        ((Salary - LAG(Salary, 1, Salary) OVER (PARTITION BY EmployeeID ORDER BY DateS)) / LAG(Salary, 1, Salary) OVER (PARTITION BY EmployeeID ORDER BY DateS)) * 100 AS PercentageIncrease
    FROM
        SalaryHistory
)

SELECT
    E.EmployeeID,
    E.FirstName,
    E.LastName,
    E.Department,
    SH.DateS,
    SH.Salary,
    SH.PreviousSalary,
    SH.PercentageIncrease
FROM
    Employee E
JOIN
    SalaryChanges SH ON E.EmployeeID = SH.EmployeeID;


