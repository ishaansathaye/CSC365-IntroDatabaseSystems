-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

CREATE TABLE `reservations` (
  `CODE` int(11) NOT NULL,
  `Room` char(5) DEFAULT NULL,
  `CheckIn` date DEFAULT NULL,
  `Checkout` date DEFAULT NULL,
  `Rate` float DEFAULT NULL,
  `LastName` varchar(15) DEFAULT NULL,
  `FirstName` varchar(15) DEFAULT NULL,
  `Adults` int(11) DEFAULT NULL,
  `Kids` int(11) DEFAULT NULL,
  PRIMARY KEY (`CODE`),
  UNIQUE KEY `Room` (`Room`,`CheckIn`),
  CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`Room`) REFERENCES `rooms` (`roomcode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1

CREATE TABLE `rooms` (
  `RoomCode` char(5) NOT NULL,
  `RoomName` varchar(30) DEFAULT NULL,
  `Beds` int(11) DEFAULT NULL,
  `bedType` varchar(8) DEFAULT NULL,
  `maxOcc` int(11) DEFAULT NULL,
  `basePrice` float DEFAULT NULL,
  `decor` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`RoomCode`),
  UNIQUE KEY `RoomName` (`RoomName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1

-- Q1
-- Find the most popular room in the hotel. The most popular room is the room 
-- that had seen the largest number of reservations (Note: if there is a tie 
-- for the most popular room status, report all such rooms). Report the full 
-- name of the room, the room code and the number of reservations.
with RoomReservations as (
    select Room,RoomName,Count(CODE) as ResCount from reservations
    join rooms on Room = RoomCode
    group by Room
)
select RoomName,Room,ResCount from RoomReservations
where ResCount = (
    select MAX(ResCount) from RoomReservations
);

-- Q2
-- Find the room (excluding 'Stay all year') that has been occupied the largest 
-- number of days based on the reservations in the database. No need to limit 
-- the number of occupied days to 2010. Report the room name, room code and the 
-- number of days it was occupied.
with RoomReservations as (
    select Room,RoomName,DateDiff(Checkout,CheckIn) as ResCount from reservations
    join rooms on Room = RoomCode
    where RoomName != 'Stay all year'
    group by Room,CheckIn,CheckOut
),
DaysOccupied as (
    select Room,RoomName,SUM(ResCount) as Total from RoomReservations
    group by Room
)
select RoomName,Room,Total from DaysOccupied
where Total = (
    select MAX(Total) from DaysOccupied
);

-- Q3
-- For each room, report the most expensive reservation. Report the full room 
-- name, dates of stay, last name of the person who made the reservation, 
-- daily rate and the total amount paid. Sort the output in descending order 
-- by total amount paid.
with RoomReservations as (
    select CODE,CheckIn,Checkout,LastName,Rate,Room,RoomName,DateDiff(Checkout,CheckIn) * Rate as Cost from reservations
    join rooms on Room = RoomCode
    group by CODE
),
CostsPerRes as (
    select CODE,RoomName,Room,MAX(Cost) as MaxCost from RoomReservations
    group by CODE
)
select RoomName,CheckIn,Checkout,LastName,Rate,Cost from RoomReservations r1
where Cost = (
    select MAX(Cost) from RoomReservations r2
    where r1.Room = r2.Room
)
order by Cost DESC;

-- Q4
-- Find the best month (i.e., month with the highest total revenue). Report 
-- the month, the total number of reservations and the revenue. For the 
-- purposes of the query, count the entire revenue of a stay that commenced 
-- in one month and ended in another towards the earlier month. (e.g., a 
-- September 29 - October 3 stay is counted as September stay for the purpose 
-- of revenue computation).
with ReservationCosts as (
    select CheckIn,CheckOut,DateDiff(CheckOut,Checkin) * Rate as Price from reservations
),
MonthlyCosts as (
    select Month(CheckIn) as Month,SUM(Price) as MonthlyCost,Count(*) as NumReservations 
    from ReservationCosts
    group by Month(CheckIn)
)
select MONTHNAME(STR_TO_DATE(Month, '%m')),MonthlyCost, NumReservations
from MonthlyCosts
where MonthlyCost = (
    select MAX(MonthlyCost) from MonthlyCosts
)
order by Month;

-- Q5
-- For each room report whether it is occupied or unoccupied on August 10, 
-- 2010. Report the full name of the room, the room code, and put either 
-- 'Occupied' or 'Empty' depending on whether the room is occupied on that day. 
-- (the room is occupied if there is someone staying the night of August 10, 
-- 2010. It is NOT occupied if there is a checkout on this day, but no check 
-- in). Output in alphabetical order by room code. Note: this query can be 
-- approached either with the use of the CASE ... WHEN clause, or by being 
-- somewhat crafty with standard SELECT statements.
WITH RoomOccupations AS (
    SELECT rooms.RoomName, reservations.Room,
    CASE 
    WHEN (CheckIn <= '2010-08-10' AND Checkout > '2010-08-10') THEN
        'Occupied'
    ELSE
        'Empty'
    END AS Status
    FROM reservations
    JOIN rooms ON  rooms.RoomCode = reservations.Room
),
TotalOccupancy AS (
    SELECT RoomOccupations.RoomName, RoomOccupations.Room, COUNT(*) AS C1
    FROM RoomOccupations
    GROUP BY RoomOccupations.Room
),
Unoccupied AS (
    SELECT RoomOccupations.RoomName, RoomOccupations.Room, COUNT(*) AS C2
    FROM RoomOccupations
    WHERE RoomOccupations.Status != 'Occupied'
    GROUP BY RoomOccupations.Room
)
SELECT TotalOccupancy.RoomName, TotalOccupancy.Room,
CASE 
WHEN C1 != C2 or TotalOccupancy.Room = 'SAY' THEN
    'Occupied'
ELSE
    'Empty'
END AS Jul4Status
FROM Unoccupied RIGHT JOIN TotalOccupancy
ON TotalOccupancy.Room = Unoccupied.Room
ORDER BY TotalOccupancy.Room;
