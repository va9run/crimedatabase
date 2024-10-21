-- Create a aggregated table for crime data

CREATE VIEW crimeAggregate AS
WITH aggregate_data AS
(
	SELECT 		c.date_occ,
				c.crm_code,
				c.area_code,
				CASE 
					WHEN c.time_occ BETWEEN 0 AND 499 THEN 'midnight/before sunrise'
					WHEN c.time_occ BETWEEN 500 AND 799 THEN 'early morning'
					WHEN c.time_occ BETWEEN 800 AND 1199 THEN 'morning/before noon'
					WHEN c.time_occ BETWEEN 1200 AND 1699 THEN 'afternoon'
					WHEN c.time_occ BETWEEN 1700 AND 2099 THEN 'evening'
					WHEN c.time_occ BETWEEN 2100 AND 2400 THEN 'night'
				END AS crm_time,
				CASE 
					WHEN c.victim_age BETWEEN 1 AND 12 THEN 'child'
					WHEN c.victim_age BETWEEN 13 AND 17 THEN 'teen'
					WHEN c.victim_age BETWEEN 18 AND 24 THEN 'young-adult'
					WHEN c.victim_age BETWEEN 25 AND 34 THEN 'adult'
					WHEN c.victim_age BETWEEN 35 AND 44 THEN 'middle-aged adult'
					WHEN c.victim_age BETWEEN 45 AND 54 THEN 'mature adult'
					WHEN c.victim_age BETWEEN 55 AND 64 THEN 'senior adult'
					WHEN c.victim_age >= 65 THEN 'elderly'
					ELSE 'unknown'
				END AS victim_age_group,
				CASE
					WHEN c.victim_sex = 'M' THEN 'male'
					WHEN c.victim_Sex = 'F' THEN 'female'
					ELSE 'unknown'
				END AS victim_sex,
				CASE 
					WHEN c.vitim_descent = 'A' OR 
						 c.vitim_descent = 'D' OR
						 c.vitim_descent = 'F' OR
						 c.vitim_descent = 'V' OR 
						 c.vitim_descent = 'C' OR 
						 c.vitim_descent = 'K' OR 
						 c.vitim_descent = 'J' OR 
						 c.vitim_descent = 'L'
					THEN 'asian'
					WHEN c.vitim_descent = 'Z' THEN 'indian asian'
					WHEN c.vitim_descent = 'G' THEN 'guamanian'
					WHEN c.vitim_descent = 'H' THEN 'hisp/latin/mex'
					WHEN c.vitim_descent = 'I' THEN 'indegineous'
					WHEN c.vitim_descent = 'P' THEN 'pacific islander'
					WHEN c.vitim_descent = 'S' THEN 'samoan'
					WHEN c.vitim_descent = 'U' THEN 'hawaiian'
					when c.vitim_descent = 'W' THEN 'white'
					WHEN c.vitim_descent = 'B' THEN 'black'
					ELSE 'unknown'
				END AS victim_descent,
				CASE 
					WHEN c.status_code = 'AA' THEN 'adult arrest'
					WHEN c.status_code = 'AO' THEN 'adult other'
					WHEN c.status_code = 'JA' THEN 'juv arrest'
					WHEN c.status_code = 'JO' THEN 'juv other'
					WHEN c.status_code = 'IC' THEN 'invest cont'
					ELSE 'unknown'
				END AS case_status,				
				c.file_no
	FROM 		crimedatabase.dbo.crimedata c
)
SELECT 		a.date_occ,
			a.crm_code,
			a.area_code,
			a.crm_time,
			a.victim_age_group,
			a.victim_sex,
			a.victim_descent,
			a.case_status,
			COUNT(a.file_no) AS no_of_cases 
FROM 		aggregate_data a 
GROUP BY 	a.date_occ, a.crm_code, a.area_code, a.crm_time, a.victim_age_group, a.victim_sex,
			a.victim_descent, a.case_status
			
			
--DROP VIEW IF EXISTS crimeAggregate