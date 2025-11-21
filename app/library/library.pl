% Library Knowledge Base


% -----------------------------
% Books and Authors
% -----------------------------
% book(BookID, Title, Author, Genre, Year).
book(b101, 'The Hobbit', 'J.R.R. Tolkien', fantasy, 1937).
book(b102, '1984', 'George Orwell', dystopian, 1949).
book(b103, 'To Kill a Mockingbird', 'Harper Lee', fiction, 1960).
book(b104, 'The Great Gatsby', 'F. Scott Fitzgerald', classic, 1925).
book(b105, 'The Catcher in the Rye', 'J.D. Salinger', classic, 1951).
book(b106, 'The Silmarillion', 'J.R.R. Tolkien', fantasy, 1977).
book(b107, 'Brave New World', 'Aldous Huxley', dystopian, 1932).
book(b108, 'The Lord of the Rings', 'J.R.R. Tolkien', fantasy, 1954).

% -----------------------------
% Library Members
% -----------------------------
% member(MemberID, Name).
member(m001, 'Alice Johnson').
member(m002, 'Bob Smith').
member(m003, 'Carol Davis').
member(m004, 'David Lee').
member(m005, 'Eve Brown').

% -----------------------------
% Borrowed Books
% -----------------------------
% borrowed(MemberID, BookID, DueDate).
borrowed(m001, b101, '2025-11-20').
borrowed(m002, b103, '2025-11-25').
borrowed(m002, b108, '2025-11-18').
borrowed(m003, b104, '2025-11-15').
borrowed(m005, b105, '2025-11-27').




available(BookID) :-
    book(BookID, _, _, _, _),
    \+ borrowed(_, BookID, _).


same_author(Book1, Book2) :-
    book(Book1, _, Author, _, _),
    book(Book2, _, Author, _, _),
    Book1 \= Book2.


borrowed_by(MemberName, BookTitle) :-
    member(MemberID, MemberName),
    borrowed(MemberID, BookID, _),
    book(BookID, BookTitle, _, _, _).


borrowed_author_books(Author, MemberName) :-
    borrowed(MemberID, BookID, _),
    book(BookID, _, Author, _, _),
    member(MemberID, MemberName).


related_books(Book1, Book2) :-
    same_author(Book1, Book2).

related_books(Book1, Book2) :-
    same_author(Book1, Intermediate),
    related_books(Intermediate, Book2),
    Book1 \= Book2.