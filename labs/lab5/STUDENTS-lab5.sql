-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- Find all pairs of students with the same first name. Report each pair of 
-- students exactly once. Report first and last names of each of the two 
-- students, and their grades.
SELECT DISTINCT l1.FirstName, l1.LastName, l1.Grade, 
    l2.FirstName, l2.LastName, l2.Grade
FROM list l1, list l2
WHERE l1.FirstName = l2.FirstName AND l1.LastName < l2.LastName
ORDER BY l1.FirstName, l1.LastName, l2.FirstName, l2.LastName;

-- Q2
-- Find all fourth-grade students who are NOT taught by GORDON KAWA. Report 
-- their first and last names in alphabetical order by last name.
SELECT DISTINCT l.FirstName, l.LastName
FROM list l, teachers t
WHERE l.Grade = 4 AND l.Classroom = t.Classroom AND t.Last != 'KAWA'
ORDER BY l.LastName, l.FirstName;

-- Q3
-- Report the total number of first graders and second graders in the school.
SELECT COUNT(*)
FROM list
WHERE Grade = 1 OR Grade = 2

-- Q4
-- Find the number of classmates of ELTON FULVIO (excluding Elton himself).
SELECT COUNT(*)
FROM list l1, list l2
WHERE l1.FirstName = 'ELTON' AND l1.LastName = 'FULVIO' 
    AND l1.Classroom = l2.Classroom AND l1.FirstName != l2.FirstName 
    AND l1.LastName != l2.LastName;
