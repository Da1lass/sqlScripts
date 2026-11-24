--  dropping all the tables in reverse creation order

DROP TABLE Participation;
DROP TABLE Hobby;
DROP TABLE BCUAccount;
-- DROP TABLE BCUAccountDependent; 
-- DROP TABLE BCUAccountEmployees; ----see comment above this table for why these are commented out
DROP TABLE Dependent;
DROP TABLE Job;
DROP TABLE Manager;
ALTER TABLE Plant DROP CONSTRAINT FK_PlantManager;
DROP TABLE Employee;
DROP TABLE Project;
DROP TABLE Building;
DROP TABLE Plant;
 --creating all tables

CREATE TABLE Plant (
    PlantNumber NUMBER(5) NOT NULL,
    PlantName VARCHAR(50),
    Budget NUMBER(11,2),
    ManagerNumber NUMBER(8), -- this needs to be a FK after the employee table has been done
    CONSTRAINT PK_Plant PRIMARY KEY (PlantNumber)
);

CREATE TABLE Building (
    BuildingNumber NUMBER(3),
    BuildingName VARCHAR(50),
    PlantNumber NUMBER(5),
    CONSTRAINT PK_Building PRIMARY KEY (BuildingNumber),
    CONSTRAINT FK_BuildingPlant FOREIGN KEY (PlantNumber)
        REFERENCES Plant(PlantNumber)
);

CREATE TABLE Project (
    ProjectNumber NUMBER(8) NOT NULL,
    ProjectName VARCHAR(50),
    Location VARCHAR(50),
    PlantNumber NUMBER(5) NOT NULL,
    CONSTRAINT PK__Project PRIMARY KEY (ProjectNumber),
    CONSTRAINT FK_ProjectPlant FOREIGN KEY (PlantNumber)
        REFERENCES Plant(PlantNumber)
);

CREATE TABLE Employee (
    EmployeeNumber NUMBER(8) NOT NULL,
    FirstName VARCHAR2(20),
    LastName VARCHAR2(50),
    StreetLine1 VARCHAR2(50),
    StreetLine2 VARCHAR2(20),
    City VARCHAR2(50),
    State VARCHAR2(2),
    Postal NUMBER(5),
    Gender CHAR,
    DateHired DATE,
    Salary NUMBER(8,2),
    SupervisorNumber NUMBER(8) NOT NULL,
    PlantNumber NUMBER(5) NOT NULL,
    CONSTRAINT PK_EmployeeNumber PRIMARY KEY (EmployeeNumber),
    CONSTRAINT FK_EmployeePlant FOREIGN KEY (PlantNumber)
        REFERENCES Plant(PlantNumber),
    CONSTRAINT FK_Supervisor FOREIGN KEY (SupervisorNumber)
        REFERENCES Employee(EmployeeNumber)
);

CREATE TABLE Manager (
    ManagerNumber NUMBER(8) NOT NULL,
    ManagerStartDate DATE,
    CONSTRAINT PK_Manager PRIMARY KEY (ManagerNumber),
    CONSTRAINT FK_Manager FOREIGN KEY (ManagerNumber)
        REFERENCES Employee(EmployeeNumber)
);

CREATE TABLE Job (
    EmployeeNumber NUMBER(8),
    ProjectNumber NUMBER(8),
    CONSTRAINT PK_Job PRIMARY KEY (EmployeeNumber, ProjectNumber),
    CONSTRAINT FK_JobEmployeeNumber FOREIGN KEY (EmployeeNumber)
        REFERENCES Employee(EmployeeNumber),
    CONSTRAINT FK_JobProjectNumber FOREIGN KEY (ProjectNumber)
        REFERENCES Project(ProjectNumber)
);

CREATE TABLE Dependent (
    DependentEmployeeNumber NUMBER(8) NOT NULL,
    DependentFirstName VARCHAR2(20) NOT NULL,
    DependentLastName VARCHAR2(50) NOT NULL,
    Relationship VARCHAR2(30),
    BirthDate DATE,
    Gender CHAR,
    CONSTRAINT PK_Dependent PRIMARY KEY (DependentEmployeeNumber, DependentFirstName, DependentLastName),
    CONSTRAINT FK_DependentEmployeeNumber FOREIGN KEY (DependentEmployeeNumber)
        REFERENCES Employee(EmployeeNumber)
);

CREATE TABLE BCUAccount (
    -- these three values are in both dependent and employee accounts
    AccountNumber NUMBER(8) NOT NULL,
    AccountType CHAR NOT NULL,
    Balance NUMBER(11,2) DEFAULT 0, 
    -- employee account values
    EmployeeNumber NUMBER(8) NOT NULL,
    FirstName VARCHAR2(20),
    LastName VARCHAR2(50),
    -- dependent account values
    DependentEmployeeNumber NUMBER(8) NOT NULL,
    DependentFirstName VARCHAR2(20) NOT NULL,
    DependentLastName VARCHAR2(50) NOT NULL,

    CONSTRAINT PK_AccountInfo PRIMARY KEY (AccountNumber, AccountType),
    -- constraints for checking 
    CONSTRAINT CHK_AccountType CHECK (AccountType IN ('E', 'D')), -- E for employee, D for dependent
    -- checking constraints
    CONSTRAINT CHK_AccountEmployee CHECK (AccountType != 'E' OR EmployeeNumber IS NOT NULL),
    CONSTRAINT CHK_AccountDependent CHECK (AccountType != 'D' OR 
    DependentEmployeeNumber IS NOT NULL AND
    DependentFirstName IS NOT NULL AND
    DependentLastName IS NOT NULL AND
    EmployeeNumber IS NULL
    ),

    
    CONSTRAINT FK_AccountEmployee FOREIGN KEY (EmployeeNumber)
        REFERENCES Employee(EmployeeNumber),
    CONSTRAINT FK_AccountDependent FOREIGN KEY (DependentEmployeeNumber, DependentFirstName, DependentLastName)
        REFERENCES Dependent(DependentEmployeeNumber, DependentFirstName, DependentLastName)
);

-- CREATE TABLE BCUAccountEmployees ( I did this and the next table b4 i realized there needed to be one single table. oops.
--     AccountNumber NUMBER(8) NOT NULL,
--     AccountType CHAR NOT NULL,
--     Balance NUMBER(11,2), 
--     EmployeeNumber NUMBER(8) NOT NULL,
--     CONSTRAINT PK_BCUAccountEmployee PRIMARY KEY (AccountNumber, AccountType),
--     CONSTRAINT FK_BCUAccountEmployee FOREIGN KEY (EmployeeNumber)
--         REFERENCES Employee(EmployeeNumber)
-- );

-- CREATE TABLE BCUAccountDependent (
--     AccountNumber NUMBER(8) NOT NULL,
--     AccountType CHAR NOT NULL,
--     Balance NUMBER(11,2),
--     DependentEmployeeNumber NUMBER(8) NOT NULL,
--     DependentFirstName VARCHAR2(20) NOT NULL,
--     DependentLastName VARCHAR2(50) NOT NULL,
--     CONSTRAINT PK_BCUAccountDependent PRIMARY KEY (AccountNumber, AccountType, DependentEmployeeNumber, DependentFirstName, DependentLastName),
--     CONSTRAINT FK_BCUAccountDependent FOREIGN KEY (DependentEmployeeNumber, DependentFirstName, DependentLastName)
--         REFERENCES Dependent(DependentEmployeeNumber, DependentFirstName, DependentLastName)
-- );

CREATE TABLE Hobby (
    HobbyName VARCHAR(50) NOT NULL,
    Activity VARCHAR(50),
    CONSTRAINT PK_Hobby PRIMARY KEY (HobbyName)
);

CREATE TABLE Participation (
    HobbyName VARCHAR(50) NOT NULL,
    DependentEmployeeNumber NUMBER(8) NOT NULL, 
    DependentFirstName VARCHAR2(20) NOT NULL,
    DependentLastName VARCHAR2(50) NOT NULL,
    AnnualCost NUMBER(8,2),
    HoursPerWeek NUMBER(2),
    CONSTRAINT PK_Participation PRIMARY KEY (HobbyName, DependentEmployeeNumber, DependentFirstName, DependentLastName),
    CONSTRAINT FK_ParticipationHobby FOREIGN KEY (HobbyName)
        REFERENCES Hobby(HobbyName),
    CONSTRAINT FK_ParticipationDependent FOREIGN KEY (DependentEmployeeNumber, DependentFirstName, DependentLastName)
    REFERENCES Dependent(DependentEmployeeNumber, DependentFirstName, DependentLastName)
);

-- adding the plant manager stuff
ALTER TABLE Plant ADD (CONSTRAINT FK_PlantManager FOREIGN KEY (ManagerNumber)
    REFERENCES Employee(EmployeeNumber));
-- index dropping for testing 
/*
DROP INDEX IDX_BCU_Dependent;
DROP INDEX IDX_BCU_Employee;
DROP INDEX IDX_BuildingName;
DROP INDEX IDX_Building_Plant;
DROP INDEX IDX_Dependent_Employee;
DROP INDEX IDX_DependentName;
DROP INDEX IDX_EmployeeName;
DROP INDEX IDX_EmployeeAddress;
DROP INDEX IDX_Employee_Supervisor;
DROP INDEX IDX_Employee_Plant;
DROP INDEX IDX_Job_Employee;
DROP INDEX IDX_Job_Project;
DROP INDEX IDX_Manager_Employee;
DROP INDEX IDX_Participation_Dependent;
DROP INDEX IDX_Participation_Hobby;
DROP INDEX IDX_PlantName;
DROP INDEX IDX_Plant_Manager;
DROP INDEX IDX_ProjectName;
DROP INDEX IDX_Project_Plant; */

-- index creation
CREATE INDEX IDX_BCU_Dependent ON BCUAccount(DependentEmployeeNumber, DependentFirstName, DependentLastName);
CREATE INDEX IDX_BCU_Employee ON BCUAccount(FirstName, LastName);

-- Building 
CREATE INDEX IDX_BuildingName ON Building(BuildingName, BuildingNumber);
CREATE INDEX IDX_Building_Plant ON Building(BuildingName, PlantNumber);

-- Dependent 
CREATE INDEX IDX_Dependent_Employee ON Dependent(DependentEmployeeNumber, DependentFirstName, DependentLastName, Relationship);
CREATE INDEX IDX_DependentName ON Dependent(DependentFirstName, DependentLastName);

-- Employee
CREATE INDEX IDX_EmployeeName ON Employee(FirstName, LastName);
CREATE INDEX IDX_EmployeeAddress ON Employee(StreetLine1, StreetLine2, City, State, Postal);
CREATE INDEX IDX_Employee_Supervisor ON Employee(EmployeeNumber, FirstName, LastName, SupervisorNumber);
CREATE INDEX IDX_Employee_Plant ON Employee(EmployeeNumber, FirstName, LastName, PlantNumber);

-- Job 
CREATE INDEX IDX_Job_Employee ON Job(EmployeeNumber);
CREATE INDEX IDX_Job_Project ON Job(ProjectNumber);

-- Manager
CREATE INDEX IDX_Manager_Employee ON Manager(ManagerNumber, ManagerStartDate);

-- Participation
CREATE INDEX IDX_Participation_Dependent ON Participation(DependentEmployeeNumber, DependentFirstName, DependentLastName);
CREATE INDEX IDX_Participation_Hobby ON Participation(HobbyName, AnnualCost, HoursPerWeek);

-- Plant
CREATE INDEX IDX_PlantName ON Plant(PlantName, PlantNumber);
CREATE INDEX IDX_Plant_Manager ON Plant(ManagerNumber, PlantName, PlantNumber);

-- Project
CREATE INDEX IDX_ProjectName ON Project(ProjectName, ProjectNumber);
CREATE INDEX IDX_Project_Plant ON Project(ProjectName, PlantNumber);

