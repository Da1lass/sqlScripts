/*
-----------------------------------------------------------------------------
Programmer’s Name: Dallas Sutton
Course: CSCI 2020 Section Number: 001
Creation Date: 11/19/2026 Date of Last Modification: 11/19/2026
E-mail Address:suttoncr@etsu.edu
-----------------------------------------------------------------------------
Purpose -
Lab 10 - Advanced SQL
-----------------------------------------------------------------------------
Identifier dictionary -
        Not Applicable
-----------------------------------------------------------------------------
Notes and Assumptions –
-----------------------------------------------------------------------------
*/

-----------------------------------------------------------------------------
-- Salary Report
SELECT 
        employee.Employee_ID AS "Employee ID",
        employee.Last_Name || ', ' || employee.First_Name AS "Name",
        jobs.Job_Title AS "Job Title",
        TO_CHAR(employee.Salary, 'FM$9,9990.00') AS "Current Salary",
        TO_CHAR(jobs.Max_Salary, 'FM$9,9990.00') AS "Maximum Salary",
        TO_CHAR((employee.Salary/jobs.Max_Salary * 100), 'FM999.99') || '%' AS "Percent of Maximum"
        FROM HR.Employees employee
        INNER JOIN HR.Jobs jobs
        ON employee.Job_ID = jobs.Job_ID;

-----------------------------------------------------------------------------
-- Employee Location Report
SELECT 
        employee.Employee_ID AS "Employee ID",
        employee.Last_Name || ', ' || employee.First_Name AS "Employee Name"
        FROM HR.Employees Employee
        JOIN HR.Departments Department
        ON employee.Department_ID = department.Department_ID
        JOIN HR.Locations Location
        ON location.Location_ID = department.Location_ID
        WHERE location.City = 'Toronto';

-----------------------------------------------------------------------------
-- Manager Discrepancy Report
SELECT
        employee.Employee_ID AS "Employee ID",
        employee.Last_Name || ', ' || employee.First_Name AS "Employee Name",
        department.Department_Name AS "Department Name",
        departmentManager.Last_Name || ', ' || departmentManager.First_Name AS "Department Manager",
        manager.Last_Name || ', ' || manager.First_Name AS "Employee Manager"
        FROM HR.Employees employee
        JOIN HR.Departments department 
        ON employee.Department_ID = department.Department_ID
        LEFT JOIN HR.Employees manager
        ON employee.Manager_ID = manager.Manager_ID
        RIGHT JOIN HR.Employees departmentManager
        ON department.Manager_ID = departmentManager.Employee_ID
        WHERE employee.Manager_ID != department.Manager_ID;

-----------------------------------------------------------------------------
-- Departments Without Employees
SELECT DISTINCT 
       department.Department_ID AS "Department ID",
       department.Department_Name AS "Department Name"
       FROM HR.Employees employee
       FULL OUTER JOIN HR.Departments department 
       ON employee.Department_ID = department.Department_ID
       WHERE employee.department_id IS NULL OR department.department_id IS NULL;

-----------------------------------------------------------------------------
-- European Employee Report
SELECT 
        employee.Employee_ID AS "Employee ID",
        employee.Last_Name || ', ' || employee.First_Name AS "Employee Name",
        country.Country_Name AS "Country Name",
        region.Region_Name AS "Region Name"
        FROM HR.Employees employee
        JOIN HR.Departments department
        ON employee.Department_ID = department.Department_ID
        JOIN HR.Countries location
        ON department.Location_ID = location.Location_ID
        JOIN HR.Countries country 
        ON country.Country_ID = location.Country_ID
        JOIN HR.Regions region
        ON region.Region_ID = country.Region_ID
        WHERE region.Region_Name = 1;