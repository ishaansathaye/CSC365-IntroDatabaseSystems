-- Name: Ishaan Sathaye
-- Cal Poly Email: isathaye@calpoly.edu

CREATE TABLE Teachers (
    Classroom int PRIMARY KEY,
    LastName varchar(16),
    FirstName varchar(16)
);

CREATE TABLE List (
    LastName varchar(16),
    FirstName varchar(16),
    Grade int,
    Classroom int,
    PRIMARY KEY (FirstName, LastName),
    FOREIGN KEY (Classroom) REFERENCES Teachers(Classroom)
);