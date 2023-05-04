### MySQL test in Python

import mysql.connector
from mysql.connector import Error

pwdfileName = '../account.info'
pwdfile = open(pwdfileName,'r')
p = pwdfile.read().splitlines()


hostName = 'mysql.labthreesixfive.com'
portName = '3306'
userName = p[0]
passString =  p[1]

dbName = p[0]

try:
  
   conn = mysql.connector.connect(host = hostName, port = portName, database = dbName,
                                        user = userName, password = passString)
   if conn.is_connected():
      print('Connected to ',hostName)

    #   cursor = conn.cursor()
    #   cursor.execute("SELECT Distinct country from leagues")
    #   records = cursor.fetchall()
    #   ##  outFrame = pd.DataFrame(records, columns=['Country','NA'])
    #   print(records)
    #   print("---------------------------------------")
    #   for r in records:
    #      print(r)
    #   print("---------------------------------------")

    #   cr1 = conn.cursor()
    #   cr1.execute("CREATE TABLE Food (Id Int PRIMARY KEY, food varchar(20))")
    #   cr1.execute("INSERT INTO Food VALUES(1, 'apple'),(2,'carrot')")
    #   cr1.execute("SELECT * FROM Food")
    #   item1 = cr1.fetchone()
    #   item2 = cr1.fetchone()
    #   print("\n\n ---------------     ----------------\n")
    #   print(item1)
    #   print(item2)
    #   print("\n ---------------- -------------------\n")

    #   cr1.execute("DROP TABLE Food")
except Error as e:
    print('Connection error: ',e)

finally:
    if conn.is_connected():
    #    cursor.close()
    #    cr1.close()
       conn.close()
       print('Done')
