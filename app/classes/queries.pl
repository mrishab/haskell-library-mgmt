% ============================================================================
% ADVANCED QUERIES AND PLANNING
% ============================================================================
% This file contains advanced queries that build on the knowledge base and
% utility predicates to provide higher-level reasoning capabilities.
% ============================================================================

:- consult('lib/kb.pl').
:- consult('lib/helper.pl').
:- consult('lib/util.pl').

% ============================================================================
% SCHEDULING AND COMPATIBILITY
% ============================================================================

% Find all sections compatible with a given section (no time conflicts)
compatible_sections(CRN, CompatibleSections) :-
    findall(OtherCRN,
            (class_section(_, OtherCRN, _, _, _, _, _, _, _, _),
             \+ schedules_conflict(CRN, OtherCRN)),
            CompatibleSections).

% Build a schedule of compatible courses
build_schedule(DesiredCourses, Schedule) :-
    findall([CourseAtom, CRN, Section],
            (member(CourseAtom, DesiredCourses),
             class_section(_, CRN, CourseAtom, Section, _, _, _, _, _, _)),
            AllOptions),
    select_compatible_schedule(AllOptions, [], Schedule).

select_compatible_schedule([], Selected, Selected).
select_compatible_schedule([Option|Rest], Selected, Schedule) :-
    Option = [CourseAtom, CRN, _],
    \+ member_course(CourseAtom, Selected),
    \+ has_conflict_with_selected(CRN, Selected),
    select_compatible_schedule(Rest, [Option|Selected], Schedule).
select_compatible_schedule([_|Rest], Selected, Schedule) :-
    select_compatible_schedule(Rest, Selected, Schedule).

member_course(CourseAtom, [[CourseAtom, _, _]|_]).
member_course(CourseAtom, [_|Rest]) :- member_course(CourseAtom, Rest).

has_conflict_with_selected(_, []).
has_conflict_with_selected(CRN, [[_, SelectedCRN, _]|_]) :-
    schedules_conflict(CRN, SelectedCRN), !.
has_conflict_with_selected(CRN, [_|Rest]) :-
    has_conflict_with_selected(CRN, Rest).

% Find team-taught sections
team_taught_sections(TeamSections) :-
    findall([CRN, CourseAtom, InstructorList],
            (class_section(_, CRN, CourseAtom, _, InstructorList, _, _, _, _, _),
             is_list(InstructorList)),
            TeamSections).

% Find most popular courses (most sections offered)
popular_courses(PopularCourses) :-
    findall([CourseAtom, Count],
            (course(CourseAtom, _, _, _, _, _),
             findall(CRN, class_section(_, CRN, CourseAtom, _, _, _, _, _, _, _), Sections),
             list_length(Sections, Count),
             Count > 1),
            CoursesWithCounts),
    sort(2, @>=, CoursesWithCounts, PopularCourses).

% Get total capacity for a course across all sections
total_course_capacity(CourseAtom, TotalCapacity) :-
    findall(Max, class_section(_, _, CourseAtom, _, _, _, _, Max, _, _), Capacities),
    sum_list(Capacities, TotalCapacity).

sum_list([], 0).
sum_list([H|T], Sum) :- sum_list(T, RestSum), Sum is H + RestSum.

% ============================================================================
% REPORTING QUERIES
% ============================================================================

% Generate course offering report
course_offering_report(CourseAtom, Report) :-
    course(CourseAtom, _, _, Name, Credits, Description),
    course_display_code(CourseAtom, DisplayCode),
    findall([CRN, Section, InstructorID, Campus, Method],
            class_section(_, CRN, CourseAtom, Section, InstructorID, 
                         Campus, Method, _, _, _),
            Sections),
    list_length(Sections, SectionCount),
    Report = [
        code-DisplayCode,
        name-Name,
        credits-Credits,
        description-Description,
        section_count-SectionCount,
        sections-Sections
    ].

% Generate instructor schedule report
instructor_schedule(InstructorID, Schedule) :-
    instructor_full_name(InstructorID, FullName),
    findall([CRN, CourseAtom, Section, Day, TimeAtom, RoomAtom],
            (class_section(_, CRN, CourseAtom, Section, InstructorID, _, _, _, _, _),
             schedule(CRN, Day, TimeAtom, RoomAtom, _)),
            ScheduleEntries),
    Schedule = [instructor-FullName, schedule-ScheduleEntries].

% ============================================================================
% CONSTRAINT SATISFACTION
% ============================================================================

% Assign instructors to sections with load balancing
assign_instructors(SectionCRNs, InstructorIDs, MaxLoad, Assignment) :-
    assign_instructors_helper(SectionCRNs, InstructorIDs, MaxLoad, [], Assignment).

assign_instructors_helper([], _, _, Assignment, Assignment).
assign_instructors_helper([CRN|RestCRNs], InstructorIDs, MaxLoad, CurrentAssignment, FinalAssignment) :-
    member(InstructorID, InstructorIDs),
    count_assignments(InstructorID, CurrentAssignment, Count),
    Count < MaxLoad,
    assign_instructors_helper(RestCRNs, InstructorIDs, MaxLoad, 
                              [[CRN, InstructorID]|CurrentAssignment], 
                              FinalAssignment).

count_assignments(_, [], 0).
count_assignments(InstructorID, [[_, InstructorID]|Rest], Count) :-
    count_assignments(InstructorID, Rest, RestCount),
    Count is RestCount + 1.
count_assignments(InstructorID, [[_, OtherID]|Rest], Count) :-
    InstructorID \= OtherID,
    count_assignments(InstructorID, Rest, Count).
