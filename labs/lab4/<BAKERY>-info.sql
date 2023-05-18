-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- Find all cookies that cost between $1 and $2 (inclusive). 
-- Report the name of the cookie (flavor, food) and the price, 
-- sort output in alphabetical order by the cookie flavor.
SELECT Flavor, Food, Price
FROM goods g
WHERE g.Price <= 2 AND g.Price >= 1
    AND g.Food = 'Cookie'
ORDER BY Flavor;

-- Q2
-- Report the prices of the following items: (a) any Pie (b) any item priced 
-- between $3.40 and $3.65 (inclusive) (c) Any Croissant except the Apple one. 
-- Output the flavor, the name (food type) and the price of each pastry. 
-- Output results in ascending order by price.
SELECT Flavor, Food, Price
FROM goods g
WHERE g.Food = 'Pie' OR (g.Price <= 3.65 AND g.Price >= 3.40) 
    OR (g.Food = 'Croissant' AND g.Flavor != 'Apple')
ORDER BY Price ASC;

-- Q3
-- Find all customers who made a purchase on October 17, 2007. 
-- Report the name of the customer (first, last). Sort the output in 
-- alphabetical order by the customer's last name. The output shall 
-- contain NO duplicate names.
SELECT DISTINCT c.LastName, c.FirstName
FROM customers c, receipts r
WHERE c.CId = r.Customer AND r.SaleDate = '2007-10-17'
ORDER BY c.LastName;

-- Q4
-- Find all different Croissants items purchased on October 9, 2007. 
-- Each tart (flavor, food) is to be listed once. Sort output in alphabetical 
-- order by the Croissant flavor.
SELECT DISTINCT g.Flavor, g.Food
FROM goods g, items i, receipts r
WHERE g.GId = i.Item AND i.Receipt = r.RNumber AND r.SaleDate = '2007-10-09'
    AND g.Food = 'Croissant'
ORDER BY g.Flavor;

-- Q5
-- Find all purchases which involved two (or more) of the same 
-- Apricot-flavored item. Report the receipt number, the name of the item 
-- purchases, and the date of the purchase. Sort in chronological order.
-- Use only basic SQL Select Statement
SELECT DISTINCT r.RNumber, g.Flavor, g.Food, r.SaleDate
FROM goods g, items i, receipts r, goods g2, items i2, receipts r2
WHERE (g.GId = i.Item AND i.Receipt = r.RNumber AND g.Flavor = 'Apricot')
    AND (g2.GId = i2.Item AND i2.Receipt = r2.RNumber AND g2.Flavor = 'Apricot')
    AND (r.RNumber = r2.RNumber AND i.Ordinal != i2.Ordinal AND 
        i.Item = i2.Item)
ORDER BY r.SaleDate;

-- Q6
-- Find the day on which MIGDALIA STADICK made multiple purchases 
-- (i.e., had at least two different receipts from the bakery). Report just 
-- the date (if multiple dates match the query, report them in chronological 
-- order).
SELECT DISTINCT r.SaleDate
FROM customers c, receipts r, customers c2, receipts r2
WHERE (c.CId = r.Customer AND c.LastName = 'STADICK' AND 
    c.FirstName = 'MIGDALIA')
    AND (c2.CId = r2.Customer AND c2.LastName = 'STADICK' AND
    c2.FirstName = 'MIGDALIA')
    AND (r.SaleDate = r2.SaleDate AND r.RNumber != r2.RNumber)
ORDER BY r.SaleDate;
