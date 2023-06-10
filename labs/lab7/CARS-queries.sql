-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- Report the most powerful (in terms of horsepowers) vehicle. Report the 
-- name of the vehicle, the year it was produced, and the horsepowers.
SELECT m.Make AS VehicleName, c.Year, c.Horsepower
FROM cardata c
JOIN makes m ON c.Id = m.Id
WHERE c.Horsepower = (
    SELECT MAX(Horsepower)
    FROM cardata
);

-- Q2
-- Among the vehicles with the best gas mileage, report the one with the best 
-- acceleration. Report full name and the year of production.
SELECT m.Make AS VehicleName, c.Year
FROM cardata c
JOIN makes m ON c.Id = m.Id
WHERE c.MPG = (
    SELECT MAX(MPG)
    FROM cardata
)
AND c.Accelerate = (
    SELECT MIN(Accelerate)
    FROM cardata
    WHERE MPG = (
        SELECT MAX(MPG)
        FROM cardata
    )
);

-- Q3
-- For each country report the automaker with the largest number of cars in the 
-- database. Report the name of the country, the short name of the automaker. 
-- Output in alphabetical order by country. (Note: we are looking for cars in 
-- the table where the car data is specified, not just for some models).
WITH
    CountryCars AS (
        SELECT co.Name AS CountryName, cm.Maker AS VehicleMaker
        FROM cardata c
        JOIN makes m ON c.Id = m.Id
        JOIN models mo ON m.Model = mo.Model
        JOIN carmakers cm ON mo.Maker = cm.Id
        JOIN countries co ON cm.Country = co.Id
    ),
    CountryCarsCount AS (
        SELECT CountryName, VehicleMaker, COUNT(*) AS Count
        FROM CountryCars
        GROUP BY CountryName, VehicleMaker
    ),
    CountryCarsMax AS (
        SELECT CountryName, MAX(Count) AS MaxCount
        FROM CountryCarsCount
        GROUP BY CountryName
    )
SELECT CountryCarsCount.CountryName, CountryCarsCount.VehicleMaker
FROM CountryCarsCount
JOIN CountryCarsMax ON CountryCarsCount.CountryName = CountryCarsMax.CountryName
WHERE CountryCarsCount.Count = CountryCarsMax.MaxCount
ORDER BY CountryCarsCount.CountryName;

-- Q4
-- For each year find the automakers whose models for that year were (on 
-- average) the heaviest. Report the year, the automaker, the number of 
-- different vehicles the automaker produced that year and the average 
-- ACCELERATION (not a typo). Exclude any automakers that produced only one car 
-- in a particular year from consideration for that year. Present the output 
-- in chronological order.
WITH groupedYearMakers AS (
    SELECT c.Year, cm.Maker AS VehicleMaker, COUNT(*) as numModels, 
        AVG(c.Weight) AvgWeight, AVG(c.Accelerate) as AvgAcceleration
    FROM cardata c
    JOIN makes m ON c.Id = m.Id
    JOIN models mo ON m.Model = mo.Model
    JOIN carmakers cm ON mo.Maker = cm.Id
    GROUP BY c.Year, cm.Maker
    HAVING numModels > 1
), groupedYear AS (
    SELECT g.Year, MAX(g.AvgWeight) AS AvgWeight
    FROM groupedYearMakers g
    GROUP BY g.Year
)
SELECT g.Year, g.VehicleMaker, g.numModels, g.AvgAcceleration
FROM groupedYearMakers g, groupedYear gy
WHERE g.Year = gy.Year AND g.AvgWeight = gy.AvgWeight
ORDER BY g.Year;

-- Q5
-- Find the difference in gas milage between the most fuel-efficient 8-cylinder 
-- model and the least fuel-efficient 4-cylinder model. Report just the number.
WITH
    EightCylinders AS (
        SELECT m.Make AS VehicleName, c.MPG
        FROM cardata c
        JOIN makes m ON c.Id = m.Id
        WHERE Cylinders = 8
        AND MPG = (
            SELECT MAX(MPG)
            FROM cardata
            WHERE Cylinders = 8
        )
    ),
    FourCylinders AS (
        SELECT m.Make AS VehicleName, c.MPG
        FROM cardata c
        JOIN makes m ON c.Id = m.Id
        WHERE Cylinders = 4
        AND MPG = (
            SELECT MIN(MPG)
            FROM cardata
            WHERE Cylinders = 4
        )
    )
SELECT EightCylinders.MPG - FourCylinders.MPG AS Difference
FROM EightCylinders, FourCylinders;

-- Q6
-- For each year between 1972 and 1976 (inclusively) find if US automakers or 
-- all other automakers produced more different cars. Report, in chronological 
-- order either 'us' or 'rest of the world' for each year, depending on whether
-- the US automakers had more different cars produced, or fewer. Report 'tie' 
-- in case of a tie\footnote{If you discover that no ties exist in the years 
-- considered, you are allowed not to include the logic for reporting the 
-- output 'tie' into your query. But if the ties do exist, this logic must be 
-- there, and the output must be correct.}. Note: you can use CASE WHEN 
-- statements for this query, or try to do this w/o the CASE WHEN.
WITH
    USCars AS (
        SELECT c.Year, COUNT(*) AS Count
        FROM cardata c
        JOIN makes m ON c.Id = m.Id
        JOIN models mo ON m.Model = mo.Model
        JOIN carmakers cm ON mo.Maker = cm.Id
        JOIN countries co ON cm.Country = co.Id
        WHERE co.Name = 'usa'
        GROUP BY c.Year
    ),
    WorldCars AS (
        SELECT c.Year, COUNT(*) AS Count
        FROM cardata c
        JOIN makes m ON c.Id = m.Id
        JOIN models mo ON m.Model = mo.Model
        JOIN carmakers cm ON mo.Maker = cm.Id
        JOIN countries co ON cm.Country = co.Id
        WHERE co.Name != 'usa'
        GROUP BY c.Year
    )
SELECT USCars.Year, CASE WHEN USCars.Count > WorldCars.Count THEN 'us' 
    WHEN USCars.Count < WorldCars.Count THEN 'rest of the world' ELSE 'tie' 
    END AS Output
FROM USCars
JOIN WorldCars ON USCars.Year = WorldCars.Year
WHERE USCars.Year BETWEEN 1972 AND 1976
ORDER BY USCars.Year;
