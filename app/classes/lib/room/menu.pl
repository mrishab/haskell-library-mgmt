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
    writeln('  1. Find rooms on a specific floor'),
    writeln('  2. Find rooms in a building'),
    writeln('  3. Find sections in a room'),
    writeln('  4. Back to main menu'),
    writeln(''),
    write('Enter your choice: '),
    read(Choice),
    process_room_choice(Choice).

process_room_choice(1) :-
    write('Enter floor number: '),
    read(Floor),
    rooms_on_floor(Floor, Rooms),
    writeln(''),
    format('Rooms on floor ~w:~n', [Floor]),
    print_list(Rooms),
    room_menu.

process_room_choice(2) :-
    write('Enter building code (e.g., ABD, ABA, CEPA): '),
    read(Building),
    rooms_in_building(Building, Rooms),
    writeln(''),
    format('Rooms in ~w:~n', [Building]),
    print_list(Rooms),
    room_menu.

process_room_choice(3) :-
    write('Enter building code: '),
    read(Building),
    write('Enter room number: '),
    read(RoomNum),
    sections_in_room(Building, RoomNum, Sections),
    list_length(Sections, Count),
    writeln(''),
    format('~w ~w hosts ~w class sessions~n', [Building, RoomNum, Count]),
    room_menu.

process_room_choice(4) :- 
    !.  % Cut to return to main menu
process_room_choice(_) :-
    writeln('Invalid choice.'),
    room_menu.