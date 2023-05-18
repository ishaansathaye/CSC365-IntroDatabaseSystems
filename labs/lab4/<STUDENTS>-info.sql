-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- Find all students who study in classroom 112. 
-- For each student list first and last name. Sort the output by the last name 
-- of the student in descending order.
SELECT l.FirstName, l.LastName
FROM list l, teachers t
WHERE l.classroom = t.classroom AND l.classroom = 112
ORDER BY l.LastName DESC;

-- Q2
-- For each classroom report the grade that is taught in it. Report just the 
-- classroom number and the grade number. Sort output by grade in 
-- ascending order.
SELECT DISTINCT t.classroom, l.grade
FROM teachers t, list l
WHERE t.classroom = l.classroom
ORDER BY l.grade ASC;

-- Q3
-- Find find the teacher of JEFFRY FLACHS. 
-- Report the teacher's first and last name.
SELECT t.First, t.Last
FROM teachers t, list l
WHERE t.classroom = l.classroom AND l.FirstName = 'JEFFRY' 
    AND l.LastName = 'FLACHS';

-- Q4
-- Assuming all classrooms in the school are organized in a long row with 
-- 101 on one end, 112 on the other end, and neighboring classrooms being 
-- different by 1 (for example, neighboring classes for 109 being 108 and 110), 
-- report the teachers who teach in the classrooms next door to LORIA ONDERSMA. 
-- Report the first and the last name of each teacher, sort output in ascending 
-- order by classroom number.
SELECT t.First, t.Last
FROM teachers lo, teachers t
WHERE lo.First = 'LORIA' AND lo.Last = 'ONDERSMA'
    AND (t.classroom = lo.classroom - 1 OR t.classroom = lo.classroom + 1)
ORDER BY t.classroom ASC;

-- Q5
-- Find all students who are in the same grade as LYNNETTE HOESCHEN but 
-- have a different teacher (i.e., study in a different classroom). 
-- Report results in ascending order by classroom, and students in each 
-- classroom in ascending order by their last name.
SELECT lh.FirstName, lh.LastName
FROM list l, list lh
WHERE l.FirstName = 'LYNNETTE' AND l.LastName = 'HOESCHEN'
    AND (l.grade = lh.grade AND l.classroom != lh.classroom)
ORDER BY lh.classroom ASC, lh.LastName ASC;
