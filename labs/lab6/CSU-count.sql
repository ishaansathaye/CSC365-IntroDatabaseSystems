-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- For each campus that averaged more than $2300 in fees between 2000 and 2004 
-- (inclusive), report the average FTE undergraduate enrollment over those 
-- years. Sort output in descending order of average enrollment.
SELECT c.Campus, AVG(e.FTE)
FROM campuses c, enrollments e, fees f
WHERE e.CampusId = c.Id AND f.Year >= 2000 AND f.Year <= 2004
    AND (f.CampusId = c.Id AND f.Year = e.Year)
GROUP BY c.Campus
HAVING AVG(f.Fee) > 2300
ORDER BY AVG(e.FTE) DESC;

-- Q2
-- For each campus for which data exists for more than 60 years, report the 
-- average, the maximum and the minimum enrollment (for all years), and the 
-- standard deviation. Sort your output in descending order by average 
-- enrollment.
SELECT c.Campus, MIN(e.Enrolled), AVG(e.Enrolled), MAX(e.Enrolled),
    STD(e.Enrolled)
FROM campuses c, enrollments e
WHERE c.Id = e.CampusId
GROUP BY c.Campus
HAVING COUNT(DISTINCT e.Year) > 60
ORDER BY AVG(e.Enrolled) DESC;

-- Q3
-- For each campus in LA and Orange counties compute the overall revenue 
-- received from students starting the year 2001 (i.e., in the 21st century). 
-- Use "warm body" enrollment numbers (not FTEs) for your 
-- computations. The number you compute technically is not quite the 
-- full revenue, but it's a good approximation. Sort output in descending 
-- order by the revenue.
SELECT c.Campus, SUM(e.Enrolled * f.Fee) AS Revenue
FROM campuses c, enrollments e, fees f
WHERE e.CampusId = c.Id AND e.Year >= 2001 
    AND (f.CampusId = c.Id AND f.year = e.Year)
    AND c.County IN ('Los Angeles', 'Orange')
GROUP BY c.Campus
ORDER BY Revenue DESC;

-- Q4
-- For each campus that had more than 20000 enrolled students in 2004 report 
-- the number of disciplines for which the campus had non-zero graduate 
-- enrollment. Sort the output in alphabetical order by the name of the 
-- campus. (This query should exclude campuses that had no graduate enrollment 
-- at all).
SELECT c.Campus, COUNT(DISTINCT de.Discipline)
FROM campuses c, enrollments e, discEnr de
WHERE c.Id = e.CampusId AND e.CampusId = de.CampusId AND e.Year = 2004
    AND e.Enrolled > 20000 AND de.Gr > 0
GROUP BY c.Campus
ORDER BY c.Campus ASC;
