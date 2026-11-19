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
        Jobs.Job_Title AS "Job Title",
        TO_CHAR(employee.Salary, 'FM$9,9990.00') AS "Current Salary",
        TO_CHAR(Jobs.Max_Salary, 'FM$9,9990.00') AS "Maximum Salary",
        TO_CHAR((employee.Salary/jobs.Max_Salary * 100), 'FM999.99') || '%' AS "Percent of Maximum"
        FROM HR.Employees Employee
        INNER JOIN HR.Jobs Jobs
        ON employee.Job_ID = jobs.Job_ID;