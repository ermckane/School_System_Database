--Student_EmergencyContact


CREATE TABLE Student_EmergencyContact
  (  
   EmergencyContact_Code Char(7) Primary key
  ,Student_Code Char(9) Foreign Key REFERENCES Student_Info(Student_Id)
  ,First_Name Varchar(75)
  ,Last_Name Varchar(75)
  ,Contact_Type Varchar(25)
  ,Birth_Date Date
  ,Social_Security Char(11) Unique
  ,Address Varchar (75)
  ,City Varchar (50)
  ,State Char(2)
  ,ZipCode Varchar (11)
  ,Home_Phone Varchar(12)
  ,Cell_Phone Varchar(12)
  ,Work_Phone Varchar(16)
  ,Work_Place Varchar(30)
  ,Email Varchar(50)
  ,Drivers_Licence Varbinary(Max)
  ,Date_Modified Datetime2(3)
  )
;

GO

;

CREATE TRIGGER trg_Student_EmergencyContact_UpdateModifiedDate
ON Student_EmergencyContact
AFTER UPDATE
AS 
  UPDATE Student_EmergencyContact
  SET Date_Modified = CURRENT_TIMESTAMP
  FROM inserted as I
    WHERE Student_EmergencyContact.Date_Modified = I.Date_Modified
;


--Student_Info


CREATE TABLE Student_Info
  (
   Student_Code Char(9) Primary key
  ,Student_Id Char(7) Unique
  ,First_Name Varchar(75)
  ,Middle_Name Varchar(75)
  ,Last_Name Varchar(75)
  ,Birth_Date Date
  ,Social_Security Char(11) Unique
  ,Address Varchar (75)
  ,City Varchar (50)
  ,State Char(2)
  ,ZipCode Varchar (11)
  ,Date_Modified Datetime2(3)
  )
;

Go

;

CREATE TRIGGER trg_Student_Info_UpdateModifiedDate
ON Student_Info
AFTER UPDATE
AS
  UPDATE Student_Info
  SET Date_Modified = CURRENT_TIMESTAMP
  FROM inserted as I
    WHERE Student_Info.Date_Modified = i.Date_Modified
;


--Student_ParentInfo


CREATE TABLE Student_ParentInfo
  (
   Parental_Code Char(9) Primary Key
  ,Parental_ID Char(7) Unique
  ,Student_Code Char(9) Foreign Key REFERENCES Student_Info(Student_Code)
  ,First_Name Varchar(75)
  ,Last_Name Varchar(75)
  ,Parent_Type Varchar(20)
  ,Birth_Date Date
  ,Social_Security Char(11) Unique
  ,Work_Phone Varchar(16)
  ,Personal_Phone Varchar(16)
  ,Email Varchar(50) Unique 
  ,Work_Place Varchar(50)
  ,Address Varchar (75)
  ,City Varchar (50)
  ,State Char(2)
  ,ZipCode Varchar (11)
  ,Drivers_License Varbinary(Max)
  ,Date_Modified Datetime2(3)
  )
;

GO

;

CREATE TRIGGER trg_Student_ParentInfo_UpdateModifiedDate
ON Student_ParentInfo
AFTER UPDATE
AS
  UPDATE Student_ParentInfo
  SET Date_Modified = CURRENT_TIMESTAMP
  FROM Inserted as I
    WHERE Student_ParentInfo.Date_Modified = I.Date_Modified
;


-- Student_Disciplinary


CREATE TABLE Student_Disciplinary
  (
   Disciplinary_Code Char(9) Primary Key
  ,Student_Code Char(9) Foreign Key REFERENCES Student_Info(Student_Code)
  ,Date_Event Date
  ,Event_Type Varchar(25)
  ,Event_Description Text
  ,Discipline Varchar(25)
  ,Duration Varchar(20)
  ,Principle_Code Char(7) Foreign Key REFERENCES HumanResources_EmployeePersonalInfo(Employee_Code)
  ,Teacher_Code Char(7) Foreign Key REFERENCES HumanResources_EmployeePersonalInfo(Employee_Code)
  ,School_Code Char(12) Foreign Key REFERENCES School_Info(School_Code)
  ,Date_Modified Datetime2(3)
  )
;

GO

;

CREATE TRIGGER trg_Student_Disciplinary_UpdateModifiedDate
ON Student_Disciplinary
AFTER UPDATE
AS
  UPDATE Student_Disciplinary
  SET Date_Modified = CURRENT_TIMESTAMP
  FROM inserted as I
    WHERE Student_Disciplinary.Date_Modified = I.Date_Modified
;


--Student_History


CREATE TABLE Student_History
  (
   Student_History_Code Char(9) Primary Key
  ,Student_Code Char(9) Foreign Key REFERENCES Student_Info(Student_Code)
  ,School_Code Char(12) Foreign Key REFERENCES School_Info(School_Code)
  ,Start_Date Date
  ,End_Date Date
  ,Transferred_In Bit
  ,Transferred_Out Bit
  ,Year_Retaken Int
  ,Retaken_Type Varchar(25)
  ,Date_Modified Datetime2(3)
  )
;

GO

;

CREATE TRIGGER trg_Student_History_UpdateModifiedDate
ON Student_History
AFTER UPDATE
AS
  UPDATE Student_History
  SET Date_Modified = CURRENT_TIMESTAMP
  FROM Inserted as I
	WHERE Student_History.Date_Modified = I.Date_Modified

