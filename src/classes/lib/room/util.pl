% ============================================================================
% ROOM UTILITIES
% ============================================================================

% Get room building
room_building(RoomAtom, Building) :-
    room(RoomAtom, Building, _, _, _).

% Get room number
room_number(RoomAtom, Number) :-
    room(RoomAtom, _, Number, _, _).

% Get room campus
room_campus(RoomAtom, Campus) :-
    room(RoomAtom, _, _, Campus, _).

% Get room floor
room_floor(RoomAtom, Floor) :-
    room(RoomAtom, _, _, _, Floor).

% Format room for display (e.g., "ABD 204" from abd_204)
room_display(online, 'Online') :- !.
room_display(RoomAtom, Display) :-
    room(RoomAtom, Building, Number, _, _),
    atom_concat(Building, ' ', Temp),
    atom_concat(Temp, Number, Display).

% Check if a room is online
is_online_room(online).

% Check if a room is physical
is_physical_room(RoomAtom) :-
    room(RoomAtom, _, _, _, _),
    RoomAtom \= online.

% Get all rooms in a building
rooms_in_building(Building, Rooms) :-
    findall(RoomAtom, room(RoomAtom, Building, _, _, _), Rooms).

% Get all rooms on a specific floor
rooms_on_floor(Floor, Rooms) :-
    findall(RoomAtom, room(RoomAtom, _, _, _, Floor), Rooms).

% Get all rooms on a specific campus
rooms_on_campus(Campus, Rooms) :-
    findall(RoomAtom, room(RoomAtom, _, _, Campus, _), Rooms).

% Get all rooms in a building on a specific floor
rooms_in_building_floor(Building, Floor, Rooms) :-
    findall(RoomAtom, room(RoomAtom, Building, _, _, Floor), Rooms).

% Check if a room is available (not online and has valid attributes)
is_available_room(RoomAtom) :-
    room(RoomAtom, Building, Number, Campus, Floor),
    Building \= none,
    Number \= none,
    Campus \= none,
    Floor \= none.
