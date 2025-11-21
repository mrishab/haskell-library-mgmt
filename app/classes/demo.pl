% ============================================================================
% UFV Course Management System - Main Application Interface
% ============================================================================
% This is the main entry point for the UFV timetable query system.
% ============================================================================

:- consult('lib/kb.pl').
:- consult('lib/util.pl').
:- consult('lib/queries.pl').
:- consult('lib/helper.pl').
:- consult('lib/course/print.pl').
:- consult('lib/section/print.pl').
:- consult('lib/instructor/print.pl').
:- consult('lib/prerequisite/print.pl').
:- consult('lib/course/menu.pl').
:- consult('lib/instructor/menu.pl').
:- consult('lib/schedule/menu.pl').
:- consult('lib/room/menu.pl').
:- consult('lib/planning/menu.pl').
:- consult('lib/report/menu.pl').
:- consult('lib/test/menu.pl').

% ============================================================================
% MAIN MENU SYSTEM
% ============================================================================

classes_main :-
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

process_main_choice(1) :- !, course_menu, show_main_menu.
process_main_choice(2) :- !, instructor_menu, show_main_menu.
process_main_choice(3) :- !, schedule_menu, show_main_menu.
process_main_choice(4) :- !, room_menu, show_main_menu.
process_main_choice(5) :- !, planning_menu, show_main_menu.
process_main_choice(6) :- !, report_menu, show_main_menu.
process_main_choice(7) :- !, run_tests, show_main_menu.
process_main_choice(8) :- 
    writeln(''),
    writeln('Returning to main menu...'),
    writeln('').
process_main_choice(_) :-
    !,
    writeln('Invalid choice. Please try again.'),
    show_main_menu.

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
:- writeln('Type "classes_main." or "main." to start, "help." for guidance.').
