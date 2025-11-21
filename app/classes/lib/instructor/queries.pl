% ============================================================================
% INSTRUCTOR QUERIES
% ============================================================================

% Get all courses taught by an instructor
courses_by_instructor(InstructorID, Courses) :-
    findall(CourseAtom, 
            class_section(_, CourseAtom, _, InstructorID, _, _, _, _, _),
            CoursesWithDups),
    unique(CoursesWithDups, Courses).

% Handle team-taught courses
courses_by_instructor_in_team(InstructorID, Courses) :-
    findall(CourseAtom,
            (class_section(_, CourseAtom, _, InstructorList, _, _, _, _, _),
             is_list(InstructorList),
             member(InstructorID, InstructorList)),
            CoursesWithDups),
    unique(CoursesWithDups, Courses).

% Get all courses taught by instructor (including team-taught)
all_courses_by_instructor(InstructorID, AllCourses) :-
    courses_by_instructor(InstructorID, SingleCourses),
    courses_by_instructor_in_team(InstructorID, TeamCourses),
    append(SingleCourses, TeamCourses, CoursesWithDups),
    unique(CoursesWithDups, AllCourses).


% Calculate instructor teaching load (number of sections)
instructor_load(InstructorID, Load) :-
    findall(CRN, class_section(CRN, _, _, InstructorID, _, _, _, _, _), Sections),
    list_length(Sections, Load).
