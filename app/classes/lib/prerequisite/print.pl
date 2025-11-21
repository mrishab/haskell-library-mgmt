% ============================================================================
% PREREQUISITE PRINTING UTILITIES
% ============================================================================
% Provides helper functions for printing prerequisite information.
% ============================================================================

% ============================================================================
% PREREQUISITE LIST PRINTING
% ============================================================================

% Print prerequisite list
print_prereq_list([]) :-
    writeln('  None').
print_prereq_list([[Faculty, Number]|Rest]) :-
    format('  ~w ~w~n', [Faculty, Number]),
    print_prereq_list(Rest).
