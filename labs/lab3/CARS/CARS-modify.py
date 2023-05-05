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

        #  Keep in the table storing the technical characteristics about the cars
        cursor.execute("DELETE FROM CarsData \
                        WHERE NOT ( \
                            ((Year = 1978 OR year = 1979) AND MPG >= 20) \
                            OR (MPG >= 26 AND Horsepower > 110) \
                            OR (Cylinders = 8 AND Accelerate < 10))"
                       )
        conn.commit()
        cursor.execute("SELECT * FROM CarsData \
                       ORDER BY Year, Id")
        records = cursor.fetchall()
        print("---------------------------------------")
        for r in records:
            print(r)
        print("---------------------------------------")

        # Remove from the car data table all attributes
        # except car id, car year, acceleration, MPG number of cylinders.
        cursor.execute("ALTER TABLE CarsData \
                        DROP COLUMN Horsepower, \
                        DROP COLUMN EngDisp, \
                        DROP COLUMN Weight"
                       )
        cursor.execute("SELECT * FROM CarsData")
        records = cursor.fetchall()
        print("---------------------------------------")
        for r in records:
            print(r)
        print("---------------------------------------")

        # Remove from car data table all cars with 5 cylinders or fewer
        cursor.execute("DELETE FROM CarsData \
                        WHERE Cylinders <= 5"
                       )
        conn.commit()
        cursor.execute("SELECT * FROM CarsData \
                       ORDER BY Year, Id")
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
