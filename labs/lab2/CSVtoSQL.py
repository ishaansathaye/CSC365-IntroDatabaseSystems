import csv
import pandas as pd
from oracle2mysql import *


airlines = [("data/AIRLINES/airlines.csv", "Airlines"), 
            ("data/AIRLINES/airports100.csv", "Airports"),
            ("data/AIRLINES/flights.csv", "Flights")]
bakery = [("data/BAKERY/customers.csv", "Customers"), ("data/BAKERY/goods.csv", "Goods"), 
         ("data/BAKERY/receipts.csv", "Receipts"), ("data/BAKERY/items.csv", "Items")]
cars = [("data/CARS/continents.csv", "Continents"),( "data/CARS/countries.csv", "Countries"), 
        ("data/CARS/car-makers.csv", "CarMakers"), ("data/CARS/model-list.csv", "Models"), 
        ("data/CARS/car-names.csv", "Makes"), ("data/CARS/cars-data.csv", "CarsData")]
csu = [("data/CSU/Campuses.csv", "Campuses"), ("data/CSU/csu-fees.csv", "Fees"), 
       ("data/CSU/degrees.csv", "Degrees"), ("data/CSU/disciplines.csv", "Disciplines"), 
       ("data/CSU/discipline-enrollments.csv", "DiscEnrollments"), 
       ("data/CSU/enrollments.csv", "Enrollments"), ("data/CSU/faculty.csv", "Faculty")]
inn = [("data/INN/Rooms.csv", "Rooms"), ("data/INN/Reservations.csv", "Reservations")]
kazten = [("data/KATZENJAMMER/Albums.csv", "Albums"), 
          ("data/KATZENJAMMER/Band.csv", "Band"), ("data/KATZENJAMMER/Songs.csv", "Songs"), 
          ("data/KATZENJAMMER/Instruments.csv", "Instruments"), 
          ("data/KATZENJAMMER/Performance.csv", "Performance"), 
          ("data/KATZENJAMMER/Tracklists.csv", "Tracklists"), 
          ("data/KATZENJAMMER/Vocals.csv", "Vocals")]
marathon = [("data/MARATHON/marathon.csv", "Marathon")]
students = [("data/STUDENTS/teachers.csv", "Teachers"), ("data/STUDENTS/list.csv", "List")]
wine = [("data/WINE/appellations.csv", "Appellations"), ("data/WINE/grapes.csv", "Grapes"), 
        ("data/WINE/wine.csv", "Wine")]


for path, table_name in airlines:
    full_path = "../../"+path
    openFile = open("../../"+path, 'r')
    if table_name == 'Wine':
        cols = list(pd.read_csv(full_path, nrows=1))
        csvFile= pd.read_csv(full_path, usecols =[i for i in cols if (i != "State" and i != "Drink")])
    else:
        csvFile= pd.read_csv(full_path)
        if table_name == 'Reservations':
            csvFile['CheckIn'] = csvFile['CheckIn'].apply(date2mysqlQuotes)
            csvFile['CheckOut'] = csvFile['CheckOut'].apply(date2mysqlQuotes)
        elif table_name == 'Receipts':
            csvFile[' Date'] = csvFile[' Date'].apply(date2mysqlQuotes)
        elif table_name == 'Marathon':
            csvFile['Time'] = csvFile['Time'].apply(time2mysqlQuotes)
            csvFile['Pace'] = csvFile['Pace'].apply(time2mysqlQuotes)
    # header = list(csvFile.columns.values)
    insert = 'INSERT INTO ' +table_name + "\n\tVALUES "
    for row in csvFile.values:
        values = map((lambda x: str(x)), row)
        print (insert +"("+ ",".join(values) +");" )
    openFile.close()
    print()