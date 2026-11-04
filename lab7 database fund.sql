/*
-----------------------------------------------------------------------------
Programmer’s Name: Dallas Sutton
Course: CSCI 2020 Section Number: 001
Creation Date: 11/2/2026 Date of Last Modification: 11/3/2026
E-mail Address:suttoncr@etsu.edu
----------------------------------------------------------------------------
Purpose -
Lab 7 - Introduction to SQL
-----------------------------------------------------------------------------
Identifier dictionary -
        Not Applicable
-----------------------------------------------------------------------------
Notes and Assumptions –
-----------------------------------------------------------------------------
*/

-- 1.1: Create Building Table
DROP TABLE building;
CREATE TABLE building (
    BuildingID NUMBER(3) NOT NULL,
    BuildingName VARCHAR2(30) NOT NULL,
    Street VARCHAR2(50),
    City VARCHAR2(50),
    State VARCHAR2(2)
);

-- 1.2: Select Building Table
SELECT * FROM building;

-- 1.3a: ALTER the Building Table to add a primary key
ALTER TABLE building
    ADD (CONSTRAINT PK_Building PRIMARY KEY (BuildingID));

-- 1.3b: DROP and RECREATE the Employee Table to add a primary key
DROP TABLE building;
CREATE TABLE building (
    BuildingID NUMBER(3) NOT NULL,
    BuildingName VARCHAR2(30) NOT NULL,
    Street VARCHAR2(50),
    City VARCHAR2(50),
    State VARCHAR2(2),
    CONSTRAINT PK_Building PRIMARY KEY (BuildingID)
);

-- 1.4a: ALTER Building Table to Add the ZIP column
ALTER TABLE building
    ADD Zipcode NUMBER(5);

-- 1.4b: DROP and RECREATE the Building Table with a New Column
DROP TABLE building;
CREATE TABLE building (
    BuildingID NUMBER(3) NOT NULL,
    BuildingName VARCHAR2(30) NOT NULL,
    Street VARCHAR2(50),
    City VARCHAR2(50),
    State VARCHAR2(2),
    Zipcode NUMBER(5),
    CONSTRAINT PK_Building PRIMARY KEY (BuildingID) 
);
/* 1.5: Why use ALTER instead of DROP and (re)CREATE?

<<Type your answer here.>>

*/

-- 1.6: Indexing the Building Name

CREATE INDEX IDX_BuildingName ON Building(BuildingName);

/**********************************************/
/** PART 2: Creating the University Database **/

DROP TABLE course;
CREATE TABLE course ( 
    DepartmentID VARCHAR2(4) NOT NULL,
    CourseNumber VARCHAR2(4) NOT NULL,
    CourseTitle VARCHAR2(60) NOT NULL,
    CatalogDescription VARCHAR2(500) NOT NULL,
    CreditHours NUMBER(5,3) NOT NULL,
    CONSTRAINT PK_CourseNumber PRIMARY KEY (CourseNumber),
    CONSTRAINT FK_Department FOREIGN KEY (DepartmentID),
    REFERENCES department(Department)
);

DROP TABLE department;
CREATE TABLE department (
    Department VARCHAR2(4) NOT NULL,
    DepartmentName VARCHAR2(50) NOT NULL,
    DepartmentOffice VARCHAR2(30),
    CONSTRAINT PK_Department PRIMARY KEY (Department)
);

DROP TABLE donation;
CREATE TABLE donation (
    DonationId NUMBER(5) NOT NULL,
    Amount NUMBER(10,2) NOT NULL,
    Type CHAR(2) NOT NULL,
    ForDepartmentID VARCHAR2(4) NOT NULL,
    CONSTRAINT PK_Donation PRIMARY KEY (DonationID),
    CONSTRAINT FK_ForDepartmentID FOREIGN KEY (ForDepartmentID) 
    REFERENCES department(Department)
);

DROP TABLE enrollment;
CREATE TABLE enrollment ( 
    );

DROP TABLE gift;
CREATE TABLE gift (
    );

DROP TABLE job;
CREATE TABLE job (
    );

DROP TABLE meeting;
CREATE TABLE meeting (
    );

DROP TABLE person;
CREATE TABLE person (
    );

DROP TABLE position;
CREATE TABLE position (
    );

DROP TABLE room;
CREATE TABLE room (
    );

DROP TABLE section;
CREATE TABLE section (
    );
