% ============================================================================
% FACULTY UTILITIES
% ============================================================================

% Get faculty full name
faculty_full_name(FacultyCode, FullName) :-
    faculty(FacultyCode, FullName).

% Check if faculty code exists
is_valid_faculty(FacultyCode) :-
    faculty(FacultyCode, _).

% Get all faculty codes
all_faculties(Faculties) :-
    findall(Code, faculty(Code, _), Faculties).

% Get all faculty full names
all_faculty_names(Names) :-
    findall(Name, faculty(_, Name), Names).
