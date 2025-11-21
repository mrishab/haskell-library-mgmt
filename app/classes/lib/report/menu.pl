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
    writeln('  1. Show COMP 150 offering report'),
    writeln('  2. Show Farshad Eshghi schedule report'),
    writeln('  3. Show campus statistics'),
    writeln('  4. Show COMP faculty statistics'),
    writeln('  5. Back to main menu'),
    writeln(''),
    write('Enter your choice: '),
    read(Choice),
    process_report_choice(Choice).

process_report_choice(1) :-
    !,
    writeln(''),
    course_offering_report(comp_150),
    writeln(''),
    report_menu.

process_report_choice(2) :-
    !,
    writeln(''),
    instructor_schedule(inst_eshghi),
    writeln(''),
    report_menu.

process_report_choice(3) :-
    !,
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
    writeln(''),
    report_menu.

process_report_choice(4) :-
    !,
    writeln(''),
    writeln('=== COMP FACULTY STATISTICS ==='),
    courses_in_faculty(comp, Courses),
    list_length(Courses, CourseCount),
    format('Total courses: ~w~n', [CourseCount]),
    findall(CRN, (class_section(_, CRN, CourseAtom, _, _, _, _, _, _, _),
                  course(CourseAtom, comp, _, _, _, _)), Sections),
    list_length(Sections, SectionCount),
    format('Total sections: ~w~n', [SectionCount]),
    writeln(''),
    report_menu.

process_report_choice(5) :- 
    !.  % Cut to return to main menu
process_report_choice(_) :-
    writeln('Invalid choice.'),
    report_menu.