% ============================================================================
% INSTRUCTOR MENU
% ============================================================================

:- consult('../helper.pl').
:- consult('util.pl').
:- consult('queries.pl').
:- consult('print.pl').

instructor_menu :-
    writeln(''),
    writeln('=== INSTRUCTOR QUERIES ==='),
    writeln(''),
    writeln('  1. Show courses taught by Farshad Eshghi'),
    writeln('  2. Show Jason Harrison\'s workload'),
    writeln('  3. Show instructors for COMP 150'),
    writeln('  4. Show Farshad Eshghi\'s schedule'),
    writeln('  5. Show team-taught sections'),
    writeln('  6. Back to main menu'),
    writeln(''),
    write('Enter your choice: '),
    read(Choice),
    process_instructor_choice(Choice).

process_instructor_choice(1) :-
    !,
    courses_by_instructor(inst_eshghi, Courses),
    writeln(''),
    writeln('Courses taught by Farshad Eshghi:'),
    print_instructor_course_list(Courses),
    writeln(''),
    instructor_menu.

process_instructor_choice(2) :-
    !,
    instructor_load(inst_harrison, Load),
    writeln(''),
    format('Jason Harrison teaches ~w sections~n', [Load]),
    writeln(''),
    instructor_menu.

process_instructor_choice(3) :-
    !,
    instructors_for_course(comp_150, Instructors),
    writeln(''),
    writeln('Instructors for COMP 150:'),
    print_simple_list(Instructors),
    writeln(''),
    instructor_menu.

process_instructor_choice(4) :-
    !,
    writeln(''),
    instructor_schedule(inst_eshghi),
    writeln(''),
    instructor_menu.

process_instructor_choice(5) :-
    !,
    team_taught_sections(Sections),
    writeln(''),
    writeln('Team-taught sections:'),
    print_team_taught(Sections),
    writeln(''),
    instructor_menu.

process_instructor_choice(6) :- 
    !.  % Cut to return to main menu
process_instructor_choice(_) :-
    writeln('Invalid choice.'),
    instructor_menu.
