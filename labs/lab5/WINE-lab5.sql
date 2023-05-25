-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- List all 2006 vintage wines from Napa (any appellation within the county) 
-- whose total revenue exceeds that of the 2006 'Appelation Series' 
-- (There is a typo there. Let it be for now.) Paso Robles Zinfandel from 
-- 'Rosenblum' winery. For each wine report grape, winery and name, score and 
-- revenue. Sort by revenue in descending order
SELECT w.Grape, w.Winery, w.Name, w.Score, (12 * w.Price * w.Cases) AS Revenue
FROM wine w, appellations a, wine w2
WHERE w.Appellation = a.Appellation AND a.County = 'Napa'
    AND w.Vintage = 2006 AND w2.Vintage = 2006
    AND w2.Winery = 'Rosenblum' AND w2.Name = 'Appelation Series' 
    AND w2.Grape = 'Zinfandel' AND w2.Appellation = 'Paso Robles'
    AND w.Price * w.Cases > w2.Price * w2.Cases
ORDER BY Revenue DESC;

-- Q2
-- Find the average score of a Sonoma Valley Zinfandel.
SELECT AVG(Score) AS AverageScore
FROM wine w, appellations a
WHERE w.Appellation = a.Appellation AND w.Appellation = 'Sonoma Valley'
    AND w.Grape = 'Zinfandel';

-- Q3
-- Find the total revenue from all 2009 Sauvignon Blanc wines with a score of 
-- 89 or higher.
SELECT SUM(12 * Price * Cases) AS TotalRevenue
FROM wine
WHERE Vintage = 2009 AND Grape = 'Sauvignon Blanc' AND Score >= 89;

-- Q4
-- Find the average number of cases of a Zinfandel produced from grapes 
-- sourced from the Central Coast.
SELECT AVG(Cases) AS AverageCases
FROM wine w, appellations a
WHERE w.Appellation = a.Appellation AND a.Area = 'Central Coast'
    AND w.Grape = 'Zinfandel';

-- Q5
-- Report the overall number of different red wines produced in Russian River 
-- Valley during the year when this AVA had a wine with a score of 98.
SELECT COUNT(DISTINCT w.Name) AS NumberOfWines
FROM wine w, appellations a, grapes g, wine w2
WHERE w.Appellation = a.Appellation AND a.Appellation = 'Russian River Valley'
    AND g.Color = 'red' AND w.Grape = g.Grape
    AND (w2.Score = 98 AND w2.Appellation = a.Appellation)
    AND w.Vintage = w2.Vintage
