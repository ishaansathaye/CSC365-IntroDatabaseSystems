-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- For each room report the total revenue for all stays and the average 
-- revenue per stay generated by stays in the room that originated in the 
-- months of June, July, and August (combined). Sort output in descending 
-- order by total revenue. (Output full room names).
SELECT r.RoomName, SUM(res.Rate * (DATEDIFF(res.CheckOut, res.CheckIn))) 
    AS TotalRevenue, 
    AVG(res.Rate * (DATEDIFF(res.CheckOut, res.CheckIn))) AS AvgRevenue
FROM reservations res, rooms r
WHERE r.RoomCode = res.Room AND (res.CheckIn >= '2010-06-01' 
    AND res.CheckIn <= '2010-08-31')
GROUP BY res.Room
ORDER BY TotalRevenue DESC;

-- Q2
-- Report the total number of reservations in 2010 that commenced on Mondays 
-- and ended on Saturdays and the total revenue they brought in.
SELECT COUNT(*), SUM(res.Rate * (DATEDIFF(res.CheckOut, res.CheckIn))) 
    AS TotalRevenue
FROM reservations res
WHERE WEEKDAY(res.CheckIn) = 0 AND WEEKDAY(res.CheckOut) = 5
    AND (res.CheckIn >= '2010-01-01' AND res.CheckIn <= '2010-12-31');

-- Q3
-- For each day of the week, report the total number of reservations longer 
-- than five (5) days that commenced on it and the total revenue these 
-- reservations brought. Report days of week as Monday, Tuesday, etc. Sort 
-- output by day of week (Monday, Tuesday, Wednesday, Thursday, Friday, 
-- Saturday, Sunday) (NOTE: this query is a bit nasty, but is very doable. You 
-- may need the built-in MOD() function)
SELECT DAYNAME(res.Checkin), COUNT(*), 
    SUM(res.Rate * (DATEDIFF(res.CheckOut, res.CheckIn))) AS TotalRevenue
FROM reservations res
WHERE DATEDIFF(res.CheckOut, res.CheckIn) > 5
GROUP BY MOD(DAYOFWEEK(res.CheckIn) + 5, 7), DAYNAME(res.Checkin)
ORDER BY MOD(DAYOFWEEK(res.CheckIn) + 5, 7);

-- Q4
-- For each room report the total number of people who stayed in it in 2010 
-- (all reservations that started in 2010). Report full names of the rooms, 
-- sort in descending order by the total number of people.
SELECT r.RoomName, SUM(res.Adults + res.Kids) AS TotalPeople
FROM reservations res, rooms r
WHERE r.RoomCode = res.Room AND (res.CheckIn >= '2010-01-01' 
    AND res.CheckIn <= '2010-12-31')
GROUP BY res.Room
ORDER BY TotalPeople DESC;

-- Q5
-- For each room report how many nights in 2010 the room was occupied. Report 
-- the room code, the full name of the room and the number of occupied nights. 
-- Sort in descending order by occupied nights. Note: it has to be number of 
-- nights in 2010 - the last reservation in each room may and will go beyond 
-- December 31, 2010, so the "extra" nights in 2011 need to be deducted. 
-- Note/Hint: This is almost an extra credit problem. While multiple solutions 
-- are possible, my solution uses SQL's SIGN() built-in function which 
-- returns -1 for negative numbers, +1 for positive numbers, and 0 for 0.
SELECT r.RoomCode, r.RoomName, SUM(DATEDIFF(LEAST(res.Checkout, '2010-12-31'), 
    GREATEST(res.Checkin, '2009-12-31'))) AS nights
FROM reservations res, rooms r
WHERE r.RoomCode = res.Room AND res.Checkin <= '2010-12-31' 
    AND res.Checkout >= '2010-01-01'
GROUP BY res.Room, r.RoomName
ORDER BY nights DESC;
