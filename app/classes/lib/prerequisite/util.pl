% ============================================================================
% PREREQUISITE UTILITIES
% ============================================================================

% Get direct prerequisites for a course
direct_prerequisites(CourseAtom, Prerequisites) :-
    findall(
        [Faculty, Number],
        (prerequisite(CourseAtom, PrereqAtom), course(PrereqAtom, Faculty, Number, _, _, _)),
        Prerequisites
    ).

% Get all prerequisites recursively (including prerequisites of prerequisites)
all_prerequisites(CourseAtom, AllPrereqs) :-
    all_prerequisites_helper(CourseAtom, [], AllPrereqAtoms),
    findall(
        [Faculty, Number],
        (member(PrereqAtom, AllPrereqAtoms), course(PrereqAtom, Faculty, Number, _, _, _)),
        AllPrereqs
    ).

all_prerequisites_helper(CourseAtom, Visited, AllPrereqs) :-
    findall(PrereqAtom, 
            (prerequisite(CourseAtom, PrereqAtom), 
             \+ member(PrereqAtom, Visited)),
            DirectPrereqs),
    (DirectPrereqs = [] ->
        AllPrereqs = []
    ;
        append(DirectPrereqs, Visited, NewVisited),
        findall(IndirectPrereq,
                (member(Prereq, DirectPrereqs),
                 all_prerequisites_helper(Prereq, NewVisited, SubPrereqs),
                 member(IndirectPrereq, SubPrereqs)),
                IndirectPrereqs),
        append(DirectPrereqs, IndirectPrereqs, TempPrereqs),
        list_to_set(TempPrereqs, AllPrereqs)
    ).

% Check if a course has any prerequisites
has_prerequisites(CourseAtom) :-
    prerequisite(CourseAtom, _).

% Check if student can take a course given completed courses
can_take_course(CourseAtom, CompletedCourses) :-
    direct_prerequisites(CourseAtom, RequiredPrereqs),
    subset(RequiredPrereqs, CompletedCourses).

% Check if student can take a course (no prerequisites check)
can_take_course_no_prereqs(CourseAtom) :-
    \+ has_prerequisites(CourseAtom).

% Get courses that have this course as a prerequisite
courses_requiring(PrereqCourseAtom, Courses) :-
    findall(CourseAtom, prerequisite(CourseAtom, PrereqCourseAtom), Courses).

% Get entry-level courses (courses with no prerequisites)
entry_level_courses(Courses) :-
    findall(
        [Faculty, Number],
        (course(CourseAtom, Faculty, Number, _, _, _), \+ has_prerequisites(CourseAtom)),
        Courses
    ).

% Get entry-level courses in a specific faculty
entry_level_courses_in_faculty(Faculty, Courses) :-
    findall(
        [Faculty, Number],
        (course(CourseAtom, Faculty, Number, _, _, _), \+ has_prerequisites(CourseAtom)),
        Courses
    ).

% Check if Course1 is a prerequisite for Course2 (directly or indirectly)
is_prerequisite_for(Course1, Course2) :-
    all_prerequisites(Course2, AllPrereqs),
    member(Course1, AllPrereqs).

% Get prerequisite chain (path from entry course to target course)
prerequisite_chain(CourseAtom, Chain) :-
    prerequisite_chain_helper(CourseAtom, [], Chain).

prerequisite_chain_helper(CourseAtom, _, [CourseAtom]) :-
    \+ has_prerequisites(CourseAtom), !.
prerequisite_chain_helper(CourseAtom, Visited, Chain) :-
    \+ member(CourseAtom, Visited),
    direct_prerequisites(CourseAtom, [FirstPrereq|_]),
    prerequisite_chain_helper(FirstPrereq, [CourseAtom|Visited], SubChain),
    append(SubChain, [CourseAtom], Chain).

% Get the depth/level of a course in the prerequisite tree
course_prerequisite_depth(CourseAtom, Depth) :-
    all_prerequisites(CourseAtom, AllPrereqs),
    length(AllPrereqs, Depth).

% Find courses with multiple prerequisites
courses_with_multiple_prerequisites(Courses) :-
    findall(CourseAtom,
            (course(CourseAtom, _, _, _, _, _),
             direct_prerequisites(CourseAtom, Prereqs),
             length(Prereqs, Count),
             Count > 1),
            Courses).
