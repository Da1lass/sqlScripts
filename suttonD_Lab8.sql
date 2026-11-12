/*
-----------------------------------------------------------------------------
Programmer’s Name: Dallas Sutton
Course: CSCI 2020 Section Number: 001
Creation Date: 11/9/2026 Date of Last Modification: 11/9/2026
E-mail Address:suttoncr@etsu.edu
-----------------------------------------------------------------------------
Purpose -
Lab 8 - Introduction to SQL P2
-----------------------------------------------------------------------------
Identifier dictionary -
        Not Applicable
-----------------------------------------------------------------------------
Notes and Assumptions –
-----------------------------------------------------------------------------
*/

-----------------------------------------------------------------------------
-- A1. Select Department Table
SELECT * FROM ALLPOWDER.Department;

-----------------------------------------------------------------------------
-- A2. Select Employee Table
-- wants LASTNAME, FIRSTNAME, and DEPARTMENT of employee table
SELECT LASTNAME, FIRSTNAME, DEPARTMENT FROM ALLPOWDER.Employee;

-----------------------------------------------------------------------------
-- A3a. Select Customer Table for Alan
SELECT LASTNAME, FIRSTNAME, EMAIL FROM ALLPOWDER.CUSTOMER
    WHERE FIRSTNAME = 'Alan';

-----------------------------------------------------------------------------
-- A3b. Select Customer Table for Sarah
SELECT LASTNAME, FIRSTNAME, EMAIL FROM ALLPOWDER.CUSTOMER
    WHERE FIRSTNAME = 'Sarah';

-----------------------------------------------------------------------------
-- A3c. Select Customer Table for McCoys
SELECT LASTNAME, FIRSTNAME, EMAIL FROM ALLPOWDER.CUSTOMER
    WHERE LASTNAME = 'McCoy';

-----------------------------------------------------------------------------
-- A4a. Select Employees in Boards Dept.
SELECT FIRSTNAME, LASTNAME FROM ALLPOWDER.Employee
    WHERE DEPARTMENT = 'Boards';

-----------------------------------------------------------------------------
-- A4b. Select Employees in Ski Departments
SELECT FIRSTNAME, LASTNAME FROM ALLPOWDER.Employee
    WHERE DEPARTMENT = 'Ski-Alpine' OR DEPARTMENT = 'Ski-Nordic';

-----------------------------------------------------------------------------
-- A4c. Select Employees in both Ski Departments
SELECT FIRSTNAME, LASTNAME FROM ALLPOWDER.Employee
    WHERE DEPARTMENT = 'Ski-Alpine' AND DEPARTMENT = 'Ski-Nordic';

-----------------------------------------------------------------------------
-- A5a. Shipping Cities
SELECT ShipCity, ShipState, ShipZip FROM ALLPOWDER.Sale;

-----------------------------------------------------------------------------
-- A5b. Shipping Cities without Duplicates.


-----------------------------------------------------------------------------
-- A5c. Number of Shipping Duplicates: ###


-----------------------------------------------------------------------------
-- A6a. Number of Rentals: ###


-----------------------------------------------------------------------------
-- A6b. Number of Rentals by Payment Type


-----------------------------------------------------------------------------
-- A6c. TotalAmount of Sales: $###,###.##


-----------------------------------------------------------------------------
-- A6d. Average Sale Price: $###,###.##


-----------------------------------------------------------------------------
-- A6e. Average Sales Tax Per Payment Type


-----------------------------------------------------------------------------
-- B1. Copy the Employee Table


-----------------------------------------------------------------------------
-- B2. Copy the Department Table


-----------------------------------------------------------------------------
-- C1. Insert to the Employee Table


-----------------------------------------------------------------------------
-- C2. Update the Employee Table
