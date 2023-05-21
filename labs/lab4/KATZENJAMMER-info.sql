-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- Report, in order, the tracklist for 'Le Pop'. Output just the names of the 
-- songs in the order in which they occur on the album.
SELECT s.Title
FROM Songs s, Tracklists t, Albums a
WHERE a.Title = 'Le Pop' AND a.AId = t.Album AND t.Song = s.SongId
ORDER BY t.Position;

-- Q2
-- List the instruments each performer plays on 'To the Sea'. Output the first 
-- name of each performer and the instrument, sort alphabetically by the first 
-- name (and by the name of the instrument for the same person if needed).
SELECT b.Firstname, i.Instrument
FROM Songs s, Instruments i, Band b
WHERE s.Title = 'To the Sea' AND i.Song = s.SongId AND i.Bandmate = b.Id
ORDER BY b.Firstname, i.Instrument;

-- Q3
-- List all instruments played by Solveig at least once during the 
-- performances. Report the instruments in alphabetical order (each instrument 
-- needs to be reported exactly once).
SELECT DISTINCT i.Instrument
FROM Performance p, Band b, Instruments i
WHERE p.Bandmate = b.Id AND b.Firstname = 'Solveig'
    AND p.Song = i.Song
    AND i.Bandmate = p.Bandmate
ORDER BY i.Instrument;

-- Q4
-- Find all songs that featured toy piano playing (by any of the performers). 
-- Report song titles in alphabetical order and the name of the person who 
-- played the toy piano.
SELECT s.Title, b.Firstname
FROM Songs s, Band b, Instruments i
WHERE i.Instrument = 'toy piano' AND i.Song = s.SongId AND i.Bandmate = b.Id
ORDER BY s.Title;

-- Q5
-- Find all instruments Turid ever played on the songs where she sang lead 
-- vocals. Report the names of instruments in alphabetical order (each 
-- instrument needs to be reported exactly once).
SELECT DISTINCT i.Instrument
FROM Songs s, Band b, Instruments i, Vocals v
WHERE b.Firstname = 'Turid' AND v.VocalType = 'lead' AND v.Song = s.SongId
    AND v.Bandmate = b.Id AND i.Song = s.SongId AND i.Bandmate = b.Id
ORDER BY i.Instrument;

-- Q6
-- Find all songs where the lead vocalist is not positioned center stage. 
-- For each song, report the name, the name of the lead vocalist (first name) 
-- and her position on the stage. Output results in alphabetical order by the 
-- song. (Note: if a song had more than one lead vocalist, you may see multiple 
-- rows returned for that song. This is the expected behavior).
SELECT s.Title, b.Firstname, p.StagePosition
FROM Vocals v, Performance p, Songs s, Band b
WHERE v.VocalType = 'lead' AND p.StagePosition != 'center'
    AND v.Song = p.Song AND v.Bandmate = p.Bandmate
    AND s.SongId = v.Song AND b.Id = v.Bandmate
ORDER BY s.Title;

-- Q7
-- Find a song on which Anne-Marit played three different instruments. 
-- Report the name of the song. (The name of the song shall be reported 
-- exactly once)
SELECT DISTINCT s.Title
FROM Songs s, Instruments i, Band b, Songs s1, Instruments i1, Band b1,
    Songs s2, Instruments i2, Band b2
WHERE b.Firstname = 'Anne-Marit' AND i.Instrument != i1.Instrument
    AND i.Instrument != i2.Instrument AND i1.Instrument != i2.Instrument
    AND i.Song = s.SongId AND i1.Song = s1.SongId AND i2.Song = s2.SongId
    AND i.Bandmate = b.Id AND i1.Bandmate = b1.Id AND i2.Bandmate = b2.Id
    AND s.SongId = s1.SongId AND s.SongId = s2.SongId
    AND b.Id = b1.Id AND b.Id = b2.Id
ORDER BY s.Title;

-- Q8
-- In the order of columns right - center - back - left, report the 
-- positioning of the band during 'Johnny Blowtorch'. (just one record needs 
-- to be returned with four columns containing the first names of the 
-- performers who were staged at the specific positions during the song).
SELECT b1.Firstname AS rightpos, b2.Firstname AS center, b3.Firstname AS back,
    b4.Firstname AS leftpos
FROM Performance p1, Performance p2, Performance p3, Performance p4, Songs s,
    Band b1, Band b2, Band b3, Band b4
WHERE p1.StagePosition = 'right' AND p2.StagePosition = 'center'
    AND p3.StagePosition = 'back' AND p4.StagePosition = 'left'
    AND s.Title = 'Johnny Blowtorch'
    AND p1.Song = s.SongId AND p2.Song = s.SongId
    AND p3.Song = s.SongId AND p4.Song = s.SongId
    AND p1.Bandmate = b1.Id AND p2.Bandmate = b2.Id
    AND p3.Bandmate = b3.Id AND p4.Bandmate = b4.Id;
