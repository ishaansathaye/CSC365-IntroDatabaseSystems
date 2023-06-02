-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- Find all airports with exactly 19 outgoing flights. Report airport code and 
-- the full name of the airport sorted in alphabetical order by the code.
SELECT a.Code, a.Name
FROM airports a, flights f
WHERE a.Code = f.Source
GROUP BY a.Code
HAVING COUNT(*) = 19
ORDER BY a.Code ASC;

-- Q2
-- Find the number of airports from which airport LTS can be reached with 
-- exactly one transfer. (make sure to exclude LTS itself from the count). 
-- Report just the number.
SELECT COUNT(DISTINCT f2.Source)
FROM flights f, flights f2
WHERE f.Destination = 'LTS' AND f.Source = f2.Destination
    AND f2.Source != 'LTS';

-- Q3
-- Find the number of airports from which airport LTS can be reached with AT 
-- MOST one transfer. (make sure to exclude LTS itself from the count). 
-- Report just the number.
SELECT COUNT(DISTINCT(f.Source))
FROM flights f, flights f2
WHERE (f.Destination = f2.Source AND f.Source != f2.Destination
    OR (f.Source = f2.Source AND f.Destination = f2.Destination))
    AND f2.Destination = 'LTS';

-- Q4
-- For each airline report the total number of airports from which it has at 
-- least two different outgoing flights. Report the full name of the airline 
-- and the number of airports computed. Report the results sorted by the number 
-- of airports in descending order.
SELECT a.Name, COUNT(DISTINCT f.Source)
FROM airlines a, flights f, flights f2
WHERE a.Id = f.Airline AND (f.Source = f2.Source AND f.FlightNo != f2.FlightNo
    AND f.Airline = f2.Airline)
GROUP BY a.Name
HAVING COUNT(DISTINCT f.Source) >= 2
ORDER BY COUNT(DISTINCT f.Source) DESC, a.Name ASC;
