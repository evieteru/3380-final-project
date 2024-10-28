from __future__ import print_function

import mysql.connector
from mysql.connector import errorcode
from mysql.connector import Error

DB_NAME = 'lego'



cnx = mysql.connector.connect(user='root', password='89661',
                              host='127.0.0.1',
                              )

cursor = cnx.cursor()



try:
    cursor.execute("USE {}".format(DB_NAME))
except mysql.connector.Error as err:
    print("Database {} does not exists.".format(DB_NAME))
    print(err)
    exit(1)



def add_set():

    theme_name = input("Enter the theme name to add set: ")
    username = input("Enter the username: ")
    set_name = input("Enter the set name: ")
    original_price = float(input("Enter the original price: "))
    selling_price = float(input("Enter the selling price: "))

    # Check if theme exists
    check_theme_query = "SELECT EXISTS(SELECT 1 FROM theme WHERE Name = %s)"
    # Check if user exists
    check_user_query = "SELECT EXISTS(SELECT 1 FROM user WHERE Username = %s)"

    add_query = """
    INSERT INTO `SET` (Theme_name, Username, Set_name, Original_price, Selling_price)
    VALUES (%s, %s, %s, %s, %s)
    """
    args = (theme_name, username, set_name, original_price, selling_price)

    try:
        #check username
        cursor.execute(check_user_query, (username,))
        username_exists = cursor.fetchone()[0]

        #check theme
        cursor.execute(check_theme_query, (theme_name,))
        theme_exists = cursor.fetchone()[0]

        #If they exist, add entry
        if username_exists and theme_exists:
            cursor.execute(add_query, args)
            cnx.commit()
            print("Set added successfully")

        else:
            if not theme_exists:
                print("Theme does not exist")
            if not username_exists:
                print("Username does not exist")

    except Error as err:
        print(f"Error: '{err}'")
    
    for a in cursor:
        print (a)



def delete_set():

    theme_name = input("Enter the theme name to delete: ")
    username = input("Enter the username to delete: ")
    set_name = input("Enter the set name to delete: ")
    original_price = float(input("Enter the original price to delete: "))
    selling_price = float(input("Enter the selling priceto delete: "))

    delete_query = """
    DELETE FROM `SET` 
    WHERE Theme_name = %s AND Username = %s AND Set_name = %s AND Original_price = %s AND Selling_price = %s
    """
    args = (theme_name, username, set_name, original_price, selling_price)

    try:
        cursor.execute(delete_query, args)
        cnx.commit()
        print("Set deleted successfully")
    except Error as err:
        print(f"Error: '{err}'")
    

def get_sets_by_theme():
    theme_name = input("Enter the theme name to search: ")

    check_theme_query = """SELECT EXISTS (
                     SELECT 1 FROM theme 
                     WHERE Name = %s
                     )"""
    get_sets_query = """SELECT Set_name 
                        FROM `set` 
                        WHERE Theme_name = %s"""
    
    try:
        #Chekcing if theme exists
        cursor.execute(check_theme_query, (theme_name,))
        theme_exists = cursor.fetchone()[0]

        if theme_exists == 1:
            print(f"Theme {theme_name} exists")
            cursor.execute(get_sets_query, (theme_name,))
            set_names = cursor.fetchall()

            if set_names:
                print(f"Sets with the theme {theme_name}:")
                for set_name in set_names:
                    print(set_name[0])
            else:
                print("No sets found for that theme")
        else:
            print(f"Theme {theme_name} does not exist")

    except Error as err:
        print("Error:", err)


def search_for_piece():
    piece_no = int(input("What is the piece number? "))

    check_piece_query = """SELECT `Piece_no`, `Quantity`
                           FROM `piece`
                           WHERE Piece_no = %s;"""

    set_name_containing_piece_query = """SELECT s.Set_name, comprised.Quantity_in_set
                                        FROM `set` AS s
                                        INNER JOIN `set_comprised_of_pieces` AS comprised
                                        ON comprised.Set_ID = s.Set_ID
                                        WHERE comprised.Piece_no = %s; """
    
    try:
        #Checking if piece exists
        cursor.execute(check_piece_query, (piece_no,))
        piece_info = cursor.fetchone()

        if piece_info:
            #Print piece info
            print(f"You have a total of {piece_info[1]} pieces with piece number {piece_info[0]}")

            #Get the name of sets if piece is in a set and print it 
            cursor.execute(set_name_containing_piece_query, (piece_no,))
            results = cursor.fetchall()

            if not results:
                print("Not in any sets")
            else:
                for row in results:
                    print(f"The {row[0]} set has {row[1]} pieces with piece number {piece_no}")

        else:
            print(f"No piece with {piece_no} found")
    
    except Error as err:
        print("Error: ", err)

    


print("Welcome to your lego database! Type \"menu\" to see options.\n")
while True:
    userInput = input("Enter your command: ")

    if userInput == "add set":
        add_set()
    elif userInput == "delete set":
        delete_set()
    elif userInput == "get sets by theme":
        get_sets_by_theme()
    elif userInput == "search for piece":
        search_for_piece()
    elif userInput == "menu":
        print("Choose from: add set, delete set, get sets by theme, search for piece, or exit")
    elif userInput == "exit":
        cursor.close()
        cnx.close()
        break
    else:
        print("Command not recognized. Type \"menu\" to see options")
