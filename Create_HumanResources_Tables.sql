USE SchoolSystem
go
;

--THumanResources_Disciplinary

CREATE TABLE HumanResources_Disciplinary
  (
   Disciplinary_Code Char(7) Primary Key
  ,Employee_Code Char(7) Foreign Key REFERENCES HumanResources_EmployeePersonalInfo(Employee_Code)
  ,Date_Of_Action Date
  ,Description Text
  ,Discipline Varchar(20)
  ,Duration TinyInt
  ,Supervisor_Code Char(7) Foreign Key REFERENCES HumanResources_EmployeePersonalInfo(Employee_Code)
  ,Date_Modified Datetime2(3)
  )
;

GO
;

CREATE TRIGGER trg_HR_Disciplinary_UpdateDate
ON HumanResources_Disciplinary
AFTER UPDATE
AS
  UPDATE HumanResources_Disciplinary
  SET Date_Modified = CURRENT_TIMESTAMP
  FROM Inserted as I
    WHERE HumanResources_Disciplinary.Disciplinary_Code = I.Disciplinary_Code
	;
 
--HumanResources_EmployeePersonalInfo

CREATE TABLE HumanResources_EmployeePersonalInfo
  (
   Employee_Code Char(7) Primary Key
  ,Employee_Id Char(5) Unique
  ,First_Name Varchar(75)
  ,Middle_Name Varchar(75)
  ,Last_Name Varchar(75)
  ,Birth_Date Date
  ,Social_Security Char(11) Unique
  ,Sex TinyINT
  ,Cell_Phone Varchar(12)
  ,Home_Phone Varchar(12) 
  ,Work_Phone Varchar(16)
  ,Personal_Email Varchar(50) Unique 
  ,Work_Email Varchar(50) Unique
  ,Address Varchar (75)
  ,City Varchar (50)
  ,State Char(2)
  ,ZipCode Varchar (11)
  ,Username Char(5)
  ,Password Varchar(75)
  ,Date_Modified Datetime2(3)
  )
;

CREATE TABLE Gender
  (
   Sex_Code TinyINT Primary Key
  ,Sex Varchar(10)
  )
;

ALTER TABLE HumanResources_EmployeePersonalInfo
ADD CONSTRAINT FK_SexCode Foreign Key (Sex) references Gender(Sex_Code)
;

Go
;

CREATE TRIGGER trg_HR_EmployeePersonalInfo_UpdateModifiedDate
ON HumanResources_EmployeePersonalInfo
AFTER UPDATE
AS 
  UPDATE HumanResources_EmployeePersonalInfo
  SET Date_Modified = CURRENT_TIMESTAMP
  FROM Inserted as I 
    WHERE HumanResources_EmployeePersonalInfo.Employee_Code = i.Employee_Code
;

--HumanResources_EmployeeJobInfo

CREATE TABLE HumanResources_EmployeeJobInfo
  (
   Employee_Job_Code Char(9) Primary Key
  ,Job_Code Char (7) Foreign Key REFERENCES HumanResources_JobInfo(Job_Code)
  ,Employee_Code Char(7) Foreign Key REFERENCES HumanResources_EmployeePersonalInfo(Employee_Code)
  ,School_Code Char(12) Foreign Key REFERENCES School_Info(School_Code)
  ,Hire_Date Date
  ,End_Date Date
  ,Reason_Left Varchar(255) 
  ,Date_Modified Datetime2(3)
  )
;


GO
;

CREATE TRIGGER trg_HR_EmployeeJobInfo_UpdateModifiedDate
ON HumanREsources_EmployeeJobInfo
AFTER UPDATE
AS
  UPDATE HumanResources_EmployeeJobInfo
  SET Date_Modified = CURRENT_TIMESTAMP
  FROM Inserted as I
    WHERE HumanResources_EmployeeJobInfo.Employee_Job_Code = I.Employee_Job_Code
;


--HumanResources_EmployeePhoto

CREATE TABLE HumanResources_EmployeePhoto
  (
   Photo_Id int Identity(10000,5) Primary Key
  ,Employee_Code Char(7) Foreign Key References HumanResources_EmployeePersonalInfo(Employee_Code)
  ,Photo Varbinary(Max)
  ,Date_Modified Datetime2(3)
  )
;

GO
;

CREATE TRIGGER trg_E_Photo_UpdateModifiedDate
ON HumanREsources_EmployeePhoto
AFTER UPDATE
AS
  UPDATE HumanResources_EmployeePhoto
  SET Date_Modified = CURRENT_TIMESTAMP
  FROM Inserted as I
    WHERE HumanResources_EmployeePhoto.Photo_Id = I.Photo_Id
;


--HumanResources_JobApplicants

CREATE TABLE HumanResources_JobApplicants
  (
   Application_Code Char(7) Primary Key
  ,Date_Applied Date
  ,First_Name Varchar(75)
  ,Last_Name Varchar(75)
  ,Phone Char(12)
  ,Email Char(50)
  ,Resume Varbinary(Max)
  ,Cover_Letter Varbinary(Max)
  ,Other_Documents Varbinary(Max)
  ,Granted_Interview Bit
  ,Interview_Date Date
  ,Acceptance Bit                    --For the BIT data types, 0 is 'NO' and 1 is 'YES'
  ,Date_Modified Datetime2(3)
  )
;

GO
;


CREATE TRIGGER trg_HR_JobApplicants_UpdateDateModified
ON HumanResources_JobApplicants
AFTER UPDATE
AS
  UPDATE HumanResources_JobApplicants
  SET Date_Modified = CURRENT_TIMESTAMP
  FROM Inserted as I
    WHERE HumanResources_JobAPplicants.Application_Code = I.Application_Code
;


--HumanResources_JobInfo

CREATE TABLE HumanResources_JobInfo
  (
   Job_Code Char(7) Primary Key
  ,Job_Title Varchar(50)
  ,Department Varchar(25)
  ,Group_Name Varchar(25)
  ,Date_Modified Datetime2(3)
  )
;

GO
;


CREATE TRIGGER trg_HR_JobInfo_UpdateModifiedDate
ON HumanREsources_JobInfo
AFTER UPDATE
AS
  UPDATE HumanResources_JobInfo
  SET Date_Modified = CURRENT_TIMESTAMP
  FROM Inserted as I
    WHERE HumanResources_JobInfo.Job_Code = I.Job_Code
;


--HumanResources_Salary

CREATE TABLE HumanResources_Salary
  (
   Salary_Code Char(9) Primary Key
  ,Employee_Code Char(7) Foreign Key REFERENCES HumanResources_EmployeePersonalInfo(Employee_Code)
  ,Amount Varchar(8)
  ,Rate_Change_Date Date
  ,Date_Modified Datetime2(3)
  )
;

GO
;

CREATE TRIGGER trg_Salary_UpdateModifiedDate
ON HumanResources_Salary
AFTER UPDATE
AS
  UPDATE HumanResources_Salary
  SET Date_Modified = CURRENT_TIMESTAMP
  FROM Inserted as I
    WHERE HumanResources_Salary.Salary_Code = I.Salary_Code
;

