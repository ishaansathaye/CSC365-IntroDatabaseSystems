-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- Find all 'traditional' rooms with a base price above $170 and two beds. 
-- Report room names and codes in alphabetical order by the code.
SELECT r.RoomCode, r.RoomName
FROM rooms r
WHERE r.decor = 'traditional' AND r.basePrice > 170 AND r.Beds = 2
ORDER BY r.RoomCode;

-- Q2
-- Find all July reservations (i.e., all reservations that both start AND end 
-- in July) for the 'Frugal not apropos' room. For each reservation report the 
-- last name of the person who reserved it, check-in and check-out dates, the 
-- total number of people staying and the total cost of the reservation. Output 
-- reservations in chronological order.
SELECT res.LastName, res.Checkin, res.Checkout, res.Adults + res.Kids, 
    res.Rate * (res.Checkout - res.Checkin)
FROM reservations res, rooms r
WHERE res.Room = r.RoomCode AND r.RoomName = 'Frugal not apropos'
    AND res.Checkin >= '2010-07-01' AND res.Checkout <= '2010-07-31'
ORDER BY res.Checkin;

-- Q3
-- Find all rooms occupied on September 23, 2010. Report full name of the room, 
-- the check-in and checkout dates of the reservation. Sort output in 
-- alphabetical order by room name.
SELECT r.RoomName, res.Checkin, res.Checkout
FROM rooms r, reservations res
WHERE r.RoomCode = res.Room AND res.Checkin <= '2010-09-23' 
    AND res.Checkout > '2010-09-23'
ORDER BY r.RoomName;

-- Q4
-- For each stay of BO DURAN in the hotel, calculate the total amount of money, 
-- they paid. Report reservation code, checkin and checkout dates, room name 
-- (full) and the total amount of money the stay cost. Sort output in 
-- chronological order by the day of arrival. Output check-in and check-out 
-- dates in the "Month Day" format (e.g., 'July 19', no need to report year).
SELECT res.Code, r.RoomName, DATE_FORMAT(res.Checkin, '%M %e') AS Checkin, 
    DATE_FORMAT(res.Checkout, '%M %e') AS Checkout, res.Rate * 
    (res.Checkout - res.Checkin) AS PAID
FROM reservations res, rooms r
WHERE res.Room = r.RoomCode AND res.LastName = 'DURAN' AND res.FirstName = 'BO'
ORDER BY res.Checkin;

-- Q5
-- Find out all modern room reservations that overlapped in time with the stays 
-- of FRITZ SPECTOR. Report the full name of the room, the last name of the 
-- person placing the reservation, the checkin date and the number of nights. 
-- Sort output in chronological order, and in alphabetical order by room name 
-- for reservations that started on the same day.
SELECT DISTINCT r.RoomName, res.LastName, res.Checkin, DATEDIFF(
    res.Checkout, res.Checkin)
FROM reservations res, rooms r, reservations res2
WHERE res.Room = r.RoomCode AND r.decor = 'modern'
    AND res2.LastName = 'SPECTOR' AND res2.FirstName = 'FRITZ'
    AND res.LastName <> 'SPECTOR' AND res.FirstName <> 'FRITZ'
    AND ((res.Checkin >= res2.Checkin AND res.Checkin < res2.Checkout)
        OR (res.Checkout > res2.Checkin AND res.Checkout <= res2.Checkout)
        OR (res.Checkin <= res2.Checkin AND res.Checkout >= res2.Checkout))
ORDER BY res.Checkin, r.RoomName;

-- Q6
-- Report all reservations in rooms with beds of type 'Double' that contained 
-- four adults. For each reservation report its code, the full name and the 
-- code of the room, check-in and check out dates. Report reservations in 
-- chronological order, and sorted by the three-letter room code (in 
-- alphabetical order) for any reservations that commenced on the same day. 
-- Report check-in and check-out dates in the format 'Day Mon' (day followed by 
-- the abbreviated month), no year is required.
SELECT res.Code, r.RoomCode, r.RoomName,
    DATE_FORMAT(res.Checkin, '%e %b') AS Checkin, 
    DATE_FORMAT(res.Checkout, '%e %b') AS Checkout
FROM reservations res, rooms r
WHERE res.Room = r.RoomCode AND r.bedType = 'Double' AND res.Adults = 4
ORDER BY res.Checkin, r.RoomCode;
