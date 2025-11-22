% Loan Menu
% -----------------------------------------------------------

loan_menu :-
    writeln(''),
    writeln('--- Loan Queries ---'),
    writeln('1. List available books'),
    writeln('2. List books borrowed by member'),
    writeln('3. Back to Main Menu'),
    write('Enter choice: '),
    read(Choice),
    process_loan_choice(Choice).

process_loan_choice(1) :-
    available_books(Books),
    print_loan_list(Books),
    loan_menu.

process_loan_choice(2) :-
    write('Enter member name: '),
    read(MemberName),
    borrowed_by_member(MemberName, Books),
    print_loan_list(Books),
    loan_menu.

process_loan_choice(3) :- !.

process_loan_choice(_) :-
    writeln('Invalid choice.'),
    loan_menu.
