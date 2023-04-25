-- Name: Ishaan Sathaye
-- Cal Poly Email: isathaye@calpoly.edu

CREATE TABLE Marathon (
    Place int PRIMARY KEY,
    RunTime time,
    Pace time,
    GroupPlace int,
    AgeGroup char(8),
    Age int,
    Sex char(1),
    BibNumber int,
    FirstName varchar(20),
    LastName varchar(20),
    Town varchar(20),
    State char(2)
);
