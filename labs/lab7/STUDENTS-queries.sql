-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- Find the teacher(s) who teach(es) the smallest number of students. Report 
-- the name of the teacher(s) (first and last) and the number of students in 
-- their class.
SELECT t.Last, t.First, COUNT(l.FirstName) AS numStudents
FROM teachers t, list l
WHERE t.classroom = l.classroom
GROUP BY t.First, t.Last
HAVING COUNT(l.FirstName) = (SELECT MIN(numStudents)
    FROM (SELECT COUNT(l2.FirstName) AS numStudents
        FROM teachers t2, list l2
        WHERE t2.classroom = l2.classroom
        GROUP BY t2.First, t2.Last) AS numStudents)
ORDER BY t.Last ASC, t.First ASC;

-- Q2
-- Find the grade/grades with the largest average number of students in the 
-- class. Report the grade(s), and the average number of students in it/them.
SELECT l.grade, AVG(numStudents) AS avgStudents
FROM list l, (SELECT t.classroom, COUNT(l.FirstName) AS numStudents
    FROM teachers t, list l
    WHERE t.classroom = l.classroom
    GROUP BY t.classroom) AS numStudents
WHERE l.classroom = numStudents.classroom
GROUP BY l.grade
HAVING AVG(numStudents) = (SELECT MAX(avgStudents)
    FROM (SELECT AVG(numStudents) AS avgStudents
        FROM list l, (SELECT t.classroom, COUNT(l.FirstName) AS numStudents
            FROM teachers t, list l
            WHERE t.classroom = l.classroom
            GROUP BY t.classroom) AS numStudents
        WHERE l.classroom = numStudents.classroom
        GROUP BY l.grade) AS avgStudents)
ORDER BY l.grade;

-- Q3
-- Find the grade/grades in which the student(s) with the longest name(s) 
-- (fist+last) studies/study. Report the grade(s) and the name(s) of the 
-- student(s). (Use built-in MySQL functions LENGTH() and CONCAT() to get 
-- there).
SELECT l.grade, l.FirstName, l.LastName
FROM list l
WHERE LENGTH(CONCAT(l.FirstName, ' ', l.LastName)) = (SELECT MAX(nameLength)
    FROM (SELECT LENGTH(CONCAT(l2.FirstName, ' ', l2.LastName)) AS nameLength
        FROM list l2) AS nameLength);

-- Q4
-- Find all pairs of classrooms with the same number of students in them. 
-- Report each pair only once. Report both classrooms and the number of 
-- students. Sort output in ascending order by the number of students in the 
-- classroom.
WITH
    studentsClassroom AS (
        SELECT t.classroom, COUNT(l.FirstName) AS numStudents
        FROM teachers t, list l
        WHERE t.classroom = l.classroom
        GROUP BY t.classroom
    )
SELECT s1.classroom AS c1, s2.classroom AS c2, s1.numStudents
FROM studentsClassroom s1, studentsClassroom s2
WHERE s1.classroom < s2.classroom AND s1.numStudents = s2.numStudents
ORDER BY s1.numStudents;

-- Q5
-- For each grade with more than one classroom, report the last name of the 
-- teacher who teachers the classroom with the largest number of students in 
-- the grade. Output results in ascending order by the grade.
WITH
    validGrades AS (
        SELECT grade
        FROM list
        GROUP BY grade
        HAVING COUNT(DISTINCT classroom) > 1
    ),
    numStudents AS (
        SELECT l.grade, t.Last, COUNT(l.FirstName) AS numStudents
        FROM list l, teachers t
        WHERE l.classroom = t.classroom
        GROUP BY l.grade, t.Last
    ),
    maxStudents AS (
        SELECT grade, MAX(numStudents) AS maxStudents
        FROM numStudents
        GROUP BY grade
    )
SELECT n.grade, n.Last
FROM numStudents n, maxStudents m, validGrades v
WHERE n.grade = m.grade AND n.numStudents = m.maxStudents AND n.grade = v.grade
ORDER BY n.grade;
