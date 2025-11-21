% ============================================================================
% ROOM MENU
% ============================================================================

:- consult('../helper.pl').
:- consult('util.pl').
:- consult('queries.pl').

room_menu :-
    writeln(''),
    writeln('=== ROOM AND FACILITY QUERIES ==='),
    writeln(''),
    writeln('  1. Show rooms on floor 3'),
    writeln('  2. Show rooms in building ABD'),
    writeln('  3. Show sections in ABD 202'),
    writeln('  4. Back to main menu'),
    writeln(''),
    write('Enter your choice: '),
    read(Choice),
    process_room_choice(Choice).

process_room_choice(1) :-
    !,
    rooms_on_floor(3, Rooms),
    writeln(''),
    writeln('Rooms on floor 3:'),
    print_list(Rooms),
    writeln(''),
    room_menu.

process_room_choice(2) :-
    !,
    rooms_in_building('ABD', Rooms),
    writeln(''),
    writeln('Rooms in ABD:'),
    print_list(Rooms),
    writeln(''),
    room_menu.

process_room_choice(3) :-
    !,
    sections_in_room('ABD', '202', Sections),
    list_length(Sections, Count),
    writeln(''),
    format('ABD 202 hosts ~w class sessions~n', [Count]),
    writeln(''),
    room_menu.

process_room_choice(4) :- 
    !.  % Cut to return to main menu
process_room_choice(_) :-
    writeln('Invalid choice.'),
    room_menu.