-- Name: Ishaan Sathaye
-- Email: isathaye@calpoly.edu

-- Q1
-- Report the first name of the performer who never played the accordion.
SELECT DISTINCT Band.Firstname
FROM Band
WHERE Band.Id NOT IN (
    SELECT DISTINCT Instruments.Bandmate
    FROM Instruments
    WHERE Instruments.Instrument = 'accordion'
) AND Band.Id IN (
    SELECT DISTINCT Instruments.Bandmate
    FROM Instruments
);

-- Q2
-- Report, in alphabetical order (if more than one song returned), the titles 
-- of all instrumental compositions performed by Katzenjammer ("instrumental 
-- composition" means no vocals).
SELECT Title 
FROM Songs
WHERE SongId NOT IN (
    SELECT DISTINCT Song
    FROM Vocals
)
ORDER BY Title;

-- Q3
-- Report the title (or titles) of the song(s) that involved the largest number 
-- of instruments played by all performers combined (if multiple songs, report 
-- the titles in alphabetical order).
WITH InstrumentsPlayed AS (
    SELECT Song, COUNT(*) AS Played FROM Instruments
    GROUP BY Song
)
SELECT Title FROM Songs
WHERE SongId IN (
    SELECT Song FROM InstrumentsPlayed
    WHERE Played = (
        SELECT MAX(Played) FROM InstrumentsPlayed
    )
)
ORDER BY Title;

-- Q4
-- Find the favorite instrument of each performer (i.e., the one they played 
-- the most). Report the first name of the performer, the name of the 
-- instrument and the number of songs the performer played the instrument on. 
-- Sort in alphabetical order by the first name, if a player has multiple 
-- favorite instruments, sort them in alphabetical order by instrument name.
WITH InstrumentsPlayed as (
    SELECT Bandmate,Instrument,Count(*) AS Played FROM Instruments
    GROUP BY Bandmate, Instrument
), FavoriteInstrument AS (
    SELECT Bandmate,Instrument, Played FROM InstrumentsPlayed
    WHERE Played = (
        SELECT MAX(Played) FROM InstrumentsPlayed AS IP
        WHERE IP.Bandmate = InstrumentsPlayed.Bandmate
    )
)
SELECT Band.Firstname, FavoriteInstrument.Instrument, FavoriteInstrument.Played
FROM Band,FavoriteInstrument
WHERE Band.Id = FavoriteInstrument.Bandmate
ORDER BY Band.Firstname, FavoriteInstrument.Instrument;

-- Q5
-- Find all instruments that ONLY Anne-Marit played. Report instruments in 
-- alphabetical order.
SELECT DISTINCT Instrument FROM Instruments
WHERE Bandmate = (
    SELECT Id FROM Band
    WHERE Firstname = 'Anne-Marit'
)
AND Instrument NOT in (
    SELECT distinct Instrument FROM Instruments
    WHERE Bandmate != (
        SELECT Id FROM Band
        WHERE Firstname = 'Anne-Marit'
    )
)
ORDER BY Instrument;

-- Q6
-- Report the first name of the performer who played the largest number of 
-- different instruments.
WITH InstrumentsPlayed AS (
    SELECT Bandmate,Count(distinct Instrument) AS Played FROM Instruments
    GROUP BY Bandmate
)
SELECT Firstname FROM Band
WHERE Id IN (
    SELECT Bandmate FROM InstrumentsPlayed
    WHERE Played = (
        SELECT MAX(Played) FROM InstrumentsPlayed
    )
);

-- Q7
-- For each song from the album 'Le Pop' report the names (first name) of the 
-- song's lead singers. Report song title and the first name of the lead 
-- singer. If a song has multiple lead singers, report them in separate tuples. 
-- Sort the output in the track order of the album, and - whenever multiple 
-- lead singers are present in alphabetical order by the singers' first names. 
-- Note: you must have a tuple for each song from 'Le Pop' in the output.
WITH LePopSongs AS (
    SELECT Song 
    FROM Tracklists
    WHERE Album = (
        SELECT aid FROM Albums
        WHERE Title = 'Le Pop'
    )
), leadVocals AS (
    SELECT v.Song, b.FirstName
    FROM Vocals v, Band b
    WHERE v.VocalType = 'lead' AND b.Id = v.Bandmate
)
SELECT Songs.Title, leadVocals.FirstName
FROM Songs, LePopSongs LEFT OUTER JOIN leadVocals 
    ON LePopSongs.Song = leadVocals.Song
WHERE LePopSongs.Song = Songs.SongId
ORDER BY LePopSongs.Song;

-- Q8
-- Which instrument(s) was/were played on the largest number of songs? Report 
-- just the names of the instruments (note, you are counting number of songs on 
-- which an instrument was played, make sure to not count two different 
-- performers playing same instrument on the same song twice). Sort in 
-- alphabetical order by name of the instrument.
WITH InstrumentsPlayed AS (
    SELECT Instrument,Count(distinct Song) AS Played FROM Instruments
    GROUP BY Instrument
)
SELECT Instrument FROM InstrumentsPlayed
WHERE Played = (
    SELECT MAX(Played) FROM InstrumentsPlayed
)
ORDER BY Instrument;
