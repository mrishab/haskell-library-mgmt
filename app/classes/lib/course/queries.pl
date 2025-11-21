% ============================================================================
% BASIC COURSE INFORMATION QUERIES
% ============================================================================

% Get course level (year) from course atom
course_level(CourseAtom, Level) :-
    course(CourseAtom, _, Number, _, _, _),
    Number >= 100, Number < 200, Level = 1.
course_level(CourseAtom, Level) :-
    course(CourseAtom, _, Number, _, _, _),
    Number >= 200, Number < 300, Level = 2.
course_level(CourseAtom, Level) :-
    course(CourseAtom, _, Number, _, _, _),
    Number >= 300, Number < 400, Level = 3.
course_level(CourseAtom, Level) :-
    course(CourseAtom, _, Number, _, _, _),
    Number >= 400, Number < 500, Level = 4.
course_level(CourseAtom, Level) :-
    course(CourseAtom, _, Number, _, _, _),
    Number < 100, Level = 0.

% Get full course information
course_info(CourseAtom, Info) :-
    course(CourseAtom, Faculty, Number, Name, Credits, Description),
    course_level(CourseAtom, Level),
    Info = [atom-CourseAtom, faculty-Faculty, number-Number, 
            name-Name, credits-Credits, level-Level, 
            description-Description].
