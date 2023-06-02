-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- For each European car maker (reported by their short name) report the 
-- average mileage per gallon of a car produced by and the corresponding 
-- standard deviation (feel free to use STD() for all standard deviations in 
-- this lab). Sort output in ascending order by the BEST MILEAGE of a car 
-- produced by the car maker. Exclude any NULL values.
SELECT cm.Maker, AVG(c.MPG), STD(c.MPG)
FROM cardata c, makes ma, models mo, carmakers cm, countries co, continents con
WHERE c.Id = ma.Id AND ma.Model = mo.Model AND mo.Maker = cm.Id 
    AND cm.Country = co.Id AND co.Continent = con.Id 
    AND con.Name = 'europe' AND c.MPG IS NOT NULL
GROUP BY mo.Maker
ORDER BY MAX(c.MPG);

-- Q2
-- For each US car maker (reported by their short name), report the number of 
-- 4-cylinder cars that are lighter than 4000 lbs , with 0 to 60 mph 
-- acceleration better than 14 seconds. Sort the output in descending order by 
-- the number of cars reported.
SELECT cm.Maker, COUNT(c.Id)
FROM cardata c, makes ma, models mo, carmakers cm, countries co
WHERE c.Id = ma.Id AND ma.Model = mo.Model AND mo.Maker = cm.Id 
    AND cm.Country = co.Id AND co.Name = 'usa' 
    AND c.Cylinders = 4 AND c.Weight < 4000 
    AND c.Accelerate < 14
GROUP BY mo.Maker
ORDER BY COUNT(c.Id) DESC;

-- Q3
-- For each year in which honda produced more than 2 models, report the best, 
-- the worst and the average gas mileage of TOYOTA (this is NOT a typo!) 
-- vehicles produced that year. Report results in chronological order. 
-- NOTE: Solve this query WITHOUT using NESTED QUERIES/Subqueries!
SELECT c.Year, MAX(c3.MPG), MIN(c3.MPG), AVG(c3.MPG)
FROM cardata c, makes ma, models mo, carmakers cm,
    cardata c2, makes ma2, models mo2, carmakers cm2,
    cardata c3, makes ma3, models mo3, carmakers cm3
WHERE c.Id = ma.Id AND ma.Model = mo.Model AND mo.Maker = cm.Id AND cm.Maker = 'honda'
    AND c2.Id = ma2.Id AND ma2.Model = mo2.Model AND mo2.Maker = cm2.Id AND cm2.Maker = 'honda'
    AND c.Year = c2.Year
    AND c3.Id = ma3.Id AND ma3.Model = mo3.Model AND mo3.Maker = cm3.Id AND cm3.Maker = 'toyota'
    AND c.Year = c3.Year
GROUP BY c.Year
HAVING COUNT(DISTINCT ma.Make) > 2
ORDER BY c.Year ASC;

-- Q4
-- For each year from 1975 to 1979 (inclusive) report the number of Japanese 
-- cars with less than 150 horsepowers. Sort output in chronological order.
SELECT c.Year, COUNT(c.Id)
FROM cardata c, makes ma, models mo, carmakers cm, countries co
WHERE c.Id = ma.Id AND ma.Model = mo.Model AND mo.Maker = cm.Id 
    AND cm.Country = co.Id AND co.Name = 'japan' 
    AND c.Year BETWEEN 1975 AND 1979 AND c.Horsepower < 150
GROUP BY c.Year
ORDER BY c.Year ASC;
