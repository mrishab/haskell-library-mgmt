% ============================================================================
% COURSE ATOM UTILITIES
% ============================================================================

% Extract faculty code from course atom
get_faculty(CourseAtom, Faculty) :-
    course(CourseAtom, Faculty, _, _, _, _).

% Extract course number from course atom  
get_course_number(CourseAtom, Number) :-
    course(CourseAtom, _, Number, _, _, _).

% Get course name
get_course_name(CourseAtom, Name) :-
    course(CourseAtom, _, _, Name, _, _).

% Get course credits
get_course_credits(CourseAtom, Credits) :-
    course(CourseAtom, _, _, _, Credits, _).

% Get course description
get_course_description(CourseAtom, Description) :-
    course(CourseAtom, _, _, _, _, Description).

% Get full course code display (e.g., "COMP 150" from comp_150)
course_display_code(CourseAtom, Code) :-
    course(CourseAtom, Faculty, Number, _, _, _),
    upcase_atom(Faculty, FacultyUpper),
    atom_concat(FacultyUpper, ' ', Temp),
    atom_concat(Temp, Number, Code).

% Get course level (1st digit of course number)
course_level(CourseAtom, Level) :-
    course(CourseAtom, _, Number, _, _, _),
    atom_number(Number, Num),
    Level is Num // 100.

% Check if course is first year (100-level)
is_first_year_course(CourseAtom) :-
    course_level(CourseAtom, 1).

% Check if course is second year (200-level)
is_second_year_course(CourseAtom) :-
    course_level(CourseAtom, 2).

% Check if course is third year (300-level)
is_third_year_course(CourseAtom) :-
    course_level(CourseAtom, 3).

% Check if course is fourth year (400-level)
is_fourth_year_course(CourseAtom) :-
    course_level(CourseAtom, 4).

% Get all courses for a faculty
courses_in_faculty(Faculty, Courses) :-
    findall(CourseAtom, course(CourseAtom, Faculty, _, _, _, _), Courses).

% Get all courses with specific credit value
courses_with_credits(Credits, Courses) :-
    findall(CourseAtom, course(CourseAtom, _, _, _, Credits, _), Courses).

% Get all courses at a specific level
courses_at_level(Level, Courses) :-
    findall(CourseAtom, 
            (course(CourseAtom, _, Number, _, _, _),
             atom_number(Number, Num),
             Num >= Level * 100,
             Num < (Level + 1) * 100),
            Courses).