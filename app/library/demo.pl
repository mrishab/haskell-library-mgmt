% ============================================================================
% LIBRARY MANAGEMENT SYSTEM - Demo Application
% ============================================================================

:- consult('library.pl').

% ============================================================================
% MAIN ENTRY POINT
% ============================================================================

library_main :-
    writeln(''),
    writeln('╔════════════════════════════════════════════════════════════╗'),
    writeln('║         LIBRARY MANAGEMENT SYSTEM - DEMO                   ║'),
    writeln('╚════════════════════════════════════════════════════════════╝'),
    writeln(''),
    writeln('This is a demo application for the Library Management System.'),
    writeln(''),
    library_demo,
    writeln(''),
    writeln('Demo completed. Returning to main menu...').

% ============================================================================
% DEMO QUERIES
% ============================================================================

library_demo :-
    writeln('=== LIBRARY DEMO ==='),
    writeln(''),
    
    % All currently available book titles
    writeln('Available Books:'),
    findall(Title, (available(BID), book(BID, Title, _, _, _)), Available),
    print_list(Available),
    writeln(''),
    
    % Books borrowed by Bob Smith
    writeln('Books Borrowed by Bob Smith:'),
    findall(BookTitle, borrowed_by('Bob Smith', BookTitle), BorrowedByBob),
    print_list(BorrowedByBob),
    writeln('').

% Helper to print a list
print_list([]).
print_list([H|T]) :-
    format('  - ~w~n', [H]),
    print_list(T).

% ============================================================================
% INITIALIZATION
% ============================================================================

:- writeln('Library Management System loaded successfully!').
