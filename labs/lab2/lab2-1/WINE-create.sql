CREATE TABLE Appellations (
    Id int PRIMARY KEY,
    Appellation varchar(50) UNIQUE,
    County varchar(16),
    State varchar(16),
    Area varchar(24),
    isAVA char(3)
);

CREATE TABLE Grapes (
    Id int PRIMARY KEY,
    Grape varchar(24) UNIQUE,
    Color varchar(10)
);

CREATE TABLE Wine (
    WineId int PRIMARY KEY,
    Grape varchar(24),
    Winery varchar(48),
    Appellation varchar(50),
    Name varchar(50),
    VintageYear int,
    Price int,
    Score int,
    Cases int DEFAULT NULL,
    UNIQUE(Winery, Appellation, Name),
    FOREIGN KEY (Grape) REFERENCES Grapes(Grape),
    FOREIGN KEY (Appellation) REFERENCES Appellations(Appellation)
);
