% ============================================================================
% INSTRUCTOR UTILITIES
% ============================================================================

% Format instructor name for display
% Handles name(First, Middle, Last) structure
instructor_display_name(InstructorID, DisplayName) :-
    instructor(InstructorID, name(First, '', Last)),
    !,
    atom_concat(First, ' ', Temp),
    atom_concat(Temp, Last, DisplayName).
instructor_display_name(InstructorID, DisplayName) :-
    instructor(InstructorID, name(First, Middle, Last)),
    atom_concat(First, ' ', Temp1),
    atom_concat(Temp1, Middle, Temp2),
    atom_concat(Temp2, ' ', Temp3),
    atom_concat(Temp3, Last, DisplayName).

% Get instructor's full name as a string
instructor_full_name(InstructorID, FullName) :-
    instructor(InstructorID, name(First, Middle, Last)),
    (Middle = '' ->
        atom_concat(First, ' ', Temp),
        atom_concat(Temp, Last, FullName)
    ;
        atom_concat(First, ' ', Temp1),
        atom_concat(Temp1, Middle, Temp2),
        atom_concat(Temp2, ' ', Temp3),
        atom_concat(Temp3, Last, FullName)
    ).

% Handle team-taught sections (list of instructors)
instructors_full_names([], '').
instructors_full_names([InstructorID], FullName) :-
    instructor_full_name(InstructorID, FullName).
instructors_full_names([InstructorID|Rest], FullNames) :-
    Rest \= [],
    instructor_full_name(InstructorID, Name),
    instructors_full_names(Rest, RestNames),
    atom_concat(Name, ' / ', Temp),
    atom_concat(Temp, RestNames, FullNames).

% Get instructor name for a class section (handles both single and team-taught)
section_instructor_name(InstructorID, FullName) :-
    atom(InstructorID), !,  % Single instructor
    instructor_full_name(InstructorID, FullName).
section_instructor_name(InstructorList, FullNames) :-
    is_list(InstructorList), !,  % Team-taught
    instructors_full_names(InstructorList, FullNames).

% Get instructor first name
instructor_first_name(InstructorID, FirstName) :-
    instructor(InstructorID, name(FirstName, _, _)).

% Get instructor last name
instructor_last_name(InstructorID, LastName) :-
    instructor(InstructorID, name(_, _, LastName)).

% Get instructor middle name
instructor_middle_name(InstructorID, MiddleName) :-
    instructor(InstructorID, name(_, MiddleName, _)).

% Check if instructor has a middle name
has_middle_name(InstructorID) :-
    instructor(InstructorID, name(_, Middle, _)),
    Middle \= ''.

% Get all instructor IDs
all_instructors(Instructors) :-
    findall(ID, instructor(ID, _), Instructors).

% Get courses taught by an instructor
courses_taught_by(InstructorID, Courses) :-
    findall(CourseAtom, 
            class_section(_, _, CourseAtom, _, InstructorID, _, _, _, _, _),
            CourseList),
    list_to_set(CourseList, Courses).

% Get number of sections taught by an instructor
instructor_section_count(InstructorID, Count) :-
    findall(ClassAtom, 
            class_section(ClassAtom, _, _, _, InstructorID, _, _, _, _, _),
            Sections),
    length(Sections, Count).

% Get all instructors teaching a specific course
instructors_for_course(CourseAtom, Instructors) :-
    findall(InstructorID,
            class_section(_, _, CourseAtom, _, InstructorID, _, _, _, _, _),
            InstructorList),
    list_to_set(InstructorList, Instructors).

% Generate instructor schedule report
instructor_schedule(InstructorID) :-
    instructor(InstructorID, name(First, Middle, Last)),
    (Middle = '' -> 
        format('~n═══════════════════════════════════════════════════════════~n', []),
        format('INSTRUCTOR SCHEDULE: ~w ~w~n', [First, Last]),
        format('═══════════════════════════════════════════════════════════~n~n', [])
    ;
        format('~n═══════════════════════════════════════════════════════════~n', []),
        format('INSTRUCTOR SCHEDULE: ~w ~w ~w~n', [First, Middle, Last]),
        format('═══════════════════════════════════════════════════════════~n~n', [])
    ),
    findall([CRN, CourseAtom, SectionAtom, Campus],
            class_section(_, CRN, CourseAtom, SectionAtom, InstructorID, Campus, _, _, _, _),
            Classes),
    print_instructor_schedule(Classes),
    writeln('═══════════════════════════════════════════════════════════').

% Helper to print instructor schedule
print_instructor_schedule([]).
print_instructor_schedule([[CRN, CourseAtom, Section, Campus]|Rest]) :-
    course(CourseAtom, Faculty, Number, Name, Credits, _),
    upcase_atom(Faculty, FacultyUpper),
    format('CRN ~w: ~w ~w - ~w~n', [CRN, FacultyUpper, Number, Name]),
    format('  Section: ~w | Campus: ~w | Credits: ~w~n', [Section, Campus, Credits]),
    % Get schedule info if available
    (schedule(CRN, Day, StartTime, EndTime, _, _, _, _) ->
        format('  Schedule: ~w ~w-~w~n', [Day, StartTime, EndTime])
    ;
        true
    ),
    writeln(''),
    print_instructor_schedule(Rest).
