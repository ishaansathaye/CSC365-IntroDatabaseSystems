# Name: Ishaan Sathaye
# Cal Poly Email: isathaye@calpoly.edu

import mysql.connector
from mysql.connector import Error

pwdfileName = '../account.info'
pwdfile = open(pwdfileName, 'r')
p = pwdfile.read().splitlines()


hostName = 'mysql.labthreesixfive.com'
portName = '3306'
userName = p[0]
passString = p[1]

dbName = p[0]

try:

    conn = mysql.connector.connect(host=hostName, port=portName, database=dbName,
                                   user=userName, password=passString)
    if conn.is_connected():

        print('Connected to ', hostName)
        cursor = conn.cursor()

        # Remove from the flights database all flights except for those to and
        # from AKI (that’s the airport code)
        cursor.execute("DELETE FROM Flights WHERE Source != 'AKI' \
                       AND Destination != 'AKI'")
        conn.commit()
        cursor.execute("SELECT * FROM Flights")
        records = cursor.fetchall()
        print("---------------------------------------")
        for r in records:
            print(r)
        print("---------------------------------------")

        # 10,'AirTran Airways','AirTran','USA'
        # 7,'Continental Airlines','Continental','USA'
        # 12,'Virgin America','Virgin','USA'
        # For all flights NOT operated by Continental, AirTran or Virgin,
        # increase the flight number by 2000
        cursor.execute("UPDATE Flights SET FlightNo = FlightNo + 2000 \
                          WHERE Airline != 10 AND Airline != 7 \
                          AND Airline != 12")
        conn.commit()
        cursor.execute("SELECT * FROM Flights")
        records = cursor.fetchall()
        print("---------------------------------------")
        for r in records:
            print(r)
        print("---------------------------------------")

        # For all pairs of flights to/from AKI NOT operated by Cont, AirTran,
        # or Virgin, all even-numbered flights need to increase by 1, all odd-numbered
        # flights need to decrease by 1
        cursor.execute("ALTER TABLE Flights DROP PRIMARY KEY")
        conn.commit()
        cursor.execute("UPDATE Flights SET FlightNo =  \
                            IF(MOD(FlightNo, 2) = 0, FlightNo + 1, FlightNo - 1) \
                            WHERE Airline != 10 AND Airline != 7 \
                            AND Airline != 12")
        conn.commit()
        cursor.execute(
            "ALTER TABLE Flights ADD PRIMARY KEY (Airline, FlightNo)")
        conn.commit()
        cursor.execute("SELECT * FROM Flights")
        records = cursor.fetchall()
        print("---------------------------------------")
        for r in records:
            print(r)
        print("---------------------------------------")

        # Replace the airline for all flights to and from AKI except for AirTran
        # and Virgin with Continental
        cursor.execute("UPDATE Flights SET Airline = 7 \
                            WHERE Airline != 10 AND Airline != 12")
        conn.commit()
        cursor.execute("SELECT * FROM Flights ORDER BY Airline, FlightNo")
        records = cursor.fetchall()
        print("---------------------------------------")
        for r in records:
            print(r)
        print("---------------------------------------")

except Error as e:
    print('Connection error: ', e)

finally:
    if conn.is_connected():
        cursor.close()
        conn.close()
        print('Done')
