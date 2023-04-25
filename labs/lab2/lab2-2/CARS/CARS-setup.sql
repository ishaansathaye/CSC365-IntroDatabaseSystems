-- Name: Ishaan Sathaye
-- Cal Poly Email: isathaye@calpoly.edu

CREATE TABLE Continents (
    Id int PRIMARY KEY,
    Name char(15) UNIQUE
);

CREATE TABLE Countries (
    Id int PRIMARY KEY,
    Name char(20) UNIQUE,
    Continent int,
    FOREIGN KEY (Continent) REFERENCES Continents(Id)
);

CREATE TABLE CarMakers (
    Id int PRIMARY KEY,
    Maker char(15) UNIQUE,
    FullName char(25) UNIQUE,
    Country int,
    FOREIGN KEY (Country) REFERENCES Countries(Id)
);

CREATE TABLE Models (
    Id int PRIMARY KEY,
    Maker int,
    Model char(15) UNIQUE,
    FOREIGN KEY (Maker) REFERENCES CarMakers(Id)
);

CREATE TABLE Makes (
    Id int PRIMARY KEY,
    Model char(15),
    Make char(60),
    FOREIGN KEY (Model) REFERENCES Models(Model)
);

CREATE TABLE CarsData (
    Id int PRIMARY KEY,
    MPG float,
    Cylinders int,
    EngDisp int,
    Horsepower int,
    Weight int,
    Accelerate float,
    Year int,
    FOREIGN KEY (Id) REFERENCES Makes(Id)
);
