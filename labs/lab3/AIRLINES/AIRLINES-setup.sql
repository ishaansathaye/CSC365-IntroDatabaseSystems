-- Name: Ishaan Sathaye
-- Cal Poly Email: isathaye@calpoly.edu

CREATE TABLE Airlines (
    Id int PRIMARY KEY,
    AirlineName varchar(30) UNIQUE,
    Abbr varchar(15) UNIQUE,
    Country varchar(30)
);

CREATE TABLE Airports (
    AirportName varchar(60),
    Code char(3) PRIMARY KEY,
    City varchar(50),
    Country varchar(30),
    CAbbr varchar(15),
    UNIQUE(AirportName, City)
);

CREATE TABLE Flights (
    Airline int,
    FlightNo int,
    Source char(3),
    Destination char(3),
    PRIMARY KEY(Airline, FlightNo),
    FOREIGN KEY(Airline) REFERENCES Airlines(Id),
    FOREIGN KEY(Source) REFERENCES Airports(Code),
    FOREIGN KEY(Destination) REFERENCES Airports(Code)
);
