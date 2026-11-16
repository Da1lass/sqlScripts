/*
-----------------------------------------------------------------------------
Programmer’s Name: Dallas Sutton
Course: CSCI 2020 Section Number: 001
Creation Date: 11/12/2026 Date of Last Modification: 11/12/2026
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
