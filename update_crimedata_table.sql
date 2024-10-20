DROP TABLE IF EXISTS crimedatabase.dbo.updated_crimedata;
WITH area_code AS
(
	SELECT		area_code,
				area_name
	FROM 		crimedatabase.dbo.crimedata
	WHERE 		area_code is NOT NULL
),
fill_area_code AS 
(
	SELECT 		c.file_no,
				c.date_rptd,
				c.date_occ,
				c.time_occ,
				d.area_code,
				c.area_name,
				c.rpt_dist_no,
				c.crm_code,
				c.crm_code_description AS crm_code_desc,
				c.modus_operandi,
				c.victim_age,
				c.victim_sex,
				c.vitim_descent AS victim_descent,
				c.premise_code,
				c.premise_code_desc,
				c.weapon_used_code,
				c.weapon_desc,
				c.status_code,
				c.status_desc,
				c.crm_code_1,
				c.crm_code_2,
				c.crm_code_3,
				c.crm_code_4,
				c.crm_location,
				c.cross_street,
				c.latitude AS lat,
				c.longitude AS lon
	FROM 		crimedatabase.dbo.crimedata AS c
	INNER JOIN 	area_code AS d
	ON 			c.area_name = d.area_name
)
SELECT 			*
INTO 			crimedatabase.dbo.updated_crimedata
FROM 			fill_area_code;
