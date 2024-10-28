import mysql.connector
from mysql.connector import Error

def create_connection():
    try:
        connection = mysql.connector.connect(
           user='root', password='89661', host='127.0.0.1', database='first' 
        )
        if connection.is_connected():
            print('Connected')
        return connection
    except Error as e:
        print("Error")

myConnection = mysql.connector.connect(user='root', password='89661', host='127.0.0.1', database='first')



def create_table(connection):
    try:
        cursor = connection.cursor()
        create_table_query = """
        CREATE TABLE IF NOT EXISTS employeer (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255) NOT NULL
        )
        """
        cursor.execute(create_table_query)
        connection.commit
        print("Table created successfully")
    except Error as e:
        print("Failed to create table")


def get_puzzles(connection):
    try:
        cursor = connection.cursor()
        get_puzzles_query = """
        SELECT `name`
        FROM `puzzles`
        """
        cursor.execute(get_puzzles_query)
        connection.commit
        print("Got puzzles")
        for name in cursor:
            print(name)
    except Error as e:
        print("Query failed")
    

connection = create_connection()
if connection:
    create_table(connection)
    get_puzzles(connection)
    connection.close