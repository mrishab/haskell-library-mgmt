% ============================================================================
% HELPER UTILITIES
% ============================================================================


% append/3 - Concatenate two lists
append([], L, L).
append([H|T1], L2, [H|T3]) :- append(T1, L2, T3).

% length/2 - Get length of a list
list_length([], 0).
list_length([_|T], N) :- list_length(T, N1), N is N1 + 1.

% unique/2 - Remove duplicates from list
unique([], []).
unique([H|T], [H|Rest]) :-
    \+ member(H, T),
    unique(T, Rest).
unique([H|T], Rest) :-
    member(H, T),
    unique(T, Rest).

subset([], _).
subset([H|T], Set) :-
    member(H, Set),
    subset(T, Set).

% ============================================================================
% GENERAL PRINTING UTILITIES
% ============================================================================

% Print a generic list with bullet points
print_simple_list([]).
print_simple_list([H|T]) :-
    format('  - ~w~n', [H]),
    print_simple_list(T).
