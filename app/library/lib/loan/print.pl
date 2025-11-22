% Loan Print Helpers
% -----------------------------------------------------------

print_loan_list([]).
print_loan_list([H|T]) :-
    format('  - ~w~n', [H]),
    print_loan_list(T).
