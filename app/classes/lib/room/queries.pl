% ============================================================================
% ROOM AND FACILITY QUERIES
% ============================================================================

% Get all rooms on a specific floor
rooms_on_floor(Floor, Rooms) :-
    findall([Building, RoomNum, Campus],
            room(Building, RoomNum, Campus, Floor),
            Rooms).

% Get all rooms in a building
rooms_in_building(Building, Rooms) :-
    findall([RoomNum, Campus, Floor],
            room(Building, RoomNum, Campus, Floor),
            Rooms).

% Get all sections scheduled in a room
sections_in_room(Building, RoomNum, Sections) :-
    findall([CRN, CourseAtom, Day, StartTime, EndTime, Date],
            (schedule(CRN, Day, StartTime, EndTime, Building, RoomNum, Date, _),
             class_section(CRN, CourseAtom, _, _, _, _, _, _, _)),
            Sections).

% Check if room is available at a specific time
room_available(Building, RoomNum, Day, date(Year,Month,DayNum), 
               time(StartH,StartM), time(EndH,EndM)) :-
    room(Building, RoomNum, _, _),
    \+ (schedule(_, Day, SchedStart, SchedEnd, Building, RoomNum, 
                 date(Year,Month,DayNum), _),
        time_overlap(time(StartH,StartM), time(EndH,EndM), SchedStart, SchedEnd)).
