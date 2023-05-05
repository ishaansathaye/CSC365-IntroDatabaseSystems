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

        # Remove from the table containing the listing of the pastries,
        # information about all pastries that are cheaper than $5
        # first need to remove from table that references this table
        cursor.execute("DELETE FROM Items WHERE Item IN \
                       (SELECT ID FROM Goods WHERE Price < 5)")
        cursor.execute("DELETE FROM Goods WHERE Price < 5")
        conn.commit()
        cursor.execute("SELECT * FROM Goods")
        records = cursor.fetchall()
        print("---------------------------------------")
        for r in records:
            print(r)
        print("---------------------------------------")

        # Increase the prices of the chocolate-flavored items by 35%
        cursor.execute("UPDATE Goods SET Price = Price * 1.35 \
                        WHERE Flavor = 'Chocolate'")
        conn.commit()
        cursor.execute("SELECT * FROM Goods")
        records = cursor.fetchall()
        print("---------------------------------------")
        for r in records:
            print(r)
        print("---------------------------------------")

        # Reduce the prices of Lemon-flavored items by $2
        cursor.execute("UPDATE Goods SET Price = Price - 2 \
                        WHERE Flavor = 'Lemon'")
        conn.commit()
        cursor.execute("SELECT * FROM Goods")
        records = cursor.fetchall()
        print("---------------------------------------")
        for r in records:
            print(r)
        print("---------------------------------------")

        # Reduce the price of all other cakes by 10% so not chocolate or lemon
        # flavored cakes
        cursor.execute("UPDATE Goods SET Price = Price * 0.9 \
                        WHERE Food = 'Cake' AND Flavor != 'Chocolate' \
                        AND Flavor != 'Lemon'")
        conn.commit()
        cursor.execute("SELECT * FROM Goods")
        records = cursor.fetchall()
        print("---------------------------------------")
        for r in records:
            print(r)
        print("---------------------------------------")

        # Make the price of pie items equal to the price of the
        # least expensive cake
        cursor.execute("UPDATE Goods SET Price = 6.95 \
                        WHERE Food = 'Pie'")
        conn.commit()
        cursor.execute("SELECT * FROM Goods ORDER BY Id")
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
