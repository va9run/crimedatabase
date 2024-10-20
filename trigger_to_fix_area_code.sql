-- Trigger: trg_updateCrimeData
-- Purpose: Automatically updates the 'area_code' in the 'crimedatabase.dbo.crimedata' table whenever new rows are inserted into the 'crimedatabase.dbo.fixeddata' table.
-- Details: This trigger fires after new data is inserted into 'fixeddata'. It updates the 'area_code' in the 'crimedatabase.dbo.crimedata' table to match the 'area_code' from the newly inserted 'fixeddata' row based on a matching 'file_no'.
-- Usage: Ensures that the 'area_code' in 'crimedata' is synchronized with any new entries in 'fixeddata' that share the same 'file_no', maintaining data consistency across tables.

CREATE TRIGGER 		trg_updateCrimeData
ON 					crimedatabase.dbo.fixeddata 
AFTER INSERT 
AS
BEGIN 
	UPDATE 			crimedatabase.dbo.crimedata
	SET 			area_code = I.area_code
	FROM 			crimedatabase.dbo.crimedata AS c 
	INNER JOIN 		inserted AS I ON c.file_no  = I.file_no
END;