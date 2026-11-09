/*
-----------------------------------------------------------------------------
Programmer’s Name: Dallas Sutton
Course: CSCI 2020 Section Number: 001
Creation Date: 11/9/2026 Date of Last Modification: 11/9/2026
E-mail Address:suttoncr@etsu.edu
----------------------------------------------------------------------------
Purpose -
Lab 8 - Introduction to SQL P2
-----------------------------------------------------------------------------
Identifier dictionary -
        Not Applicable
-----------------------------------------------------------------------------
Notes and Assumptions –
-----------------------------------------------------------------------------
*/

------------------------------
-- A1. Select Department Table
SELECT * FROM ALLPOWDER.Department;

------------------------------
-- A2. Select Employee Table
-- wants LASTNAME, FIRSTNAME, and DEPARTMENT of employee table
SELECT LASTNAME, FIRSTNAME, DEPARTMENT FROM ALLPOWDER.Employee;

--------------------------------------
-- A3a. Select Customer Table for Alan
SELECT LASTNAME, FIRSTNAME, EMAIL FROM ALLPOWDER.CUSTOMER
    WHERE FIRSTNAME = 'Alan';

--------------------------------------
-- A3b. Select Customer Table for Sarah
SELECT LASTNAME, FIRSTNAME, EMAIL FROM ALLPOWDER.CUSTOMER
    WHERE FIRSTNAME = 'Sarah';

----------------------------------------
-- A3c. Select Customer Table for McCoys
SELECT LASTNAME, FIRSTNAME, EMAIL FROM ALLPOWDER.CUSTOMER
    WHERE LASTNAME = 'McCoy';