-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- Find all customers who purchased, during the same trip to the bakery, two 
-- different (i.e., different flavor) Cookies, one of which is Tuile. Report 
-- the date of the purchase, and the first and last names of the customers in 
-- chronological order.
SELECT DISTINCT r1.SaleDate, c1.FirstName, c1.LastName
FROM customers c1, receipts r1, items i1, goods g1, items i2, goods g2, 
    receipts r2, customers c2
WHERE (c1.CId = r1.Customer AND r1.RNumber = i1.Receipt AND i1.Item = g1.GId)
    AND (i2.Item = g2.GId AND r2.RNumber = i2.Receipt AND r2.Customer = c2.CId)
    AND g1.Food = 'Cookie' AND g1.Flavor != g2.Flavor AND g2.Food = 'Cookie' 
    AND g2.Flavor = 'Tuile' 
    AND c1.CId = c2.CId AND r1.SaleDate = r2.SaleDate
ORDER BY r1.SaleDate, c1.LastName, c1.FirstName;

-- Q2
-- Find all days on which either ASHARRON TOUSSAND made a purchase that 
-- contained five items, or someone purchased a Gongolais Cookie. Sort dates 
-- in chronological order. Each date shall appear exactly once.
SELECT DISTINCT r.SaleDate
FROM customers c, receipts r, items i, goods g
WHERE (c.CId = r.Customer AND r.RNumber = i.Receipt AND i.Item = g.GId)
    AND ((c.FirstName = 'SHARRON' AND c.LastName = 'TOUSSAND' AND i.Ordinal = 5)
    OR (g.Flavor = 'Gongolais' AND g.Food = 'Cookie'))
ORDER BY r.SaleDate

-- Q3
-- Report the total amount of money JULIET LOGAN spent at the bakery during 
-- the first ten days of the month of October, 2007.
SELECT SUM(g.Price)
FROM customers c, receipts r, items i, goods g
WHERE c.CId = r.Customer AND r.RNumber = i.Receipt AND i.Item = g.GId 
    AND c.FirstName = 'JULIET' AND c.LastName = 'LOGAN' 
    AND r.SaleDate >= '2007-10-01' AND r.SaleDate <= '2007-10-10'

-- Q4
-- Report the total number of purchases (i.e., unique receipts) that included 
-- a cake.
SELECT COUNT(DISTINCT r.RNumber)
FROM customers c, receipts r, items i, goods g
WHERE c.CId = r.Customer AND r.RNumber = i.Receipt AND i.Item = g.GId 
    AND g.Food = 'Cake'

-- Q5
-- Report the total number of cakes bought in the bakery during the month of 
-- October of 2007.
SELECT COUNT(*)
FROM customers c, receipts r, items i, goods g
WHERE c.CId = r.Customer AND r.RNumber = i.Receipt AND i.Item = g.GId 
    AND g.Food = 'Cake' AND r.SaleDate >= '2007-10-01' 
    AND r.SaleDate <= '2007-10-31'
