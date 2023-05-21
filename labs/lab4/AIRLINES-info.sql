-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- Find all airlines that have at least one flight out of the Akutan (KQA) 
-- airport. Report the full name and the abbreviation of each airline. Report 
-- each name only once. Sort the airlines in alphabetical order.
SELECT DISTINCT a.Name, a.Abbr
FROM airlines a, flights f
WHERE f.Source = 'KQA' AND f.Airline = a.Id
ORDER BY a.Name;

-- Q2
-- Find all destinations served from the KQA airport by Delta. Report flight 
-- number, airport code and the full name of the airport. Sort in ascending 
-- order by flight number.
SELECT f.FlightNo, a.Code, a.Name
FROM flights f, airports a, airlines al
WHERE f.Airline = al.Id AND f.Destination = a.Code
    AND al.Abbr = 'Delta' AND f.Source = 'KQA'
ORDER BY f.FlightNo;

-- Q3
-- Find all other destinations that are accessible from KQA on only Delta 
-- flights with exactly one change-over. Report pairs of flight numbers, 
-- airport codes for the final destinations, and full names of the airports 
-- sorted in alphabetical order by the airport code.
SELECT f1.FlightNo, f2.FlightNo, a.Code, a.Name
FROM flights f1, flights f2, airports a, airlines al1, airlines al2
WHERE f1.Airline = al1.Id AND f2.Airline = al2.Id
    AND f1.Destination = f2.Source AND f2.Destination = a.Code
    AND al1.Abbr = 'Delta' AND al2.Abbr = 'Delta'
    AND f1.Source = 'KQA' AND f2.Destination != 'KQA'
ORDER BY a.Code;

-- Q4
-- Report all pairs of airports served by both Delta and JetBlue. Each pair 
-- must be reported exactly once (if a pair X,Y is reported, than a pair Y,X 
-- is redundant and should not be reported). For each airport, report its code 
-- and its full name.
SELECT a1.Name, a1.Code, a2.Name, a2.Code
FROM flights f1, flights f2, airlines al1, airlines al2, airports a1, airports a2
WHERE f1.Airline = al1.Id AND f2.Airline = al2.Id
    AND f1.Source = a1.Code AND f2.Destination = a2.Code
    AND (al1.Abbr = 'Delta' AND f1.FlightNo MOD 2 = 1) 
    AND (al2.Abbr = 'JetBlue' AND f2.FlightNo MOD 2 = 1)
    AND (f1.Source = f2.Source AND f1.Destination = f2.Destination)

-- Q5
-- Find all airports served by ALL five of the airlines listed below: Delta, 
-- Frontier, USAir, UAL, and Southwest. Report just the airport codes, sorted 
-- in alphabetical order.
SELECT DISTINCT a.Code
FROM flights f1, airlines a1, flights f2, airlines a2, flights f3, airlines a3,
    flights f4, airlines a4, flights f5, airlines a5, airports a
WHERE f1.Airline = a1.Id AND f2.Airline = a2.Id AND f3.Airline = a3.Id
    AND f4.Airline = a4.Id AND f5.Airline = a5.Id
    AND a1.Abbr = 'Delta' AND a2.Abbr = 'Frontier' AND a3.Abbr = 'USAir'
    AND a4.Abbr = 'UAL' AND a5.Abbr = 'Southwest'
    AND f1.Destination = f2.Destination AND f2.Destination = f3.Destination
    AND f3.Destination = f4.Destination AND f4.Destination = f5.Destination
    AND f5.Destination = a.Code
ORDER BY a.Code;

-- Q6
-- Find all airports that are served by at least three Delta flights. Report 
-- just the three-letter codes of the airports --- each code exactly once, in 
-- alphabetical order.
SELECT DISTINCT ap.Code
FROM flights f1, flights f2, flights f3, airlines a, airports ap
WHERE f1.Airline = a.Id AND f2.Airline = a.Id AND f3.Airline = a.Id
    AND a.Abbr = 'Delta'
    AND f1.Destination = f2.Destination AND f2.Destination = f3.Destination
    AND f3.Destination = ap.Code
    AND f1.FlightNo != f2.FlightNo AND f2.FlightNo != f3.FlightNo
    AND f1.FlightNo != f3.FlightNo
ORDER BY ap.Code;
