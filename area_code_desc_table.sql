SELECT 			DISTINCT c.area_code, c.area_name 
INTO 			crimedatabase.dbo.areaCodeData
FROM 			crimedatabase.dbo.crimedata c 
WHERE 			c.area_code IS NOT NULL
ORDER BY 		c.area_code ASC;