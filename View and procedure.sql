--**********************************************************************************************-
/* VIEW */
--**********************************************************************************************-

use[HumanResoursestest]

-- VEmployee_full_info
CREATE VIEW VEmployee_full_info
AS
SELECT dbo.Employees.Emp_iD, dbo.Departments.Dept_id, dbo.Employees.First_name, dbo.Employees.Middle_name, dbo.Employees.Last_name, dbo.Employees.Gender, dbo.Employees.Birth_date, dbo.Employees.Nationality, 
dbo.Employees.TelNo, dbo.Employees.Email, dbo.Employees.Hire_date, dbo.Employees.Salary, dbo.Departments.Dept_name, dbo.Employee_Educational_Background.Edu_Background, 
dbo.Employee_Educational_Background.Edu_level,
dob.Dependents.First_name, dbo.Dependents.Middle_name, dbo.Dependents.Last_name, dbo.Dependents.Gender,Dependents.Relationship
,dbo.Employees_address.House_number, dbo.WOREDA.WoredaId, dbo.REGION.RegionId, dbo.ZONE.ZoneId
FROM  dbo.Employees INNER JOIN
dbo.Emp_dep ON dbo.Employees.Emp_iD = dbo.Emp_dep.Emp_id INNER JOIN
dbo.Departments ON dbo.Emp_dep.Dept_id = dbo.Departments.Dept_id INNER JOIN
dbo.Employee_Educational_Background ON dbo.Employees.Emp_iD = dbo.Employee_Educational_Background.Emp_id INNER JOIN
Dependents on  Employees.Emp_id = dependents.Emp_id INNER JOIN
dbo.Employees_address ON dbo.Employees.Emp_iD = dbo.Employees_address.Emp_id INNER JOIN
dbo.WOREDA ON dbo.Employees_address.WoredaId = dbo.WOREDA.WoredaId INNER JOIN
dbo.ZONE ON dbo.WOREDA.WZoneId = dbo.ZONE.ZoneId INNER JOIN
dbo.REGION ON dbo.ZONE.ZRegionID = dbo.REGION.RegionId

DROP VIEW VEmployee_full_info
SELECT* FROM VEmployee_full_info



--VEmployee_Address
CREATE VIEW VEmployee_Address
AS
SELECT Employees.Emp_iD,Employees_address.Add_id,  First_name, Middle_name,Last_name,Gender,WoredaName,ZoneName,RegionName,House_number
FROM Employees 
INNER JOIN Employees_address ON dbo.Employees.Emp_iD = dbo.Employees_address.Emp_id 
INNER JOIN WOREDA ON Employees_address.WoredaId = WOREDA.WoredaId 
INNER JOIN ZONE ON WOREDA.WZoneId = ZONE.ZoneId 
INNER JOIN REGION ON ZONE.ZRegionID = REGION.RegionId

DROP VIEW VEmployee_Address
SELECT* FROM VEmployee_Address




--VEMP_DEP
CREATE VIEW VEmp_dep
AS
SELECT Employees.Emp_iD, Departments.Dept_id, Employees.First_name, Employees.Middle_name, Employees.Last_name,Gender,Departments.Dept_name
FROM  Employees 
INNER JOIN Emp_dep ON Employees.Emp_iD = Emp_dep.Emp_id 
INNER JOIN Departments ON Emp_dep.Dept_id = Departments.Dept_id

DROP VIEW VEmp_dep
SELECT* FROM VEmp_dep

--vDept_manager
CREATE VIEW vDept_manager
AS
SELECT        dbo.Dept_manager.Emp_id, dbo.Dept_manager.Dept_id, dbo.Employees.First_name, dbo.Employees.Middle_name, dbo.Employees.Last_name,Gender, dbo.Departments.Dept_name
FROM            dbo.Departments INNER JOIN
dbo.Dept_manager ON dbo.Departments.Dept_id = dbo.Dept_manager.Dept_id INNER JOIN
dbo.Employees ON dbo.Dept_manager.Emp_id = dbo.Employees.Emp_iD
DROP VIEW vDept_manager
SELECT* FROM vDept_manager



--vJob_salary
CREATE VIEW VJob_salary
AS
SELECT        dbo.Jobs.Job_id, dbo.Jobs.Job, dbo.Job_salary.Lowest_salary, dbo.Job_salary.Highest_salary
FROM            dbo.Job_salary INNER JOIN
dbo.Jobs ON dbo.Job_salary.Job_id = dbo.Jobs.Job_id

DROP VIEW VJob_salary
SELECT* FROM VJob_salary



--VEmp_Salary_tax
CREATE VIEW VEmp_Salary_tax
AS
SELECT dbo.Emp_dep.Emp_id, dbo.Emp_dep.Dept_id, dbo.Employees.First_name, dbo.Employees.Middle_name, dbo.Employees.Last_name, dbo.Employees.Gender, dbo.Departments.Dept_name, dbo.Employees.Salary
,CASE
WHEN Salary < 600 THEN 0
WHEN Salary >600 and  Salary < 1650 THEN SALARY-(0.1*Salary -60)
WHEN Salary >1651 and  Salary < 3200 THEN SALARY-(0.15*Salary -142.50)
WHEN Salary >3201 and  Salary < 5250 THEN SALARY-(0.20*Salary -302.50)
WHEN Salary >5251 and  Salary < 7800 THEN SALARY-(0.25*Salary -565)
WHEN Salary >7801 and  Salary < 10900 THEN SALARY-(0.30*Salary -955)
ELSE  SALARY-(0.35*Salary -1500)
END AS After_Tax 
FROM dbo.Employees INNER JOIN
dbo.Emp_dep ON dbo.Employees.Emp_iD = dbo.Emp_dep.Emp_id INNER JOIN
dbo.Departments ON dbo.Emp_dep.Dept_id = dbo.Departments.Dept_id

DROP VIEW VEmp_Salary_tax
SELECT* FROM VEmp_Salary_tax

--VRETIRE
CREATE VIEW VRETIREMENT 
	AS
	SELECT Emp_iD,First_name,Middle_name,Last_name,Gender,Birth_date, DATEDIFF(YY, BIRTH_DATE, GETDATE()) AS AGE,
	CASE
	WHEN DATEDIFF(YY, BIRTH_DATE, GETDATE()) > 79 THEN 1
    ELSE  (80 -(DATEDIFF(YY, BIRTH_DATE, GETDATE()))) 
	END AS 'Years Left'
	FROM Employees

DROP VIEW VRETIREMENT
SELECT* FROM VRETIREMENT


	




--***************************************************************************************
/*PROCEDURE*/
--***************************************************************************************


--Department is selected (by department names )
CREATE PROCEDURE PDept_name
@Dept_name VARCHAR(40)
AS
SELECT *
FROM VEmployee_full_info
WHERE Dept_name =@Dept_name
GO

EXEC PDept_name @Dept_name = 'Marketing'



--	Gender is selected 
CREATE PROCEDURE PEmp_Gender
@Gender VARCHAR(1)
AS
SELECT* 
FROM VEmployee_full_info
WHERE GENDER = @Gender
GO

EXEC PEmp_Gender @Gender = 'M'



--Educational Level is selected (Phd, Msc/MA ,Bsc/BA, Diploma, Others )
CREATE PROCEDURE PEdu_level
@Edu_level VARCHAR(10)
AS
SELECT* 
FROM VEmployee_full_info
WHERE Edu_level = @Edu_level
GO

EXEC PEdu_level  @Edu_level = 'MA'



--*******************************************************************************************
/*8.	A stored procedure  or view which returns count of employees group by  */
--*******************************************************************************************



--VEmp_Dept_Count
CREATE VIEW VEmp_Dept_Count
AS
SELECT        dbo.Departments.Dept_id,count(employees.Emp_iD) AS Emp_Count
FROM            dbo.Departments INNER JOIN
dbo.Emp_dep ON dbo.Departments.Dept_id = dbo.Emp_dep.Dept_id INNER JOIN
dbo.Employees ON dbo.Emp_dep.Emp_id = dbo.Employees.Emp_iD
GROUP BY (DEPARTMENTS.Dept_id)

DROP VIEW VEmp_Dept_Count
SELECT* FROM VEmp_Dept_Count



--Gender_count
CREATE VIEW VGender_count
AS
SELECT      Gender,count(Emp_iD) AS Gender_count
FROM  Employees
GROUP BY (Gender)

DROP VIEW VGender_count
SELECT* FROM VGender_count

--Edu_level_count
CREATE VIEW VEdu_level_count
AS
SELECT  Edu_level,count(Edu_level)AS Edu_level_count
FROM Employee_Educational_Background 
INNER JOIN Employees ON Employee_Educational_Background.Emp_id = Employees.Emp_iD
GROUP BY (Edu_level)

DROP VIEW VEdu_level_count
SELECT* FROM VEdu_level_count


--*******************************************************************************************
/*9.	A stored procedure which updates basic salary of employee given his/her id */
--*******************************************************************************************

CREATE PROCEDURE PUpdate_Salary
@Update_salary DECIMAL(10,2),
@Emp_id VARCHAR(5)
AS
UPDATE Employees
SET 
SALARY = @Update_salary
WHERE  Emp_id = @Emp_id

EXEC PUpdate_salary @Update_salary = '32000.50', @Emp_id = 'E0001'

DROP PROCEDURE PUpdate_Salary

SELECT* FROM Employees




--*******************************************************************************************
/*10.	A stored procedure which delete an employee given given his/her id  */
--*******************************************************************************************

/*Conflict occurs cause fk exists*/
CREATE PROCEDURE PDelete_Emp
@Delete_Emp VARCHAR(5)
AS
DELETE FROM Employees
WHERE Emp_iD = @Delete_Emp

EXEC PDelete_Emp @Delete_Emp = 'E0030'

SELECT* FROM Employees

