% ============================================================================
% REPORT MENU
% ============================================================================

:- consult('../helper.pl').
:- consult('../course/queries.pl').
:- consult('../instructor/queries.pl').
:- consult('../section/queries.pl').

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

process_report_choice(5) :- 
    !.  % Cut to return to main menu
process_report_choice(_) :-
    writeln('Invalid choice.'),
    report_menu.