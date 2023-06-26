DROP DATABASE HumanResoursestest

CREATE DATABASE HumanResoursestest
USE HumanResoursestest


CREATE TABLE Employees(

	Emp_iD			VARCHAR(5) PRIMARY KEY,
	First_name		NVARCHAR(20) NOT NULL check(First_name NOT Like '%[^A-Za-z]%'),
	Middle_name		NVARCHAR(20) NOT NULL check(Middle_name NOT Like '%[^A-Za-z]%') ,
	Last_name		NVARCHAR(20) NOT NULL check(Last_name NOT Like '%[^A-Za-z]%'),
	Gender			NVARCHAR(2) NOT NULL check (Gender in('M','F')),
	Birth_date		DATE  NOT NULL  CHECK (Birth_date BETWEEN  '1944-01-01' AND SYSDATETIME ()),
	Nationality     VARCHAR(50) NOT NULL DEFAULT 'Ethiopian',
	TelNo			VARCHAR(20) check(TelNo NOT LIKE '%[^0-9]%'),
	Email		    VARCHAR(30) CHECK(Email Like '%_@__%.__%'),
	Hire_date		DATE  NOT NULL,
	Salary			DECIMAL(10,2) NOT NULL

)


CREATE TABLE Employee_Educational_Background
(
	Emp_id			VARCHAR(5)   FOREIGN KEY REFERENCES Employees (Emp_id),
	Edu_Background	VARCHAR(50) NOT NULL,
	Edu_level		VARCHAR(10)
)



--****************************************************************************-
/*                               Departments                                   */
--****************************************************************************-

CREATE TABLE Departments (
	Dept_id		VARCHAR(5) PRIMARY KEY NOT NULL,
	Dept_name   VARCHAR(40) NOT NULL UNIQUE,
);


CREATE TABLE Dept_manager (
	Emp_id       VARCHAR(5) FOREIGN KEY REFERENCES employees (Emp_id) ,
	Dept_id      VARCHAR(5) FOREIGN KEY REFERENCES Departments (Dept_id),
	PRIMARY KEY (Emp_id,Dept_id)

);



CREATE TABLE Emp_dep (
	Emp_id      VARCHAR(5)   FOREIGN KEY REFERENCES Employees (Emp_id),
	Dept_id     VARCHAR(5)  FOREIGN KEY REFERENCES Departments (Dept_id),
	PRIMARY KEY (Emp_id,Dept_id),
);



--****************************************************************************-
/*                               JOB                                   */
--****************************************************************************-


CREATE TABLE Jobs
(
	Job_id VARCHAR(5) PRIMARY KEY,
	Job VARCHAR(50) NOT NULL
)


CREATE TABLE Job_salary
(
	Job_id			VARCHAR(5) NOT NULL FOREIGN KEY REFERENCES Jobs (Job_id),
	Job				VARCHAR(50),
	Lowest_salary	DECIMAL(10,2) NOT NULL,
	Highest_salary	DECIMAL(10,2) NOT NULL, 
)


CREATE TABLE Emp_Jobs (
	Emp_id			VARCHAR(5) NOT NULL FOREIGN KEY REFERENCES employees (Emp_id),
	Job_id			VARCHAR(5) NOT NULL FOREIGN KEY REFERENCES Jobs (Job_id),
	Assigned_date	DATE NOT NULL,
	PRIMARY KEY (Emp_id,Job_id)
);






--****************************************************************************-
/*                                  ADDRESS                               */
--****************************************************************************-

CREATE TABLE REGION 
(
	RegionId	 VARCHAR(4) PRIMARY KEY ,
	RegionName   VARCHAR(25) NOT NULL
)

CREATE TABLE ZONE 
(
	ZoneId		VARCHAR(4) PRIMARY KEY ,
	ZoneName	varchar(25) NOT NULL,
	ZRegionID	VARCHAR(4) NOT NULL FOREIGN KEY REFERENCES REGION (RegionId)
)

CREATE TABLE WOREDA
(
	WoredaId	 VARCHAR(4) PRIMARY KEY ,
	WoredaName   VARCHAR(25) NOT NULL,
	WZoneId		 VARCHAR(4) NOT NULL FOREIGN KEY REFERENCES ZONE (ZoneId)
)

CREATE TABLE Employees_address
(
	Add_id			VARCHAR(5)	 PRIMARY KEY,
	Emp_id			VARCHAR(5)   FOREIGN KEY REFERENCES Employees (Emp_id),
	WoredaId		VARCHAR(4)	 FOREIGN KEY REFERENCES WOREDA (WoredaId),
	House_number	VARCHAR(20),
)





--****************************************************************************-
/*                         Training_programs                               */
--****************************************************************************-
CREATE TABLE Training_programs
(
	Training_id			 VARCHAR PRIMARY KEY,
	Dept_id				 VARCHAR(5) FOREIGN KEY REFERENCES Departments (Dept_id),
	Types_of_training    VARCHAR(50) NOT NULL,
	Start_date			 DATE NOT NULL,
	End_date			 DATE NOT NULL
)


--****************************************************************************-
/*                               Candidates                                   */
--****************************************************************************-


CREATE TABLE Candidates
(
	Can_id				VARCHAR(5) PRIMARY KEY,
	Can_first_name		VARCHAR(20) NOT NULL check(Can_first_name NOT Like '%[^A-Za-Z]%'),
	Can_middle_name		VARCHAR(20) NOT NULL check(Can_middle_name NOT Like '%[^A-Za-Z]%'),
	Can_last_name		VARCHAR(20) NOT NULL check(Can_last_name NOT Like '%[^A-Za-Z]%'),
	Can_Gender			VARCHAR(2) NOT NULL check (Can_Gender in('M','F')),
	Can_GPA				DECIMAL(4,2)NOT NULL CHECK(Can_GPA <=4),
	Can_DOB				DATE NOT NULL CHECK (Can_DOB BETWEEN  '1944-01-01' AND SYSDATETIME ()),
	Can_nationality		VARCHAR(50) NOT NULL DEFAULT 'Ethiopian',
	Can_Study_field		VARCHAR(5) NOT NULL  FOREIGN KEY REFERENCES Jobs (Job_id) ,
	Can_Edu_level		VARCHAR(5) NOT NULL,
	Resume_date			DATE NOT NULL
)


CREATE TABLE Dependents
(
	Dependent_id    VARCHAR(3) PRIMARY KEY,
	Emp_id			VARCHAR(5) NOT NULL FOREIGN KEY REFERENCES employees (Emp_id),
	First_name		NVARCHAR(20) NOT NULL check(First_name NOT Like '%[^A-Za-Z]%'),
	Middle_name		NVARCHAR(20) NOT NULL check(Middle_name NOT Like '%[^A-Za-Z]%') ,
	Last_name		NVARCHAR(20) NOT NULL check(Last_name NOT Like '%[^A-Za-Z]%'),
	Gender			NVARCHAR(2) NOT NULL check (Gender in('M','F')),
	Relationship	VARCHAR(20) NOT NULL
)

