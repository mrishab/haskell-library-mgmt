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
    writeln('  1. Show direct prerequisites for COMP 230'),
    writeln('  2. Show all prerequisites for COMP 230 (recursive)'),
    writeln('  3. Show entry-level COMP courses'),
    writeln('  4. Check eligibility for COMP 230 (with COMP 150 completed)'),
    writeln('  5. Show corequisites for COMP 230'),
    writeln('  6. Back to main menu'),
    writeln(''),
    write('Enter your choice: '),
    read(Choice),
    process_planning_choice(Choice).

process_planning_choice(1) :-
    !,
    direct_prerequisites(comp_230, Prereqs),
    writeln(''),
    writeln('Direct prerequisites for COMP 230:'),
    print_prereq_list(Prereqs),
    writeln(''),
    planning_menu.

process_planning_choice(2) :-
    !,
    all_prerequisites(comp_230, AllPrereqs),
    writeln(''),
    writeln('All prerequisites for COMP 230 (recursive):'),
    print_prereq_list(AllPrereqs),
    writeln(''),
    planning_menu.

process_planning_choice(3) :-
    !,
    entry_level_courses_in_faculty(comp, Courses),
    writeln(''),
    writeln('Entry-level COMP courses (no prerequisites):'),
    print_prereq_list(Courses),
    writeln(''),
    planning_menu.

process_planning_choice(4) :-
    !,
    writeln(''),
    (can_take_course(comp_230, [comp_150]) ->
        writeln('✓ Eligible to take COMP 230 with COMP 150 completed') ;
        writeln('✗ Not eligible to take COMP 230 (missing prerequisites)')),
    writeln(''),
    planning_menu.

process_planning_choice(5) :-
    !,
    find_corequisites(comp_230, Coreqs),
    writeln(''),
    writeln('Corequisites for COMP 230:'),
    print_prereq_list(Coreqs),
    writeln(''),
    planning_menu.

process_planning_choice(6) :- 
    !.  % Cut to return to main menu
process_planning_choice(_) :-
    writeln('Invalid choice.'),
    planning_menu.
