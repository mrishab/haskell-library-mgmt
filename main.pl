:- consult('app/archives.pl').
:- consult('app/classes.pl').
:- consult('app/library.pl').

main(Result) :-
	% All currently available book titles
	findall(Title, (available(BID), book(BID, Title, _, _, _)), Available),
	% Books borrowed by Bob Smith
	findall(BookTitle, borrowed_by('Bob Smith', BookTitle), BorrowedByBob),
	Result = demo{available:Available, bob_borrowed:BorrowedByBob}.

run :-
    main(R),
    pretty_print(R).

pretty_print(demo{available:Available, bob_borrowed:BorrowedByBob}) :-
    writeln('=== LIBRARY DEMO RESULTS ==='),
    nl,
    writeln('Available Books:'),
    writeln(Available),
    nl,
    writeln('Books Borrowed by Bob Smith:'),
    writeln(BorrowedByBob).