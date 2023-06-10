-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- Find the customer(s) who spent the most at the bakery in October of 2007. 
-- Report first and last name.
WITH CustomerSpending AS (
    SELECT Customer, FirstName, LastName, SUM(PRICE) AS Spent FROM receipts 
    JOIN items ON Receipt = RNumber
    JOIN goods ON GId = Item
    JOIN customers ON Customer = CId
    WHERE SaleDate >= '2007-10-01' AND SaleDate <= '2007-10-31'
    GROUP BY Customer
)
SELECT FirstName, LastName 
FROM CustomerSpending
WHERE Spent = (
    SELECT MAX(Spent) FROM CustomerSpending
);

-- Q2
-- Find the customers who never purchased an eclair ('Eclair') (in October 
-- of 2007). Report their first and last names in alphabetical order by last 
-- name.
WITH FullTable AS (
    SELECT * FROM receipts 
    JOIN items ON Receipt = RNumber
    JOIN goods ON GId = Item
    JOIN customers ON Customer = CId
    WHERE SaleDate >= '2007-10-01' AND SaleDate <= '2007-10-31'
)
SELECT DISTINCT FirstName, LastName FROM FullTable
WHERE Customer NOT IN (
    SELECT DISTINCT Customer FROM FullTable
    WHERE Food = 'Eclair'
)
ORDER BY LastName;

-- Q3
-- Find all people who bought more cakes than cookies in October of 2007. 
-- Report their names in alphabetical order by last name.
WITH Cakes AS (
    SELECT Customer,FirstName,LastName,Count(*) AS Cakes from receipts 
    JOIN items ON Receipt = RNumber
    JOIN goods ON GId = Item
    JOIN customers ON Customer = CId
    WHERE SaleDate >= '2007-10-01' AND SaleDate <= '2007-10-31'
    AND Food = 'Cake'
    GROUP BY Customer
), Cookies AS (
    SELECT Customer,FirstName,LastName,Count(*) AS Cookies from receipts 
    JOIN items ON Receipt = RNumber
    JOIN goods ON GId = Item
    JOIN customers ON Customer = CId
    WHERE SaleDate >= '2007-10-01' AND SaleDate <= '2007-10-31'
    AND Food = 'Cookie'
    GROUP BY Customer
)
SELECT FirstName,LastName FROM Cakes
WHERE Cakes > (
    SELECT Cookies FROM Cookies
    WHERE Cookies.Customer = Cakes.Customer
)
ORDER BY LastName;

-- Q4
-- Find the most popular (by number of pastries sold) item (or items). Report 
-- the item (food, flavor) and its total number of sales.
with GoodsSold as (
    SELECT Food,Flavor,Count(*) as Sold from receipts 
    JOIN items ON Receipt = RNumber
    JOIN goods ON GId = Item
    group by Food,Flavor
)
SELECT Flavor,Food,Sold from GoodsSold
where Sold = (
    SELECT MAX(Sold) from GoodsSold
);

-- Q5
-- Find the day of the highest revenue in the month of October, 2007.
with DayRevenue as (
    SELECT SaleDate,SUM(PRICE) as Revenue from receipts 
    JOIN items ON Receipt = RNumber
    JOIN goods ON GId = Item
    where SaleDate >= '2007-10-01' and SaleDate <= '2007-10-31'
    group by SaleDate
)
SELECT SaleDate from DayRevenue
where Revenue = (
    SELECT MAX(Revenue) from DayRevenue
);

-- Q6
-- Find the best-selling item (by number of purchases) on the day of the 
-- highest revenue in October of 2007.
with DayRevenue as (
    SELECT SaleDate,SUM(PRICE) as Revenue from receipts 
    JOIN items ON Receipt = RNumber
    JOIN goods ON GId = Item
    where SaleDate >= '2007-10-01' and SaleDate <= '2007-10-31'
    group by SaleDate
),
GoodsSold as (
    SELECT SaleDate,Food,Flavor,Count(*) as Sold from receipts 
    JOIN items ON Receipt = RNumber
    JOIN goods ON GId = Item
    group by Food,Flavor,SaleDate
),
GoodsSoldMaxDay as (
    SELECT Food,Flavor,Sold from GoodsSold 
    where SaleDate = (
        SELECT SaleDate from DayRevenue
        where Revenue = (
            SELECT MAX(Revenue) from DayRevenue
        )
    )
)
SELECT Food,Flavor,Sold from GoodsSoldMaxDay
where Sold = (
    SELECT MAX(Sold) from GoodsSoldMaxDay
);

-- Q7
-- For every type of Cake report the customer(s) who purchased it the largest 
-- number of times during the month of October 2007. Report the name of the 
-- pastry (flavor, food type), the name of the customer (first, last), and the 
-- number of purchases made. Sort output in descending order on the number of 
-- purchases, then in alphabetical order by cake flavor, then in alphabetical 
-- order by last name of the customer.
with CakesPerCustomer as (
    SELECT Customer,FirstName,LastName,Flavor,Food,Count(*) as qty from receipts 
    JOIN items ON Receipt = RNumber
    JOIN goods ON GId = Item
    JOIN customers ON Customer = CId
    where 
    SaleDate >= '2007-10-01' 
    and SaleDate <= '2007-10-31'
    and Food = 'Cake'
    group by Customer,Flavor,Food
)
SELECT Flavor,Food,FirstName,LastName,qty from CakesPerCustomer c1
where qty = (
    SELECT MAX(qty) from CakesPerCustomer c2
    where c2.Flavor = c1.Flavor
)
order by qty DESC,Flavor,LastName;

-- Q8
-- Output the names of all customers who did not make a purchase between 
-- October 19 and October 23 (inclusive) of 2007. Output first and last 
-- names in alphabetical order by last name.
SELECT FirstName,LastName 
FROM (
    SELECT distinct Customer from receipts 
    where Customer not in (
        SELECT distinct Customer from receipts
        where (SaleDate >= '2007-10-19' and SaleDate <= '2007-10-23')
        order by Customer
    )
) t1
JOIN customers ON CId = Customer
order by LastName;

-- Q9
-- For each customer report (in a single row per customer) the number of 
-- purchases of Eclairs, Danishes, and Pies. If the customer did not purchase 
-- one or more of these items, you are allowed to report NULL for that 
-- purchase. Sort output in alphabetical order by customer last name.
WITH Eclairs AS (
    SELECT Customer, COUNT(*) AS Eclairs FROM receipts 
    JOIN items ON Receipt = RNumber
    JOIN goods ON GId = Item
    WHERE Food = 'Eclair'
    GROUP BY Customer
), Danishes AS (
    SELECT Customer, COUNT(*) AS Danishes FROM receipts 
    JOIN items ON Receipt = RNumber
    JOIN goods ON GId = Item
    WHERE Food = 'Danish'
    GROUP BY Customer
), Pies AS (
    SELECT Customer, COUNT(*) AS Pies FROM receipts 
    JOIN items ON Receipt = RNumber
    JOIN goods ON GId = Item
    WHERE Food = 'Pie'
    GROUP BY Customer
)
SELECT FirstName, LastName, Eclairs, Danishes, Pies 
FROM customers
LEFT JOIN Eclairs ON CId = Eclairs.Customer
LEFT JOIN Danishes ON CId = Danishes.Customer
LEFT JOIN Pies ON CId = Pies.Customer
ORDER BY LastName;

-- Q10
-- Find out if the sales of Chocolate-flavored items (in terms of revenue) or 
-- the sales of Croissants (of all flavors) were higher in October of 2007. 
-- Output the word Chocolate, if the sales of Chocolate-flavored items had 
-- higher revenue, or the word Croissant if the sales of Croissants had higher 
-- revenue. Note: This can be done in a number of ways. One way involved the 
-- CASE ... WHEN clause inside the SELECT clause, but there are ways of 
-- building the output without the use of any "exotic" features.
with CroissantRevenue as (
    SELECT SUM(PRICE) as Crois from receipts 
    JOIN items ON Receipt = RNumber
    JOIN goods ON GId = Item
    where Food = 'Croissant'
),
ChocolateRevenue as (
    SELECT SUM(PRICE) as Choc,Flavor from receipts 
    JOIN items ON Receipt = RNumber
    JOIN goods ON GId = Item
    where Flavor = 'Chocolate'
)
SELECT  
CASE WHEN Choc > Crois 
THEN
'Chocolate'
ELSE
'Croissant'
END
FROM ChocolateRevenue JOIN CroissantRevenue;
