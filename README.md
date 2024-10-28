### Mizzou CS 3380 Final Project
**Evie Wilbur**

**Description:** This is a simple databse for storing information about a Lego Collection. It demonstrates my knowledge of normalization, implementing relational database schema, SQL queries, and connection to a RDBMS using Python

## Parts
# createLego.sql
This is a SQL script written using MySQL that implements the relational database schema developed in Phase 2. It creates the necessary tables with attributes and constraints, and populates the tables with 2-5 synthetic data entries. This must be run before using finalprojectfunctions.py.

# finalprojectfunctions.py
This connects to my database created in createLego.sql. It has a rudimentary menu functionality that provides the user with the option to add or delete a set entry from the `set` table, get sets by theme, or search for a piece. To use, simply start the program and choose one of the options.