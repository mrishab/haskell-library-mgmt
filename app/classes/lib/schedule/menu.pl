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
    writeln('  1. Find sections for a course'),
    writeln('  2. Find sections on a specific campus'),
    writeln('  3. Find sections on a specific day'),
    writeln('  4. Check if sections conflict'),
    writeln('  5. Find online sections'),
    writeln('  6. Find hybrid/blended sections'),
    writeln('  7. Get course total capacity'),
    writeln('  8. Back to main menu'),
    writeln(''),
    write('Enter your choice: '),
    read(Choice),
    process_schedule_choice(Choice).

process_schedule_choice(1) :-
    write('Enter faculty code: '),
    read(Faculty),
    write('Enter course number: '),
    read(Number),
    course_sections(Faculty, Number, Sections),
    writeln(''),
    format('Sections for ~w ~w:~n', [Faculty, Number]),
    print_section_list(Sections),
    schedule_menu.

process_schedule_choice(2) :-
    write('Enter campus code (ab, ch, ho, on): '),
    read(Campus),
    sections_on_campus(Campus, Sections),
    list_length(Sections, Count),
    writeln(''),
    format('Found ~w sections on ~w campus~n', [Count, Campus]),
    schedule_menu.

process_schedule_choice(3) :-
    write('Enter day (monday, tuesday, wednesday, thursday, friday): '),
    read(Day),
    sections_on_day(Day, Sections),
    list_length(Sections, Count),
    writeln(''),
    format('Found ~w sections on ~w~n', [Count, Day]),
    print_day_sections(Sections),
    schedule_menu.

process_schedule_choice(4) :-
    write('Enter first CRN: '),
    read(CRN1),
    write('Enter second CRN: '),
    read(CRN2),
    writeln(''),
    (time_conflict(CRN1, CRN2) ->
        format('CRN ~w and ~w have TIME CONFLICTS~n', [CRN1, CRN2]) ;
        format('CRN ~w and ~w are COMPATIBLE~n', [CRN1, CRN2])),
    schedule_menu.

process_schedule_choice(5) :-
    findall(CRN, is_online_section(CRN), OnlineCRNs),
    list_length(OnlineCRNs, Count),
    writeln(''),
    format('Found ~w online sections: ~w~n', [Count, OnlineCRNs]),
    schedule_menu.

process_schedule_choice(6) :-
    findall(CRN, is_hybrid_section(CRN), HybridCRNs),
    list_length(HybridCRNs, Count),
    writeln(''),
    format('Found ~w hybrid sections: ~w~n', [Count, HybridCRNs]),
    schedule_menu.

process_schedule_choice(7) :-
    write('Enter faculty code: '),
    read(Faculty),
    write('Enter course number: '),
    read(Number),
    total_course_capacity(Faculty, Number, Capacity),
    writeln(''),
    format('Total capacity for ~w ~w: ~w students~n', [Faculty, Number, Capacity]),
    schedule_menu.

process_schedule_choice(8) :- 
    !.  % Cut to return to main menu
process_schedule_choice(_) :-
    writeln('Invalid choice.'),
    schedule_menu.