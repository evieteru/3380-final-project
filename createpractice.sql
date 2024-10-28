DROP DATABASE IF EXISTS first;

CREATE DATABASE first;

USE first;

CREATE TABLE puzzle (
    name VARCHAR(250) NOT NULL,
    difficulty VARCHAR(250),
    numberofsets INT,
    location VARCHAR(250),
    PRIMARY KEY (name)
);

CREATE TABLE user (
    name VARCHAR(250) NOT NULL,
    skill VARCHAR(250),
    age INT,
    PRIMARY KEY (name)
);

CREATE TABLE solving (
    username VARCHAR(250),
    puzzlename VARCHAR(250),
    PRIMARY KEY (username , puzzlename),
    CONSTRAINT fk_solving FOREIGN KEY (username)
        REFERENCES user (name),
    CONSTRAINT fk_2_solving FOREIGN KEY (puzzlename)
        REFERENCES puzzle (name)
);

INSERT INTO puzzle
VALUES 
	('Rubik Cube', 'Hard', 3, 'Living Room'),
    ('Sudoku', 'Medium', 1, 'Kitchen'),
    ('Jigsaw', 'Medium', 4, 'Living Room')
    ;
    
    


