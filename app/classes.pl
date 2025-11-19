% ============================================================================
% UFV Course Management System - Main Application Interface
% ============================================================================
% This is the main entry point for the UFV timetable query system.
% It provides a user-friendly interface for querying course information.
% ============================================================================

:- consult('../src/classes/queries/queries.pl').

% ============================================================================
% MAIN MENU SYSTEM
% ============================================================================

main :-
    writeln(''),
    writeln('╔════════════════════════════════════════════════════════════╗'),
    writeln('║      UFV COURSE MANAGEMENT SYSTEM - MAIN APPLICATION       ║'),
    writeln('╚════════════════════════════════════════════════════════════╝'),
    writeln(''),
    show_main_menu.

show_main_menu :-
    writeln('Please select an option:'),
    writeln(''),
    writeln('  1. Course Information Queries'),
    writeln('  2. Instructor Queries'),
    writeln('  3. Schedule and Section Queries'),
    writeln('  4. Room and Facility Queries'),
    writeln('  5. Prerequisite and Course Planning'),
    writeln('  6. Generate Reports'),
    writeln('  7. Run System Tests'),
    writeln('  8. Exit'),
    writeln(''),
    write('Enter your choice (1-8): '),
    read(Choice),
    process_main_choice(Choice).

process_main_choice(1) :- course_menu.
process_main_choice(2) :- instructor_menu.
process_main_choice(3) :- schedule_menu.
process_main_choice(4) :- room_menu.
process_main_choice(5) :- planning_menu.
process_main_choice(6) :- report_menu.
process_main_choice(7) :- run_tests, show_main_menu.
process_main_choice(8) :- 
    writeln('Thank you for using the UFV Course Management System!'),
    halt.
process_main_choice(_) :-
    writeln('Invalid choice. Please try again.'),
    show_main_menu.

% ============================================================================
% COURSE INFORMATION MENU
% ============================================================================

course_menu :-
    writeln(''),
    writeln('=== COURSE INFORMATION QUERIES ==='),
    writeln(''),
    writeln('  1. List all courses in a faculty'),
    writeln('  2. Find courses by credit value'),
    writeln('  3. Find courses at a specific level'),
    writeln('  4. Get detailed course information'),
    writeln('  5. Find popular courses (multiple sections)'),
    writeln('  6. Back to main menu'),
    writeln(''),
    write('Enter your choice: '),
    read(Choice),
    process_course_choice(Choice).

process_course_choice(1) :-
    write('Enter faculty code (e.g., comp, bio, agri): '),
    read(Faculty),
    courses_in_faculty(Faculty, Courses),
    writeln(''),
    format('Courses in ~w:~n', [Faculty]),
    print_course_list(Courses),
    course_menu.

process_course_choice(2) :-
    write('Enter credit value (e.g., 3.0, 4.0): '),
    read(Credits),
    courses_with_credits(Credits, Courses),
    list_length(Courses, Count),
    writeln(''),
    format('Found ~w courses with ~w credits:~n', [Count, Credits]),
    print_course_list_with_faculty(Courses),
    course_menu.

process_course_choice(3) :-
    write('Enter course level (0-4): '),
    read(Level),
    courses_at_level(Level, Courses),
    list_length(Courses, Count),
    writeln(''),
    format('Found ~w level-~w courses:~n', [Count, Level]),
    print_course_list_with_faculty(Courses),
    course_menu.

process_course_choice(4) :-
    write('Enter faculty code: '),
    read(Faculty),
    write('Enter course number: '),
    read(Number),
    writeln(''),
    course_offering_report(Faculty, Number),
    course_menu.

process_course_choice(5) :-
    popular_courses(Courses),
    writeln(''),
    writeln('Popular courses (multiple sections):'),
    print_popular_courses(Courses),
    course_menu.

process_course_choice(6) :- show_main_menu.
process_course_choice(_) :-
    writeln('Invalid choice.'),
    course_menu.

% ============================================================================
% INSTRUCTOR MENU
% ============================================================================

instructor_menu :-
    writeln(''),
    writeln('=== INSTRUCTOR QUERIES ==='),
    writeln(''),
    writeln('  1. Find courses by instructor'),
    writeln('  2. Get instructor workload'),
    writeln('  3. Find instructors for a course'),
    writeln('  4. Generate instructor schedule'),
    writeln('  5. Find team-taught sections'),
    writeln('  6. Back to main menu'),
    writeln(''),
    write('Enter your choice: '),
    read(Choice),
    process_instructor_choice(Choice).

process_instructor_choice(1) :-
    write('Enter instructor name (in quotes): '),
    read(Instructor),
    courses_by_instructor(Instructor, Courses),
    writeln(''),
    format('Courses taught by ~w:~n', [Instructor]),
    print_instructor_course_list(Courses),
    instructor_menu.

process_instructor_choice(2) :-
    write('Enter instructor name (in quotes): '),
    read(Instructor),
    instructor_load(Instructor, Load),
    writeln(''),
    format('~w teaches ~w sections~n', [Instructor, Load]),
    instructor_menu.

process_instructor_choice(3) :-
    write('Enter faculty code: '),
    read(Faculty),
    write('Enter course number: '),
    read(Number),
    instructors_for_course(Faculty, Number, Instructors),
    writeln(''),
    format('Instructors for ~w ~w:~n', [Faculty, Number]),
    print_list(Instructors),
    instructor_menu.

process_instructor_choice(4) :-
    write('Enter instructor name (in quotes): '),
    read(Instructor),
    writeln(''),
    instructor_schedule(Instructor),
    instructor_menu.

process_instructor_choice(5) :-
    team_taught_sections(Sections),
    writeln(''),
    writeln('Team-taught sections:'),
    print_team_taught(Sections),
    instructor_menu.

process_instructor_choice(6) :- show_main_menu.
process_instructor_choice(_) :-
    writeln('Invalid choice.'),
    instructor_menu.

% ============================================================================
% SCHEDULE MENU
% ============================================================================

schedule_menu :-
    writeln(''),
    writeln('=== SCHEDULE AND SECTION QUERIES ==='),
    writeln(''),
    writeln('  1. Find sections for a course'),
    writeln('  2. Find sections on a specific campus'),
    writeln('  3. Find sections on a specific day'),
    writeln('  4. Check if sections conflict'),
    writeln('  5. Find online sections'),
    writeln('  6. Find hybrid/blended sections'),
    writeln('  7. Get course total capacity'),
    writeln('  8. Back to main menu'),
    writeln(''),
    write('Enter your choice: '),
    read(Choice),
    process_schedule_choice(Choice).

process_schedule_choice(1) :-
    write('Enter faculty code: '),
    read(Faculty),
    write('Enter course number: '),
    read(Number),
    course_sections(Faculty, Number, Sections),
    writeln(''),
    format('Sections for ~w ~w:~n', [Faculty, Number]),
    print_section_list(Sections),
    schedule_menu.

process_schedule_choice(2) :-
    write('Enter campus code (ab, ch, ho, on): '),
    read(Campus),
    sections_on_campus(Campus, Sections),
    list_length(Sections, Count),
    writeln(''),
    format('Found ~w sections on ~w campus~n', [Count, Campus]),
    schedule_menu.

process_schedule_choice(3) :-
    write('Enter day (monday, tuesday, wednesday, thursday, friday): '),
    read(Day),
    sections_on_day(Day, Sections),
    list_length(Sections, Count),
    writeln(''),
    format('Found ~w sections on ~w~n', [Count, Day]),
    print_day_sections(Sections),
    schedule_menu.

process_schedule_choice(4) :-
    write('Enter first CRN: '),
    read(CRN1),
    write('Enter second CRN: '),
    read(CRN2),
    writeln(''),
    (time_conflict(CRN1, CRN2) ->
        format('CRN ~w and ~w have TIME CONFLICTS~n', [CRN1, CRN2]) ;
        format('CRN ~w and ~w are COMPATIBLE~n', [CRN1, CRN2])),
    schedule_menu.

process_schedule_choice(5) :-
    findall(CRN, is_online_section(CRN), OnlineCRNs),
    list_length(OnlineCRNs, Count),
    writeln(''),
    format('Found ~w online sections: ~w~n', [Count, OnlineCRNs]),
    schedule_menu.

process_schedule_choice(6) :-
    findall(CRN, is_hybrid_section(CRN), HybridCRNs),
    list_length(HybridCRNs, Count),
    writeln(''),
    format('Found ~w hybrid sections: ~w~n', [Count, HybridCRNs]),
    schedule_menu.

process_schedule_choice(7) :-
    write('Enter faculty code: '),
    read(Faculty),
    write('Enter course number: '),
    read(Number),
    total_course_capacity(Faculty, Number, Capacity),
    writeln(''),
    format('Total capacity for ~w ~w: ~w students~n', [Faculty, Number, Capacity]),
    schedule_menu.

process_schedule_choice(8) :- show_main_menu.
process_schedule_choice(_) :-
    writeln('Invalid choice.'),
    schedule_menu.

% ============================================================================
% ROOM MENU
% ============================================================================

room_menu :-
    writeln(''),
    writeln('=== ROOM AND FACILITY QUERIES ==='),
    writeln(''),
    writeln('  1. Find rooms on a specific floor'),
    writeln('  2. Find rooms in a building'),
    writeln('  3. Find sections in a room'),
    writeln('  4. Back to main menu'),
    writeln(''),
    write('Enter your choice: '),
    read(Choice),
    process_room_choice(Choice).

process_room_choice(1) :-
    write('Enter campus code (ab, ch, ce): '),
    read(Campus),
    write('Enter floor number: '),
    read(Floor),
    rooms_on_floor(Campus, Floor, Rooms),
    writeln(''),
    format('Rooms on floor ~w at ~w campus:~n', [Floor, Campus]),
    print_list(Rooms),
    room_menu.

process_room_choice(2) :-
    write('Enter building code (e.g., ABD, ABA, CEPA): '),
    read(Building),
    rooms_in_building(Building, Rooms),
    writeln(''),
    format('Rooms in ~w:~n', [Building]),
    print_list(Rooms),
    room_menu.

process_room_choice(3) :-
    write('Enter building code: '),
    read(Building),
    write('Enter room number: '),
    read(RoomNum),
    sections_in_room(Building, RoomNum, Sections),
    list_length(Sections, Count),
    writeln(''),
    format('~w ~w hosts ~w class sessions~n', [Building, RoomNum, Count]),
    room_menu.

process_room_choice(4) :- show_main_menu.
process_room_choice(_) :-
    writeln('Invalid choice.'),
    room_menu.

% ============================================================================
% PLANNING MENU
% ============================================================================

planning_menu :-
    writeln(''),
    writeln('=== PREREQUISITE AND COURSE PLANNING ==='),
    writeln(''),
    writeln('  1. Check direct prerequisites'),
    writeln('  2. Find all prerequisites (recursive)'),
    writeln('  3. Find entry-level courses'),
    writeln('  4. Check course eligibility'),
    writeln('  5. Find corequisites'),
    writeln('  6. Back to main menu'),
    writeln(''),
    write('Enter your choice: '),
    read(Choice),
    process_planning_choice(Choice).

process_planning_choice(1) :-
    write('Enter faculty code: '),
    read(Faculty),
    write('Enter course number: '),
    read(Number),
    direct_prerequisites(Faculty, Number, Prereqs),
    writeln(''),
    format('Direct prerequisites for ~w ~w:~n', [Faculty, Number]),
    print_prereq_list(Prereqs),
    planning_menu.

process_planning_choice(2) :-
    write('Enter faculty code: '),
    read(Faculty),
    write('Enter course number: '),
    read(Number),
    all_prerequisites(Faculty, Number, AllPrereqs),
    writeln(''),
    format('All prerequisites for ~w ~w:~n', [Faculty, Number]),
    print_prereq_list(AllPrereqs),
    planning_menu.

process_planning_choice(3) :-
    write('Enter faculty code: '),
    read(Faculty),
    entry_level_courses(Faculty, Courses),
    writeln(''),
    format('Entry-level ~w courses (no prerequisites):~n', [Faculty]),
    print_course_list(Courses),
    planning_menu.

process_planning_choice(4) :-
    write('Enter faculty code for target course: '),
    read(Faculty),
    write('Enter course number for target course: '),
    read(Number),
    write('Enter list of completed courses as [[fac1,num1],[fac2,num2],...]: '),
    read(Completed),
    writeln(''),
    (can_take_course(Faculty, Number, Completed) ->
        format('✓ Eligible to take ~w ~w~n', [Faculty, Number]) ;
        format('✗ Not eligible to take ~w ~w (missing prerequisites)~n', [Faculty, Number])),
    planning_menu.

process_planning_choice(5) :-
    write('Enter faculty code: '),
    read(Faculty),
    write('Enter course number: '),
    read(Number),
    find_corequisites(Faculty, Number, Coreqs),
    writeln(''),
    format('Corequisites for ~w ~w:~n', [Faculty, Number]),
    print_prereq_list(Coreqs),
    planning_menu.

process_planning_choice(6) :- show_main_menu.
process_planning_choice(_) :-
    writeln('Invalid choice.'),
    planning_menu.

% ============================================================================
% REPORT MENU
% ============================================================================

report_menu :-
    writeln(''),
    writeln('=== GENERATE REPORTS ==='),
    writeln(''),
    writeln('  1. Course offering report'),
    writeln('  2. Instructor schedule report'),
    writeln('  3. Campus statistics'),
    writeln('  4. Faculty statistics'),
    writeln('  5. Back to main menu'),
    writeln(''),
    write('Enter your choice: '),
    read(Choice),
    process_report_choice(Choice).

process_report_choice(1) :-
    write('Enter faculty code: '),
    read(Faculty),
    write('Enter course number: '),
    read(Number),
    writeln(''),
    course_offering_report(Faculty, Number),
    report_menu.

process_report_choice(2) :-
    write('Enter instructor name (in quotes): '),
    read(Instructor),
    writeln(''),
    instructor_schedule(Instructor),
    report_menu.

process_report_choice(3) :-
    writeln(''),
    writeln('=== CAMPUS STATISTICS ==='),
    sections_on_campus(ab, AbSections),
    list_length(AbSections, AbCount),
    sections_on_campus(ch, ChSections),
    list_length(ChSections, ChCount),
    sections_on_campus(on, OnSections),
    list_length(OnSections, OnCount),
    format('Abbotsford campus: ~w sections~n', [AbCount]),
    format('Chilliwack campus: ~w sections~n', [ChCount]),
    format('Online: ~w sections~n', [OnCount]),
    report_menu.

process_report_choice(4) :-
    write('Enter faculty code: '),
    read(Faculty),
    writeln(''),
    format('=== ~w FACULTY STATISTICS ===~n', [Faculty]),
    courses_in_faculty(Faculty, Courses),
    list_length(Courses, CourseCount),
    format('Total courses: ~w~n', [CourseCount]),
    findall(CRN, class_section(CRN, Faculty, _, _, _, _, _, _, _), Sections),
    list_length(Sections, SectionCount),
    format('Total sections: ~w~n', [SectionCount]),
    report_menu.

process_report_choice(5) :- show_main_menu.
process_report_choice(_) :-
    writeln('Invalid choice.'),
    report_menu.

% ============================================================================
% RUN TESTS
% ============================================================================

run_tests :-
    writeln(''),
    writeln('Running system tests...'),
    writeln(''),
    consult('../test/classes/test.pl'),
    run_all_tests.

% ============================================================================
% HELPER PRINTING FUNCTIONS
% ============================================================================

print_list([]).
print_list([H|T]) :-
    format('  - ~w~n', [H]),
    print_list(T).

print_course_list([]).
print_course_list([[Number, Name, Credits]|Rest]) :-
    format('  ~w - ~w (~w credits)~n', [Number, Name, Credits]),
    print_course_list(Rest).

print_course_list_with_faculty([]).
print_course_list_with_faculty([[Faculty, Number, Name]|Rest]) :-
    format('  ~w ~w - ~w~n', [Faculty, Number, Name]),
    print_course_list_with_faculty(Rest).

print_section_list([]).
print_section_list([[CRN, Section, Instructor, Campus]|Rest]) :-
    format('  CRN: ~w, Section: ~w, Instructor: ~w, Campus: ~w~n', 
           [CRN, Section, Instructor, Campus]),
    print_section_list(Rest).

print_instructor_course_list([]).
print_instructor_course_list([[Faculty, Number, Section]|Rest]) :-
    format('  ~w ~w (Section ~w)~n', [Faculty, Number, Section]),
    print_instructor_course_list(Rest).

print_prereq_list([]) :-
    writeln('  None').
print_prereq_list([[Faculty, Number]|Rest]) :-
    format('  ~w ~w~n', [Faculty, Number]),
    print_prereq_list(Rest).

print_popular_courses([]).
print_popular_courses([[Faculty, Number, Count]|Rest]) :-
    format('  ~w ~w: ~w sections~n', [Faculty, Number, Count]),
    print_popular_courses(Rest).

print_team_taught([]).
print_team_taught([[CRN, Faculty, Number, Instructor]|Rest]) :-
    format('  CRN ~w: ~w ~w taught by ~w~n', [CRN, Faculty, Number, Instructor]),
    print_team_taught(Rest).

print_day_sections([]).
print_day_sections([[CRN, Faculty, Number, Start, End]|Rest]) :-
    format('  CRN ~w: ~w ~w (~w-~w)~n', [CRN, Faculty, Number, Start, End]),
    print_day_sections(Rest).

% ============================================================================
% QUICK START GUIDE
% ============================================================================

help :-
    writeln(''),
    writeln('╔════════════════════════════════════════════════════════════╗'),
    writeln('║         UFV COURSE MANAGEMENT SYSTEM - HELP GUIDE          ║'),
    writeln('╚════════════════════════════════════════════════════════════╝'),
    writeln(''),
    writeln('QUICK START:'),
    writeln('  Type "main." to start the application'),
    writeln('  Type "demo." to see example queries'),
    writeln('  Type "run_all_tests." to run comprehensive tests'),
    writeln(''),
    writeln('EXAMPLE QUERIES:'),
    writeln('  courses_in_faculty(comp, Courses).'),
    writeln('  course_sections(comp, 150, Sections).'),
    writeln('  instructor_schedule(\'Farshad Eshghi\').'),
    writeln('  sections_on_day(tuesday, Sections).'),
    writeln('  all_prerequisites(comp, 230, Prereqs).'),
    writeln(''),
    writeln('For more examples, see test/classes/test.pl'),
    writeln('').

% ============================================================================
% INITIALIZATION
% ============================================================================

:- writeln('UFV Course Management System loaded successfully!').
:- writeln('Type "main." to start, "help." for guidance, or "demo." for examples.').
