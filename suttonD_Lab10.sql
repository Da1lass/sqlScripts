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
        FROM HR.Employees employee
        RIGHT JOIN HR.Job_History jobHistory 
        ON employee.Employee_ID = jobHistory.EMployee_ID
        WHERE jobHistory.Department_ID = 20;