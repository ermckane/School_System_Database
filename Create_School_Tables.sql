--School_Info


CREATE TABLE School_Info
  (
   School_Code Char(12) Primary Key
  ,School_Name Varchar(75)
  ,School_Type Varchar(25)
  ,Street Varchar(25)
  ,City Varchar(50)
  ,State Char(2)
  ,Zipcode Varchar (11)
  ,Description Text
  ,Date_Modified Datetime2(3)
  )
;

GO

;

CREATE TRIGGER trg_School_Info_UpdateModifiedDate
ON School_Info
AFTER UPDATE
AS
  UPDATE School_Info
  SET Date_Modified = CURRENT_TIMESTAMP
  FROM Inserted as I
    WHERE School_Info.School_Code = I.School_Code
;


--School_Histoty


CREATE TABLE School_History
  (
   History_Code Char(7) Primary Key
  ,School_Code Char(12) Foreign Key REFERENCES School_Info(School_Code)
  ,Renovation_Start Date
  ,Renovation_End Date
  ,Reno_Description Text
  ,Donation_Date Date
  ,Donation_Start Date
  ,Donation_Amount BigInt
  ,Donation_Description Text
  ,Date_Modified Datetime2(3)
  )
;

GO

;

CREATE TRIGGER trg_School_History_UpdateModifiedDate
ON School_History
AFTER UPDATE
AS
  UPDATE School_History
  SET Date_Modified = CURRENT_TIMESTAMP
  FROM Inserted AS I
     WHERE School_History.Date_Modified = I.Date_Modified
