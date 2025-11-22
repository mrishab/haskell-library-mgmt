% ============================================================================
% LIBRARY MANAGEMENT SYSTEM - Demo Application
% ============================================================================

:- consult('lib/kb.pl').
:- consult('lib/book/queries.pl').
:- consult('lib/book/print.pl').
:- consult('lib/book/menu.pl').
:- consult('lib/member/queries.pl').
:- consult('lib/member/print.pl').
:- consult('lib/member/menu.pl').
:- consult('lib/loan/queries.pl').
:- consult('lib/loan/print.pl').
:- consult('lib/loan/menu.pl').

% ============================================================================
% MAIN ENTRY POINT
% ============================================================================

library_main :-
    writeln(''),
    writeln('╔════════════════════════════════════════════════════════════╗'),
    writeln('║         LIBRARY MANAGEMENT SYSTEM - MAIN MENU              ║'),
    writeln('╚════════════════════════════════════════════════════════════╝'),
    writeln(''),
    show_main_menu.

show_main_menu :-
    writeln('Please select an option:'),
    writeln(''),
    writeln('  1. Book Queries'),
    writeln('  2. Member Queries'),
    writeln('  3. Loan Queries'),
    writeln('  4. Exit'),
    writeln(''),
    write('Enter your choice (1-4): '),
    read_line_to_string(user_input, Input),
    (   number_string(Choice, Input)
    ->  process_main_choice(Choice)
    ;   writeln('Invalid input.'), show_main_menu
    ).

process_main_choice(1) :- !, book_menu, show_main_menu.
process_main_choice(2) :- !, member_menu, show_main_menu.
process_main_choice(3) :- !, loan_menu, show_main_menu.
process_main_choice(4) :- 
    writeln(''),
    writeln('Exiting Library Management System...'),
    writeln('').
process_main_choice(_) :-
    !,
    writeln('Invalid choice. Please try again.'),
    show_main_menu.

% ============================================================================
% INITIALIZATION
% ============================================================================

:- writeln('Library Management System loaded successfully!').
:- writeln('Type "library_main." to start.').
