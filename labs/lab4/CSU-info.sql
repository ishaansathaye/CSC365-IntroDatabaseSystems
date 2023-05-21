-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- Report all campuses (full name of campus, year of foundation) that started 
-- their work before 1920, sort output in ascending order by the year of 
-- foundation.
SELECT c.Campus, c.Year
FROM campuses c
WHERE c.Year < 1920
ORDER BY c.Year;

-- Q2
-- For each year between 2000 and 2004 (inclusive) report the number of students
-- who graduated from San Diego State University. Output the year and the number
-- of degrees granted. Sort output by year.
SELECT d.Year, d.Degrees
FROM degrees d, campuses c
WHERE d.CampusId = c.Id AND c.Campus = 'San Diego State University'
    AND d.Year >= 2000 AND d.Year <= 2004
ORDER BY d.Year;

-- Q3
-- Report undergraduate and graduate enrollments (as two numbers) in 
-- 'Mathematics', 'Engineering' and 'Computer and Info. Sciences' disciplines
-- for both Polytechnic universities of the CSU system in 2004 as well as for 
-- the newest Polytechnic university, which in our database is still known 
-- as 'Humboldt State University'. Output the name of the campus, the 
-- discipline and the number of graduate and the number of undergraduate 
-- students enrolled. Sort output by campus name, and by discipline for each 
-- campus.
SELECT c.Campus, d.Name, de.Gr, de.Ug
FROM campuses c, disciplines d, discEnr de
WHERE c.Id = de.CampusId AND de.Discipline = d.Id
    AND (c.Campus = 'California Polytechnic State University-San Luis Obispo'
    OR c.Campus = 'California State Polytechnic University-Pomona'
    OR c.Campus = 'Humboldt State University')
    AND (d.Name = 'Mathematics' OR d.Name = 'Engineering'
    OR d.Name = 'Computer and Info. Sciences')
    AND de.Year = 2004
ORDER BY c.Campus, d.Name;

-- Q4
-- Find all situations when more than 25% of students graduated from a CSU 
-- campus in a given year (for enrollments, use the FTE number) in 1990s. 
-- Report the name of the campus, the year when this happened, and the 
-- percentage of the campus full-time-equivalent student body that graduated 
-- that year. Sort output in chronological order, and in alphabetical order 
-- by campus name within a single year.
SELECT c.Campus, d.Year, (d.Degrees / e.FTE)
FROM degrees d, enrollments e, campuses c
WHERE d.CampusId = e.CampusId AND d.Year = e.Year AND d.CampusId = c.Id
    AND d.Year >= 1990 AND d.Year <= 1999
    AND (d.Degrees / e.FTE) > 0.25
ORDER BY d.Year, c.Campus;

-- Q5
-- Find all disciplines and campuses where graduate enrollment in 2004 was at 
-- least four times higher than undergraduate enrollment and (where both 
-- graduate and graduate enrollments were non-zero). Report campus names, 
-- discipline names, and the undergraduate and graduate enrollments. Sort 
-- output by campus name, then by discipline name in alphabetical order.
SELECT c.Campus, d.Name, de.Ug, de.Gr
FROM campuses c, disciplines d, discEnr de
WHERE c.Id = de.CampusId AND de.Discipline = d.Id
    AND de.Ug != 0 AND de.Gr != 0
    AND de.Gr >= (4 * de.Ug)
    AND de.Year = 2004
ORDER BY c.Campus, d.Name;

-- Q6
-- Report the total amount of money collected from student fees (use the 
-- full-time equivalent enrollment for computations) at San Diego State 
-- University for each year between 2000 and 2004 inclusively, and the amount 
-- of money collected from student fees per one full-time equivalent faculty. 
-- Output the year, the two computed numbers sorted chronologically by year.
SELECT f.Year, (f.fee * e.FTE), (f.fee * e.FTE / fa.FTE)
FROM fees f, enrollments e, faculty fa, campuses c
WHERE f.CampusId = e.CampusId AND f.CampusId = fa.CampusId
    AND f.CampusId = c.Id AND c.Campus = 'San Diego State University'
    AND f.Year >= 2000 AND f.Year <= 2004
    AND e.Year = f.Year AND fa.Year = f.Year
ORDER BY f.Year;

-- Q7
-- Find all campuses where enrollment in 2003 (use the FTE numbers), was 
-- higher than the 2003 enrollment in 'San Jose State University'. Report the 
-- name of campus, the 2003 enrollment number, the number of faculty teaching 
-- that year, and the student-to-faculty ratio. Sort output in ascending order 
-- by student-to-faculty ratio.
SELECT c.Campus, e.FTE, fa.FTE, (e.FTE / fa.FTE)
FROM campuses c, enrollments e, faculty fa, campuses c2, enrollments e2
WHERE c.Id = e.CampusId AND c.Id = fa.CampusId
    AND c2.Id = e2.CampusId
    AND c2.Campus = 'San Jose State University'
    AND e.Year = 2003 AND fa.Year = 2003 AND e2.Year = 2003
    AND e.FTE > e2.FTE
ORDER BY (e.FTE / fa.FTE);
