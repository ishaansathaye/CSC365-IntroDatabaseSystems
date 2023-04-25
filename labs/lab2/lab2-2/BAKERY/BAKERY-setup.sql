-- Name: Ishaan Sathaye
-- Cal Poly Email: isathaye@calpoly.edu

CREATE TABLE Customers (
    Id int PRIMARY KEY,
    LastName char(20),
    FirstName char(20),
    UNIQUE(LastName, FirstName)
);

CREATE TABLE Goods (
    Id char(15) PRIMARY KEY,
    Flavor char(20),
    Food char(20),
    Price float,
    UNIQUE(Flavor, Food)
);

CREATE TABLE Receipts (
    Id int PRIMARY KEY,
    PurchDate date,
    CustomerId int,
    FOREIGN KEY (CustomerId) REFERENCES Customers(Id)
);

CREATE TABLE Items (
    ReceiptId int,
    Ordinal int,
    Item char(15),
    PRIMARY KEY (ReceiptId, Ordinal),
    FOREIGN KEY (Item) REFERENCES Goods(Id),
    FOREIGN KEY (ReceiptId) REFERENCES Receipts(Id)
);
