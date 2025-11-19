% ============================================================================
% COREQUISITE UTILITIES
% ============================================================================

% Get all corequisites for a course
find_corequisites(CourseAtom, Corequisites) :-
    findall(CoreqAtom, corequisite(CourseAtom, CoreqAtom), Corequisites).

% Check if a course has any corequisites
has_corequisites(CourseAtom) :-
    corequisite(CourseAtom, _).

% Check if two courses are corequisites of each other
are_corequisites(Course1, Course2) :-
    corequisite(Course1, Course2).

% Get all courses with corequisites
courses_with_corequisites(Courses) :-
    findall(CourseAtom,
            (course(CourseAtom, _, _, _, _, _),
             has_corequisites(CourseAtom)),
            CourseList),
    list_to_set(CourseList, Courses).
