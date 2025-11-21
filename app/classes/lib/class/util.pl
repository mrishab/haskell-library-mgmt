% ============================================================================
% CLASS UTILITIES
% ============================================================================

% Get class CRN
class_crn(ClassAtom, CRN) :-
    class_section(ClassAtom, CRN, _, _, _, _, _, _, _, _).

% Get class course atom
class_course(ClassAtom, CourseAtom) :-
    class_section(ClassAtom, _, CourseAtom, _, _, _, _, _, _, _).

% Get class section atom
class_section_atom(ClassAtom, SectionAtom) :-
    class_section(ClassAtom, _, _, SectionAtom, _, _, _, _, _, _).

% Get class instructor
class_instructor(ClassAtom, InstructorID) :-
    class_section(ClassAtom, _, _, _, InstructorID, _, _, _, _, _).

% Get class campus
class_campus(ClassAtom, Campus) :-
    class_section(ClassAtom, _, _, _, _, Campus, _, _, _, _).

% Get class instructional method
class_method(ClassAtom, Method) :-
    class_section(ClassAtom, _, _, _, _, _, Method, _, _, _).

% Get class max enrollment
class_max_enrollment(ClassAtom, Max) :-
    class_section(ClassAtom, _, _, _, _, _, _, Max, _, _).

% Get class start date
class_start_date(ClassAtom, StartDate) :-
    class_section(ClassAtom, _, _, _, _, _, _, _, StartDate, _).

% Get class end date
class_end_date(ClassAtom, EndDate) :-
    class_section(ClassAtom, _, _, _, _, _, _, _, _, EndDate).

% Check if class is online
is_online_class(ClassAtom) :-
    class_section(ClassAtom, _, _, _, _, on, _, _, _, _).

% Check if class is face-to-face
is_face_to_face_class(ClassAtom) :-
    class_section(ClassAtom, _, _, _, _, _, face_to_face, _, _, _).

% Check if class is blended
is_blended_class(ClassAtom) :-
    class_section(ClassAtom, _, _, _, _, _, blended, _, _, _).

% Check if class uses online sync method
is_online_sync_class(ClassAtom) :-
    class_section(ClassAtom, _, _, _, _, _, online_sync, _, _, _).

% Check if a CRN is online (by checking if it uses online campus or method)
is_online(CRN) :-
    (class_section(_, CRN, _, _, _, on, _, _, _, _) ;
     class_section(_, CRN, _, _, _, _, online_sync, _, _, _) ;
     class_section(_, CRN, _, _, _, _, online_async, _, _, _)).

% Check if a CRN is hybrid/blended
is_hybrid(CRN) :-
    (class_section(_, CRN, _, _, _, _, blended, _, _, _) ;
     class_section(_, CRN, _, _, _, _, hybrid, _, _, _)).

% Get all sections on a specific campus (by CRN)
sections_on_campus(Campus, Sections) :-
    findall(CRN,
            class_section(_, CRN, _, _, _, Campus, _, _, _, _),
            Sections).

% Get all sections meeting on a specific day (by CRN)
sections_on_day(Day, Sections) :-
    findall(CRN,
            (schedule(CRN, Day, _, _, _)),
            SectionList),
    list_to_set(SectionList, Sections).
