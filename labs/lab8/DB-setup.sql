-- Urban Social Disorder Database
-- Based on Urban Social Disorder Kaggle Dataset
-- https://www.kaggle.com/datasets/waltervanhuissteden/urban-social-disorder
-- Dataset Codebook: https://www.kaggle.com/datasets/waltervanhuissteden/urban-social-disorder?select=USD+Codebook.pdf


-- March 13, 2023
-- Alex Dekhtyar, dekhtyar@calpoly.edu


-- ProblemTypes: list of social unrset problem types used to code
--               the social unrest events in the database

CREATE TABLE ProblemTypes(
 Ptype INT PRIMARY KEY,              -- problem type code (two digit int)
 ProblemType  VARCHAR(64) UNIQUE,    -- problem type 
 description  TEXT                   -- description of the problem type (verbatim text from the dataset codebook)
);


CREATE TABLE Countries (
   Country VARCHAR(64) PRIMARY KEY,   -- Name of the country, also will serve as the primary key
   ISO3  CHAR(3) UNIQUE,              -- 3-digit ISO country code
   GWNO  INT  UNIQUE,                 -- GWNO number associated with the country
   Region VARCHAR(32)                 -- Region the country is in.
);


CREATE TABLE Cities (
  CityID INT Primary Key,             -- unique ID for the city
  City  VARCHAR(64),                  -- name of the city (not unique)
  Country CHAR(3),                    -- country (ISO3 code)
  isCapital INT,                      -- if set to 1: this is the country's capital, if set to 0 - not a capital
  Longitude  DOUBLE,                  -- Longitude of (some point in) the city
  Lattitude  DOUBLE,                  -- Lattitude of (some point in) the city
  FOREIGN KEY(Country) REFERENCES Countries(ISO3)
);


CREATE TABLE Events (
 eventID VARCHAR(10) PRIMARY KEY,    -- unique event Id
 City  INT,                          -- city where the event took place (INT)
 Ptype INT,                          -- Event type (problem type of the event see ProblemTypes)
 StartDate DATE,                     -- start date of the event
 EndDate DATE,                       -- end date of the event
 nPart INT,                          -- code for number of participants  see codebook.
 minDeaths INT,                      -- minimum number of deaths 
 maxDeaths INT,                      --  max number of deaths
 deathFlag INT,                      -- set to 1 is at least one death, set to 0 if no deaths
 eLocal VARCHAR(64),                 -- location of the unrest
 summary text,                       -- summary of unrest event
 FOREIGN KEY(City) REFERENCES Cities(CityID)
 FOREIGN KEY(Ptype) REFERENCES ProblemTypes(Ptype)
);


--- Event actors: list of actors in the events

CREATE TABLE EventActors(
  eventId VARCHAR(10),
  actor VARCHAR(64),
  PRIMARY KEY(eventId, actor),
  FOREIGN KEY(eventId) REFERENCES Events(eventId)
);

CREATE TABLE EventTargets(
  eventId VARCHAR(10),
  target VARCHAR(64),
  PRIMARY KEY(eventId, target),
  FOREIGN KEY(eventId) REFERENCES Events(eventId)
);
