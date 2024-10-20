SELECT 			DISTINCT c.crm_code, c.crm_code_description 
INTO 			crimedatabase.dbo.crimeCodeDesc
FROM 			crimedatabase.dbo.crimedata c 
ORDER BY 		c.crm_code ASC 