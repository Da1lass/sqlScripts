/*
-----------------------------------------------------------------------------
Programmer’s Name: Dallas Sutton
Course: CSCI 2020 Section Number: 001
Creation Date: 11/12/2026 Date of Last Modification: 11/19/2026
E-mail Address:suttoncr@etsu.edu
-----------------------------------------------------------------------------
Purpose -
Lab 9 - Advanced SQL
-----------------------------------------------------------------------------
Identifier dictionary -
        Not Applicable
-----------------------------------------------------------------------------
Notes and Assumptions –
-----------------------------------------------------------------------------
*/

-----------------------------------------------------------------------------
-- A1. Employees from 650 Area Code
SELECT * FROM HR.Employees
    WHERE PHONE_NUMBER LIKE '650%';

-----------------------------------------------------------------------------
-- A2. Employees with 501 in the phone number
SELECT * FROM HR.Employees
    WHERE PHONE_NUMBER LIKE '%501%';

-----------------------------------------------------------------------------
-- A3. Employees with 76 at the end of the phone number
SELECT * FROM HR.Employees
    WHERE PHONE_NUMBER LIKE '%76';

-----------------------------------------------------------------------------
-- A4. Employees phone number in the format ###.###.####
SELECT * FROM HR.Employees
    WHERE PHONE_NUMBER LIKE '___.___.____';

-----------------------------------------------------------------------------
-- A5. Employees phone number in the format ###.###.####
SELECT * FROM HR.Employees
    WHERE REGEXP_LIKE (PHONE_NUMBER, '^[0-9]{3}\.[0-9]{3}\.[0-9]{4}$');

-----------------------------------------------------------------------------
-- A6. Employees phone number in the format ###.##.####.######
SELECT * FROM HR.Employees
    WHERE REGEXP_LIKE (PHONE_NUMBER, 
                        '^[0-9]{3}\.[0-9]{2}\.[0-9]{4}\.[0-9]{5}');

-----------------------------------------------------------------------------
-- B1. Employees Last and first names
-- SELECT CONCAT(CONCAT(FIRST_NAME, ' '), LAST_NAME) FROM HR.Employees;
SELECT FIRST_NAME || ' ' || LAST_NAME FROM HR.Employees;

-----------------------------------------------------------------------------
-- B2. Special Employee IDs in the format ZZ-###
-- SELECT CONCAT('ZZ-', TO_CHAR(EMPLOYEE_ID)) FROM HR.Employees;
SELECT 'ZZ-' || TO_CHAR(EMPLOYEE_ID) FROM HR.Employees;

-----------------------------------------------------------------------------
-- B3. Department names surrounded by asterisks
SELECT LPAD(RPAD(DEPARTMENT_NAME, (LENGTH(DEPARTMENT_NAME)+1), '*'), (LENGTH(DEPARTMENT_NAME)+2), '*') FROM HR.Departments;

-----------------------------------------------------------------------------
-- B4. Formatted Location Addresses
-- SELECT STREET_ADDRESS, CITY, STATE_PROVINCE, POSTAL_CODE, COUNTRY_ID FROM HR.Locations;
SELECT TO_CHAR(STREET_ADDRESS)|| CHR(13) 
    || '     ' || TO_CHAR(CITY) || ' ' || TO_CHAR(STATE_PROVINCE) || ' ' || TO_CHAR(POSTAL_CODE) || ' ' || TO_CHAR(COUNTRY_ID) 
    AS FormmattedAddress FROM HR.Locations;

-----------------------------------------------------------------------------
-- B5. Formatted Dates
SELECT 
    TO_CHAR(SYSDATE, 'MMDDYYYY') COL1,
    TO_CHAR(SYSDATE, 'MON-YYYY') COL2,
    TO_CHAR(SYSDATE, 'YYYY/MM/DD') COL3,
    TO_CHAR(SYSDATE, 'MON DD, YYYY') COL4,
    TO_CHAR(SYSDATE, 'DAY, MON DD, YYYY') COL5,
    TO_CHAR(SYSDATE, 'MON DD, YYYY, HH:MI:SS AM') COL6
    FROM dual;

-----------------------------------------------------------------------------
-- C1. Simple Join of Employees and Departments
SELECT
    employee.Employee_ID, employee.Last_Name, employee.First_Name, department.Department_Name FROM HR.Employees Employee
    INNER JOIN HR.Departments Department
        ON employee.Department_ID = department.Department_ID;

-----------------------------------------------------------------------------
-- C2. Select with two joins, including a self-join
SELECT
    employee.Employee_ID, employee.Last_Name, employee.First_Name, department.Department_Name, 
    manager.First_Name AS ManagerFirstName, manager.Last_Name AS ManagerLastName FROM HR.Employees Employee
    INNER JOIN HR.Departments Department
        ON employee.Department_ID = department.Department_ID
    INNER JOIN HR.Employees Manager
        ON employee.Manager_ID = manager.Employee_ID;

-----------------------------------------------------------------------------
-- C3. Cross Join Example
SELECT COUNT(*) AS EmployeeCount FROM HR.Employees;

SELECT COUNT(*) AS DepartmentCount FROM HR.Departments;

SELECT (SELECT COUNT(*) FROM HR.Employees) * (SELECT COUNT(*) FROM HR.Departments) AS ProductCount FROM dual;

SELECT * FROM HR.Employees
    CROSS JOIN HR.Departments;

-----------------------------------------------------------------------------
--C4. Cross Join as Inner Join Example
SELECT * FROM HR.Employees
    CROSS JOIN HR.Departments
    WHERE HR.Employees.Department_ID = HR.Departments.Department_ID

/*
Number of Records Returned: 106
How does this compare and why? it removes any records from the output that have a null department id
*/