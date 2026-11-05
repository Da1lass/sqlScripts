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



DROP TABLE department;
CREATE TABLE department (
    DepartmentID VARCHAR2(4) NOT NULL,
    DepartmentName VARCHAR2(50) NOT NULL,
    DepartmentOffice VARCHAR2(30),
    CONSTRAINT PK_Department PRIMARY KEY (DepartmentID)
);

DROP TABLE course;
CREATE TABLE course ( 
    DepartmentID VARCHAR2(4) NOT NULL,
    CourseNumber VARCHAR2(4) NOT NULL,
    CourseTitle VARCHAR2(60) NOT NULL,
    CatalogDescription VARCHAR2(500) NOT NULL,
    CreditHours NUMBER(5,3) NOT NULL,
    CONSTRAINT PK_Course PRIMARY KEY (DepartmentID, CourseNumber),
    CONSTRAINT FK_Department FOREIGN KEY (DepartmentID)
        REFERENCES department(DepartmentID)
);

DROP TABLE section;
CREATE TABLE section (
    DepartmentID VARCHAR2(4) NOT NULL,
    CourseNumber VARCHAR2(4) NOT NULL,
    SectionNumber VARCHAR2(3) NOT NULL,
    CreditHours	NUMBER(5,3),
    SpecialTitle VARCHAR2(30),
    MaximumEnrollment NUMBER(3),
    TeacherENumber VARCHAR2(9),
    CONSTRAINT PK_Section PRIMARY KEY (DepartmentID, CourseNumber, SectionNumber),
    CONSTRAINT FK_Department FOREIGN KEY (DepartmentID)
        REFERENCES department(DepartmentID),
    CONSTRAINT FK_Course FOREIGN KEY (CourseNumber)
        REFERENCES course(CourseNumber)
);

DROP TABLE donation;
CREATE TABLE donation (
    DonationId NUMBER(5) NOT NULL,
    Amount NUMBER(10,2) NOT NULL,
    Type CHAR(2) NOT NULL,
    ForDepartmentID VARCHAR2(4),
    CONSTRAINT PK_Donation PRIMARY KEY (DonationID),
    CONSTRAINT FK_ForDepartmentID FOREIGN KEY (ForDepartmentID) 
        REFERENCES department(DepartmentID) 
);

DROP TABLE person;
CREATE TABLE person (
    ENumber VARCHAR2(9) NOT NULL,
    SSN VARCHAR2(9),
    FirstName VARCHAR2(50) NOT NULL,
    LastName VARCHAR2(50) NOT NULL,
    Street VARCHAR2(50),
    City VARCHAR2(2),
    Zipcode VARCHAR2(9),
    Telephone VARCHAR2(10),
    BuildingID NUMBER(3),
    RoomNumber NUMBER(4),
    CONSTRAINT PK_ENumber PRIMARY KEY (ENumber),
    CONSTRAINT FK_Building FOREIGN KEY (BuildingID) 
        REFERENCES building(BuildingID),
    CONSTRAINT FK_Room FOREIGN KEY (RoomNumber)
        REFERENCES room(RoomNumber)
);

DROP TABLE room;
CREATE TABLE room (
    BuildingID NUMBER(3) NOT NULL,
    RoomNumber NUMBER(4) NOT NULL,
    RoomType CHAR,
    CONSTRAINT PK_Room PRIMARY KEY (BuildingID, RoomNumber),
    CONSTRAINT FK_Building FOREIGN KEY (BuildingID)
        REFERENCES building(BuildingID)
);

DROP TABLE gift;
CREATE TABLE gift (
    DonationID NUMBER(5) NOT NULL,
    ENumber VARCHAR2(9) NOT NULL, 
    GiftDate DATE NOT NULL,
    ReceiptDate DATE,
    CONSTRAINT PK_Gift PRIMARY KEY (DonationID, ENumber, GiftDate),
    CONSTRAINT FK_Donation FOREIGN KEY (DonationID)
        REFERENCES donation(DonationID),
    CONSTRAINT FK_ENumber FOREIGN KEY (ENumber)
        REFERENCES person(ENumber)
);

DROP TABLE enrollment;
CREATE TABLE enrollment ( 
    ENumber VARCHAR2(9) NOT NULL,
    DepartmentID VARCHAR2(4) NOT NULL,
    CourseNumber VARCHAR2(4) NOT NULL,
    SectionNumber VARCHAR2(3) NOT NULL,
    CONSTRAINT PK_Enrollment PRIMARY KEY (ENumber, DepartmentID, CourseNumber, SectionNumber),
    CONSTRAINT FK_ENumber FOREIGN KEY (ENumber)
        REFERENCES person(ENumber),
    CONSTRAINT FK_Department FOREIGN KEY (DepartmentID)
        REFERENCES department(DepartmentID),
    CONSTRAINT FK_Course FOREIGN KEY (CourseNumber)
        REFERENCES course(CourseNumber),
    CONSTRAINT FK_Section FOREIGN KEY (SectionNumber)
        REFERENCES section(SectionNumber)
);

DROP TABLE position;
CREATE TABLE position (
    PositionNumber VARCHAR2(6) NOT NULL,
    PositionTitle VARCHAR2(30) NOT NULL,
    ActiveIndicator CHAR NOT NULL,
    CONSTRAINT PK_Position PRIMARY KEY (PositionNumber)
);

DROP TABLE job;
CREATE TABLE job (
    ENumber VARCHAR2(9)	NOT NULL,
    PositionNumber VARCHAR2(6)	NOT NULL,
    StartDate DATE,
    EndDate DATE,
    Salary NUMBER(8,2),
    CONSTRAINT PK_Job PRIMARY KEY (ENumber, PositionNumber),
    CONSTRAINT FK_ENumber FOREIGN KEY (ENumber)
        REFERENCES person(ENumber),
    CONSTRAINT FK_Position FOREIGN KEY (PositionNumber)
        REFERENCES position(PositionNumber)
);

DROP TABLE meeting;
CREATE TABLE meeting (
    DepartmentID VARCHAR2(4) NOT NULL,
    CourseNumber VARCHAR2(4) NOT NULL,
    SectionNumber VARCHAR2(3) NOT NULL,
    BuildingID NUMBER(3) NOT NULL,
    RoomNumber NUMBER(4) NOT NULL,
    Day	VARCHAR2(7) NOT NULL,
    StartTime VARCHAR2(5) NOT NULL,
    EndTime	VARCHAR2(5)	NOT NULL,
    CONSTRAINT PK_Meeting PRIMARY KEY (DepartmentID, CourseNumber, SectionNumber, BuildingID, RoomNumber, Day, StartTime, EndTime),
    CONSTRAINT FK_Department FOREIGN KEY (DepartmentID)
        REFERENCES department(DepartmentID),
    CONSTRAINT FK_Course FOREIGN KEY (CourseNumber)
        REFERENCES course(CourseNumber),
    CONSTRAINT FK_Section FOREIGN KEY (SectionNumber)
        REFERENCES section(SectionNumber),
    CONSTRAINT FK_Building FOREIGN KEY (BuildingID)
        REFERENCES building(BuildingID),
    CONSTRAINT FK_Room FOREIGN KEY (RoomNumber)
        REFERENCES room(RoomNumber)
);

