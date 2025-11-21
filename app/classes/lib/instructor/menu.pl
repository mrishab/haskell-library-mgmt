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

process_instructor_choice(6) :- 
    !.  % Cut to return to main menu
process_instructor_choice(_) :-
    writeln('Invalid choice.'),
    instructor_menu.
