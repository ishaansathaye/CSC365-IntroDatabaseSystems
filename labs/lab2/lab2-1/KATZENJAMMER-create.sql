CREATE TABLE Albums (
    Id int PRIMARY KEY,
    Title varchar(128) UNIQUE,
    Year int,
    Label varchar(24),
    AlbumType varchar(10)
);

CREATE TABLE Band (
    Id int PRIMARY KEY,
    Firstname varchar(24),
    Lastname varchar(24)
);

CREATE TABLE Songs (
    Id int PRIMARY KEY,
    Title varchar(64)
);

CREATE TABLE Instruments (
    SongId int,
    BandmateId int,
    Instrument varchar(24),
    PRIMARY KEY(SongId, BandmateId, Instrument),
    FOREIGN KEY (SongId) REFERENCES Songs(Id),
    FOREIGN KEY (BandmateId) REFERENCES Band(Id)
);

CREATE TABLE Performance (
    SongId int,
    BandmateId int,
    StagePosition varchar(10),
    PRIMARY KEY(SongId, BandmateId),
    FOREIGN KEY (SongId) REFERENCES Songs(Id),
    FOREIGN KEY (BandmateId) REFERENCES Band(Id)
);

CREATE TABLE Tracklists (
    AlbumId int,
    Position int,
    SongId int,
    PRIMARY KEY(AlbumId, Position),
    FOREIGN KEY (SongId) REFERENCES Songs(Id),
    FOREIGN KEY (AlbumId) REFERENCES Albums(Id)
);

CREATE TABLE Vocals (
    SongId int,
    BandmateId int,
    VocalType varchar(10),
    PRIMARY KEY(SongId, BandmateId, VocalType),
    FOREIGN KEY (SongId) REFERENCES Songs(Id),
    FOREIGN KEY (BandmateId) REFERENCES Band(Id)
);
