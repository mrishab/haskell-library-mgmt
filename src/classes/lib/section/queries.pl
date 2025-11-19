% ============================================================================
% SECTION QUERIES
% ============================================================================

% Get all sections for a course
course_sections(CourseAtom, Sections) :-
    findall([CRN, Section, InstructorID, Campus, Method, MaxEnroll, StartDate, EndDate],
            class_section(CRN, CourseAtom, Section, InstructorID, Campus, 
                         Method, MaxEnroll, StartDate, EndDate),
            Sections).

% Check if section is online/in-person/hybrid
is_online(CRN) :-
    class_section(CRN, _, _, _, _, online_sync, _, _, _).
is_online(CRN) :-
    class_section(CRN, _, _, _, _, online_async, _, _, _).

is_inperson(CRN) :-
    class_section(CRN, _, _, _, _, face_to_face, _, _, _).

is_hybrid(CRN) :-
    class_section(CRN, _, _, _, _, blended, _, _, _).

% Get all sections on a campus
sections_on_campus(Campus, Sections) :-
    findall([CRN, CourseAtom, Section, InstructorID],
            class_section(CRN, CourseAtom, Section, InstructorID, 
                         Campus, _, _, _, _),
            Sections).

% Get all sections on a specific day
sections_on_day(Day, Sections) :-
    findall([CRN, StartTime, EndTime, Building, Room],
            schedule(CRN, Day, StartTime, EndTime, Building, Room, _, _),
            SectionsWithDups),
    unique(SectionsWithDups, Sections).

% Check if two sections have time conflict
time_conflict(CRN1, CRN2) :-
    CRN1 \= CRN2,
    schedule(CRN1, Day, Start1, End1, _, _, Date1, _),
    schedule(CRN2, Day, Start2, End2, _, _, Date2, _),
    Date1 = Date2,  % Same date
    time_overlap(Start1, End1, Start2, End2).
