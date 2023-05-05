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

except Error as e:
    print('Connection error: ', e)

finally:
    if conn.is_connected():
        cursor.close()
        conn.close()
        print('Done')
