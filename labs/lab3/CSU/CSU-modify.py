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

        # Keep in DiscEnrollments info about conditions that are given:
        # 1. Engineering (9) majors from Campus 20, Campus 14, and Campus 8
        # 2. San Jose State (19) enrollments for disciplines with more than
        #   500 students
        # 3. All enrollments in LA County CSUs 4, 9, 10, 13, 14 where graduate
        #   enrollment exceeds undergraduate enrollment for the same discipline
        cursor.execute("DELETE FROM DiscEnrollments WHERE NOT \
                        ((CampusId = 20 AND Discipline = 9) OR \
                        (CampusId = 14 AND Discipline = 9) OR \
                        (CampusId = 8 AND Discipline = 9)) \
                       AND \
                       NOT (CampusId = 19 AND Grad > 500) \
                       AND \
                       NOT ((CampusId = 4 AND Grad > Undergrad) OR \
                       (CampusId = 9 AND Grad > Undergrad) OR \
                       (CampusId = 10 AND Grad > Undergrad) OR \
                       (CampusId = 13 AND Grad > Undergrad) OR \
                       (CampusId = 14 AND Grad > Undergrad))")
        conn.commit()
        cursor.execute("SELECT * FROM DiscEnrollments \
                       ORDER BY CampusId, Discipline")
        records = cursor.fetchall()
        print("---------------------------------------")
        for r in records:
            print(r)
        print("---------------------------------------")

        # Keep in the Fees table only info that matches ALL of the following:
        # 1. Fee is greater than 2,500
        # 2. Year is either 2002 or one of 2004 to 2006
        # 3. Campus is either 20, 14, or 17
        cursor.execute("DELETE FROM Fees WHERE NOT \
                        (CampusFee > 2500 AND \
                        (Year = 2002 OR (Year >= 2004 AND Year <= 2006)) AND \
                        (CampusId = 20 OR CampusId = 14 OR CampusId = 17))")
        conn.commit()
        cursor.execute("SELECT * FROM Fees \
                       ORDER BY CampusId, Year")
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
