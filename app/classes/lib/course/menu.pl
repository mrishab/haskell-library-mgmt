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
    !,
    write('Enter faculty code (e.g., comp, bio, agri): '),
    read(Faculty),
    (   courses_in_faculty(Faculty, Courses)
    ->  (   writeln(''),
            format('Courses in ~w:~n', [Faculty]),
            print_course_list(Courses),
            writeln('')
        )
    ;   (   writeln(''),
            format('No courses found for faculty: ~w~n', [Faculty]),
            writeln('')
        )
    ),
    course_menu.

process_course_choice(2) :-
    !,
    write('Enter credit value (e.g., 3.0, 4.0): '),
    read(Credits),
    courses_with_credits(Credits, Courses),
    list_length(Courses, Count),
    writeln(''),
    format('Found ~w courses with ~w credits:~n', [Count, Credits]),
    print_course_list_with_faculty(Courses),
    writeln(''),
    course_menu.

process_course_choice(3) :-
    !,
    write('Enter course level (0-4): '),
    read(Level),
    courses_at_level(Level, Courses),
    list_length(Courses, Count),
    writeln(''),
    format('Found ~w level-~w courses:~n', [Count, Level]),
    print_course_list_with_faculty(Courses),
    writeln(''),
    course_menu.

process_course_choice(4) :-
    !,
    write('Enter faculty code: '),
    read(Faculty),
    write('Enter course number: '),
    read(Number),
    writeln(''),
    course_offering_report(Faculty, Number),
    writeln(''),
    course_menu.

process_course_choice(5) :-
    !,
    popular_courses(Courses),
    writeln(''),
    writeln('Popular courses (multiple sections):'),
    print_popular_courses(Courses),
    writeln(''),
    course_menu.

process_course_choice(6) :- 
    !.  % Cut to return to main menu
process_course_choice(_) :-
    writeln('Invalid choice.'),
    course_menu.
