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

        # Remove columns storing appellation name and the name of the wine from
        # table
        cursor.execute("ALTER TABLE Wine DROP Foreign Key Wine_App")
        cursor.execute("ALTER TABLE Wine DROP COLUMN Appellation")
        cursor.execute("ALTER TABLE Wine DROP COLUMN Name")
        cursor.execute("SELECT * FROM Wine")
        records = cursor.fetchall()
        print("---------------------------------------")
        for r in records:
            print(r)
        print("---------------------------------------")

        # Keep in the wine table only the Zinfandels with a score of 92 or higher.
        cursor = conn.cursor()
        cursor.execute("DELETE FROM Wine WHERE Grape != 'Zinfandel'")
        conn.commit()
        cursor.execute("DELETE FROM Wine WHERE Score < 92")
        conn.commit()
        cursor.execute("SELECT * FROM Wine")
        records = cursor.fetchall()
        print("---------------------------------------")
        for r in records:
            print(r)
        print("---------------------------------------")

        # Add a new column to the table called Revenue. It should have the same
        # type as your price column.
        cursor = conn.cursor()
        cursor.execute("ALTER TABLE Wine ADD Revenue INT")
        # A case is 12 bottles of wine. Using the information available to you,
        # set the revenue for each wine left in the table to be equal to the
        # total amount of money that can be made by selling all the cases of the
        # wine.
        cursor.execute("UPDATE Wine SET Revenue = Price * 12 * Cases")
        conn.commit()
        cursor.execute("SELECT * FROM Wine ORDER BY Revenue")
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
