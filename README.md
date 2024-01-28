# SQL-queries-employee

These SQL queries involve creating a Common Table Expression (CTE) named "SalaryChanges" 
to calculate the percentage increase in salary for each employee, considering their
salary change history. The subsequent SELECT query retrieves and displays
comprehensive details, including EmployeeID, FirstName, LastName,
Department, DateS (date of salary change), Salary, PreviousSalary
(preceding salary before the change), and PercentageIncrease.
This is achieved by joining the "Employee" table with the
"SalaryChanges" CTE, providing a comprehensive overview
of salary changes for each employee.
