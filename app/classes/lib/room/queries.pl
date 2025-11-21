% ============================================================================
% ROOM AND FACILITY QUERIES
% ============================================================================
% Note: rooms_on_floor/2, rooms_in_building/2, and sections_in_room/3 
% are defined in room/util.pl and schedule/util.pl

% Check if room is available at a specific time
room_available(Building, RoomNum, Day, date(Year,Month,DayNum), 
               time(StartH,StartM), time(EndH,EndM)) :-
    room(Building, RoomNum, _, _),
    \+ (schedule(_, Day, SchedStart, SchedEnd, Building, RoomNum, 
                 date(Year,Month,DayNum), _),
        time_overlap(time(StartH,StartM), time(EndH,EndM), SchedStart, SchedEnd)).
