-- Using MySQL
-- Assumptions: Assuming data types are limited to strings and integers, assuming no string will need to be longer than 250 charactersname

DROP DATABASE IF EXISTS library;

CREATE DATABASE library;

USE library;

CREATE TABLE publisher (
    name VARCHAR(250),
    address VARCHAR(250),
    phone INT,
    PRIMARY KEY (name)
);

CREATE TABLE book (
    book_id INT NOT NULL,
    title VARCHAR(250),
    publisher_name VARCHAR(250),
    PRIMARY KEY (book_id),
    CONSTRAINT fk_book FOREIGN KEY (publisher_name)
        REFERENCES publisher (name)
);

CREATE TABLE book_authors (
    book_id INT,
    author_name VARCHAR(250),
    PRIMARY KEY (book_id , author_name),
    CONSTRAINT fk_bookauthors FOREIGN KEY (book_id)
        REFERENCES book (book_id)
);

CREATE TABLE library_branch (
    branch_id INT NOT NULL,
    branch_name VARCHAR(250),
    address VARCHAR(250),
    PRIMARY KEY (branch_id)
);

CREATE TABLE book_copies (
    book_id INT,
    branch_id INT,
    no_of_copies INT,
    PRIMARY KEY (book_id , branch_id),
    CONSTRAINT fk_bookcopies1 FOREIGN KEY (book_id)
        REFERENCES book (book_id),
    CONSTRAINT fk_bookcopies2 FOREIGN KEY (branch_id)
        REFERENCES library_branch (branch_id)
);

CREATE TABLE borrower (
    card_no INT NOT NULL,
    name VARCHAR(250),
    address VARCHAR(250),
    phone INT,
    PRIMARY KEY (card_no)
);

CREATE TABLE book_loans (
    book_id INT,
    branch_id INT,
    card_no INT,
    date_out INT,
    due_date INT,
    PRIMARY KEY (book_id , branch_id , card_no),
    CONSTRAINT fk_bookloans1 FOREIGN KEY (book_id)
        REFERENCES book (book_id),
    CONSTRAINT fk_bookloans2 FOREIGN KEY (branch_id)
        REFERENCES library_branch (branch_id),
    CONSTRAINT fk_bookloans3 FOREIGN KEY (card_no)
        REFERENCES borrower (card_no)
);


-- Insert data into the publisher table first
INSERT INTO publisher
VALUES
    ('Disney', 'Orlando, Florida', 111111),
    ('Jump Comics', 'Tokyo, Japan', 222222)
;

INSERT INTO book
VALUES
    (1, 'The Lightning Theif', 'Disney'),
    (2, 'Romance Dawn', 'Jump Comics')
;

INSERT INTO book_authors
VALUES
    (1, 'Rick Riordan'),
    (2, 'Eichiro Oda')
;

INSERT INTO library_branch
VALUES
    (11, 'Columbia', 'Broadway, Columbia MO'),
    (22, 'St Louis', 'Main Street, St. Louis MO')
;

INSERT INTO borrower
VALUES
    (123456, 'Jim', '333 Providence, Columbia MO', 7777777),
    (78910, 'John', '444 Avenue, St. Charles MO', 8888888)
;

INSERT INTO book_copies
VALUES
    (1, 11, 5),
    (2, 22, 12)
;

INSERT INTO book_loans
VALUES
    (1, 11, 123456, 41224, 51224),
    (2, 22, 123456, 41324, 51324)
;


-- Queries

SELECT branch_name, COUNT(book_id)
FROM library_branch
LEFT JOIN book_loans ON book_loans.branch_id = library_branch.branch_id
GROUP BY branch_name;

SELECT borrower.*
FROM borrower
LEFT JOIN book_loans ON borrower.card_no = book_loans.card_no
WHERE book_loans.card_no IS NULL;


-- Question 2
SELECT book.title, book.publisher_name, book_authors.author_name
FROM book
LEFT JOIN book_authors ON book.book_id = book_authors.book_id; 

SELECT book.title, borrower.name, borrower.phone
FROM book
INNER JOIN book_loans ON book.book_id = book_loans.book_id
INNER JOIN borrower ON book_loans.card_no = borrower.card_no

