% Book Menu
% -----------------------------------------------------------

book_menu :-
    writeln(''),
    writeln('--- Book Queries ---'),
    writeln('1. List all books'),
    writeln('2. List books by author'),
    writeln('3. List books by genre'),
    writeln('4. Back to Main Menu'),
    write('Enter choice: '),
    read_line_to_string(user_input, Input),
    (   number_string(Choice, Input)
    ->  process_book_choice(Choice)
    ;   writeln('Invalid input.'), book_menu
    ).

process_book_choice(1) :-
    all_books(Books),
    print_book_list(Books),
    book_menu.

process_book_choice(2) :-
    write('Enter author name (partial match): '),
    read_line_to_string(user_input, Author),
    books_by_author(Author, Books),
    print_book_list(Books),
    book_menu.

process_book_choice(3) :-
    write('Enter genre (partial match): '),
    read_line_to_string(user_input, Genre),
    books_in_genre(Genre, Books),
    print_book_list(Books),
    book_menu.

process_book_choice(4) :- !.

process_book_choice(_) :-
    writeln('Invalid choice.'),
    book_menu.
