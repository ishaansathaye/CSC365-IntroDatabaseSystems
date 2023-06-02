-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- For each wine score value above 88, report average price, the cheapest price 
-- and the most expensive price for a bottle of wine with that score (for all 
-- vintage years combined), the total number of wines with that score and the 
-- total number of cases produced. Sort by the wine score.
SELECT Score, AVG(Price), MIN(Price), MAX(Price), COUNT(*), SUM(Cases) 
FROM wine 
GROUP BY Score 
HAVING Score > 88 
ORDER BY Score;

-- Q2
-- For each red grape varietal for which there are more than 10 wines in the 
-- database, report the highest price of a case of wine. Report in descending 
-- order of the case price.
SELECT w.Grape, MAX(Price*12)
FROM wine w, grapes g
WHERE w.Grape = g.Grape AND g.Color = 'red'
GROUP BY w.Grape
HAVING COUNT(*) > 10
ORDER BY MAX(Price*12) DESC;

-- Q3
-- Report the list of wineries that produced Zinfandel wines from Sonoma Valley 
-- grapes and the names of the Sonoma Valley Zinfandel wines they produce; use 
-- one row for each winery, report each unique name of wine exactly once, sort 
-- output in alphabetical order by winery name.
SELECT w.Winery, GROUP_CONCAT(DISTINCT w.Name SEPARATOR ', ')
FROM wine w
WHERE w.Grape = 'Zinfandel' AND w.Appellation = 'Sonoma Valley'
GROUP BY w.Winery
ORDER BY w.Winery;

-- Q4
-- For each county in the database, report the score of the highest ranked 
-- 2009 red wine. Exclude wines that do not have a county of origin ('N/A'). 
-- Sort output in descending order by the best score.
SELECT a.County, MAX(Score)
FROM wine w, grapes g, appellations a
WHERE g.Grape= w.Grape AND a.Appellation = w.Appellation
    AND w.Vintage = 2009 AND a.County != "N/A" AND g.Color = "Red"
GROUP BY a.County
ORDER BY MAX(Score) DESC;
