% ============================================================================
% INSTRUCTOR PRINTING UTILITIES
% ============================================================================
% Provides helper functions for printing instructor-related information.
% ============================================================================

% ============================================================================
% INSTRUCTOR LIST PRINTING
% ============================================================================

% Print courses taught by an instructor
print_instructor_course_list([]).
print_instructor_course_list([[Faculty, Number, Section]|Rest]) :-
    format('  ~w ~w (Section ~w)~n', [Faculty, Number, Section]),
    print_instructor_course_list(Rest).

% Print team-taught courses
print_team_taught([]).
print_team_taught([[CRN, Faculty, Number, Instructor]|Rest]) :-
    format('  CRN ~w: ~w ~w taught by ~w~n', [CRN, Faculty, Number, Instructor]),
    print_team_taught(Rest).
