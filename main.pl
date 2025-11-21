% ============================================================================
% COMP 481 MINI PROJECT 2 - Main Entry Point
% ============================================================================
% This is the main entry point for COMP 481 Mini Project 2.
% It allows users to select which mini-application they want to run:
%   1. Classes Management System (UFV Knowledge Base)
%   2. Library Management System  
%   3. Archives Management System
% ============================================================================

% ============================================================================
% MAIN MENU
% ============================================================================

main :-
    writeln(''),
    writeln('╔════════════════════════════════════════════════════════════╗'),
    writeln('║            COMP 481 MINI PROJECT 2 - MAIN MENU            ║'),
    writeln('╚════════════════════════════════════════════════════════════╝'),
    writeln(''),
    writeln('Select a mini-application to run:'),
    writeln(''),
    writeln('  1. Classes Management System (UFV Knowledge Base)'),
    writeln('     - Course scheduling and timetable management'),
    writeln('     - Instructor assignments'),
    writeln('     - Prerequisite tracking'),
    writeln(''),
    writeln('  2. Library Management System'),
    writeln('     - Book catalog management'),
    writeln('     - Borrowing and returns'),
    writeln('     - Patron management'),
    writeln(''),
    writeln('  3. Archives Management System'),
    writeln('     - Archival collections management'),
    writeln('     - Thesaurus and controlled vocabulary'),
    writeln('     - Subject and location indexing'),
    writeln(''),
    writeln('  4. Exit'),
    writeln(''),
    write('Enter your choice (1-4): '),
    flush_output,
    read_line_to_string(user_input, Input),
    process_choice(Input).

% ============================================================================
% CHOICE PROCESSING
% ============================================================================

process_choice("1") :-
    !,
    writeln(''),
    writeln('Launching Classes Management System...'),
    writeln(''),
    run_classes_app,
    prompt_return_to_menu.

process_choice("2") :-
    !,
    writeln(''),
    writeln('Launching Library Management System...'),
    writeln(''),
    run_library_app,
    prompt_return_to_menu.

process_choice("3") :-
    !,
    writeln(''),
    writeln('Launching Archives Management System...'),
    writeln(''),
    run_archives_app,
    prompt_return_to_menu.

process_choice("4") :-
    !,
    writeln(''),
    writeln('Thank you for using COMP 481 Mini Project 2!'),
    writeln('Goodbye!'),
    writeln('').

process_choice(_) :-
    writeln(''),
    writeln('Invalid choice. Please enter a number between 1 and 4.'),
    writeln(''),
    main.

% ============================================================================
% APPLICATION LAUNCHERS
% ============================================================================

run_classes_app :-
    catch(
        (
            unload_file('app/classes/demo.pl'),
            consult('app/classes/demo.pl'),
            writeln('Classes application loaded successfully.'),
            writeln(''),
            classes_main
        ),
        Error,
        (
            writeln(''),
            writeln('ERROR: Failed to load Classes Management System.'),
            format('Details: ~w~n', [Error]),
            writeln('Please ensure the application files exist in app/classes/')
        )
    ).

run_library_app :-
    catch(
        (
            consult('app/library/demo.pl'),
            writeln('Library application loaded successfully.'),
            writeln(''),
            library_main
        ),
        Error,
        (
            writeln(''),
            writeln('ERROR: Failed to load Library Management System.'),
            format('Details: ~w~n', [Error]),
            writeln('Please ensure the application files exist in app/library/')
        )
    ).

run_archives_app :-
    catch(
        (
            consult('app/archives/demo.pl'),
            writeln('Archives application loaded successfully.'),
            writeln(''),
            archives_main
        ),
        Error,
        (
            writeln(''),
            writeln('ERROR: Failed to load Archives Management System.'),
            format('Details: ~w~n', [Error]),
            writeln('Please ensure the application files exist in app/archives/')
        )
    ).

% ============================================================================
% UTILITY FUNCTIONS
% ============================================================================

prompt_return_to_menu :-
    writeln(''),
    writeln('─────────────────────────────────────────────────────────────'),
    write('Press Enter to return to main menu...'),
    flush_output,
    read_line_to_string(user_input, _),
    writeln(''),
    main.

% ============================================================================
% STARTUP
% ============================================================================

% Display welcome message on startup
:- initialization(
    (
        writeln(''),
        writeln('Welcome to COMP 481 Mini Project 2!'),
        writeln('Type "main." to start the application.')
    )
).
