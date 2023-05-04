-- Name: Ishaan Sathaye
-- Cal Poly Email: isathaye@calpoly.edu

CREATE TABLE Campuses (
    Id int PRIMARY KEY,
    Campus varchar(60) UNIQUE, 
    Location varchar(30), 
    County char(20), 
    Year int,
    UNIQUE(Location, County)
);

CREATE TABLE Fees (
    CampusId int,
    Year int,
    CampusFee int,
    PRIMARY KEY(CampusId, Year),
    FOREIGN KEY (CampusId) REFERENCES Campuses(Id)
);

CREATE TABLE Degrees (
    Year int,
    CampusId int,
    Degrees int,
    PRIMARY KEY(Year, CampusId),
    FOREIGN KEY (CampusId) REFERENCES Campuses(Id)
);

CREATE TABLE Disciplines (
    Id int PRIMARY KEY,
    Name varchar(40) UNIQUE
);

CREATE TABLE DiscEnrollments (
    CampusId int,
    Discipline int,
    Year int,
    Undergrad int,
    Grad int,
    PRIMARY KEY(CampusId, Discipline, Year),
    FOREIGN KEY (CampusId) REFERENCES Campuses(Id),
    FOREIGN KEY (Discipline) REFERENCES Disciplines(Id)
);

CREATE TABLE Enrollments (
    CampusId int,
    Year int,
    Enrolled int,
    FTE int,
    PRIMARY KEY(CampusId, Year),
    FOREIGN KEY (CampusId) REFERENCES Campuses(Id)
);

CREATE TABLE Faculty (
    CampusId int,
    Year int,
    Faculty float,
    PRIMARY KEY(CampusId, Year),
    FOREIGN KEY (CampusId) REFERENCES Campuses(Id)
);
