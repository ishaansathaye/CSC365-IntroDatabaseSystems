-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- Report the average of degrees granted by California Polytechnic State 
-- University-San Luis Obispo in the period between 1995 and 2000 (inclusively).
SELECT AVG(Degrees)
FROM degrees d, campuses c
WHERE d.CampusId = c.Id AND 
    c.Campus = 'California Polytechnic State University-San Luis Obispo'
    AND d.Year >= 1995 AND d.Year <= 2000;

-- Q2
-- Find the largest, the smallest and the average fee on a CSU campus in 2002.
SELECT MIN(f.fee), AVG(f.fee), MAX(f.fee)
FROM fees f, campuses c
WHERE f.CampusId = c.Id AND f.Year = 2002;

-- Q3
-- Report the average student to faculty (use student FTE to faculty FTE ratio) 
-- ratio in 2004 among the campuses where 2004 enrollment (FTE numbers) was 
-- greater than 15000.
SELECT AVG(e.FTE/f.FTE)
FROM enrollments e, faculty f, campuses c
WHERE e.CampusId = f.CampusId AND e.CampusId = c.Id 
    AND e.Year = 2004 AND f.Year = 2004 AND e.FTE > 15000;

-- Q4
-- Report all years in which either there were more than 17000 students 
-- (NOT FTEs) on California Polytechnic State University-San Luis Obispo 
-- campus, or California Polytechnic State University-San Luis Obispo 
-- graduated (gave degrees) to more than 3500 students. Report years in 
-- chronological order, with each year reported once.
SELECT DISTINCT e.Year
FROM enrollments e, degrees d, campuses c
WHERE e.CampusId = c.Id AND d.CampusId = c.Id 
    AND c.Campus = 'California Polytechnic State University-San Luis Obispo'
    AND (e.Enrolled > 17000 OR d.Degrees > 3500)
ORDER BY e.Year ASC;
