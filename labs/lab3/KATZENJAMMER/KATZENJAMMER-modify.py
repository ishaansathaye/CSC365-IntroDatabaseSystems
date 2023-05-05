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

        # Replace all occurrences of bass balalaika with 'awesome bass balalaika'
        # and all occurrences of 'guitar' with 'acoustic guitar'
        cursor.execute("UPDATE Instruments \
                        SET Instrument = 'awesome bass balalaika' \
                        WHERE Instrument = 'bass balalaika'")
        conn.commit()
        cursor.execute("UPDATE Instruments \
                        SET Instrument = 'acoustic guitar' \
                        WHERE Instrument = 'guitar'")
        conn.commit()
        cursor.execute("SELECT * FROM Instruments")
        records = cursor.fetchall()
        print("---------------------------------------")
        for r in records:
            print(r)
        print("---------------------------------------")

        # Keep in instruments table only info about 'awesome bass balalaika'
        # players and the info about all instruments Anne-Marit (band member id
        # is 3) played on all songs
        cursor.execute("DELETE FROM Instruments WHERE NOT \
                        (Instrument = 'awesome bass balalaika') AND \
                        NOT (BandmateId = 3)")
        conn.commit()
        cursor.execute("SELECT * FROM Instruments \
                       ORDER BY SongId, BandmateId")
        records = cursor.fetchall()
        print("---------------------------------------")
        for r in records:
            print(r)
        print("---------------------------------------")

        # Add new attribute to table describing albums released by Katzenjammer
        # Attribute should store total number of songs on the album
        cursor.execute("ALTER TABLE Albums ADD COLUMN NumSongs INT")
        conn.commit()
        cursor.execute("SELECT * FROM Albums")
        records = cursor.fetchall()
        print("---------------------------------------")
        for r in records:
            print(r)
        print("---------------------------------------")

        # Based on info in tracklists table, update each record in the albums
        # table to show the correct number of tracks
        cursor.execute("UPDATE Albums \
                        SET NumSongs = 13 \
                        WHERE Id = 1")
        conn.commit()
        cursor.execute("UPDATE Albums \
                        SET NumSongs = 12 \
                        WHERE Id = 2")
        conn.commit()
        cursor.execute("UPDATE Albums \
                        SET NumSongs = 19 \
                        WHERE Id = 3")
        conn.commit()
        cursor.execute("UPDATE Albums \
                        SET NumSongs = 11 \
                        WHERE Id = 4")
        conn.commit()
        cursor.execute("SELECT * FROM Albums ORDER BY Year")
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
