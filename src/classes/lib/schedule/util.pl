% ============================================================================
% SCHEDULE UTILITIES
% ============================================================================

% Get schedule details with expanded information
schedule_details(CRN, Day, TimeDisplay, RoomDisplay, Date) :-
    schedule(CRN, Day, TimeAtom, RoomAtom, Date),
    time_display(TimeAtom, TimeDisplay),
    room_display(RoomAtom, RoomDisplay).

% Check if a schedule is online
is_online_schedule(CRN) :-
    schedule(CRN, _, _, online, _).

% Get all schedules for a CRN
crn_schedules(CRN, Schedules) :-
    findall((Day, TimeAtom, RoomAtom, Date), 
            schedule(CRN, Day, TimeAtom, RoomAtom, Date), 
            Schedules).

% Get all schedules on a specific day
schedules_on_day(Day, Schedules) :-
    findall((CRN, TimeAtom, RoomAtom, Date),
            schedule(CRN, Day, TimeAtom, RoomAtom, Date),
            Schedules).

% Get all schedules in a specific room
schedules_in_room(RoomAtom, Schedules) :-
    findall((CRN, Day, TimeAtom, Date),
            schedule(CRN, Day, TimeAtom, RoomAtom, Date),
            Schedules).

% Get all schedules using a specific time slot
schedules_at_time(TimeAtom, Schedules) :-
    findall((CRN, Day, RoomAtom, Date),
            schedule(CRN, Day, TimeAtom, RoomAtom, Date),
            Schedules).

% Check if two CRNs have overlapping schedules
schedules_conflict(CRN1, CRN2) :-
    schedule(CRN1, Day, TimeAtom1, _, _),
    schedule(CRN2, Day, TimeAtom2, _, _),
    time_slots_overlap(TimeAtom1, TimeAtom2).

% Get all days a CRN meets
crn_meeting_days(CRN, Days) :-
    findall(Day, schedule(CRN, Day, _, _, _), DayList),
    list_to_set(DayList, Days).

% Get schedule count for a CRN
crn_schedule_count(CRN, Count) :-
    findall(1, schedule(CRN, _, _, _, _), Schedules),
    length(Schedules, Count).

% Check if schedule is on a specific date
has_schedule_on_date(CRN, Date) :-
    schedule(CRN, _, _, _, Date).

% Get all schedules between two dates
schedules_in_date_range(CRN, StartDate, EndDate, Schedules) :-
    findall((Day, TimeAtom, RoomAtom, Date),
            (schedule(CRN, Day, TimeAtom, RoomAtom, Date),
             date_between(StartDate, Date, EndDate)),
            Schedules).

% Helper: check if Date is between StartDate and EndDate
date_between(date(Y1,M1,D1), date(Y,M,D), date(Y2,M2,D2)) :-
    date_to_days(Y1,M1,D1, Days1),
    date_to_days(Y,M,D, Days),
    date_to_days(Y2,M2,D2, Days2),
    Days >= Days1,
    Days =< Days2.

% Helper: convert date to days (simple approximation)
date_to_days(Y,M,D, Days) :-
    Days is Y * 365 + M * 30 + D.

% Get sections meeting in a specific room (by building and room number)
sections_in_room(Building, RoomNumber, Sections) :-
    findall(CRN,
            (room(RoomAtom, Building, RoomNumber, _, _),
             schedule(CRN, _, _, RoomAtom, _)),
            SectionList),
    list_to_set(SectionList, Sections).

% Check if two CRNs have time conflicts (same day and overlapping times)
time_conflict(CRN1, CRN2) :-
    CRN1 \= CRN2,
    schedule(CRN1, Day, TimeAtom1, _, _),
    schedule(CRN2, Day, TimeAtom2, _,_),
    time_slots_overlap(TimeAtom1, TimeAtom2).
