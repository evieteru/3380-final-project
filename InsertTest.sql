INSERT INTO authors (author_name) VALUES
('Jane Austen'),
('George Orwell'),
('J.K. Rowling');

INSERT INTO books (title, author_id, publication_year, isbn) VALUES
('Pride and Prejudice', 1, 1813, '9780141439518'),
('1984', 2, 1949, '9780451524935'),
('Harry Potter and the Philosopher''s Stone', 3, 1997, '9781408855652');

INSERT INTO book_loans (book_id, borrower_name, loan_date, return_date) VALUES
(1, 'Alice', '2023-01-15', '2023-02-15'),
(2, 'Bob', '2023-02-01', NULL),
(3, 'Charlie', '2023-03-10', NULL);