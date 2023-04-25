--
--  CSC 365: build and test all databases
--

-- AIRLINES

-- set echo on
source AIRLINES/AIRLINES-setup.sql
-- set echo off
source AIRLINES/AIRLINES-build-airports100.sql
source AIRLINES/AIRLINES-build-airlines.sql
source AIRLINES/AIRLINES-build-flights.sql

-- test AIRLINES

source AIRLINES/AIRLINES-test.sql

-- remove AIRLINES

source AIRLINES/AIRLINES-cleanup.sql


-- BAKERY
-- set echo on
source BAKERY/BAKERY-setup.sql
-- set echo off
source BAKERY/BAKERY-build-goods.sql
source BAKERY/BAKERY-build-customers.sql
source BAKERY/BAKERY-build-receipts.sql
source BAKERY/BAKERY-build-items.sql

-- test BAKERY

source BAKERY/BAKERY-test.sql

-- remove BAKERY

source BAKERY/BAKERY-cleanup.sql


-- CARS
-- set echo on
source CARS/CARS-setup.sql
-- set echo off
source CARS/CARS-build-continents.sql
source CARS/CARS-build-countries.sql
source CARS/CARS-build-car-makers.sql
source CARS/CARS-build-model-list.sql
source CARS/CARS-build-car-names.sql
source CARS/CARS-build-cars-data.sql

-- test CARS
source CARS/CARS-test.sql

-- remove CARS

source CARS/CARS-cleanup.sql



-- CSU
-- set echo on
source CSU/CSU-setup.sql
-- set echo off
source CSU/CSU-build-Campuses.sql
source CSU/CSU-build-disciplines.sql
source CSU/CSU-build-degrees.sql
source CSU/CSU-build-discipline-enrollments.sql
source CSU/CSU-build-enrollments.sql
source CSU/CSU-build-faculty.sql
source CSU/CSU-build-csu-fees.sql

-- test CSU

source CSU/CSU-test.sql

-- remove CSU

source CSU/CSU-cleanup.sql



-- INN
-- set echo on
source INN/INN-setup.sql
-- set echo off
source INN/INN-build-Rooms.sql
source INN/INN-build-Reservations.sql

-- test INN
source INN/INN-test.sql

-- remove INN
source INN/INN-cleanup.sql



-- MARATHON
-- set echo on
source MARATHON/MARATHON-setup.sql
-- set echo off
source MARATHON/MARATHON-build-marathon.sql

-- test MARATHON
source MARATHON/MARATHON-test.sql

-- remove MARATHON
source MARATHON/MARATHON-cleanup.sql



-- STUDENTS
-- set echo on
source STUDENTS/STUDENTS-setup.sql
-- set echo off
source STUDENTS/STUDENTS-build-teachers.sql
source STUDENTS/STUDENTS-build-list.sql

-- test STUDENTS
source STUDENTS/STUDENTS-test.sql

-- remove STUDENTS
source STUDENTS/STUDENTS-cleanup.sql



-- WINE
-- set echo on
source WINE/WINE-setup.sql
-- set echo off
source WINE/WINE-build-grapes.sql
source WINE/WINE-build-appellations.sql
source WINE/WINE-build-wine.sql


-- test WINES
source WINE/WINE-test.sql

-- remove WINE
source WINE/WINE-cleanup.sql



-- KATZENJAMMER

source KATZENJAMMER/KATZENJAMMER-setup.sql
source KATZENJAMMER/KATZENJAMMER-build-Band.sql
source KATZENJAMMER/KATZENJAMMER-build-Songs.sql
source KATZENJAMMER/KATZENJAMMER-build-Albums.sql
source KATZENJAMMER/KATZENJAMMER-build-Tracklists.sql
source KATZENJAMMER/KATZENJAMMER-build-Instruments.sql
source KATZENJAMMER/KATZENJAMMER-build-Performance.sql
source KATZENJAMMER/KATZENJAMMER-build-Vocals.sql

-- test KATZENJAMMER
source KATZENJAMMER/KATZENJAMMER-test.sql

-- remove KAZENJAMMER

source KATZENJAMMER/KATZENJAMMER-cleanup.sql









-- set echo on
-- done








