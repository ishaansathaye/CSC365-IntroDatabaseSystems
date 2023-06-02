-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- Report all customers who made more than 10 different purchases 
-- (unique receipts) from the bakery. Report first and last name of the 
-- customer, sort output in alphabetical order by last name.
SELECT DISTINCT c.FirstName, c.LastName, COUNT(DISTINCT r.RNumber) 
    AS num_purchases
FROM customers c, receipts r
WHERE c.CId = r.Customer
GROUP BY c.CId
HAVING num_purchases > 10
ORDER BY c.LastName, c.FirstName;

-- Q2
-- For each flavor of cookie report total number of times it was purchased 
-- (count the actual cookies, not receipts), number of unique customers who 
-- purchased the cookie, and the total sales amount. Sort output in 
-- alphabetical order by cookie flavor.
SELECT g.Flavor, COUNT(i.Item) AS num_purchases, 
    COUNT(DISTINCT r.Customer) AS num_customers, 
    SUM(g.Price) AS total_sales
FROM goods g, items i, receipts r
WHERE g.GId = i.Item AND i.Receipt = r.RNumber AND g.Food = 'cookie'
GROUP BY g.Flavor
ORDER BY g.Flavor;

-- Q3
-- For each day of the week of October 15 (Monday to Sunday) report the total 
-- number of purchases (receipts), the total number of pastries purchased and 
-- the overall daily revenue. Report results in chronological order and include 
-- both the day of the week and the date. (Note: the total amounts paid may 
-- look strange, if you are using floating points for prices.)
SELECT DATE_FORMAT(r.SaleDate, '%W'), r.SaleDate, COUNT(DISTINCT r.RNumber),
    COUNT(i.Item), SUM(g.Price)
FROM receipts r, items i, goods g
WHERE r.RNumber = i.Receipt AND i.Item = g.GId
    AND r.SaleDate >= '2007-10-15' AND r.SaleDate < '2007-10-22'
GROUP BY r.SaleDate
ORDER BY r.SaleDate;

-- Q4
-- Find all purchases that totaled $25 or more. Report the customer who made 
-- the purchase, the receipt number, and the total amount of the purchase. 
-- Sort output in descending order by the total amount.
SELECT c.FirstName, c.LastName, r.RNumber, SUM(g.Price) AS total
FROM customers c, receipts r, items i, goods g
WHERE c.CId = r.Customer AND r.RNumber = i.Receipt AND i.Item = g.GId
GROUP BY r.RNumber
HAVING total >= 25
ORDER BY total DESC;

-- Q5
-- For each customer, count the number of times they purchased exactly five 
-- items from the bakery on a single receipt. Report last name, first name, 
-- and the number of five-item purchases sorted in chronological order by the 
-- last purchase made, breaking the ties in alphabetical order of the last 
-- name. (note: if you study the database carefully, you will discover that 
-- the maximum number of items purchased on the same receipt in is five).
SELECT c.FirstName, c.LastName, COUNT(r.RNumber) AS num_purchases
FROM customers c, receipts r, items i
WHERE c.CId = r.Customer AND r.RNumber = i.Receipt AND i.Ordinal = 5
GROUP BY c.CId
ORDER BY MAX(r.SaleDate) ASC, c.LastName, c.FirstName;
