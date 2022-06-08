--Need to add comments and add original data files

Select top 10000 name into #Name_Last
from sql_practice.dbo.last_names
order by newid()
;



select top 5000 first_name into #Name_First
from sql_practice.dbo.first_names
order by newid()
;



select top 10000 name as Middle_Name into #Name_Middle
from sql_practice.dbo.last_names
order by newid()
;



select * into #All_Name
from #Name_First
cross join #Name_Last
;



select top 10000 name as Last_Name, first_name as First_Name into #First_Last_Name
from #Name_First
cross join #Name_Last
order by newid()
;



UPDATE #Name_Middle
SET Middle_Name=UPPER(LEFT(Middle_Name,1))+LOWER(SUBSTRING(Middle_Name,2,LEN(Middle_Name)))
;



UPDATE #First_Last_Name
SET Last_Name=UPPER(LEFT(Last_Name,1))+LOWER(SUBSTRING(Last_Name,2,LEN(Last_Name)))
;


DROP TABLE IF EXISTS #Student_Name
CREATE TABLE #Student_Name
  (
   Student_Code Char(9)
  ,First_Name Varchar(75)
  ,Middle_Name Varchar(75)
  ,Last_Name Varchar(75)
  )
 ;



WITH Firstlast 
AS
  (
   SELECT First_name, Last_name, ROW_NUMBER() OVER(ORDER BY NEWID()) AS Rank_Fl
   FROM #First_Last_Name 
  ) 
,Middle 
AS
  (
   SELECT Middle_Name, ROW_NUMBER() OVER(ORDER BY NEWID()) AS Rank_M
   FROM #Name_Middle
  )
INSERT INTO #Student_Name (First_Name, Middle_Name, Last_Name)
SELECT Fl.First_Name, M.Middle_Name as Middle_Name, Fl.Last_Name 
FROM Firstlast AS Fl
INNER JOIN Middle AS M
	ON Fl.Rank_Fl = M.Rank_M
;


--Joing the names with randomly generated student codes. 
--If duplicate is made, rerun again until works. 
--Unfortunately this method is not duplicate proof.


WITH Uncleaned_Code 
AS
   (
    SELECT  
	 ABS(CAST(CAST(NEWID() AS varbinary) AS int)) AS Student_Code_Unfixed
	,ROW_NUMBER() OVER(ORDER BY NEWID()) AS Rank_C
    FROM #Student_Name
   )
,Cleaned_Code
AS
   (
    SELECT
	 Rank_C
	,CASE
		WHEN LEN(Student_Code_Unfixed) > 9 THEN Student_Code_Unfixed / 4
		WHEN LEN(Student_Code_Unfixed) = 8 THEN Student_Code_Unfixed * 10
		WHEN LEN(Student_Code_Unfixed) = 7 THEN Student_Code_Unfixed * 100
		     ELSE Student_Code_Unfixed
	 END AS Student_Code
    FROM Uncleaned_Code
   )
,Names
AS
   (
    SELECT
	 First_Name
        ,Middle_Name
        ,Last_name
        ,ROW_NUMBER() OVER(ORDER BY NEWID()) AS Rank_N
    FROM #Student_Name
   )
,SocialSecurity
AS
  (
   SELECT  
	CONCAT(LEFT(ABS(CAST(CAST(NEWID() AS varbinary) AS int)), 3) 
	,'-'
	,SUBSTRING(CAST(ABS(CAST(CAST(NEWID() AS varbinary) AS int)) AS Char),3, 2)
        ,'-'
	,SUBSTRING(CAST(ABS(CAST(CAST(NEWID() AS varbinary) AS int)) AS Char),4, 4)) AS Social_Security
        ,ROW_NUMBER() OVER(ORDER BY NEWID()) AS Rank_S
    FROM #Student_Name
   )
,Collection
AS
  (
   SELECT 
   	CAST(Student_Code as Char) as Student_Code
       ,LOWER(CONCAT(LEFT(First_Name, 1), LEFT(Middle_Name, 1), LEFT(Last_Name, 1), SUBSTRING(CAST(Student_Code as Char),3, 3), RIGHT(Last_Name, 1))) as Student_ID
       ,Social_Security
       ,First_Name
       ,Middle_Name
       ,Last_Name
   FROM Cleaned_Code as C
   INNER JOIN Names as N
	 ON C.Rank_C = N.Rank_N
   INNER JOIN SocialSecurity as S
	 ON S.Rank_S = N.Rank_N
  )
INSERT INTO Student_Info (Student_Code, Student_Id, First_Name, Middle_Name, Last_Name, Social_Security)
SELECT Student_Code, Student_Id, First_Name, Middle_Name, Last_Name, Social_Security
FROM Collection
;


SELECT *
FROM Student_Info


