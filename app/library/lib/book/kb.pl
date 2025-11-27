% Book Knowledge Base
% -----------------------------------------------------------
% item(ID, Title).
% has_property(ItemID, Property, Value).

% ============================================================================
% ITEM DEFINITIONS (All item/2 clauses together)
% ============================================================================

item(1, 'The Hobbit').
item(2, '1984').
item(3, 'To Kill a Mockingbird').
item(4, 'The Great Gatsby').
item(5, 'The Catcher in the Rye').
item(6, 'The Silmarillion').
item(7, 'Brave New World').
item(8, 'The Lord of the Rings').
item(9, 'Harry Potter and the Sorcerer\'s Stone').
item(10, 'The Shining').
item(11, 'Pride and Prejudice').
item(12, 'Dune').
item(13, 'Neuromancer').

% ============================================================================
% ITEM PROPERTIES (All has_property/3 clauses together)
% ============================================================================

% Item 1: The Hobbit
has_property(1, title, 'The Hobbit').
has_property(1, author, 'J.R.R. Tolkien').
has_property(1, genre, 'Fantasy').
has_property(1, year, 1937).

% Item 2: 1984
has_property(2, title, '1984').
has_property(2, author, 'George Orwell').
has_property(2, genre, 'Dystopian').
has_property(2, year, 1949).

% Item 3: To Kill a Mockingbird
has_property(3, title, 'To Kill a Mockingbird').
has_property(3, author, 'Harper Lee').
has_property(3, genre, 'Fiction').
has_property(3, year, 1960).

% Item 4: The Great Gatsby
has_property(4, title, 'The Great Gatsby').
has_property(4, author, 'F. Scott Fitzgerald').
has_property(4, genre, 'Classic').
has_property(4, year, 1925).

% Item 5: The Catcher in the Rye
has_property(5, title, 'The Catcher in the Rye').
has_property(5, author, 'J.D. Salinger').
has_property(5, genre, 'Classic').
has_property(5, year, 1951).

% Item 6: The Silmarillion
has_property(6, title, 'The Silmarillion').
has_property(6, author, 'J.R.R. Tolkien').
has_property(6, genre, 'Fantasy').
has_property(6, year, 1977).

% Item 7: Brave New World
has_property(7, title, 'Brave New World').
has_property(7, author, 'Aldous Huxley').
has_property(7, genre, 'Dystopian').
has_property(7, year, 1932).

% Item 8: The Lord of the Rings
has_property(8, title, 'The Lord of the Rings').
has_property(8, author, 'J.R.R. Tolkien').
has_property(8, genre, 'Fantasy').
has_property(8, year, 1954).

% Item 9: Harry Potter and the Sorcerer's Stone
has_property(9, title, 'Harry Potter and the Sorcerer\'s Stone').
has_property(9, author, 'J.K. Rowling').
has_property(9, genre, 'Fantasy').
has_property(9, year, 1997).

% Item 10: The Shining
has_property(10, title, 'The Shining').
has_property(10, author, 'Stephen King').
has_property(10, genre, 'Horror').
has_property(10, year, 1977).

% Item 11: Pride and Prejudice
has_property(11, title, 'Pride and Prejudice').
has_property(11, author, 'Jane Austen').
has_property(11, genre, 'Classic').
has_property(11, year, 1813).

% Item 12: Dune
has_property(12, title, 'Dune').
has_property(12, author, 'Frank Herbert').
has_property(12, genre, 'Science Fiction').
has_property(12, year, 1965).

% Item 13: Neuromancer
has_property(13, title, 'Neuromancer').
has_property(13, author, 'William Gibson').
has_property(13, genre, 'Science Fiction').
has_property(13, year, 1984).
