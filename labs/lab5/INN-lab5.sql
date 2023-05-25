-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- Find all rooms that were occupied on all three of the following dates: 
-- February 16, 2010, July 12, 2010 and October 20, 2010. Report just the 
-- full name of the room and the room code. Sort output in alphabetical order 
-- by room name.
SELECT DISTINCT r.RoomCode, r.RoomName
FROM rooms r, reservations res, reservations res2, reservations res3
WHERE r.RoomCode = res.Room AND r.RoomCode = res2.Room AND r.RoomCode = res3.Room
    AND (res.CheckIn <= '2010-02-16' AND res.CheckOut >= '2010-02-16')
    AND (res2.CheckIn <= '2010-07-12' AND res2.CheckOut >= '2010-07-12')
    AND (res3.CheckIn <= '2010-10-20' AND res3.CheckOut >= '2010-10-20')
ORDER BY r.RoomName ASC;

-- Q2
-- Find the total number of seven-night stays in rooms with modern decor.
SELECT COUNT(*)
FROM rooms r, reservations res
WHERE r.RoomCode = res.Room AND r.Decor = 'modern'
    AND DATEDIFF(res.CheckOut, res.CheckIn) = 7;

-- Q3
-- Find the number of August reservations (both check-in and checkout dates 
-- are in August) where two adults are staying with two children.
SELECT COUNT(*)
FROM reservations res
WHERE res.CheckIn >= '2010-08-01' AND res.CheckIn <= '2010-08-31'
    AND res.CheckOut >= '2010-08-01' AND res.CheckOut <= '2010-08-31'
    AND res.Adults = 2 AND res.Kids = 2;

-- Q4
-- Find the average number of nights of stay in the 'Interim but salutary' 
-- room for all reservations that commenced May 1, 2010 or later and ended 
-- before August 31, 2010.
SELECT AVG(DATEDIFF(res.CheckOut, res.CheckIn))
FROM rooms r, reservations res
WHERE r.RoomCode = res.Room AND r.RoomName = 'Interim but salutary'
    AND (res.CheckIn >= '2010-05-01' AND res.CheckOut < '2010-08-31');

-- Q5
-- Find how many different durations of stay for trips that commenced and 
-- ended in July of 2010 were in 'Interim but salutary' room.
SELECT COUNT(DISTINCT DATEDIFF(res.CheckOut, res.CheckIn))
FROM rooms r, reservations res
WHERE r.RoomCode = res.Room AND r.RoomName = 'Interim but salutary'
    AND (res.CheckIn >= '2010-07-01' AND res.CheckOut <= '2010-07-31');
