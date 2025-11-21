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
    (number(Number) -> Num = Number ; atom_number(Number, Num)),
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
    findall([Number, Name, Credits], 
            course(_, Faculty, Number, Name, Credits, _), 
            Courses).

% Get all courses with specific credit value
courses_with_credits(Credits, Courses) :-
    findall([Faculty, Number, Name], 
            course(_, Faculty, Number, Name, Credits, _), 
            Courses).

% Get all courses at a specific level
courses_at_level(Level, Courses) :-
    findall([Faculty, Number, Name], 
            (course(_, Faculty, Number, Name, _, _),
             (number(Number) -> Num = Number ; atom_number(Number, Num)),
             Num >= Level * 100,
             Num < (Level + 1) * 100),
            Courses).

% Get all section atoms for a specific course
course_sections(CourseAtom, Sections) :-
    findall([CRN, SectionAtom, InstructorID, Campus],
            class_section(_, CRN, CourseAtom, SectionAtom, InstructorID, Campus, _, _, _, _),
            Sections).

% Get all class information for a course
course_classes(CourseAtom, Classes) :-
    findall([ClassAtom, CRN, SectionAtom, InstructorID],
            class_section(ClassAtom, CRN, CourseAtom, SectionAtom, InstructorID, _, _, _, _, _),
            Classes).

% Find courses with multiple sections (popular courses)
popular_courses(PopularCourses) :-
    findall([Faculty, Number, Count],
            (course(CourseAtom, Faculty, Number, _, _, _),
             findall(CRN, class_section(_, CRN, CourseAtom, _, _, _, _, _, _, _), Sections),
             list_length(Sections, Count),
             Count > 1),
            PopularCourses).

% Generate detailed course offering report
course_offering_report(CourseAtom) :-
    course(CourseAtom, Faculty, Number, Name, Credits, Description),
    upcase_atom(Faculty, FacultyUpper),
    writeln(''),
    writeln('═══════════════════════════════════════════════════════════'),
    format('COURSE OFFERING REPORT: ~w ~w~n', [FacultyUpper, Number]),
    writeln('═══════════════════════════════════════════════════════════'),
    writeln(''),
    format('Course Name: ~w~n', [Name]),
    format('Credits: ~w~n', [Credits]),
    format('Description: ~w~n', [Description]),
    writeln(''),
    writeln('SECTIONS OFFERED:'),
    writeln(''),
    findall([CRN, SectionAtom, InstructorID, Campus, Method, MaxEnroll],
            class_section(_, CRN, CourseAtom, SectionAtom, InstructorID, Campus, 
                         Method, MaxEnroll, _, _),
            Sections),
    print_course_sections(Sections),
    writeln(''),
    writeln('═══════════════════════════════════════════════════════════').

% Helper to print course sections
print_course_sections([]).
print_course_sections([[CRN, Section, Instructor, Campus, Method, MaxEnroll]|Rest]) :-
    format('  CRN ~w: Section ~w~n', [CRN, Section]),
    format('    Instructor: ~w~n', [Instructor]),
    format('    Campus: ~w~n', [Campus]),
    format('    Method: ~w~n', [Method]),
    format('    Max Enrollment: ~w~n', [MaxEnroll]),
    writeln(''),
    print_course_sections(Rest).

% Get total capacity for a course across all sections
total_course_capacity(CourseAtom, TotalCapacity) :-
    findall(MaxEnroll,
            class_section(_, _, CourseAtom, _, _, _, _, MaxEnroll, _, _),
            Capacities),
    sum_list(Capacities, TotalCapacity).

% Helper to sum a list
sum_list([], 0).
sum_list([H|T], Sum) :-
    sum_list(T, TSum),
    Sum is H + TSum.

% Find team-taught sections
team_taught_sections(Sections) :-
    findall([CRN, Faculty, Number, InstructorList],
            (class_section(_, CRN, CourseAtom, _, InstructorList, _, _, _, _, _),
             is_list(InstructorList),
             course(CourseAtom, Faculty, Number, _, _, _)),
            Sections).