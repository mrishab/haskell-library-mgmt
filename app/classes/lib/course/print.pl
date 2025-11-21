% ============================================================================
% COURSE PRINTING UTILITIES
% ============================================================================
% Provides helper functions for printing course-related information.
% ============================================================================

% ============================================================================
% COURSE LIST PRINTING
% ============================================================================

% Print a simple course list (without faculty code)
print_course_list([]).
print_course_list([[Number, Name, Credits]|Rest]) :-
    format('  ~w - ~w (~w credits)~n', [Number, Name, Credits]),
    print_course_list(Rest).

% Print course list with faculty code
print_course_list_with_faculty([]).
print_course_list_with_faculty([[Faculty, Number, Name]|Rest]) :-
    format('  ~w ~w - ~w~n', [Faculty, Number, Name]),
    print_course_list_with_faculty(Rest).

% Print popular courses with section counts
print_popular_courses([]).
print_popular_courses([[Faculty, Number, Count]|Rest]) :-
    format('  ~w ~w: ~w sections~n', [Faculty, Number, Count]),
    print_popular_courses(Rest).
