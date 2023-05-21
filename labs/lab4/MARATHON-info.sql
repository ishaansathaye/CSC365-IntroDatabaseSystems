-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- Report the time, pace, name, and the overall place of all runners from 
-- LITTLE FERRY, NJ, sort output in order of finish.
SELECT m.Place, m.RunTime, m.FirstName, m.LastName, TIME_FORMAT(m.Pace, '%i:%s')
FROM marathon m
WHERE m.Town = 'LITTLE FERRY' AND m.State = 'NJ'
ORDER BY m.Place;

-- Q2
-- Report names (first, last), times, overall places as well as places in their 
-- sex-age group for all female runners from QUNICY, MA. Sort output by overall 
-- place in the race.
SELECT m.FirstName, m.LastName, m.Place, m.RunTime, m.GroupPlace
FROM marathon m
WHERE m.State = 'MA' AND m.Town = 'QUNICY' AND m.Sex = 'F'
ORDER BY m.Place;

-- Q3
-- Find the results for all 27-year old female runners from Rhode Island (RI). 
-- For each runner, output name (first, last), town, their place in the race 
-- and their place in their sex-age category, and the running time. 
-- Sort by time.
SELECT m.FirstName, m.LastName, m.Town, m.Place, m.GroupPlace, m.RunTime
FROM marathon m
WHERE m.Age = 27 AND m.Sex = 'F' AND m.State = 'RI'
ORDER BY m.RunTime;

-- Q4
-- Find all duplicate bibs in the race. Report just the bib numbers. 
-- Sort in ascending order of the bib number. Each duplicate bib number must 
-- be reported exactly once. 
-- (Note: without restrictions on what SQL functionality to use, 
-- this query can be implemented in a number of valid ways. Your task is 
-- to implement it using the SQL SELECT features allowed in this lab).
SELECT DISTINCT m.BibNumber
FROM marathon m, marathon m2
WHERE m.BibNumber = m2.BibNumber AND m.Place != m2.Place
ORDER BY m.BibNumber;

-- Q5
-- List all runners who took first place and second place in their respective 
-- age/sex groups. For each age group, output name (first, last) and age for 
-- both the winner and the runner up (in a single row). Order the output by 
-- gender, then by age group.
SELECT m.Sex, m.AgeGroup, m.FirstName, m.LastName, m.Age, m2.FirstName, 
    m2.LastName, m2.Age
FROM marathon m, marathon m2
WHERE m.AgeGroup = m2.AgeGroup AND m.Sex = m2.Sex 
    AND (m.GroupPlace = 1 AND m2.GroupPlace = 2)
ORDER BY m.Sex, m.AgeGroup;
