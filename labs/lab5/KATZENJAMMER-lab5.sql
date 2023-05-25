-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- Find the number of times each band member played bass balalaika on 
-- Katzenjammer songs. Report the result as four separate rows, each 
-- consisting of the name of one musician, and the number of times they played 
-- bass balalaika. Do not use Group By.
SELECT b.FirstName, COUNT(*) AS NumberOfTimes
FROM Band b, Instruments i
WHERE b.Id = i.Bandmate AND i.Instrument = 'bass balalaika'
    AND b.FirstName = 'Solveig'
UNION
SELECT b.FirstName, COUNT(*) AS NumberOfTimes
FROM Band b, Instruments i
WHERE b.Id = i.Bandmate AND i.Instrument = 'bass balalaika'
    AND b.FirstName = 'Marianne'
UNION
SELECT b.FirstName, COUNT(*) AS NumberOfTimes
FROM Band b, Instruments i
WHERE b.Id = i.Bandmate AND i.Instrument = 'bass balalaika'
    AND b.FirstName = 'Anne-Marit'
UNION
SELECT b.FirstName, COUNT(*) AS NumberOfTimes
FROM Band b, Instruments i
WHERE b.Id = i.Bandmate AND i.Instrument = 'bass balalaika'
    AND b.FirstName = 'Turid';

-- Q2
-- Find the number of times Solveig was positioned center stage while Turid 
-- sang lead.
SELECT COUNT(*) AS NumberOfTimes
FROM Performance p, Band b1, Band b2, Songs s, Vocals v
WHERE p.Song = s.SongId AND p.Bandmate = b1.Id AND b1.Firstname = 'Solveig'
    AND p.StagePosition = 'center' 
    AND b2.Firstname = 'Turid' AND v.VocalType = 'lead'
    AND v.Song = s.SongId AND v.Bandmate = b2.Id
    AND p.Song = v.Song;

-- Q3
-- Find the number of times Anne-Marit played banjo, sang lead, and was 
-- positioned center stage.
SELECT COUNT(*) AS NumberOfTimes
FROM Performance p, Band b, Songs s, Vocals v, Instruments i
WHERE p.Song = s.SongId AND p.Bandmate = b.Id AND b.Firstname = 'Anne-Marit'
    AND p.StagePosition = 'center' 
    AND v.VocalType = 'lead'
    AND v.Song = s.SongId AND v.Bandmate = b.Id
    AND i.Instrument = 'banjo'
    AND i.Song = s.SongId AND i.Bandmate = b.Id
    AND p.Song = v.Song AND p.Song = i.Song;

-- Q4
-- Find the total number of different instruments Turid played on 
-- Katzenjammer songs.
SELECT COUNT(DISTINCT i.Instrument) AS NumberOfInstruments
FROM Instruments i, Band b
WHERE i.Bandmate = b.Id AND b.Firstname = 'Turid';

-- Q5
-- List all the instruments that both Solveig and Turid played on 
-- (possibly different) Katzenjammer songs.
SELECT DISTINCT i1.Instrument
FROM Instruments i1, Band b1, Instruments i2, Band b2
WHERE i1.Bandmate = b1.Id AND b1.Firstname = 'Solveig'
    AND i2.Bandmate = b2.Id AND b2.Firstname = 'Turid'
    AND (i1.Instrument = i2.Instrument AND i1.Song != i2.Song)
ORDER BY i1.Instrument ASC;

-- Q6
-- Find how many songs DID NOT feature a guitar. (Note: you CAN and MUST do 
-- this without using nested queries) (Note 2: technically, there is one 
-- a-capella song that does NOT have any instruments, but we are going to 
-- ignore it. The query can be rephrased as "Of all the songs on which at 
-- least one instrument played, how many DO NOT feature a guitar?")
SELECT COUNT(DISTINCT s.SongId) - COUNT(DISTINCT i.song)
FROM Songs s, Songs s2, Instruments i
WHERE s2.SongId = i.Song AND i.Instrument = 'guitar'

-- Q7
-- Find on how many songs at least two performers played the same instrument.
SELECT COUNT(DISTINCT i1.Song) AS NumberOfSongs
FROM Instruments i1, Instruments i2
WHERE i1.Song = i2.Song AND i1.Bandmate != i2.Bandmate
    AND i1.Instrument = i2.Instrument;
