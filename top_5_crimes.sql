-- Get Top 5 crimes of each year

CREATE VIEW topFiveCrimes AS
WITH aggregate_all AS
(
	SELECT 		YEAR(c.date_occ) AS crm_year, 
				MONTH(c.date_occ) AS crm_month, 
				c.crm_code, 
				COUNT(file_no) AS no_of_cases,
				ROW_NUMBER() OVER(PARTITION BY YEAR(c.date_occ), MONTH(c.date_occ) ORDER BY COUNT(c.file_no) DESC) AS top_rows
	FROM 		crimedatabase.dbo.crimedata c
	GROUP BY 	YEAR(c.date_occ), MONTH(c.date_occ), c.crm_code
)
SELECT 		*
FROM 		aggregate_all
WHERE 		top_rows < 6
--ORDER BY 	crm_year, crm_month, top_rows;	