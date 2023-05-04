-- Name: Ishaan Sathaye
-- Cal Poly Email: isathaye@calpoly.edu

CREATE TABLE Rooms (
    RoomId char(5) PRIMARY KEY,
    RoomName varchar(30) UNIQUE,
    Beds int,
    bedType varchar(8),
    maxOcc int,
    basePrice int,
    decor varchar(20)
);

CREATE TABLE Reservations (
    Code int PRIMARY KEY,
    Room char(5),
    CheckIn date,
    Checkout date,
    Rate float,
    LastName varchar(15),
    FirstName varchar(15),
    Adults int,
    Kids int,
    UNIQUE(Room, CheckIn, Checkout, LastName, FirstName),
    FOREIGN KEY(Room) REFERENCES Rooms(RoomId)
);
