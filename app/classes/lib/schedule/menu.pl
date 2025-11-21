% ============================================================================
% SCHEDULE MENU
% ============================================================================

:- consult('../helper.pl').
:- consult('util.pl').
:- consult('../section/queries.pl').
:- consult('../section/print.pl').
:- consult('../time/util.pl').

schedule_menu :-
    writeln(''),
    writeln('=== SCHEDULE AND SECTION QUERIES ==='),
    writeln(''),
    writeln('  1. Show sections for COMP 150'),
    writeln('  2. Show sections on Abbotsford campus'),
    writeln('  3. Show sections on Tuesday'),
    writeln('  4. Check conflict between CRN 30101 and 30102'),
    writeln('  5. Find online sections'),
    writeln('  6. Find hybrid/blended sections'),
    writeln('  7. Show total capacity for COMP 150'),
    writeln('  8. Back to main menu'),
    writeln(''),
    write('Enter your choice: '),
    read(Choice),
    process_schedule_choice(Choice).

process_schedule_choice(1) :-
    !,
    course_sections(comp_150, Sections),
    writeln(''),
    writeln('Sections for COMP 150:'),
    print_section_list(Sections),
    writeln(''),
    schedule_menu.

process_schedule_choice(2) :-
    !,
    sections_on_campus(ab, Sections),
    list_length(Sections, Count),
    writeln(''),
    format('Found ~w sections on Abbotsford campus~n', [Count]),
    writeln(''),
    schedule_menu.

process_schedule_choice(3) :-
    !,
    sections_on_day(tuesday, Sections),
    list_length(Sections, Count),
    writeln(''),
    format('Found ~w sections on Tuesday~n', [Count]),
    print_day_sections(Sections),
    writeln(''),
    schedule_menu.

process_schedule_choice(4) :-
    !,
    writeln(''),
    (time_conflict(30101, 30102) ->
        writeln('CRN 30101 and 30102 have TIME CONFLICTS') ;
        writeln('CRN 30101 and 30102 are COMPATIBLE')),
    writeln(''),
    schedule_menu.

process_schedule_choice(5) :-
    !,
    findall(CRN, is_online_section(CRN), OnlineCRNs),
    list_length(OnlineCRNs, Count),
    writeln(''),
    format('Found ~w online sections: ~w~n', [Count, OnlineCRNs]),
    writeln(''),
    schedule_menu.

process_schedule_choice(6) :-
    !,
    findall(CRN, is_hybrid_section(CRN), HybridCRNs),
    list_length(HybridCRNs, Count),
    writeln(''),
    format('Found ~w hybrid sections: ~w~n', [Count, HybridCRNs]),
    writeln(''),
    schedule_menu.

process_schedule_choice(7) :-
    !,
    total_course_capacity(comp_150, Capacity),
    writeln(''),
    format('Total capacity for COMP 150: ~w students~n', [Capacity]),
    writeln(''),
    schedule_menu.

process_schedule_choice(8) :- 
    !.  % Cut to return to main menu
process_schedule_choice(_) :-
    writeln('Invalid choice.'),
    schedule_menu.