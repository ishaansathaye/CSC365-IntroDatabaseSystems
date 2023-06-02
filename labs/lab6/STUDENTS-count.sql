-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- Report the names of teachers who have two or three students in their classes. 
-- Sort output in alphabetical order by teacher's last name.
SELECT DISTINCT t.Last, t.First
FROM teachers t, list l
WHERE t.classroom = l.classroom
GROUP BY t.classroom
HAVING COUNT(l.LastName) = 2 OR COUNT(l.LastName) = 3
ORDER BY t.Last, t.First;

-- Q2
-- For each grade, report, in a single row, all classrooms this grade is taught 
-- in (classrooms should be in ascending order).
SELECT grade, GROUP_CONCAT(DISTINCT classroom 
    ORDER BY classroom ASC SEPARATOR ', ')
FROM list
GROUP BY grade;

-- Q3
-- For each kindergarden classroom, report the total number of students. Sort 
-- output in the descending order by the number of students.
SELECT classroom, COUNT(FirstName) AS num_students
FROM list
WHERE grade = 0
GROUP BY classroom
ORDER BY num_students DESC;

-- Q4
-- For each first grade classroom, report the student (last name) who is the 
-- first (alphabetically) on the class roster. Sort output by classroom.
SELECT classroom, MIN(LastName) AS first_student
FROM list
WHERE grade = 1
GROUP BY classroom
ORDER BY classroom;
