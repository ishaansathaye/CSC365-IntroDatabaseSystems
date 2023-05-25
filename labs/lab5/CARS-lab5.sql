-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- Find all cars made after 1980 with gas mileage better than the 1982 honda 
-- civic. Report full name of the car, year it was made and the name of the 
-- manufacturer. Sort output in descending order by gas mileage.
SELECT ma.Make, c.Year, cm.Maker
FROM cardata c, makes ma, models mo, carmakers cm,
    cardata c2, makes ma2, models mo2, carmakers cm2
WHERE c.Id = ma.Id AND ma.Model = mo.Model AND mo.Maker = cm.Id
    AND c2.Id = ma2.Id AND ma2.Model = mo2.Model AND mo2.Maker = cm2.Id
    AND ma2.Make = 'honda civic' AND c2.year = 1982
    AND c.Year > 1980 AND c.MPG > c2.MPG
ORDER BY c.MPG DESC;

-- Q2
-- Find the average, maximum and minimum horsepower for 4-cylinder vehicles 
-- manufactured by French automakers between 1971 and 1976 inclusively.
SELECT AVG(c.Horsepower), MAX(c.Horsepower), MIN(c.Horsepower)
FROM cardata c, makes ma, models mo, carmakers cm, countries co
WHERE c.Id = ma.Id AND ma.Model = mo.Model AND mo.Maker = cm.Id 
    AND cm.Country = co.Id AND co.Name = 'France' AND c.Year >= 1971
    AND c.Year <= 1976 AND c.Cylinders = 4;

-- Q3
-- Find how many cars produced in 1971 had better acceleration than a 1972 
-- volvo 145e (sw). Report just the number.
SELECT COUNT(*)
FROM cardata c, makes ma, models mo, carmakers cm,
    cardata c2, makes ma2, models mo2, carmakers cm2
WHERE c.Id = ma.Id AND ma.Model = mo.Model AND mo.Maker = cm.Id 
    AND c2.Id = ma2.Id AND ma2.Model = mo2.Model AND mo2.Maker = cm2.Id
    AND c.Year = 1971 AND c2.Year = 1972 AND ma2.Make = 'volvo 145e (sw)'
    AND c.Accelerate < c2.Accelerate;

-- Q4
-- Find how many different car manufacturers produced a vehicle heavier than 
-- 5000 lbs.
SELECT COUNT(DISTINCT cm.Maker)
FROM cardata c, makes ma, models mo, carmakers cm
WHERE c.Id = ma.Id AND ma.Model = mo.Model AND mo.Maker = cm.Id
    AND c.Weight > 5000;
