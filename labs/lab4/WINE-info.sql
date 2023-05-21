-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- Find all 2008 Zinfandels produced in Napa Valley (Appellation). Report the 
-- name of the wine, the winery it is produced by, and the wine score, sort in 
-- descending order by the score.
SELECT w.Name, w.Winery, w.Score
FROM wine w
WHERE w.Appellation = 'Napa Valley' AND w.Vintage = 2008 
    AND w.Grape = 'Zinfandel'
ORDER BY w.Score DESC;

-- Q2
-- List all white grape varieties for which at least one wine of the 2009 
-- vintage is rated at 90 points or above in the database. Each grape variety 
-- needs to be reported once. Sort the output in alphabetical order.
SELECT DISTINCT w.Grape
FROM wine w, grapes g
WHERE w.Grape = g.Grape AND g.Color = 'White' AND w.Vintage = 2009
    AND w.Score >= 90
ORDER BY w.Grape;

-- Q3
-- List all Sonoma county appellations for which the database contains at least 
-- one rating for a 'Grenache'. For each appellation list its name and county. 
-- Sort output in alphabetical order by county, then by appellation name. 
-- Report each appellation once.
SELECT DISTINCT a.Appellation, a.County
FROM wine w, appellations a
WHERE w.Appellation = a.Appellation AND a.County = 'Sonoma'
    AND w.Grape = 'Grenache'
ORDER BY a.County, a.Appellation;

-- Q4
-- List all vintage years in which at least one Zinfandel from Sonoma County 
-- (any appellation) scored above 92. Each year needs to be reported once. 
-- Sort in chronological order.
SELECT DISTINCT w.Vintage
FROM wine w, appellations a
WHERE w.Appellation = a.Appellation AND a.County = 'Sonoma'
    AND w.Grape = 'Zinfandel' AND w.Score > 92
ORDER BY w.Vintage;

-- Q5
-- A case of wine is 12 bottles. For each Altamura (name of the winery) wine 
-- compute the total revenue assuming that all the wine sold at the specified 
-- price. Report the name of the wine, its vintage wine score and overall 
-- revenue. Sort in descending order by revenue. Exclude NULL values.
SELECT w.Name, w.Vintage, w.Score, w.Price * 12 * w.Cases
FROM wine w
WHERE w.Winery = 'Altamura' AND w.Price != 'NULL'
ORDER BY w.Price * 12 * w.Cases DESC;

-- Q6
-- Compute the total price of a bottle of Kosta Browne's 'Koplen Vineyard}' 
-- 2008 'Pinot Noir', two bottles of 'Darioush''s 2007 'Darius II' 
-- 'Cabernet Sauvingnon', and three bottles of Kistler}'s 'McCrea Vineyard' 
-- 2006 'Chardonnay'. Report just the one number.
SELECT (w.Price) + (w2.Price * 2) + (w3.Price*3)
FROM wine w, wine w2, wine w3
WHERE (w.Winery = 'Kosta Browne' AND w.Grape = 'Pinot Noir' AND 
    w.Name = 'Koplen Vineyard' AND w.Vintage = 2008)
    AND (w2.Winery = 'Darioush' AND w2.Grape = 'Cabernet Sauvingnon' AND
    w2.Name = 'Darius II' AND w2.Vintage = 2007)
    AND (w3.Winery = 'Kistler' AND w3.Grape = 'Chardonnay' AND
    w3.Name = 'McCrea Vineyard' AND w3.Vintage = 2006);
