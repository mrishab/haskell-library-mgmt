% Member Print Helpers
% -----------------------------------------------------------

print_member_list([]).
print_member_list([H|T]) :-
    format('  - ~w~n', [H]),
    print_member_list(T).
