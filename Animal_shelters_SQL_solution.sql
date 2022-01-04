WITH no_sponsored AS -- Creating a CTE table to remove all sponsored animal from selection
	(
	SELECT animalid,
		sponsorid,
		animals.animaltype,
		birthdate, 
		weight,
		2021 - extract(year from (cast(birthdate as date))) AS age, -- creating an age column to join the age_cost table
		animals.location,
		CASE WHEN animals.animaltype = 'Dog' AND weight <= 10 THEN 'DS' 
			WHEN animals.animaltype = 'Dog' AND weight > 30 THEN 'DL'
			WHEN animals.animaltype = 'Dog' AND (weight > 10 OR weight <= 30) THEN 'DM'
			WHEN animals.animaltype = 'Cat' AND weight <= 5 THEN 'CS'
			WHEN animals.animaltype = 'Cat' AND weight > 7 THEN 'CL'
			WHEN animals.animaltype = 'Cat' AND (weight > 5 OR weight <= 7) THEN 'CM'
			WHEN animals.animaltype = 'Bird' AND weight <= 0.7 THEN 'BS'
			WHEN animals.animaltype = 'Bird' AND weight > 1.1 THEN 'BL'
			WHEN animals.animaltype = 'Bird' AND (weight > 0.7 OR weight <= 1.1) THEN 'DM'
		END AS sizeid -- created foriegn key 'sizeid' to join size_costs table
    FROM animals 
	LEFT JOIN sponsored_animals ON animals.animalid = sponsored_animals.sponsorid -- joining sponsored table
	WHERE sponsorid IS NULL -- removing all sponsored animal from the result
	),
	calculation_table AS -- CTE table to hold calculations
	(
	SELECT no_sponsored.animaltype,
	   size, 
	   SUM(size_costs.costs + location_costs.costs + age_costs.costs) as total -- calculating total cost of taking care of animals
	FROM no_sponsored
	LEFT JOIN size_costs ON no_sponsored.sizeid = size_costs.sizeid -- joining size_costs table
	LEFT JOIN location_costs ON no_sponsored.location = location_costs.location -- joining location_costs table
	LEFT JOIN age_costs ON no_sponsored.age = CAST(age_costs.age as int) -- joining age cost table and converting age column to integer
	GROUP BY no_sponsored.animaltype, size -- grouping table by animal type, then by size 
	)

-- selecting result from CTE table
SELECT animaltype,
	   size,
	   total,
       CAST((total * 100 / percentage_deno) AS DECIMAL(12,2)) AS percentage -- calculating percentage
-- Subquerying so i can use percentage_demo to find the percentage cost for sub category of animals
FROM (SELECT animaltype, 
			 size,
			 total,
			 CASE WHEN animaltype = 'Bird' THEN (select sum(total)from calculation_table where animaltype = 'Bird')
				  WHEN animaltype = 'Cat' THEN (select sum(total)from calculation_table where animaltype = 'Cat')
				  ELSE (select sum(total)from calculation_table where animaltype = 'Dog')
			 END AS percentage_deno -- findind the total cost of animals
		FROM calculation_table
		GROUP BY animaltype, size, total) AS result -- naming subquery result
ORDER BY animaltype, size DESC