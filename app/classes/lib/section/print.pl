% ============================================================================
% SECTION PRINTING UTILITIES
% ============================================================================
% Provides helper functions for printing section-related information.
% ============================================================================

% ============================================================================
% SECTION LIST PRINTING
% ============================================================================

% Print section list with details
print_section_list([]).
print_section_list([[CRN, Section, Instructor, Campus]|Rest]) :-
    format('  CRN: ~w, Section: ~w, Instructor: ~w, Campus: ~w~n', 
           [CRN, Section, Instructor, Campus]),
    print_section_list(Rest).

% Print sections scheduled on a specific day
print_day_sections([]).
print_day_sections([[CRN, Faculty, Number, Start, End]|Rest]) :-
    format('  CRN ~w: ~w ~w (~w-~w)~n', [CRN, Faculty, Number, Start, End]),
    print_day_sections(Rest).
