% ============================================================================
% BASIC COURSE INFORMATION QUERIES
% ============================================================================

% Get full course information
course_info(CourseAtom, Info) :-
    course(CourseAtom, Faculty, Number, Name, Credits, Description),
    course_level(CourseAtom, Level),
    Info = [atom-CourseAtom, faculty-Faculty, number-Number, 
            name-Name, credits-Credits, level-Level, 
            description-Description].
