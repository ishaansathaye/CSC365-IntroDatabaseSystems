-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- Find the most popular red grape (i.e., the grape that is used to make the 
-- largest number of red wines) in San Luis Obispo County. Report the name of 
-- the grape. Do not use limit.
WITH validGrapes AS (
    SELECT g.Grape, COUNT(g.Grape) AS numWines
    FROM grapes g
    JOIN wine w ON g.Grape = w.Grape
    JOIN appellations a ON w.Appellation = a.Appellation
    WHERE g.Color = 'red' AND a.County = 'San Luis Obispo'
    GROUP BY g.Grape
)
SELECT Grape
FROM validGrapes
WHERE numWines = (
    SELECT MAX(numWines)
    FROM validGrapes
);

-- Q2
-- Report the grape with the largest number of high-ranked wines (wines ranked 
-- 93 or higher).
WITH validGrapes AS (
    SELECT g.Grape, COUNT(g.Grape) AS numWines
    FROM grapes g
    JOIN wine w ON g.Grape = w.Grape
    WHERE w.Score >= 93
    GROUP BY g.Grape
)
SELECT Grape
FROM validGrapes
WHERE numWines = (
    SELECT MAX(numWines)
    FROM validGrapes
);

-- Q3
-- Find the wine with the 37th largest number of cases produced. Report the 
-- winery, the wine (full name) and the number of cases produced. (If there is 
-- a tie for the 37th place, return all wines that are tied for it).
-- Cannot use LIMIT.
SELECT w1.Winery, w1.Name, w1.Cases
FROM wine w1
LEFT JOIN wine w2 ON w1.Cases < w2.Cases
GROUP BY w1.WineId
HAVING COUNT(w2.WineId) = 36
ORDER BY w1.Cases DESC;

-- Q4
-- Find if there are any 2008 Zinfandels with a score equal or higher than all 
-- 2007 Grenaches. Report winery, wine name, appellation, score and price.
SELECT w.Winery, w.Name, w.Appellation, w.Score, w.Price
FROM wine w
WHERE w.Vintage = 2008 AND w.Grape = 'Zinfandel' AND w.Score >= ALL (
    SELECT w2.Score
    FROM wine w2
    WHERE w2.Vintage = 2007 AND w2.Grape = 'Grenache'
);

-- Q5
-- Two California AVAs, Carneros and Dry Creek Valley have a bragging rights 
-- contest every year: the AVA that produces the highest-ranked wine among all 
-- the wines produced in both AVAs wins. Based on the data in the database, 
-- output (as a single tuple) the number of vintage years each AVA has won 
-- between 2005 and 2009 (you want the output to look like a score of a game 
-- between the two AVAs. Only the vintage years where one AVA won count - 
-- vintages when both AVAs had the same highest score should not be counted).
-- Expected Result: Carneros: 2, Dry Creek Valley: 3
WITH Carneros AS (
    SELECT w.Appellation, w.Vintage, SUM(w.Score) as Score
    FROM wine w
    WHERE w.Appellation = "Carneros" AND w.Vintage BETWEEN 2005 AND 2009
    GROUP BY w.Vintage
    ORDER BY w.Vintage
), DCV AS (
    SELECT w.Appellation, w.Vintage, SUM(w.Score) as Score
    FROM wine w
    WHERE w.Appellation = "Dry Creek Valley" AND w.Vintage BETWEEN 2005 AND 2009
    GROUP BY w.Vintage
    ORDER BY w.Vintage
)
SELECT COUNT(CASE WHEN Carneros.Score > DCV.Score THEN 1 END) AS DCV,
    COUNT(CASE WHEN Carneros.Score < DCV.Score THEN 1 END) AS Carneros
FROM Carneros, DCV
WHERE Carneros.Vintage = DCV.Vintage;

-- Q6
-- For each winemaking area in California (exclude 'N/A' and 'Calfiornia') 
-- report how many wineries produce a wine made with Grenache grapes. Report 
-- the area (in alphabetical order) and the number of wineries. Note: you must 
-- have a result for each area.
WITH validAppellations AS (
    SELECT a.Area, a.Appellation
    FROM appellations a
    WHERE a.Area != 'N/A' AND a.Area != 'California'
), validWineries AS (
    SELECT w.Appellation, w.Winery
    FROM wine w
    WHERE w.Grape = 'Grenache'
)
SELECT a.Area, COUNT(DISTINCT w.Winery)
FROM validAppellations a
LEFT OUTER JOIN validWineries w ON a.Appellation = w.Appellation
GROUP BY a.Area
ORDER BY a.Area;
