-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- For each performer (use first name) report how many times she sang lead 
-- vocals on a song. Sort output in descending order by the number of leads.
SELECT b.FirstName, COUNT(v.VocalType)
FROM Band b, Vocals v
WHERE b.Id = v.Bandmate AND v.VocalType = 'lead'
GROUP BY b.FirstName
ORDER BY COUNT(v.VocalType) DESC;

-- Q2
-- Report how many different unique instruments each performer plays on songs 
-- from 'Rockland'. Sort the output by the first name of the performers.
SELECT b.FirstName, COUNT(DISTINCT(i.Instrument))
FROM Albums a, Tracklists t, Songs s, Instruments i, Band b
WHERE a.Title = 'Rockland' AND a.AId = t.Album AND t.Song = s.SongId 
    AND s.SongId = i.Song AND i.Bandmate = b.Id
GROUP BY b.FirstName
ORDER BY b.FirstName;

-- Q3
-- Report the number of times Solveig stood at each stage position when 
-- performing live. Sort output in ascending order of the number of times 
-- she performed in each position.
SELECT p.StagePosition, COUNT(p.StagePosition)
FROM Performance p, Band b
WHERE p.Bandmate = b.Id AND b.FirstName = 'Solveig'
GROUP BY p.StagePosition
ORDER BY COUNT(p.StagePosition);

-- Q4
-- Report how many times each of the remaining peformers played the bass 
-- balalaika on the songs where Anne-Marit was positioned on the left side of 
-- the stage. Sort output alphabetically by the name of the performer.
SELECT b.FirstName, COUNT(i.Song)
FROM Instruments i, Band b, Band b2, Performance p
WHERE b2.FirstName = "Anne-Marit" AND p.StagePosition = "left" 
    AND p.Bandmate = b2.Id AND p.Song = i.Song 
    AND i.Instrument = "bass balalaika" AND b.FirstName != b2.FirstName 
    AND b.Id = i.Bandmate
GROUP BY b.FirstName
ORDER BY b.FirstName;

-- Q5
-- Report all instruments (in alphabetical order) that were played by all 
-- four members of Katzenjammer.
SELECT i.Instrument
FROM Instruments i, Band b
WHERE i.Bandmate = b.Id
GROUP BY i.Instrument
HAVING COUNT(DISTINCT b.FirstName) = 4
ORDER BY i.Instrument;

-- Q6
-- For each performer, report the number of times they played more than one 
-- instrument on the same song. Sort output in alphabetical order by first 
-- name of the performer. (Yes, you can do it without using nested queries!).
SELECT b.FirstName, COUNT(DISTINCT i.Song)
FROM Band b, Instruments i, Instruments i2
WHERE b.Id = i.Bandmate AND (i.Song = i2.Song AND i.Bandmate = i2.Bandmate
    AND i.Instrument != i2.Instrument)
GROUP BY b.Id
HAVING COUNT(DISTINCT i.Song) >= 1
ORDER BY b.FirstName;
