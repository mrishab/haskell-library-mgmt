% ============================================================================
% PLANNING MENU
% ============================================================================

:- consult('../helper.pl').
:- consult('../prerequisite/util.pl').
:- consult('../prerequisite/print.pl').
:- consult('../corequisite/util.pl').
:- consult('../course/print.pl').

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

process_planning_choice(6) :- 
    !.  % Cut to return to main menu
process_planning_choice(_) :-
    writeln('Invalid choice.'),
    planning_menu.
