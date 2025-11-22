% Book Print Helpers
% -----------------------------------------------------------

print_book_list([]).
print_book_list([H|T]) :-
    format('  - ~w~n', [H]),
    print_book_list(T).
