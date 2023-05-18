-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- Find all pontiacs in the database (pontiac here is a model of the car) 
-- released before 1977. For each, report the name of the car and the year. 
-- Sort output by year.
SELECT ma.Make, c.Year
FROM models m, makes ma, cardata c
WHERE m.Model = 'PONTIAC' AND m.Model = ma.Model AND ma.Id = c.Id
    AND c.Year < 1977
ORDER BY c.Year;

SELECT ma.Make, c.Year
FROM models m, makes ma, cardata c, carmakers cm
WHERE m.Model = ma.Model AND ma.Id = c.Id
    AND (m.Model = 'PONTIAC' AND c.Year < 1977)
ORDER BY c.Year, ma.Make DESC;

-- Q2
-- Find all cars produced by Chrysler (the company) in 1976 and 1977. 
-- Report the name of the car and the year it was produced, sort output in 
-- ascending order by the year, and in alphabetical order within a single year.
SELECT ma.Make, c.Year
FROM models m, makes ma, cardata c, carmakers cm
WHERE cm.Maker = 'CHRYSLER' AND c.Id = ma.Id AND ma.Model = m.Model AND
    m.Maker = cm.Id AND (c.Year = 1976 OR c.Year = 1977)
ORDER BY c.Year, ma.Make;

-- Q3
-- Report all French and Swedish automakers. Output the full name of the 
-- automaker and the country of origin sorted alphabetically by the country, 
-- and then the full name of the automaker.
SELECT cm.FullName, co.Name
FROM carmakers cm, countries co
WHERE cm.Country = co.Id AND (co.Name = 'France' OR co.Name = 'Sweden')
ORDER BY co.Name, cm.FullName;

-- Q4
-- Find all non-four cylinder cars produced in 1979 that have a better 
-- fuel economy better than 20 MPG and that accelerate to 60 mph faster than 
-- in 18 seconds. Report the name of the car and the name of the automaker.
SELECT cm.Maker, ma.Make
FROM models m, makes ma, cardata c, carmakers cm
WHERE c.Id = ma.Id AND ma.Model = m.Model AND m.Maker = cm.Id
    AND (c.Year = 1979 AND c.Cylinders != 4 AND c.MPG > 20 AND c.Accelerate 
    < 18)

-- Q5
-- Find all American car makers which produced at least one light 
-- (weight less than 2000lbs) car between 1977 and 1979 (inclusively). 
-- Output the full name of the company and its home country sorted 
-- alphabetically by the company name. Each company should be reported just 
-- once.
SELECT DISTINCT cm.FullName, co.Name
FROM models m, makes ma, cardata c, carmakers cm, countries co, continents con
WHERE c.Id = ma.Id AND ma.Model = m.Model AND m.Maker = cm.Id
    AND cm.Country = co.Id AND co.Continent = con.Id
    AND (con.Name = 'america' AND c.Year >= 1977 AND c.Year <= 1979
    AND c.Weight < 2000)
ORDER BY cm.FullName;

-- Q6
-- For each Volvo ('volvo') released after 1971, compute the ratio between the 
-- weight of the car and its number of horsepowers. Report the full name of 
-- the car, the year it was produced and the ratio sorted in descending order 
-- by the ratio.
SELECT ma.Make, c.Year, c.Weight/c.Horsepower
FROM models m, makes ma, cardata c
WHERE m.Model = ma.Model AND ma.Id = c.Id
    AND (m.Model = 'volvo' AND c.Year > 1971)
ORDER BY c.Weight/c.Horsepower DESC;