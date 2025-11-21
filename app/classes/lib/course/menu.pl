% ============================================================================
% COURSE INFORMATION MENU
% ============================================================================

:- consult('../helper.pl').
:- consult('util.pl').
:- consult('queries.pl').
:- consult('print.pl').

course_menu :-
    writeln(''),
    writeln('=== COURSE INFORMATION QUERIES ==='),
    writeln(''),
    writeln('  1. List all COMP courses'),
    writeln('  2. List all BIO courses'),
    writeln('  3. Find 3-credit courses'),
    writeln('  4. Find level 1 courses'),
    writeln('  5. Show COMP 150 details'),
    writeln('  6. Show popular courses (multiple sections)'),
    writeln('  7. Back to main menu'),
    writeln(''),
    write('Enter your choice: '),
    read(Choice),
    process_course_choice(Choice).

process_course_choice(1) :-
    !,
    courses_in_faculty(comp, Courses),
    writeln(''),
    writeln('Courses in COMP:'),
    print_course_list(Courses),
    writeln(''),
    course_menu.

process_course_choice(2) :-
    !,
    courses_in_faculty(bio, Courses),
    writeln(''),
    writeln('Courses in BIO:'),
    print_course_list(Courses),
    writeln(''),
    course_menu.

process_course_choice(3) :-
    !,
    courses_with_credits(3.0, Courses),
    list_length(Courses, Count),
    writeln(''),
    format('Found ~w courses with 3.0 credits:~n', [Count]),
    print_course_list_with_faculty(Courses),
    writeln(''),
    course_menu.

process_course_choice(4) :-
    !,
    courses_at_level(1, Courses),
    list_length(Courses, Count),
    writeln(''),
    format('Found ~w level-1 courses:~n', [Count]),
    print_course_list_with_faculty(Courses),
    writeln(''),
    course_menu.

process_course_choice(5) :-
    !,
    writeln(''),
    course_offering_report(comp_150),
    writeln(''),
    course_menu.

process_course_choice(6) :-
    !,
    popular_courses(Courses),
    writeln(''),
    writeln('Popular courses (multiple sections):'),
    print_popular_courses(Courses),
    writeln(''),
    course_menu.

process_course_choice(7) :- 
    !.  % Cut to return to main menu
process_course_choice(_) :-
    writeln('Invalid choice.'),
    course_menu.
